Return-Path: <cyrus@holtmann.org>
From: Rick Mann <rmann@latencyzero.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_836AFB03-18EA-4BCB-8BD7-F4095E16175A"; protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: Problems enabling GATT
Message-Id: <B45316ED-3A52-4411-B5B6-4C9BE9E8116D@latencyzero.com>
Date: Tue, 6 May 2014 14:05:34 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_836AFB03-18EA-4BCB-8BD7-F4095E16175A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

BlueZ 4.101
Ubuntu 13.09

If I modify /etc/bluetooth/main.conf and change EnableGatt to true, then =
run bluetoothd, I get

=95 bluetoothd[1170]: plugins/dbusoob.c:dbusoob_init() Setup dbusoob =
plugin
=95 bluetoothd[1170]: Not enough free handles to register service

I'm also seeing

=95 bluetoothd[1170]: src/main.c:parse_config() Key file does not have =
key 'DeviceID'

In the end, I need to create a Bluetooth peripheral that advertises a =
set of services and a number of characteristics.

You can see the full output here: http://pastebin.com/M5vAh8x3

Is there something else I need to do to enable BLE? I'm also trying to =
add

EnableLE =3D true
AttributeServer =3D true

But they seem to have no effect.

--=20
Rick




--Apple-Mail=_836AFB03-18EA-4BCB-8BD7-F4095E16175A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNpTp4ACgkQBzBA/9aDmJsFiwCfd+DBNtyCRf84INRg0T1O+ptG
o+4AnRL7in9R8AqeoOC/EbvzeDPLNXzJ
=/7eg
-----END PGP SIGNATURE-----

--Apple-Mail=_836AFB03-18EA-4BCB-8BD7-F4095E16175A--
