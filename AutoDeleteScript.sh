#!/bin/bash
help() {
    echo "Usage: $0 [-d directory] [-e extensions] [-h]"
    echo "  -d directory      Specify the directory to clean"
    echo "  -e extensions     Specify file extensions to remove (comma-separated)"
    echo "  -h                Display help"
}

clean_directory() {
    directory=$1
    shift
    for ext in "$@"; do
        echo "Cleaning *.$ext files from directory $directory..."
        rm -rf "$directory"/*.$ext
    done
    echo "Cleaning completed."
}
directory=""
extensions=()
while getopts ":hd:e:" opt; do
    case $opt in
        h)
            help
            exit 0;;
        d)
            directory=$OPTARG;;
        e)
            IFS=',' read -r -a extensions <<< "$OPTARG";;
        \?)
            echo "Unknown option: -$OPTARG" >&2
            help
            exit 1;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            help
            exit 1;;
    esac
done
if [ -n "$directory" ] && [ ${#extensions[@]} -gt 0 ]; then
    clean_directory "$directory" "${extensions[@]}"
    zenity --info --title="Cleaning Result" --text="Cleaning successfully completed."
    exit 0
fi
DIALOG=${DIALOG=dialog}
$DIALOG --title "Cleaning Confirmation" --clear \
  --yesno "Are you sure you want to clean files from selected directories?" 10 50
case $? in
    0)
        directory=$(zenity --file-selection --directory --title="Select directory to clean")
        if [ $? -eq 0 ]; then
            extensions=$(dialog --stdout --separate-output --checklist "Select file extensions to remove:" 0 0 0 \
                tmp "Temporary files" off \
                log "Log files" off \
                cache "Cache files" off \
                bak "Backup files" off \
                txt "Text files" off \
                custom "Enter custom extension" off)

            if [ $? -eq 0 ]; then
                selected_extensions=()
                IFS=$'\n' read -r -a ext_array <<< "$extensions"
                for ext in "${ext_array[@]}"; do
                    if [ "$ext" = "custom" ]; then
                        custom_ext=$(zenity --entry --title="Enter custom extension" --text="Enter custom extension:")
                        selected_extensions+=("$custom_ext")
                    else
                        selected_extensions+=("$ext")
                    fi
                done
                clean_directory "$directory" "${selected_extensions[@]}"
                zenity --info --title="Cleaning Result" --text="Cleaning successfully completed."
            else
                zenity --info --title="Cleaning Result" --text="Cleaning was canceled by the user."
            fi
        else
            zenity --info --title="Cleaning Result" --text="Cleaning was canceled by the user."
        fi;;
    1)
        zenity --info --title="Cleaning Result" --text="Cleaning was canceled by the user.";;
esac
exit 0
