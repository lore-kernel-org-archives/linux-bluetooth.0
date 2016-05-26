Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 May 2016 19:43:02 -0400
Message-ID: <CAHY_EhUv=K6qhMQ4JdO5d8XUYUk1oNk4_3QaLFUOCdO8f_dTRg@mail.gmail.com>
Subject: HFP missing audio
From: Jason Gauthier <jagauthier@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings,

 I've been working on a project to turn a raspberry pi 3 into a hands
free device. I ran into a recent challenge.
After connecting with my phone, I've verified that A2DP audio works.
But when placing a call, the audio is absent.
I've been working on this for awhile, and finally decided to try one
of my external USB BT receivers.  Well, after pairing with that
device, HFP audio worked!

I did a little bit more detective work, and using hcidump on both
devices, while making phone calls I see this only on the working
device:

< SCO data: handle 64 flags 0x00 dlen 48
> SCO data: handle 64 flags 0x00 dlen 48
> SCO data: handle 64 flags 0x00 dlen 48
> SCO data: handle 64 flags 0x00 dlen 48
> SCO data: handle 64 flags 0x00 dlen 48
< SCO data: handle 64 flags 0x00 dlen 48
< SCO data: handle 64 flags 0x00 dlen 48
< SCO data: handle 64 flags 0x00 dlen 48
< SCO data: handle 64 flags 0x00 dlen 48
> SCO data: handle 64 flags 0x00 dlen 48

The built in BT controller does not have any SCO packets. Which
explains why there is no audio!

I don't know if this is a bluez issue, a pi3 driver issue, hardware
issue.. So, I decided to email here.

Here is some information about the two adapters:

hci1 works.  hci0 does not work.


hci1:   Type: BR/EDR  Bus: USB
        BD Address: 00:1A:7D:DA:71:13  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:10440048 acl:31566 sco:26509 events:1188 errors:0
        TX bytes:1372769 acl:779 sco:26500 commands:239 errors:1
        Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x5b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'CarPi #2'
        Class: 0x0c0408
        Service Classes: Rendering, Capturing
        Device Class: Audio/Video, Hands-free
        HCI Version: 4.0 (0x6)  Revision: 0x22bb
        LMP Version: 4.0 (0x6)  Subversion: 0x22bb
        Manufacturer: Cambridge Silicon Radio (10)

hci0:   Type: BR/EDR  Bus: UART
        BD Address: B8:27:EB:9E:B3:BA  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN
        RX bytes:32838138 acl:58221 sco:0 events:830 errors:0
        TX bytes:25954 acl:847 sco:18 commands:255 errors:0
        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'CarPi'
        Class: 0x0c0408
        Service Classes: Rendering, Capturing
        Device Class: Audio/Video, Hands-free
        HCI Version: 4.1 (0x7)  Revision: 0xb6
        LMP Version: 4.1 (0x7)  Subversion: 0x2209
        Manufacturer: Broadcom Corporation (15)


If there is anything else I can provide for information that might
help get to the bottom of this, let me know.
I'd definitely like to solve it!

Thanks!
