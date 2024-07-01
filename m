Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060511388;
	Mon,  1 Jul 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719795906; cv=none; b=Y3zKUb6xbUGfP86IqVLY3omklue+FeinxXL8TYfcddqJrAuMN30Issvfh9XI9q073J7/nfHIJMf9/EwBovPHMqRJVAylnPvY+SCuzTeFIDBEiwYFKLS8hhj6eLiSGwktz5y4d37H3UV8GZDB0z5EO69onpvmhlqOdYwKJ1e320g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719795906; c=relaxed/simple;
	bh=zt88BMcCBRpJY29U2eW/EnAJhUpbDlG0WddY4Dm+gzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jd3+Rvdz0Y6IJyjMTv9NOfLXMeXUdfqTCtWYK9e+TnEj8ieK7gnNwQ0+G2h7jYbUt5zQlIG233TTFadqfONgNlpTDkwXBLczJQ8xONIoKP3XNhT0X1wzl9CU8Q79fjB8JRzZHBqocQ6Kv80ECyCdn9rVBG1H6XKimQKHOXydgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=K0nuT5wc; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="K0nuT5wc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1719795905; x=1751331905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zt88BMcCBRpJY29U2eW/EnAJhUpbDlG0WddY4Dm+gzc=;
  b=K0nuT5wcP04NyUwmnuuRAQ+uCGT6Ib05uvJz/3c9xyxsm7Z5k8QK9qc5
   9g5n0jpym2w33CP7/56VpgaJ/VWfqzYDQzRbDp/ei9JhaiYQGZcX8Z3Wk
   eNMDMAhQK3FscqAF9tAdUvb7fdkV0KsKGBGdR1CzPFc33XfV/wDc1rjEo
   g=;
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="80217184"
X-IronPort-AV: E=Sophos;i="6.09,175,1716242400"; 
   d="scan'208";a="80217184"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 03:04:56 +0200
