Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: Adapters power management
Date: Mon, 24 Mar 2014 14:46:42 +0100
Message-ID: <6994105.2fQO4AGuyy@monsterbad>
In-Reply-To: <20140323150842.GB20404@t440s.P-661HNU-F1>
References: <2963801.adpd6n3SPJ@minibad> <1458063.fJ1RYS5iKm@minibad> <20140323150842.GB20404@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3419831.dl11bWj1PL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--nextPart3419831.dl11bWj1PL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 23 March 2014 17:08:42 Johan Hedberg wrote:
> > That bluez could implement something similar so when the application that
> > changed Adapter::powered to true exists the state is set back to false.
> 
> How would you suggest to make this work together with Bluetooth mice and
> keyboards that need to be connected or at least able to initiate
> connections on demand (when you press a button or move the mouse).
My idea was to enable Bluetooth for a few minutes after boot and resume so 
mouse/keyboard have a chance to connect at least on laptops (given that in 
that form factor you have the touchpad always present).
--nextPart3419831.dl11bWj1PL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTMDdGAAoJEGCsZ2zsJAWe6S4P+wY/ZEjg6V0xspLgeEHsEoqr
R5yacXRrLapUOl74Y6a7/vRER3fILQavFntV7Uf0UkAX4ZVXe1wATmc1Rok5V4d0
iy/BWH4m6E3KHesin8bBOTTVPa+33mNXsmoK8ErrYWnSAx/f0f66beiSFLfTMWP3
XbROjzuV3JutrRMT0TE7tgr+xknIvw9qwmNDNPe03vMAvipaFO2UrYAqP8AAJ3fV
tytgSra74xR/VeU70qcCpOhSRjOUA2gGGa0u1V7GOBvsM+Q/L8UOIxsgNkDafBIb
ZUXiyJwWuWsNj/Urt3ZEWF9nBhlGNig85ow6RKRPAaRk5zGiVfmdg36feoIwO3NH
mTGE6t2tiQ5R6SrDxtTDf/ciaVWbu7ZcDTYZYjI/f9NRU7aMMDDRGWxkbJLRukCe
Qti3IRMAMde6dXrlspYIfFbMfZsEoMiWxmRuJjc97FrD23bQZYOhSVJVrkyYHn8+
Iw1+5bo6ysFdJE5B1hj7U6aRNqbO9h5HNe12whxHI9nEYVYkeXzKU+q8CnJDxwEs
ZrHjmd7J80g4DMEFZCeYJLcYBndjXqt60W36Ffug7b5TVwCcLSZ2WAt+rD/JQw+y
qaDgal+a2hJwy71Svj3cazsPGKvjgMNcmzCDgRpNZh1x0HqWu/JB+5f76ngDFOs9
IdymeTOIRDoY38HtxEHO
=mGh/
-----END PGP SIGNATURE-----

--nextPart3419831.dl11bWj1PL--

