Return-Path: <pomac@vapor.com>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095877744.6223.88.camel@pegasus>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cYgKq5ehe3/2dswM1COz"
Message-Id: <1095877955.3211.18.camel@big>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 20:32:35 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-cYgKq5ehe3/2dswM1COz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 20:29, Marcel Holtmann wrote:
> Hi Ian,
>=20
> > The problem is, this computer doesn't have a usb 1.1 port.
> > But it should basically fallback, and afair it worked with a cable
> > direct to the computer, i haven't tested that since... because i need
> > the hubs.
> >=20
> > But if it indeed is a usb 1.1  vs 2.0 problem then it has to be
> > something broken in the kernel... Anyone else using this with usb 2.0?
>=20
> this problem was reported two or three times, but I am unable to
> reproduce it with my USB 2.0 host controllers.

ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ohci_hcd 0000:00:02.1: irq 185, pci mem f8818000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3

What controller do you use? and what usb1.1 driver?

> Regards
>=20
> Marcel
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-cYgKq5ehe3/2dswM1COz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUcVD7F3Euyc51N8RAvWKAJ9Owvlbew8tn08Z2KwLY0mweuB5AQCguCig
mZGeI70QJxwZ3hog4/V0YgU=
=l9vG
-----END PGP SIGNATURE-----

--=-cYgKq5ehe3/2dswM1COz--
