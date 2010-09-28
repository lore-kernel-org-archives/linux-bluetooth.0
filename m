Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
Date: Tue, 28 Sep 2010 01:05:18 -0600
Message-ID: <AANLkTim27JkfgsumEwd3jK+n1DzYvTYWJGCLGreuw7y3@mail.gmail.com>
Subject: Re: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

> can avrcp be used to drive mythtv? I've got a setup where the myth
> frontend is rarely the foreground app

So if avrcp were to present events in a /dev/input/eventX device, I
could use inputlircd to connect those events to lirc clients. It might
make it easier if a udev rule created something like /dev/input/avrcp0
so we could find it more easily for the inputlircd config.

And I see now that it is by virtue of the use of liblirc that myth can
get remote events even if it's not the foreground app.

Control is enabled by default in 4.60, is there anything I can check
to see why I don't see any log messages about avrcp, no input device
appear, nothing logged, etc? The main connection is initiated by the
headset and the audio connection is initiated by the computer. If I
remember tinkering with this stuff, bluez would need to initiate the
control connection in this case.

hcidump -X -V shows messages going across when I tap avrcp buttons...


> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 0]
      0000: a0 11 0e 00 48 7c 4b 00                           ....H|K.
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0053 len 8 [psm 0]
      0000: a2 11 0e 09 48 7c 4b 00                           ....H|K.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 0]
      0000: b0 11 0e 00 48 7c cb 00                           ....H|..
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0053 len 8 [psm 0]
      0000: b2 11 0e 09 48 7c cb 00                           ....H|..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 200
    Mode: Sniff

-- 
Brad Midgley
