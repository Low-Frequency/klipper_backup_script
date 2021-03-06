#!/bin/bash

## Opening manual
if [[ "$1" = "-h" || "$1" = "--help" ]]
then
        less "$HOME/scripts/klipper_backup_script/manual"
        exit 1
elif [[ -n "$1" ]]
then
        echo "Try -h, or --help for the manual"
        exit 2
fi

ROT="o"
while [[ "$ROT" != "y" && "$ROT" != "n" ]]
do
        read -p 'Enable log rotation? [y|n] ' ROT

        case $ROT in
                n)
                        sed -i 's/^ROTATION=.*/ROTATION=0/g' "$HOME/.config/klipper_backup_script/backup.cfg"
                        echo "Log rotation disabled"
                        ;;
                y)
                        echo "Log rotation enabled"
                        sed -i 's/^ROTATION=.*/ROTATION=1/g' "$HOME/.config/klipper_backup_script/backup.cfg"
                        ;;
                *)
                        echo "Please provide a valid configuration"
                        echo ""
                        ;;
        esac
done

echo ""

if [[ "$ROT" = "y" ]]
then
        read -p "How long should the logs be kept (in months) " KEEP
        sed -i "s/^RETENTION=.*/RETENTION=$KEEP/g" "$HOME/.config/klipper_backup_script/backup.cfg"
fi
