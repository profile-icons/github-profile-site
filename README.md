# GitHub Profile Site

Deploy your GitHub user or organization profile as a configurable site with:

- profile avatar
- (optional) tagline
- (optional) themes and styles
- (optional) i18n translations
- (optional) website icon links
- (optional) organization badge links
- (optional) Google analytics
- full support of GitHub README Markdown format

# Instructions

Create the workflow: `.github/workflows/deploy-profile-site.yml`

```yaml
name: deploy-profile-site

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: gh-pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v7

      - name: Build
        id: profile-site
        uses: profile-icons/github-profile-site@main
        with:
          hf-token: ${{ secrets.HF_TOKEN }}  # optional

      - name: Upload
        uses: actions/upload-pages-artifact@v5
        with:
          path: ${{ steps.profile-site.outputs.dist-path }}

  deploy:
    needs: build
    runs-on: ubuntu-latest

    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      - name: Deploy
        id: deployment
        uses: actions/deploy-pages@v5
```
</details>

### Configure

To display your profile `README.md` content, edit `site.config.json`:

- **[required]** GitHub _user_ or _organization_ name: `githubName`
- **[required]** GitHub profile site _URL_: `siteUrl`
- [_optional_] GitHub repo the README data is fetched from (defaults to _profile_ repo): `repoName`
- [_optional_] GitHub repo the profile site is deployed from (defaults to `repoName`): `basePath`
- [_optional_] A brief tagline to complement the profile Avatar (associated with `githubName`): `tagline`
- [_optional_] The tab (user/org) identifier for the profile site (defaults to `githubName`): `tabName`
- [_optional_] The tab title for the profile site (defaults to _"GitHub profile"_): `tabSuffix`
- [_optional_] The site description (not displayed on the deployed site): `description`
- [_optional_] A theme name for the site theme (`github_soft`, for example) - refer below for more info: `theme`
- [_optional_] A (RGB, HEX) color for accent, supporting colors (and `theme` when it is an empty string): `themeColor`
- [_optional_] A style name for the site style (`aurora`, for example) - refer below for more info: `style`
- [_optional_] A list of GitHub organization links to display as badges - refer below for more info: `organizations` 
- [_optional_] The language the profile README Markdown is written in (defaults to _"en"_): `language`
- [_optional_] A list of locales for providing translations from `language` - refer below for more info: `locales`
- [_optional_] A dictionary of website-link mapping for providing icon links - refer below for more info: `links`

```json
{
  "githubName": "",
  "siteUrl": "",
  "repoName": "",
  "basePath": "",
  "tagline": "",
  "tabName": "",
  "tabSuffix": "",
  "description": "",
  "theme": "",
  "themeColor": "",
  "style": "",
  "organizations": [],
  "language": "",
  "locales": [],
  "links": {},
  "gaId":
}
```

### Theme

<details>
<summary>Select from any one of the available themes:</summary>

* `aura`
* `ayu`
* `catppuccin`
* `cobalt2`
* `dracula`
* `everforest`
* `flexoki`
* `github`
* `github_colorblind`
* `github_high_contrast`
* `github_soft`
* `gruvbox`
* `horizon`
* `iceberg`
* `kanagawa`
* `material`
* `monokai`
* `moonlight`
* `night_owl`
* `night_fox`
* `nord`
* `one_dark`
* `oxocarbon`
* `pale_night`
* `paper_color`
* `poimandres`
* `rose_pine`
* `solarized`
* `stars`
* `star_wars`
* `synthwave84`
* `tokyo_night`
* `tomorrow`
* `vesper`
* `vitesse`
* `zen_burn`
</details>

Each theme supports light and dark mode. CSS can be found in `src/themes.json`.

### Style

<details>
<summary>Select from any one of the available styles:</summary>

* `aurora`
* `blueprint`
* `crosshatch`
* `gradient`
* `grain`
* `grid`
* `glow`
* `halftone`
* `mesh`
* `paper`
* `solid`
* `spotlight`
* `stars`
</details>

CSS can be found in `src/styles.json`.

### Organization Badges

Each entry in the **organizations** array is a GitHub organization name, ie: `["org-name-one", "org-name-two", ...]`

### Locales - i18n

