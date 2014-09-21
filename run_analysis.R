run_analysis <- function() {
  
  #read the column headers
  
  columnHeaders <- read.table("features.txt")
  activityLabels <- read.table("activity_labels.txt",colClasses = "character")
  
  # read the test data
  
  Test_data <- read.table("./test/X_test.txt")
  Test_activities <- read.table("./test/y_test.txt",colClasses = "character")
  Test_subjects <- read.table("./test/subject_test.txt")
  Test_activities <- mapvalues(Test_activities[,1],activityLabels[,1],activityLabels[,2])
  
  
  # read the train data
  
  Train_data <- read.table("./train/X_train.txt")
  Train_activities <- read.table("./train/y_train.txt",colClasses = "character")
  Train_subjects <- read.table("./train/subject_train.txt")
  Train_activities <- mapvalues(Train_activities[,1],activityLabels[,1],activityLabels[,2])
  
  #rename the columns
  
  names(Test_data) <- columnHeaders[,2]
  names(Train_data) <- columnHeaders[,2]
  
  #append Subject and Activity columns to the Data
  
  Test_data <- cbind(Test_subjects,Test_activities,Test_data)
  Train_data <- cbind(Train_subjects,Train_activities,Train_data)
  
  colnames(Test_data)[1:2]<- c("Subject","Activity")
  colnames(Train_data)[1:2]<- c("Subject","Activity")
  
  #find columns with std() or mean()
  meanCols <- grep("mean()",columnHeaders[,2],value=TRUE,fixed=TRUE)
  stdCols <- grep("std()",columnHeaders[,2],value=TRUE,fixed=TRUE)
  
  colsToKeep <- c("Subject", "Activity",meanCols[],stdCols[])
  
  # keep only desired columns
  Test_data <- subset(Test_data,select=colsToKeep)
  Train_data <- subset(Train_data,select=colsToKeep)
  
  # merge data
  
  Total_data <- rbind(Test_data,Train_data)
  
  new_data <- ddply(Total_data,.(Subject,Activity),numcolwise(mean))
  
  return(new_data)
    
}