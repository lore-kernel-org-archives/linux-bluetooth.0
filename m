Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C961DA.46ECE947"
Subject: RE: [PATCH] rfcomm/sock.c: rfcomm_sock_sendmsg() does not return error on a connection faulure
Date: Fri, 19 Dec 2008 14:04:07 +0100
Message-ID: <C36B5BF556750D4282E3E0FA9ABEE628023B1394@nl-exc-01.intra.local>
In-Reply-To: <1229670042.17082.29.camel@violet>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C961DA.46ECE947
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Is this ok?

Regards,
   Victor.

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Friday, December 19, 2008 8:01 AM
To: Victor Shcherbatyuk
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] rfcomm/sock.c: rfcomm_sock_sendmsg() does not
return error on a connection faulure

Hi Victor,

> We noticed a problem, when a connection from the remote device is
> dropper the write() function does not return the error in the user
> space, returning 0 instead - indicating that 0 bytes are sent. We've
> also noticed that with some older kernels it used to work (2.6.13 vs
> 2.6.23-17). The patch fixes the problem.

that is a bug and your patch looks good. However can you use
git-format-patch and sent it again with proper Signed-off-by line for me
to apply.

Regards

Marcel



------_=_NextPart_001_01C961DA.46ECE947
Content-Type: application/octet-stream;
	name="0001-Fixed-rfcomm_sock_sendmsg-to-return-an-error-on-th.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Fixed-rfcomm_sock_sendmsg-to-return-an-error-on-th.patch
Content-Disposition: attachment;
	filename="0001-Fixed-rfcomm_sock_sendmsg-to-return-an-error-on-th.patch"

RnJvbSA3YWJiYWYxMjdmZDYyZjViZDNiMmE3ZmMwMmI1MjUzYmFjMjk5YjQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgU2hjaGVyYmF0eXVrIDxWaWN0b3IuU2hjaGVyYmF0
eXVrQHRvbXRvbS5jb20+CkRhdGU6IEZyaSwgMTkgRGVjIDIwMDggMTM6NTY6NTggKzAxMDAKU3Vi
amVjdDogW1BBVENIXSBGaXhlZCByZmNvbW1fc29ja19zZW5kbXNnKCkgdG8gcmV0dXJuIGFuIGVy
cm9yIG9uIHRoZSBjb25uZWN0aW9uIGZhaWx1cmUKCgpTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgU2hj
aGVyYmF0eXVrIDxWaWN0b3IuU2hjaGVyYmF0eXVrQHRvbXRvbS5jb20+Ci0tLQogbmV0L2JsdWV0
b290aC9yZmNvbW0vc29jay5jIHwgICAgNSArKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9yZmNv
bW0vc29jay5jIGIvbmV0L2JsdWV0b290aC9yZmNvbW0vc29jay5jCmluZGV4IDhhOTcyYjYuLjk5
ZTY1YWYgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYworKysgYi9uZXQv
Ymx1ZXRvb3RoL3JmY29tbS9zb2NrLmMKQEAgLTU3NSw4ICs1NzUsMTEgQEAgc3RhdGljIGludCBy
ZmNvbW1fc29ja19zZW5kbXNnKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IHNvY2tldCAqc29j
aywKIAogCQlza2IgPSBzb2NrX2FsbG9jX3NlbmRfc2tiKHNrLCBzaXplICsgUkZDT01NX1NLQl9S
RVNFUlZFLAogCQkJCW1zZy0+bXNnX2ZsYWdzICYgTVNHX0RPTlRXQUlULCAmZXJyKTsKLQkJaWYg
KCFza2IpCisJCWlmICghc2tiKSB7CisJCQlpZiAoc2VudCA9PSAwKQorCQkJCXNlbnQgPSBlcnI7
CiAJCQlicmVhazsKKwkJfQogCQlza2JfcmVzZXJ2ZShza2IsIFJGQ09NTV9TS0JfSEVBRF9SRVNF
UlZFKTsKIAogCQllcnIgPSBtZW1jcHlfZnJvbWlvdmVjKHNrYl9wdXQoc2tiLCBzaXplKSwgbXNn
LT5tc2dfaW92LCBzaXplKTsKLS0gCjEuNS40LjMKCg==

------_=_NextPart_001_01C961DA.46ECE947--
