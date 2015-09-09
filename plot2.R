
# Download, unzip, extract data and delete leftover file
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileNAME <- "household_power_consumption.txt"
download.file(fileURL,temp)
data <- read.table(unz(temp,fileNAME), header=TRUE, sep=";")
unlink(temp)

#Convert data set into proper date type and filter into subset
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
subdata <- subset(data, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))

#Convert columns into numeric data type
subdata <- transform(subdata, Global_active_power = as.character(Global_active_power),Global_reactive_power = as.character(Global_reactive_power),Voltage = as.character(Voltage),Global_intensity = as.character(Global_intensity),Sub_metering_1 = as.character(Sub_metering_1),Sub_metering_2 = as.character(Sub_metering_2),Sub_metering_3 = as.character(Sub_metering_3))
subdata <- transform(subdata, Global_active_power = as.numeric(Global_active_power),Global_reactive_power = as.numeric(Global_reactive_power),Voltage = as.numeric(Voltage),Global_intensity = as.numeric(Global_intensity),Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3 = as.numeric(Sub_metering_3))

#Create combined variable of date and time
subdata$Datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%Y-%m-%d %H:%M:%S")
subdata$Time <- strptime(subdata$Time,format = "%H:%M:%S")

#Create chart
with(subdata, plot(Datetime,Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)"))

#Copy to png format and close
dev.copy(png,file="plot2.png", width=480, height=480)
dev.off()