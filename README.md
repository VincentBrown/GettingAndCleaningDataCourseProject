GettingAndCleaningDataCourseProject
===================================
The script run_analysis.R reads data from the folders in the UCI Dataset and tidies them.  The steps are:

1. read the features from "features.txt". These are the variable names and will be the column names of the data frames we create
2. read the activity labels from "activity_labels.txt"  We will use these to replace the 1 to 6 values of the values with the labels.
3. read in the test data from the test folder.  Use read.table to read in:
	- "X_text.txt" which are the measurements of the features for each observation. Data frame is Test_data.
	- "y_text.txt" which are the activities for each observation.  Data frame is Test_activities.
	- "subject_test.txt" which are the subjects from 1 to 30 for each observation.  Data frame is Test_subjects.
4. replace the activity number with the labels using mapvalues from the plyr package
5. repeat step 3 and 4 with the train data from the train folder.
6. rename the columns of Test_data and Train_data to the feature names from "features.txt"
7. Append the activities and subjects to the Test_data and Train_data as columns at the beginning of the data frame using cbind.
8. Name these columns "Subject" and "Activity"
9. Scan the features vector for the text "mean()" and "std()" using grep
10.create vector colsToKeep which is "Subject", "Activity", and the columns found in step 9.
11.Subset the columns from colsToKeep for Test_data and Train_data
12.Merge Test_data and Train_data using rbind.
13.use ddply from the plyr package to reshape the data with one row for each combination of subject and activity and the mean for that combination of all the other variables in the following columns.