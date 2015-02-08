
# Read the file
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
power <- read.table(file, header=T, sep=";")

# Convert the Date and Time variables to Date/Time classes
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

# Read the data from dates the 2007-02-01 and 2007-02-02
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

# Convert some variable to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))

# Convert the Date and Time variables to Date/Time classes
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Convert some variable to numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Plot 3
png(filename="plot3.png", width=480, height=480)
plot(df$timestamp,
     df$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering",
     main="")
lines(df$timestamp, df$Sub_metering_2, col="red")
lines(df$timestamp, df$Sub_metering_3, col="blue")
legend("topright",
       lwd=1,
       lty=1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
