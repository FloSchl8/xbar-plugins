#!/usr/bin/env bash

# <xbar.title>Tor</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Yulian Kraynyak</xbar.author>
# <xbar.author.github>ykray</xbar.author.github>
# <xbar.desc>Toggles system-wide Tor proxy.</xbar.desc>
# <xbar.image>https://i.imgur.com/chMB5T2.png</xbar.image>
# <xbar.dependencies>tor</xbar.dependencies>

## ** CONFIGURATION **

# * - INSTALL TOR:
#         brew install tor
# * - UPDATE `sudoers` (to allow password-less network management)
#     (1) sudo visudo
#     (2) Append the following line at the end of the file:
#             %admin          ALL = NOPASSWD: /usr/sbin/networksetup,killall

readonly PATH="/opt/homebrew/bin:$PATH"
readonly INTERFACE="Wi-Fi"
readonly HOSTNAME="127.0.0.1"
readonly TOR_PORT=9050
readonly TOR_PID=$(lsof -t -i:$TOR_PORT -sTCP:LISTEN)

readonly icon_enabled="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Ni0xMlQxNDoxNDozMy0wNDowMCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDplYmJkM2Q5Yy1jYjdjLTQzNmUtODQ5YS0xNTFkMWQ2MmFlNTMiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDozZTlkMzY0Ny1kMGRkLTVmNDUtYjFkMy1kYWY4MDYxY2M1NjMiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0NjhhNTJhMy01ZWZjLTQyYzMtYjhmYS01ODU3ODYzZDYyZjciIGRjOmZvcm1hdD0iaW1hZ2UvcG5nIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0iR2VuZXJpYyBSR0IgUHJvZmlsZSI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDY4YTUyYTMtNWVmYy00MmMzLWI4ZmEtNTg1Nzg2M2Q2MmY3IiBzdEV2dDp3aGVuPSIyMDIzLTA2LTEyVDE0OjE0OjMzLTA0OjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgMjIuNSAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ZWJiZDNkOWMtY2I3Yy00MzZlLTg0OWEtMTUxZDFkNjJhZTUzIiBzdEV2dDp3aGVuPSIyMDIzLTA2LTEyVDE0OjE0OjMzLTA0OjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgMjIuNSAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7EozFQAAACLUlEQVRYw8VXzStEURR/xoyvmSx8NhRJ+cgkWfhICSsLCzYWaFjbWmj+A0V2PpayYyUkpJgkTUnNSMpCvkZCGUmZWeCcuq+OO/eZN28OTv0W73fve7/z7jnn3nM1zbwVAaYAt4APwKcCR4AhQL7GaF2AsIHgTzgE1KUinAUIWRCWsWJFvC1JETQnoB1wbDCnyqx4b7J/CaZRiNVbVsz1JBJvtbjMZ4A1QA8gnThSDniT5lYaiWczxBvxChgDpAknMgFPipDF2SmTAzqCGAriBF2JXVm8KUUxtELAvMTfoLhwolQaq6YO3KfiAIk5Wh4gRsYDJBxLhL/TX3AzLPcWYJgI2QBRMj4ueIf0XgGS04xx95O4uwgf0atD2idGkXhgTj4/Cccc4fsF7yHcucYkiiX8Tp69QiyHcKukIr4lMIcDuunPm2QVdO5awbE7sCOew0QsIrjYXziwoXDg8S8d+LcQ2KSmxatIuHWDvSDuoEgVB7ghiT+dVDhVQzhs77QZRvF9LD3F32Mi2gW/R3gfEmUMwtuAEbIVa9JW7BO8XXrPLZcKx2HkksSDxLEFwkfpadjJUAW5gAnFcewU4sXSWIPcE1wwJ+MJyQe71JCEfrMle8bjlyy7Q1FpdqO2rMOi6JVoSgf1bBfiJYqmtDZRZzzA0JZnAGYVc5vN3g26LSQhhrBR7AWqOfXJ3o6wnC4ZciIgnLNsfRb3CSzBFs5bMrbRi4CXBKJYARVmP/oF3cI0yzAf9xMAAAAASUVORK5CYII="
readonly icon_disabled="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LTA2LTEyVDE0OjEzOjM0LTA0OjAwIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjlmNDAyODc1LTJhMGItNGRkNC05YzA2LTUyN2RjMGFjODY2NSIgeG1wTU06RG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjM0NmI4OGNkLTU0MjktNzg0Zi04NDY1LWQzYTgyNWY0ZTA2ZiIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjRhYTJhMDViLTk1Y2QtNDNjNi04MjMyLTEyNmJlYWI0NmVjYiIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJHZW5lcmljIFJHQiBQcm9maWxlIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo0YWEyYTA1Yi05NWNkLTQzYzYtODIzMi0xMjZiZWFiNDZlY2IiIHN0RXZ0OndoZW49IjIwMjMtMDYtMTJUMTQ6MTM6MzQtMDQ6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMi41IChNYWNpbnRvc2gpIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo5ZjQwMjg3NS0yYTBiLTRkZDQtOWMwNi01MjdkYzBhYzg2NjUiIHN0RXZ0OndoZW49IjIwMjMtMDYtMTJUMTQ6MTM6MzQtMDQ6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMi41IChNYWNpbnRvc2gpIiBzdEV2dDpjaGFuZ2VkPSIvIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgYdDGQAAAJpSURBVFjDxZc7aFRBFIa/JBuTbKLFrm8DosH3IqKFNtrY2ghio0RrO7FY0sQ2YG9SqYWNVqIi8YUJUSQgYlRQBAuNsVFwQQQTxGtzLvw5zGbvSx2Y4v4zc/5/zpw59wwkb2XgKHAf+AVEgf4MOAlUKbANAA+bEC7VnwK78pJfzkDs+40sxP0BQ7+BS8Bhc3FHFEW6phc4BDxvImRrUvItgcXngWoURSTpQDdwPWCn1op8rVvwGqglIHwD3AKOxJ4xfCPww9kcWEqATpwAKgl3rOu+A+eANhvrAr66OcF21e28ksLloTOfAbpFhHrikSdf7c8qKbkE4ipgzNmZBbpszgY3tk0FPJaB4TTkASEVYEHsTctxXBP8c7xgubtq1QzEd4FTQtQOzIvduuGdzgsrAY4JMJZx5/H6STn3PsEbkjc0T5zBXBQDB3MKiIBJOY5RwY8bXhPsnV9czSigB/gpdgYNLwt2U27EoiupHx05gk9tjQseYx8D2GIBOaMf4IHZmhO8YdjCvxBwJyDgS2IB//0I0qRfJ6AdmAsEoQbc7Sa5gBcFX8MnQJvt9EJA1HbBPgEMCjCaU8AUUA7svgGUDJ8QfCjO3XlT8T3gtKRiXCoeMrzkvLUunvy2wJ9RnyOfEWFXBJ/X6N1cwO94BTAS+B332pw1bmyPrwnGCy5IXkk8lFxB8vJvlmTfgLq4vTNQkpWaCdiUsSj9YEXpiTjaDV8fKEp3tKqM9wbcOZzySJYBFwN29id9G+zM8DDpMfFTTWJid9rXUSnjm9D3aROXue2zyiUt8SxwoMhXcj9wFnjfgrRuwZyo/QFNFC6isxlzsQAAAABJRU5ErkJggg=="

