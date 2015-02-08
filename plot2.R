#!/usr/bin/env Rscript

# read data for 2007-02-01 and 2007-02-02
varclasses <- c(rep('character', 2), rep('numeric', 7))
data <- read.csv('household_power_consumption.txt', skip=66636,
                    nrows=(69516-66637+1), sep=';',
                    na.strings='?', colClasses=varclasses)

# reassign the column names
names(data) <- c("Date", "Time", "Global_active_power",
                    "Global_reactive_power", "Voltage",
                    "Global_intensity", "Sub_metering_1",
                    "Sub_metering_2", "Sub_metering_3")

# convert date time to R types
combined_time <- paste(data$Date, data$Time)
data$Time <- as.POSIXct(strptime(combined_time, format="%d/%m/%Y %H:%M:%S"))

# plot
png(filename='plot2.png', width=480, height=480, units='px')
plot(data$Global_active_power ~ data$Time, type='l',
        ylab='Global Active Power (kilowatts)', xlab='')
dev.off()

