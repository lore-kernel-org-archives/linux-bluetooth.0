Return-Path: <cyrus@holtmann.org>
Subject: obexd-0.21: configure doesn't work as expected
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FMzcuKC3rxSgNUR6g+UC"
Date: Fri, 19 Feb 2010 12:13:48 +0100
Message-Id: <1266578028.5249.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-FMzcuKC3rxSgNUR6g+UC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello all!

The problem we are suffering downstream is the following:
http://bugs.gentoo.org/show_bug.cgi?id=3D305063#c5

In summary, the same files are being *installed* with
--with-phonebook=3Debook and --with-phonebook=3Ddummy (in both cases,
phonebook files are not being installed at all). A
$PREFIX/lib/obex/plugins directory is created but nothing is installed
on it.

Another problem is that, when passing --without-phonebook to configure,
build fails with:
$ make
make --no-print-directory all-am
  CC     gdbus/mainloop.o
  CC     gdbus/object.o
  CC     gdbus/watch.o
  CC     plugins/filesystem.o
  CC     plugins/opp.o
  CC     plugins/ftp.o
  CC     plugins/pbap.o
  CC     plugins/syncevolution.o
  CC     src/main.o
  GEN    src/builtin.h
  CC     src/plugin.o
  CC     src/logging.o
  CC     src/btio.o
  CC     src/manager.o
  CC     src/obex.o
  CC     src/bluetooth.o
  CC     src/mimetype.o
  CC     src/service.o
make[1]: *** No rule to make target `plugins/phonebook-no.c', needed by
`plugins/phonebook.c'.  Stop.
make: *** [all] Error 2


Thanks a lot for your help :-)

--=-FMzcuKC3rxSgNUR6g+UC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt+cmwACgkQCaWpQKGI+9S1UwCeKYd4E7iEPVEN0FNvBAA0moqR
2eYAn3mEBvwKPWFnutWGYSBQRQehWlDR
=AHa/
-----END PGP SIGNATURE-----

--=-FMzcuKC3rxSgNUR6g+UC--

