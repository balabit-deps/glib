#!/bin/sh
set -e
touch README INSTALL
mkdir -p m4
libtoolize --force --copy --install --verbose
aclocal${AM_VERSION} -I m4
gtkdocize --copy || true
# wipe out doc generation as it does not work on all platforms
sed -i -e 's/^install-data-local:/no-\0/' gtk-doc.make || true

autoheader
automake${AM_VERSION} --add-missing --copy  --force-missing --foreign
autoconf --force  -i

find -name libtool -o -name ltmain.sh | xargs sed -i -e "s,'file format pe-i386.*\?','file format \(pei\*-i386\(\.\*architecture: i386\)\?|pe-arm-wince|pe-x86-64\)'," -e 's,cmd \/\/c,,'
