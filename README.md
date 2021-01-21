This repository contains the following files:

README.md, an overview of the dataset

run_analysis.R, R script cleaning the raw data in UCI HAR Dataset

tidyData.txt, the resulting clean data as the output of run_analysis.R

CodeBook.md, describing the variables of tidyData.txt and the transformation undergone from raw data in UCI HAR Dataset

### Background

The raw data was obtained from Human Activity Recognition (HAR) dataset.  This dataset contains measurements recorded by accelerometer
and gyroscope embedded into Samsung Galaxy S II.  30 volunteers wore the smart phone around their waist and the device captured 3-axial
linear acceleration and angular velocity.  The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers 
was selected for generating the training data and 30% the test data.

### Overview

run_analysis.R first downloads the dataset from UCI's website.  It first combines the training and test datasets.  Then it retrieves mean
and standard deviation measurements.  Finally it replaces IDs with their respective variable names and outputs a summary as a mean of all
6 activities of each subject.  See CodeBook.md for more details.

