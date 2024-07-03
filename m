Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3229D1C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995525; cv=none; b=Pi9pwUa08EZZtmUgycbZ1J1JafY1akwtyya9AncdaDxp0TJ0S/9DKlrRWuJfVhYynuXI5KXYwGDEsQaT9UqoQr7d4tAPqjoXSJUFkfgSlAhGurUb1egJEfl1CX4AwKyGy8bKrr6rBppWxiTosDt0Xpah3NZisRXHhrqYstQk2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995525; c=relaxed/simple;
	bh=Tl6xHBJkgv5XVAV96HxaAKhvNpt1Zmc6cRcWgq20skY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrK1/WaMmRHap9Tw/3vPxJ5b21ZYAyE8N8u6WlzZpFetEMWsOjBJJICt013GypI/N1nl3LeH40ia62CXvTqyzJ4llunB11Hu+5vVCSE8TgstRdF5i0w0Oeg9b0czKmVWvOqAuSoa6Hhz4N51Q7nSlCtLjiM703JblWg/jaOMEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 11:31:55 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Wed, 3 Jul 2024 11:31:56 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to
 sock_io_send()
Thread-Topic: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to
 sock_io_send()
Thread-Index: AQHazIWHHSPkVYVEa0KJ0GfCqDEMKrHjVdmAgAElvYA=
Date: Wed, 3 Jul 2024 08:31:56 +0000
Message-ID: <5700318c65b6592028b7fae2745b4bd1998bc1fe.camel@omp.ru>
References: <20240702134106.102024-1-r.smirnov@omp.ru>
	 <CABBYNZLZ1D5ujf938c00mNqNPdG+RXBScQnAZw9FYB3zrLTr7g@mail.gmail.com>
