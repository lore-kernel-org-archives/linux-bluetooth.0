Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 15:56:20 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Subject: Building master on Debian systems fails at linking "check".
Message-Id: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__14_Nov_2011_15_56_20_+0100_/p7QC.SysGJ8V=wF"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__14_Nov_2011_15_56_20_+0100_/p7QC.SysGJ8V=wF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

building the master branch (a267bc2) on Debian systems fails when=20
linking the unit tests to the "check" library with this error:

  CCLD   unit/test-eir
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/4.6/../../../../lib/libcheck.a
(check.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be
used when making a shared object; recompile with
-fPIC /usr/lib/gcc/x86_64-linux-gnu/4.6/../../../../lib/libcheck.a:
could not read symbols: Bad value collect2: ld returned 1 exit status
make[1]: *** [unit/test-eir] Error 1 make: *** [all] Error 2


AFAIU this is a Debian quirk, the facts of the issue are more or less
these (please correct me if I am wrong):
  - libcheck.a, as per upstream default, is generally built with -fPIC
  - Debian policy tells that by default .a are not expected to be
    built with -fPIC, so they provide libcheck_pic.a as alternative
    instead.
  - BlueZ build system tries to dynamically link the unit tests to
    libcheck.a, but on Debian systems this is a non-PIC library and on
    X86_64 linking to non PIC as shared library is not allowed.

After a little bit of research I found out that gstreamer people also
had run into that issue and they have a m4 macro to pickup
libcheck_pic.a if present:

  http://cgit.freedesktop.org/gstreamer/common/tree/m4/check.m4

I have no idea if you BlueZ dev too want to handle this in-tree or
leave the burden to distributors.

The workaround I use for now is:
  - run "make" and let the build system fail
  - show the  failing command with "make V=3D1"
  - change -lcheck to -lcheck_pic and rerun the command
  - "make" will now proceed with the build

Regards,
   Antonio=20

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__14_Nov_2011_15_56_20_+0100_/p7QC.SysGJ8V=wF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7BLBQACgkQ5xr2akVTsAFZNwCffa+puzpqlwMjiwFykvGx7sS6
4CcAn0bMZbi1DPAXdILf+sOMNopHzCs/
=Fm5B
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Nov_2011_15_56_20_+0100_/p7QC.SysGJ8V=wF--
