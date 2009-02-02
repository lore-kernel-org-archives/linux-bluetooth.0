Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can i configure bluez to transmit Voice over PCM
Date: Mon, 2 Feb 2009 08:31:10 +0100
Message-ID: <49ED01FC03EE524BB7BB258E8F93BFF32F3DD5@bfl-exchange-1.BFL.local>
In-Reply-To: <1233507125.4809.2.camel@californication>
References: <49ED01FC03EE524BB7BB258E8F93BFF32F3DB5@bfl-exchange-1.BFL.local> <1233507125.4809.2.camel@californication>
From: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

is it possible to use Version 4.27 for embedded systems without any
Desktop Environment only with commandline?
I will try to switch to 4.27.
Regards
Sebastian

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Sunday, February 01, 2009 5:52 PM
> To: Matuschka, Sebastian
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: How can i configure bluez to transmit Voice over PCM
>=20
> Hi Sebastian,
>=20
> > i'm using bluez 3.36 on an embedded system with a CSR Chip
connected.
> > Communication via HCI over UART works well. I need to receive and
send
> > voice from/to a headset and therefore I want to send/get the voice
as
> > PCM to the CSR chip. The PCM pins of the CSR Chip are connected to
the
> > SSC pins of an avr32 microcontroller. The CSR chip is configured to
use
> > PCM as soon as the Host produces Clock, otherwise it tries to
transmit
> > voice per HCI which is too slow (only 115200 baudrate for a 8kHz PCM
> > stream).
> > In etc/bluetooth/audio.conf I have set SCORouting=3DPCM
> > In etc/Bluetooth/asound.conf I have written the following:
> > #####################
> > pcm.headset {
> > 	type bluetooth
> > }
> > ctl.headset {
> > 	type bluetooth
> > }
> > #####################
> > But bluez is still sending voice over HCI, which is ok because: How
> > should it know where to transmit the PCM stream. I need a device but
I
> > am not sure what exactly is needed.
> > Do I have to write a dummy soundcard driver which only sends and
> > receives pcm over the ssc pins? I guess a pseudo UART device for SSC
> > isn't enough because bluez needs an alsa device, correct?
> >
> > For a quick and dirty solution: Is it possible to let bluez reduce
the
> > soundquality so it works over HCI any way?
> >
> > Are my settings correct or have I missed something?
>=20
> I would really advise you to start using 4.27 instead of a previous
> major version that is not developed.
>=20
> Also when using PCM for SCO then you need to use the D-Bus API for
> headsets and not the ALSA plugin.
>=20
> Regards
>=20
> Marcel
>=20
