Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041125060213.4c8c34d5.henryk@ploetzli.ch>
In-Reply-To: <1101350953.7538.22.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
	<20041123074829.7f978ce7.henryk@ploetzli.ch>
	<1101201897.26578.54.camel@pegasus>
	<20041123204901.776fe240.henryk@ploetzli.ch>
	<1101243809.27351.18.camel@pegasus>
	<20041124042114.5e1fee94.henryk@ploetzli.ch>
	<1101272477.27351.67.camel@pegasus>
	<41A43E8A.8030602@xmission.com>
	<1101307146.27351.104.camel@pegasus>
	<20041124213730.46aefcb7.henryk@ploetzli.ch>
	<1101350953.7538.22.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Nov_2004_06_02_13_+0100_CfQBpBZzvNvse62D"
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
Date: Thu, 25 Nov 2004 06:02:13 +0100

--Signature=_Thu__25_Nov_2004_06_02_13_+0100_CfQBpBZzvNvse62D
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 25 Nov 2004 03:49:13 +0100 schrieb Marcel Holtmann:

> maybe you wanna try:
>=20
> 	mpg321 --au /dev/stdout foo.mp3 | sbcenc - | a2play <bdaddr> -

That works fine, too, and is a lot less to type, thanks. But now the 100
Million Dollar question: When a2play is streaming my Microsoft Wireless
IntelliMouse Explorer for Bluetooth can't connect to the hidd. And vice
versa: If the mouse is connected a2play won't stream.

Is this expected? Can it be fixed?

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Thu__25_Nov_2004_06_02_13_+0100_CfQBpBZzvNvse62D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpWdaIjWgKE0OA2gRAmKyAKCDv2bEnjxK4ZRoauovrB5ziomcRQCgqX1y
P/QfgGVr8b1JUDOh5n9lL/8=
=vrhr
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Nov_2004_06_02_13_+0100_CfQBpBZzvNvse62D--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
