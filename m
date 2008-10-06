Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9277B.CB604F57"
Subject: [PATCH] Don't show (null) in wizard
Date: Mon, 6 Oct 2008 01:21:21 -0500
Message-ID: <FA7963CC89065B49AED46A6F797F0FA6F286AA@AUSX3MPC128.aus.amer.dell.com>
From: <Mario_Limonciello@Dell.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9277B.CB604F57
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:

I've noticed that the wizard will show (null) if the device name is not =
yet recognized when pairing.  This is a bit confusing to the user =
experience.  The attached patch makes the behavior a little bit better.

Regards

Mario Limonciello=20
Dell | Linux Engineering=20
Mario_Limonciello@Dell.com=20



------_=_NextPart_001_01C9277B.CB604F57
Content-Type: text/x-patch;
	name="07_null_device_name.patch"
Content-Transfer-Encoding: base64
Content-Description: 07_null_device_name.patch
Content-Disposition: attachment;
	filename="07_null_device_name.patch"

ZGlmZiAtTnVyIC14ICcqLm9yaWcnIC14ICcqficgYmx1ZXotZ25vbWUtMS44L3dpemFyZC9tYWlu
LmMgYmx1ZXotZ25vbWUtMS44Lm5ldy93aXphcmQvbWFpbi5jCi0tLSBibHVlei1nbm9tZS0xLjgv
d2l6YXJkL21haW4uYwkyMDA4LTEwLTA0IDE0OjMyOjU2LjAwMDAwMDAwMCAtMDUwMAorKysgYmx1
ZXotZ25vbWUtMS44Lm5ldy93aXphcmQvbWFpbi5jCTIwMDgtMTAtMDYgMDE6MTg6NTQuMDAwMDAw
MDAwIC0wNTAwCkBAIC0zNjIsNiArMzYyLDggQEAKIAkJZ19mcmVlKHRhcmdldF9hZGRyZXNzKTsK
IAkJdGFyZ2V0X2FkZHJlc3MgPSBhZGRyZXNzOwogCisJCWlmIChuYW1lID09IE5VTEwpCisJCQlu
YW1lID0gImRldmljZSI7CiAJCWdfZnJlZSh0YXJnZXRfbmFtZSk7CiAJCXRhcmdldF9uYW1lID0g
bmFtZTsKIAo=

------_=_NextPart_001_01C9277B.CB604F57--
