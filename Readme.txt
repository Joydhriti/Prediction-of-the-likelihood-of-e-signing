In this project I have tried to predict the likelihood of e-signing based on financial history.
	* RANDOM FOREST
	* SUPPORT VECTOR MACHINE
	* LOGISTIC REGRESSION
	* K NEAREST NEIGHBOUR
	* NAIVE BAYES
	  
dataset link : https://www.superdatascience.com/machine-learning-practical/

Methodology:
	* the dataset was imported
	* a new dataset was created to check there is any correalation between attributes.
	* main dataset was split into train and test set.
	* random forest, svm, logistic regression, KNN and naive bayes algorithms 
	were used to predict accuracy 

Result:
Random Forest: 0.6368881
		0    1
	    0 1446  916
       	    1 1035 1976


SVM: 0.5741671
	   	0    1
            0 1005  812
            1 1476 2080

Logistic Regression: 0.5737949
	    	0    1
      	    0 1049  858
      	    1 1432 2034

Knn: 0.5618835		

		0    1
             0 1216 1089
             1 1265 1803

Naive Bayes: 0.5728643

          
	 	0    1
             0 1133  947
             1 1348 1945

conclusion: random forest provided best result.