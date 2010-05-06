Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4BE2947F.9030103@greffrath.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
	 <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
	 <4BE2947F.9030103@greffrath.com>
Date: Thu, 6 May 2010 13:18:48 +0300
Message-ID: <j2o793f89501005060318nfb8e2e84y54a2b1e9ee346ca3@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/6 Fabian Greffrath:
> Maybe a stupid question, but do you have an application like GNOME's
> bluetooth applet running (that keeps the shared lib in memory) while
> switching bluez versions?
>
Yeah, kbluetooth was running, but switching bluez version implies
bluetoothd restart.
Anyway, here is what i get after terminating kbluetooth and manually
stopping and starting bluetoothd:

First run without sudo:

$ hciconfig -a
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

Second run without sudo:

$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING
        RX bytes:664 acl:0 sco:0 events:18 errors:0
        TX bytes:77 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out (110)

Third run without sudo, and 'Name:' appears:

$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING
        RX bytes:664 acl:0 sco:0 events:18 errors:0
        TX bytes:83 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
Can't read class of device on hci0: Connection timed out (110)


Same result with sudo: first one or two runs didn't get name, but later did
