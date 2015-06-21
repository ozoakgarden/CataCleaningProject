# Codebook
This markup file describes the process from the original data to the output file requested in step 5 of the assignment.

The assignemnt provided us with a zip file containing several data files and the respective descriptions. 
All data was sourced from an experiment about "Human Activity Recognition using smartphones", in which 30 volunteers between 19-48 years performed a series of 6 activities while wearing a smartphone. The smartphone measured a series of different metrics (called features). 
The data is divided into a test part and a traing part

Not all of the provided files were used for this project only the follwoing:
- features.txt: listing the 561 different metrics measured in the experiment (2 variables, ID and feature, 561 observations)
- activity_labels.txt: listing the 6 different activities the volunteers had to perform (2 variables, ID and activity, 6 observations)
- subject_test.txt: identifying the subject who performed the activities for test purposes (1 variable, 2947 observations)
- subject_train.txt: identifying the subject who performed the activities for training purposes (1 variable, 7352 observations)
- X_test.txt: the test set (561 variables, 2947 observations)
- y_test.txt: test labels (1 variable, 2947 observations)
- X_train.txt: the training set (561 variables, 7352 observations)
- y_train.txt: training labels (1 variable, 7532 observations)
- 
After reading in these datafiles into separate data frames I needed to perform certain changes in variable names, to make the data easier to read, but also prepare the data for merging. Variables showing the identical data should also have identical variable names. 

The features.txt file contained feature descriptions containing characters which could not be used as variable names in R. Therefore I created a file featclean.txt which provided me with usable descriptions.

To make sure that in a combined dataset it will still be possible to differ between test and training data, I established a new variable "sample" carrying either "test" or "train".

Together with the sample variable i combined the data sets "subject_test", "X_test" and "y_test" to one combined test data set (test_data). Identical steps were taken to create a combined data set for training data (train_data).

To identify the features reporting means or standard deviations of specific metrics I used the "grep" function to create a vector with all feature_IDs containing "mean" or "std" in the feature description. This vector was then used to subset the test and training data to only keep the variables we were interested in.

Finally these 2 new data sets ("test_data_new" and "train_data_new") were merged to a "complete_data_new" set of data. From this I used the aggregate function to create the final output data frame "step5_data" which contains the averages of all metrics of interest by subject and activity.

The final data frame (exported as "step5_data.txt") contains 180 observations (30 volunteers / subjects times 6 activities) across 79 different measures (including subject_ID and activity_ID this data set contains 81 variables).
