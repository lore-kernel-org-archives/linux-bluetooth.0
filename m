Return-Path: <Olivier.Bornet@smartdata.ch>
Date: Tue, 6 Jan 2004 18:15:10 +0100
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Holler <holler@ahsoftware.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Success: switching the Logitech-Hub
Message-ID: <20040106171510.GE15149@smartdata.ch>
References: <9810000.1073197538@[192.168.207.2]> <1073267036.3804.4.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
In-Reply-To: <1073267036.3804.4.camel@pegasus>
Sender: Olivier Bornet <Olivier.Bornet@smartdata.ch>
List-ID: <bluez-devel.lists.sourceforge.net>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel and Alexander,

Great work. :-)

> > Bus 001 Device 004: ID 046d:c707 Logitech, Inc.
> > Bus 001 Device 003: ID 046d:c704 Logitech, Inc.

one of our device has an ID of 0x046d:0xc703. Can you add it to the
hid2hci.c file in the CVS ? I have tested it, and it works OK.

One question: I can't switch back to USB mode. Is this not supported at
this time ?

Good day.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+u0edj3R/MU9khgRAgdQAKDmK1qOIPYjySsVy/OoxqXy0kKcAACghAkG
015ttYsSlOLf3maDte6Skpk=
=+FQG
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
