Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Mar 2016 00:43:59 +0100
Message-ID: <CA+kEDGHWraudGyTcj9Og+hNKH2kCwFB7P7qvjQhTvQNCXfPOLw@mail.gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add BCM2E55 ACPI ID used in Lenovo
 ThinkPad Tablet 8
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
	<jerome.debretagne@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=089e0112d18ec2f9f6052d1974f7
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0112d18ec2f9f6052d1974f7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>

Lenovo ThinkPad Tablet 8 with BCM43241 rev B5 chipset uses the BCM2E55
ACPI ID for Bluetooth. Add it to the list of supported devices.

Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index bb4c5a0..d8881dc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -821,6 +821,7 @@ static const struct acpi_device_id bcm_acpi_match[] =3D=
 {
     { "BCM2E3F", 0 },
     { "BCM2E40", 0 },
     { "BCM2E54", 0 },
+    { "BCM2E55", 0 },
     { "BCM2E64", 0 },
     { "BCM2E65", 0 },
     { "BCM2E67", 0 },
--=20
2.7.0

--089e0112d18ec2f9f6052d1974f7
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-Bluetooth-hci_bcm-Add-BCM2E55-ACPI-ID-used-in-Lenovo.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-hci_bcm-Add-BCM2E55-ACPI-ID-used-in-Lenovo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilbhj6ok0

RnJvbSBmYmEwZTRmMWNmY2M0ZjNlZjViMDAwMzljYTQ5NDE5M2QyYmRjMGNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Sj1DMz1BOXI9QzM9QjRtZT0yMGRlPTIwQnJl
dGFnbmU/PQogPGplcm9tZS5kZWJyZXRhZ25lQGdtYWlsLmNvbT4KRGF0ZTogV2VkLCAyIE1hciAy
MDE2IDIzOjMwOjE3ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRvb3RoOiBoY2lfYmNtOiBB
ZGQgQkNNMkU1NSBBQ1BJIElEIHVzZWQgaW4gTGVub3ZvCiBUaGlua1BhZCBUYWJsZXQgOApNSU1F
LVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29u
dGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKTGVub3ZvIFRoaW5rUGFkIFRhYmxldCA4IHdp
dGggQkNNNDMyNDEgcmV2IEI1IGNoaXBzZXQgdXNlcyB0aGUgQkNNMkU1NSBBQ1BJIElEIGZvciBC
bHVldG9vdGguIEFkZCBpdCB0byB0aGUgbGlzdCBvZiBzdXBwb3J0ZWQgZGV2aWNlcy4KClNpZ25l
ZC1vZmYtYnk6IErDqXLDtG1lIGRlIEJyZXRhZ25lIDxqZXJvbWUuZGVicmV0YWduZUBnbWFpbC5j
b20+Ci0tLQogZHJpdmVycy9ibHVldG9vdGgvaGNpX2JjbS5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNt
LmMgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtLmMKaW5kZXggYmI0YzVhMC4uZDg4ODFkYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX2JjbS5jCisrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2hjaV9iY20uYwpAQCAtODIxLDYgKzgyMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YWNwaV9kZXZpY2VfaWQgYmNtX2FjcGlfbWF0Y2hbXSA9IHsKIAl7ICJCQ00yRTNGIiwgMCB9LAog
CXsgIkJDTTJFNDAiLCAwIH0sCiAJeyAiQkNNMkU1NCIsIDAgfSwKKwl7ICJCQ00yRTU1IiwgMCB9
LAogCXsgIkJDTTJFNjQiLCAwIH0sCiAJeyAiQkNNMkU2NSIsIDAgfSwKIAl7ICJCQ00yRTY3Iiwg
MCB9LAotLSAKMi43LjAKCg==
--089e0112d18ec2f9f6052d1974f7--
