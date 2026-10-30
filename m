Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357803;
	b=IJd2vjqWVy+dDE5O9E9Ki4daRW1h995gZ9m1SGglltJqob1OOyj3cqtENCC4I+IR8Ov6
	 L+fErk2zloaAhG832oFRN7wZdWx0ZbEM4/apnAHTuzjH5HDhctKAxdqZG8zRpe1ZNjdJQ
	 xrJYxWnb3cMBlU75WW2Z7Ffs1jES/nI8Oo9bm5G9gt3BFJthCFhDifvwKC/uo3evIwgS1
	 kCsPiJvFWfbnt/pQXo70MqaKMak6vUxYyimYfWSMxsb2wvbogPqR4+f2BOPuZrNvxCO01
	 +BNDDrVYtb/0bZbyT/RZ+9s0K1iBdwwRsWcW//yGfm4L+O6XoHjsqEyVD36FcGIOTjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357803;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=pd1CEwiYjZ8Qovui4gR16gB+aFb2YZLVeoP0UhItucU=;
	b=PjTsu2OlFWGCw+8hUh23SEDjIqHLTvRu7fDiuwnvdkJZ2X3FlmUzMcDlxqA/k+fbnzD1
	 e4+qwbAs3zS3nHGhf5PxKKs6/3dc2FYsEL99E7IeMCrpSRx0r9n209eSBGFCM0pKOGKbi
	 gYlb3rnRT+YQAE8A5PzGecEu+LsWZ94jC9iIHefqBnbue47In7a3u2xYAAUnwfKjE6PLu
	 xHil7O9o3Ay7WSCkwqZUMq7Br/6QsV4A5JxnKxsgwS59KbecX/AIhiZ6Iic37MS1vUchj
	 i7EnDizAEdEszR+1dQbwOWqHWIR2lo7Uh7iPUvLwxpeR59+qppcdLQASivh6LXkNtGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=B0lCzHNa;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7F606AC10
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 10:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD7F606AC10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=B0lCzHNa
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69UAuQGO13770479, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793357786; bh=pd1CEwiYjZ8Qovui4gR16gB+aFb2YZLVeoP0UhItucU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=B0lCzHNaoGbLN+FFRF57d94w8iWP+jVRP6bcr0Z+eT1gPEy/f8iZHZTEx7bLsR6AT
	 d9jKk51HRoJYQQYHEjJ4917tjh6JdbHzX+nlpVLFmO7FjUYjIUlhilj4cfANA+Xf/Z
	 rVyR5mWrvOFkel2GBH6tLP5wCVgd6mVxz8U+fa2AXGahgPpZv9IYLI8JgBFeow8ext
	 eiN3LSSw/a8yjjeq89wbl9hajD7LjWy8Ac3lr/rI3RDmdaCyxYNdajSUa70SuKdf/j
	 g3rQcVyE9JZCswALfi8d9mmYY49hG4tchSG1zCpzD4sydP7Yhhu/77dg89S9UCYrX5
	 2M+/2C4VV0Igw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69UAuQGO13770479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 18:56:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 18:56:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 18:56:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::bbab:78ea:8d39:6f1e]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::bbab:78ea:8d39:6f1e%4]) with mapi id
 15.02.2562.056; Fri, 30 Oct 2026 18:56:27 +0800
From: Hilda Wu <hildawu@realtek.com>
To: Athos Andrade <athosandrade04@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, Max Chou
	<max.chou@realtek.com>, Chih-Hsiang Wang <wangchihhs@realtek.com>
Subject: RE: [BUG] rtl_bt: RTL8852B BT USB FW 0x127C_FD78 stops delivering BLE
 keyboard input, 0x42D3_4E04 works
Thread-Topic: [BUG] rtl_bt: RTL8852B BT USB FW 0x127C_FD78 stops delivering
 BLE keyboard input, 0x42D3_4E04 works
