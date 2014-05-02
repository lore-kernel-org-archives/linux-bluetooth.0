Return-Path: <cyrus@holtmann.org>
From: Rick Mann <rmann@latencyzero.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_0785BEFD-F01D-45BC-AF5A-E4A34D4D2190"; protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: Getting started with BLE device
Message-Id: <35E2DFE7-B463-4A15-8148-F7E30A201646@latencyzero.com>
Date: Thu, 1 May 2014 19:59:32 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_0785BEFD-F01D-45BC-AF5A-E4A34D4D2190
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

We've been building a product with a different BLE module. Today we got =
our new hardware that uses a TiWi-BLE module and BlueZ (under Ubuntu =
12.04 and 14.04), and I'm looking for documentation on how to get =
started with it. I can't seem to find a good starting point.

The Ubuntu image we have (it came from our board designer) has a bunch =
of commands installed, like bluez-test-adapter, bluez-test-service, etc. =
But when I try to execute bluez-test-adapter (as root), I just get dbus =
errors:

	dbus.exceptions.DBusException: org.bluez.Error.NoSuchAdapter: No =
such adapter=20

Some other attempts, including hciconfig and python =
/usr/share/doc/bluez/examples/list-devices, show no devices. I'm not =
sure what a device looks like (is it /dev/something?). It's possible our =
kernel isn't properly configured. But I can't find any docs that show me =
how to start.

The end goal is to configure this device to be a Bluetooth LE server.

I'd greatly appreciate some guidance as to where to go next. Thanks!

--=20
Rick




--Apple-Mail=_0785BEFD-F01D-45BC-AF5A-E4A34D4D2190
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNjChQACgkQBzBA/9aDmJshpACguammuXp9XZmFoyP2Y+jn1lU8
SrcAoIWGC2M6II6p2F/ERWlo+hyx9L4M
=lPzE
-----END PGP SIGNATURE-----

--Apple-Mail=_0785BEFD-F01D-45BC-AF5A-E4A34D4D2190--
