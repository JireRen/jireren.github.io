#!/usr/bin/env bash
set -e

SOURCE_DIR="$HOME/working/personal_page"
PUBLISH_DIR="$HOME/working/jireren.github.io"
DOMAIN="jingyao.ren"

cd "$SOURCE_DIR"

bundle exec jekyll clean
bundle exec jekyll build

# Add GitHub Pages static-hosting files directly into generated output
echo "$DOMAIN" > "$SOURCE_DIR/_site/CNAME"
touch "$SOURCE_DIR/_site/.nojekyll"

rsync -av --delete \
  --exclude='.git/' \
  "$SOURCE_DIR/_site/" "$PUBLISH_DIR/"

cd "$PUBLISH_DIR"

git add .
git commit -m "Update website" || echo "No changes to commit"
git push origin main