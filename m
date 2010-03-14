Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Sun, 14 Mar 2010 19:01:20 -0400
Message-ID: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


We have a strange compatible problem with Bluez for eSCO audio. 

We develope an embedded application based on Bluez library that can play the
role of HF and it uses a generic CSR USB Bluetooth dongle. The application
worked well for most cell phones (iPhone, Blackberry etc). But when we tried
it with an Android phone (Motorola Droid), we found one way voice problem.
The Android phone side can not hear the voice. 

We know that Android phone also uses the Bluez library. So we tried to pair
our application with another Linux with Bluez library with another CSR USB
Bluetooth dongle. We used "hcidump" to capture the SCO packets in that
system. We received a lot of SCO packets, but the content of packets is all
zero. However from another end of SCO connection, we actually sent a lot
non-zero contents. 

To simply our debug, we then used the "scotest" program from the Bluez 4.65
source and used one system as client and another as server. From the hcidump
output, we still saw the content of packets is all zero. However when we
changed one USB dongle to another USB dongle with the Broadcom chipset, we
can receive some non-zero data. In both case, we didn't see Bluez kernel
error message.

The Linux kernel for the system we used for test is 2.6.30.  The attachment
is the SCO packet we captured for receiving side. The following is the
information of Bluetooth USB dongle we use:


	hciconfig -a

	hci0:   Type: USB

        BD Address: 00:11:F6:0B:CA:EE ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING PSCAN AUTH ENCRYPT
        RX bytes:2081370 acl:185 sco:17775 events:9695 errors:0
        TX bytes:252089 acl:164 sco:3002 commands:4693 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'test'
        Class: 0x000408
        Service Classes: Unspecified
        Device Class: Audio/Video, Hands-free
        HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver:
0xc5c
        Manufacturer: Cambridge Silicon Radio (10)

 

	hciconfig hci0 revision:

	hci0:   Type: USB

          BD Address: 00:11:F6:0B:CA:EE ACL MTU: 310:10 SCO MTU: 64:8
          Unified 21e
          Chip version: BlueCore4-ROM
          Max key size: 128 bit
          SCO mapping:  HCI


This audio problem seems only happen if both ends use Bluez library. If one
side uses a different Bluetooth library, this issue will not appear. What
can be the cause of this? I am very confused. 


