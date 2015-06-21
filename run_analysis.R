# Set my working directory
setwd("C:/Walter/R/datacleaning/assignment/UCI HAR Dataset")

#Reading in the various datafiles
features <- read.table("features.txt")
feat_clean <- read.table("features_clean.txt") # cleaned features.txt to remove parenthesis and replace "-" with "_"
subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/x_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_test <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/x_test.txt")
y_test <- read.table("./test/y_test.txt")
activity_labels <- read.table("activity_labels.txt")

# create a vector which we will use as identifier between training and test data in a combined file 
sample <- c("")

# Renaming variable names to make sure that the same variables in training and test data will have the same name
colnames(activity_labels) = c("activity_ID", "activity")
colnames(y_train) = c("activity_ID")
colnames(y_test) = c("activity_ID")
colnames(subject_test) = c("subject_ID")
colnames(subject_train) = c("subject_ID")
colnames(features) = c("feat_ID", "feature")
colnames(feat_clean) = c("feat_ID", "feature")
# using the actual measurement names as variable names
colnames(x_train) = feat_clean$feature 
colnames(x_test) =  feat_clean$feature


# combining the different datasets to one dataset for training data and a second dataset for test data
train_data <- cbind(sample, subject_train, y_train, x_train)
train_data$sample <- "train" # sets the sample identifier to "train"
test_data <- cbind(sample, subject_test, y_test, x_test)
test_data$sample <- "test"  # sets the sample identifier to "test"

# prepare the features dataframe so that we can identify variables using mean or std
features$text <- as.character(features$feature)

# creating vectors with the numbers of variables including "mean" or "std" in the variable name
featselect1 <- grep("mean", features$text)
featselect2 <- grep("std", features$text)
# Merging vectors and adding 3 to each - this takes into account that in each data set we have three
# initial variables we need to include: sample, subject_id, activity_id
featselect3 <- sort(c(featselect1, featselect2)) +3
# creating the final vector we are using to subset / narrow data set to only mean and std measures
featselect <-c(c(1,2,3), featselect3)

# subsetting each dataset to only include measures around mean and std
train_data_new <- subset(train_data[featselect])
test_data_new <- subset(test_data[featselect])

# merging both training and test dataset to one tidy big file
complete_data_new <- rbind(train_data_new, test_data_new)
# This data set now includes both training and test data of all subjects and activities, across a set of 
# 79 measures (features)

# remove data sets not used anymore
rm(features, subject_test, subject_train, test_data, test_data_new, train_data, train_data_new, x_train, x_test, y_train, y_test, featselect, featselect1, featselect2, featselect3, sample)

# create the same data set only without variable "sample" (necessary to perform aggregate function in next step)
CDN <- complete_data_new
CDN$sample <- NULL # removes variable "sample" from data set

# Step 5 - independent tidy data set with averages of each variable for each activity and each subject
step5_data <- aggregate(. ~ subject_ID + activity_ID, data=CDN, mean, na.action = na.omit)
# write into text file
write.table(step5_data, file="step5_data.txt", row.names=FALSE)

write.table(step5_data, file="step5_data.txt", row.names=FALSE)
