#!/bin/bash

HACHIKO_DIRECTORY=""
HACHIKO_TINY_DIRECTORY=""

#######################################################################################################################
# Helpers

function print_usage {
cat << EOF

 This uses the documentation of the Hachiko to generate the
 one necessary for Hachiko tiny.

 Usage: $1 [options]

 OPTIONS:
 -h                 Print this help and exit
 -o <directory>     Hachiko documentation directory
 -t <directory>     Hachiko tiny documentation directory

EOF
}

function clean_hachiko_tiny_directory {
    local TO_CLEAN
    local TO_DELETE
    local TO_DELETE_LIST

    TO_CLEAN=$1
    TO_DELETE_LIST=`ls -a ${TO_CLEAN} | grep -v "^.$" | grep -v "^..$" | grep -v "^.git" | grep -v "to_replace\.keys" | grep -v "README\.md"`
    for TO_DELETE in ${TO_DELETE_LIST}
    do
        rm -rf ${TO_CLEAN}/${TO_DELETE}
    done
}

#######################################################################################################################
# Options parsing

while getopts "ht:c:o:" option
do
    case ${option} in
        h)
            print_usage $0
            exit 0
            ;;
        o)
            HACHIKO_DIRECTORY=${OPTARG}
            ;;
        t)
            HACHIKO_TINY_DIRECTORY=${OPTARG}
            ;;
        ?)
            print_usage $0
            exit 1
            ;;
    esac
done

[ -n "${HACHIKO_DIRECTORY}"  ]      || { echo "ERROR: Give me the Hachiko documentation directory."; print_usage $0; exit 1; }
[ -n "${HACHIKO_TINY_DIRECTORY}"  ] || { echo "ERROR: Give me the Hachiko tiny documentation directory."; print_usage $0; exit 1; }

clean_hachiko_tiny_directory    ${HACHIKO_TINY_DIRECTORY}

cp -r ${HACHIKO_DIRECTORY}/source ${HACHIKO_TINY_DIRECTORY}
