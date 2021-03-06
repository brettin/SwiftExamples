#!/bin/bash
set -eu

if [[ ${PROJECT:-} == "" ]]
then
  echo "Error: You need to set environment variable PROJECT."
  exit 1
fi

# Canonicalize PWD
cd $( /bin/pwd )

PATH=/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin:$PATH

export LD_LIBRARY_PATH=
LD_LIBRARY_PATH+=/opt/gcc/4.9.2/snos/lib64:
LD_LIBRARY_PATH+=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=out-%Q
export TURBINE_DIRECTIVE='#PBS -l advres=brettin.3672'

export WALLTIME=01:00:00
PROCS=2
swift-t -m cray -n $PROCS run-many.swift --auen_home=$PWD
