#!/bin/bash
# search for the earliest TAG that contains a file with certain version (blob)

if [ $# -ne 2 ] ; then
	if [ $# -ne 3 ] ; then
		echo "NOTE: ./this-file <filename> <blobhash>"
		exit 1
	fi
fi

for tag in `cat gittags` ; do
	hash=`git ls-tree -r $tag $1`
	if [ -z "$hash" ] ; then
		echo "cannot find $1 in $tag"
		continue
	fi

	echo $hash	\
		| while read mode type h name ; do
				if [[ $h == "$2"* ]]; then
					echo $tag $1
					# bash seems to fork another process here
					# so simple global variables don't work here
					if [ "$3" != "--all" ]; then
						exit 1
					fi
				fi
			done
	if [ $? -eq 1 ]; then
		exit 0
	fi
done

# FIXME: with --all, if the file not found, nothing will display
if [ "$3" != "--all" ]; then
	echo "cannot find $1 with hash $2"
	exit 1
fi
