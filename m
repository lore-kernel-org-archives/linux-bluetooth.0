Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Elimination of pow() in SBC code
Message-Id: <20041128025750.00e11da4.henryk@ploetzli.ch>
In-Reply-To: <1101599506.18467.6.camel@pegasus>
References: <1101599506.18467.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__28_Nov_2004_02_57_50_+0100_9iyCupMCKcAVnvUu"
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
Date: Sun, 28 Nov 2004 02:57:50 +0100

--Signature=_Sun__28_Nov_2004_02_57_50_+0100_9iyCupMCKcAVnvUu
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 28 Nov 2004 00:51:46 +0100 schrieb Marcel Holtmann:

> the pow() function is the only reason for linking with -lm and it is
> only used in one place with a limit range of parameters.

Oh yes, that occurence of pow(2.0, x) is in older code I forgot about.
(And before -lm was necessary for cos(), too)

> So what is the range of scale_factor[ch][sb]. From a quick testing a
> saw that it ranges from 0 - 15. Is this always true?=20

Yes, scale_factor is a 4 bit integer (Table 12.13 of A2DP) and there
should be no way of getting it bigger. If there was this would be a bug.

> If yes, then I would use a pre-calculated array for 2^x.

Isn't 1<<x good enough for that?

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__28_Nov_2004_02_57_50_+0100_9iyCupMCKcAVnvUu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBqTCiIjWgKE0OA2gRApq9AJ447miqy2GNRC4+a3jUX9vqqpf0LwCfa6fM
YerNSHG+aQwCicilLN4/A6E=
=OW1X
-----END PGP SIGNATURE-----

--Signature=_Sun__28_Nov_2004_02_57_50_+0100_9iyCupMCKcAVnvUu--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
