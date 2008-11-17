Return-Path: <cyrus@holtmann.org>
Message-ID: <5a14e9b50811171025w3eec0b40g6afdfc0ebffdb7b0@mail.gmail.com>
Date: Mon, 17 Nov 2008 19:25:00 +0100
From: "XazZ XazZ" <xazz.xazz@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with bluez and a bluetooth headset
In-Reply-To: <1226940114.10178.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <5a14e9b50811111229l2addf4aega6e1107320a83026@mail.gmail.com>
	 <5a14e9b50811151841i3d84eae3i6c11068cfad1ac01@mail.gmail.com>
	 <1226940114.10178.3.camel@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

good evening

> I'd recommend you to try kernel 2.6.27 or later.
> A fix concerning eSCO fallback is in it.
> The bug is triggered by using a bluetooth 2 dongle and bluetooth 1
> headset, for instance.

I'm already running a kernel which is newer than 2.6.27 (I'm currently
running 2.6.28 rc3)
But something else must be wrong then:
my USB dongle is a 2.0 one and my headset is also a 2.0 device

[XazZ@darklight ~]$ hciconfig hci0 version | grep HCI
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2c6 LMP Ver: 2.0 (0x3) LMP Subver: 0x2c6

that's what my hciconfig says about my dongle

>Bluetooth version
>    * Bluetooth version: 2.0 with EDR
That is directly taken from my headsets manufacturers website (Nokia)

Thanks in advance
XazZ
