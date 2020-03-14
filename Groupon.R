install.packages("rvest")
library(rvest)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)
install.packages("plot3D")
library(plot3D)
install.packages("scatterplot3d")
library(scatterplot3d)



GrouponPrice <- lapply(0:7, function(i) {
  url <- str_c("https://www.groupon.com/browse/san-antonio?category=food-and-drink&page=", i)
  page <- read_html(url)
  html_nodes(page,".c-txt-price") %>%
    html_text()
})

OriginalPrice <- lapply(0:7, function(i) {
  url <- str_c("https://www.groupon.com/browse/san-antonio?category=food-and-drink&page=", i)
  page <- read_html(url)
  html_nodes(page,".c-txt-gray-dk") %>%
    html_text()
})




GrouponPrice
OriginalPrice




class(GrouponPrice)
head(GrouponPrice)
GrouponPrice <- unlist(GrouponPrice)
head(GrouponPrice)
GrouponPrice<-gsub("[$]","",GrouponPrice)
head(GrouponPrice)
class(GrouponPrice)
GrouponPrice <- as.numeric(as.character(GrouponPrice))
head(GrouponPrice)
max(GrouponPrice)
hist(GrouponPrice,col="green",breaks=seq(0,130,1))
length(GrouponPrice)
x<-seq(1:40)
head(x)
plot(x,GrouponPrice,col="green",pch=20)
GrouponPrice

class(OriginalPrice)
head(OriginalPrice)
OriginalPrice <- unlist(OriginalPrice)
head(OriginalPrice)
OriginalPrice<-gsub("[$]","",OriginalPrice)
head(OriginalPrice)
class(OriginalPrice)
OriginalPrice <- as.numeric(as.character(OriginalPrice))
head(OriginalPrice)
max(OriginalPrice)
hist(OriginalPrice,col="green",breaks=seq(0,130,1))
length(OriginalPrice)
x<-seq(1:40)
head(x)
plot(x,OriginalPrice,col="green",pch=20)
OriginalPrice


GrouponPrice<-GrouponPrice[-c(19)]
GrouponPrice
Markdown <- cbind(OriginalPrice,GrouponPrice)
Markdown

PercentDiscount <- (OriginalPrice - GrouponPrice)/(OriginalPrice)*100
PercentDiscount

PercentMarkdown <- cbind(OriginalPrice, GrouponPrice,PercentDiscount)
PercentMarkdown
hist(PercentDiscount,col="green")
plot(OriginalPrice,GrouponPrice,col="blue",pch=20)

scatter3D(OriginalPrice,GrouponPrice,PercentDiscount)
scatter3D(OriginalPrice,GrouponPrice,PercentDiscount,phi=0,bty="g",type="h",ticktype="detailed",pch=19,cex=0.5,type="l",xlab="OriginalPrice",ylab="GrouponPrice",zlab="PercentDiscount")
fit <- lm(PercentDiscount ~ OriginalPrice + GrouponPrice)
S3D <- scatterplot3d::scatterplot3d(PercentMarkdown,type="h",color="blue",angle=45,scale.y=.4,pch=16,main="GrouponPredictionPlane")
S3D$plane3d(fit,col="green",lwd= 3)
S3D$plane3d()
  