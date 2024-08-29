Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747FA95E;
	Thu, 29 Aug 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920804; cv=none; b=NZzdsJhRTjOLyZAWqzTbm4PaPixB1h2l+DTH8SDGeQJHCZcwdyp4SuAy9o6xjdtt32ifxDJYHZ0bM1KZKbZSPQICSqt7ExhSkC5OGVyk/eLyjOP44tLzJQZa1v3D/B3JIDaTnoutBk5GsS2BafbOh5HJCUbk5B2U6nPBePfx1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920804; c=relaxed/simple;
	bh=nYm7k/bU2XBFM5zBHvUSt+A9ANU/1URLWURTjWOEBsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMCnVJ6uQJYxDsCOGnJ1S/GmRZutjgXkN1yKw6hPuhejhbFFCHsj+OcF2cd4Jc5rY+KsGZP21Qc4gCCw6lYjMES+hiRsIWzeF3jWVBAJ4oBHINUM6erzNjS+0e7SR+Q2rf1NkFp+c51w5WfsMtCxgKj0GxQQIep1syoiuW4/ASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=trtS3KR3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="trtS3KR3"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T8dUgW53355613, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724920770; bh=nYm7k/bU2XBFM5zBHvUSt+A9ANU/1URLWURTjWOEBsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=trtS3KR3nyMIAqbSzFQm930OSCqyzfjLFJ2a/GOnueF4DpMBkawkEIMo4Eh6JSglr
	 cBEK2z2KWa9VoQ//XmurpFpomx2e+yv9qOY+Cj6CTy2Nqub4SKcZc7EnQp+0jjaFBc
	 nXfFLLpXOCpqJErmJzAFXZZVOYMolKJDYLEtpLzUaaKIRjaQ/fTnXUACiCqtbEkYtZ
	 wDImBk3c4/X0C8T9IndVsgTgv8mO/gNEitHzLcAkyGTa/QbLNzRUE3b5RKw6fo9QmG
	 qKmC77fLKkOXzgsrOb+E9P1p3twcg1HknbyQt5nh7PDhCLGWzjJYUYdnzV9oHSw1z6
	 b0c7Rl+KxfM0Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T8dUgW53355613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:39:30 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 16:39:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Aug 2024 16:39:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 29 Aug 2024 16:39:29 +0800
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
	<kidman@realtek.com>
Subject: RE: [PATCH v3] Bluetooth: btrtl: Set msft ext address filter quirk
Thread-Topic: [PATCH v3] Bluetooth: btrtl: Set msft ext address filter quirk
Thread-Index: AQHa+cYJjXc6wB+kB0ONYbe9oAOxjrI9O5aAgACbPAA=
Date: Thu, 29 Aug 2024 08:39:29 +0000
Message-ID: <62d8718a7c134596a8d3ffea26d490b2@realtek.com>
References: <20240829034627.676529-1-hildawu@realtek.com>
 <83b72389-e12b-4224-aed7-736880e2877f@molgen.mpg.de>
