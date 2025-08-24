#!/bin/bash

# This script can be copied into your base directory for use with
# automated testing using assignment-autotest.
# Author: Swaroop B

set -e

# Set working directory to the script location
cd "$(dirname "$0")"
test_dir="$(pwd)"

echo "starting test with SKIP_BUILD=\"${SKIP_BUILD}\" and DO_VALIDATE=\"${DO_VALIDATE}\"" | tee -a test.sh.log
echo "Running test with user $(whoami)" | tee -a test.sh.log

set +e

# Run unit tests and log output
./unit-test.sh | tee -a test.sh.log
unit_test_rc=$?
if [ $unit_test_rc -ne 0 ]; then
    echo "Unit test failed" | tee -a test.sh.log
fi

# Run assignment test if assignment.txt exists
if [ -f conf/assignment.txt ]; then
    assignment=$(cat conf/assignment.txt)
    if [ -f ./assignment-autotest/test/${assignment}/assignment-test.sh ]; then
        echo "Executing assignment test script" | tee -a test.sh.log
        ./assignment-autotest/test/${assignment}/assignment-test.sh "$test_dir" | tee -a test.sh.log
    fi
fi

echo "Test script complete, exiting." | tee -a test.sh.log
exit 0
