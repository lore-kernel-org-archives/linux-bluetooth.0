Return-Path: <cyrus@holtmann.org>
Message-ID: <4F660390.3050702@s2004.tu-chemnitz.de>
Date: Sun, 18 Mar 2012 16:47:28 +0100
From: Holger Langenau <holger.langenau@s2004.tu-chemnitz.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Problems connecting via BCM2035
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

For some time I have been using a Sitecom Bluetooth USB Adapter 
(Art.code CN-500V2) to send files to or save contacts from my mobile 
(Nokia 2700c). lsusb reports it as Broadcom Corp. BCM2035 Bluetooth 
dongle (ID 0a5c:200a). This worked fine on a Debian Squeeze (bluez 4.66) 
and Ubuntu 10.04 (bluez 4.60). However using more recent systems on my 
main machine (Debian wheezy & Arch Linux (both bluez 4.99), Fedora FC16, 
Ubuntu 11.10) I did not get it to work for a long time.
It took me some time to find a reason to this. From a fresh install of 
Debian squeeze I built multiple versions of bluez from source and found 
that the problem is between commits 9d7109c and bca43a4 (version 
4.84..4.85; 5b1a2a3 breaks it completely for me).

Setting event[2] |= 0x04 in set_event_mask in plugins/hcipos.c fixes the 
problem for me. Sending files or retrieving contacts etc. from the phone 
works without problems. But having no deep knowledge of the 
communication between hardware and the kernel I don't know if this is 
really a fix for the problem or just the symptom.

The testing was done with l2ping. In my setting the working version gets 
50 responses until I get a "Connection reset by peer" message. The 
non-working version gives me 10 respones (the last with a longer time), 
4 messages "no response from ..." and after that a "Recv failed: 
Connection reset by peer".

Here is some more data of the stick:

Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy:
Link mode: SLAVE ACCEPT
Class: 0x420100
Service Classes: Networking, Telephony
Device Class: Computer, Uncategorized
HCI Version: 1.2 (0x2)  Revision: 0x3
LMP Version: 1.2 (0x2)  Subversion: 0x6963
Manufacturer: Broadcom Corporation (15)

Please let me know if I can provide some more information.

Best regards,
Holger
