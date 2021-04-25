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
# Plot 4... Global active power, Energy sub metering, Voltage and Global reative power

datetime <- strptime(paste(datad$Date, datad$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactivepower <- as.numeric(datad$Global_active_power)
globalreactivepower <- as.numeric(datad$Global_reactive_power)
voltage <- as.numeric(datad$Voltage)
submet1 <- as.numeric(datad$Sub_metering_1)
submet2 <- as.numeric(datad$Sub_metering_2)
submet3 <- as.numeric(datad$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalactivepower, type="l", xlab="", 
     ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, submet1, type="l", ylab="Energy submeter", xlab="")
lines(datetime, submet2, type="l", col="red")
lines(datetime, submet3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalreactivepower, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()