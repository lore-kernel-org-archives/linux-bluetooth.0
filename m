Return-Path: <webmaster@baxter-net.de>
From: "Tobias Sprafke" <webmaster@baxter-net.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] Re: Bluez on Axis DevBoard 82
Date: Mon, 8 Mar 2004 18:32:07 +0100
Message-ID: <DGELJAKAPGMFDACACGBEMEJHCCAA.webmaster@baxter-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1078765296.10671.14.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

I use the kernel 2.4.22. (This is the latest tested version for the Axis
Devboard 82)


The line
"source net/bluetooth/Config.in"
is missing in the linux/arch/cris/config.in file.


Regards
Tobias Sprafke

Mobile: +49 (0) 177 64 32 313
Fon:    +49 (0) 208 75 10 123
E-Mail: tobias.sprafke@baxter-net.de

Have a lot of fun ... :-)

-----Ursprüngliche Nachricht-----
Von: Marcel Holtmann [mailto:marcel@holtmann.org]
Gesendet: Montag, 8. März 2004 18:02
An: Tobias Sprafke
Cc: Eric Chapman; BlueZ Mailing List
Betreff: Re: [Bluez-devel] Re: Bluez on Axis DevBoard 82


Hi Tobias,

> with "kernel part of bluez" I really mean this part of bluez,
> which could be configured in the linux kernel.
> After installing the Axis-DevBoard-Software, there isn't a submenu for
> Bluetooth anymore
> when running "make xconfig" ...

this must be a bug. What kernel do you use? Maybe it is some Axis OpenBT
specific cruft of the Cris architecture. If so, it must be removed and
patches are welcome.

Regards

Marcel
