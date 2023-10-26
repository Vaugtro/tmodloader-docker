#!/usr/bin/env bash
# DedicatedServerUtils/Setup_tModLoaderServer.sh

# Logging time snippet
function tee_with_timestamps () {
    local logfile=$1
    while read data; do
        echo "${data}" | sed -e "s/^/$(date '+%d-%m-%C%y %H:%M:%S') /" >> "${logfile}"
        echo "${data}"
    done
}

input="install.txt"
if [ -f "$input" ] ; then
	str="+force_install_dir /root/terraria-server/workshop-mods +login anonymous"
	while read -r line
	do
		str="$str +workshop_download_item 1281930 $line"
	done < "$input"
	str="$str +quit"
	
	steamcmd $str
fi

./start-tModLoaderServer.sh -steamworkshopfolder /root/terraria-server/workshop-mods/steamapps/workshop | tee_with_timestamps log.txt