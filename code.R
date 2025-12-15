library(mice)
library(GGally)

set.seed(123)
# Load the dataset
pre_data = read.csv("df_estados_bank.csv")

# Take a look
summary(pre_data)

# We remove ids
pre_data = pre_data[,4:15]

# We also remove the surnames, as we will not be using them
pre_data = pre_data[,-10]

# Check for NAs
barplot(colMeans(is.na(pre_data)), las=2)

# There are NAs in Age and EstimatedSalary
# We can try mice

clean = mice(pre_data, method = "rf", m = 5)
data = complete(clean)

# They are pretty similar
summary(data)

# We check correlation between variables
data$Gender = as.factor(data$Gender)
levels(data$Gender)
data_num = data[,-c(2, 8)]
data_num$Gender = as.numeric(data$Gender) - 1 # 0 for female and 1 for male

R = cor(data_num)
ggcorr(data_num, label = T)
