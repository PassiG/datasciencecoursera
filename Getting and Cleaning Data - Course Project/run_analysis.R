##step 1 load train and test data into dataframes and join them together

##loading Train data
trainDataDf <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")## loading the train data into data frames
trainLabelDf <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")## loading the train label data into data frames
trainSubjectDf <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")## loading the train subject data into data frames

##loading Test data
testDataDf <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")## loading the test data into data frames
testLabelDf <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")## loading the test label data into data frames
testSubjectDf <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")## loading the test subject data into data frames

##labeling Train and test data within the different data franes with the respective origin
##has been commented out due to the fact is not required for further analysis
##testDataDf$DataType <- "test"
##trainDataDf$DataType <- "train"
##testLabelDf$DataType <- "test"
##trainLabelDf$DataType <- "train"
##testSubjectDf$DataType <- "test"
##trainSubjectDf$DataType <- "train"

## joning train and test data into new data frames
totalDataDF <- rbind(trainDataDf,testDataDf) ##step 1 result --> 10299 obs. of 561 variables
totalLabelDF <- rbind(trainLabelDf,testLabelDf)  ##step 1 result --> 10299 obs. of 1 variables
totalSubjectDf <- rbind(trainSubjectDf,testSubjectDf)  ##step 1 result--> 10299 obs. of 1 variables


#step 2 Extracts only the measurements on the mean and standard deviation for each measurement

featuresDf  <- read.table(file = "./UCI HAR Dataset/features.txt") ## loading the feautre information in to a data frame --> 561 obs. of 2 variables
featureIndex.MeanAndStd <- grep("mean\\(\\)|std\\(\\)", featuresDf[,2]) ## indexing the rows with the meann and standard deviation (std) measures
##featuresDf[featureIndex.MeanAndStd,2] ##is showing the names of the mean and std label
MeanStdTotalDf <- totalDataDF[,featureIndex.MeanAndStd] ##step 2 result--> extracting variabels from the total test and train data frame related to featureIndex.MeanAndStd 10299 obs. of 66 variables

##step 3 Uses descriptive activity names to name the activities in the data set
activityLabelDf <- read.table("./UCI HAR Dataset/activity_labels.txt")## loading the activity information in to a data frame --> 6 obs. of 2 variables
activityLabelDf[, 2] <- tolower(gsub("_", " ", activityLabelDf[, 2])) ##formatting the Activities into readable text
for (i in 1:length(activityLabelDf[, 2]))
        {
        activityLabelDf[i, 2] <- paste(toupper(substring(activityLabelDf[i, 2], 1, 1)), substring(activityLabelDf[i, 2], 2), sep = "", collapse = " ")
        }## formatting the Activties into readable text first letter capital
totalLabelDF[, 1] <- activityLabelDf[totalLabelDF[, 1], 2] ## step3 result --> replacing the values 1 to 6 within the label data frame with the readable activity text

##table(totalLabelDF[, 1])


##step 4 Appropriately labels the data set with descriptive variable names.
featuresDf[, 2] <-gsub("\\(\\)", "", featuresDf[, 2])##formatting the variablenames --> replacing "()" with ""
featuresDf[, 2] <-gsub("-", "_", featuresDf[, 2])##formatting the variablenames --> replacing "-" with "_"
featuresDf[, 2] <-gsub("\\(", "_", featuresDf[, 2])##formatting the variablenames --> replacing "(" with "_"
featuresDf[, 2] <-gsub("\\)", "", featuresDf[, 2])##formatting the variablenames --> replacing ")" with ""
featuresDf[, 2] <-gsub(",", "_", featuresDf[, 2])##formatting the variablenames --> replacing "," with "_"
names(MeanStdTotalDf) <- featuresDf[featureIndex.MeanAndStd,2] ##result step 4 --> giving the MeanStdTotal dataframe from step 2 the reformated variablenames
names(totalLabelDF) <- "Activity" ##result step 4 --> giving the label dataframe a readable variablemame
names(totalSubjectDf) <- "Subject"##result step 4 --> giving the subject dataframe a readable variablemame



## step 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

totalDF <- cbind(totalSubjectDf,totalLabelDF,MeanStdTotalDf) ## joninig all data frames together

observation.unique <- unique(totalDF[,1:2])  ## just geeting the unique combination of activities and subjects derifed from the joined data frame
observation.unique <- observation.unique[order(observation.unique$Subject,observation.unique$Activity),] ## just making an order of the combination of activities and subjects
TotalMean <- NULL
for(j in 1:length(observation.unique[,1])) ##looping through all combination of activities and subjects
{

       TotalMean <- rbind(TotalMean,colMeans(totalDF[totalDF$Subject == observation.unique[j,"Subject"] & totalDF$Activity == observation.unique[j,"Activity"],3:68]))
       ## calculating the mean of all measures (3:68) of each subject and activitiy combination

}

Total <- cbind(observation.unique ,TotalMean)## joining the result of the mean togehter witht the subject,activity combination

write.table(Total, file = "./UCI HAR Dataset/Total.txt",row.name=FALSE) ##step 5 result--> writing a file with the results of step 5
