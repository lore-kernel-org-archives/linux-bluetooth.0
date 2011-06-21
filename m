Return-Path: <cyrus@holtmann.org>
From: "Li, Nami" <nami@qca.qualcomm.com>
To: "openobex-users@lists.sourceforge.net"
	<openobex-users@lists.sourceforge.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Liu, Haijun" <haijun@qca.qualcomm.com>
Subject: [PATCH v2 openobex 3/3] Modify code to read entire packet when fd
 transport format is SEQPACKET.
Date: Tue, 21 Jun 2011 05:23:06 +0000
Message-ID: <EC94610F2568494D8D9291885C48D3103CFC9D@nasanexd01a.na.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LS0tDQogbGliL2Zkb2JleC5jIHwgICAgMyArKysNCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9mZG9iZXguYyBiL2xp
Yi9mZG9iZXguYyBpbmRleCA3ZmE0YTIxLi40NmEwNzk2IDEwMDY0NA0KLS0tIGEvbGliL2Zkb2Jl
eC5jDQorKysgYi9saWIvZmRvYmV4LmMNCkBAIC03OSw2ICs3OSw5IEBAIHN0YXRpYyBpbnQgZmRv
YmV4X3JlYWQob2JleF90ICpzZWxmLCB2b2lkICpidWYsIGludCBidWZsZW4pICB7DQogCXN0cnVj
dCBvYmV4X3RyYW5zcG9ydCAqdHJhbnMgPSAmc2VsZi0+dHJhbnM7DQoNCisJaWYodHJhbnMtPmRh
dGEuZmQuZm10ID09IEZET0JFWF9NVF9TRVFQQUNLRVQpDQorCQlidWZsZW4gPSBzZWxmLT5tdHVf
cng7DQorDQogI2lmZGVmIF9XSU4zMg0KIAlyZXR1cm4gIF9yZWFkKHRyYW5zLT5mZCwgYnVmLCBi
dWZsZW4pOyAgI2Vsc2UNCi0tDQoxLjcuMQ0K
