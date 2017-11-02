## This script reads multiple files containing test and training data
## reads all files and combines like data frames
## finally, we tidy the data finding the mean of every column and export


# setwd("E:\\Dropbox\\coursera\\Getting and Cleaning Data\\UCI HAR Dataset")
setwd("~/Dropbox/coursera/Getting and Cleaning Data/UCI HAR Dataset")

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/y_test.txt")

features <- read.table("./features.txt")[,2]
# features1 <- read.table(".\\features.txt")
activities <- read.table("./activity_labels.txt")[,2] # activity names 

# str(features)
# 
# head(X_train)
# head(y_train)
# head(X_test)
# head(y_test)

names(X_test) <- features # set the names of data frame
names(X_train) <- features # set the names of data frame

X_df <- rbind(X_test, X_train) # merge X frames
y_df <- rbind(y_test, subject_test, y_train) # merge y frames

X_df <- X_df[,grepl(".*(.*mean|.*std).*", features)] # filter columns with mean or std in name

activities
rep(activities, X_df)

y_df[,1]
y_df[,2] <- activities[y_df[,1]]
names(y_df) <- c('ActivityId', 'Activity') # set names of activities based on activity value


tidy_df <- colMeans(X_df) # find the mean of every column in dataframe
tidy_df

write.table(tidy_df, "./tidy_df.txt", sep="\t", row.names = FALSE) # export tidy dataframe