Thread-Index: AQHdZYP21nSZ4tA5PU6hm3d9M85TWbcV7Rlg
Date: Fri, 30 Oct 2026 10:56:26 +0000
Message-ID: <b30c3e615bd64cc1a92e79c0239fa88c@realtek.com>
References: <CAAErAfLhrvtQOEqtGhEOmNX+0Lkq7ckLekmgSjot4-7jFD0shA@mail.gmail.com>
In-Reply-To: <CAAErAfLhrvtQOEqtGhEOmNX+0Lkq7ckLekmgSjot4-7jFD0shA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

SGkgQXRob3MsDQoNClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIGluZm9ybWF0aW9uLg0KQ291
bGQgeW91IHBsZWFzZSBzaGFyZSB0aGUgYnRtb24gbG9nPyANCihJdCB3b3VsZCBiZSBhcHByZWNp
YXRlZCBpZiB5b3UgY291bGQgYWxzbyBwcm92aWRlIHRoZSB0aW1lc3RhbXAgd2hlbiB0aGUgZnJl
ZXplIG9jY3VycmVkLikNCkFsc28sIGlmIG9ubHkgb25lIExvZnJlZSBGbG93Mi02OCBrZXlib2Fy
ZCBjb25uZWN0aW9uIGlzIGtlcHQsIGRvZXMgdGhlIGlzc3VlIHN0aWxsIG9jY3VyPw0KDQpUaGFu
ayB5b3UgYWdhaW4uDQpSZWdhcmRzLA0KSGlsZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEF0aG9zIEFuZHJhZGUgPGF0aG9zYW5kcmFkZTA0QGdtYWlsLmNvbT4gDQpTZW50
OiBUdWVzZGF5LCBPY3RvYmVyIDI3LCAyMDI2IDM6NTUgQU0NClRvOiBsaW51eC1ibHVldG9vdGhA
dmdlci5rZXJuZWwub3JnDQpDYzogbGludXgtZmlybXdhcmVAa2VybmVsLm9yZzsgSGlsZGEgV3Ug
PGhpbGRhd3VAcmVhbHRlay5jb20+DQpTdWJqZWN0OiBbQlVHXSBydGxfYnQ6IFJUTDg4NTJCIEJU
IFVTQiBGVyAweDEyN0NfRkQ3OCBzdG9wcyBkZWxpdmVyaW5nIEJMRSBrZXlib2FyZCBpbnB1dCwg
MHg0MkQzXzRFMDQgd29ya3MNCg0KDQpFeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgcmVwbHksIGNsaWNrIGxp
bmtzLCBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIg
YW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNCkhpLA0KDQpTaW5jZSBsaW51eC1m
aXJtd2FyZSBjb21taXQgNGNhMzMxN2UgKCJydGxfYnQ6IFVwZGF0ZSBSVEw4ODUyQiBCVCBVU0Ig
RlcgdG8gMHgxMjdDX0ZENzgiKSwgYSBCTEUga2V5Ym9hcmQgY29ubmVjdGVkIHRvIHRoZSBSVEw4
ODUyQlUgQmx1ZXRvb3RoIGNvbnRyb2xsZXIgb2YgbXkgbGFwdG9wIHN0b3BzIGRlbGl2ZXJpbmcg
a2V5IHByZXNzZXMgZXZlcnkNCjEgdG8gNCBtaW51dGVzLiBHb2luZyBiYWNrIHRvIHRoZSBwcmV2
aW91cyBmaXJtd2FyZSBvbmx5ICgweDQyRDNfNEUwNCwgY29tbWl0IDhiY2M5MWQxKSBmaXhlcyBp
dC4gSSBkaWQgYW4gQS9CIHRlc3QgYW5kIHRoZSByZXN1bHQgaXMgcmVwZWF0YWJsZS4NCg0KSGFy
ZHdhcmUgYW5kIHNvZnR3YXJlDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi0gTGFwdG9wOiBMZW5v
dm8gVGhpbmtQYWQgRTE0IEdlbiA0ICgyMUU0MDAxR0JPKSwgSW50ZWwgaTUtMTIzNVUNCi0gQ29u
dHJvbGxlcjogUmVhbHRlayBSVEw4ODUyQkUgY29tYm8gY2FyZCwgQmx1ZXRvb3RoIG9uIFVTQiAw
YmRhOjQ4NTMNCiAgKFJPTTogaGNpX3Zlcj0wYiBoY2lfcmV2PTAwMGIgbG1wX3N1YnZlcj04ODUy
KQ0KLSBGaXJtd2FyZTogcnRsX2J0L3J0bDg4NTJidV9mdy5iaW4NCiAgICBiYWQ6ICAweDEyN2Nm
ZDc4DQogICAgZ29vZDogMHg0MmQzNGUwNA0KICBydGw4ODUyYnVfY29uZmlnLmJpbiBpcyB0aGUg
c2FtZSBpbiBib3RoIGNhc2VzDQotIEtlcm5lbDogNy4yLjggKEFyY2gtYmFzZWQgZGlzdHJvIGtl
cm5lbCwgbGludXgtb21hcmNoeSA3LjIuOC05KQ0KLSBsaW51eC1maXJtd2FyZS1yZWFsdGVrIDIw
MjYwOTE2IChBcmNoIHBhY2thZ2UpDQotIEJsdWVaIDUuODcNCi0gUGVyaXBoZXJhbDogTG9mcmVl
IEZsb3cyLTY4IGtleWJvYXJkLCBCTEUgSElEIG92ZXIgR0FUVCAoSE9HUCkNCi0gT3RoZXIgTEUg
ZGV2aWNlcyBvbiB0aGUgc2FtZSBjb250cm9sbGVyOiBMb2dpdGVjaCBNWCBNYXN0ZXIgM1MsDQog
IExvZ2l0ZWNoIE1YIEVyZ28gUw0KDQpTeW1wdG9tDQotLS0tLS0tDQpUaGUga2V5Ym9hcmQgc3Rh
eXMgY29ubmVjdGVkIGJ1dCBzdG9wcyBzZW5kaW5nIGlucHV0LiBJbiBidG1vbjoNCg0KLSBUaGUg
bGFzdCBBVFQgSGFuZGxlIFZhbHVlIE5vdGlmaWNhdGlvbiBmcm9tIHRoZSBrZXlib2FyZCBpcyBh
DQogIGtleS1kb3duIHJlcG9ydCB3aXRoIG5vIG1hdGNoaW5nIGtleS11cCByZXBvcnQuDQotIEFm
dGVyIHRoYXQsIG5vIG1vcmUgQUNMIGRhdGEgYXJyaXZlcyBmcm9tIHRoZSBrZXlib2FyZCBoYW5k
bGUuDQotIFRoZXJlIGlzIG5vIERpc2Nvbm5lY3QgQ29tcGxldGUgZXZlbnQgYW5kIG5vIHN1cGVy
dmlzaW9uIHRpbWVvdXQuDQotIE90aGVyIExFIGNvbm5lY3Rpb25zIG9uIHRoZSBzYW1lIGNvbnRy
b2xsZXIgKHRoZSBtb3VzZSkga2VlcA0KICBkZWxpdmVyaW5nIGRhdGEgZHVyaW5nIHRoZSBmcmVl
emUuDQotIFRoZSBrZXlib2FyZCBkb2VzIG5vdCBhZHZlcnRpc2UgZHVyaW5nIHRoZSBmcmVlemUu
DQoNClRoZSBvbmx5IHdheSB0byByZWNvdmVyIGlzIHRvIHJlY29ubmVjdCB0aGUga2V5Ym9hcmQg
ZnJvbSB0aGUga2V5Ym9hcmQgc2lkZSAoRGlzY29ubmVjdCBDb21wbGV0ZSwgcmVhc29uIDB4MTMp
LiBUaGUga2VybmVsIGxvZ3MNCiJCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25v
d24gY29ubmVjdGlvbiBoYW5kbGUiIGF0IGVhY2ggcmVjb25uZWN0Lg0KDQpUaGUgc2FtZSBrZXli
b2FyZCB3b3JrcyB3aXRob3V0IHByb2JsZW1zIHdpdGggbWFjT1MsIHdpdGggV2luZG93cyBvbiBh
IGRpZmZlcmVudCBtYWNoaW5lLCBhbmQgd2l0aCBhIHBob25lLg0KDQpDb25uZWN0aW9uIHBhcmFt
ZXRlcnMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhlIGtleWJvYXJkIHNlbmRzIGFuIEwyQ0FQ
IENvbm5lY3Rpb24gUGFyYW1ldGVyIFVwZGF0ZSBSZXF1ZXN0IHJpZ2h0IGFmdGVyIGNvbm5lY3Rp
bmcsIGFuZCB0aGUgaG9zdCBhY2NlcHRzIGl0Og0KDQogIGludGVydmFsIDcuNSBtcywgcGVyaXBo
ZXJhbCBsYXRlbmN5IDQ0LCBzdXBlcnZpc2lvbiB0aW1lb3V0IDE1MDAgbXMNCg0KUnVsZWQgb3V0
IChhbGwgd2l0aCAweDEyN0NfRkQ3OCkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQotIGJ0dXNiIGF1dG9zdXNwZW5kIChwb3dlci9jb250cm9sPW9uKTogc3RpbGwgZnJlZXplcw0K
LSByZWxvYWQgb2YgYnR1c2IgKG5ldyBmaXJtd2FyZSBkb3dubG9hZCk6IGZyZWV6ZXMgYWZ0ZXIg
fjEgbWluDQotIFdpLUZpIHJhZGlvIG9mZiAocmZraWxsIGJsb2NrIHdsYW4sIHdpcmVkIG5ldHdv
cmspOiBmcmVlemVzDQogIGFmdGVyIH40IG1pbg0KLSBOdW0gTG9jayBMRUQgb2ZmIChubyBMRUQg
b3V0cHV0IHJlcG9ydCk6IHN0aWxsIGZyZWV6ZXMNCi0gbmV3IHBhaXJpbmcgb24gYSBkaWZmZXJl
bnQga2V5Ym9hcmQgY2hhbm5lbDogc3RpbGwgZnJlZXplcw0KDQpBL0IgdGVzdA0KLS0tLS0tLS0N
CjEuIDB4MTI3Q19GRDc4IChwYWNrYWdlIGRlZmF1bHQpOiAzIGZyZWV6ZXMgaW4gNiBtaW51dGVz
Lg0KMi4gMHg0MkQzXzRFMDQgY29waWVkIHRvIC9saWIvZmlybXdhcmUvdXBkYXRlcy9ydGxfYnQv
LCBidHVzYg0KICAgcmVsb2FkZWQ6IG5vIGZyZWV6ZSBkdXJpbmcgbm9ybWFsIHVzZS4NCjMuIE92
ZXJyaWRlIHJlbW92ZWQgKGJhY2sgdG8gMHgxMjdDX0ZENzgpLCBidHVzYiByZWxvYWRlZDogZnJl
ZXplDQogICBhZnRlciBhYm91dCAxIG1pbnV0ZS4NCjQuIE92ZXJyaWRlIHJlc3RvcmVkICgweDQy
RDNfNEUwNCk6IG5vIGZyZWV6ZSBhZ2Fpbi4NCg0KSSBjYW4gY2FwdHVyZSBidG1vbiBsb2dzIChi
dHNub29wKSBvZiBhIGZyZWV6ZSBhbmQgdGVzdCBuZXcgZmlybXdhcmUgYnVpbGRzIGlmIHRoYXQg
aGVscHMuDQoNClRoYW5rcywNCkF0aG9zIEFuZHJhZGUNCg==
