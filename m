Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
To: ML bluez-devel <bluez-devel@lists.sourceforge.net>
Message-id: <41ED7E8D.8030709@pca.it>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_TrMptEIyOBXNq5M1ohHmpw)"
Subject: [Bluez-devel] [btsco] configure/make errors
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
Date: Tue, 18 Jan 2005 22:24:29 +0100

This is a multi-part message in MIME format.

--Boundary_(ID_TrMptEIyOBXNq5M1ohHmpw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello again,

after having solved the automake error, configure gave me another one
and googling solved it [1]. But, again, no dependencies from libao-dev
is present in the README (and, strangely, automake doesn't complain).

This wasn't enough: make gave me other errors, because it could not find
the Bluetooth dev libraries.

Attached a patch against the current CVS:

* bootstrap:
checking for the existence of /usr/share/aclocal/ao.m4 and exiting with
an error if not present (we cannot use the pkg-config because ao.m4 is
used to generate the configure script)

* configure.in:
used pkg-config to check the presence of the Bluetooth dev libraries

* README:
added more info about dependencies (section Build.0)

Thx, bye,
Gismo / Luca

[1] https://www.redhat.com/archives/fedora-list/2004-December/msg03679.html
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFB7X6NVAp7Xm10JmkRAtPlAJ46nBk7st7KfzBsSc3+W+4tuc2kNwCfSRBM
uNAdtpcWbvjUmLOm83oUT+E=
=wdn3
-----END PGP SIGNATURE-----

--Boundary_(ID_TrMptEIyOBXNq5M1ohHmpw)
Content-type: text/plain;
 name=btsco_cvs-20050118-2128_libao-libbluetooth-check.diff; CHARSET=us-ascii
Content-transfer-encoding: BASE64
Content-disposition: inline;
 filename=btsco_cvs-20050118-2128_libao-libbluetooth-check.diff

ZGlmZiAtTmF1ciBidHNjb19jdnMtMjAwNTAxMTgtMjEyOC9ib290c3RyYXAgYnRz
Y28vYm9vdHN0cmFwDQotLS0gYnRzY29fY3ZzLTIwMDUwMTE4LTIxMjgvYm9vdHN0
cmFwCTIwMDUtMDEtMTggMTg6MTE6MjEuMDAwMDAwMDAwICswMTAwDQorKysgYnRz
Y28vYm9vdHN0cmFwCTIwMDUtMDEtMTggMjI6MDQ6MzIuMDAwMDAwMDAwICswMTAw
DQpAQCAtMSwxMCArMSwxOSBAQA0KICMhIC9iaW4vc2gNCiANCisjIFRlc3QgZm9y
IHRoZSByaWdodCBhdXRvbWFrZQ0KIGlmIFsgISBgd2hpY2ggYXV0b21ha2UtMS43
YCBdOyB0aGVuDQogICAgIGVjaG8gLWUgIlxuKioqIFlvdSBuZWVkIGF1dG9tYWtl
LTEuNyB0byBjb21waWxlIHRoaXMgc29mdHdhcmUgKioqXG4iDQogICAgIGV4aXQg
MQ0KIGVsaWYgWyAhIGBhdXRvbWFrZSAtLXZlcnNpb24gfCBncmVwIC1xIDEuN2Ag
XTsgdGhlbg0KICAgICBBVVRPTUFLRV9WRVJTSU9OPSItMS43Ig0KIGZpDQotIA0K
Kw0KKyMgVGVzdCBmb3IgdGhlIHByZXNlbmNlIG9mIGxpYmFvLWRldiAodGhpcyBj
YW5ub3QgYmUgZG9uZSB3aXRoDQorIyBwa2ctY29uZmlnIGJlY2F1c2Ugd2UgbmVl
ZCBsaWJhby1kZXYgZm9yIGF1dG9tYWtlKQ0KK2lmIFsgISAtcyAiL3Vzci9zaGFy
ZS9hY2xvY2FsL2FvLm00IiBdOyB0aGVuDQorICAgIGVjaG8gLWUgIlxuKioqIFlv
dSBuZWVkIGxpYmFvLWRldiB0byBjb21waWxlIHRoaXMgc29mdHdhcmUgKioqXG4i
DQorICAgIGV4aXQgMQ0KK2ZpDQorDQorIyBBbGwgd2UgbmVlZCBmb3IgdGhlIGF1
dG90b29scyBpcyBpbnN0YWxsZWQsIHNvIGdvIG9uDQogYWNsb2NhbCRBVVRPTUFL
RV9WRVJTSU9OICYmIGF1dG9oZWFkZXIgJiYgYXV0b21ha2UkQVVUT01BS0VfVkVS
U0lPTiAtLWFkZC1taXNzaW5nIC0tY29weSAtLWlnbm9yZS1kZXBzICYmIGF1dG9j
b25mDQpkaWZmIC1OYXVyIGJ0c2NvX2N2cy0yMDA1MDExOC0yMTI4L2NvbmZpZ3Vy
ZS5pbiBidHNjby9jb25maWd1cmUuaW4NCi0tLSBidHNjb19jdnMtMjAwNTAxMTgt
MjEyOC9jb25maWd1cmUuaW4JMjAwNC0xMS0yOCAwNzo0NDo0OS4wMDAwMDAwMDAg
KzAxMDANCisrKyBidHNjby9jb25maWd1cmUuaW4JMjAwNS0wMS0xOCAyMjoxMzoy
My4wMDAwMDAwMDAgKzAxMDANCkBAIC01LDYgKzUsOCBAQA0KIEFDX1BSRVJFUSgy
LjUwKQ0KIEFDX0lOSVQoKQ0KIA0KK1BLR19DSEVDS19NT0RVTEVTKEJUU0NPLCBi
bHVleikNCisNCiBBTV9JTklUX0FVVE9NQUtFKGJ0c2NvLCAwLjIpDQogQU1fQ09O
RklHX0hFQURFUihjb25maWcuaCkNCiANCmRpZmYgLU5hdXIgYnRzY29fY3ZzLTIw
MDUwMTE4LTIxMjgvUkVBRE1FIGJ0c2NvL1JFQURNRQ0KLS0tIGJ0c2NvX2N2cy0y
MDA1MDExOC0yMTI4L1JFQURNRQkyMDA1LTAxLTE4IDE4OjExOjIwLjAwMDAwMDAw
MCArMDEwMA0KKysrIGJ0c2NvL1JFQURNRQkyMDA1LTAxLTE4IDIyOjA0OjQ2LjAw
MDAwMDAwMCArMDEwMA0KQEAgLTMxLDEwICszMSwxNCBAQA0KIA0KICAgQnVpbGQN
CiANCisgICAgMC4gSW4gb3JkZXIgdG8gYnVpbGQgdGhpcyBwcm9qZWN0LCB5b3Ug
bmVlZDoNCisgICAgICAgIGF1dG9tYWtlLTEuNw0KKyAgICAgICAgbGliYW8tZGV2
DQorICAgICAgICBsaWJibHVldG9vdGgtZGV2DQogICAgIDEuIFRoZSBDVlMgcmVw
b3NpdG9yeSBtdXN0IGJlIGNoZWNrZWQgb3V0Og0KICAgICAgICAgY3ZzIC1kOnBz
ZXJ2ZXI6YW5vbnltb3VzQGN2cy5zZi5uZXQ6L2N2c3Jvb3QvYmx1ZXRvb3RoLWFs
c2EgbG9naW4NCiAgICAgICAgIGN2cyAtZDpwc2VydmVyOmFub255bW91c0BjdnMu
c2YubmV0Oi9jdnNyb290L2JsdWV0b290aC1hbHNhIGNvIGJ0c2NvDQotICAgIDIu
IEFmdGVyIHRoYXQgaXQgbXVzdCBiZSBjb21waWxlZCAoeW91IG5lZWQgYXV0b21h
a2UgMS43KToNCisgICAgMi4gQWZ0ZXIgdGhhdCBpdCBtdXN0IGJlIGNvbXBpbGVk
Og0KICAgICAgICAgLi9ib290c3RyYXANCiAgICAgICAgIC4vY29uZmlndXJlDQog
ICAgICAgICBtYWtlDQo=

--Boundary_(ID_TrMptEIyOBXNq5M1ohHmpw)--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
