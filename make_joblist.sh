#!/bin/bash

#make joblist for running ParallelStructure

#usage: set the number of independent runs, number of Ks to test, number of pops, burnin, and MCMC iterations below, then execute script. This will output a file called joblist.txt:

#section to set variables:
RUNS=10
KMIN=1
KMAX=9
POPS=8
BURNIN=100000
MCMC=1000000


#section to create file (modification not necessary):
KCOUNT=$(expr $KMAX - $KMIN + 1)
TOTAL=$(expr $RUNS \* $KCOUNT)
POPS_LIST=$(seq -s, 1 1 $POPS)

col1=$(seq 1 1 $TOTAL | sed -e 's/^/T/')
col2=$(yes $POPS_LIST | head -n $TOTAL)
col3=$(seq $KMIN $KMAX | awk '{for(i=0;i<'$RUNS';i++)print}')
col4=$(yes $BURNIN | head -n $TOTAL)
col5=$(yes $MCMC | head -n $TOTAL)
paste -d ' ' <(echo "$col1") <(echo "$col2") <(echo "$col3") <(echo "$col4") <(echo "$col5") > joblist.txt