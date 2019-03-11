Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CA1C10F06
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6C62087F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCKWT1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:19:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:15133 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKWT1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 18:19:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 15:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="150738717"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 15:19:27 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Mar 2019 15:19:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.56]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 15:19:25 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Enable local loopback
Thread-Topic: [PATCH BlueZ v2] mesh: Enable local loopback
Thread-Index: AQHU1f/v5xesf5bWlE66gzw1GfxyxaYHekyA
Date:   Mon, 11 Mar 2019 22:19:24 +0000
Message-ID: <1552342761.29289.0.camel@intel.com>
References: <20190308224016.9857-1-brian.gix@intel.com>
In-Reply-To: <20190308224016.9857-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.149.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3AC1403395A584FA5D98FFB1326FE4F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMDMtMDggYXQgMTQ6NDAgLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gSW1wbGVtZW50cyBtZWNoYW5pc20gdG8gYWxsb3cgZGlyZWN0IG1lc3NhZ2luZyBi
ZXR3ZWVuIGxvY2FsDQo+IG5vZGVzIHdpdGhvdXQgcmVxdWlyaW5nIGFuIGV4dGVybmFsIHJlbGF5
IG5vZGUuDQo+IC0tLQ0KPiAgbWVzaC9uZXQuYyB8IDUxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMg
Yi9tZXNoL25ldC5jDQo+IGluZGV4IDJhZGFlNzBjMy4uYjE3M2UxYzA5IDEwMDY0NA0KPiAtLS0g
YS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTI1NCwxMCArMjU0LDI0IEBA
IHN0cnVjdCBuZXRfZGVjb2RlIHsNCj4gIAlib29sIHByb3h5Ow0KPiAgfTsNCj4gIA0KPiArc3Ry
dWN0IG5ldF9xdWV1ZV9kYXRhIHsNCj4gKwlzdHJ1Y3QgbWVzaF9pb19yZWN2X2luZm8gKmluZm87
DQo+ICsJc3RydWN0IG1lc2hfbmV0ICpuZXQ7DQo+ICsJY29uc3QgdWludDhfdCAqZGF0YTsNCj4g
Kwl1aW50OF90ICpvdXQ7DQo+ICsJc2l6ZV90IG91dF9zaXplOw0KPiArCWVudW0gX3JlbGF5X2Fk
dmljZSByZWxheV9hZHZpY2U7DQo+ICsJdWludDMyX3Qga2V5X2lkOw0KPiArCXVpbnQzMl90IGl2
X2luZGV4Ow0KPiArCXVpbnQxNl90IGxlbjsNCj4gK307DQo+ICsNCj4gICNkZWZpbmUgRkFTVF9D
QUNIRV9TSVpFIDgNCj4gIHN0YXRpYyBzdHJ1Y3QgbF9xdWV1ZSAqZmFzdF9jYWNoZTsNCj4gIHN0
YXRpYyBzdHJ1Y3QgbF9xdWV1ZSAqbmV0czsNCj4gIA0KPiArc3RhdGljIHZvaWQgbmV0X3J4KHZv
aWQgKm5ldF9wdHIsIHZvaWQgKnVzZXJfZGF0YSk7DQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IG1lc2hfc3VibmV0ICpnZXRfcHJpbWFyeV9zdWJuZXQoc3RydWN0IG1lc2hfbmV0ICpuZXQp
DQo+ICB7DQo+ICAJcmV0dXJuIGxfcXVldWVfcGVla19oZWFkKG5ldC0+c3VibmV0cyk7DQo+IEBA
IC0yMjY3LDE2ICsyMjgxLDI3IEBAIHN0YXRpYyB2b2lkIHNlbmRfcmVsYXlfcGt0KHN0cnVjdCBt
ZXNoX25ldCAqbmV0LCB1aW50OF90ICpkYXRhLCB1aW50OF90IHNpemUpDQo+ICBzdGF0aWMgdm9p
ZCBzZW5kX21zZ19wa3Qoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQ4X3QgKnBhY2tldCwgdWlu
dDhfdCBzaXplKQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX2lvICppbyA9IG5ldC0+aW87DQo+IC0J
c3RydWN0IG1lc2hfaW9fc2VuZF9pbmZvIGluZm8gPSB7DQo+IC0JCS50eXBlID0gTUVTSF9JT19U
SU1JTkdfVFlQRV9HRU5FUkFMLA0KPiAtCQkudS5nZW4uaW50ZXJ2YWwgPSBuZXQtPnR4X2ludGVy
dmFsLA0KPiAtCQkudS5nZW4uY250ID0gbmV0LT50eF9jbnQsDQo+IC0JCS51Lmdlbi5taW5fZGVs
YXkgPSBERUZBVUxUX01JTl9ERUxBWSwNCj4gLQkJLyogTm8gZXh0cmEgcmFuZG9taXphdGlvbiB3
aGVuIHNlbmRpbmcgcmVndWxhciBtZXNoIG1lc3NhZ2VzICovDQo+IC0JCS51Lmdlbi5tYXhfZGVs
YXkgPSBERUZBVUxUX01JTl9ERUxBWQ0KPiArCXN0cnVjdCBtZXNoX2lvX3NlbmRfaW5mbyBpbmZv
Ow0KPiArCXN0cnVjdCBuZXRfcXVldWVfZGF0YSBuZXRfZGF0YSA9IHsNCj4gKwkJLmluZm8gPSBO
VUxMLA0KPiArCQkuZGF0YSA9IHBhY2tldCArIDEsDQo+ICsJCS5sZW4gPSBzaXplIC0gMSwNCj4g
KwkJLnJlbGF5X2FkdmljZSA9IFJFTEFZX05PTkUsDQo+ICAJfTsNCj4gIA0KPiArCS8qIFNlbmQg
dG8gbG9jYWwgbm9kZXMgZmlyc3QgKi8NCj4gKwlsX3F1ZXVlX2ZvcmVhY2gobmV0cywgbmV0X3J4
LCAmbmV0X2RhdGEpOw0KPiArDQo+ICsJaWYgKG5ldF9kYXRhLnJlbGF5X2FkdmljZSA9PSBSRUxB
WV9ESVNBTExPV0VEKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAlwYWNrZXRbMF0gPSBNRVNIX0FE
X1RZUEVfTkVUV09SSzsNCj4gKwlpbmZvLnR5cGUgPSBNRVNIX0lPX1RJTUlOR19UWVBFX0dFTkVS
QUw7DQo+ICsJaW5mby51Lmdlbi5pbnRlcnZhbCA9IG5ldC0+dHhfaW50ZXJ2YWw7DQo+ICsJaW5m
by51Lmdlbi5jbnQgPSBuZXQtPnR4X2NudDsNCj4gKwlpbmZvLnUuZ2VuLm1pbl9kZWxheSA9IERF
RkFVTFRfTUlOX0RFTEFZOw0KPiArCS8qIE5vIGV4dHJhIHJhbmRvbWl6YXRpb24gd2hlbiBzZW5k
aW5nIHJlZ3VsYXIgbWVzaCBtZXNzYWdlcyAqLw0KPiArCWluZm8udS5nZW4ubWF4X2RlbGF5ID0g
REVGQVVMVF9NSU5fREVMQVk7DQo+ICANCj4gIAltZXNoX2lvX3NlbmQoaW8sICZpbmZvLCBwYWNr
ZXQsIHNpemUpOw0KPiAgfQ0KPiBAQCAtMjQ2MSwxOCArMjQ4Niw2IEBAIHN0YXRpYyBlbnVtIF9y
ZWxheV9hZHZpY2UgcGFja2V0X3JlY2VpdmVkKHZvaWQgKnVzZXJfZGF0YSwNCj4gIAkJcmV0dXJu
IFJFTEFZX05PTkU7DQo+ICB9DQo+ICANCj4gLXN0cnVjdCBuZXRfcXVldWVfZGF0YSB7DQo+IC0J
c3RydWN0IG1lc2hfaW9fcmVjdl9pbmZvICppbmZvOw0KPiAtCXN0cnVjdCBtZXNoX25ldCAqbmV0
Ow0KPiAtCWNvbnN0IHVpbnQ4X3QgKmRhdGE7DQo+IC0JdWludDhfdCAqb3V0Ow0KPiAtCXNpemVf
dCBvdXRfc2l6ZTsNCj4gLQllbnVtIF9yZWxheV9hZHZpY2UgcmVsYXlfYWR2aWNlOw0KPiAtCXVp
bnQzMl90IGtleV9pZDsNCj4gLQl1aW50MzJfdCBpdl9pbmRleDsNCj4gLQl1aW50MTZfdCBsZW47
DQo+IC19Ow0KPiAtDQo+ICBzdGF0aWMgdm9pZCBuZXRfcngodm9pZCAqbmV0X3B0ciwgdm9pZCAq
dXNlcl9kYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBuZXRfcXVldWVfZGF0YSAqZGF0YSA9IHVzZXJf
ZGF0YTs=
