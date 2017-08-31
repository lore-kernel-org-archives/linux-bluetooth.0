Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504193531.18331.1.camel@gmail.com>
Subject: bluetoothctl =?UTF-8?Q?=E2=80=9CWaiting?= to connect to
 =?UTF-8?Q?bluetoothd=E2=80=A6=E2=80=9D?= in udev rule script
From: Diego Fernandez <aiguo.fernandez@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 31 Aug 2017 11:32:11 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I'm writing some scripts to automate fixing some issues with
PulseAudio, Bluetooth, and A2DP. I've found some useful examples
online, and I have a script that works when I run it manually. However,
when udev kicks off the rule, I get the error in $subject, which I
imagine means that bluetoothctl can't connect to bluetoothd. I also
tried using hcitool, but that doesn't fix my bluetooth issues.

I tried looking at the code for bluetoothctl, and it seems like it's
using dbus in the background. If that's the case, I would think that
setting XDG_RUNTIME_DIR, XAUTHORITY and DISPLAY should be enough.

I originally posted the question here: https://superuser.com/questions/
1245940/bluetoothctl-waiting-to-connect-to-bluetoothd-in-udev-rule-
script

Here are the scripts I have, which I believe should work with any
bluetooth headset as long as there's only 1 pulseaudio instance running
and only 1 headset connected:

/etc/udev/rules.d/80-bt-headset.rules
-------------------------------------------------
ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/local/bin/a2dp-fix-
wrapper"
-------------------------------------------------

/usr/local/bin/a2dp-fix-wrapper
-------------------------------------------------
#!/bin/bash -x
PID=$(pgrep pulseaudio)
USER=$(grep -z USER= /proc/$PID/environ | sed 's/.*=//')
USER_ID=$(id -u $USER)
HOME=$(echo $(getent passwd $USER )| cut -d : -f 6)

export XDG_RUNTIME_DIR=/run/user/$USER_ID
export XAUTHORITY=$HOME/.Xauthority
export DISPLAY=:0
export PULSE_RUNTIME_PATH=$XDG_RUNTIME_DIR/pulse/

sleep 5

sudo -u $USER -E /usr/local/bin/a2dp-fix &> /udev_output.txt
-------------------------------------------------

/usr/local/bin/a2dp-fix
-------------------------------------------------
#!/bin/bash -x
bt_device_addr=$(pacmd list-cards | grep -i 'name:.*bluez_card' | sed
-E 's/.*<?bluez_card\.([A-Z0-9_]+)>?/\1/')
device_mac=$(echo $bt_device_addr | sed 's/_/:/g')

a2dp_available=$(pacmd list-cards | grep -A30 bluez | grep "A2DP Sink"
| sed -E 's/.* available: ([a-z]+)\)/\1/g')

if [[ "$a2dp_available" == "no" ]]
then
    echo -e "connect $device_mac\nquit" | bluetoothctl
    sleep 5
    pacmd set-card-profile bluez_card.$bt_device_addr off
    pacmd set-card-profile bluez_card.$bt_device_addr a2dp_sink
    pacmd set-default-sink bluez_sink.$bt_device_addr.a2dp_sink
fi
-------------------------------------------------

The following things work:
* running `/usr/local/bin/a2dp-fix` as current user
* running `sudo /usr/local/bin/a2dp-fix-wrapper`

Any help would be greatly appreciated!
