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

house_power <- mutate(house_power, Date = as.Date(house_power$Date, "%d/%m/%Y"))
house_power <- mutate(house_power, Time = strptime(house_power$Time, "%H:%M:%S"))

# subset data to require period 
house_subset <- house_power[house_power$Date >= 
                              "2007-02-01" & house_power$Date <= "2007-02-02", ]

# open png file 
png("plot1.png", width = 480, height = 480)

# generate plot 
with(house_subset, hist(Global_active_power, col = "red", ylim = c(0, 1200),
                        xlab = "Global Active Power (kilowatts)", 
                        main = "Global Active Power"))

# close png file
dev.off()
