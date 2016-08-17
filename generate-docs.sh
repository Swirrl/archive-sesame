#!/bin/bash
#
# Quick and dirty shell script to generate javadocs for historical
# sesame builds for a crude archive site.
#
# SET SESAME_REPO environment variable to the directory containing the
# sesame git repository and run.
#
# It will output apidocs into this scripts pw, though you can also
# edit the OUTPUT_PATH env var below.

cd `dirname $0`
OUTPUT_PATH=`pwd`
SESAME_REPO=../sesame

pushd $SESAME_REPO
for VERSION in $(git tag | grep sesame); do
    git checkout $VERSION -f
    mkdir $OUTPUT_PATH/$VERSION
    mvn -DreportOutputDirectory=$OUTPUT_PATH/$VERSION javadoc:aggregate
    mv $OUTPUT_PATH/$VERSION/apidocs/* $OUTPUT_PATH/$VERSION
    rmdir $OUTPUT_PATH/$VERSION/apidocs
done

popd
