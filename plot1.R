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

#create the plot, sending it to the png graphics device
png("plot1.png")
with(m.data.subset, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()