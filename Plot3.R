#downloading and unzipping file from web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data") #unzipping

#Reading household_power_consumption file
Brutfile <- "./data/household_power_consumption.txt"
data <- read.table(Brutfile, header = TRUE, sep = ";", stringsAsFactors = FALSE, 
                   dec = ".")

#names of dataset
names(data) <- c("Date","Time","Global_active_power",
                 "Global_reactive_power","Voltage","Global_intensity",
                 "Sub_metering_1","Sub_metering_2","Sub_metering_3")


#only using data from the dates 2007-02-01 and 2007-02-02
datad <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

## Making plot
# Plot 3... Energy sub metering
datetime <- strptime(paste(datad$Date, datad$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactivepower <- as.numeric(datad$Global_active_power)
subMet1 <- as.numeric(datad$Sub_metering_1)
subMet2 <- as.numeric(datad$Sub_metering_2)
subMet3 <- as.numeric(datad$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, subMet1, type="l", ylab="Energy Sub metering", xlab="")
lines(datetime, subMet2, type="l", col="red")
lines(datetime, subMet3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()