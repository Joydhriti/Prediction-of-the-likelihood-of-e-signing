data = read.csv("Financial Data.csv", header = T)

#... data visualization....
newdata = data
newdata$entry_id = NULL
newdata$pay_schedule = NULL

correlation = round(cor(newdata),1)
library(corrplot)

corrplot(correlation, order= "AOE",method = "color", number.cex = .7, addCoef.col = "black")

#.....feature engineering.....

data$personal_account_month = data$personal_account_m + data$personal_account_y*12
data$emplyed_month = data$months_employed + data$years_employed*12
data$months_employed = NULL
data$years_employed = NULL
data$personal_account_m = NULL
data$personal_account_y = NULL
data$entry_id = NULL
data$e_signed = as.factor(as.character(data$e_signed))

#.... train and test set.....

library(caTools)
set.seed(123)
split= sample.split(data$e_signed, SplitRatio = .70)
training = subset(data, split==TRUE)
test = subset(data, split== FALSE)



#......Random Forest Model.....#
library(randomForest)
set.seed(1234)
classifier = randomForest(formula= factor(e_signed) ~.,
                          data = training, ntree=100, mtry=10,
                          importance = TRUE, type = "classification")

predTest <- predict(classifier, test, type = "class")
mean(predTest == test$e_signed)                    
table(predTest,test$e_signed)  


#........ SVM Model........#
library(e1071)
classifier_svm = svm(formula = factor(e_signed) ~.,
                     data = training, type = "C-classification",
                     kernel= "linear")
pred_svm <- predict(classifier_svm, test, type = "class")
mean(pred_svm == test$e_signed)                    
table(pred_svm,test$e_signed)  

#..... logistic regression...

model <- glm(factor(e_signed) ~ ., 
             data = training, family = binomial)
pred_lr <- predict(model, test, type = "response")
pred_lr <- ifelse(pred_lr > 0.5, "1", "0")
mean(pred_lr == test$e_signed)                    
table(pred_lr,test$e_signed)

#....... KNN.........
library(class)
knn_train = training #we need to create two new variable because 
knn_test = test # knn function cannot handle factor value

knn_train$pay_schedule = as.numeric(knn_train$pay_schedule)
knn_test$pay_schedule = as.numeric(knn_test$pay_schedule)

classifier_Knn = knn(train = knn_train[,-16], test = knn_test[,-16], 
                     cl= knn_train[,16], k =5)
mean(classifier_Knn == test$e_signed)                    
table(classifier_Knn,test$e_signed)

#...... Naive Bayes..........

classifier_NB = naiveBayes(x = knn_train[,-16] ,
                        y = knn_train$e_signed)
predict_NB = predict(classifier_NB, newdata = knn_test)

mean(predict_NB == knn_test$e_signed)                    
table(predict_NB,knn_test$e_signed)
