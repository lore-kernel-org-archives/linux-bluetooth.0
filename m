Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
To: ML bluez-devel <bluez-devel@lists.sourceforge.net>
Message-id: <41ED224E.9030702@pca.it>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_NltT+kIz6TqUkVjuh+TBfw)"
Subject: [Bluez-devel] [btsco] automake error
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
Date: Tue, 18 Jan 2005 15:50:54 +0100

This is a multi-part message in MIME format.

--Boundary_(ID_NltT+kIz6TqUkVjuh+TBfw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm new to the list, so hello to everyone :-)

I just bought a Bluetake i-Phono and I was trying to test it (Debian
unstable, kernel 2.6.10, ALSA 1.0.8), but I got an automake error:
=====
luca@gismo:~/src/kernel/bluetooth$ cvs
- -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa login
Logging in to :pserver:anonymous@cvs.sf.net:2401/cvsroot/bluetooth-alsa
CVS password:
luca@gismo:~/src/kernel/bluetooth$ cvs
- -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
cvs checkout: Updating btsco
<cut>
U btsco/sbc/sbcinfo.c

luca@gismo:~/src/kernel/bluetooth$ cd btsco/
luca@gismo:~/src/kernel/bluetooth/btsco$ ./bootstrap
automake: unrecognized option -- `--ignore-deps'
Try `automake --help' for more information.

luca@gismo:~/src/kernel/bluetooth/btsco$ automake --help | grep ignore
luca@gismo:~/src/kernel/bluetooth/btsco$ automake --version | grep automake
automake (GNU automake) 1.4-p6
=====

So, the attached patch check for automake-1.7 during the bootstrap
process and add an info in the README.

But I still have some compilation problems... (new post, IMHO it's better).

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFB7R1mVAp7Xm10JmkRAsS6AJ0cJCqjyaxxDdVW2HafWJFWwJbatQCdF002
OXtjJYOo4mfeYcpDZyGT9Y0=
=eIey
-----END PGP SIGNATURE-----

--Boundary_(ID_NltT+kIz6TqUkVjuh+TBfw)
Content-type: text/plain; name=btsco_cvs-20050118-1520_automake1.7-check.diff;
 CHARSET=us-ascii
Content-transfer-encoding: BASE64
Content-disposition: inline;
 filename=btsco_cvs-20050118-1520_automake1.7-check.diff

ZGlmZiAtTmF1ciBidHNjb19jdnMtMjAwNTAxMTgtMTUyMC9ib290c3RyYXAgYnRz
Y28vYm9vdHN0cmFwDQotLS0gYnRzY29fY3ZzLTIwMDUwMTE4LTE1MjAvYm9vdHN0
cmFwCTIwMDUtMDEtMTggMTU6MjI6NDQuMDAwMDAwMDAwICswMTAwDQorKysgYnRz
Y28vYm9vdHN0cmFwCTIwMDUtMDEtMTggMTU6MTk6MzguMDAwMDAwMDAwICswMTAw
DQpAQCAtMSwyICsxLDEwIEBADQogIyEgL2Jpbi9zaA0KLWFjbG9jYWwgJiYgYXV0
b2hlYWRlciAmJiBhdXRvbWFrZSAtLWFkZC1taXNzaW5nIC0tY29weSAtLWlnbm9y
ZS1kZXBzICYmIGF1dG9jb25mDQorDQoraWYgWyAhIGB3aGljaCBhdXRvbWFrZS0x
LjdgIF07IHRoZW4NCisgICAgZWNobyAtZSAiXG4qKiogWW91IG5lZWQgYXV0b21h
a2UtMS43IHRvIGNvbXBpbGUgdGhpcyBzb2Z0d2FyZSAqKipcbiINCisgICAgZXhp
dCAxDQorZWxpZiBbICEgYGF1dG9tYWtlIC0tdmVyc2lvbiB8IGdyZXAgLXEgMS43
YCBdOyB0aGVuDQorICAgIEFVVE9NQUtFX1ZFUlNJT049Ii0xLjciDQorZmkNCisg
DQorYWNsb2NhbCRBVVRPTUFLRV9WRVJTSU9OICYmIGF1dG9oZWFkZXIgJiYgYXV0
b21ha2UkQVVUT01BS0VfVkVSU0lPTiAtLWFkZC1taXNzaW5nIC0tY29weSAtLWln
bm9yZS1kZXBzICYmIGF1dG9jb25mDQpkaWZmIC1OYXVyIGJ0c2NvX2N2cy0yMDA1
MDExOC0xNTIwL1JFQURNRSBidHNjby9SRUFETUUNCi0tLSBidHNjb19jdnMtMjAw
NTAxMTgtMTUyMC9SRUFETUUJMjAwNS0wMS0xOCAxNToyMzozMi4wMDAwMDAwMDAg
KzAxMDANCisrKyBidHNjby9SRUFETUUJMjAwNC0xMS0yNSAwMTo1MTo0MC4wMDAw
MDAwMDAgKzAxMDANCkBAIC0zNyw3ICszNyw3IEBADQogICAgIDEuIFRoZSBDVlMg
cmVwb3NpdG9yeSBtdXN0IGJlIGNoZWNrZWQgb3V0Og0KICAgICAgICAgY3ZzIC1k
OnBzZXJ2ZXI6YW5vbnltb3VzQGN2cy5zZi5uZXQ6L2N2c3Jvb3QvYmx1ZXRvb3Ro
LWFsc2EgbG9naW4NCiAgICAgICAgIGN2cyAtZDpwc2VydmVyOmFub255bW91c0Bj
dnMuc2YubmV0Oi9jdnNyb290L2JsdWV0b290aC1hbHNhIGNvIGJ0c2NvDQotICAg
IDIuIEFmdGVyIHRoYXQgaXQgbXVzdCBiZSBjb21waWxlZCwgeW91IG5lZWQgYXV0
b21ha2UxLjcgdG8gZG8gaXQ6DQorICAgIDIuIEFmdGVyIHRoYXQgaXQgbXVzdCBi
ZSBjb21waWxlZDoNCiAgICAgICAgIC4vYm9vdHN0cmFwDQogICAgICAgICAuL2Nv
bmZpZ3VyZQ0KICAgICAgICAgbWFrZQ0K

--Boundary_(ID_NltT+kIz6TqUkVjuh+TBfw)--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
