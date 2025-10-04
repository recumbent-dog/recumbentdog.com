#!/bin/bash

echo ">> building: about.html"

function md2html(){
  # local file folder mdfile target date
  cd ../images/about
  local image
  image="$(file --mime-type * | grep 'image/')"
  image="/images/about/${image%:*}"
  cd ../../about
  for mdfile in *.md; do
    file=${mdfile%.*}
    date=$(date -r ${file}.md +%y%m%d)
    folder=$(basename $(pwd))
    echo "building $folder /// $file"

    target=index.html
    cat $1 > ${target}
    cat >> ${target} <<EOF

<div class="twoColumns">
  <div class="txtbox">

EOF
    cmark --unsafe ${file}.md >> ${target}
    cat >> ${target} <<EOF

</div>
  <div class="imgbox">
    <img src="$image">
  </div>

EOF
    cat $2 >> ${target}
    sed -i '' -e 's#DATE#'$date'#g' ${target}
    echo "$folder \\\ $file built"
  done
}
md2html "../head.htm_" "../foot.htm_"