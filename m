Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] more encoder stuff
Message-Id: <20041125071423.10e449c3.henryk@ploetzli.ch>
In-Reply-To: <41A56774.1000308@xmission.com>
References: <41A56774.1000308@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Nov_2004_07_14_23_+0100_SyaOx4ygr8CssDci"
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
Date: Thu, 25 Nov 2004 07:14:23 +0100

--Signature=_Thu__25_Nov_2004_07_14_23_+0100_SyaOx4ygr8CssDci
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 24 Nov 2004 22:02:44 -0700 schrieb Brad Midgley:

> Henryk, you were saying the reference encoder runs faster. Is there
> any chance they are using vector processing like sse/sse2? Do projects
> like xine and mplayer detect and use a vector processor through a
> library?

Nope, that was an error on my side. My file output was awfully slow. I
didn't test with large files since then, though. However, I_did_ profile
it and know that most of the encoding time is spent in sbc_analyze_audio
(no surprise there) in the matrixing, windowing and partial calculation
stages.

I just tested it again with a -O3 compiled sbcenc:

| time wine sbc_encoder.exe -o Uninvited.sbc Uninvited.wav
gives=20
| real    0m30.095s
| user    0m18.766s
| sys     0m0.686s

| time ./sbcenc Uninvited.au > Uninvited.sbc
gives
| real    0m36.539s
| user    0m27.200s
| sys     0m1.500s

That's not _too_ bad, especially since they are using dual channel while
we are using stereo (the latter gives smaller file size in this case).

By using CC=3Dicc CFLAGS=3D"-O3 -tpp7 -march=3Dpentium4" I can easily get it
down to
| real    0m19.122s
| user    0m11.272s
| sys     0m1.474s

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Thu__25_Nov_2004_07_14_23_+0100_SyaOx4ygr8CssDci
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpXhEIjWgKE0OA2gRAv2sAKCVb7PLld9Go92N4LSlNTnCVwQsOgCgqjbA
rhvz10LHbLBYk25XmIjYg1g=
=LjvX
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Nov_2004_07_14_23_+0100_SyaOx4ygr8CssDci--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
