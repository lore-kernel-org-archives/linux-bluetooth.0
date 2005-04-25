Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP sink code finally
Message-Id: <20050425080812.41cf1fab.henryk@ploetzli.ch>
In-Reply-To: <426C62D4.80009@xmission.com>
References: <20050424150930.71134.qmail@web8308.mail.in.yahoo.com>
	<426C62D4.80009@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__25_Apr_2005_08_08_12_+0200_gXRlJ0DzgG41velB"
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
Date: Mon, 25 Apr 2005 08:08:12 +0200

--Signature=_Mon__25_Apr_2005_08_08_12_+0200_gXRlJ0DzgG41velB
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 24 Apr 2005 21:24:04 -0600 schrieb Brad Midgley:

> Thanks for the submission. I corrected some warnings, disabled unused=20
> functions, and added it to Makefile.am.

Ah, thanks.

> We definitely need to do a lot of cleanup (eg now that a2play and
> a2snk  have so much duplication), but first off we need to see why
> audio is  being distorted...

Hmm, how do I test that? I can't seem to get my audio dongle to connect.
Is there anything else I've got to do apart from=20
| hciconfig hci0 class 0x200404
| sdptool add A2SNK
| ./a2snk
?

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__25_Apr_2005_08_08_12_+0200_gXRlJ0DzgG41velB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCbIlQIjWgKE0OA2gRAhGUAKDIycUjHniSgisIKhwfWnE2GPdXEgCfUMv9
4mhgc7gG4ldoIGKBq5cz93A=
=/hse
-----END PGP SIGNATURE-----

--Signature=_Mon__25_Apr_2005_08_08_12_+0200_gXRlJ0DzgG41velB--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
