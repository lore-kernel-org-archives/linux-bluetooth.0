Return-Path: <pomac@vapor.com>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095878303.6223.93.camel@pegasus>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>  <1095878303.6223.93.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3wN1ey5yLEqO9emo46RS"
Message-Id: <1095878969.3211.23.camel@big>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 20:49:30 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-3wN1ey5yLEqO9emo46RS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 20:38, Marcel Holtmann wrote:
> Hi Ian,
>=20
> > > this problem was reported two or three times, but I am unable to
> > > reproduce it with my USB 2.0 host controllers.
> >=20
> > ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> > ohci_hcd 0000:00:02.1: irq 185, pci mem f8818000
> > ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
>=20
> your IRQ looks very weird. I have never seen an IO-APIC system assigning
> IRQ 185 to any device. Does any other USB device works in conjunction
> with this controller?

2 joysticks, one 6in1 card reader and one muvodrive, it all works.
And, it registers the device correctly it just can't read from it.

And yeah i know, it's part of the nvidia workaround:
cat /proc/interrupts
           CPU0
  0:   91522201          XT-PIC  timer
  1:      17141    IO-APIC-edge  i8042
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:     341508    IO-APIC-edge  ide0
 15:    1917703    IO-APIC-edge  ide1
177:          0   IO-APIC-level  ohci_hcd
185:          0   IO-APIC-level  ohci_hcd
193:     347701   IO-APIC-level  ehci_hcd
201:    4266340   IO-APIC-level  EMU10K1
209:    3869397   IO-APIC-level  eth0
217:   11455874   IO-APIC-level  nvidia
NMI:       8253
LOC:   91523920
ERR:          0
MIS:          0

hurrm ohci_hcd should have data... hurrrm, it might be LKML related
after all.. =3DP
(I might have left the experimental 'ohci' support in ehci on in this
kernel.)

> > What controller do you use? and what usb1.1 driver?
>=20
> I use a NEC controller with an OHCI for USB 1.1 stuff.

Heh ok=20

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-3wN1ey5yLEqO9emo46RS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUck57F3Euyc51N8RApIZAJ9TnIvj3sQvdIqlBNDOZ23ZK0VdbgCeOfrz
fw44yGpFs0lsmOrcAryPp3o=
=DYDq
-----END PGP SIGNATURE-----

--=-3wN1ey5yLEqO9emo46RS--
