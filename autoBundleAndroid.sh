#!/usr/bin/env sh

#
# Copyright 2021 Dipesh Joshi
# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the Software 
# is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


##############################################################################
##
##  Bash script for updating version code android for react-native
##
##############################################################################

cd "`pwd`/android"
file="`pwd`/app/build.gradle"

if [[ `cat $file` == *" versionCode "* ]]; then
  line=`grep -m 1 -n " versionCode " $file`

  lineNum=`grep -m 1 -n " versionCode " $file | cut -f1 -d:`
  code=`grep -m 1 -h " versionCode " $file | tr -dc '0-9'`

  echo "Updating the Existing Version Code $code to $((code + 1))"
  code=$((code + 1))

  sed -i "${lineNum}s/.*/      versionCode ${code}/" $file
fi

echo "Cleaning Older Builds"
./gradlew clean

echo "" ""
echo "Creating App Bundle"
./gradlew bundleRelease

cd ".."
echo "" ""
echo "App Bundle ready at `pwd`/android/app/build/outputs/bundle/release/app-release.aab"

$SHELL