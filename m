Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
Message-Id: <20041126045659.6a3291f5.henryk@ploetzli.ch>
In-Reply-To: <1101440449.6465.64.camel@pegasus>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
	<20041125112509.75347786.henryk@ploetzli.ch>
	<20041125105615.GA19821@snoopy.src.ricoh.co.jp>
	<1101440449.6465.64.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__26_Nov_2004_04_56_59_+0100_F0PeclmoEXMH=W1E"
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
Date: Fri, 26 Nov 2004 04:56:59 +0100

--Signature=_Fri__26_Nov_2004_04_56_59_+0100_F0PeclmoEXMH=W1E
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Fri, 26 Nov 2004 04:40:49 +0100 schrieb Marcel Holtmann:

> For me it is not clear if we have to set them, ignore them or what to
> do with them. Do we have to insert the content protection header in
> the media payload if these capability is present?

Obviously we may only insert the content protection header if we request
content protection during set configuration. However, I don't remember
any document requiring us to do that. I think Content protection is
completely optional and we would only use that if we were a paranoid
Sony device that believed everybody else on the planet was after us to
steal our music.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Fri__26_Nov_2004_04_56_59_+0100_F0PeclmoEXMH=W1E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpqmQIjWgKE0OA2gRAleCAJ47hhnqpYCLumePiY6n32Vjl5UUmACfeHwo
jEoyydMwZaDDcmFXVgd3pio=
=BLo6
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Nov_2004_04_56_59_+0100_F0PeclmoEXMH=W1E--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
