Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Aug 2011 21:57:16 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Alan Ott <alan@signal11.us>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>,
	Arc Riley <arcriley@gmail.com>
Subject: Re: [PATCH BlueZ 2/4] Add sixaxis plugin: USB pairing and LEDs
 settings
Message-Id: <20110819215716.71f6b39d3b5e783c4276f422@studenti.unina.it>
In-Reply-To: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-3-git-send-email-ospite@studenti.unina.it>
	<4E41EBE5.7040908@signal11.us>
	<20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Aug 2011 16:13:57 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

[...]
> If the idea looks OK I'll fold those patches in v5, along with the
> plugin renaming to "sony-controller", and maybe I'll split the plugin in
> several modules too:
>   sony-controller.c 	/* udev and bluez stuff */
>   sony-controller-hid.c	/* hidraw and device specific stuff */
>   sony-controlled-hid.h
>=20

Do you think "controller" fits the PS3 headset as well?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5OwBwACgkQ5xr2akVTsAHafwCgj1Aa2Nf1nIuN0zEB/9AX/NP3
XSwAnR76LfIbBagoqN7NwTMYUfNOg3wy
=lnyT
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9--
