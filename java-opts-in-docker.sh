#!/bin/bash
#return resonable JAVA_OPTS 

CGROUPS_MEM=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
MEMINFO_MEM=$(($(awk '/MemTotal/ {print $2}' /proc/meminfo)*1024))
MEM=$(($MEMINFO_MEM>$CGROUPS_MEM?$CGROUPS_MEM:$MEMINFO_MEM))

#customize the ratio if you want.
JVM_HEAP_RATIO=${JVM_HEAP_RATIO:-0.6}

XMX=$(awk '{printf("%d",$1*$2/1024^2)}' <<<" ${MEM} ${JVM_HEAP_RATIO} ")

echo "-Xmx${XMX}m"
