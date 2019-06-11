Return-Path: <SRS0=I8Nx=UK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85699C31E44
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6320921734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405355AbfFKWdX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:33:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:45904 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404099AbfFKWdW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jun 2019 18:33:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 15:33:21 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2019 15:33:21 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Jun 2019 15:33:21 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.232]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.18]) with mapi id 14.03.0415.000;
 Tue, 11 Jun 2019 15:33:21 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3] mesh: Fix segmentation fault after adding
 second netkey via NET_KEY_ADD opcode
Thread-Topic: [PATCH BlueZ v3] mesh: Fix segmentation fault after adding
 second netkey via NET_KEY_ADD opcode
Thread-Index: AQHVH2j1X+v8o58xCUyONQNUFA0BaKaXgdiA
Date:   Tue, 11 Jun 2019 22:33:21 +0000
Message-ID: <1560292395.27321.1.camel@intel.com>
References: <20190610084605.11411-1-jakub.witowski@silvair.com>
In-Reply-To: <20190610084605.11411-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.159.204]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0DD0A90053FA34DAC46BD44189735F4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpQYXRjaCBBcHBsaWVkLCBUaGFua3MuDQoNCk9uIE1vbiwgMjAxOS0wNi0xMCBhdCAxMDo0NiAr
MDIwMCwgSmFrdWIgV2l0b3dza2kgd3JvdGU6DQo+IFNlZ21lbnRhdGlvbiBmYXVsdCB3YXMgY2F1
c2VkIGJ5IHBhc3Npbmcgc3VibmV0IHBvaW50ZXIgdG8gdGhlDQo+IHN0YXJ0X25ldHdvcmtfYmVh
Y29uKCkgd2hpY2ggd2FzIE5VTEwNCj4gLS0tDQo+ICBtZXNoL25ldC5jIHwgMjUgKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5j
DQo+IGluZGV4IGM3YWZmOWFiNC4uZmRkMzhlN2NlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5j
DQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTk3NywyNyArOTc3LDI4IEBAIGludCBtZXNoX25l
dF9kZWxfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgpDQo+ICAJcmV0dXJu
IE1FU0hfU1RBVFVTX1NVQ0NFU1M7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgYWRkX2tleShz
dHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgaWR4LCBjb25zdCB1aW50OF90ICp2YWx1ZSkN
Cj4gK3N0YXRpYyBzdHJ1Y3QgbWVzaF9zdWJuZXQgKmFkZF9rZXkoc3RydWN0IG1lc2hfbmV0ICpu
ZXQsIHVpbnQxNl90IGlkeCwNCj4gKwkJCQkJCQljb25zdCB1aW50OF90ICp2YWx1ZSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgbWVzaF9zdWJuZXQgKnN1Ym5ldDsNCj4gIA0KPiAgCXN1Ym5ldCA9IHN1Ym5l
dF9uZXcobmV0LCBpZHgpOw0KPiAgCWlmICghc3VibmV0KQ0KPiAtCQlyZXR1cm4gTUVTSF9TVEFU
VVNfSU5TVUZGX1JFU09VUkNFUzsNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAlzdWJuZXQt
Pm5ldF9rZXlfdHggPSBzdWJuZXQtPm5ldF9rZXlfY3VyID0gbmV0X2tleV9hZGQodmFsdWUpOw0K
PiAgCWlmICghc3VibmV0LT5uZXRfa2V5X2N1cikgew0KPiAgCQlsX2ZyZWUoc3VibmV0KTsNCj4g
LQkJcmV0dXJuIE1FU0hfU1RBVFVTX0lOU1VGRl9SRVNPVVJDRVM7DQo+ICsJCXJldHVybiBOVUxM
Ow0KPiAgCX0NCj4gIA0KPiAgCWlmICghY3JlYXRlX3NlY3VyZV9iZWFjb24obmV0LCBzdWJuZXQs
IHN1Ym5ldC0+c25iLmJlYWNvbiArIDEpIHx8DQo+ICAJCQkJIWxfcXVldWVfcHVzaF90YWlsKG5l
dC0+c3VibmV0cywgc3VibmV0KSkgew0KPiAgCQlzdWJuZXRfZnJlZShzdWJuZXQpOw0KPiAtCQly
ZXR1cm4gTUVTSF9TVEFUVVNfSU5TVUZGX1JFU09VUkNFUzsNCj4gKwkJcmV0dXJuIE5VTEw7DQo+
ICAJfQ0KPiAgDQo+IC0JcmV0dXJuIE1FU0hfU1RBVFVTX1NVQ0NFU1M7DQo+ICsJcmV0dXJuIHN1
Ym5ldDsNCj4gIH0NCj4gIA0KPiAgLyoNCj4gQEAgLTEwMDcsNyArMTAwOCw2IEBAIHN0YXRpYyBp
bnQgYWRkX2tleShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgaWR4LCBjb25zdCB1aW50
OF90ICp2YWx1ZSkNCj4gIGludCBtZXNoX25ldF9hZGRfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0
LCB1aW50MTZfdCBpZHgsIGNvbnN0IHVpbnQ4X3QgKnZhbHVlKQ0KPiAgew0KPiAgCXN0cnVjdCBt
ZXNoX3N1Ym5ldCAqc3VibmV0Ow0KPiAtCWludCBzdGF0dXM7DQo+ICANCj4gIAlzdWJuZXQgPSBs
X3F1ZXVlX2ZpbmQobmV0LT5zdWJuZXRzLCBtYXRjaF9rZXlfaW5kZXgsDQo+ICAJCQkJCQkJTF9V
SU5UX1RPX1BUUihpZHgpKTsNCj4gQEAgLTEwMTksOSArMTAxOSw5IEBAIGludCBtZXNoX25ldF9h
ZGRfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgsIGNvbnN0IHVpbnQ4X3Qg
KnZhbHVlKQ0KPiAgCQkJcmV0dXJuIE1FU0hfU1RBVFVTX0lEWF9BTFJFQURZX1NUT1JFRDsNCj4g
IAl9DQo+ICANCj4gLQlzdGF0dXMgPSBhZGRfa2V5KG5ldCwgaWR4LCB2YWx1ZSk7DQo+IC0JaWYg
KHN0YXR1cyAhPSBNRVNIX1NUQVRVU19TVUNDRVNTKQ0KPiAtCQlyZXR1cm4gc3RhdHVzOw0KPiAr
CXN1Ym5ldCA9IGFkZF9rZXkobmV0LCBpZHgsIHZhbHVlKTsNCj4gKwlpZiAoIXN1Ym5ldCkNCj4g
KwkJcmV0dXJuIE1FU0hfU1RBVFVTX0lOU1VGRl9SRVNPVVJDRVM7DQo+ICANCj4gIAlpZiAoIXN0
b3JhZ2VfbmV0X2tleV9hZGQobmV0LCBpZHgsIHZhbHVlLCBmYWxzZSkpIHsNCj4gIAkJbF9xdWV1
ZV9yZW1vdmUobmV0LT5zdWJuZXRzLCBzdWJuZXQpOw0KPiBAQCAtMjQ5MCw3ICsyNDkwLDcgQEAg
c3RhdGljIHZvaWQgbmV0X3J4KHZvaWQgKm5ldF9wdHIsIHZvaWQgKnVzZXJfZGF0YSkNCj4gIAlp
bnQ4X3QgcnNzaSA9IDA7DQo+ICANCj4gIAlrZXlfaWQgPSBuZXRfa2V5X2RlY3J5cHQobmV0LT5p
dl9pbmRleCwgZGF0YS0+ZGF0YSwgZGF0YS0+bGVuLA0KPiAtCQkJCQkJCQkmb3V0LCAmb3V0X3Np
emUpOw0KPiArCQkJCQkJCSZvdXQsICZvdXRfc2l6ZSk7DQo+ICANCj4gIAlpZiAoIWtleV9pZCkN
Cj4gIAkJcmV0dXJuOw0KPiBAQCAtMzAxNyw3ICszMDE3LDYgQEAgYm9vbCBtZXNoX25ldF9zZXRf
a2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgsIGNvbnN0IHVpbnQ4X3QgKmtl
eSwNCj4gIAkJCQkJY29uc3QgdWludDhfdCAqbmV3X2tleSwgdWludDhfdCBwaGFzZSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgbWVzaF9zdWJuZXQgKnN1Ym5ldDsNCj4gLQlpbnQgc3RhdHVzOw0KPiAgDQo+
ICAJc3VibmV0ID0gbF9xdWV1ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0Y2hfa2V5X2luZGV4LA0K
PiAgCQkJCQkJCUxfVUlOVF9UT19QVFIoaWR4KSk7DQo+IEBAIC0zMDMyLDggKzMwMzEsOCBAQCBi
b29sIG1lc2hfbmV0X3NldF9rZXkoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGlkeCwg
Y29uc3QgdWludDhfdCAqa2V5LA0KPiAgCWlmIChwaGFzZSAhPSBLRVlfUkVGUkVTSF9QSEFTRV9O
T05FICYmICFuZXdfa2V5KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gLQlzdGF0dXMgPSBh
ZGRfa2V5KG5ldCwgaWR4LCBrZXkpOw0KPiAtCWlmIChzdGF0dXMgIT0gTUVTSF9TVEFUVVNfU1VD
Q0VTUykNCj4gKwlzdWJuZXQgPSBhZGRfa2V5KG5ldCwgaWR4LCBrZXkpOw0KPiArCWlmICghc3Vi
bmV0KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gIAlzdWJuZXQgPSBsX3F1ZXVlX2ZpbmQo
bmV0LT5zdWJuZXRzLCBtYXRjaF9rZXlfaW5kZXgs
