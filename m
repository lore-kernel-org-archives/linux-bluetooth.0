Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA513B5AF;
	Fri,  4 Oct 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028780; cv=none; b=VIoApTDguuytUDEadBlhvFCK00LUfN0wR3Jyfu8ju6sOtG42qwHgQJyBfZ+LpiOcjD49PIQ8wFqSV7H+3S4ck5aCWBzvoBQ30qQu7xaUY4amA/2FfnzUKDqdrU8SoAfmybNPNREpFreOuCh4Q7Q7unAabgJ5QXOaDnFBap6nuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028780; c=relaxed/simple;
	bh=0q+P4Cd7WWffXaGtq9TXUriT1nDvca/KArHC0acGhU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HfzQIBxQnD5r6IaJM0CLUg0DhfpZA0nO+fAPfp4QiBM4clB8MXxjEYsY4cWT0I7pLMKBYDShlJKEozqR8JvPgtfs94a9jCfVafJcxY4Db3fUJZPuzKOCvlzZ0cm+rXdeIdWfsDvnyxpa8UPSFovfL9G2+Ug6wwEjL0xT4Gcx5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iJ2yC9fY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iJ2yC9fY"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4947uerpF1193073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728028601; bh=0q+P4Cd7WWffXaGtq9TXUriT1nDvca/KArHC0acGhU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iJ2yC9fY2YIK9+zmv5X83HX+os8w1Xv6z6RhgDd4QBKSK2VYvL2W23mt58SeMbLuF
	 /o1TuFT6haeEoXVtDm2NOW/zjykLQwDexOqr1qyw0SAbwUmF1n/m/Xc2beICh8RaLp
	 vG9NrhuToUTRxGiHCglGz+gcf/2DhFJlM4oadW72oaSOG/6AvsN5nXOjRhuJ6Pbemq
	 xT32LQ4F3UH70zhEuOEi8K/4GZqj+glpFoolQ8daUnF6PKbQgJZHMXrbY46X0rFkyp
	 ees9O+agL9OdyaJ5UakqiLoruiGTaayzdiWtvSD896pT8YGoQ4O/vVFu9qX+/Mw15B
	 WyPK6v61ILdug==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4947uerpF1193073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 15:56:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:56:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Oct 2024 15:56:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 4 Oct 2024 15:56:37 +0800
From: Hilda Wu <hildawu@realtek.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Max Chou
	<max.chou@realtek.com>, KidmanLee <kidman@realtek.com>,
        "howardchung@google.com" <howardchung@google.com>,
        "apusaka@chromium.org"
	<apusaka@chromium.org>,
        "yinghsu@chromium.org" <yinghsu@chromium.org>,
        "johnlai@google.com" <johnlai@google.com>
Subject: RE: [PATCH v2] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s
Thread-Topic: [PATCH v2] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from
 10 s to 2 s
Thread-Index: AQHbE9Wk8o1hnErfykagER9qhaLU37Jxf5OAgAS0QOA=
Date: Fri, 4 Oct 2024 07:56:37 +0000
Message-ID: <0590e0edfe5d453f925d5fdb2ab96cc3@realtek.com>
References: <20241001074339.1160157-1-hildawu@realtek.com>
 <CABBYNZJj+gtmSUUz4gUigkg3GUaBuR29jEU=ZxKjxu7cPSv1Yw@mail.gmail.com>
