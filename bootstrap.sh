#! /bin/bash
#
# $Id: bootstrap.sh 542 2007-11-30 07:49:51Z martinr $
#
# Authors:
#     Martin Thorsen Ranang <mtr@linpro.no>
#     Aslak Johannessen <aslakjo@ifi.uio.no>
#
# WARNING: This file is a copy of 'common_build_files/bootstrap.sh'.
#     The next time 'common_build_files/distribute.sh' is run with the
#     appropriate arguments, all changes to this file will disappear.
#     Please edit the original.
#

# Get version and check if --install can be used.
autoreconf=$(which autoreconf)
value=$(autoconf --version  | head -n 1 | sed -e "s/.* //")
set -ax
minor=${value#*.}
major=${value%.*}
install=""

if [ $major -lt 2 ]; then
    install="--install"
fi

if [ $major -eq 2 ] && [ $minor -le 59 ]; then
    install="--install"
fi




if [ -n "${install}" ] && [ -n "${autoreconf}" ] ; then
    set -x
    $autoreconf
else
    set -x
    aclocal -I m4
    libtoolize --force --copy
    autoheader
    automake --add-missing --copy
    autoconf
fi
