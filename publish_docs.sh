#!/bin/bash
set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]; then
  echo "Skipping deploy of commit made against $TRAVIS_BRANCH."
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd html
git init
git config user.name "Dan Albert"
git config user.email "dan@gingerhq.net"

git remote add upstream "https://$GH_TOKEN@github.com/DanAlbert/ndk-docs.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "Rebuild docs at ${rev}."
git push -q upstream HEAD:gh-pages
