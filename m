Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_8B2B1773-6BA2-4BC3-A4B9-0A1018413B42"; protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: BLE connection failing
From: Rick Mann <rmann@latencyzero.com>
In-Reply-To: <9ED33F2C-C3EF-41D7-8559-C04F1E6CE21D@holtmann.org>
Date: Mon, 12 May 2014 18:32:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7E32DBFD-3A61-4126-8B8F-71E1E3D395EB@latencyzero.com>
References: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com> <9ED33F2C-C3EF-41D7-8559-C04F1E6CE21D@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_8B2B1773-6BA2-4BC3-A4B9-0A1018413B42
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On May 12, 2014, at 18:27 , Marcel Holtmann <marcel@holtmann.org> wrote:

> kernel 3.13 and later have support for Set Advertising mgmt command. =
That is what you should be using. Just issue =93btmgmt advertising on=94.

Unfortunately, I can't. We're stuck with the 3.10 kernel. I turn on =
advertising with hciconfig hci0 leadv. Advertising is not the problem =
though, as you can see.


--=20
Rick




--Apple-Mail=_8B2B1773-6BA2-4BC3-A4B9-0A1018413B42
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNxdiYACgkQBzBA/9aDmJsOogCbBu6GxiZODVrCeTx7wQK+/ziW
TbYAn0AElq5+jxjQ40hvTSc2ga3l7yBR
=8TBj
-----END PGP SIGNATURE-----

--Apple-Mail=_8B2B1773-6BA2-4BC3-A4B9-0A1018413B42--
