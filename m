Return-Path: <peter.kjellerstedt@axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Windows Port
Date: Wed, 28 Jan 2004 08:33:38 +0100
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "Marcel Holtmann" <marcel@holtmann.org>, <acr@acroberts.com>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Marcel Holtmann
> Sent: Tuesday, January 27, 2004 17:39
> To: acr@acroberts.com
> Cc: BlueZ Mailing List
> Subject: Re: [Bluez-devel] Windows Port
>=20
> Hi Antony,
>=20
> > I've just been looking at the code (from 2.4 - I'm running=20
> > RH9). As far as I can see L2CAP and RFCOMM are connected=20
> > by a socket interface, and L2CAP and the HCI layer are=20
> > connected by a callback interface, yes?
> >=20
> > After a very cursory investigation, I don't think it's a=20
> > lot of work to create an abstraction layer so that Windows=20
> > can provide the same APIs that BlueZ is using. In fact=20
> > Microsofts BT implementation also uses a socket-based=20
> > approach (unfortunately, because MS don't want us innovating
> > in Bluetooth, everything other than RFCOMM is locked down).
> >=20
> > Of course, the hci_ API would have to be re-written to=20
> > accomodate the new driver (probably need to use sockets=20
> > there as well), but I don't see why L2CAP and RFCOMM=20
> > couldn't communicate in the same way on Windows. I'd
> > probably move them up into user space as services -=20
> > this of course means you have a messy route back into=20
> > kernel mode for Virtual Serial port functions, but=20
> > still, I'd say it's doable.
> >=20
> > I would draw the line at Virtual Serial Port and BNEP, and=20
> > let Windows have it's own user services (not the same as=20
> > the gnome stuff for BlueZ).
> >=20
> > What do you think? Am I right in that we are basically=20
> > talking about sockets for L2CAP and RFCOMM?
>=20
> I don't believe that it is possible to port BlueZ to the
> Windows platform, but I also don't wanna keep you from=20
> trying it. Personally I think it is easier to start from=20
> scratch and then offer the same interfaces as BlueZ does=20
> for Linux.
>=20
> Regards
>=20
> Marcel

I may be stating the obvious, but do not forget about the=20
license issue. As far as I can tell from a quick search=20
through the BlueZ repository, only the code in libs2/lib=20
and utils2/lib is under LGPL, the rest (including the "old"=20
libraries) are under GPL. This means that any program or
kernel driver that uses any of the GPLed parts need to be=20
GPLed too. (This, btw, goes for Linux applications too that=20
use or link with the GPLed parts.)

//Peter
