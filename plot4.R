# load dplyr package for data manipulation 
library(dplyr)

# download data from the link provided 
urlink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = urlink, destfile = "exdata_data_household_power_consumption.zip")

# untar the downloded file 
untar("exdata_data_household_power_consumption.zip")

# loading the data 
house_power <- read.table("household_power_consumption.txt", header = TRUE, 
                          na.strings = "?", sep = ";")

# change character strings in Date column to date
house_power <- mutate(house_power, Date = as.Date(house_power$Date, "%d/%m/%Y"))

# subset data to require period 
house_subset <- house_power[house_power$Date >= 
                              "2007-02-01" & house_power$Date <= "2007-02-02", ]

# merge the Date and Time columns in the subset data
# create a new column called "datetime) 
house_subset$datetime <- paste(house_subset$Date, house_subset$Time, sep = " ")

# format datetime column to time 
house_subset$datetime <- strptime(house_subset$datetime, 
                                  format = "%Y-%m-%d %H:%M:%S")


# open png file 
png("plot4.png", width = 480, height = 480)

# setting graphical parameters 
par(mfcol = c(2,2))

# generate first graph 
# generate plot 
# set x-axis and respective label to null
plot(house_subset$datetime, house_subset$Global_active_power, type = "l", xaxt = "n",
     ylab = "Global Active Power", xlab = "")

# add x-axis to plot
axis.POSIXct(1, at = c(as.Date(c("2007-02-01", "2007-02-02", "2007-02-03"), 
                               format = "%Y-%m-%d")), labels = c("Thu", "Fri", "Sat"))


# generate second graph 
# generate plot for sub metering 1 
# set x-axis and respective label to null
attach(house_subset)
plot(datetime, Sub_metering_1, col = "black", type = "l", xaxt = "n", 
     ylab = "Energy sub metering", xlab = "")

# add lines for sub metering 2 and 3 
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")

# add x-axis to plot
axis.POSIXct(1, at = c(as.Date(c("2007-02-01", "2007-02-02", "2007-02-03"), 
                               format = "%Y-%m-%d")), labels = c("Thu", "Fri", "Sat"))

# add legend 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")

# generate third graph 
# set x-axis to null
plot(datetime, Voltage, type = "l", xaxt = "n")

# add x-axis to plot
axis.POSIXct(1, at = c(as.Date(c("2007-02-01", "2007-02-02", "2007-02-03"), 
                               format = "%Y-%m-%d")), labels = c("Thu", "Fri", "Sat"))

# generate fourth graph 
# set x-axis to null
plot(datetime, Global_reactive_power, type = "l", xaxt = "n")

# add x-axis to plot
axis.POSIXct(1, at = c(as.Date(c("2007-02-01", "2007-02-02", "2007-02-03"), 
                               format = "%Y-%m-%d")), labels = c("Thu", "Fri", "Sat"))

# close png file
dev.off()
