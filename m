Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53A89.E602A746"
Subject: RE: [Bluez-devel] RFCOMM related oops
Message-ID: <C70061B183DE09419568AB2060C52A952AAE31@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Cc: <victor@win.tue.nl>
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
Date: Wed, 6 Apr 2005 11:20:38 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53A89.E602A746
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

The attached prog. is oops'ing for the _patched_ kernel. Hope this
helps.

Kind regards,
           Victor.=20

P.S. I used channels 1 and 12 for 6310.


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Tuesday, April 05, 2005 16:14 PM
To: Victor Shcherbatyuk
Subject: RE: [Bluez-devel] RFCOMM related oops

Hi Victor,

> Sorry, I should be more clear ... I tried 2.6.11.1 w/o the patch and=20
> with it, the patch is what makes it oops'ing.

actually I need a small test program, so that I can reproduce it with my
Nokia 6310 at home. This will help me a lot to finally fix that issue.

Regards

Marcel



------_=_NextPart_001_01C53A89.E602A746
Content-Type: application/octet-stream;
	name="tryoops.c"
Content-Transfer-Encoding: base64
Content-Description: tryoops.c
Content-Disposition: attachment;
	filename="tryoops.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8dW5pc3RkLmg+
CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgoKI2luY2x1ZGUgPGJs
dWV0b290aC9ibHVldG9vdGguaD4KI2luY2x1ZGUgPGJsdWV0b290aC9oY2kuaD4KI2luY2x1ZGUg
PGJsdWV0b290aC9oY2lfbGliLmg+CiNpbmNsdWRlIDxibHVldG9vdGgvcmZjb21tLmg+CgojZGVm
aW5lIE5UUklFUyA1CgppbnQgYnRvcGVuKCBjb25zdCBjaGFyKiBhZGRyLCBpbnQgY2hhbiApCnsK
CXN0cnVjdCBzb2NrYWRkcl9yYyByZW1vdGVfYWRkciwgbG9jYWxfYWRkcjsKCWJkYWRkcl90IGJk
YWRkcjsKCWludCBzOwoKCXN0cjJiYShhZGRyLCAmYmRhZGRyKTsKCWlmICgocyA9IHNvY2tldChQ
Rl9CTFVFVE9PVEgsIFNPQ0tfU1RSRUFNLCBCVFBST1RPX1JGQ09NTSkpIDwgMCkgewoJCXByaW50
ZigiQ2FuJ3QgY3JlYXRlIHNvY2tldC4gJXMgKCVkKVxuIiwgc3RyZXJyb3IoZXJybm8pLCBlcnJu
byk7CgkJcmV0dXJuIC0xOwoJfQoKCW1lbXNldCgmbG9jYWxfYWRkciwgMCwgc2l6ZW9mKGxvY2Fs
X2FkZHIpKTsKCWxvY2FsX2FkZHIucmNfZmFtaWx5ID0gQUZfQkxVRVRPT1RIOwoJYmFjcHkoJmxv
Y2FsX2FkZHIucmNfYmRhZGRyLCBCREFERFJfQU5ZKTsKCWlmIChiaW5kKHMsIChzdHJ1Y3Qgc29j
a2FkZHIgKikmbG9jYWxfYWRkciwgc2l6ZW9mKGxvY2FsX2FkZHIpKSA8IDApIHsKCQlwcmludGYo
IkNhbid0IGJpbmQgc29ja2V0LiAlcyAoJWQpXG4iLCBzdHJlcnJvcihlcnJubyksIGVycm5vKTsK
CQljbG9zZShzKTsKCQlyZXR1cm4gLTE7Cgl9CgoJbWVtc2V0KCZyZW1vdGVfYWRkciwgMCwgc2l6
ZW9mKHJlbW90ZV9hZGRyKSk7CglyZW1vdGVfYWRkci5yY19mYW1pbHkgPSBBRl9CTFVFVE9PVEg7
CgliYWNweSgmcmVtb3RlX2FkZHIucmNfYmRhZGRyLCAmYmRhZGRyKTsKCXJlbW90ZV9hZGRyLnJj
X2NoYW5uZWwgPSBjaGFuOwoJaWYgKGNvbm5lY3QocywgKHN0cnVjdCBzb2NrYWRkciAqKSZyZW1v
dGVfYWRkciwgc2l6ZW9mKHJlbW90ZV9hZGRyKSkgPCAwKSB7CgkJcHJpbnRmKCJDYW4ndCBjb25u
ZWN0IG9uIGNoYW5uZWwgJWQuICVzICglZClcbiIsIGNoYW4sIHN0cmVycm9yKGVycm5vKSwgZXJy
bm8pOwoJCWNsb3NlKHMpOwoJCXJldHVybiAtMTsKCX0KCglyZXR1cm4gczsKfQoKaW50IG1haW4o
IGludCBhcmdjLCBjaGFyKiogYXJndiApCnsKCWludCBmZDEsIGZkMjsKCglpZiAoIGFyZ2MgPCA0
ICkKCXsKCQlwcmludGYoIlVzZTogdHJ5b29wcyA8YWRkcmVzcz4gPGNoYW5uZWxfMT4gPGNoYW5u
ZWxfMj5cbiIpOwoJCWV4aXQoIDEgKTsKCX0KICAvLyBvcGVuIHRoZSBmaXJzdCBjaGFubmVsCglw
cmludGYoIm9wZW5pbmcgJXMgb24gYSBjaGFubmVsICVkLi4uXG4iLCBhcmd2WzFdLCBhdG9pKGFy
Z3ZbMl0pKTsKCWlmICggKGZkMSA9IGJ0b3Blbihhcmd2WzFdLCBhdG9pKGFyZ3ZbMl0pKSkgPCAw
ICl7CgkJcHJpbnRmKCJjYW5ub3Qgb3BlbiB0aGUgY2hhbm5lbCFcbiIpOwoJCWV4aXQoMSk7Cgl9
CgllbHNlCgkJcHJpbnRmKCJvcGVuZWQuXG4iKTsKCgkvL3RyeSB0byBvcGVuIHRoZSBzZWNvbmQg
Y2hhbm5lbCwgaWYgdGhlIHBhdGNoIGlzIGFwcGxpZWQgaXQgc2hvdWxkIGZhaWwgZm9yIGZpcnN0
IDIgdGltZXMgYW5kIHRoZW4gc3VjY2VlZAoJcHJpbnRmKCJvcGVuaW5nICVzIG9uIGEgY2hhbm5l
bCAlZC4uLlxuIiwgYXJndlsxXSwgYXRvaShhcmd2WzNdKSk7CglpbnQgbnRyaWVzID0gTlRSSUVT
OwoJd2hpbGUgKChmZDIgPSBidG9wZW4oYXJndlsxXSwgYXRvaShhcmd2WzNdKSkpIDwgMCAmJiAt
LW50cmllcyApCgkJcHJpbnRmKCJhdHRlbXB0ICVkIGZhaWxlZC5cbiIsIE5UUklFUyAtIG50cmll
cyk7CglpZiAoIW50cmllcyl7CgkJcHJpbnRmKCJrZXJuZWwgbm90IHBhdGNoZWQ/XG4iKTsKCQlj
bG9zZShmZDEpOwoJCWV4aXQoMSk7Cgl9CgllbHNlCgkJcHJpbnRmKCJvcGVuZWQuXG4iKTsKCglw
cmludGYoImNsb3NpbmcgY2hhbm5lbCAlZFxuIiwgYXRvaShhcmd2WzNdKSk7CgljbG9zZShmZDIp
OwoJLy90aGlzIG9uZSBzaG91bGQgb29wcwoJcHJpbnRmKCJjbG9zaW5nIGNoYW5uZWwgJWRcbiIs
IGF0b2koYXJndlsyXSkpOwoJY2xvc2UoZmQxKTsKCglyZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C53A89.E602A746--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
