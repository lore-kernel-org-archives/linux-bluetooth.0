Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB91BD02E;
	Tue,  1 Oct 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768685; cv=none; b=Mp3mUCCgKYLbsqAeqc3OQeWuIHIqOZ0PalcCFfogv7uUiJ9DuQ0HIYjZJC24Nf/Xdvp9xTWpTomdetBwHtjsRkRz+6IKnbnoBNeFCOHU3PYRANOMo8R2NixZXR/O6Mt+vCkpqwPCDhZjdLRRcmpMeM3ohsCai2fHcQHuOZlW0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768685; c=relaxed/simple;
	bh=/avPBd5p8dKshb31c3T/dHcpDqdJZjXRb5eucMd/iUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZj87d0lqZs7MKJ0Kj/KLiTEqv04g1IVTi7OAYPkdbucD4k07MpoQwgyqpY0tQoerwo4zMklkJ4LcS+2FsYdbuLtKzWGuZSv4u/4wHGncmMxvKgpNekYg9D62u7+qOCIr9uS/eRkEnFA3Y2dozR15fcNGaVu5DSfYcQokf4k6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qq1qiOyD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qq1qiOyD"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4917iAJD1709915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727768650; bh=/avPBd5p8dKshb31c3T/dHcpDqdJZjXRb5eucMd/iUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qq1qiOyDY8fVsHsgKdmEmoJVO1ddhuFD5ZT7k2PmOMlD5dho/RE4fiw3eqAABZT4l
	 MU73DARkUBYElsjvgzQSCb9yyTrJVZQyIEZO/aXsTlVJmbi4TAzbwqzoKxmXB1gdYl
	 LiufaAwFC8WYTyCLeB7WsvBFQvR/qTt+SAu4w1sBNf8aHI0/g0JJC3nrQLZX2sYBMG
	 QwgXAbdvGCxIU+aPhOHOR3Fjj9mpHolaoFKW/CvOWqGeH/mWbKsIz0NKB+VdUXcZjC
	 LxNoLfXcx6EsApYOh7oJjWm5Bisjgb4enBNRgXJci0vwDWcvV5vlkMXsX4fQ3E2ouP
	 Lu4zLm8s9emMQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4917iAJD1709915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 15:44:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 15:44:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 1 Oct 2024 15:44:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 1 Oct 2024 15:44:09 +0800
From: Hilda Wu <hildawu@realtek.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "alex_lu@realsil.com.cn"
	<alex_lu@realsil.com.cn>,
        Max Chou <max.chou@realtek.com>, KidmanLee
	<kidman@realtek.com>,
        "howardchung@google.com" <howardchung@google.com>,
        "apusaka@chromium.org" <apusaka@chromium.org>,
        "yinghsu@chromium.org"
	<yinghsu@chromium.org>,
        "johnlai@google.com" <johnlai@google.com>
Subject: RE: [PATCH] Bluetooth: btrtl: Shorten HCI_OP_RESET timeout
Thread-Topic: [PATCH] Bluetooth: btrtl: Shorten HCI_OP_RESET timeout
Thread-Index: AQHbEKhK6FkCNXoGvUufNlPU/6PTd7Jqqw0AgADIcZA=
Date: Tue, 1 Oct 2024 07:44:09 +0000
Message-ID: <5503c74a64684cdeb7fae6225319fb3c@realtek.com>
References: <20240927064127.4167789-1-hildawu@realtek.com>
 <6e333fc5-cd36-4fed-9704-9e3d69633155@molgen.mpg.de>
