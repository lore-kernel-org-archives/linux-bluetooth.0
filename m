Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <j2o793f89501005060318nfb8e2e84y54a2b1e9ee346ca3@mail.gmail.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
	 <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
	 <4BE2947F.9030103@greffrath.com>
	 <j2o793f89501005060318nfb8e2e84y54a2b1e9ee346ca3@mail.gmail.com>
Date: Fri, 7 May 2010 11:51:08 +0300
Message-ID: <s2y793f89501005070151p6f01d8d3yba2dc7047460cac1@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Another interesting discovery: when bluetoothd is stopped and bluez
version is 4.60, hciconfig can show all info and i can scan for
another devices:

$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING
        RX bytes:1012 acl:0 sco:0 events:29 errors:0
        TX bytes:114 acl:0 sco:0 commands:31 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver: 0x800
        Manufacturer: Broadcom Corporation (15)

$ hcitool scan
Scanning ...
        00:1E:DC:9B:FF:C4       HBH-DS205

but afer bluetoothd start problem reappears, hciconfig doesn't show
all info and hcitool scan fails
