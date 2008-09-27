Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C920D9.7D6F6323"
Subject: [PATCH] Default bluez-gnome UI to a connectable state
Date: Sat, 27 Sep 2008 14:44:21 -0500
Message-ID: <FA7963CC89065B49AED46A6F797F0FA6F28690@AUSX3MPC128.aus.amer.dell.com>
From: <Mario_Limonciello@Dell.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C920D9.7D6F6323
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Looking through the code, it appears that bluetoothd does start up =
connectable, but the UI doesn't reflect this from the first boot.  This =
patch should address it.

Mario Limonciello=20
Dell | Linux Engineering=20
Mario_Limonciello@Dell.com=20

------_=_NextPart_001_01C920D9.7D6F6323
Content-Type: text/x-patch;
	name="03_default_connectable.patch"
Content-Transfer-Encoding: base64
Content-Description: 03_default_connectable.patch
Content-Disposition: attachment;
	filename="03_default_connectable.patch"

ZGlmZiAtTnVyIC14ICcqLm9yaWcnIC14ICcqficgYmx1ZXotZ25vbWUtMS41L3Byb3BlcnRpZXMv
YWRhcHRlci5jIGJsdWV6LWdub21lLTEuNS5uZXcvcHJvcGVydGllcy9hZGFwdGVyLmMKLS0tIGJs
dWV6LWdub21lLTEuNS9wcm9wZXJ0aWVzL2FkYXB0ZXIuYwkyMDA4LTA4LTI0IDE2OjE0OjI0LjAw
MDAwMDAwMCAtMDUwMAorKysgYmx1ZXotZ25vbWUtMS41Lm5ldy9wcm9wZXJ0aWVzL2FkYXB0ZXIu
YwkyMDA4LTA5LTI3IDAzOjUyOjU3LjAwMDAwMDAwMCAtMDUwMApAQCAtNDA4LDkgKzQwOCw4IEBA
CiAJCQkJCV8oIk90aGVyIGRldmljZXMgY2FuIGNvbm5lY3QiKSk7CiAJZ3JvdXAgPSBndGtfcmFk
aW9fYnV0dG9uX2dldF9ncm91cChHVEtfUkFESU9fQlVUVE9OKGJ1dHRvbikpOwogCWd0a19ib3hf
cGFja19zdGFydChHVEtfQk9YKHZib3gpLCBidXR0b24sIEZBTFNFLCBGQUxTRSwgMCk7Ci0KLQlp
ZiAobW9kZSAmJiBnX2FzY2lpX3N0cmNhc2VjbXAobW9kZSwgImNvbm5lY3RhYmxlIikgPT0gMCkK
LQkJZ3RrX3RvZ2dsZV9idXR0b25fc2V0X2FjdGl2ZShHVEtfVE9HR0xFX0JVVFRPTihidXR0b24p
LCBUUlVFKTsKKwkKKwlndGtfdG9nZ2xlX2J1dHRvbl9zZXRfYWN0aXZlKEdUS19UT0dHTEVfQlVU
VE9OKGJ1dHRvbiksIFRSVUUpOwogCiAJYWRhcHRlci0+YnV0dG9uX2Nvbm5lY3QgPSBidXR0b247
CiAK

------_=_NextPart_001_01C920D9.7D6F6323--
