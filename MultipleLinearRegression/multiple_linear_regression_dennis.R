#Multiple Linear Regression

# Importing the dataset
dataset = read.csv('50_Startups.csv')

#Encoding categorical data
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1,2,3))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling - won't be necessary manually -> automatically done by our function

#Fitting Multiple Linear Regresssion to the Training Set
#regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State)
#simpler way:
regressor = lm(formula = Profit ~ .,
               data = training_set)
#summary(regressor)
#simply using Profit ~ R.D.Spend as our formula would give us equally good prediction based on P values

#Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

#Building the optimal model using Backward Elimination -> we use entire dataset for this
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset)
summary(regressor)

#note - removing the worst independent variable can actually remove some bias for the other IVs; thus, changing their p-values
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = dataset)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = dataset)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor)
# If you look closely you will see adjusted r-squared value goes down, which means by removing Marketing Spend IV we have made our model worse

#Just going to personally retry new model on predictions to compare
regressor = lm(formula = Profit ~ R.D.Spend,
               data = training_set)
summary(regressor)
y_pred = predict(regressor, newdata = test_set)