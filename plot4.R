#create a temporary file and download the data
tempFile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempFile)

#read in the data and unlink the temporary file
m.data <- read.table(unz(tempFile, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
unlink(tempFile)

#convert the "Date" column to a date datatype
m.data$Date <- as.Date(m.data$Date, "%d/%m/%Y")

#set the start and end dates for analysis
start.date <- as.Date("2007-02-01", "%Y-%m-%d")
end.date <- as.Date("2007-02-02", "%Y-%m-%d")

#subset the data by the chosen date range
m.data.subset <- subset(m.data, Date >= start.date & Date <= end.date)

#create the date/time
m.data.subset$DateTime <- strptime(paste(m.data.subset$Date, m.data.subset$Time), "%Y-%m-%d %H:%M:%S")

#create the plot, sending it to the png graphics device
png("plot4.png")
#setup the plot array
par(mfrow=c(2,2))

#the first plot
with(m.data.subset, plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
#add the data lines
with(m.data.subset, lines(DateTime, Global_active_power))

#the second plot
with(m.data.subset, plot(DateTime, Voltage, type="n"))
#add the data lines
with(m.data.subset, lines(DateTime, Voltage))

#the third plot
with(m.data.subset, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
#add the data lines
with(m.data.subset, lines(DateTime, Sub_metering_1))
with(m.data.subset, lines(DateTime, Sub_metering_2, col="red"))
with(m.data.subset, lines(DateTime, Sub_metering_3, col="blue"))
#add the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=1,
	col=c("black", "red", "blue"), bty="n")

#the fourth plot
with(m.data.subset, plot(DateTime, Global_reactive_power, type="n"))
#add the data lines
with(m.data.subset, lines(DateTime, Global_reactive_power))

dev.off()