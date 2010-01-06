Return-Path: <cyrus@holtmann.org>
Subject: pc as headset
To: linux-bluetooth@vger.kernel.org
From: Mailing List SVR <lists@svrinformatica.it>
Reply-To: lists@svrinformatica.it
Date: Wed, 6 Jan 2010 18:56:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001061856.48075.lists@svrinformatica.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to use my pc as an headset, first of all I changed the class of 
device, so I have:

hciconfig -a
hci0:   Type: USB
        BD Address: 00:23:4D:E6:C4:61 ACL MTU: 1021:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:7370 acl:37 sco:0 events:187 errors:0
        TX bytes:3628 acl:26 sco:0 commands:128 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'e6500-0'
        Class: 0x200404
        Service Classes: Audio
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 2.1 (0x4) HCI Rev: 0x51c8 LMP Ver: 2.1 (0x4) LMP Subver: 
0x423d
        Manufacturer: Broadcom Corporation (15)

even from another pc hcitool scan --class confirm that the class of my pc is 
headset

I registered the HS service, "sdptool browse local" find the headset service:

Service Name: Headset
Service RecHandle: 0x10007
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

and I can see this service from another pc too, 

but other device no yet identify my pc as an headset,

I have a phone that only discover headset devices, it finds commercial headsets 
but not my pc, what missing?

thanks for your help,

Nicola
