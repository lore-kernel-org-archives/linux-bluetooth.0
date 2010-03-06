Return-Path: <cyrus@holtmann.org>
Subject: bluez-4.61 fails to build if configured with "--disable-gstreamer
 --disable-alsa --enable-test"
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ngnmF3DmMpXdSKl7HuWj"
Date: Sat, 06 Mar 2010 19:14:35 +0100
Message-Id: <1267899275.32038.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ngnmF3DmMpXdSKl7HuWj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

It fails with:
  CC     test/ipctest.o
  CC     audio/ipc.o
  CCLD   test/ipctest
gcc: sbc/.libs/libsbc.a: No such file or directory
make[1]: *** [test/ipctest] Error 1
make: *** [all] Error 2


Also, other combinations (like --enable-services, --enable-audio...) can
end up with errors like:
libtool: link: x86_64-pc-linux-gnu-gcc -I/usr/include/dbus-1.0
-I/usr/lib64/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -DBLUETOOTH_PLUGIN_BUILTIN
-DPLUGINDIR=3D\"/usr/lib64/bluetooth/plugins\" -O2 -march=3Dathlon64-sse3
-mtune=3Dathlon64-sse3 -pipe -D_FORTIFY_SOURCE=3D2 -fPIC -Wl,-O1 -pie -o
test/ipctest test/ipctest.o audio/ipc.o  /usr/lib64/libglib-2.0.so
sbc/.libs/libsbc.a
test/ipctest.o: In function `set_conf':
ipctest.c:(.text+0x1462): undefined reference to `sbc_reinit'
ipctest.c:(.text+0x14af): undefined reference to `sbc_init'
ipctest.c:(.text+0x161b): undefined reference to `sbc_get_codesize'
collect2: ld returned 1 exit status
make[1]: *** [test/ipctest] Error 1
make: *** [all] Error 2

Thanks a lot for your help

--=-ngnmF3DmMpXdSKl7HuWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuSm4sACgkQCaWpQKGI+9SVewCfejbqQQCTprOtV7rFa/BOJRGy
puUAn0+UCroenuCzumF9L9JAw3DTfIt0
=L9qq
-----END PGP SIGNATURE-----

--=-ngnmF3DmMpXdSKl7HuWj--

