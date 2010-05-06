Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4BE270EE.5080306@greffrath.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
Date: Thu, 6 May 2010 12:56:19 +0300
Message-ID: <u2z793f89501005060256g3eb32a09ncff16e8e454bdcc@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/6 Fabian Greffrath:
> Could you please post the output of 'sudo hciconfig -a'? I am especially
> interested in the Name part.
>
For bluez version 4.60 (I'm at work now, i have 4.64 version only at home):
hci0:   Type: USB
       BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
       UP RUNNING
       RX bytes:664 acl:0 sco:0 events:18 errors:0
       TX bytes:73 acl:0 sco:0 commands:19 errors:0
       Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy:
       Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out (110)

And for 4.32:
hci0:   Type: USB
       BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
       UP RUNNING PSCAN
       RX bytes:1362 acl:0 sco:0 events:46 errors:0
       TX bytes:693 acl:0 sco:0 commands:47 errors:0
       Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy:
       Link mode: SLAVE ACCEPT
       Name: 'Broadcom BCM2035'
       Class: 0x0a0100
       Service Classes: Networking, Capturing
       Device Class: Computer, Uncategorized
       HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver: 0x800
       Manufacturer: Broadcom Corporation (15)
