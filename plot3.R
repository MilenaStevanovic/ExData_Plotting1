setwd("C:/Projects/R/Coursera")

#Read only the first column (to find rows from 1/2/2007 to 2/2/2007)
Dates<-read.csv("./data/household_power_consumption.txt",colClasses = c("character", rep("NULL", 8)), sep = ";",na.strings = "?")
subset_Dates<-subset(Dates, Date=="1/2/2007"|Date=="2/2/2007")

#Read only data from 1/2/2007 to 2/2/2007 (subset_Dates)
subset_data<-read.csv("./data/household_power_consumption.txt",skip=as.integer(row.names(subset_Dates)[1])-1, nrows=nrow(subset_Dates),sep = ";",na.strings = "?")#2075259

#Set column names
col_names <- sapply(read.table("./data/household_power_consumption.txt", nrow = 1, sep = ";"), as.character)
names(subset_data)<-col_names

#Add datetime column (combining Date and Time)
subset_data$datetime<-strptime(paste(as.character(subset_data$Date),as.character(subset_data$Time)),"%d/%m/%Y %H:%M:%S")

#Construct the plot
par(mfrow = c(1, 1))
par(mar=c(5.1, 4.1, 4.1, 2.1))
plot(subset_data$datetime, subset_data$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "n")
points(subset_data$datetime, subset_data$Sub_metering_1, type = "l")
points(subset_data$datetime, subset_data$Sub_metering_2, type = "l", col= "red")
points(subset_data$datetime, subset_data$Sub_metering_3, type = "l", col= "blue")

legend("topright", col=c("black","red","blue"), lwd=c(2,2), cex = 0.5, lty=c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

#save it to a PNG file
dev.copy(png,file="plot3.png", width = 480, height = 480)
dev.off()