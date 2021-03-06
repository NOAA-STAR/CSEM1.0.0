#!/bin/csh
#-------------------------------------------------------------------------------#
# DEBUG build settings for IBM AIX xlf2003 compiler
#-------------------------------------------------------------------------------#

setenv FC "xlf2003"
setenv FCFLAGS "-qcheck -qdbg -qextchk -qfloat=nomaf:rndsngl -qflttrap=ov:zero:en -qinitauto -qhalt=W -qlanglvl=2008pure -qmaxmem=-1 -qsuffix=f=f90:cpp=fpp:cpp=F90"
setenv LDFLAGS ""
setenv LIBS ""

setenv NETCDF_HOME ""
setenv HDF5_HOME   ""

echo "========================================="
echo " CSEM compilation environment variables:"
echo "   FC:       ${FC}"
echo "   FCFLAGS: ${FCFLAGS}"
echo "   FL:       ${FL}"
echo "   FLFLAGS: ${FLFLAGS}"
echo "========================================="
echo
