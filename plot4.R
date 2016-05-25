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

png("plot4.png",480,480)
par(mfrow=c(2,2))
plot(data$Time,data$Global_active_power, type="l",xlab="",ylab="Global Active Power") ### eventuell hinzufuegen cex.lab=0.7, cex.axis=0.7
plot(data$Time,data$Voltage, type="l",xlab="datetime",ylab="Voltage")
plot(data$Time,data$Sub_metering_1, type="n",xlab="",ylab="Energy sub metering")
lines(data$Time,data$Sub_metering_1)
lines(data$Time,data$Sub_metering_2,col="red")
lines(data$Time,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue"),bty = "n",cex=0.6) ## eventuell cex erhoehen
plot(data$Time,data$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()