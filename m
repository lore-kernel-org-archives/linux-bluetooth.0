Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041125060727.7b1bf533.henryk@ploetzli.ch>
In-Reply-To: <1101278049.27351.98.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
	<20041123074829.7f978ce7.henryk@ploetzli.ch>
	<1101201897.26578.54.camel@pegasus>
	<20041123204901.776fe240.henryk@ploetzli.ch>
	<1101243809.27351.18.camel@pegasus>
	<20041124042114.5e1fee94.henryk@ploetzli.ch>
	<1101272477.27351.67.camel@pegasus>
	<1101278049.27351.98.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Nov_2004_06_07_27_+0100_kINKfXflmgcvFqA6"
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
Date: Thu, 25 Nov 2004 06:07:27 +0100

--Signature=_Thu__25_Nov_2004_06_07_27_+0100_kINKfXflmgcvFqA6
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 24 Nov 2004 07:34:09 +0100 schrieb Marcel Holtmann:

> when using sbcenc in a pipe with rcplay I get a delay for the first
> bits of music that should be played. This is only on the first call of
> the program or after the kernel removed it from its cache. Do you have
> any idea what might causes this?

Hmm, don't know exactly what you mean. I know that there is a delay of
about 38 samples for 4 subbands (and I guess simply double that number
for 8 subbands), but that is inherent in SBC and can be seen in the
reference encoder/decoder, too.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Thu__25_Nov_2004_06_07_27_+0100_kINKfXflmgcvFqA6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpWiUIjWgKE0OA2gRAso/AKCurjfUV6PP2gSSwbtOJc8uT8ruzQCgkRSl
DmvmjgUhYYiNUDQPtyG0SNI=
=FyGG
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Nov_2004_06_07_27_+0100_kINKfXflmgcvFqA6--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
