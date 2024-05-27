Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAA79CC;
	Mon, 27 May 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775164; cv=none; b=jzUEBQMd88pwkd/Zdj3y6ziyKyCm+LEGxRPhnZnOaj+6nOJTDdsdQ/1A0WSa12boCqYrD6XdO74SOWmwr1Py8DiKUyUIDWEKForLaOoZXEWZ1Ydwhr7Um402EcJyg0fQ3GA+5vRHeVq7nGmqNGehIdc1XjZCGzIkRvej0hY4YG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775164; c=relaxed/simple;
	bh=HkaNFuBrTVxYNPWeD6kFeLSKVPgVwvMG4VXUqpIXbho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2u/n3P320SxXJELqeNpQXrdrS6SJK90o0ywnE9hU2emxzy9dECPa5SG63A2i1SDwkf3NlCqdHpwsAq4B2CBMcESm/n9ODJLEvrIKSn1/RRxLAN6iPljaO7UgjefA3ZIXC+cLtzekj1UPgzQicprk6YMHfZWp5mtd5Mh2Tyza8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=JUu5NKQn; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="JUu5NKQn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1716775163; x=1748311163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkaNFuBrTVxYNPWeD6kFeLSKVPgVwvMG4VXUqpIXbho=;
  b=JUu5NKQnrGan2V5XRkbpjfe0Dpv5KRxT6PG8mHc+tDZMsRmeJowTSwrH
   H/08eTRsMISKuYUgBlgE6Kcc0MpfM3HH3QRmIOFb2v1Si7HNHkI/U1i5+
   B6bmFoq1+GQ8EtnL51ZemqADOJUYFrfPQTbYDGrWxaZQoQIK1JIlckRyy
   k=;
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="51929722"
X-IronPort-AV: E=Sophos;i="6.08,191,1712613600"; 
   d="scan'208";a="51929722"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:59:14 +0200
Received: from KLUSE834.infineon.com (172.28.156.178) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 May
 2024 03:59:13 +0200
Received: from KLUSE832.infineon.com (172.28.156.177) by KLUSE834.infineon.com
 (172.28.156.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 27 May
 2024 03:59:13 +0200
Received: from KLUSE832.infineon.com ([fe80::66a7:739f:6a03:4e1c]) by
 KLUSE832.infineon.com ([fe80::66a7:739f:6a03:4e1c%7]) with mapi id
 15.02.1258.034; Mon, 27 May 2024 03:59:13 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <luiz.dentz@gmail.com>
CC: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Topic: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Index: AQHarXodRFaIWgJslEGA5+113yeWdrGmousAgAOzr9A=
Date: Mon, 27 May 2024 01:59:12 +0000
Message-ID: <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
 <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com>
In-Reply-To: <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com>
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

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPj4gIHN0YXRpYyBpbnQgYnRi
Y21fcmVhZF9pbmZvKHN0cnVjdCBoY2lfZGV2ICpoZGV2KSAgew0KPj4gICAgICAgICBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiOw0KPj4gKyAgICAgICB1OCBjaGlwX2lkOw0KPj4gKyAgICAgICB1MTYgYmFz
ZWxpbmU7DQo+Pg0KPj4gICAgICAgICAvKiBSZWFkIFZlcmJvc2UgQ29uZmlnIFZlcnNpb24gSW5m
byAqLw0KPj4gICAgICAgICBza2IgPSBidGJjbV9yZWFkX3ZlcmJvc2VfY29uZmlnKGhkZXYpOw0K
Pj4gICAgICAgICBpZiAoSVNfRVJSKHNrYikpDQo+PiAgICAgICAgICAgICAgICAgcmV0dXJuIFBU
Ul9FUlIoc2tiKTsNCj4+IC0NCj4+ICsgICAgICAgY2hpcF9pZCA9IHNrYi0+ZGF0YVsxXTsNCj4+
ICsgICAgICAgYmFzZWxpbmUgPSBza2ItPmRhdGFbM10gfCAoc2tiLT5kYXRhWzRdIDw8IDgpOw0K
Pg0KPlRoaXMgaXMgbm90IHJlYWxseSBzYWZlLCB5b3Ugc2hvdWxkbid0IGF0dGVtcHQgdG8gYWNj
ZXNzIHNrYi0+ZGF0YSB3aXRob3V0IGZpcnN0IGNoZWNraW5nIHNrYi0+bGVuLCBhY3R1YWxseSBp
dCB3b3VsZCBiZSBtdWNoIGJldHRlciB0aGF0ID55b3Ugd291bGQgdXNlIHNrYl9wdWxsX2RhdGEg
d2hpY2ggZG9lcyBza2ItPmxlbiBjaGVjayBiZWZvcmUgcHVsbGluZyBkYXRhLg0KDQpJIHRoaW5r
IGl0IGNvdWxkIGJlIHNhZmUgYmVjYXVzZSBpdHMgbGVuZ3RoIGlzIGNoZWNrZWQgaW5zaWRlIGJ0
YmNtX3JlYWRfdmVyYm9zZV9jb25maWcoKSBhcyBiZWxvdy4NClBsZWFzZSBsZXQgbWUga25vdyBp
ZiBmdXJ0aGVyIGNoZWNraW5nIGlzIG5lZWRlZC4NCg0KPj4+DQpzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKmJ0YmNtX3JlYWRfdmVyYm9zZV9jb25maWcoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQp7DQoJ
c3RydWN0IHNrX2J1ZmYgKnNrYjsNCg0KCXNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIDB4ZmM3
OSwgMCwgTlVMTCwgSENJX0lOSVRfVElNRU9VVCk7DQoJaWYgKElTX0VSUihza2IpKSB7DQoJCWJ0
X2Rldl9lcnIoaGRldiwgIkJDTTogUmVhZCB2ZXJib3NlIGNvbmZpZyBpbmZvIGZhaWxlZCAoJWxk
KSIsDQoJCQkgICBQVFJfRVJSKHNrYikpOw0KCQlyZXR1cm4gc2tiOw0KCX0NCg0KCWlmIChza2It
PmxlbiAhPSA3KSB7DQoJCWJ0X2Rldl9lcnIoaGRldiwgIkJDTTogVmVyYm9zZSBjb25maWcgbGVu
Z3RoIG1pc21hdGNoIik7DQoJCWtmcmVlX3NrYihza2IpOw0KCQlyZXR1cm4gRVJSX1BUUigtRUlP
KTsNCgl9DQoNCglyZXR1cm4gc2tiOw0KfQ0KPDw8DQoNCkJlc3QgUmVnYXJkcywNCk5vYnVha2kg
VHN1bmFzaGltYQ0KDQo=
