Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Date: Thu, 28 Oct 2010 14:22:46 +0200
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukasz.Rymanowski@tieto.com
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com> <20101022135130.617f0ce8@lxorguk.ukuu.org.uk> <AANLkTik-S50ZX6mFG+vWhBv0x_WmipP=t+4VqmAgssRC@mail.gmail.com>
In-Reply-To: <AANLkTik-S50ZX6mFG+vWhBv0x_WmipP=t+4VqmAgssRC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010281422.46687.arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 22 October 2010, Par-Gunnar Hjalmdahl wrote:

> >
> > So - NAK this for the moment, it needs to be split cleanly into ldisc
> > (thing which speaks the protocol and eg sees "speed change required" and
> > acts on it) and device (thing which knows about the hardware).
> 
> OK. We will try to figure out a new design.
> I'm not too happy about putting the ldisc part in Bluetooth though
> since it is only partly Bluetooth, it is also GPS and FM. Better could
> maybe be under char/?

After getting a better idea of what the base mfd driver does, my impression
is now that you should not register a second N_HCI line discipline at all,
but instead extend the existing line discipline with this number.

I'm not sure what happens if you need two modules that try to register
the same ldisc number, but I imagine it is not good.

Shouldn't you instead be using the drivers/bluetooth/hci_{ldisc,h4} code?

	Arnd
