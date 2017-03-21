## Create Directory "tidydata" & Download Dataset
if(!file.exists("./tidydata")){dir.create("./tidydata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./tidydata/Dataset.zip")

##Unzip the Dataset to /tidydata directory
unzip(zipfile="./tidydata/Dataset.zip",exdir="./tidydata")

## Read the training tables:
x_train <- read.table("./tidydata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./tidydata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./tidydata/UCI HAR Dataset/train/subject_train.txt")

## Read the testing tables:
x_test <- read.table("./tidydata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./tidydata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./tidydata/UCI HAR Dataset/test/subject_test.txt")

## Read the feature vector table:
features <- read.table('./tidydata/UCI HAR Dataset/features.txt')

## Read the activity labels:
activityLabels = read.table('./tidydata/UCI HAR Dataset/activity_labels.txt')

## Assigned Column names

colnames(x_train) <- features[,2] 
colnames(y_train) <-"ActivityID"
colnames(subject_train) <- "SubjectID"
      
colnames(x_test) <- features[,2] 
colnames(y_test) <- "ActivityID"
colnames(subject_test) <- "SubjectID"
      
colnames(activityLabels) <- c('ActivityID','ActivityType')

## Merge data into one set "MergedDataSet"

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
MergedDataSet <- rbind(mrg_train, mrg_test)

## Read Column Names
colNames <- colnames(MergedDataSet)

## Create vector for defining ID, mean and standard deviation

mean_std <- (grepl("ActivityID" , colNames) | 
                 grepl("SubjectID" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                 )

## Create subset from set MergedDataSet
Mean_Std_Set <- MergedDataSet[ , mean_std == TRUE]

## Using descriptive activity names to name the activities
ActivityNamesSet <- merge(Mean_Std_Set, activityLabels,
                              by='ActivityID',
                              all.x=TRUE)

## Create Second Tidy Data Set with the average of every variable for each activity and subject

SecondTidySet <- aggregate(. ~SubjectID + ActivityID, ActivityNamesSet, mean)
SecondTidySet <- SecondTidySet[order(SecondTidySet$SubjectID, SecondTidySet$ActivityID),]

## Write second data set in txt file
write.table(SecondTidySet, "SecondTidySet.txt", row.name=FALSE)