In-Reply-To: <CABBYNZJj+gtmSUUz4gUigkg3GUaBuR29jEU=ZxKjxu7cPSv1Yw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTHVpeiwNCg0KWWVzLCBwbGVhc2UuDQpUaGlzIGlzIGluZGVlZCB3aGF0IEkgd2FudCB0byBl
eHByZXNzLg0KVGhhbmsgeW91IGZvciB5b3VyIGhlbHAuDQoNClJlZ2FyZHMsDQpIaWxkYQ0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8
bHVpei5kZW50ekBnbWFpbC5jb20+IA0KU2VudDogVHVlc2RheSwgT2N0b2JlciAxLCAyMDI0IDEx
OjI5IFBNDQpUbzogSGlsZGEgV3UgPGhpbGRhd3VAcmVhbHRlay5jb20+DQpDYzogbWFyY2VsQGhv
bHRtYW5uLm9yZzsgbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgYWxleF9sdUByZWFsc2lsLmNvbS5jbjsgTWF4IENob3UgPG1heC5j
aG91QHJlYWx0ZWsuY29tPjsgS2lkbWFuTGVlIDxraWRtYW5AcmVhbHRlay5jb20+OyBob3dhcmRj
aHVuZ0Bnb29nbGUuY29tOyBhcHVzYWthQGNocm9taXVtLm9yZzsgeWluZ2hzdUBjaHJvbWl1bS5v
cmc7IGpvaG5sYWlAZ29vZ2xlLmNvbQ0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gQmx1ZXRvb3Ro
OiBidHJ0bDogRGVjcmVhc2UgSENJX09QX1JFU0VUIHRpbWVvdXQgZnJvbSAxMCBzIHRvIDIgcw0K
DQoNCkV4dGVybmFsIG1haWwuDQoNCg0KDQpIaSBIaWxkYSwNCg0KT24gVHVlLCBPY3QgMSwgMjAy
NCBhdCAzOjQz4oCvQU0gSGlsZGEgV3UgPGhpbGRhd3VAcmVhbHRlay5jb20+IHdyb3RlOg0KPg0K
PiBUaGUgb3JpZ2luYWwgdGltZW91dCBzZXR0aW5nIGZvciBIQ0kgUmVzZXQgb24gc2h1dGRvd24g
aXMgMTAgc2Vjb25kcy4NCj4gU2luY2UgdGhlIEhDSSBSZXNldCBwcm9jZXNzaW5nIHRpbWUgaXMg
c29vbiwgc28gZGVjcmVhc2UgdGhlIHRpbWVvdXQgDQo+IHRvIDIgc2Vjb25kcyBmb3IgSENJIFJl
c2V0IG9uIHNodXRkb3duLg0KDQpJIGd1ZXNzIHlvdSBhcmUgc2F5aW5nIHRoYXQgSENJIFJlc2V0
IHNob3VsZG4ndCB0YWtlIDEwIHNlY29uZHMgdG8gY29tcGxldGUgc28gaW5zdGVhZCB1c2UgdGhl
IGRlZmF1bHQgdGltZW91dCBmb3IgY29tbWFuZHMuIEkgY2FuIHVwZGF0ZSB0aGUgZGVzY3JpcHRp
b24gbXlzZWxmIGlmIHlvdSBhZ3JlZSB0byB1c2UgdGhlIGFib3ZlIHNlbnRlbmNlLg0KDQo+IFNp
Z25lZC1vZmYtYnk6IEhpbGRhIFd1IDxoaWxkYXd1QHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gVjEg
LT4gVjI6IE1vZGlmeSBjb21taXQgbWVzc2FnZSBhbmQgc3VtbWFyeQ0KPiAtLS0NCj4gLS0tDQo+
ICBkcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Js
dWV0b290aC9idHJ0bC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYyANCj4gaW5kZXggMmQ5
NWIzZWEwNDZkLi43MTI4YThhMGJhMjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0cnRsLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYw0KPiBAQCAtMTM3MSw3
ICsxMzcxLDcgQEAgaW50IGJ0cnRsX3NodXRkb3duX3JlYWx0ZWsoc3RydWN0IGhjaV9kZXYgKmhk
ZXYpDQo+ICAgICAgICAgLyogQWNjb3JkaW5nIHRvIHRoZSB2ZW5kb3IgZHJpdmVyLCBCVCBtdXN0
IGJlIHJlc2V0IG9uIGNsb3NlIHRvIGF2b2lkDQo+ICAgICAgICAgICogZmlybXdhcmUgY3Jhc2gu
DQo+ICAgICAgICAgICovDQo+IC0gICAgICAgc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwgSENJ
X09QX1JFU0VULCAwLCBOVUxMLCBIQ0lfSU5JVF9USU1FT1VUKTsNCj4gKyAgICAgICBza2IgPSBf
X2hjaV9jbWRfc3luYyhoZGV2LCBIQ0lfT1BfUkVTRVQsIDAsIE5VTEwsIA0KPiArIEhDSV9DTURf
VElNRU9VVCk7DQo+ICAgICAgICAgaWYgKElTX0VSUihza2IpKSB7DQo+ICAgICAgICAgICAgICAg
ICByZXQgPSBQVFJfRVJSKHNrYik7DQo+ICAgICAgICAgICAgICAgICBidF9kZXZfZXJyKGhkZXYs
ICJIQ0kgcmVzZXQgZHVyaW5nIHNodXRkb3duIGZhaWxlZCIpOw0KPiAtLQ0KPiAyLjM0LjENCj4N
Cg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
