@echo off
echo Starting lernOS Guide Generation ...

REM Variables
set filename="lernOS-Problem-Solving-Guide-de"
set chapters=./src/index.md ./src/1-0-Grundlagen.md ./src/2-00-Lernpfad.md ./src/2-01-was-bringt-dich-hierher.md ./src/2-02-beschreibe-dein-problem-ausfuehrlich.md ./src/2-03-probleme-lassen-sich-einteilen.md ./src/2-04-problemloesung-im-team.md ./src/2-05-korrekturmassnahmen.md ./src/2-06-ursachenanalyse-methodenbaukasten-1.md ./src/2-07-ursachenanalyse-methodenbaukasten-2.md ./src/2-08-finden-und-umsetzen-von-loesungen.md ./src/2-09-woher-erkenne-ich-dass-eine-loesung-erfolgreich-ist.md ./src/2-10-transfer.md ./src/2-11-feiern.md ./src/2-12-retrospektive.md ./src/3-0-Anhang.md

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.*

REM Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
REM pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o %filename%.docx %chapters%
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections -V lang=de-de -o %filename%.docx %chapters%

REM Create HTML Version (html)
echo Creating HTML version ...
REM pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o %filename%.html %chapters%
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections -V lang=de-de -o %filename%.html %chapters%

REM Create PDF Version (pdf)
echo Creating PDF version ...
REM pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernOS --number-sections --toc -V lang=de-de -o %filename%.pdf %chapters%
pandoc metadata.yaml --from markdown -s --resource-path="./src" --template lernOS --number-sections --toc -V lang=de-de -o %filename%.pdf %chapters%

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
REM magick -density 300 %filename%.pdf[0] src/images/ebook-cover.jpg
REM magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
REM magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
REM pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o %filename%.epub %chapters%
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections --toc -V lang=de-de -o %filename%.epub %chapters%
REM ebook-convert %filename%.epub %filename%.mobi
