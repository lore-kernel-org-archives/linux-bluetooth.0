Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] more encoder stuff
Message-Id: <20041126000655.1a762210.henryk@ploetzli.ch>
In-Reply-To: <1101365484.7538.74.camel@pegasus>
References: <41A56774.1000308@xmission.com>
	<20041125071423.10e449c3.henryk@ploetzli.ch>
	<1101365484.7538.74.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__26_Nov_2004_00_06_55_+0100_GZtiHJpqwx=fBx/j"
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
Date: Fri, 26 Nov 2004 00:06:55 +0100

--Signature=_Fri__26_Nov_2004_00_06_55_+0100_GZtiHJpqwx=fBx/j
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 25 Nov 2004 07:51:24 +0100 schrieb Marcel Holtmann:

> The MAD library (www.underbit.com/products/mad/) is using fixed-point
> integer computation. Do you think it is possible to do the same thing
> for SBC? Will it give us some extra performance?

Unfortunately I'm not familiar with fixed-point arithmetics, especially
with how to handle multiplication. So if anyone who has done this before
would step forward ...

Well, I did some naive tests: I probably did something wrong, but I'm
not seeing any significant difference between floating point and fixed
point (that is: integer). For multiplication the difference is not
noticeable (1.38s vs. 1.36s in my test program) and for addition it is
not that big (0.77s vs. 0.47s).

I guess we'll be fine using floating point as long as there is an FPU.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Fri__26_Nov_2004_00_06_55_+0100_GZtiHJpqwx=fBx/j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpmWTIjWgKE0OA2gRApBoAKCEVD0AxvCa1UTzLFt4HI2HDxzkWQCfWmX8
OIRHinW2MnhdLlmGEWnLIIE=
=cGdz
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Nov_2004_00_06_55_+0100_GZtiHJpqwx=fBx/j--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
