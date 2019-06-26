Return-Path: <SRS0=cKDh=UZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A2C48BD9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F75920659
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZRdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:33:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:33663 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRdF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jun 2019 13:33:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="164025669"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2019 10:33:02 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Jun 2019 10:32:59 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.150]) with mapi id 14.03.0439.000;
 Wed, 26 Jun 2019 10:32:59 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix to duplicated model Ids saved to storage
Thread-Topic: [PATCH BlueZ] mesh: Fix to duplicated model Ids saved to
 storage
Thread-Index: AQHVLDa5MrDEgZy1OEqJpjr2FIo6dKaup06A
Date:   Wed, 26 Jun 2019 17:32:58 +0000
Message-ID: <1561570377.22940.17.camel@intel.com>
References: <20190626154902.18904-1-rafal.gajda@silvair.com>
In-Reply-To: <20190626154902.18904-1-rafal.gajda@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.45.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1BB75B7E1CF1F448F37E09BE2D0221F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIGNvbW1pdCBtZXNzYWdlIGNoYW5nZSwgVGhhbmtzDQoNCk9uIFdl
ZCwgMjAxOS0wNi0yNiBhdCAxNzo0OSArMDIwMCwgUmFmYcWCIEdhamRhIHdyb3RlOg0KPiBCbHVl
WiBpbnRlcm5hbGx5IGltcGxlbWVudHMgYSBTSUcgbW9kZWwgZm9yIENvbmZpZyBTZXJ2ZXIuDQo+
IA0KPiBXaGVuIGdlbmVyYXRpbmcgbm9kZSwgaWYgdGhlIE1lc2ggRWxlbWVudCBpbiBtZXNoIGFw
cGxpY2F0aW9uIHJldHVybnMgbW9kZWxJZCAwDQo+IGFtb25nIGl0cyBzdXBwb3J0ZWQgbW9kZWxz
LCBpdCBzaG91bGQgYmUgc2tpcHBlZCwgb3RoZXJ3aXNlIGl0IHdpbGwgYmUNCj4gZHVwbGljYXRl
ZCBhbmQgc2F2ZWQgaW4gdGhlIHN0b3JhZ2UgZmlsZS4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMg
Y29ycmVjdGx5IHNraXBwaW5nIENvbmZpZyBTZXJ2ZXIgbW9kZWwgZHVyaW5nIG5vZGUgY3JlYXRp
b24uDQo+IC0tLQ0KPiAgbWVzaC9ub2RlLmMgfCA3ICsrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVz
aC9ub2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCBlOTk4NTg2MjMuLjRlMzViYjNmZiAxMDA2
NDQNCj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4gQEAgLTEwNjEs
MTAgKzEwNjEsOSBAQCBzdGF0aWMgYm9vbCB2YWxpZGF0ZV9tb2RlbF9wcm9wZXJ0eShzdHJ1Y3Qg
bm9kZV9lbGVtZW50ICplbGUsDQo+ICAJCS8qIEJsdWV0b290aCBTSUcgZGVmaW5lZCBtb2RlbHMg
Ki8NCj4gIAkJd2hpbGUgKGxfZGJ1c19tZXNzYWdlX2l0ZXJfbmV4dF9lbnRyeSgmaWRzLCAmbW9k
X2lkKSkgew0KPiAgCQkJc3RydWN0IG1lc2hfbW9kZWwgKm1vZDsNCj4gLQkJCXVpbnQzMl90IG0g
PSBtb2RfaWQ7DQo+ICANCj4gIAkJCS8qIFNraXAgaW50ZXJuYWxseSBpbXBsZW1lbnRlZCBtb2Rl
bHMgKi8NCj4gLQkJCWlmIChtID09IENPTkZJR19TUlZfTU9ERUwpDQo+ICsJCQlpZiAoKFZFTkRP
Ul9JRF9NQVNLIHwgbW9kX2lkKSA9PSBDT05GSUdfU1JWX01PREVMKQ0KPiAgCQkJCWNvbnRpbnVl
Ow0KPiAgDQo+ICAJCQltb2QgPSBsX3F1ZXVlX2ZpbmQoZWxlLT5tb2RlbHMsIG1hdGNoX21vZGVs
X2lkLA0KPiBAQCAtMTA3OCw2ICsxMDc3LDcgQEAgc3RhdGljIGJvb2wgdmFsaWRhdGVfbW9kZWxf
cHJvcGVydHkoc3RydWN0IG5vZGVfZWxlbWVudCAqZWxlLA0KPiAgCQl3aGlsZSAobF9kYnVzX21l
c3NhZ2VfaXRlcl9uZXh0X2VudHJ5KCZpZHMsICZ2ZW5kb3JfaWQsDQo+ICAJCQkJCQkJCSZtb2Rf
aWQpKSB7DQo+ICAJCQlzdHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiArDQo+ICAJCQltb2QgPSBs
X3F1ZXVlX2ZpbmQoZWxlLT5tb2RlbHMsIG1hdGNoX21vZGVsX2lkLA0KPiAgCQkJCUxfVUlOVF9U
T19QVFIoKHZlbmRvcl9pZCA8PCAxNikgfCBtb2RfaWQpKTsNCj4gIAkJCWlmICghbW9kKQ0KPiBA
QCAtMTEwOCwxMCArMTEwOCw5IEBAIHN0YXRpYyB2b2lkIGdldF9tb2RlbHNfZnJvbV9wcm9wZXJ0
aWVzKHN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZSwNCj4gIAlpZiAoIXZlbmRvcikgew0KPiAgCQl3
aGlsZSAobF9kYnVzX21lc3NhZ2VfaXRlcl9uZXh0X2VudHJ5KCZpZHMsICZtb2RfaWQpKSB7DQo+
ICAJCQlzdHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiAtCQkJdWludDMyX3QgbSA9IG1vZF9pZDsN
Cj4gIA0KPiAgCQkJLyogU2tpcCBpbnRlcm5hbGx5IGltcGxlbWVudGVkIG1vZGVscyAqLw0KPiAt
CQkJaWYgKG0gPT0gQ09ORklHX1NSVl9NT0RFTCkNCj4gKwkJCWlmICgoVkVORE9SX0lEX01BU0sg
fCBtb2RfaWQpID09IENPTkZJR19TUlZfTU9ERUwpDQo+ICAJCQkJY29udGludWU7DQo+ICANCj4g
IAkJCW1vZCA9IG1lc2hfbW9kZWxfbmV3KGVsZS0+aWR4LCBtb2RfaWQpOw==
