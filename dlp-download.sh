#! /bin/bash

################################################################################
# Script to get a PDF of the https://www.deeplearningbook.org/.
# Requires brave browser, but similar command available for chromium-browser.
# Last tested: 09th April 2025.
################################################################################

WEBSITE=https://www.deeplearningbook.org/
TMP_DIR=$(mktemp -d)
OUT_FILE=$(pwd)/deeplearningbook.pdf

n=0
for file in $(curl -# $WEBSITE | grep -oE 'contents/.*html'); do
    brave-browser --headless --disable-gpu --print-to-pdf=$TMP_DIR/$n.pdf $WEBSITE/$file
    n=$(( n + 1 ))
done

cd $TMP_DIR
pdfunite $(ls *.pdf | sort -n) $OUT_FILE
cd -
rm -rf $TMP_DIR
