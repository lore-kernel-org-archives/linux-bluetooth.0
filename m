Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
Message-Id: <20050501172156.0ab4ad2a.henryk@ploetzli.ch>
In-Reply-To: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__1_May_2005_17_21_56_+0200_CIJjcu6mYMpZOhI5"
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
Date: Sun, 1 May 2005 17:21:56 +0200

--Signature=_Sun__1_May_2005_17_21_56_+0200_CIJjcu6mYMpZOhI5
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 1 May 2005 13:43:48 +0100 (BST) schrieb Mayank Batra:

> The output is pretty well if we incorporate the proper
> endian type.

Ahh, so it works for you now? (I was not able to test it yet ...)

I hadn't thought of endianess all the way long. I was using big endian
for the .au file input (don't remember why) in the encoder and then
mostly consequently everywhere from there on.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__1_May_2005_17_21_56_+0200_CIJjcu6mYMpZOhI5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCdPQXIjWgKE0OA2gRAgoYAKDqNxx5f0pV2cOIk3SwHrEfI0K7MgCeKSH0
THzkwBjpMGJyd6VX0UhBAcc=
=ipVk
-----END PGP SIGNATURE-----

--Signature=_Sun__1_May_2005_17_21_56_+0200_CIJjcu6mYMpZOhI5--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