In-Reply-To: <CABBYNZLZ1D5ujf938c00mNqNPdG+RXBScQnAZw9FYB3zrLTr7g@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 7/3/2024 6:47:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5545D271CEA37499774D8A618D31D2E@omp.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDExOjAwIC0wNDAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBIaSBSb21hbiwNCj4gDQo+IE9uIFR1ZSwgSnVsIDIsIDIwMjQgYXQgOTo0MeKA
r0FNIFJvbWFuIFNtaXJub3YgPHIuc21pcm5vdkBvbXAucnU+IHdyb3RlOg0KPiA+IA0KPiA+IEl0
IGlzIG5lY2Vzc2FyeSB0byBhZGQgYSByZXR1cm4gdmFsdWUgY2hlY2suDQo+ID4gDQo+ID4gRm91
bmQgd2l0aCB0aGUgU1ZBQ0Ugc3RhdGljIGFuYWx5c2lzIHRvb2wuDQo+ID4gLS0tDQo+ID4gwqBz
cmMvZ2F0dC1kYXRhYmFzZS5jIHwgOSArKysrKysrKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc3Jj
L2dhdHQtZGF0YWJhc2UuYyBiL3NyYy9nYXR0LWRhdGFiYXNlLmMNCj4gPiBpbmRleCA1NzU2ZWI5
ZDEuLjk5YWE2YjYzYSAxMDA2NDQNCj4gPiAtLS0gYS9zcmMvZ2F0dC1kYXRhYmFzZS5jDQo+ID4g
KysrIGIvc3JjL2dhdHQtZGF0YWJhc2UuYw0KPiA+IEBAIC0yNjI1LDYgKzI2MjUsNyBAQCBzdGF0
aWMgaW50IHNvY2tfaW9fc2VuZChzdHJ1Y3QgaW8gKmlvLCBjb25zdCB2b2lkICpkYXRhLCBzaXpl
X3QgbGVuKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtc2doZHIgbXNnOw0K
PiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb3ZlYyBpb3Y7DQo+ID4gK8KgwqDCoMKgwqDCoCBp
bnQgZmQ7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgaW92Lmlvdl9iYXNlID0gKHZvaWQgKikg
ZGF0YTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBpb3YuaW92X2xlbiA9IGxlbjsNCj4gPiBAQCAtMjYz
Myw3ICsyNjM0LDEzIEBAIHN0YXRpYyBpbnQgc29ja19pb19zZW5kKHN0cnVjdCBpbyAqaW8sIGNv
bnN0IHZvaWQgKmRhdGEsIHNpemVfdCBsZW4pDQo+ID4gwqDCoMKgwqDCoMKgwqAgbXNnLm1zZ19p
b3YgPSAmaW92Ow0KPiA+IMKgwqDCoMKgwqDCoMKgIG1zZy5tc2dfaW92bGVuID0gMTsNCj4gPiAN
Cj4gPiAtwqDCoMKgwqDCoMKgIHJldHVybiBzZW5kbXNnKGlvX2dldF9mZChpbyksICZtc2csIE1T
R19OT1NJR05BTCk7DQo+ID4gK8KgwqDCoMKgwqDCoCBmZCA9IGlvX2dldF9mZChpbyk7DQo+ID4g
K8KgwqDCoMKgwqDCoCBpZiAoZmQgPCAwKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZXJyb3IoImlvX2dldF9mZCgpIHJldHVybmVkICVkXG4iLCBmZCk7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZkOw0KPiA+ICvCoMKgwqDCoMKgwqAgfQ0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIHJldHVybiBzZW5kbXNnKGZkLCAmbXNnLCBNU0dfTk9T
SUdOQUwpOw0KPiA+IMKgfQ0KPiANCj4gU28gc3RhdGljIGFuYWx5emVycyBhcmUgY29tcGxhaW5p
bmcgdGhhdCB3ZSBwYXNzIGEgbmVnYXRpdmUgZmQgdG8gdGhlDQo+IGxpa2VzIG9mIHNlbmRtc2c/
IEkgYXNzdW1lIHRoYXQgaXQgd2FzIHNhZmUgdG8gcGFzcyBpdCB0aGlzIHdheSBzaW5jZQ0KPiB0
aGUgc2VuZG1zZyB3b3VsZCBjaGVjayB0aGF0IGZkIGlzIHZhbGlkIGFuZCByZXR1cm4gYW4gZXJy
b3IsIGFueXdheQ0KPiBpdCBpcyB2YWxpZCBwb2ludCB0aGF0IGlmIHdlIGNhdGNoIGl0IGVhcmxp
ZXIgdGhhbiB3ZSBjYW4gcHJpbnQgYQ0KPiBzcGVjaWZpYyBlcnJvciByYXRoZXIgdGhlbiBkZXBl
bmQgb24gc2VuZG1zZyByZXR1cm4sIGp1c3Qgd29uZGVyaW5nDQo+IHdoYXQgaXMgdGhlIHN0YXRp
YyBhbmFseXplciB0cnlpbmcgdG8gZG8gd2l0aCByZXNwZWN0IHRvIGNoZWNraW5nIHRoZQ0KPiB2
YWx1ZXMgcGFzc2VkIHRvIHN5c2NhbGxzLg0KDQpGcm9tIHRoZSBhbmFseXplcidzIHBvaW50IG9m
IHZpZXcsIHRoZSBwcm9ibGVtIGhlcmUgaXMgbm90IGluIHBhc3NpbmcNCmEgbmVnYXRpdmUgdmFs
dWUuIFRoZSBwcm9ibGVtIGlzIHRoYXQgaW9fZ2V0X2ZkKCkgbWF5IHJldHVybiBhbiBlcnJvcg0K
Y29kZSBidXQgdGhlIGZ1bmN0aW9uIGRvZXMgbm90IGhhbmRsZSB0aGlzIGNhc2UuIFRoaXMgaXMg
d2hhdCB0aGUNCmFuYWx5emVyIHdyaXRlczoNCg0KIlZhcmlhYmxlICdyZXR1cm4gdmFsdWUgb2Yg
aW9fZ2V0X2ZkKC4uLiknLCB3aGljaCBtaWdodCByZWNlaXZlIGENCm5lZ2F0aXZlIHZhbHVlIGF0
IGlvLWdsaWIuYzoxMjcgYnkgY2FsbGluZyBmdW5jdGlvbiAnaW9fZ2V0X2ZkJw0KYXQgZ2F0dC1k
YXRhYmFzZS5jOjI2MzUsIGlzIHVzZWQgd2l0aG91dCBjaGVja2luZyBhdA0KZ2F0dC1kYXRhYmFz
ZS5jOjI2MzUgYnkgY2FsbGluZyBmdW5jdGlvbiAnc2VuZG1zZycuIg0KDQpJcyBpdCB3b3J0aCBz
ZW5kaW5nIHBhdGNoZXMgZm9yIHNpbWlsYXIgZXJyb3JzPw0KPiANCj4gPiDCoHN0YXRpYyB2b2lk
IGF0dF9kaXNjb25uZWN0X2NiKGludCBlcnIsIHZvaWQgKnVzZXJfZGF0YSkNCj4gPiAtLQ0KPiA+
IDIuMzQuMQ0KPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==
