Return-Path: <cyrus@holtmann.org>
Subject: Problem on PulseAudio
From: Josu Lazkano <josu.lazkano@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Nov 2009 14:41:13 +0100
Message-ID: <1258378873.2419.1.camel@HP>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a problem to get working my laptop with a bluetooth headset on
PulseAudio. I wrote to PulseAudio mail-list, but they recomend to write
on this mail-list.

The proble is that I hava Ubuntu Karmic installed on two laptops, each
ne has it own's BT built in hardware:

$ hciconfig -a (this the one that not work, and now it has Ubuntu
Karmic)

hci0:    Type: USB
    BD Address: 00:10:C6:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
    UP RUNNING
    RX bytes:664 acl:0 sco:0 events:18 errors:0
    TX bytes:73 acl:0 sco:0 commands:19 errors:0
    Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy:
    Link mode: SLAVE ACCEPT
    Name: 'HP integrated Bluetooth module'
    Class: 0x4a0000
    Service Classes: Networking, Capturing, Telephony
    Device Class: Miscellaneous,
    HCI Ver: 1.2 (0x2) HCI Rev: 0x11 LMP Ver: 1.2 (0x2) LMP Subver:
0x6963
    Manufacturer: Broadcom Corporation (15)

And this is the one that works: (now runing Debian Lenny)

# hciconfig -a
hci0:    Type: USB
    BD Address: 00:21:85:xx:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
    UP RUNNING PSCAN ISCAN
    RX bytes:1237 acl:0 sco:0 events:30 errors:0
    TX bytes:852 acl:0 sco:0 commands:29 errors:0
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'LG'
    Class: 0x00010c
    Service Classes: Unspecified
    Device Class: Computer, Laptop
    HCI Ver: 2.1 (0x4) HCI Rev: 0x12e7 LMP Ver: 2.1 (0x4) LMP Subver:
0x12e7
    Manufacturer: Cambridge Silicon Radio (10)

The problem is that I have this errors on PulseAudio on Ubuntu:
http://pastebin.com/f37840107


This line is in red: "E: module-bluetooth-device.c: Failed to write data
to SCO socket: Argumento inválido"

Argumento inválido = Invalid argument (in spanish)

Can you help with this? Is my harware compatible?


Thanks for all and best regards.

