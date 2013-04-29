Return-Path: <cyrus@holtmann.org>
From: Shuah Khan <shuah.kh@samsung.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shuahkhan@gmail.com" <shuahkhan@gmail.com>
Subject: [PATCH] Bluetooth: Add missing reset_resume dev_pm_ops
Date: Mon, 29 Apr 2013 15:45:34 +0000
Message-ID: <1367250333.4938.20.camel@lorien>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

QWRkIG1pc3NpbmcgcmVzZXRfcmVzdW1lIGRldl9wbV9vcHMuIE1pc3NpbmcgcmVzZXRfcmVzdW1l
IHJlc3VsdHMgaW4gdGhlDQpmb2xsb3dpbmcgbWVzc2FnZSBhZnRlciBwb3dlciBtYW5hZ2VtZW50
IGRldmljZSB0ZXN0LiBUaGlzIGNoYW5nZSBzZXRzDQpyZXNldF9yZXN1bWUgdG8gYnR1c2JfcmVz
dW1lKCkuDQoNClsgMjUwNi45MzYxMzRdIGJ0dXNiIDEtMS41OjEuMDogbm8gcmVzZXRfcmVzdW1l
IGZvciBkcml2ZXIgYnR1c2I/DQpbIDI1MDYuOTM2MTM3XSBidHVzYiAxLTEuNToxLjE6IG5vIHJl
c2V0X3Jlc3VtZSBmb3IgZHJpdmVyIGJ0dXNiPw0KDQpTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFu
IDxzaHVhaC5raEBzYW1zdW5nLmNvbT4NCi0tLQ0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMg
fCAgICAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQpp
bmRleCAyY2M1Zjc3Li4xMWQ3MmRlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KQEAgLTEyMzAsNiArMTIzMCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2RyaXZlciBidHVzYl9kcml2ZXIgPSB7DQogI2lmZGVmIENP
TkZJR19QTQ0KIAkuc3VzcGVuZAk9IGJ0dXNiX3N1c3BlbmQsDQogCS5yZXN1bWUJCT0gYnR1c2Jf
cmVzdW1lLA0KKwkucmVzZXRfcmVzdW1lCT0gYnR1c2JfcmVzdW1lLA0KICNlbmRpZg0KIAkuaWRf
dGFibGUJPSBidHVzYl90YWJsZSwNCiAJLnN1cHBvcnRzX2F1dG9zdXNwZW5kID0gMSwNCi0tIA0K
MS43LjEwLjQNCg0KDQo=
