#!/bin/bash -l
#SBATCH -A ACD114195
#SBATCH -J E1700_000        # Job name
#SBATCH -p ct224
#SBATCH -n 200           # Number of MPI tasks (i.e. processes)
#SBATCH -c 1
#SBATCH --ntasks-per-node=56  
#SBATCH -t 4-00:00:00        # Wall time limit (days-hrs:min:sec)
#SBATCH -o %j.log       # Path to the standard output and error files relative to the working directory
#SBATCH -e %j.err       # Path to the standard output and error files relative to the working directory

#cd "${0%/*}" || exit                                # Run from this directory

cd /work/u5857756/CASE/ntut_r200_E_1700_alpha000

. ${WM_PROJECT_DIR:?}/bin/tools/RunFunctions        # Tutorial run functions


rm -f log.*
 
##Run snappyHexMesh
#runParallel snappyHexMesh -overwrite

##Run reconstructParMesh
#runApplication reconstructParMesh -constant -latestTime -mergeTol 1e-6

##Run decompose

##Run initial data 
runParallel potentialFoam -noFunctionObjects -writep -writePhi

##Run openFoam
runParallel $(getApplication)
runApplication reconstructPar -latestTime
runApplication postProcess -func sampleDict -latestTime

exit


