Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Aug 2011 12:44:38 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>,
	Arc Riley <arcriley@gmail.com>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Message-Id: <20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
In-Reply-To: <1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__18_Aug_2011_12_44_38_+0200_3qxGy/lkHRZXFdJw"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Thu__18_Aug_2011_12_44_38_+0200_3qxGy/lkHRZXFdJw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Aug 2011 16:09:17 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Don't link bluetoothd to udev unconditionally, but only when it is
> needed. For now bluetoothd needs to be linked to udev only when the
> sixaxis plugin is enabled.

Any comment on this change? If it looks OK I'll fold it in v5.

Thanks,
   Antonio

> ---
>  Makefile.am |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index dbe0170..219ca0f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -288,7 +288,11 @@ src_bluetoothd_SOURCES =3D $(gdbus_sources) $(builti=
n_sources) \
>  			src/event.h src/event.c \
>  			src/oob.h src/oob.c src/eir.h src/eir.c
>  src_bluetoothd_LDADD =3D lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
> -							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
> +							@CAPNG_LIBS@ -ldl -lrt
> +if SIXAXISPLUGIN
> +src_bluetoothd_LDADD +=3D @UDEV_LIBS@
> +endif
> +
>  src_bluetoothd_LDFLAGS =3D -Wl,--export-dynamic \
>  				-Wl,--version-script=3D$(srcdir)/src/bluetooth.ver
> =20
> --=20
> 1.7.5.4
>=20
>=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__18_Aug_2011_12_44_38_+0200_3qxGy/lkHRZXFdJw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5M7RYACgkQ5xr2akVTsAEOxQCgqS9pcvbvXYD2hMqtXAZzXafL
AdUAoIVo+eZvMDyDvq4BxWsTxdsJMzDf
=4y5C
-----END PGP SIGNATURE-----

--Signature=_Thu__18_Aug_2011_12_44_38_+0200_3qxGy/lkHRZXFdJw--
