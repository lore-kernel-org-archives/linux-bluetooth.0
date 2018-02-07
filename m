Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Jim Veneskey <bluetooth@bigorc.com>
Date: Wed, 7 Feb 2018 08:48:26 -0500
Message-ID: <CAJaHWiM2iuj5m==6SZwNYy0LD0OMREPtZZg5wfLuB6S4R32icg@mail.gmail.com>
Subject: Testing SPP profiles
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am attempting to test SPP profiles - both inbound and outbound
connections using a Laird WB50N module.  This is an embedded device
running Linux and the firmware includes BlueZ version 5.43

I am attempting to configure SPP via these commands:

###

# /usr/bin/nohup /usr/libexec/bluetooth/bluetoothd &
# nohup: appending output to nohup.out

# bluetoothctl
[NEW] Controller D0:12:6B:0B:E7:E8 BlueZ 5.43 [default]
[NEW] Device B0:05:94:F3:4F:F9 ubuntu-0
[NEW] Device 00:16:A4:0B:F3:84 LAIRD BT900
[bluetooth]# discoverable on
Changing discoverable on succeeded
[CHG] Controller D0:12:6B:0B:E7:E8 Discoverable: yes
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# agent
Missing on/off/capability argument
[bluetooth]# agent on
Agent registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# quit
Agent unregistered
[DEL] Controller D0:12:6B:0B:E7:E8 BlueZ 5.43 [default]

(note sure if the above was required or not)

#
# hciconfig hci0 piscan
# hciconfig hci0
hci0:   Type: Primary  Bus: UART
        BD Address: D0:12:6B:0B:E7:E8  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2449 acl:0 sco:0 events:72 errors:0
        TX bytes:2532 acl:0 sco:0 commands:72 errors:0

# sdptool add --channel=3 SP
# rfcomm watch /dev/rfcomm0 3
Waiting for connection on channel 3


###

At this point, if I query the device from a nearby linux box - I see this:

###

biff@dellthing:~$ sdptool browse D0:12:6B:0B:E7:E8
Browsing D0:12:6B:0B:E7:E8 ...
Service RecHandle: 0x10000
Service Class ID List:
  "PnP Information" (0x1200)
Profile Descriptor List:
  "PnP Information" (0x1200)
    Version: 0x0103

Browsing D0:12:6B:0B:E7:E8 ...
Service Search failed: Invalid argument
Service Name: Generic Access Profile
Service Provider: BlueZ
Service RecHandle: 0x10001
Service Class ID List:
  "Generic Access" (0x1800)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 31
  "ATT" (0x0007)
    uint16: 0x0001
    uint16: 0x0005

Service Name: Generic Attribute Profile
Service Provider: BlueZ
Service RecHandle: 0x10002
Service Class ID List:
  "Generic Attribute" (0x1801)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 31
  "ATT" (0x0007)
    uint16: 0x0006
    uint16: 0x0009

Service Name: AVRCP CT
Service RecHandle: 0x10003
Service Class ID List:
  "AV Remote" (0x110e)
  "AV Remote Controller" (0x110f)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x0103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0106

Service Name: AVRCP TG
Service RecHandle: 0x10004
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x0103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0105

###


No sign of any SPP support.

I'm obviously missing something, but many google searches later I have
nothing to show for it.  (I also searched this mailing list archives -
very little discussion on SPP)

If this is documented someplace, I'd appreciate a pointer to it.

thanks!

Jim