In-Reply-To: <6e333fc5-cd36-4fed-9704-9e3d69633155@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIG9waW5pb24uDQpJIGp1c3QgbW9kaWZpZWQg
dGhlIGNvbW1pdCBtZXNzYWdlIHN1bW1hcnkgYW5kIHNlbnQgdjIuDQpQbGVhc2UgY2hlY2sgdGhl
IGZvbGxvd2luZyBjb21tZW50Lg0KVGhhbmtzIGFnYWluLg0KDQpSZWdhcmRzLA0KSGlsZGENCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1v
bGdlbi5tcGcuZGU+IA0KU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjQgMjo0OCBQTQ0K
VG86IEhpbGRhIFd1IDxoaWxkYXd1QHJlYWx0ZWsuY29tPg0KQ2M6IG1hcmNlbEBob2x0bWFubi5v
cmc7IGx1aXouZGVudHpAZ21haWwuY29tOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbGV4X2x1QHJlYWxzaWwuY29tLmNuOyBN
YXggQ2hvdSA8bWF4LmNob3VAcmVhbHRlay5jb20+OyBLaWRtYW5MZWUgPGtpZG1hbkByZWFsdGVr
LmNvbT47IGhvd2FyZGNodW5nQGdvb2dsZS5jb207IGFwdXNha2FAY2hyb21pdW0ub3JnOyB5aW5n
aHN1QGNocm9taXVtLm9yZzsgam9obmxhaUBnb29nbGUuY29tDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBCbHVldG9vdGg6IGJ0cnRsOiBTaG9ydGVuIEhDSV9PUF9SRVNFVCB0aW1lb3V0DQoNCg0KRXh0
ZXJuYWwgbWFpbC4NCg0KDQoNCkRlYXIgSGlsZGEsDQoNCg0KVGhhbmsgeW91IGZvciB5b3VyIHBh
dGNoLg0KDQpBbSAyNy4wOS4yNCB1bSAwODo0MSBzY2hyaWViIEhpbGRhIFd1Og0KPiBTaG9ydGVu
IHRoZSB0aW1lb3V0IGZvciB0aGUgSENJIFJlc2V0IG9uIHNodXRkb3duLg0KDQpXaHk/IEl04oCZ
ZCBiZSBncmVhdCBpZiB5b3UgZWxhYm9yYXRlZCwgYW5kIGRvY3VtZW50ZWQgaG93IHRvIHJlcHJv
ZHVjZSB0aGUgcHJvYmxlbS4NCg0KQWN0dWFsbHksIHRoaXMgcGF0Y2ggaXMgbm90IGZvciBmaXgg
c29tZXRoaW5nIGhhcHBlbiwgYnV0IGEgcHJldmVudGlvbi4NCkxldCB1cHBlciBsYXllciBzdGFj
ayByZWR1Y2UgdGhlIGV4cGVjdGVkIHdhaXRpbmcgdGltZSwgZm9yIHByZXZlbnRpbmcgc3RhY2sg
ZGFlbW9uIGJlIGJsb2NrZWQgYnkgdGhlIHNvY2tldCBjbG9zZSBpZiB0aGlzIGNvdWxkIGhhcHBl
bi4NCg0KV2hhdCBpcyB0aGUgb2xkIGFuZCBuZXcgdGltZW91dCB2YWx1ZT8gRm9yIHRoZSBnaXQg
Y29tbWl0IG1lc3NhZ2Ugc3VtbWFyeSwgbWF5YmUgdXNlOg0KDQpBZGQgY2hhbmdlcy4NCg0KQmx1
ZXRvb3RoOiBidHJ0bDogRGVjcmVhc2UgSENJX09QX1JFU0VUIHRpbWVvdXQgZnJvbSB4IG1zIHRv
IHkgbXMNCg0KQWRkIGNoYW5nZXMuDQoNCj4gU2lnbmVkLW9mZi1ieTogSGlsZGEgV3UgPGhpbGRh
d3VAcmVhbHRlay5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMgfCAy
ICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRydGwuYyANCj4gaW5kZXggMmQ5NWIzZWEwNDZkLi43MTI4YThhMGJhMjUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMNCj4gKysrIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRydGwuYw0KPiBAQCAtMTM3MSw3ICsxMzcxLDcgQEAgaW50IGJ0cnRsX3NodXRkb3du
X3JlYWx0ZWsoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ICAgICAgIC8qIEFjY29yZGluZyB0byB0
aGUgdmVuZG9yIGRyaXZlciwgQlQgbXVzdCBiZSByZXNldCBvbiBjbG9zZSB0byBhdm9pZA0KPiAg
ICAgICAgKiBmaXJtd2FyZSBjcmFzaC4NCj4gICAgICAgICovDQo+IC0gICAgIHNrYiA9IF9faGNp
X2NtZF9zeW5jKGhkZXYsIEhDSV9PUF9SRVNFVCwgMCwgTlVMTCwgSENJX0lOSVRfVElNRU9VVCk7
DQo+ICsgICAgIHNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIEhDSV9PUF9SRVNFVCwgMCwgTlVM
TCwgDQo+ICsgSENJX0NNRF9USU1FT1VUKTsNCj4gICAgICAgaWYgKElTX0VSUihza2IpKSB7DQo+
ICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihza2IpOw0KPiAgICAgICAgICAgICAgIGJ0X2Rl
dl9lcnIoaGRldiwgIkhDSSByZXNldCBkdXJpbmcgc2h1dGRvd24gZmFpbGVkIik7DQoNCg0KS2lu
ZCByZWdhcmRzLA0KDQpQYXVsDQo=
