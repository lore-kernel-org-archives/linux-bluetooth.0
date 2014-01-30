Return-Path: <cyrus@holtmann.org>
Message-ID: <52EA8D88.8050306@mousecar.com>
Date: Thu, 30 Jan 2014 12:36:08 -0500
From: ken <gebser@mousecar.com>
Reply-To: gebser@mousecar.com
MIME-Version: 1.0
To: bluetooth list <linux-bluetooth@vger.kernel.org>
Subject: "retail" config question OT???
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I signed up for this list, not because I'm a bluetooth developer, but 
for help configuring my system.  Reading all the messages on development 
passing here the past week or so, I'm thinking I might have the wrong 
list.  If so, please ignore my query below (or respond if you care to) 
and direct me to the appropriate list.

For several weeks I've been trying to use bluetooth to connect my 
Android phone (running BlueTerm) to a terminal on a Raspberry Pi.  I've 
somehow gotten them paired and connected and have transferred a file 
from the Pi to the phone.  But when attempting to connect from BlueTerm, 
it says "Connected" just for a second, then a second message appears 
saying, "Device connection was lost".

"grep -i blue /var/log/*" yields a lot, among which is:

messages:Jan 27 02:17:18 rpi kernel: [   18.926436] Bluetooth: Core ver 2.16
messages:Jan 27 02:17:18 rpi kernel: [   20.888582] Bluetooth: HCI 
device and connection manager initialized
messages:Jan 27 02:17:18 rpi kernel: [   21.307016] Bluetooth: HCI 
socket layer initialized
messages:Jan 27 02:17:18 rpi kernel: [   21.371930] Bluetooth: L2CAP 
socket layer initialized
messages:Jan 27 02:17:18 rpi kernel: [   21.438767] Bluetooth: SCO 
socket layer initialized
messages:Jan 27 02:17:20 rpi kernel: [   40.992246] Bluetooth: BNEP 
(Ethernet Emulation) ver 1.3
messages:Jan 27 02:17:20 rpi kernel: [   40.992284] Bluetooth: BNEP 
filters: protocol multicast
messages:Jan 27 02:17:20 rpi kernel: [   40.992345] Bluetooth: BNEP 
socket layer initialized
messages:Jan 27 02:17:20 rpi kernel: [   41.042231] Bluetooth: RFCOMM 
TTY layer initialized
messages:Jan 27 02:17:20 rpi kernel: [   41.042346] Bluetooth: RFCOMM 
socket layer initialized
messages:Jan 27 02:17:20 rpi kernel: [   41.042368] Bluetooth: RFCOMM 
ver 1.11
syslog:Jan 30 12:00:38 rpi bluetoothd[2042]: Unable to spawn pnatd: 
Failed to execute child process "/usr/bin/phonet-at" (No such file or 
directory)
...

I haven't been able to get blueTerm to output any logs.

Perhaps helpful:

# hciconfig hci0 -a
hci0:   Type: BR/EDR  Bus: USB
         BD Address: 00:1F:81:00:08:30  ACL MTU: 1021:4  SCO MTU: 180:1
         UP RUNNING PSCAN
         RX bytes:6034 acl:90 sco:0 events:242 errors:0
         TX bytes:3253 acl:102 sco:0 commands:77 errors:0
         Features: 0xff 0x3e 0x09 0x76 0x80 0x01 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF
         Link mode: SLAVE ACCEPT
         Name: 'rpi-0'
         Class: 0x520100
         Service Classes: Networking, Object Transfer, Telephony
         Device Class: Computer, Uncategorized
         HCI Version: 2.0 (0x3)  Revision: 0x44
         LMP Version: 2.0 (0x3)  Subversion: 0x3
         Manufacturer: Cambridge Silicon Radio (10)

Running "rfcomm -a" returns nothing at all.  Not knowing or finding 
anywhere what to put in any of the /etc/bluetooth/* files, that may not 
be surprising.

TIA for any help you can provide.
