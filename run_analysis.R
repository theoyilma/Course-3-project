# read and build training data
subject_train <- read.table('subject_train.txt')

activity_train <- read.table('y_train.txt')

data_train <- read.table('X_train.txt')

data_train <- cbind(activity_train, data_train)

data_train <- cbind(subject_train, data_train)


# read and build test data 
subject_test <- read.table('subject_test.txt')

activity_test <- read.table('y_test.txt')

data_test <- read.table('X_test.txt')

data_test <- cbind(activity_test, data_test)

data_test <- cbind(subject_test, data_test)

# load featcher names
features <- read.table('features.txt')

# combine test and training data into one data set
all_data <- rbind(data_test, data_train)

# set column names of the combined data set to the appropriate feature names
names(all_data) <- names(all_data) <- c(c('Subject', 'Activity'), as.character(features[,2]))

# extract mean and standard data for each subject/activity 
#mean_n_std <- all_data[,c(1:8)]
mean_std <- all_data[, c((1:2), grep('mean', colnames(all_data)), grep('std', colnames(all_data)), grep('Mean', colnames(all_data)), grep('Std', colnames(all_data)))]

# replace activity ids with descriptive names
walking_indexes <- mean_std[,2] == 1

mean_std[,2][walking_indexes] <- 'WALKING'

walking_upstairs_indexes <- mean_std[,2] == 2

mean_std[,2][walking_upstairs_indexes] <- 'WALKING_UPSTAIRS'

walking_downstairs_indexes <- mean_std[,2] == 3

mean_std[,2][walking_downstairs_indexes] <- 'WALKING_DOWNSTAIRS'

sitting_indexes <- mean_std[,2] == 4

mean_std[,2][sitting_indexes] <- 'SITTING'

standing_indexes <- mean_std[,2] == 5

mean_std[,2][standing_indexes] <- 'STANDING'

laying_indexes <- mean_std[,2] == 6

mean_std[,2][laying_indexes] <- 'LAYING'


# aggregate data by subject and activity creating average for each data variable.
tidy <- aggregate(mean_std[, c(3:88)], list(mean_std$Subject, mean_std$Activity), mean)

colnames(tidy)[1] <- 'Subject'

colnames(tidy)[2] <- 'Activity'

# write tidy data into a csv file.
write.csv(tidy, 'tidy.csv')

