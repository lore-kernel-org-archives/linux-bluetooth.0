Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598536;
	b=4SR/IeR+5sOxjFG4gV3e3tiGnp6260NGY4cWeN5ry7YNgO9c5r8WxU/gFy1KfvYUwM8x
	 13OW9Yl6ESlrQLjcfugccz9JksvZpuDCdXiOw+yVYgV1wt4tD3VBz8B9/a4EkwE3wIoGO
	 4Pohe39sqBEJTIWxKopKs1/2Vv+l3MR14eSR4WQp/+chKuyE9Uii2XTTiRzVWKX+koydd
	 j32KaOzXLwWjA4qEggiuZDLrb48E09rzqR9eZuXAWY7LyoNvLgCJ+2MtbPZTMCzBFJklN
	 qgKoRXeLfpVt9W5SKei9+AVNOCklV6EV/dSCI9A5IEVPusD1CVR/GQtMpyiAGFzLi7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598536;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=rq9p2DABjCBRXBLBJrXGsekvHgMOukra9e1sZzDgbkQ=;
	b=gdlukJTJQAhGfAaC9+6yy3PNbICvUqVFpvE5kP5ICsdlqpfEE5hZTvPQwtkHhm6U+R93
	 rkoX9/qgBhoybKpIjO1LzW/OZ2my2Tzs8k9+ufaIPzzQYPw5XjOyH0YZvXkYNRqUC0Iqc
	 38juuXmS/R/8EcLihYYUXI/9hs4wMMx7+sofVAH8lUvRZ41Sb4FQPTqucPptuS2OCscrd
	 qszNYRCGOa7BsSM0WlVBEgBul8xysUuI2iIQAp4FQzsOfwCrFeMHDEXvp/oZrr+cjODYC
	 VbzJ4t3JA1yxbmCDeBSQ9dcma8uGSSxNwXEJTX2h9F3mnZ13T5Vum7M14Vm9bwCV5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=qlQi0P4X;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA1606A697;
	Wed, 25 Nov 2026 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BA1606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=qlQi0P4X
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AP9M5gL43338481, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795598525; bh=rq9p2DABjCBRXBLBJrXGsekvHgMOukra9e1sZzDgbkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qlQi0P4XmjFy31o8MB6SLN6lqU1QYDQDnFC5bV6vs6ndg5HF3CfbD3YmAHD5MKlkm
	 PLwPi17ceSXJwsdv/T2v0czBM/pDjJn4/qW8L4iS+PD1aHoZ4fipjbrQ8kWgfxAXkk
	 3EBS5uGI6e0cnbbOG5wAuhHBQNjX+Q9rfZcCX6yyF1xRS214uJMy9xt2WHa/0zxnO0
	 RLIUI5k59lq7eb7V2bxnvfQ/AKpxmVuvqFgvB4ZKSqoTZG7J5wE5paSxWwCOGAkftO
	 13AotIOwksuTOs9FwC7V5drISN/eC+nAgEq4G4kIrYfrnKIWL5pza2B+Lc2pOXClxG
	 q/3dfa2K7YQqw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AP9M5gL43338481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 17:22:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 17:22:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 17:22:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::59f9:8723:adda:65e3]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::59f9:8723:adda:65e3%4]) with mapi id
 15.02.2562.056; Wed, 25 Nov 2026 17:22:05 +0800
From: Hilda Wu <hildawu@realtek.com>
To: =?utf-8?B?VmV5c2kgw5Z6Z8O8bg==?= <veysiiozgun@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alex_lu@realsil.com.cn"
	<alex_lu@realsil.com.cn>, jason_mao <jason_mao@realsil.com.cn>, zoey_zhou
	<zoey_zhou@realsil.com.cn>, Max Chou <max.chou@realtek.com>, KidmanLee
	<kidman@realtek.com>, Chih-Hsiang Wang <wangchihhs@realtek.com>
Subject: RE: [PATCH v8] Bluetooth: btrtl: Add firmware format v3 support
Thread-Topic: [PATCH v8] Bluetooth: btrtl: Add firmware format v3 support
Thread-Index: AQHdS0iiEi48WCGVikyP1HpKqbabDLbgZq2AgF5+XeA=
Date: Wed, 25 Nov 2026 09:22:05 +0000
Message-ID: <a6278aece1a844179b23fd2e35c572a0@realtek.com>
References: <20260923104521.1706251-1-hildawu@realtek.com>
 <20260926141653.4994-1-veysiiozgun@gmail.com>