Received: from MUCSE833.infineon.com (172.23.7.105) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 1 Jul
 2024 03:04:55 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE833.infineon.com
 (172.23.7.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 1 Jul
 2024 03:04:55 +0200
Received: from MUCSE832.infineon.com ([fe80::df7:95e8:60bd:7478]) by
 MUCSE832.infineon.com ([fe80::df7:95e8:60bd:7478%15]) with mapi id
 15.02.1258.034; Mon, 1 Jul 2024 03:04:55 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <luiz.dentz@gmail.com>
CC: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Topic: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Index: AQHarXodRFaIWgJslEGA5+113yeWdrGmousAgAOzr9CAMussgIAEB17A
Date: Mon, 1 Jul 2024 01:04:54 +0000
Message-ID: <3ae77d91542241eb9b1f4c7428ee52cd@infineon.com>
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
 <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com>
 <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
 <CABBYNZKjUY2XVf2yu95ECggZb1xJ0SAneKqMNSnAGGfgRTs02g@mail.gmail.com>
In-Reply-To: <CABBYNZKjUY2XVf2yu95ECggZb1xJ0SAneKqMNSnAGGfgRTs02g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCj4gT2ssIGJ1dCBJIHN0aWxs
IGNvbnNpZGVyIHJld29ya2luZyB0aGVzZSB0byB1c2Ugc2tiX3B1bGxfZGF0YS4NCg0KTm93LCBJ
IHJlY29uc2lkZXIgYW5kIGZvdW5kIHRoZSBza2JfcHVsbF9kYXRhIGlzIG1vcmUgY29udmVuaWVu
dCByYXRoZXIgdGhhbiBkaXJlY3RseSBhY2Nlc3NpbmcgdG8gc2tiLT5kYXRhLg0KQXMgSSBhbSBv
biBidXNpbmVzcyB0cmlwIG9uIGEgZmV3IGRheXMsIEkgd2lsbCBzdWJtaXQgbmV3IHBhdGNoIGFm
dGVyIEkgY29tZSBiYWNrLg0KDQpSZWdhcmRzLA0KTm9idWFraSBUc3VuYXNoaW1hDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6
LmRlbnR6QGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIEp1bmUgMjgsIDIwMjQgMTA6MjkgUE0N
ClRvOiBUc3VuYXNoaW1hIE5vYnVha2kgKFNNRCBDMyBKUCBSTSBXTFMgQUUpIDxOb2J1YWtpLlRz
dW5hc2hpbWFAaW5maW5lb24uY29tPg0KQ2M6IG1hcmNlbEBob2x0bWFubi5vcmc7IGxpbnV4LWJs
dWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIEJsdWV0b290aDogYnRiY206IEFwcGx5IEhDSV9RVUlSS19C
Uk9LRU5fUkVBRF9UUkFOU01JVF9QT1dFUiB0byBDWVc0MzczDQoNCkNhdXRpb246IFRoaXMgZS1t
YWlsIG9yaWdpbmF0ZWQgb3V0c2lkZSBJbmZpbmVvbiBUZWNobm9sb2dpZXMuIFBsZWFzZSBiZSBj
YXV0aW91cyB3aGVuIHNoYXJpbmcgaW5mb3JtYXRpb24gb3Igb3BlbmluZyBhdHRhY2htZW50cyBl
c3BlY2lhbGx5IGZyb20gdW5rbm93biBzZW5kZXJzLiBSZWZlciB0byBvdXIgaW50cmFuZXQgZ3Vp
ZGU8aHR0cHM6Ly9pbnRyYW5ldC1jb250ZW50LmluZmluZW9uLmNvbS9leHBsb3JlL2Fib3V0aW5m
aW5lb24vcnVsZXMvaW5mb3JtYXRpb25zZWN1cml0eS91Zy9Tb2NpYWxFbmdpbmVlcmluZy9QYWdl
cy9Tb2NpYWxFbmdpbmVlcmluZ0VsZW1lbnRzX2VuLmFzcHg+IHRvIGhlbHAgeW91IGlkZW50aWZ5
IFBoaXNoaW5nIGVtYWlsLg0KDQoNCg0KSGksDQoNCk9uIFN1biwgTWF5IDI2LCAyMDI0IGF0IDk6
NTnigK9QTSA8Tm9idWFraS5Uc3VuYXNoaW1hQGluZmluZW9uLmNvbT4gd3JvdGU6DQo+DQo+IEhp
IEx1aXosDQo+DQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+DQo+ID4+ICBzdGF0aWMgaW50
IGJ0YmNtX3JlYWRfaW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldikgIHsNCj4gPj4gICAgICAgICBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+PiArICAgICAgIHU4IGNoaXBfaWQ7DQo+ID4+ICsgICAg
ICAgdTE2IGJhc2VsaW5lOw0KPiA+Pg0KPiA+PiAgICAgICAgIC8qIFJlYWQgVmVyYm9zZSBDb25m
aWcgVmVyc2lvbiBJbmZvICovDQo+ID4+ICAgICAgICAgc2tiID0gYnRiY21fcmVhZF92ZXJib3Nl
X2NvbmZpZyhoZGV2KTsNCj4gPj4gICAgICAgICBpZiAoSVNfRVJSKHNrYikpDQo+ID4+ICAgICAg
ICAgICAgICAgICByZXR1cm4gUFRSX0VSUihza2IpOw0KPiA+PiAtDQo+ID4+ICsgICAgICAgY2hp
cF9pZCA9IHNrYi0+ZGF0YVsxXTsNCj4gPj4gKyAgICAgICBiYXNlbGluZSA9IHNrYi0+ZGF0YVsz
XSB8IChza2ItPmRhdGFbNF0gPDwgOCk7DQo+ID4NCj4gPlRoaXMgaXMgbm90IHJlYWxseSBzYWZl
LCB5b3Ugc2hvdWxkbid0IGF0dGVtcHQgdG8gYWNjZXNzIHNrYi0+ZGF0YSB3aXRob3V0IGZpcnN0
IGNoZWNraW5nIHNrYi0+bGVuLCBhY3R1YWxseSBpdCB3b3VsZCBiZSBtdWNoIGJldHRlciB0aGF0
ID55b3Ugd291bGQgdXNlIHNrYl9wdWxsX2RhdGEgd2hpY2ggZG9lcyBza2ItPmxlbiBjaGVjayBi
ZWZvcmUgcHVsbGluZyBkYXRhLg0KPg0KPiBJIHRoaW5rIGl0IGNvdWxkIGJlIHNhZmUgYmVjYXVz
ZSBpdHMgbGVuZ3RoIGlzIGNoZWNrZWQgaW5zaWRlIGJ0YmNtX3JlYWRfdmVyYm9zZV9jb25maWco
KSBhcyBiZWxvdy4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIGZ1cnRoZXIgY2hlY2tpbmcgaXMg
bmVlZGVkLg0KPg0KPiA+Pj4NCj4gc3RhdGljIHN0cnVjdCBza19idWZmICpidGJjbV9yZWFkX3Zl
cmJvc2VfY29uZmlnKHN0cnVjdCBoY2lfZGV2ICpoZGV2KSANCj4gew0KPiAgICAgICAgIHN0cnVj
dCBza19idWZmICpza2I7DQo+DQo+ICAgICAgICAgc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwg
MHhmYzc5LCAwLCBOVUxMLCBIQ0lfSU5JVF9USU1FT1VUKTsNCj4gICAgICAgICBpZiAoSVNfRVJS
KHNrYikpIHsNCj4gICAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIoaGRldiwgIkJDTTogUmVhZCB2
ZXJib3NlIGNvbmZpZyBpbmZvIGZhaWxlZCAoJWxkKSIsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFBUUl9FUlIoc2tiKSk7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gc2tiOw0KPiAg
ICAgICAgIH0NCj4NCj4gICAgICAgICBpZiAoc2tiLT5sZW4gIT0gNykgew0KPiAgICAgICAgICAg
ICAgICAgYnRfZGV2X2VycihoZGV2LCAiQkNNOiBWZXJib3NlIGNvbmZpZyBsZW5ndGggbWlzbWF0
Y2giKTsNCj4gICAgICAgICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIHJldHVy
biBza2I7DQo+IH0NCj4gPDw8DQoNCk9rLCBidXQgSSBzdGlsbCBjb25zaWRlciByZXdvcmtpbmcg
dGhlc2UgdG8gdXNlIHNrYl9wdWxsX2RhdGEuDQoNCj4gQmVzdCBSZWdhcmRzLA0KPiBOb2J1YWtp
IFRzdW5hc2hpbWENCj4NCg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