Profile translations are generated for **locales** prior to deployment using the [Xenova/m2m100_418M](https://huggingface.co/Xenova/m2m100_418M) model.

Each entry in the **locales** array is a code corresponding to a language being translated, ie: `["sv", "de", ...]`

<details>
<summary>Valid locale code values for translation are listed here (mapped to respective language-key for reference)
</summary>

```json
{
  "Afrikaans": "af",
  "Albanian": "sq",
  "Amharic": "am",
  "Arabic": "ar",
  "Armenian": "hy",
  "Asturian": "ast",
  "Azerbaijani": "az",
  "Bashkir": "ba",
  "Belarusian": "be",
  "Bengali": "bn",
  "Bosnian": "bs",
  "Breton": "br",
  "Bulgarian": "bg",
  "Burmese": "my",
  "Catalan": "ca",
  "Cebuano": "ceb",
  "Chinese": "zh",
  "Czech": "cs",
  "Danish": "da",
  "Dutch": "nl",
  "English": "en",
  "Estonian": "et",
  "Finnish": "fi",
  "French": "fr",
  "Fulah": "ff",
  "Galician": "gl",
  "Ganda": "lg",
  "Georgian": "ka",
  "German": "de",
  "Greek": "el",
  "Gujarati": "gu",
  "Haitian Creole": "ht",
  "Hausa": "ha",
  "Hebrew": "he",
  "Hindi": "hi",
  "Croatian": "hr",
  "Hungarian": "hu",
  "Icelandic": "is",
  "Igbo": "ig",
  "Iloko": "ilo",
  "Indonesian": "id",
  "Irish": "ga",
  "Italian": "it",
  "Japanese": "ja",
  "Javanese": "jv",
  "Kannada": "kn",
  "Kazakh": "kk",
  "Khmer": "km",
  "Korean": "ko",
  "Lao": "lo",
  "Latvian": "lv",
  "Lingala": "ln",
  "Lithuanian": "lt",
  "Luxembourgish": "lb",
  "Macedonian": "mk",
  "Malagasy": "mg",
  "Malay": "ms",
  "Malayalam": "ml",
  "Marathi": "mr",
  "Mongolian": "mn",
  "Nepali": "ne",
  "Northern Sotho": "ns",
  "Norwegian": "no",
  "Occitan": "oc",
  "Odia": "or",
  "Pashto": "ps",
  "Persian": "fa",
  "Polish": "pl",
  "Portuguese": "pt",
  "Punjabi": "pa",
  "Romanian": "ro",
  "Russian": "ru",
  "Scottish Gaelic": "gd",
  "Serbian": "sr",
  "Sindhi": "sd",
  "Sinhala": "si",
  "Slovak": "sk",
  "Slovenian": "sl",
  "Somali": "so",
  "Spanish": "es",
  "Sundanese": "su",
  "Swahili": "sw",
  "Swati": "ss",
  "Swedish": "sv",
  "Tagalog": "tl",
  "Tamil": "ta",
  "Thai": "th",
  "Tswana": "tn",
  "Turkish": "tr",
  "Ukrainian": "uk",
  "Urdu": "ur",
  "Uzbek": "uz",
  "Vietnamese": "vi",
  "Welsh": "cy",
  "Western Frisian": "fy",
  "Wolof": "wo",
  "Xhosa": "xh",
  "Yiddish": "yi",
  "Yoruba": "yo",
  "Zulu": "zu"
}
```

</details>

> Note: if changing browser languages during a session, a cache refresh may be required to render translations.

###### HF_TOKEN

Optionally, add a HuggingFace token as a repository secret named `HF_TOKEN` for authenticated model downloading.

### Icon Links

Each entry in the **links** `{key: value}` object maps a platform/icon ID (`key`) to its destination URL (`value`).

### Example

```json
{
  "githubName": "r055a",
  "siteUrl": "https://r055a.github.io",
  "repoName": "",
  "basePath": "",
  "tagline": "Just a guy who likes ☕",
  "tabName": "Adam Ross",
  "tabSuffix": "GitHub Profile",
  "description": "A GitHub profile site for rendering README content with avatar, tagline, translations, org & icon links.",
  "theme": "github_soft",
  "themeColor": "",
  "style": "aurora",
  "organizations": ["profile-icons", "uni-projects-demos", "uni-git-projects"],
  "language": "en",
  "locales": [
    "en",
    "sv",
    "zh",
    "pt",
    "ja",
    "de",
    "ru",
    "uk",
    "es",
    "fr",
    "fi",
    "tr",
    "ko",
    "pl",
    "vi",
    "nl",
    "hi",
    "it",
    "ar",
    "he",
    "th",
    "cs"
  ],
  "links": {
    "buymeacoffee": "https://buymeacoffee.com/kofi.kiwi",
    "github": "https://r055a.github.io/r055a/",
    "huggingface": "https://huggingface.co/r055a",
    "kaggle": "https://www.kaggle.com/r055a20",
    "ko-fi": "https://ko-fi.com/kawhe_kiwi",
    "x": "https://x.com/r0S5a",
    "youtube": "https://youtube.com/@whatevername"
  },
  "gaId": ""
}
```

# Install

```Bash
npm install
```

## i18n

```Bash
npm run i18n
```

# Run

```Bash
npm run dev
```

# Build

```Bash
npm run build
npm run preview
```

# Contribute

Before making a Pull Request, ensure it addresses an Issue, and verify:

```Bash
npm run verify:fix
```
