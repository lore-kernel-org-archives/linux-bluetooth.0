Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix inconsistencies in the build system
From: Tiziano =?ISO-8859-1?Q?M=FCller?= <dev-zero@gentoo.org>
Reply-To: dev-zero@gentoo.org
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-VG57EokuqmWnwH6LOE7I"
Date: Tue, 07 Apr 2009 09:39:06 +0200
Message-Id: <1239089946.7320.17.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-VG57EokuqmWnwH6LOE7I
Content-Type: multipart/mixed; boundary="=-pI5qvqOLq0FnAgzvZfOJ"


--=-pI5qvqOLq0FnAgzvZfOJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

There are some minor inconsistencies in the build system:
a) If --disable-{alsa,gstreamer} are given on configure LIBSBC doesn't
get built. Even though SBC_CFLAGS and SBC_LIBS get substituted in the
Makefile and therefore libsbc.la ends up in the link-list for libipc
which then fails.
b) ipctest needs libipc and libsbc but gets built unconditionally in
audio/Makefile.am.

The attached patch fixes that.

Cheers,
Tiziano


--=-pI5qvqOLq0FnAgzvZfOJ
Content-Disposition: attachment; filename="4.34-conditional_libsbc.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="4.34-conditional_libsbc.patch"; charset="UTF-8"

VGhlIGNvbmZpZ3VyZSBzdHVmZiBpcyBhIGluY29uc2VxdWVudDoNCi0gZXZlbiBpZiBuZWl0aGVy
IGFsc2Egbm9yIGdzdHJlYW1lciBzdXBwb3J0IGlzIGVuYWJsZWQsIFNCQ19MSUJTIGdldHMgc3Vi
c3RpdHV0ZWQgYnkgbGlic2JjLmxhDQogIHdoaWNoIGRvZXNuJ3QgZ2V0IGJ1aWxkIHdpdGhvdXQg
YWxzYSBvciBnc3RyZWFtZXIuIE1ha2luZyB0aGlzIGNvbmRpdGlvbmFsIGhlbHBzLg0KLSBpcGN0
ZXN0IG5lZWRzIGJvdGggbGliaXBjLmxhIGFuZCBsaWJzYmMubGEgYW5kIGZhaWxzIGlmIFNCQ19M
SUJTL1NCQ19DRkxBR1MgYXJlIGVtcHR5LA0KICBtYWtpbmcgdGhlIGJ1aWxkIGNvbmRpdGlvbmFs
IGhlbHBzIGFnYWluLg0KLS0tIGFjaW5jbHVkZS5tNC5vcmlnCTIwMDktMDQtMDYgMTY6MjY6MTQu
NTcwNzgwMjQxICswMjAwDQorKysgYWNpbmNsdWRlLm00CTIwMDktMDQtMDYgMTY6MjY6NTkuNTQw
Nzc5MTQ4ICswMjAwDQpAQCAtMzMwLDggKzMzMCwxMCBAQA0KIAlBQ19TVUJTVChbR0RCVVNfQ0ZM
QUdTXSwgWyctSSQodG9wX3NyY2RpcikvZ2RidXMnXSkNCiAJQUNfU1VCU1QoW0dEQlVTX0xJQlNd
LCBbJyQodG9wX2J1aWxkZGlyKS9nZGJ1cy9saWJnZGJ1cy5sYSddKQ0KIA0KLQlBQ19TVUJTVChb
U0JDX0NGTEFHU10sIFsnLUkkKHRvcF9zcmNkaXIpL3NiYyddKQ0KLQlBQ19TVUJTVChbU0JDX0xJ
QlNdLCBbJyQodG9wX2J1aWxkZGlyKS9zYmMvbGlic2JjLmxhJ10pDQorCWlmICh0ZXN0ICIke2Fs
c2FfZW5hYmxlfSIgPSAieWVzIiB8fCB0ZXN0ICIke2dzdHJlYW1lcl9lbmFibGV9IiA9ICJ5ZXMi
KTsgdGhlbg0KKwkJQUNfU1VCU1QoW1NCQ19DRkxBR1NdLCBbJy1JJCh0b3Bfc3JjZGlyKS9zYmMn
XSkNCisJCUFDX1NVQlNUKFtTQkNfTElCU10sIFsnJCh0b3BfYnVpbGRkaXIpL3NiYy9saWJzYmMu
bGEnXSkNCisJZmkNCiANCiAJQU1fQ09ORElUSU9OQUwoU05ERklMRSwgdGVzdCAiJHtzbmRmaWxl
X2VuYWJsZX0iID0gInllcyIgJiYgdGVzdCAiJHtzbmRmaWxlX2ZvdW5kfSIgPSAieWVzIikNCiAJ
QU1fQ09ORElUSU9OQUwoTkVUTElOSywgdGVzdCAiJHtuZXRsaW5rX2VuYWJsZX0iID0gInllcyIg
JiYgdGVzdCAiJHtuZXRsaW5rX2ZvdW5kfSIgPSAieWVzIikNCi0tLSBhdWRpby9NYWtlZmlsZS5h
bS5vcmlnCTIwMDktMDQtMDYgMTY6NDc6MjEuMjQwNjgxMjcyICswMjAwDQorKysgYXVkaW8vTWFr
ZWZpbGUuYW0JMjAwOS0wNC0wNiAxNzo0MjoyNy4yNDA1OTc3MTUgKzAyMDANCkBAIC02MCwxMCAr
NjAsMTYgQEANCiANCiBsaWJpcGNfbGFfU09VUkNFUyA9IGlwYy5oIGlwYy5jDQogDQoraWYgQVVE
SU9QTFVHSU4NCitpZiBTQkMNCisNCiBub2luc3RfUFJPR1JBTVMgPSBpcGN0ZXN0DQogDQogaXBj
dGVzdF9MREFERD0gbGliaXBjLmxhIEBTQkNfTElCU0AgQEdMSUJfTElCU0ANCiANCitlbmRpZg0K
K2VuZGlmDQorDQogQU1fQ0ZMQUdTID0gLWZ2aXNpYmlsaXR5PWhpZGRlbiBAU0JDX0NGTEFHU0Ag
XA0KIAkJQEJMVUVaX0NGTEFHU0AgQERCVVNfQ0ZMQUdTQCBAR0xJQl9DRkxBR1NAIEBHREJVU19D
RkxBR1NADQogDQo=


--=-pI5qvqOLq0FnAgzvZfOJ--

--=-VG57EokuqmWnwH6LOE7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAknbAxoACgkQGwVqY66cHjA+NQCfXDfEAaWCIko6bvkNywhfL4Q5
2/sAn1QrdZ2kIR2Aey1UWRSjjRxbRkIW
=01q4
-----END PGP SIGNATURE-----

--=-VG57EokuqmWnwH6LOE7I--

