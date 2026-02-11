#!/bin/bash

echo "=============================================="
echo "         SERVER PERFORMANCE STATS"
echo "=============================================="
echo ""

# --------------------------------------------
# Total CPU Usage
# --------------------------------------------
echo "1. Total CPU Usage:"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
CPU_USAGE=$((100 - CPU_IDLE))
echo "   CPU Usage: ${CPU_USAGE}%"
echo ""

# --------------------------------------------
# Total Memory Usage
# --------------------------------------------
echo "2. Total Memory Usage:"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$((MEM_USED * 100 / MEM_TOTAL))

echo "   Total Memory: ${MEM_TOTAL} MB"
echo "   Used Memory : ${MEM_USED} MB"
echo "   Free Memory : ${MEM_FREE} MB"
echo "   Usage       : ${MEM_PERCENT}%"
echo ""

# --------------------------------------------
# Total Disk Usage
# --------------------------------------------
echo "3. Total Disk Usage (Root Partition):"
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "   Total Disk: ${DISK_TOTAL}"
echo "   Used Disk : ${DISK_USED}"
echo "   Free Disk : ${DISK_FREE}"
echo "   Usage     : ${DISK_PERCENT}"
echo ""

# --------------------------------------------
# Top 5 Processes by CPU Usage
# --------------------------------------------
echo "4. Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo ""

# --------------------------------------------
# Top 5 Processes by Memory Usage
# --------------------------------------------
echo "5. Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo ""

echo "=============================================="
echo "             END OF REPORT"
echo "=============================================="
