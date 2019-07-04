Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF3DC0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B9E218A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGDSAv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:00:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:30241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfGDSAv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 14:00:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 11:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="187628612"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2019 11:00:50 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 11:00:49 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.81]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 11:00:49 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v5 1/5] mesh: Cleanup l_dbus_message_... API usage
 in models
Thread-Topic: [PATCH BlueZ v5 1/5] mesh: Cleanup l_dbus_message_... API
 usage in models
Thread-Index: AQHVMmS8Y1CQNAAdS0a+RyysSsycuKa7NWAA
Date:   Thu, 4 Jul 2019 18:00:48 +0000
Message-ID: <c04efa59b7ff55ff3ea2e93dc0a9baf46b82ba9d.camel@intel.com>
References: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
         <20190704123338.5988-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190704123338.5988-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.106]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F840CD8A72E394D91B290E5EDBBED6E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBlbnRpcmUgcGF0Y2gtc2V0ICpleGNlcHQqIHBhdGNoIDEsIHdoaWNoIGlzIGEgZnVu
Y3Rpb25hbA0KZHVwbGljYXRlIG9mIHRoZSBzYW1lIGxfZGJ1cyBjbGVhbi11cCB0aGF0IEluZ2Eg
c3VibWl0dGVkLg0KDQpUaGlzIGhhcyBiZWVuIHJ1biBhbmQgYnVpbGQgdGVzdGVkLCBidXQgc2lu
Y2UgdGhpcyBhZmZlY3RzIGhhcmQgdG8NCnJlcHJvZHVjZSAqZXJyb3IqIGhhbmRsaW5nLCBwbGVh
c2UgZG91YmxlLWNoZWNrIHRoZSBmaW5hbCByZXN1bHQuDQoNCg0KDQpPbiBUaHUsIDIwMTktMDct
MDQgYXQgMTQ6MzMgKzAyMDAsIE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiAtLS0N
Cj4gIG1lc2gvbW9kZWwuYyB8IDM0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXggNzQw
MWRjZWNiLi44NjhmZTllNTIgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9t
ZXNoL21vZGVsLmMNCj4gQEAgLTI0OSwxMCArMjQ5LDEwIEBAIHN0YXRpYyB2b2lkDQo+IGNvbmZp
Z191cGRhdGVfbW9kZWxfcHViX3BlcmlvZChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLA0KPiAgCQkJ
CQkJCQkmcGVyaW9kDQo+ICk7DQo+ICANCj4gIAlsX2RidXNfbWVzc2FnZV9idWlsZGVyX2xlYXZl
X2FycmF5KGJ1aWxkZXIpOw0KPiAtCWlmIChsX2RidXNfbWVzc2FnZV9idWlsZGVyX2ZpbmFsaXpl
KGJ1aWxkZXIpKQ0KPiAtCQlsX2RidXNfc2VuZChkYnVzLCBtc2cpOw0KPiAtDQo+ICsJbF9kYnVz
X21lc3NhZ2VfYnVpbGRlcl9maW5hbGl6ZShidWlsZGVyKTsNCj4gIAlsX2RidXNfbWVzc2FnZV9i
dWlsZGVyX2Rlc3Ryb3koYnVpbGRlcik7DQo+ICsNCj4gKwlsX2RidXNfc2VuZChkYnVzLCBtc2cp
Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBhcHBlbmRfZGljdF91aW50MTZfYXJyYXkoc3Ry
dWN0IGxfZGJ1c19tZXNzYWdlX2J1aWxkZXINCj4gKmJ1aWxkZXIsDQo+IEBAIC0yOTEsMTAgKzI5
MSwxMCBAQCBzdGF0aWMgdm9pZCBjb25maWdfdXBkYXRlX21vZGVsX2JpbmRpbmdzKHN0cnVjdA0K
PiBtZXNoX25vZGUgKm5vZGUsDQo+ICAJYXBwZW5kX2RpY3RfdWludDE2X2FycmF5KGJ1aWxkZXIs
IG1vZC0+YmluZGluZ3MsICJCaW5kaW5ncyIpOw0KPiAgDQo+ICAJbF9kYnVzX21lc3NhZ2VfYnVp
bGRlcl9sZWF2ZV9hcnJheShidWlsZGVyKTsNCj4gLQlpZiAobF9kYnVzX21lc3NhZ2VfYnVpbGRl
cl9maW5hbGl6ZShidWlsZGVyKSkNCj4gLQkJbF9kYnVzX3NlbmQoZGJ1cywgbXNnKTsNCj4gLQ0K
PiArCWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfZmluYWxpemUoYnVpbGRlcik7DQo+ICAJbF9kYnVz
X21lc3NhZ2VfYnVpbGRlcl9kZXN0cm95KGJ1aWxkZXIpOw0KPiArDQo+ICsJbF9kYnVzX3NlbmQo
ZGJ1cywgbXNnKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgZm9yd2FyZF9tb2RlbCh2b2lk
ICphLCB2b2lkICpiKQ0KPiBAQCAtNzE0LDI1ICs3MTQsMTUgQEAgc3RhdGljIHZvaWQgc2VuZF9t
c2dfcmN2ZChzdHJ1Y3QgbWVzaF9ub2RlDQo+ICpub2RlLCB1aW50OF90IGVsZV9pZHgsIGJvb2wg
aXNfc3ViLA0KPiAgDQo+ICAJYnVpbGRlciA9IGxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfbmV3KG1z
Zyk7DQo+ICANCj4gLQlpZiAoIWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfYXBwZW5kX2Jhc2ljKGJ1
aWxkZXIsICdxJywgJnNyYykpDQo+IC0JCWdvdG8gZXJyb3I7DQo+ICsJbF9kYnVzX21lc3NhZ2Vf
YnVpbGRlcl9hcHBlbmRfYmFzaWMoYnVpbGRlciwgJ3EnLCAmc3JjKTsNCj4gKwlsX2RidXNfbWVz
c2FnZV9idWlsZGVyX2FwcGVuZF9iYXNpYyhidWlsZGVyLCAncScsICZrZXlfaWR4KTsNCj4gKwls
X2RidXNfbWVzc2FnZV9idWlsZGVyX2FwcGVuZF9iYXNpYyhidWlsZGVyLCAnYicsICZpc19zdWIp
Ow0KPiArCWRidXNfYXBwZW5kX2J5dGVfYXJyYXkoYnVpbGRlciwgZGF0YSwgc2l6ZSk7DQo+ICAN
Cj4gLQlpZiAoIWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfYXBwZW5kX2Jhc2ljKGJ1aWxkZXIsICdx
JywNCj4gJmtleV9pZHgpKQ0KPiAtCQlnb3RvIGVycm9yOw0KPiAtDQo+IC0JaWYgKCFsX2RidXNf
bWVzc2FnZV9idWlsZGVyX2FwcGVuZF9iYXNpYyhidWlsZGVyLCAnYicsDQo+ICZpc19zdWIpKQ0K
PiAtCQlnb3RvIGVycm9yOw0KPiAtDQo+IC0JaWYgKCFkYnVzX2FwcGVuZF9ieXRlX2FycmF5KGJ1
aWxkZXIsIGRhdGEsIHNpemUpKQ0KPiAtCQlnb3RvIGVycm9yOw0KPiAtDQo+IC0JaWYgKCFsX2Ri
dXNfbWVzc2FnZV9idWlsZGVyX2ZpbmFsaXplKGJ1aWxkZXIpKQ0KPiAtCQlnb3RvIGVycm9yOw0K
PiArCWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfZmluYWxpemUoYnVpbGRlcik7DQo+ICsJbF9kYnVz
X21lc3NhZ2VfYnVpbGRlcl9kZXN0cm95KGJ1aWxkZXIpOw0KPiAgDQo+ICAJbF9kYnVzX3NlbmQo
ZGJ1cywgbXNnKTsNCj4gLQ0KPiAtZXJyb3I6DQo+IC0JbF9kYnVzX21lc3NhZ2VfYnVpbGRlcl9k
ZXN0cm95KGJ1aWxkZXIpOw0KPiAgfQ0KPiAgDQo+ICBib29sIG1lc2hfbW9kZWxfcngoc3RydWN0
IG1lc2hfbm9kZSAqbm9kZSwgYm9vbCBzem1pY3QsIHVpbnQzMl90DQo+IHNlcTAsDQo=
