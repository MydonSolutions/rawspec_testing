# Execute testing.
# Prerequisite: xprep.sh
#

HERE=`pwd`
LOG=${HERE}/`basename $0`.log
> $LOG # Make the log nil.
set -e
set -o pipefail

export PATH=$HOME/rawspec:$PATH
export LD_LIBRARY_PATH=$HOME/rawspec

cd $HOME/rawspec_testing/exec
python3 runner.py $@ 2>&1 | tee -a $LOG
if [ $? -eq 0 ]; then
    python3 reviewer.py 2>&1 | tee -a $LOG
fi

echo 2>&1 | tee -a $LOG
echo ======== 2>&1 | tee -a $LOG
echo FINISHED 2>&1 | tee -a $LOG
echo ======== 2>&1 | tee -a $LOG
echo There is a log of this session in $LOG