enable_tor() {
  # Keep-alive: update existing `sudo` timestamp until finished
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &

  sudo networksetup -setsocksfirewallproxy "$INTERFACE" "$HOSTNAME" "$TOR_PORT" off
  sudo networksetup -setsocksfirewallproxystate "$INTERFACE" on

  tor &
}

disable_tor() {
  sudo networksetup -setsocksfirewallproxystate "$INTERFACE" off

  if [[ -n $TOR_PID ]]; then
    kill "$TOR_PID"
  fi
}

get_new_identity() {
  killall -HUP tor
}

case "$1" in
  enable) enable_tor ;;
  disable) disable_tor ;;
  new-identity) get_new_identity ;;
esac

if lsof -Pi :"$TOR_PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "| templateImage="$icon_enabled""
  echo ---
  echo "New Identity | refresh=true param1=new-identity bash=$0"
  echo "Disable Tor | color=#f08a7b refresh=true param1=disable bash=$0"
  echo ---
  echo -e "$(curl -s --socks5-hostname "$HOSTNAME":"$TOR_PORT" icanhazip.com) (ipv4)"
  echo -e "$(curl -s --socks5-hostname "$HOSTNAME":"$TOR_PORT" https://ipv6.icanhazip.com) (ipv6)"

else
  echo "| templateImage="$icon_disabled""
  echo ---
  echo "Enable Tor | color=#cd83f2 refresh=true param1=enable bash=$0"
  echo ---
  echo -e "$(curl -s icanhazip.com) (public IP)"
fi
