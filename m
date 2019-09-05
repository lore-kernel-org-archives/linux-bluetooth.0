Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED609C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 21:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FBC20820
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfIEVoX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:44:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:47727 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEVoX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 17:44:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 14:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="208019095"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2019 14:44:19 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Sep 2019 14:43:59 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.78]) with mapi id 14.03.0439.000;
 Thu, 5 Sep 2019 14:43:59 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix IV Recovery procedure when IV Update is
 in progress
Thread-Topic: [PATCH BlueZ] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Thread-Index: AQHVY+uf8hDJFFAVpUiTus2uFDmwLqceE4uA
Date:   Thu, 5 Sep 2019 21:43:58 +0000
Message-ID: <3980d0c20d416de8ca17bd406cc830b03a4d9498.camel@intel.com>
References: <20190905131240.24969-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190905131240.24969-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.24.188]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0420383A9F5BFD4AAD086C8347E7F6AF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDE5LTA5LTA1IGF0IDE1OjEyICswMjAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBmaXhlcyBlcnJvbmVvdXNseSBjbGVhcmVk
IHNlcXVlbmNlIG51bWJlciB3aGVuIG5vZGUgcGVyZm9ybXMgSVYNCj4gUmVjb3ZlcnkgcHJvY2Vk
dXJlIG9uIHN0YXJ0dXAgaW4gYSBmb2xsb3dpbmcgc2NlbmFyaW86DQo+ICAgICAgLSBub2RlIGhh
cyBJViBJbmRleCBzZXQgdG8gPE4+DQo+ICAgICAgLSBub2RlIHN0YXJ0cyBpbiBJVl9VUERfSU5J
VCBzdGF0ZQ0KPiAgICAgIC0gbm9kZSByZWNlaXZlcyBhIFNlY3VyZSBOZXR3b3JrIEJlYWNvbiB3
aXRoIElWIEluZGV4IDxOPisxIGFuZCBJVg0KPiAgICAgICAgVXBkYXRlIGZsYWcgc2V0DQo+IA0K
PiBVcG9uIHJlY2VwdGlvbiwgdGhlIG5vZGUgc2hhbGw6DQo+ICAgICAtIGluY3JlYXNlIGl0cyBJ
ViBJbmRleCB0byA8Tj4rMQ0KPiAgICAgLSBlbnRlciBJVl9VUERfVVBEQVRJTkcgc3RhdGUNCj4g
DQo+IFRoaXMgbWVhbnMgdGhhdCB0aGUgbm9kZSBrZWVwcyB0cmFuc21pdHRpbmcgbWVzc2FnZXMg
dXNpbmcgSVYgSW5kZXgNCj4gZXF1YWwgdG8gPE4+LCB0aGVyZWZvcmUgaXQgc2hhbGwgbm90IHJl
c2V0IGl0cyBTZXF1ZW5jZSBOdW1iZXIgYmVmb3JlIElWDQo+IFVwZGF0ZSBwcm9jZWR1cmUgY29t
cGxldGVzLg0KPiANCj4gSWYsIG9uIHRoZSBvdGhlciBoYW5kLCByZWNlaXZlZCBTZWN1cmUgTmV0
d29yayBCZWFjb24gY29udGFpbnMgSVYgSW5kZXgNCj4gPE4+KzIgKG9yIG1vcmUpLCB0aGUgbm9k
ZSBzaGFsbDoNCj4gICAgIC0gaW5jcmVhc2UgaXRzIElWIEluZGV4IHRvIDxOPisyIChvciBtb3Jl
KQ0KPiAgICAgLSBlbnRlciBJVl9VUERfVVBEQVRJTkcgc3RhdGUNCj4gICAgIC0gcmVzZXQgdGhl
IFNlcXVlbmNlIE51bWJlciB0byAwDQo+IC0tLQ0KPiAgbWVzaC9uZXQuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDI3ODUwMzlkYi4uYjRiMzkw
NTQxIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAg
LTI3MzUsNyArMjczNSw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9pdl9rcl9zdGF0ZShzdHJ1Y3Qg
bWVzaF9zdWJuZXQgKnN1Ym5ldCwgdWludDMyX3QgaXZfaW5kZXgsDQo+ICAJfQ0KPiAgDQo+ICAJ
aWYgKG5ldC0+aXZfdXBkX3N0YXRlID09IElWX1VQRF9JTklUKSB7DQo+IC0JCWlmIChpdl9pbmRl
eCA+IG5ldC0+aXZfaW5kZXgpDQo+ICsJCWlmIChpdl9pbmRleCA+IG5ldC0+aXZfaW5kZXggKyAx
KQ0KPiAgCQkJbWVzaF9uZXRfc2V0X3NlcV9udW0obmV0LCAwKTsNCg0KSSB0aGluayB5b3UgaGF2
ZSBmb3VuZCBzb21ldGhpbmcsIGJ1dCBJIHRoaW5rIHdlIGFyZSBtaXNzaW5nIHNvbWV0aGluZyBo
ZXJlLi4uDQoNCklmIGl2X2luZGV4ID4gbmV0LT5pdl9pbmRleCwgYW5kIGl2X3VwZGF0ZSA9PSBm
YWxzZSwgdGhlbiB3ZSBzdGlsbCB3YW50IHRvIHJlc2V0IHRvIFNlcSBaZXJvLCBJIHRoaW5rLi4u
RXZlbiBpZg0KdGhlIGluY3JlYXNlIGlzIGp1c3QgMS4NCg0KVGhpcyBwYXJ0aWN1bGFyIHBhdGgg
aXMganVzdCBjb3ZlcmluZyB0aGUgc2l0dWF0aW9uIHdoZXJlIHRoaXMgaXMgdGhlICpmaXJzdCog
U05CIHdlIGFyZSByZWNlaXZpbmcgYWZ0ZXIgbm9kZQ0Kc3RhcnQtdXAgKGl2X3VwZF9zdGF0ZSA9
PSBJTklUKSBhbmQgaXQgaXMgdmVyeSBwb3NzaWJsZSB0aGF0IHRoZSBub2RlIGhhcyBiZWVuIGF3
YXkgZm9yIGxvbmcgZW5vdWdoIHRoYXQgYQ0Kc2luZ2xlIElWIFVwZGF0ZSBoYXMgc3RhcnRlZCBh
bmQgZmluaXNoZWQuDQoNClNvIHBlcmhhcHM6DQoJaWYgKGl2X2luZGV4ID4gbmV0LT5pdl9pbmRl
eCAmJiAhaXZfdXBkYXRlKQ0KCQltZXNoX25ldF9zZXRfc2VxX251bShuZXQsIDApOw0KCWVsc2Ug
aWYgKGl2X2luZGV4ID4gbmV0LT5pdl9pbmRleCArIDIpDQoJCW1lc2hfbmV0X3NldF9zZXFfbnVt
KG5ldCwgMCk7DQoNCk9yIG1vcmUgZXNvdGVyaWNhbGx5IChhbmQgbWF5YmUgaGFyZGVyIHRvIGZv
bGxvdyk6DQoJaWYgKGl2X2luZGV4ID4gbmV0LT5pdl9pbmRleCArIGl2X3VwZGF0ZSkNCgkJbWVz
aF9uZXRfc2V0X3NlcV9udW0obmV0LCAwKTsNCg0KT3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCg0K
DQo+ICAJCW5ldC0+aXZfaW5kZXggPSBpdl9pbmRleDsNCj4gIA0K
