#!/bin/bash
# To exclude some directories that annoies and confusing ctags

if [ -z "$1" ]; then
	echo "Usage: ./thisfile <kernel-path>"
	exit 1
fi

echo "entering $1"
cd $1

cmd="ctags -R"
for dir in `ls arch`; do
	if [ "$dir" == "x86" ]; then
		continue
	fi

	cmd=`echo $cmd --exclude=arch/${dir}/*`
done

# TODO: exclude tools/arch and exclude tools/perf/arch

cmd=`echo $cmd --exclude=tools/* --exclude=drivers/*`

eval $cmd -V
