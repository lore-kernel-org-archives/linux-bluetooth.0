Return-Path: <pomac@vapor.com>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095879167.6223.104.camel@pegasus>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>  <1095878303.6223.93.camel@pegasus>
	 <1095878969.3211.23.camel@big>  <1095879167.6223.104.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g1clS8S/nBwxFaCYsSBD"
Message-Id: <1095880805.3277.4.camel@big>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 21:20:05 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-g1clS8S/nBwxFaCYsSBD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 20:52, Marcel Holtmann wrote:
> > 2 joysticks, one 6in1 card reader and one muvodrive, it all works.
> > And, it registers the device correctly it just can't read from it.
>=20
> are these devices all USB 2.0 capable? If yes, then they are handled by
> the ehci_hcd host controller driver.

All except the monitor that also registers it self via usb, =3D)
(I am really surprised about that actually)

Sam Sung Electronics
Manufacturer: Samsung Electronics
Serial Number: HVAWA04398
Speed: 1.5Mb/s (low)
USB Version:  1.10
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 8
Number of Configurations: 1
Vendor Id: 0419
Product Id: 8002
Revision Number:  2.00

And here is the usb dongle output
hci_usb
Speed: 12Mb/s (full)
USB Version:  1.10
Device Class: e0(unk. ) <=3D=3D Looks like something missing
Device Subclass: 01
Device Protocol: 01
Maximum Default Endpoint Size: 64
Number of Configurations: 1
Vendor Id: 0db0
Product Id: 1967
Revision Number:  5.25

Should i change some identifier and test some?

> Check that first and then report it to the Linux USB mailing list. It is
> more an USB issue then LKML related.

yep... Assumed, i just assumed that some small thing might be broken and
that you usb ppl would be quicker to spot it =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-g1clS8S/nBwxFaCYsSBD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUdBk7F3Euyc51N8RAgFQAJ90CqfjhJJapXl4VIKj5ObGzJ/08QCeKG5s
LJ+1oxKFTIpCgpaxd+ORgGM=
=gfO2
-----END PGP SIGNATURE-----

--=-g1clS8S/nBwxFaCYsSBD--
