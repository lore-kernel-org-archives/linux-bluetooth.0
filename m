Return-Path: <cyrus@holtmann.org>
From: Kilian Lackhove <Kilian.Lackhove@web.de>
To: linux-bluetooth@vger.kernel.org
Subject: Connecting Headset results in "FD error: POLLHUP"
Date: Sun, 25 Oct 2009 14:48:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200910251448.29160.Kilian.Lackhove@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello List!

I am trying to connect a "Plantronics Explorer 230" Headset to my PC. The 
Bluetooth adapter is a "Gigabyte GN-BTD02" and supports Bluetooth 1.2 and the 
hsp profile. An apple wireless keyboard pro is also connected to the computer.

I am running arch linux with bluez 4.56-1 and pulseaudio 0.9.15-1 on kernel 
2.6.31.4-1.

The headset was successfully paired using gnome-bluetooth applet.
According to the bluez-wiki i entered in pacmd:
load-module module-bluetooth-device profile=hsp sink_name=fred 
address=00:23:7F:35:XX:XX
wich doesnt produce any output in pacmd

Unloading the module module-bluetooth-discover didnt change anything.

this is the output of pulseaudio -v:
http://pastebin.com/m26a5fcf9

this is what hcidump says:
---*snip*---
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Synchronous Connect Complete (0x2c) plen 17

This is hciconfig hci0 -a:   
	Type: USB
        BD Address: 00:0F:EA:9A:A3:4B ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:130180 acl:6734 sco:0 events:99 errors:0
        TX bytes:1268 acl:35 sco:0 commands:43 errors:0
        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'rechenknecht'
        Class: 0x4a0104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver: 0x512
        Manufacturer: Cambridge Silicon Radio (10)

This is the output ob bluetoothd -d
http://pastebin.com/d2db878f7

and this is the vendors description of my bluetooth adapter:
http://pastebin.com/d3ad02c8

Regards, Kilian
