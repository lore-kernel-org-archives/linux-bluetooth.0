Return-Path: <tetsu@s-direct.com>
Message-Id: <4.3.2-J.20040713015123.0463e378@emi.s-direct.com>
Date: Tue, 13 Jul 2004 02:16:34 +0900
To: Marcel Holtmann <marcel@holtmann.org>
From: Tetsuo Shiraishi <tetsu@s-direct.com>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1089481271.13519.71.camel@pegasus>
References: <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
 <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;	boundary="=====================_11271106==_"
List-ID: <bluez-devel.lists.sourceforge.net>

--=====================_11271106==_
Content-Type: text/plain; charset="us-ascii"

Hi Marcel,

At 04/07/10 19:41 +0200, Marcel Holtmann wrote:
>
>you should have mentioned that, because dund creates a /dev/rfcommX
>device node for starting PPP. Maybe there is a leftover, which leaves
>the DLC open and so the session can't be terminated. Maybe a running
>pppd holds the socket descriptor open.
>
>But I won't have time to look into that in detail. If you provide me a
>patch for dund or for the kernel RFCOMM part, I will review it.
>

I tried to make patch for this.

Thanks,

Tetsuo

--=====================_11271106==_
Content-Type: application/octet-stream; name="bluez_sock_garbage.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bluez_sock_garbage.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yNC1vcmcvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL3JmY29tbS5o
IGxpbnV4LTIuNC4yNC10ZXN0MS9pbmNsdWRlL25ldC9ibHVldG9vdGgvcmZjb21tLmgKLS0tIGxp
bnV4LTIuNC4yNC1vcmcvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL3JmY29tbS5oCVNhdCBOb3YgMjkg
MDM6MjY6MjEgMjAwMworKysgbGludXgtMi40LjI0LXRlc3QxL2luY2x1ZGUvbmV0L2JsdWV0b290
aC9yZmNvbW0uaAlUdWUgSnVsIDEzIDAwOjEwOjI5IDIwMDQKQEAgLTMxNyw2ICszMTcsNyBAQAog
dm9pZCByZmNvbW1fY2xlYW51cF9zb2NrZXRzKHZvaWQpOwogCiBpbnQgIHJmY29tbV9jb25uZWN0
X2luZChzdHJ1Y3QgcmZjb21tX3Nlc3Npb24gKnMsIHU4IGNoYW5uZWwsIHN0cnVjdCByZmNvbW1f
ZGxjICoqZCk7Cit2b2lkIHJmY29tbV9zb2NrX2NsZWFudXBfZ2FyYmFnZSAoc3RydWN0IHJmY29t
bV9kbGMgKmQpOwogCiAvKiAtLS0tIFJGQ09NTSBUVFkgLS0tLSAqLwogI2RlZmluZSBSRkNPTU1f
TUFYX0RFViAgMjU2CmRpZmYgLXVyTiBsaW51eC0yLjQuMjQtb3JnL25ldC9ibHVldG9vdGgvcmZj
b21tL2NvcmUuYyBsaW51eC0yLjQuMjQtdGVzdDEvbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5j
Ci0tLSBsaW51eC0yLjQuMjQtb3JnL25ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYwlNb24gTWF5
IDI0IDIzOjI0OjEyIDIwMDQKKysrIGxpbnV4LTIuNC4yNC10ZXN0MS9uZXQvYmx1ZXRvb3RoL3Jm
Y29tbS9jb3JlLmMJVHVlIEp1bCAxMyAwMDoxNDoyMyAyMDA0CkBAIC0zNjUsNiArMzY1LDcgQEAK
IAkJcmZjb21tX2RsY191bmxvY2soZCk7CiAKIAkJc2tiX3F1ZXVlX3B1cmdlKCZkLT50eF9xdWV1
ZSk7CisJCXJmY29tbV9zb2NrX2NsZWFudXBfZ2FyYmFnZSAoZCk7CiAJCXJmY29tbV9kbGNfdW5s
aW5rKGQpOwogCX0KIApkaWZmIC11ck4gbGludXgtMi40LjI0LW9yZy9uZXQvYmx1ZXRvb3RoL3Jm
Y29tbS9zb2NrLmMgbGludXgtMi40LjI0LXRlc3QxL25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2su
YwotLS0gbGludXgtMi40LjI0LW9yZy9uZXQvYmx1ZXRvb3RoL3JmY29tbS9zb2NrLmMJTW9uIEF1
ZyAyNSAyMDo0NDo0NCAyMDAzCisrKyBsaW51eC0yLjQuMjQtdGVzdDEvbmV0L2JsdWV0b290aC9y
ZmNvbW0vc29jay5jCVR1ZSBKdWwgMTMgMDA6MTc6NDQgMjAwNApAQCAtMTEwLDYgKzExMCwxOCBA
QAogfQogCiAvKiAtLS0tIFNvY2tldCBmdW5jdGlvbnMgLS0tLSAqLworc3RydWN0IHNvY2sgKl9f
cmZjb21tX2dldF9zb2NrX2J5X2RsYyhzdHJ1Y3QgcmZjb21tX2RsYyAqZCwgYmRhZGRyX3QgKnNy
YykKK3sKKwlzdHJ1Y3Qgc29jayAqc2s7CisKKwlmb3IgKHNrID0gcmZjb21tX3NrX2xpc3QuaGVh
ZDsgc2s7IHNrID0gc2stPm5leHQpIHsKKwkJaWYgKHJmY29tbV9waShzayktPmRsYyA9PSBkICYm
IAorCQkJCSFiYWNtcCgmYmx1ZXpfcGkoc2spLT5zcmMsIHNyYykpCisJCQlicmVhazsKKwl9CisK
KwlyZXR1cm4gc2s7Cit9CiBzdGF0aWMgc3RydWN0IHNvY2sgKl9fcmZjb21tX2dldF9zb2NrX2J5
X2FkZHIodTggY2hhbm5lbCwgYmRhZGRyX3QgKnNyYykKIHsKIAlzdHJ1Y3Qgc29jayAqc2s7CkBA
IC0yNDQsNiArMjU2LDIzIEBACiAJbG9ja19zb2NrKHNrKTsKIAlfX3JmY29tbV9zb2NrX2Nsb3Nl
KHNrKTsKIAlyZWxlYXNlX3NvY2soc2spOworfQorCit2b2lkIHJmY29tbV9zb2NrX2NsZWFudXBf
Z2FyYmFnZSAoc3RydWN0IHJmY29tbV9kbGMgKmQpCit7CisJc3RydWN0IHJmY29tbV9zZXNzaW9u
ICpzID0gZC0+c2Vzc2lvbjsKKwlzdHJ1Y3Qgc29jayAqc2s7CisJYmRhZGRyX3Qgc3JjLCBkc3Q7
CisKKwlpZiAoIXMpCisJCXJldHVybjsKKworCXJmY29tbV9zZXNzaW9uX2dldGFkZHIocywgJnNy
YywgJmRzdCk7CisJc2sgPSBfX3JmY29tbV9nZXRfc29ja19ieV9kbGMgKGQsICZzcmMpOworCWlm
IChzayAmJiBzay0+c3RhdGUgPT0gQlRfQ0xPU0VEKSB7CisJCXJmY29tbV9zb2NrX2Nsb3NlIChz
ayk7CisJCXJmY29tbV9zb2NrX2tpbGwgKHNrKTsKKwl9CiB9CiAKIHN0YXRpYyB2b2lkIHJmY29t
bV9zb2NrX2luaXQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc29jayAqcGFyZW50KQo=
--=====================_11271106==_
Content-Type: text/plain; charset="us-ascii"


//
//   Tetsuo Shiraishi tetsu@s-direct.com
//                    tshiro@arion.ocn.ne.jp
//

--=====================_11271106==_--
