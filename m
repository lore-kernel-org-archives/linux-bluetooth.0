Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-4.61 fails to build if configured with
 "--disable-gstreamer --disable-alsa --enable-test"
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100307005005.GA15923@vigoh>
References: <20100307005005.GA15923@vigoh>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-dpaqDdfySQcyRoHVPG7u"
Date: Mon, 08 Mar 2010 14:57:34 +0100
Message-Id: <1268056654.7822.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-dpaqDdfySQcyRoHVPG7u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 06-03-2010 a las 21:50 -0300, Gustavo F. Padovan escribi=C3=B3=
:
> Hi Pacho,
>=20
> * Pacho Ramos <pacho@condmat1.ciencias.uniovi.es> [2010-03-06 19:14:35 +0=
100]:
>=20
> > It fails with:
> >   CC     test/ipctest.o
> >   CC     audio/ipc.o
> >   CCLD   test/ipctest
> > gcc: sbc/.libs/libsbc.a: No such file or directory
> > make[1]: *** [test/ipctest] Error 1
> > make: *** [all] Error 2
> >=20
> >=20
> > Also, other combinations (like --enable-services, --enable-audio...) ca=
n
> > end up with errors like:
> > libtool: link: x86_64-pc-linux-gnu-gcc -I/usr/include/dbus-1.0
> > -I/usr/lib64/dbus-1.0/include -I/usr/include/glib-2.0
> > -I/usr/lib64/glib-2.0/include -DBLUETOOTH_PLUGIN_BUILTIN
> > -DPLUGINDIR=3D\"/usr/lib64/bluetooth/plugins\" -O2 -march=3Dathlon64-ss=
e3
> > -mtune=3Dathlon64-sse3 -pipe -D_FORTIFY_SOURCE=3D2 -fPIC -Wl,-O1 -pie -=
o
> > test/ipctest test/ipctest.o audio/ipc.o  /usr/lib64/libglib-2.0.so
> > sbc/.libs/libsbc.a
> > test/ipctest.o: In function `set_conf':
> > ipctest.c:(.text+0x1462): undefined reference to `sbc_reinit'
> > ipctest.c:(.text+0x14af): undefined reference to `sbc_init'
> > ipctest.c:(.text+0x161b): undefined reference to `sbc_get_codesize'
> > collect2: ld returned 1 exit status
> > make[1]: *** [test/ipctest] Error 1
> > make: *** [all] Error 2
>=20
> Vinicius has a patch to fix this. Let's wait he send the patch to the
> mailing list.
>=20

Fine :-D

Thanks a lot for the information

--=-dpaqDdfySQcyRoHVPG7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuVAk4ACgkQCaWpQKGI+9QPvgCcDHrYTr8G9lF8jLQ24/Wnx82F
iZUAnjcViLVKswBVDuqfpRayAmWAfcET
=s0Ei
-----END PGP SIGNATURE-----

--=-dpaqDdfySQcyRoHVPG7u--

