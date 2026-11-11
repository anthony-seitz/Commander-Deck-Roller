# Commander Deck Roller

A free, static website that generates random Magic: The Gathering Commander (EDH) decks by bracket, Game Changers, budget, and color identity, or builds a deck from the visitor's own card collection. Every deck comes with a primer that explains its goal and win conditions.

It's plain HTML/CSS/JS with no build step. Card data comes live from the [Scryfall API](https://scryfall.com/docs/api) in the visitor's browser, so there's no server to run or pay for.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The deck roller (all app code lives here) |
| `guide.html` | Bracket guide & FAQ (useful content for visitors, search engines, and AdSense review) |
| `privacy.html` | Privacy policy (required for AdSense) |
| `pages.css` | Styles for the guide and privacy pages |
| `ads.txt` | Authorizes Google to sell ads on your domain |
| `serve.ps1` | Local preview server (not needed online) |
| `test-collection-5000.txt` | 5,250-card sample list for testing "My collection" |

## Preview locally

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File serve.ps1
```

Then open http://localhost:8765.

## Launch checklist

### 1. Put it online (free)

**GitHub Pages**
1. Create a new public repository on GitHub (for example `commander-deck-roller`).
2. Push this folder to it:
   ```bash
   git remote add origin https://github.com/YOUR-USERNAME/commander-deck-roller.git
   git push -u origin main
   ```
3. In the repository, go to **Settings → Pages**, set **Source** to "Deploy from a branch", choose `main` and `/ (root)`, and save.
4. The site goes live at `https://YOUR-USERNAME.github.io/commander-deck-roller/` within a minute or two.

**Or Cloudflare Pages:** in the Cloudflare dashboard go to **Workers & Pages → Create → Pages → Connect to Git**, pick the repository, leave the build command empty, and set the output directory to `/`.

Every `git push` after that updates the live site automatically.

### 2. Get a custom domain (~$10–15/year)

Buy one (Cloudflare Registrar and Porkbun are cheap and simple), then add it under **Settings → Pages → Custom domain** on GitHub, or **Custom domains** on Cloudflare Pages. AdSense works much better on your own domain. Note that `ads.txt` must be at the root of the domain, which a `github.io/project` address can't do.

### 3. Fill in the placeholders

- `privacy.html`: replace `[CONTACT EMAIL]` with an email address for the site.
- `index.html`: the `SITE` settings block at the top of the `<script>` controls the money features. Everything stays off while a value is empty:
  - `tcgplayerAffiliatePrefix`: your TCGplayer affiliate tracking link (step 4)
  - `adsensePublisher` and `adSlots`: your AdSense IDs (step 5)
  - `cloudflareAnalyticsToken`: optional, privacy-friendly visit counts (no cookie banner needed)

### 4. Affiliate links (TCGplayer)

1. Apply to the TCGplayer affiliate program (it runs through Impact).
2. Once approved, create a tracking link in Impact. It looks like `https://partner.tcgplayer.com/c/1234567/1830156/21018`.
3. Set `tcgplayerAffiliatePrefix` to that link followed by `?u=`, for example `"https://partner.tcgplayer.com/c/1234567/1830156/21018?u="`.

The "Buy this deck on TCGplayer" button already opens TCGplayer's Mass Entry with the full list; with the prefix set, purchases are credited to you.

### 5. Google AdSense

1. Launch on your custom domain first, and give it a bit of real traffic.
2. Apply at https://adsense.google.com and add your site.
3. In AdSense, open **Privacy & messaging** and turn on the **European regulations** (GDPR) consent message. That's Google's own certified consent banner, so you don't need to add one yourself.
4. Create two **display ad units** (one for the sidebar, one below the results) and copy their slot IDs.
5. In `index.html`, set `adsensePublisher` (`"ca-pub-..."`) and the two `adSlots`.
6. In `ads.txt`, replace `pub-0000000000000000` with your publisher ID.
7. Push. Ads show up after AdSense finishes reviewing the site.

If AdSense turns the site down, add more content pages (deck guides, budget tips, articles about the brackets) and apply again, or try Ezoic or Media.net.

## Rules to follow

- **Wizards of the Coast Fan Content Policy:** the site must stay free to use. Ads, sponsorships, and affiliate links are fine. Keep the disclaimer in the footer and don't use official logos.
- **Scryfall API guidelines:** don't paywall Scryfall data, don't crop or cover card images, and keep artist credit on art crops (the commander banner already shows "Art by …"). Read https://scryfall.com/docs/api before launch since the terms can change.
