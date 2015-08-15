# Load the training data into training_data variable from the directory Data which is placed at working directory
training_data = read.csv("data/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training_data[,562] = read.csv("data/UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training_data[,563] = read.csv("data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Load the testing data into testing_data variable from the directory Data which is placed at working directory
testing_data = read.csv("data/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing_data[,562] = read.csv("data/UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing_data[,563] = read.csv("data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Load the labels into activityLabels variable from the directory Data which is placed at working directory
activityLabels = read.csv("data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)


# Read features from directory Data which is placed at working directory
# make the feature names better suited according to R substitutions
# set them into features variable
features = read.csv("data/UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets together
# set them into allData variable
allData = rbind(training_data, testing_data)

# Get only the data on mean and std. dev.
# set them into requiredCols variable
requiredCols <- grep(".*Mean.*|.*Std.*", features[,2])

# Reduce the features table to what we want
features <- features[requiredCols,]

# Add the last two columns (subject and activity)
requiredCols <- c(requiredCols, 562, 563)

# And remove the unwanted columns from allData
allData <- allData[,requiredCols]
# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
        allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
        currentActivity <- currentActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)

tidy = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)

# Remove the subject and activity column
tidy[,90] = NULL
tidy[,89] = NULL

# Write all tidy data as text file into data directory which is placed at working directory
write.table(tidy, "data/tidy.txt", sep="\t", row.name = FALSE)