library(dplyr)
library(superml)

data <- read.csv('data/dirty_dataset_diamond.csv')

# dropping unnecessary column
drops <- c('Unnamed..0', 'X')
data <- data[ , !(names(data) %in% drops)]

# removing missing values
data <- filter(data, x > 0, y > 0, z > 0)
data <- subset(data, cut != 'Unknown')

# exporting clean data
write.csv(data, "data/clean_dataset_diamond.csv", row.names = FALSE)


# Label Encoding data for machine learning
label <- LabelEncoder$new()
data$cut <- label$fit_transform(data$cut)
data$color <- label$fit_transform(data$color)
data$clarity <- label$fit_transform(data$clarity)
summary(data)

# Standarizing data for machine learning
model_data = scale(data)


# Splitting data into train and test splits
sample <- sample.int(n = nrow(model_data), size = floor(.7*nrow(model_data)), replace = F)
train_data <- model_data[sample, ]
test_data  <- model_data[-sample, ]
write.csv(train_data, "data/train_set.csv", row.names = FALSE)
write.csv(test_data, "data/test_set.csv", row.names = FALSE)
