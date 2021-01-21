################################################################################
##  - Overview -
##
## Takes in train, test, activity_labels, and features data from UCI HAR Dataset
## and produces a tidy data called "tidyData.txt".
##
## See README.md for more details
################################################################################

library(dplyr)

## Download dataset

if(!file.exists("./UCI HAR Dataset")) {
        temp <- tempfile()
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, temp)
        unzip(temp); unlink(temp)
}

## Reading all relevant files 

trainSubjects <- read.table("./UCI Har Dataset/train/subject_train.txt", header = FALSE)
trainLabels <- read.table("./UCI Har Dataset/train/y_train.txt", header = FALSE)
trainSets <- read.table("./UCI Har Dataset/train/X_train.txt", header = FALSE) 

testSubjects <- read.table("./UCI Har Dataset/test/subject_test.txt", header = FALSE)
testLabels <- read.table("./UCI Har Dataset/test/y_test.txt", header = FALSE)
testSets <- read.table("./UCI Har Dataset/test/x_test.txt", header = FALSE)

activities <- read.table("./UCI Har Dataset/activity_labels.txt", header = FALSE)
features <- read.table("./UCI Har Dataset/features.txt", header = FALSE)

## Tagging relevant files with proper column names

colnames(trainSubjects) <- "subject"  
colnames(trainLabels) <- "activity"
colnames(trainSets) <- features[,2]

colnames(testSubjects) <- "subject"
colnames(testLabels) <- "activity"
colnames(testSets) <- features[,2]

## Task 1: Merge train and test datasets ##
train <- cbind(trainSubjects, trainLabels, trainSets); rm(trainSubjects, trainLabels, trainSets)
test <- cbind(testSubjects, testLabels, testSets); rm(testSubjects, testLabels, testSets)
dat <- rbind(train, test); rm(train, test) 

## Task 2: Extract mean and standard deviation features of each measurement ##
relevantColumns <- grepl("subject|activity|mean|std", colnames(dat))
dat <- dat[, relevantColumns]

## Task 3: Uses descriptive activity names to name the activities in the data set ##
dat$activity <- factor(dat$activity, levels = activities[, 1], labels = activities[, 2])
        
## Task 4: Appropriately labels the data set with descriptive variable names ##
variables <- colnames(dat)

## Replace "-" and "()" with ""
variables <- gsub("[\\(\\)-]", "", variables)

## Expand abbreviations
variables <- gsub("^t", "timeDomainSignal", variables)
variables <- gsub("^f", "frequencyDomainSignal", variables)
variables <- gsub("Acc", "Accelerometer", variables)
variables <- gsub("Gyro", "Gyroscope", variables)
variables <- gsub("mean", "Mean", variables)
variables <- gsub("std", "StandardDeviation", variables)
variables <- gsub("Mag", "Magnitude", variables)
variables <- gsub("Freq", "Frequency", variables)

## Replace labels with proper variable names
colnames(dat) <- variables

## Task 5: Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject ##

## Group elements by "subject" and "activiy" and summarize using mean
dat2 <- dat %>% group_by(subject, activity) %>% summarize_each(mean)

## Write out new file with tidy data
if (!file.exists("tidyData.txt")) {
        write.table(dat2, "tidyData.txt")
}





