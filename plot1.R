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
hist(subset_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

#save it to a PNG file
dev.copy(png,file="plot1.png", width = 480, height = 480)
dev.off()