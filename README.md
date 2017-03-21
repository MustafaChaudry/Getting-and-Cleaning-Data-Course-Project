# Getting-and-Cleaning-Data-Course-Project

This is the Getting and Cleaning Data Coursera Course Project. The R script, run_analysis.R, does the following:

Downloads the dataset if it does not already exist in the working directory.
Loads the activity and features information.
Loads both the test and training datasets. It keeps columns that reflect a mean or standard deviation.
Loads the activity and subject data for each dataset, and merges those columns with the dataset.
Merges the two datasets.
Converts the activity and subject columns into factors.
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The final result is shown in the file tidy.txt.
