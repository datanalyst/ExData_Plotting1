
setwd(dir)

# Data Loading and Preprocessing
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

# Read the file;
power <- read.table(file, header=T, sep=";")

# Look at data
head(power)

#         Date     Time Global_active_power Global_reactive_power Voltage
# 1 16/12/2006 17:24:00               4.216                 0.418 234.840
# 2 16/12/2006 17:25:00               5.360                 0.436 233.630
# 3 16/12/2006 17:26:00               5.374                 0.498 233.290
# 4 16/12/2006 17:27:00               5.388                 0.502 233.740
# 5 16/12/2006 17:28:00               3.666                 0.528 235.680
# 6 16/12/2006 17:29:00               3.520                 0.522 235.020
#   Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
# 1           18.400          0.000          1.000             17
# 2           23.000          0.000          1.000             16
# 3           23.000          0.000          2.000             17
# 4           23.000          0.000          1.000             17
# 5           15.800          0.000          1.000             17
# 6           15.000          0.000          2.000             17
 
# Convert the Date and Time variables to Date/Time classes
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

# Read the data from dates the 2007-02-01 and 2007-02-02
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

# Convert some variable to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))

df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))


# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot,
# i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
# Add the PNG file and R code file to your git repository

# Plot1
plot1 <- function() {
        hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
plot1()

# Plot1.png has been saved in /Users/dmaurath/Documents/JHDS/datasciencecoursera/Exploratory Data Analysis Projects/Plotting 1