In-Reply-To: <20260926141653.4994-1-veysiiozgun@gmail.com>
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

SGkgVmV5c2ksDQoNClRoYW5rcyBmb3IgdGVzdGluZyB2OC4gdjExIGhhcyBjb2RlIGNoYW5nZXMg
aW4gZHJpdmVycy9ibHVldG9vdGgvYnRydGxfbWFpbi5jIChidHJ0bC5jIHJlbmFtZSB0byBidHJ0
bF9tYWluLmMpLCANCnNvIEkgZHJvcHBlZCB5b3VyIFRlc3RlZC1ieSBmb3Igbm93LiBDb3VsZCB5
b3UgZ2l2ZSB2MTEgYSB0cnkgd2hlbiB5b3UgaGF2ZSB0aW1lPw0KDQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3RoL3BhdGNoLzIwMjYxMTI1MDg0NzAzLjE1Nzg2
MDEtMi1oaWxkYXd1QHJlYWx0ZWsuY29tLw0KDQpJZiBpdCBzdGlsbCB3b3JrcyBmb3IgeW91LCBh
IG5ldyBUZXN0ZWQtYnkgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4NClRoYW5rIHlvdSBhZ2Fp
bi4NCg0KUmVnYXJkcywNCkhpbGRhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBWZXlzaSDDlnpnw7xuIDx2ZXlzaWlvemd1bkBnbWFpbC5jb20+IA0KU2VudDogU2F0dXJkYXks
IFNlcHRlbWJlciAyNiwgMjAyNiAxMDoxNyBQTQ0KVG86IEhpbGRhIFd1IDxoaWxkYXd1QHJlYWx0
ZWsuY29tPg0KQ2M6IG1hcmNlbEBob2x0bWFubi5vcmc7IGx1aXouZGVudHpAZ21haWwuY29tOyBs
aW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBhbGV4X2x1QHJlYWxzaWwuY29tLmNuOyBqYXNvbl9tYW8gPGphc29uX21hb0ByZWFsc2ls
LmNvbS5jbj47IHpvZXlfemhvdSA8em9leV96aG91QHJlYWxzaWwuY29tLmNuPjsgTWF4IENob3Ug
PG1heC5jaG91QHJlYWx0ZWsuY29tPjsgS2lkbWFuTGVlIDxraWRtYW5AcmVhbHRlay5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIHY4XSBCbHVldG9vdGg6IGJ0cnRsOiBBZGQgZmlybXdhcmUgZm9y
bWF0IHYzIHN1cHBvcnQNCg0KDQpFeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgcmVwbHksIGNsaWNrIGxpbmtz
LCBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5k
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNCkhpIEhpbGRhLA0KDQpJIHRlc3RlZCB2
OCBvbiBhIExlbm92byBMT1EgMTVBUlAxMEUgKDgzUzApIHdpdGggdGhlIFJUTDg4NTJCVSBjb250
cm9sbGVyICgwYmRhOmI4NTMsIGhjaV9yZXYgMHgwMDBiLCBsbXBfc3VidmVyIDB4ODg1Miwgcm9t
X3ZlcnNpb24gMykuDQpXaXRoIHRoZSBjdXJyZW50IGxpbnV4LWZpcm13YXJlIHRoaXMgY29udHJv
bGxlciBuZXZlciBjb21lcyB1cCwgYXMgcmVwb3J0ZWQgaW4gWzFdLg0KDQpTZXR1cDoNCi0gS2Vy
bmVsIDcuMS41IChLYWxpKS4gSSBhcHBsaWVkIHY4IHRvIGRyaXZlcnMvYmx1ZXRvb3RoIGZyb20g
dGhhdA0KICB0cmVlLiBUaGUgb25seSBjb25mbGljdCB3YXMgaW4gYnR1c2IuYyAoYnR1c2JfbWFp
bi5jIHVwc3RyZWFtKTsgSQ0KICBhcHBsaWVkIHRoZSBidHVzYl9yZWN2X2V2ZW50X3JlYWx0ZWso
KSBjaGFuZ2UgdGhlcmUgYnkgaGFuZC4gYnRydGwuYywNCiAgYnRydGwuaCwgYnRydGxfZW5oLmMg
YW5kIHRoZSBNYWtlZmlsZSBhcHBsaWVkIGFzIGlzLg0KLSBGaXJtd2FyZTogcnRsODg1MmJkX21w
X2NoaXBfbmV3LmRhdCBmcm9tIHRoZSBXaW5kb3dzIGRyaXZlcg0KICAxOC40MDMyLjAuMzAwOCwg
aW5zdGFsbGVkIHVuY2hhbmdlZCBhcyBydGxfYnQvcnRsODg1MmJ1X2Z3LmJpbi4NCg0KUmVzdWx0
Og0KICBSVEw6IHN1YnNlY3Rpb24gKDAwMDA6MDApLCBjaGlwIGlkIDIwLCBjdXQgMHgwNCwgbGVu
IDAwMDBmMDcwDQogIFJUTDogc3Vic2VjdGlvbiAoMDAwMDowMSksIGNoaXAgaWQgMjAsIGN1dCAw
eDA0LCBsZW4gMDAwMDAyMzgNCiAgUlRMOiBzdWJzZWN0aW9uICgwMDAwOjAyKSwgY2hpcCBpZCAy
MCwgY3V0IDB4MDQsIGxlbiAwMDAwMGI1NA0KICBSVEw6IGZpcm13YXJlIHNlY3Rpb24gcGF5bG9h
ZCB0b3RhbCBsZW46IDB4MDAwMGZkZmMNCiAgUlRMOiBXYXRjaGRvZyByZXNldCBzdGF0dXMgMDAN
CiAgUlRMOiBmdyB2ZXJzaW9uIDB4M2M5MTk1MGUNCg0KVGhlIGNvbnRyb2xsZXIgcmVnaXN0ZXJz
IHdpdGggbWdtdCB3aXRoIGl0cyByZWFsIEJEX0FERFIuIEkgdGVzdGVkOg0KLSBzY2FubmluZyAo
bmVhcmJ5IEJSL0VEUiBhbmQgTEUgZGV2aWNlcyBzaG93IHVwKQ0KLSBwYWlyaW5nIGFuZCBjb25u
ZWN0aW5nIGEgaGVhZHNldCAoR2FsYXh5IEJ1ZHM0IFBybyksIGF1ZGlvIG92ZXINCiAgQTJEUCAo
U0JDKQ0KLSBjb2xkIGJvb3Q6IHRoZSBmaXJtd2FyZSBsb2FkcyBmcm9tIHNjcmF0Y2ggYW5kIHRo
ZSBoZWFkc2V0IHJlY29ubmVjdHMNCi0gc3VzcGVuZC9yZXN1bWUgKHMyaWRsZSk6IHRoZSBmaXJt
d2FyZSBpcyBsb2FkZWQgYWdhaW4gb24gcmVzdW1lIGFuZA0KICB0aGUgaGVhZHNldCByZWNvbm5l
Y3RzDQpUaGVyZSBhcmUgbm8gYnR1c2IvYnRydGwgZXJyb3JzIGluIGRtZXNnLg0KDQpUaGlzIGFs
c28gYW5zd2VycyBteSBtYWlsIGluIFsxXTogdjggYWxyZWFkeSBpbXBsZW1lbnRzIHRoZSAweGZj
NjIgc2VxdWVuY2UgSSBzYXcgaW4gdGhlIFdpbmRvd3MgVVNCIGNhcHR1cmUsIHNvIHBsZWFzZSBp
Z25vcmUgbXkgcXVlc3Rpb24gdGhlcmUuDQoNClRlc3RlZC1ieTogVmV5c2kgw5Z6Z8O8biA8dmV5
c2lpb3pndW5AZ21haWwuY29tPg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
Ymx1ZXRvb3RoLzIwMjYwOTI2MTM1MjE5LjEzOTI1LTEtdmV5c2lpb3pndW5AZ21haWwuY29tLw0K
DQpUaGFua3MsDQpWZXlzaQ0K
