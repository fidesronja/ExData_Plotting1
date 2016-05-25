
##downloading zip file
if (!file.exists("data")){
       dir.create("data")
}

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="data.zip")
unzip("data.zip")

##estimate requested memory
estimated_memory_use_in_mb<-2075259*9*8/1048576
estimated_memory_use_in_mb

data<-read.table("./household_power_consumption.txt",header=T,sep=";",na.strings="?")

names(data)
str(data)

data<-subset(data,data$Date=="1/2/2007"|data$Date=="2/2/2007")
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time2<-paste(data$Date,data$Time)
data$Time2<-strptime(data$Time2,format="%Y-%m-%d %H:%M:%S")
data$Time<-data$Time2
data$Time2<-NULL
png("plot1.png",480,480)
hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
