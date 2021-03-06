#!/bin/bash

# incorporated resources
# http://texblog.org/tag/pgftikz/#preview
# http://how-to.wikia.com/wiki/How_to_read_command_line_arguments_in_a_bash_script


base=~/.drawtikztex
tmp=$base/tmp


input=$1
output=$2
startpoint=$(pwd)



mkdir $tmp
cp $base/drawtikz.tex $tmp/
cp $input $tmp/input.tex

cd $tmp/
pdflatex drawtikz.tex

cd $startpoint
mv $tmp/drawtikz.pdf $output

rm -r $tmp/

echo ''
echo ''
echo 'TikZ picture successfully drawn:'
echo $output

#
if [ "$3" == 'png' ]
then
  pnt=`expr index "$output" .`
  p=$(bc -l <<< $pnt-1)
  outputbase=${output:0:p}
  pdftops -eps $output
  convert -density 300 $outputbase.eps $outputbase.png
  rm $outputbase.eps
fi
