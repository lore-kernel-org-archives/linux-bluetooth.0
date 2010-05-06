Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4BE270EE.5080306@greffrath.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
Date: Thu, 6 May 2010 13:01:36 +0300
Message-ID: <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/6 Fabian Greffrath:
> Could you please post the output of 'sudo hciconfig -a'? I am especially
> interested in the Name part.
>
Interesting moment: when run without sudo with version 4.60 it shows
name, but prints error on getting class of device:

hci0:   Type: USB
        BD Address: 00:1A:7D:0A:C8:8A ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING
        RX bytes:3059 acl:0 sco:0 events:70 errors:0
        TX bytes:797 acl:0 sco:0 commands:75 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
Can't read class of device on hci0: Connection timed out (110)
