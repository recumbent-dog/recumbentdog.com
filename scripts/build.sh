echo ">> building site"
zsh ./md2html.sh
cd ..
cd notes
zsh ./cards.sh
cd ../about
zsh ./about.sh
echo ">> site built"