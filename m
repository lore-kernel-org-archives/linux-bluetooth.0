Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9611F.B3410FD7"
Subject: [PATCH] rfcomm/sock.c: rfcomm_sock_sendmsg() does not return error on a connection faulure
Date: Thu, 18 Dec 2008 15:48:33 +0100
Message-ID: <C36B5BF556750D4282E3E0FA9ABEE628023B1019@nl-exc-01.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9611F.B3410FD7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We noticed a problem, when a connection from the remote device is
dropper the write() function does not return the error in the user
space, returning 0 instead - indicating that 0 bytes are sent. We've
also noticed that with some older kernels it used to work (2.6.13 vs
2.6.23-17). The patch fixes the problem.

Regards,
    Victor.

------_=_NextPart_001_01C9611F.B3410FD7
Content-Type: application/octet-stream;
	name="sock.c.patch"
Content-Transfer-Encoding: base64
Content-Description: sock.c.patch
Content-Disposition: attachment;
	filename="sock.c.patch"

LS0tIGEvbmV0L2JsdWV0b290aC9yZmNvbW0vc29jay5jCTIwMDgtMTItMTggMTU6MjA6MTUuMDAw
MDAwMDAwICswMTAwCisrKyBiL25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYwkyMDA4LTEyLTE4
IDE1OjE4OjAwLjAwMDAwMDAwMCArMDEwMApAQCAtNTc1LDggKzU3NSwxMSBAQAogCiAJCXNrYiA9
IHNvY2tfYWxsb2Nfc2VuZF9za2Ioc2ssIHNpemUgKyBSRkNPTU1fU0tCX1JFU0VSVkUsCiAJCQkJ
bXNnLT5tc2dfZmxhZ3MgJiBNU0dfRE9OVFdBSVQsICZlcnIpOwotCQlpZiAoIXNrYikKKwkJaWYg
KCFza2IpIHsKKwkJCWlmIChzZW50ID09IDApCisJCQkJc2VudCA9IGVycjsKIAkJCWJyZWFrOwor
CQl9CiAJCXNrYl9yZXNlcnZlKHNrYiwgUkZDT01NX1NLQl9IRUFEX1JFU0VSVkUpOwogCiAJCWVy
ciA9IG1lbWNweV9mcm9taW92ZWMoc2tiX3B1dChza2IsIHNpemUpLCBtc2ctPm1zZ19pb3YsIHNp
emUpOwo=

------_=_NextPart_001_01C9611F.B3410FD7--