In-Reply-To: <83b72389-e12b-4224-aed7-736880e2877f@molgen.mpg.de>
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

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KSSB3aWxsIHNlbmQgdGhlIFY0
IGFuZCBwbGVhc2UgY2hlY2sgbXkgY29tbWVudCBhcyBiZWxvdy4gVGhhbmsgeW91IGFnYWluLg0K
DQpSZWdhcmRzLA0KSGlsZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBh
dWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+IA0KU2VudDogVGh1cnNkYXksIEF1Z3Vz
dCAyOSwgMjAyNCAyOjE0IFBNDQpUbzogSGlsZGEgV3UgPGhpbGRhd3VAcmVhbHRlay5jb20+DQpD
YzogbWFyY2VsQGhvbHRtYW5uLm9yZzsgbHVpei5kZW50ekBnbWFpbC5jb207IGxpbnV4LWJsdWV0
b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFsZXhf
bHVAcmVhbHNpbC5jb20uY247IE1heCBDaG91IDxtYXguY2hvdUByZWFsdGVrLmNvbT47IEtpZG1h
bkxlZSA8a2lkbWFuQHJlYWx0ZWsuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2M10gQmx1ZXRv
b3RoOiBidHJ0bDogU2V0IG1zZnQgZXh0IGFkZHJlc3MgZmlsdGVyIHF1aXJrDQoNCg0KRXh0ZXJu
YWwgbWFpbC4NCg0KDQoNCkRlYXIgSGlsZGEsDQoNCg0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNo
Lg0KDQpBbSAyOS4wOC4yNCB1bSAwNTo0NiBzY2hyaWViIEhpbGRhIFd1Og0KPiBGb3IgdHJhY2tp
bmcgbXVsdGlwbGUgZGV2aWNlcyBjb25jdXJyZW50bHkgd2l0aCBhIGNvbmRpdGlvbi4NCj4gVGhl
IHBhdGNoIGVuYWJsZXMgdGhlIEhDSV9RVUlSS19VU0VfTVNGVF9FWFRfQUREUkVTU19GSUxURVIg
cXVpcmsgb24gDQo+IFJUTDg4NTJCIGNvbnRyb2xsZXIuDQoNClBsZWFzZSBhZGQgdGhlIGNvbnRy
b2xsZXIgbmFtZSBhbHNvIHRvIHRoZSBjb21taXQgbWVzc2FnZSBzdW1tYXJ5Lg0KDQpVcGRhdGVk
IGluIHY0Lg0KDQo+IFRoZSBxdWlyayBzZXR0aW5nIGlzIGJhc2VkIG9uIHRoaXMgY29tbWl0Lg0K
PiBDb21taXQgOWUxNDYwNmQ4ZjM4ICgiQmx1ZXRvb3RoOiBtc2Z0OiBFeHRlbmRlZCBtb25pdG9y
IHRyYWNraW5nIGJ5IA0KPiBhZGRyZXNzIGZpbHRlciIpDQoNCuKApiBpcyBiYXNlZCBvbiBjb21t
aXQgOWUxNDYwNmQ4ZjM4ICgiQmx1ZXRvb3RoOiBtc2Z0OiBFeHRlbmRlZCBtb25pdG9yIHRyYWNr
aW5nIGJ5IGFkZHJlc3MgZmlsdGVyIikuDQoNClVwZGF0ZWQgaW4gdjQuDQoNCj4gV2l0aCB0aGlz
IHNldHRpbmcsIHdoZW4gYSBwYXR0ZXJuIG1vbml0b3IgZGV0ZWN0cyBhIGRldmljZSwgdGhpcyAN
Cj4gZmVhdHVyZSBpc3N1ZXMgYW4gYWRkcmVzcyBtb25pdG9yIGZvciB0cmFja2luZyB0aGF0IGRl
dmljZS4gTGV0IHRoZSANCj4gb3JpZ2luYWwgcGF0dGVybiBtb25pdG9yIGNhbiBrZWVwIG1vbml0
b3IgbmV3IGRldmljZXMuDQoNClJlbW92ZSAqY2FuKj8NCg0KVXBkYXRlZCBpbiB2NC4NCg0KUGxl
YXNlIHBhc3RlIHBvc3NpYmxlIExpbnV4IG1lc3NhZ2UgYmVmb3JlL2FmdGVyIHRoZSBjb21taXQg
aW50byB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClRoZXJlIHdpbGwgbm8gbWVzc2FnZXMgYWZ0ZXIg
dGhlIGNvbW1pdC4NClJlbGF0ZWQgTGludXggbWVzc2FnZSBpcyB3aGVuIHVzaW5nIE1TRlQgZXh0
IGFuZCB0dXJuaW5nIG9uIERFQlVHIGxvZywgdGhlIG1lc3NhZ2Ugc2hvd3Mgd2hlbiBhZGQgb3Ig
Y2FuY2VsIGFuIGFkZHJlc3MgZmlsdGVyIHdoZW4gcmVjZWl2aW5nIGEgTEUgbW9uaXRvciBkZXZp
Y2UgZXZlbnQuDQpERUJVRyBrZXJuZWw6IFsgNTI2My44OTcyOThdIEJsdWV0b290aDogbXNmdF9t
b25pdG9yX2RldmljZV9ldnQoKSBoY2kwOiBNU0ZUIHZlbmRvciBldmVudCAweDAyOiBoYW5kbGUg
MHgwMDAwIHN0YXRlIDEgYWRkciBjNDowNTpjNDowNTowMDowMA0KREVCVUcga2VybmVsOiBbIDUy
NjMuODk3MzA2XSBCbHVldG9vdGg6IG1zZnRfYWRkX2FkZHJlc3NfZmlsdGVyKCkgaGNpMDogTVNG
VDogQWRkIGRldmljZSBjNDowNTpjNDowNTowMDowMCBhZGRyZXNzIGZpbHRlcg0KDQpERUJVRyBr
ZXJuZWw6IFsgNTMyNC45ODEwNTJdIEJsdWV0b290aDogbXNmdF9tb25pdG9yX2RldmljZV9ldnQo
KSBoY2kwOiBNU0ZUIHZlbmRvciBldmVudCAweDAyOiBoYW5kbGUgMHgwMDAzIHN0YXRlIDAgYWRk
ciBjNDowNTpjNDowNTowMDowMA0KREVCVUcga2VybmVsOiBbIDUzMjQuOTgyODQ3XSBCbHVldG9v
dGg6IG1zZnRfY2FuY2VsX2FkZHJlc3NfZmlsdGVyX3N5bmMoKSBoY2kwOiBNU0ZUOiBDYW5jZWxl
ZCBkZXZpY2UgYzQ6MDU6YzQ6MDU6MDA6MDAgYWRkcmVzcyBmaWx0ZXINCg0KPiBTaWduZWQtb2Zm
LWJ5OiBIaWxkYSBXdSA8aGlsZGF3dUByZWFsdGVrLmNvbT4NCj4gLS0tDQo+IENoYW5nZToNCj4g
djM6IGVkaXQgY29tbWl0IGxvZyBhbmQgdGl0bGUNCj4gdjI6IEFkZCByZWZlcmVuY2UgY29tbWl0
LCB1cGRhdGUgY29tbWl0IGRlc2NyaXB0aW9uDQo+IC0tLQ0KPiAtLS0NCj4gICBkcml2ZXJzL2Js
dWV0b290aC9idHJ0bC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jIGIvZHJpdmVycy9i
bHVldG9vdGgvYnRydGwuYyANCj4gaW5kZXggNGMwZjU1MWE5OTc1Li4yZDk1YjNlYTA0NmQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMNCj4gKysrIGIvZHJpdmVycy9i
bHVldG9vdGgvYnRydGwuYw0KPiBAQCAtMTMwOCw2ICsxMzA4LDcgQEAgdm9pZCBidHJ0bF9zZXRf
cXVpcmtzKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3QgYnRydGxfZGV2aWNlX2luZm8gKmJ0
cnRsX2RldikNCj4gICAgICAgICAgICAgICAgICAgICAgIGJ0cmVhbHRla19zZXRfZmxhZyhoZGV2
LCANCj4gUkVBTFRFS19BTFQ2X0NPTlRJTlVPVVNfVFhfQ0hJUCk7DQo+DQo+ICAgICAgICAgICAg
ICAgaWYgKGJ0cnRsX2Rldi0+cHJvamVjdF9pZCA9PSBDSElQX0lEXzg4NTJBIHx8DQo+ICsgICAg
ICAgICAgICAgICAgIGJ0cnRsX2Rldi0+cHJvamVjdF9pZCA9PSBDSElQX0lEXzg4NTJCIHx8DQo+
ICAgICAgICAgICAgICAgICAgIGJ0cnRsX2Rldi0+cHJvamVjdF9pZCA9PSBDSElQX0lEXzg4NTJD
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfVVNFX01TRlRfRVhU
X0FERFJFU1NfRklMVEVSLCANCj4gJmhkZXYtPnF1aXJrcyk7DQoNCg0KS2luZCByZWdhcmRzLA0K
DQpQYXVsDQo=
