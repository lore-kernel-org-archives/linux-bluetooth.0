Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: # =?ISO-8859-1?Q?Bj=F6rn?= Specht # <bspecht@gmx.net>
To: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Message-ID: <20050209140701.2cf50710@CleverSophie>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__9_Feb_2005_14_07_01_+0100_W6PeIE=0HKB+__cu";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: [Bluez-devel] btohs,btohl, ...
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 9 Feb 2005 14:07:01 +0100

--Signature_Wed__9_Feb_2005_14_07_01_+0100_W6PeIE=0HKB+__cu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I implemented a client server over bluetooth and I was wondering if I need =
the Little Endian, Big Endien conversion functions btohs,btohl,htobs,htobl?

Do I need to convert every single byte? which is received or sent over my s=
ock_stream socket?
If yes, should it look like this for the receiving case: btohs(buf[0]).... =
an so on for every byte?

Thanks in advance=20
Bj=F6rn

--Signature_Wed__9_Feb_2005_14_07_01_+0100_W6PeIE=0HKB+__cu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCCgr2rdSygrmIeLARAl4yAJ98AHNb8tDJnpD32n60KzZZ2ku2pQCeJPoC
wsCVKR04jeUj7Ig7AQgJnqY=
=J+uM
-----END PGP SIGNATURE-----

--Signature_Wed__9_Feb_2005_14_07_01_+0100_W6PeIE=0HKB+__cu--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
