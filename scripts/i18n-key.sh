#!/usr/bin/env bash
set -euo pipefail

src_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$src_dir"

test -f i18n/Cargo.toml
test -f i18n/Cargo.lock

{
  printf '%s\n' \
    'i18n-bundle-v2' \
    'rust=1.100.0' \
    'runner=ubuntu-24.04'

  {
    find i18n -type d \( -name target -o -name .git -o -name .cache \) -prune \
      -o -type f -print0
    if [[ -d .cargo ]]; then
      find .cargo -type f -print0
    fi
    for file in rust-toolchain rust-toolchain.toml; do
      if [[ -f "$file" ]]; then
        printf '%s\0' "$file"
      fi
    done
    for file in scripts/i18n-key.sh scripts/build-i18n.sh scripts/run-i18n.sh scripts/setup-onnx.sh; do
      test -f "$file"
      printf '%s\0' "$file"
    done
  } | LC_ALL=C sort -z | xargs -0 sha256sum
} | sha256sum | cut -d' ' -f1
