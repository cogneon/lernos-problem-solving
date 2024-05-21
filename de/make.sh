#PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-Problem-Solving-Guide-de"
chapters="./src/index.md ./src/1-0-Grundlagen.md ./src/2-0-Lernpfad.md ./src/2-1-was-bringt-dich-hierher.md ./src/2-2-beschreibe-dein-problem-ausfuehrlich.md ./src/2-3-probleme-lassen-sich-einteilen.md ./src/2-4-problemloesung-im-team.md ./src/2-5-korrekturmassnahmen.md ./src/2-6-ursachenanalyse-methodenbaukasten-1.md ./src/2-7-ursachenanalyse-methodenbaukasten-2.md ./src/2-8-finden-und-umsetzen-von-loesungen.md ./src/2-9-woher-erkenne-ich-dass-eine-loesung-erfolgreich-ist.md ./src/2-10-transfer.md ./src/2-11-feiern.md ./src/2-12-retrospektive.md ./src/3-0-Anhang.md"

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.*

REM Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o %filename%.docx %chapters%

REM Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o %filename%.html %chapters%

REM Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernOS --number-sections --toc -V lang=de-de -o %filename%.pdf %chapters%

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] src/images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o %filename%.epub %chapters%
ebook-convert %filename%.epub %filename%.mobi


# Delete Old Versions
echo Deleting old versions ...
rm -rf $filename.*
rm -rf ../docs/de/*
rm -ff ../docs/de-slides/index.html

# Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

# Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml -s --resource-path="./src" -F mermaid-filter -N --toc -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml -s --resource-path="./src" -F mermaid-filter -N --toc -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml -s --resource-path="./src" -F mermaid-filter --template lernos -N --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 $filename.pdf[0] ebook-cover.jpg
mogrify -size 2500x2500 -resize 2500x2500 ebook-cover.jpg
mogrify -crop 1563x2500+102+0 ebook-cover.jpg
pandoc metadata.yaml -s --resource-path="./src" -F mermaid-filter --epub-cover-image=ebook-cover.jpg -N --toc -V lang=de-de -o $filename.epub $chapters
ebook-convert $filename.epub $filename.mobi

# Create Slides (revealjs)
# echo Creating Presentation ...
# pandoc metadata.yaml --from markdown -s --resource-path="./src" -t revealjs -V theme=night -s ./slides/index.md -o ../docs/de-slides/index.html

# Remove Unnecessary Files
rm mermaid-filter.err
rm ebook-cover.jpg
