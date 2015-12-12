Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Dec 2015 17:06:09 +0100
Message-ID: <CA+RPYyX5b=QGdym1V0pFrU5kT_4HbTPeJF8piheUcp9MnOSYdQ@mail.gmail.com>
Subject: Lenovo keyboard
From: chris <inkbottle007@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list,

I've been consistently using a lenovo bluetooth keyboard since Bluez4.
Since a recent (a month ago or so) upgrade (debian/stretch) it doesn't
connect anymore.
Neither does a Jabra Stealth earpiece which was doing fine a month ago.

$ bluetoothctl --version
5.36

Here is my attempt to pair the keyboard (as root):

# bluetoothctl -a
[NEW] Controller 9C:2A:70:82:50:FB pluto [default]
Agent registered
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# agent on
Agent is already registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 9C:2A:70:82:50:FB Discovering: yes
[NEW] Device 90:7F:61:11:2C:A7 ThinkPad Compact Bluetooth Keyboard
with TrackPoint
[CHG] Device 90:7F:61:11:2C:A7 Connected: no
[DEL] Device 90:7F:61:11:2C:A7 ThinkPad Compact Bluetooth Keyboard
with TrackPoint
[NEW] Device 90:7F:61:11:2C:A7 ThinkPad Compact Bluetooth Keyboard
with TrackPoint
[bluetooth]# pair 90:7F:61:11:2C:A7
Attempting to pair with 90:7F:61:11:2C:A7
[CHG] Device 90:7F:61:11:2C:A7 Connected: yes
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[CHG] Device 90:7F:61:11:2C:A7 RSSI: -53
[CHG] Device 90:7F:61:11:2C:A7 Paired: yes
Pairing successful
[CHG] Device 90:7F:61:11:2C:A7 Connected: no
[bluetooth]# trust 90:7F:61:11:2C:A7
[CHG] Device 90:7F:61:11:2C:A7 Trusted: yes
Changing 90:7F:61:11:2C:A7 trust succeeded
[bluetooth]# connect 90:7F:61:11:2C:A7
Attempting to connect to 90:7F:61:11:2C:A7
[CHG] Device 90:7F:61:11:2C:A7 Connected: yes
[CHG] Device 90:7F:61:11:2C:A7 RSSI: -68
Failed to connect: org.bluez.Error.Failed
[CHG] Device 90:7F:61:11:2C:A7 Connected: no
[CHG] Device 90:7F:61:11:2C:A7 RSSI: -57
[bluetooth]# quit

During the passkey thing, the color of the digits indicates that the
input from the bluetooth keyboard is taken into account.

Even when it says conneced: yes, it isn't actually connected:
the led of the keyboard indicates it isn't connected and there is no input.

# cat /var/lib/bluetooth/9C\:2A\:70\:82\:50\:FB/90\:7F\:61\:11\:2C\:A7/info
[General]
Name=ThinkPad Compact Bluetooth Keyboard with TrackPoint
Class=0x002540
SupportedTechnologies=BR/EDR;
Trusted=true
Blocked=false

[LinkKey]
Key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Type=5
PINLength=0

I've got no knowledge about how bluetooth stack is working, I'm a
complete end-user there.
But if you can point me out something I've done wrong, or suggest
something else to do,
or if I can provide additional information...

Chris
