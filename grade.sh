CPATH=".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if ! [[ -f student-submission/ListExamples.java ]]
then
    echo "Error: ListExamples.java Not Found!"
    exit 1
fi

cp -r student-submission/ListExamples.java grading-area
cp -r TestListExamples.java grading-area

cd grading-area
javac -cp $CPATH ListExamples.java TestListExamples.java

if [[ $? == 0 ]]
then
    echo "Compilation Successful"
elif [[ $? == 1 ]]
then
    echo "Compilation Unsuccessful! Check code for syntax errors. (Exit Code: 1)"
    exit 1
else
    echo "Compilation Unsuccessful! (Exit Code: $?)"
    exit $?
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > TestResults.txt

echo `grep "test" TestResults.txt`

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
