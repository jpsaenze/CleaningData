## run_analysis.R
## This files run the operations based on the README.txt

library(dplyr)
library(tidyr)

#test data
test_set_subject <- read.csv(paste(getwd(), "/UCI HAR Dataset/test/subject_test.txt",sep=""),sep = " ", header = FALSE)
test_set_data <- read.fwf(paste(getwd(), "/UCI HAR Dataset/test/x_test.txt", sep=""), widths = rep(16,561))
test_set_activity <- read.csv(paste(getwd(), "/UCI HAR Dataset/test/y_test.txt", sep=""), sep = " ", header = FALSE)

#train data
train_set_subject <- read.csv(paste(getwd(), "/UCI HAR Dataset/train/subject_train.txt",sep=""),sep = " ", header = FALSE)
train_set_data <- read.fwf(paste(getwd(), "/UCI HAR Dataset/train/x_train.txt", sep=""), widths = rep(16,561))
train_set_activity <- read.csv(paste(getwd(), "/UCI HAR Dataset/train/y_train.txt", sep=""), sep = " ", header = FALSE)

#common data
activity_lables <- read.delim(paste(getwd(), "/UCI HAR Dataset/activity_labels.txt", sep=""), sep= " ", header = FALSE)
features <- read.delim(paste(getwd(), "/UCI HAR Dataset/features.txt", sep=""), sep= " ", header = FALSE)

#combining the data
set_subject <- rbind(test_set_subject,train_set_subject)
set_data <- rbind(test_set_data,train_set_data)
set_set_activity <- rbind(test_set_activity,train_set_activity)
full_set <- cbind(set_subject,set_set_activity,set_data)

#select the columns to keep only mean() and std() containing columns
selected_features_index <- c(1,2,2+ features[grep("mean\\(|std\\(",features$V2) ,1])
full_set_reduce <-full_set[,selected_features_index]
names(full_set_reduce) <- c( "Subject", "Activity", as.vector(features[grep("mean\\(|std\\(",features$V2) ,2]))

#Changing the lable of the activities
full_set_reduce$Activity <- recode(full_set_reduce$Activity, "1" = "WALKING", "2" = "WALKING_UPSTAIRS", 
                                   "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5"= "STANDING", "6"= "LAYING")

## Optional to write the fileintermediate data set to file
## write.csv(full_set_reduce, paste(getwd(),"/full_set_reduce.csv", sep=""))

full_set_reduce <- group_by(full_set_reduce, Subject, Activity)
tidy_data <- summarize_each(full_set_reduce, funs(median))


## Next line uncommented for producing long format 
## tidy_data <- gather(tidy_data,"Measurements", "Mean", 3:68)
write.csv(tidy_data, paste(getwd(),"/tidy_data.csv", sep=""))
rm(list = ls())
