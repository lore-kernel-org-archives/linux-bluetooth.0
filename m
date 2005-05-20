Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] libsbc optimizing
Message-Id: <20050521000412.1499f11e.henryk@ploetzli.ch>
In-Reply-To: <428BD03E.9000307@xmission.com>
References: <428BD03E.9000307@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__21_May_2005_00_04_12_+0200_/PdtGjIADm9tofHA"
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
Date: Sat, 21 May 2005 00:04:12 +0200

--Signature=_Sat__21_May_2005_00_04_12_+0200_/PdtGjIADm9tofHA
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 18 May 2005 17:31:10 -0600 schrieb Brad Midgley:

> Can I get help with the ranges for bits[ch][sb] in sbc_unpack_frame
> and  the state.* vectors if they're bounded?
>=20
> How about this first little patch?

This doesn't particularly aid readability so I'd suggest to keep the old
code in a comment to explain what it should do. Apart from that it looks
fine and you're doing some clever things. So if it improves performance,
go ahead.

I thought about it: Do you have long integers on that platform or will
they be slow too? Basically there should be no number greater than 2^16
anywhere (I'll have to check that, though) and we only need add,
multiply and shift.=20

A naive fixed point implementation would be to use a 32 bit integers and
shift the original value left 16 bits (multiplying by 2^16) leaving 16
bits before and 16 bits after the decimal point. Add and Shift will work
as usual, but for multiply additional 16 bits (e.g. an integer type with
at least 48 bits) are needed.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sat__21_May_2005_00_04_12_+0200_/PdtGjIADm9tofHA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCjl7iIjWgKE0OA2gRAvieAJ0dhLUAQcc3WVMHBXyltoltlJIacwCgyRU0
J9/UJkQl9TcOf6o5XgQfIjg=
=i/CB
-----END PGP SIGNATURE-----

--Signature=_Sat__21_May_2005_00_04_12_+0200_/PdtGjIADm9tofHA--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
