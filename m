Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041124042114.5e1fee94.henryk@ploetzli.ch>
In-Reply-To: <1101243809.27351.18.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
	<20041123074829.7f978ce7.henryk@ploetzli.ch>
	<1101201897.26578.54.camel@pegasus>
	<20041123204901.776fe240.henryk@ploetzli.ch>
	<1101243809.27351.18.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__24_Nov_2004_04_21_14_+0100_bfjNdp+PnoaMbvW8"
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
Date: Wed, 24 Nov 2004 04:21:14 +0100

--Signature=_Wed__24_Nov_2004_04_21_14_+0100_bfjNdp+PnoaMbvW8
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 23 Nov 2004 22:03:29 +0100 schrieb Marcel Holtmann:

> this actually reminds me again that I am not an audio expert. Can you
> fix it easily?

Yupp, I think I did.

> I like to keep them as sbcenc and sbcdec, because this is what they
> are doing. The output to a soundcard is a nice extra feature of sbcdec
> and if sbcenc can capture from a soundcard this will be also great.=20

Ok, sounds reasonable to me.

> The choose for libao was, because mpg321 uses it and its API is very
> easy. The possibility for writing to a file and playing on a soundcard
> with the same set of functions was also a plus. However I don't know
> what's the best audio library nowadays. So any comments about that are
> welcome.

Neither do I. I just put "audio file library" into the search at
freshmeat and it came up with that audio file library. The main reason
why I'd like to use that is that it supports reading of audio files.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Wed__24_Nov_2004_04_21_14_+0100_bfjNdp+PnoaMbvW8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBo/4uIjWgKE0OA2gRAqXoAJ0TRl+TTgV/2QLjP651Av/8l2Rm3wCgkb0s
MM22I5xzNTYLyzmih/+i8QE=
=9M/C
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Nov_2004_04_21_14_+0100_bfjNdp+PnoaMbvW8--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
