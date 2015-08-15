<h1>Getting and Cleaning Data: Course Project</h1>
<h2>Introduction</h2>

This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization. What follows first are my notes on the original data.

<h2>About the raw data</h2>

The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file.

The same holds for the training set.

<h2>About the script and the tidy dataset</h2>

I created a script called run_analysis.R which will merge the test and training sets together. Prerequisites for this script:

<ol>
<li>the UCI HAR Dataset must be extracted and..</li>
<li>the UCI HAR Dataset must be availble in a directory called "data/UCI HAR Dataset"</li>
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

<h2>About the Code Book</h2>

The CodeBook.md file explains the transformations performed and the resulting data and variables.
