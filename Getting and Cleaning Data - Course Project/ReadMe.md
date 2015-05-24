#Getting and Cleaning Data
##Course Project

###How To
This file describes how the **run_analysis.R** script works.

1. First , you need to download the datasets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract and place the whole folder named *"UCI HAR Dataset"* with the data in your working directory.
  + check with getwd() command your current working directory
  + make sure the folder name is as mentioned above *"UCI HAR Dataset"*
3. Place the *run_analysis.R* script in the same working directory as the folder "UCI HAR Dataset" is with all the datasets.
4. Execute the dir() command and you should get resulted at least the script and the folder
  + **UCI HAR Dataset**
  + **run_analysis.R**
5. Now you can execute every single command in the *run_analysis.R* script or simply mark the whole code (Commands and execute them). The order of the command as it is in the script is important. May you execute the command in a different order you might get wrong results and some errors.
6. The script writes back the results into one file called **Total.txt** within the UCI HAR Dataset folder

###Approach
The script has 5 steps according to the Course requirement.
- Step 1 : loading the test and train data into data frames and join them together into one total data frame.
  + test and train data *--> 10299 obs. of 561 variables*
  + test and train subject data *--> 10299 obs. of 1 variables*
  + test and train label data *--> 10299 obs. of 561 variables*
- Step 2 : loading feature information and extracting mean and standard deviation information into new data frame
  + loading the feature information into a data frame *--> 561 obs. of 2 variables*
  + extracting from the total test and train data only that the variables with the mean or standard deviation (std) information *--> 10299 obs. of 66 variables*
- Step 3 : Formatting activity expressions from numeric into specific text expression
  + loading the activity information in to a data frame --> 6 obs. of 2 variables
  + formatting the Activities into readable text
  + replacing the values 1 to 6 within the label data frame with the readable activity text
- Step 4 : Formatting the variable names with read able names
  + formatting the variable names
  + giving the MeanStdTotal data frame from step 2 the re-formated variable names
  + giving the label data frame a readable variable name
  + giving the subject data frame a readable variable name
- Step 5 :calculating the mean of all measures (3:68) of each subject and activity combination and writing back the data frame result into a file
  + required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features
  + writing back the data frame result into a file called **Total.txt**



###More Info
In case you need more functional information regarding the datasets go to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


© Pasquale Grippo 2015 All Rights reserved.
