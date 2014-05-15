Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 15 May 2014 21:52:32 +0200
Message-ID: <CAL1QEK3bxy_iuR++NYFDmVFUzgqiowV4YxEgAOPY1KRJx5_ExA@mail.gmail.com>
Subject: [Bluez 4.95] Can't start the bluetoothd daemon
From: =?UTF-8?B?SsOpcsOpbXkgQ2F6YXV4?= <jcazaux@sirlan.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I encounter several issues using the bluetooth on my embedded system
(a STLinux 2.4 OS).

I'm using bluez 4.95 and dbus 1.4.14.

I can't connect to the local SDP server. No SDP server is running.

root@b2020-h416_a9:~# sdptool browse local
Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or directory
root@b2020-h416_a9:~#

No active bluetoothd process on the system:

root@b2020-h416_a9:~# ps aux |grep blue
root 1290 0.0 0.0 1564 492 pts/2 S+ 03:52 0:00 grep blue
root@b2020-h416_a9:~#

root@b2020-h416_a9:~# ps aux |grep sdp
root 1292 0.0 0.0 1564 492 pts/2 S+ 03:52 0:00 grep sdp
root@b2020-h416_a9:~#

Here is the dmesg stack trace:
root@b2020-h416_a9:~# dmesg |grep Blue
[ 0.220000] Bluetooth: Core ver 2.16
[ 0.220000] Bluetooth: HCI device and connection manager initialized
[ 0.220000] Bluetooth: HCI socket layer initialized
[ 0.220000] Bluetooth: L2CAP socket layer initialized
[ 0.220000] Bluetooth: SCO socket layer initialized
[ 0.600000] Bluetooth: Virtual HCI driver ver 1.3
[ 0.600000] Bluetooth: HCI UART driver ver 2.2
[ 0.600000] Bluetooth: HCI H4 protocol initialized
[ 0.600000] Bluetooth: HCI BCSP protocol initialized
[ 0.600000] Bluetooth: HCILL protocol initialized
[ 0.600000] Bluetooth: HCIATH3K protocol initialized
[ 0.600000] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[ 0.780000] Bluetooth: RFCOMM TTY layer initialized
[ 0.780000] Bluetooth: RFCOMM socket layer initialized
[ 0.780000] Bluetooth: RFCOMM ver 1.11
[ 0.780000] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 0.780000] Bluetooth: BNEP filters: protocol multicast
[ 0.780000] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
root@b2020-h416_a9:~#

The following bluetoothd doesn't create a bluetooth process:
root@b2020-h416_a9:~# bluetoothd
root@b2020-h416_a9:~# ps aux |grep blue
root 1302 0.0 0.0 1564 492 pts/2 S+ 03:57 0:00 grep blue
root@b2020-h416_a9:~#

With the -n option, I have the following error:
root@b2020-h416_a9:~# bluetoothd -n
bluetoothd[1303]: Bluetooth daemon 4.95
bluetoothd[1303]: Unable to get on D-Bus
root@b2020-h416_a9:~#

dbus is not active and cannot be started:
root@b2020-h416_a9:~# dbus-launch
Failed to start message bus: Failed to read directory
"/etc/dbus-1/session.d": No such file or directory
EOF in dbus-launch reading address from bus daemon
root@b2020-h416_a9:~#


So, I have created the /etc/dbus-1/session.d directory:

mkdir /etc/dbus-1/session.d

root@b2020-h416_a9:~# dbus-launch
DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-aIOwKaatcU,guid=8d540a0ec3d355269fda85bf00015156
DBUS_SESSION_BUS_PID=2361

root@b2020-h416_a9:~# ps aux |grep dbus
root 2361 0.0 0.0 2420 492 ? Ss 23:59 0:00 /usr/bin/dbus-daemon --fork
--print-pid 4 --print-address 6 --session
root 2363 0.0 0.0 1564 492 pts/3 S+ 23:59 0:00 grep dbus
root@b2020-h416_a9:~#

Unfortunately, the bluetooth daemon can't be started:

root@b2020-h416_a9:~# bluetoothd -n
bluetoothd[2364]: Bluetooth daemon 4.95
bluetoothd[2364]: Unable to get on D-Bus
root@b2020-h416_a9:~#


The USB bluetooth device is detected:
root@b2020-h416_a9:~# hciconfig -a
hci0: Type: BR/EDR Bus: USB
BD Address: 00:02:72:CC:97:CD ACL MTU: 1021:8 SCO MTU: 64:1
UP RUNNING PSCAN ISCAN
RX bytes:1494 acl:0 sco:0 events:43 errors:0
TX bytes:656 acl:0 sco:0 commands:43 errors:0
Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH SNIFF
Link mode: SLAVE ACCEPT
Name: 'BCM20702A'
Class: 0x000000
Service Classes: Unspecified
Device Class: Miscellaneous,
HCI Version: 4.0 (0x6) Revision: 0x1000
LMP Version: 4.0 (0x6) Subversion: 0x220e
Manufacturer: Broadcom Corporation (15)

root@b2020-h416_a9:~#

Thank you for your help

Best regards,
