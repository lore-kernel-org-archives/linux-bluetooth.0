Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Aug 2011 21:08:54 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
 linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell
 <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin
 Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>,
 Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko
 Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley
 <arcriley@gmail.com>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Message-Id: <20110819210854.81dff694ad455da3ed0e6e96@studenti.unina.it>
In-Reply-To: <20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
	<20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
	<1313709545.3373.196.camel@aeonflux>
	<20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_21_08_54_+0200_ssJ4iTv18qPhhZAm"
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__19_Aug_2011_21_08_54_+0200_ssJ4iTv18qPhhZAm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Aug 2011 10:58:02 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Thu, 18 Aug 2011 16:18:57 -0700
> Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
[...]
> >=20
> > I rather have the Sixaxis plugin being an external plugin only then. So
> > you are not allowed to make this builtin.
> >=20
>=20
> Marcel, I guess that an _external_ plugin in BlueZ context is one which
> is not embedded in the bluetoothd binary but rather distributed as a
> shared object, isn't it? Are there examples of such a plugin in bluez
> tree I can copy from?
>

OK, I think I've got it, it is external-dummy, this is how I did it:

---
 Makefile.am |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4bcff4d..ff33bf0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -230,8 +230,10 @@ builtin_sources +=3D thermometer/main.c \
 endif
=20
 if SIXAXISPLUGIN
-builtin_modules +=3D sixaxis
-builtin_sources +=3D plugins/sixaxis.c
+plugin_LTLIBRARIES +=3D plugins/sixaxis.la
+plugins_sixaxis_la_SOURCES =3D plugins/sixaxis.c
+plugins_sixaxis_la_LDFLAGS =3D -module -avoid-version -no-undefined @UDEV_=
LIBS@
+plugins_sixaxis_la_CFLAGS =3D -fvisibility=3Dhidden @DBUS_CFLAGS@ @GLIB_CF=
LAGS@ @UDEV_CFLAGS@
 endif
=20
 builtin_modules +=3D hciops mgmtops
@@ -300,7 +302,7 @@ src_bluetoothd_SOURCES =3D $(gdbus_sources) $(builtin_s=
ources) \
 			src/event.h src/event.c \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD =3D lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
-							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
+							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/bluetooth.ver
=20
@@ -415,7 +417,7 @@ EXTRA_DIST +=3D doc/manager-api.txt \
=20
 AM_YFLAGS =3D -d
=20
-AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ @UDEV_CFLAGS@ \
+AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
 		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=3D\""$(plugindir)"\"
=20
 INCLUDES =3D -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
--=20
1.7.5.4

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_21_08_54_+0200_ssJ4iTv18qPhhZAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5OtMYACgkQ5xr2akVTsAEklgCfZBcJ18o21auvJsbuWaFetIHy
wx0AoKPZOzt+d4drhj/PSWzQziY4hb5R
=M5bv
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_21_08_54_+0200_ssJ4iTv18qPhhZAm--
