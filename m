Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC code cleanup
Message-Id: <20041128053245.4608f749.henryk@ploetzli.ch>
In-Reply-To: <1101592165.27074.31.camel@pegasus>
References: <1101592165.27074.31.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__28_Nov_2004_05_32_45_+0100_kHXpQTdShDHp9lvx"
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
Date: Sun, 28 Nov 2004 05:32:45 +0100

--Signature=_Sun__28_Nov_2004_05_32_45_+0100_kHXpQTdShDHp9lvx
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sat, 27 Nov 2004 22:49:25 +0100 schrieb Marcel Holtmann:

> I started with some cleaning up of the SBC code to better fit into
> current coding conventions. My focus was on the sbc_synthesize_audio()
> and sbc_analyze_audio() functions.=20

I saw that and you're doing a good job there. I also saw that you
registered sf.net/projects/sbc.

> -       for (i =3D 0; i < 7; i++)
> +       for (i =3D 0; i < 8; i++)

> Am I right, or do I miss something?

No, you're absolutely right. Actually the decoder is broken currently
(I swear it worked when I checked in rev 1.8 of sbclib.c). I'm
investigating...

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__28_Nov_2004_05_32_45_+0100_kHXpQTdShDHp9lvx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBqVTxIjWgKE0OA2gRAvSMAJ9otVBPbeM/8dyEEweyCaR2s/S3mQCfYJHc
iNZ929izpYEiVkAh5WMSrLc=
=LYy4
-----END PGP SIGNATURE-----

--Signature=_Sun__28_Nov_2004_05_32_45_+0100_kHXpQTdShDHp9lvx--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
