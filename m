Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF644C89;
	Fri, 28 Jun 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553414; cv=none; b=ebKyg0YjxM4wCANS3VqXHZ7HEUnSZOcHPz7H6OrwNt9ZT50pF3p+5h41/VcMsqt48eA1JD7lhGJnJ5e8v25uUt3qVBMSbowJWp9o57TaPIBETkv8sX4wok7j9ux6ic2PahRt6rhHBqW349qCwX0iSx1AWamJuGCHYIEyc6eejh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553414; c=relaxed/simple;
	bh=GYJkITd51LZsT0LxMKJXHqbZm7sWdh0+Ygvn60katiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QrWger/OGuWjwcbPYX95Kpo1+g00XTlSNCAGQfcnKPb3+V7m19Gzr+iqWK2ZbT8Bx2WKjJK2aM7q5rRQMrS2FhtUyM1+OFzaiqNmpKiIlLSEnCUnV5aggksrSgvruXGnzfQiqz/CuJzmK3b2WbCtwBrVq2YpHxxkX15pB6j+z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Pbh7T+Gq; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Pbh7T+Gq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1719553413; x=1751089413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GYJkITd51LZsT0LxMKJXHqbZm7sWdh0+Ygvn60katiw=;
  b=Pbh7T+Gq6oSzGcfz+eJgOnb4UoNGOG9/9vNCmLvCuqqxlVonGhPuSRO+
   UCnXrJ7keBQ3j5mWEvwOaVuvK53qr9UBseWXPz8jzd5zbMVxbqr6+DNXe
   WPrCUBA6vS8yw0IJ+O30m1pL5snU4Pobmin7DX6lcAorQiqiaiO+P3dwF
   E=;
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="80065559"
X-IronPort-AV: E=Sophos;i="6.09,168,1716242400"; 
   d="scan'208";a="80065559"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 07:42:21 +0200
Received: from MUCSE839.infineon.com (172.23.7.112) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 28 Jun
 2024 07:42:21 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE839.infineon.com
 (172.23.7.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 28 Jun
 2024 07:42:20 +0200
Received: from MUCSE832.infineon.com ([fe80::df7:95e8:60bd:7478]) by
 MUCSE832.infineon.com ([fe80::df7:95e8:60bd:7478%15]) with mapi id
 15.02.1258.034; Fri, 28 Jun 2024 07:42:20 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <luiz.dentz@gmail.com>
CC: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Topic: [PATCH v4] Bluetooth: btbcm: Apply
 HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Thread-Index: AQHarXodRFaIWgJslEGA5+113yeWdrGmousAgAOzr9CAMogp8A==
Date: Fri, 28 Jun 2024 05:42:20 +0000
Message-ID: <0616e1ca047a4652a08727b43f5d2655@infineon.com>
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
 <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com>
 <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
In-Reply-To: <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
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

SGVsbG8sDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGFkZGl0aW9uYWwg
YWN0aW9ucyBuZWVkZWQgZnJvbSBteSBlbmQgdG8gZmFjaWxpdGF0ZSBwcm9ncmVzcyBvbiB0aGlz
IHBhdGNoLg0KWW91ciBmZWVkYmFjayB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KDQpU
aGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIHRvIHRoaXMgbWF0dGVyLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpOb2J1YWtpIFRzdW5hc2hpbWENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IFRzdW5hc2hpbWEgTm9idWFraSAoU01EIEMzIEpQIFJNIFdMUyBBRSkgDQpTZW50OiBNb25k
YXksIE1heSAyNywgMjAyNCAxMDo1OSBBTQ0KVG86ICdMdWl6IEF1Z3VzdG8gdm9uIERlbnR6JyA8
bHVpei5kZW50ekBnbWFpbC5jb20+DQpDYzogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPjsgbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSCB2NF0gQmx1ZXRvb3RoOiBidGJjbTog
QXBwbHkgSENJX1FVSVJLX0JST0tFTl9SRUFEX1RSQU5TTUlUX1BPV0VSIHRvIENZVzQzNzMNCg0K
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
ZmYgKmJ0YmNtX3JlYWRfdmVyYm9zZV9jb25maWcoc3RydWN0IGhjaV9kZXYgKmhkZXYpIHsNCglz
dHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KDQoJc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwgMHhmYzc5
LCAwLCBOVUxMLCBIQ0lfSU5JVF9USU1FT1VUKTsNCglpZiAoSVNfRVJSKHNrYikpIHsNCgkJYnRf
ZGV2X2VycihoZGV2LCAiQkNNOiBSZWFkIHZlcmJvc2UgY29uZmlnIGluZm8gZmFpbGVkICglbGQp
IiwNCgkJCSAgIFBUUl9FUlIoc2tiKSk7DQoJCXJldHVybiBza2I7DQoJfQ0KDQoJaWYgKHNrYi0+
bGVuICE9IDcpIHsNCgkJYnRfZGV2X2VycihoZGV2LCAiQkNNOiBWZXJib3NlIGNvbmZpZyBsZW5n
dGggbWlzbWF0Y2giKTsNCgkJa2ZyZWVfc2tiKHNrYik7DQoJCXJldHVybiBFUlJfUFRSKC1FSU8p
Ow0KCX0NCg0KCXJldHVybiBza2I7DQp9DQo8PDwNCg0KQmVzdCBSZWdhcmRzLA0KTm9idWFraSBU
c3VuYXNoaW1hDQoNCg==
