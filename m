Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
Message-Id: <20041125060857.22178e80.henryk@ploetzli.ch>
In-Reply-To: <1101272951.27351.76.camel@pegasus>
References: <41A22C0B.4050008@xmission.com>
	<41A234FA.7020303@xmission.com>
	<20041123033429.132bf84b.henryk@ploetzli.ch>
	<41A2B331.4010001@xmission.com>
	<20041123070621.50569968.henryk@ploetzli.ch>
	<41A3471C.4000602@xmission.com>
	<20041123203836.046fb4f4.henryk@ploetzli.ch>
	<41A3ACE2.4030501@xmission.com>
	<1101246735.27351.45.camel@pegasus>
	<41A3FD27.6060400@xmission.com>
	<1101272951.27351.76.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Nov_2004_06_08_57_+0100_4QVtRO/=merfDXIw"
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
Date: Thu, 25 Nov 2004 06:08:57 +0100

--Signature=_Thu__25_Nov_2004_06_08_57_+0100_4QVtRO/=merfDXIw
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Wed, 24 Nov 2004 06:09:11 +0100 schrieb Marcel Holtmann:

> I also don't see any reason why we need to store a SBC configuration
> and then submit the same values with every frame. However without the
> header it is impossible to get the SBC frame size.

Because we're allowed to change the bitpool value, I guess. The current
value can then always be read from the header. And of course to ease
resynchronization.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Thu__25_Nov_2004_06_08_57_+0100_4QVtRO/=merfDXIw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpWjtIjWgKE0OA2gRAs6wAJ4x3fUGwt0ts8Yq7aNQ70zKo9E1xgCg5fWm
VnSC7ymtokJFpniGl4it9vg=
=Yffn
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Nov_2004_06_08_57_+0100_4QVtRO/=merfDXIw--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
