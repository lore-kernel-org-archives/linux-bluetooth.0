Return-Path: <cyrus@holtmann.org>
From: "Oprisenescu, CatalinX" <catalinx.oprisenescu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Trandafir, IonutX" <ionutx.trandafir@intel.com>
Subject: bluetoothd failure after a "malloc retun NULL" injection
 (attachment fix)
Date: Wed, 13 Nov 2013 14:09:32 +0000
Message-ID: <6522C4F948C6F5419BA5943E1E79DD2A8ABBAE@IRSMSX104.ger.corp.intel.com>
Content-Type: multipart/mixed;
	boundary="_002_6522C4F948C6F5419BA5943E1E79DD2A8ABBAEIRSMSX104gercorpi_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_6522C4F948C6F5419BA5943E1E79DD2A8ABBAEIRSMSX104gercorpi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Following is an issue encountered and handled using bluez-5.10 on a 32bit T=
izen 2.0 IVI based distribution.

If malloc returns a random NULL bluetoothd exits with core dumped.
In this case we do the following:
      -start bluetoothd,
      -at a random malloc call from any library (*lib*.so*), a random NULL =
will be returned by bluetoothd with a ld_preloaded library.

~# LD_PRELOAD=3D/root/lib_wrapper.so /usr/libexec/bluetooth/bluetoothd -E

Analyzing the dump, it points directly to a DBUS_ERROR_NO_MEMORY which, aft=
er handling, keeps bluetoothd from dumping and allowing it to return the fa=
tal error occurred as exit status, thus failing gracefully.

A fix proposal, handling the use-case is attached.


Regards,
Calin Oprisenescu.
--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). Any review or distribution by others =
is strictly prohibited. If you are not the intended recipient, please conta=
ct the sender and delete all copies.


--_002_6522C4F948C6F5419BA5943E1E79DD2A8ABBAEIRSMSX104gercorpi_
Content-Type: application/octet-stream;
	name="0001-Provide-fix-for-malloc-null-injection.patch"
Content-Description: 0001-Provide-fix-for-malloc-null-injection.patch
Content-Disposition: attachment;
	filename="0001-Provide-fix-for-malloc-null-injection.patch"; size=967;
	creation-date="Wed, 13 Nov 2013 12:17:49 GMT";
	modification-date="Wed, 13 Nov 2013 12:17:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1Njc3MzJjODQyNzhmOTRmYzNkOGM3NDljMGU0MGRlMzQ5ZTlmMDBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYWxpbiBPcHJpc2VuZXNjdSA8Y2F0YWxpbngub3ByaXNlbmVz
Y3VAaW50ZWwuY29tPgpEYXRlOiBUdWUsIDUgTm92IDIwMTMgMTI6Mjc6MjAgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBQcm92aWRlIGZpeCBmb3IgbWFsbG9jIG51bGwgaW5qZWN0aW9uIEFTRDEwMDAw
MTU2NQoKQ2hhbmdlLUlkOiBJN2EyNDlmODE1MzM1ZTY1YWU2NzcxZDVkMWZmNTg0OTdkYmRiYjdk
YgpBdXRob3I6IENhbGluIE9wcmlzZW5lc2N1IDxjYXRhbGlueC5vcHJpc2VuZXNjdUBpbnRlbC5j
b20+CkNvbW1pdHRlcjogQ2FsaW4gT3ByaXNlbmVzY3UgPGNhdGFsaW54Lm9wcmlzZW5lc2N1QGlu
dGVsLmNvbT4KLS0tCiBzcmMvbWFpbi5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL21haW4uYyBiL3NyYy9tYWluLmMKaW5kZXggOTFk
OTBiNC4uM2JmMmFlNCAxMDA2NDQKLS0tIGEvc3JjL21haW4uYworKysgYi9zcmMvbWFpbi5jCkBA
IC00MjcsNiArNDI3LDEwIEBAIHN0YXRpYyBpbnQgY29ubmVjdF9kYnVzKHZvaWQpCiAJY29ubiA9
IGdfZGJ1c19zZXR1cF9idXMoREJVU19CVVNfU1lTVEVNLCBCTFVFWl9OQU1FLCAmZXJyKTsKIAlp
ZiAoIWNvbm4pIHsKIAkJaWYgKGRidXNfZXJyb3JfaXNfc2V0KCZlcnIpKSB7CisJCQlpZiAoZGJ1
c19lcnJvcl9oYXNfbmFtZSAoJmVyciwgREJVU19FUlJPUl9OT19NRU1PUlkpKSB7CisJCQkJZGJ1
c19lcnJvcl9mcmVlKCZlcnIpOworCQkJCXJldHVybiAtRU5PTUVNOworCQkJfQogCQkJZ19wcmlu
dGVycigiRC1CdXMgc2V0dXAgZmFpbGVkOiAlc1xuIiwgZXJyLm1lc3NhZ2UpOwogCQkJZGJ1c19l
cnJvcl9mcmVlKCZlcnIpOwogCQkJcmV0dXJuIC1FSU87Ci0tIAoxLjguNC5tc3lzZ2l0LjAKCg==

--_002_6522C4F948C6F5419BA5943E1E79DD2A8ABBAEIRSMSX104gercorpi_--

