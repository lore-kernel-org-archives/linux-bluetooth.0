Return-Path: <cyrus@holtmann.org>
From: "Li, Nami" <nami@qca.qualcomm.com>
To: "openobex-users@lists.sourceforge.net"
	<openobex-users@lists.sourceforge.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>
Subject: [PATCH v3 openobex 3/3] Modify code to read entire packet when fd
 transport format is SEQPACKET.
Date: Tue, 21 Jun 2011 05:17:25 +0000
Message-ID: <EC94610F2568494D8D9291885C48D3103CFC7A@nasanexd01a.na.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LS0tDQogbGliL2Zkb2JleC5jIHwgICAgMyArKysNCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9mZG9iZXguYyBiL2xp
Yi9mZG9iZXguYw0KaW5kZXggN2ZhNGEyMS4uNDZhMDc5NiAxMDA2NDQNCi0tLSBhL2xpYi9mZG9i
ZXguYw0KKysrIGIvbGliL2Zkb2JleC5jDQpAQCAtNzksNiArNzksOSBAQCBzdGF0aWMgaW50IGZk
b2JleF9yZWFkKG9iZXhfdCAqc2VsZiwgdm9pZCAqYnVmLCBpbnQgYnVmbGVuKQ0KIHsNCiAJc3Ry
dWN0IG9iZXhfdHJhbnNwb3J0ICp0cmFucyA9ICZzZWxmLT50cmFuczsNCg0KKwlpZih0cmFucy0+
ZGF0YS5mZC5mbXQgPT0gRkRPQkVYX01UX1NFUVBBQ0tFVCkNCisJCWJ1ZmxlbiA9IHNlbGYtPm10
dV9yeDsNCisNCiAjaWZkZWYgX1dJTjMyDQogCXJldHVybiAgX3JlYWQodHJhbnMtPmZkLCBidWYs
IGJ1Zmxlbik7DQogI2Vsc2UNCi0tDQoxLjcuMQ0K
