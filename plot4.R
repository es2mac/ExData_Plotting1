
# Read the UCI power consumption dataset
# Estimated slightly over 2075259 * 9 * 8 bytes ~= 142 MB in memory
# Will read only the relevant subset, 2007/02/01 ~ 2007/02/02
# 2880 rows starting from row 66637

# First read column names
hpc_colnames <- colnames(read.table("household_power_consumption.txt", sep=";", header = TRUE, nrow = 1))

# Read the subset of data in days 2007/02/01 ~ 2007/02/02
hpc <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)), col.names = hpc_colnames, skip = 66636, nrows = 2880)

# Construct POSIX time from the date and time string
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')




# Plot 4: Group of 2x2 plots
png(filename = "plot4.png", bg = "transparent")

par(mfrow = c(2, 2))

# first: same as plot2 (adjusted ylab)

with(hpc, plot(datetime, Global_active_power, 'l', xlab = "", ylab = "Global Active Power", main = ""))

# second: plot voltage vs datetime

with(hpc, plot(datetime, Voltage, 'l'))

# third: same as plot3
with(hpc, plot(datetime, Sub_metering_1, 'l', xlab = "", main = "", ylab = "Energy sub metering"))
with(hpc, points(datetime, Sub_metering_2, 'l', col = "red"))
with(hpc, points(datetime, Sub_metering_3, 'l', col = "blue"))
legend('topright', legend = c("Sub_metering_1",  "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

# fourth: plot global reactive power vs datetime

with(hpc, plot(datetime, Global_reactive_power, 'l'))

dev.off()

