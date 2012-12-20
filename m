Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 20 Dec 2012 08:41:23 +0100
Message-ID: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
Subject: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi! I'm trying to pair my bluetooth headset BTH220. In PC I have USB dongle

# hciconfig -a
hci0:   Type: BR/EDR  Bus: USB
   BD Address: 00:02:5B:00:1C:7B  ACL MTU: 310:10  SCO MTU: 64:8
   UP RUNNING PSCAN
   RX bytes:12771 acl:0 sco:0 events:221 errors:0
   TX bytes:1431 acl:0 sco:0 commands:96 errors:0
   Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
   Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
   Link policy: RSWITCH HOLD SNIFF PARK
   Link mode: SLAVE ACCEPT
   Name: 'vandal-0'
   Class: 0x420100
   Service Classes: Networking, Telephony
   Device Class: Computer, Uncategorized
   HCI Version: 2.1 (0x4)  Revision: 0x149c
   LMP Version: 2.1 (0x4)  Subversion: 0x149c
   Manufacturer: Cambridge Silicon Radio (10)


But when I try 'simple-agent hci0 XX:XX:XX' I always get error

Creating device failed: org.bluez.Error.AuthenticationRejected:
Authentication Rejected


I'm doing everything as root, so what could be the reason for
"Authentication Rejected"? Incompatible hardware? Wrong configuration?

In which direction should I be searching?

Thank you
Andrei Voropaev
