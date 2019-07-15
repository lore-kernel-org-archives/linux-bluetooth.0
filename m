Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04462C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 22:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FCD2053B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfGOW1I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:27:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:35301 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbfGOW1I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 18:27:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 15:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,494,1557212400"; 
   d="scan'208";a="169072294"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2019 15:27:07 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 15:27:06 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 15:27:06 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: Re: [PATCH BlueZ 00/10 v3] mesh: Configuration storage re-org
Thread-Topic: [PATCH BlueZ 00/10 v3] mesh: Configuration storage re-org
Thread-Index: AQHVOpsjm7ZVmxNEmE6nqN3QNaGcX6bMuP0A
Date:   Mon, 15 Jul 2019 22:27:06 +0000
Message-ID: <1563229624.7215.0.camel@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.137.82]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55E6C6EEDBECA14EB874666480E0EDFA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtU2V0IGFwcGxpZWQsIFRoYW5rcy4NCg0KT24gU3VuLCAyMDE5LTA3LTE0IGF0IDE2OjIz
IC0wNzAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiArIHJlYmFzZSBvZmYgdGhlIHRpcA0KPiAN
Cj4gVGhpcyBzZXQgb2YgcGF0Y2hlcyBpbnRyb2R1Y2VzIHRoZSBub3Rpb24gb2YgZ2VuZXJpYyBt
ZXNoLWNvbmZpZyBBUEkNCj4gdGhhdCBhbGxvd3MgdGhlIGRhZW1vbiB0byBiZSBhZ25vc3RpYyBv
ZiB0aGUgdW5kZXJseWluZyBub2RlIGNvbmZpZ3VyYXRpb24NCj4gZGlyZWN0b3J5IGxheW91dCBh
bmQgdGhlIGZvcm1hdCBvZiB0aGUgZmlsZShzKSBpbiB3aGljaCBub2RlIGNvbmZpZ3VyYXRpb24N
Cj4gaXMgc2F2ZWQuIA0KPiANCj4gQ3VycmVudGx5LCB0aGUgZGFlbW9uIHN1cHBvcnRzIG9ubHkg
SlNPTi1iYXNlZCBjb25maWd1cmF0aW9uIGZvcm1hdC4NCj4gSXQgaXMgZXhwZWN0ZWQgdGhhdCBv
dGhlciBjb25maWd1cmF0aW9uIGZvcm1hdHMgbWF5IGJlIGFkZGVkIGluIGZ1dHVyZS4NCj4gDQo+
IEFzIGEgcmVzdWx0IG9mIHRoZXNlIGNoYW5nZXMsIHN0b3JhZ2UuYyBhbmQgc3RvcmFnZS5oIGFy
ZSBvYnNvbGV0ZQ0KPiBhbmQgYXJlIHJlbW92ZWQuDQo+IA0KPiBJbmdhIFN0b3RsYW5kICgxMCk6
DQo+ICAgbWVzaDogTW92ZSBuZXR3b3JrIGNvbmZpZyBzZXR1cCBmcm9tIHN0b3JhZ2UuYyB0byBu
b2RlLmMNCj4gICBtZXNoOiBSZW5hbWUgbWVzaC1kYi5jIHRvIG1lc2gtY29uZmlnLWpzb24uYw0K
PiAgIG1lc2g6IENoYW5nZSBtZXNoX2RiIHByZWZpeCB0byBtZXNoX2NvbmZpZw0KPiAgIG1lc2g6
IE1vdmUgbG9hZCBmcm9tIHN0b3JhZ2UgZnVuY3Rpb25hbGl0eSBpbnRvIG5vZGUuYw0KPiAgIG1l
c2g6IENvbmZpbmUgZGVwZW5kZW5jeSBvbiBqc29uLWMgdG8gbWVzaC1jb25maWctanNvbi5jDQo+
ICAgbWVzaDogUmVwbGFjZSBzdG9yYWdlX3NhdmVfY29uZmlnIHdpdGggbWVzaF9jb25maWdfc2F2
ZV9jb25maWcNCj4gICBtZXNoOiBVc2UgbWVzaF9jb25maWcgQVBJcyB0byBzdG9yZSBub2RlIGNv
bmZpZ3VyYXRpb24NCj4gICBtZXNoOiBNYW5hZ2Ugbm9kZSBjb25maWcgZGlyZWN0b3J5IGluIG1l
c2gtY29uZmlnDQo+ICAgbWVzaDogQ3JlYXRlIG9yIHJlLXVzZSBhIG5vZGUgc3RvcmFnZSBkaXJl
Y3RvcnkgZm9yIGtleXJpbmcNCj4gICBtZXNoOiBSZW5hbWUgbWVzaF9jb25maWdfc3J2X2luaXQo
KSB0byBjZmdtb2Rfc2VydmVyX2luaXQoKQ0KPiANCj4gIE1ha2VmaWxlLm1lc2ggICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMyArLQ0KPiAgbWVzaC9hcHBrZXkuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDE5ICstDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyAgICAgICAgICAg
ICAgICAgICB8ICAgMzEgKy0NCj4gIG1lc2gvY2ZnbW9kLmggICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgMiArLQ0KPiAgbWVzaC9rZXlyaW5nLmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDM2ICstDQo+ICBtZXNoL3ttZXNoLWRiLmMgPT4gbWVzaC1jb25maWctanNvbi5jfSB8IDEw
NzEgKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICBtZXNoL21lc2gtY29uZmlnLmggICAgICAg
ICAgICAgICAgICAgICB8ICAxNzIgKysrKw0KPiAgbWVzaC9tZXNoLWRiLmggICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTU3IC0tLS0NCj4gIG1lc2gvbWVzaC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxNSArLQ0KPiAgbWVzaC9tZXNoLmggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAxICsNCj4gIG1lc2gvbW9kZWwuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyMyArLQ0KPiAgbWVzaC9uZXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDI2ICstDQo+ICBtZXNoL25vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMjQg
KysrLS0NCj4gIG1lc2gvbm9kZS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMyAr
LQ0KPiAgbWVzaC9zdG9yYWdlLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjU2IC0tLS0t
LS0tLS0tLS0tLQ0KPiAgbWVzaC9zdG9yYWdlLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDUxIC0tDQo+ICBtZXNoL3V0aWwuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMzkg
Ky0NCj4gIG1lc2gvdXRpbC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+
ICAxOCBmaWxlcyBjaGFuZ2VkLCAxMjE5IGluc2VydGlvbnMoKyksIDEzMjEgZGVsZXRpb25zKC0p
DQo+ICByZW5hbWUgbWVzaC97bWVzaC1kYi5jID0+IG1lc2gtY29uZmlnLWpzb24uY30gKDU4JSkN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBtZXNoL21lc2gtY29uZmlnLmgNCj4gIGRlbGV0ZSBtb2Rl
IDEwMDY0NCBtZXNoL21lc2gtZGIuaA0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IG1lc2gvc3RvcmFn
ZS5jDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgbWVzaC9zdG9yYWdlLmgNCj4g
