run_analysis.R  does the following.

1. Merges the training and the test sets to create one data set.

        Asssumes that the data is in raw format as downloaded from the web, located
        in the same folder that the run_analysis.R file
        
        As two follwo the instructions:
        The train and test data are individually built, concatenating the different files
        
        - subject_train.txt is the first column of final set column name subject (person ID) 
        - y_train.txt is the next column, test lables, this will be replaced by activity lables
          and the column name will be named activity
        - x_train.txt contains the data set, columns in the final data,  features.txt is to 
          be used as the column names of the 
          
          After the process has been follow for train and test data sets, both tables are join
          in a final table call Data_set_total.csv

2. Extracts only the measurements on the mean and standard deviation for each measurement.

        Uses the column selection to select columns that only contain either mean and \
        standard deviation
        
This was already preformed in point 1, so skip (3 and 4).
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.