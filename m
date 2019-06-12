Return-Path: <SRS0=QTJ/=UM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56999C31E45
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B712053B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfFMRQX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:50481 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfFLViX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jun 2019 17:38:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 14:38:21 -0700
X-ExtLoop1: 1
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2019 14:38:20 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Jun 2019 14:38:20 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.232]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.229]) with mapi id 14.03.0415.000;
 Wed, 12 Jun 2019 14:38:20 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Remove redundant checks when adding a
 net key
Thread-Topic: [PATCH BlueZ 1/1] mesh: Remove redundant checks when adding a
 net key
Thread-Index: AQHVIKu9El0pujejoky/fQWC0wY06KaZAk0A
Date:   Wed, 12 Jun 2019 21:38:20 +0000
Message-ID: <1560375498.11349.0.camel@intel.com>
References: <20190611231643.25165-1-inga.stotland@intel.com>
In-Reply-To: <20190611231643.25165-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.54.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8ED9017DEB7654A8DEA9802015B1021@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIGNvbW1pdCBtZXNzYWdlIHR3ZWVrcw0KDQpPbiBUdWUsIDIwMTkt
MDYtMTEgYXQgMTY6MTYgLTA3MDAsIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgcGF0Y2gg
Y2xlYW5zIHVwIHJlZHVuZGFudCBjaGVja3MgaW4gc2RkX2tleSgpIGFuZCBtZXNoX25ldF9zZXRf
a2V5KCk6DQo+IG5vIG5lZWQgdG8gY2hlY2sgdGhlIHJlc3VsdCBvZiBsX3F1ZXVlX3B1c2hfdGFp
bCgpIGFuZCBub3QgbmVlZCB0byBjaGVjaw0KPiBpZiBzdWJuZXQgaXMgdmFsaWQgYWZ0ZXIgaXQg
d2FzIHN1Y2Nlc3NmdWxseSBjcmVhdGVkLg0KPiAtLS0NCj4gIG1lc2gvbmV0LmMgfCAxOSArKysr
KysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25ldC5jIGIvbWVzaC9uZXQuYw0K
PiBpbmRleCBmZGQzOGU3Y2UuLmE1OTdiODc5NCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9uZXQuYw0K
PiArKysgYi9tZXNoL25ldC5jDQo+IEBAIC05OTIsMTIgKzk5MiwxMyBAQCBzdGF0aWMgc3RydWN0
IG1lc2hfc3VibmV0ICphZGRfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgs
DQo+ICAJCXJldHVybiBOVUxMOw0KPiAgCX0NCj4gIA0KPiAtCWlmICghY3JlYXRlX3NlY3VyZV9i
ZWFjb24obmV0LCBzdWJuZXQsIHN1Ym5ldC0+c25iLmJlYWNvbiArIDEpIHx8DQo+IC0JCQkJIWxf
cXVldWVfcHVzaF90YWlsKG5ldC0+c3VibmV0cywgc3VibmV0KSkgew0KPiArCWlmICghY3JlYXRl
X3NlY3VyZV9iZWFjb24obmV0LCBzdWJuZXQsIHN1Ym5ldC0+c25iLmJlYWNvbiArIDEpKSB7DQo+
ICAJCXN1Ym5ldF9mcmVlKHN1Ym5ldCk7DQo+ICAJCXJldHVybiBOVUxMOw0KPiAgCX0NCj4gIA0K
PiArCWxfcXVldWVfcHVzaF90YWlsKG5ldC0+c3VibmV0cywgc3VibmV0KTsNCj4gKw0KPiAgCXJl
dHVybiBzdWJuZXQ7DQo+ICB9DQo+ICANCj4gQEAgLTMwMTgsMTEgKzMwMTksNiBAQCBib29sIG1l
c2hfbmV0X3NldF9rZXkoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGlkeCwgY29uc3Qg
dWludDhfdCAqa2V5LA0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX3N1Ym5ldCAqc3VibmV0Ow0KPiAg
DQo+IC0Jc3VibmV0ID0gbF9xdWV1ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0Y2hfa2V5X2luZGV4
LA0KPiAtCQkJCQkJCUxfVUlOVF9UT19QVFIoaWR4KSk7DQo+IC0JaWYgKHN1Ym5ldCkNCj4gLQkJ
cmV0dXJuIGZhbHNlOw0KPiAtDQo+ICAJLyogQ3VycmVudCBrZXkgbXVzdCBiZSBhbHdheXMgcHJl
c2VudCAqLw0KPiAgCWlmICgha2V5KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+IEBAIC0zMDMxLDEy
ICszMDI3LDEzIEBAIGJvb2wgbWVzaF9uZXRfc2V0X2tleShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwg
dWludDE2X3QgaWR4LCBjb25zdCB1aW50OF90ICprZXksDQo+ICAJaWYgKHBoYXNlICE9IEtFWV9S
RUZSRVNIX1BIQVNFX05PTkUgJiYgIW5ld19rZXkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0K
PiAtCXN1Ym5ldCA9IGFkZF9rZXkobmV0LCBpZHgsIGtleSk7DQo+IC0JaWYgKCFzdWJuZXQpDQo+
IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiArCS8qIENoZWNrIGlmIHRoZSBzdWJuZXQgd2l0aCB0
aGUgc3BlY2lmaWVkIGluZGV4IGFscmVhZHkgZXhpc3RzICovDQo+ICAJc3VibmV0ID0gbF9xdWV1
ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0Y2hfa2V5X2luZGV4LA0KPiAgCQkJCQkJCUxfVUlOVF9U
T19QVFIoaWR4KSk7DQo+ICsJaWYgKHN1Ym5ldCkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+
ICsJc3VibmV0ID0gYWRkX2tleShuZXQsIGlkeCwga2V5KTsNCj4gIAlpZiAoIXN1Ym5ldCkNCj4g
IAkJcmV0dXJuIGZhbHNlOw0KPiAg
