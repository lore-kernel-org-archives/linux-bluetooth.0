Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: =?ISO-8859-1?Q?M=EDla?= Kuchta <kuchta@geeks.cz>
To: bluez-users@lists.sourceforge.net
Date: Mon, 10 Dec 2007 16:08:39 +0100
Message-Id: <1197299329.5651.6.camel@intel>
Mime-Version: 1.0
Subject: [Bluez-users] Usage of network service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1229257753=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1229257753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zqrPsIY6AsTqk7chmVHy"


--=-zqrPsIY6AsTqk7chmVHy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I've been using bluetooth PAN using pand daemon. Pand runs as a daemon
and used to create network interface on demand calling dev-up and
dev-down script which in turn runs ifup and ifdown to setup the device.

In newer version of bluez, it's preffered to use network service, but I
haven't found any documentation describing the process of creating and
setting up the device.

It is right that network service creates device and calls upon them
ifup/ifdown or does some dbus (HAL, NetworkManager) magic?

Regards

Mila

--=-zqrPsIY6AsTqk7chmVHy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXVZ2B/h+xQ5W7PoRAixuAJ90ucadSqS1+acSNBgXSRyYdNGLZwCfZS9c
VyK1f+/yKiO3G3qKF//Wf10=
=veyv
-----END PGP SIGNATURE-----

--=-zqrPsIY6AsTqk7chmVHy--



--===============1229257753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1229257753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1229257753==--
