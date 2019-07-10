Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE1C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F17B20844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfGJRUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:20:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:27268 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfGJRUZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 13:20:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 10:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="317427318"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2019 10:20:23 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 10:20:23 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.63]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 10:20:23 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: RE: [PATCH BlueZ 6/9] mesh: Define storage format specific
 read/write routines
Thread-Topic: [PATCH BlueZ 6/9] mesh: Define storage format specific
 read/write routines
Thread-Index: AQHVNt3AGsVSoct9XEmLaY5Omo5eGqbD8IiAgAAZyvA=
Date:   Wed, 10 Jul 2019 17:20:22 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBCC4E9@ORSMSX103.amr.corp.intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-7-inga.stotland@intel.com>
 <20190710075245.2koao3eyj22wbj7s@mlowasrzechonek2133>
In-Reply-To: <20190710075245.2koao3eyj22wbj7s@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTU4MTQ3YTUtMTFjZi00YzkzLThlNTgtMmY1OTMyNjcyZjY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGtrTTBtQnF5QzMxUE5aSXFaOXoybzl0SGdhWnFnM2R2KzAwbVUyT0ZuM2I3eHZWY0s0TWhIV1drNW42NHpTUiJ9
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layBbbWFpbHRvOm1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFp
ci5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMCwgMjAxOSAxMjo1MyBBTQ0KPiBUbzog
U3RvdGxhbmQsIEluZ2EgPGluZ2Euc3RvdGxhbmRAaW50ZWwuY29tPg0KPiBDYzogbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgR2l4LCBCcmlhbiA8YnJpYW4uZ2l4QGludGVsLmNvbT47
DQo+IGpha3ViLndpdG93c2tpQHNpbHZhaXIuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggQmx1
ZVogNi85XSBtZXNoOiBEZWZpbmUgc3RvcmFnZSBmb3JtYXQgc3BlY2lmaWMNCj4gcmVhZC93cml0
ZSByb3V0aW5lcw0KPiANCj4gT24gMDcvMDksIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+ID4gVGhp
cyBhZGRzIHRoZSBmb2xsb3dpbmcgZ2VuZXJpYyBBUElzIHRvIG1lc2gtY29uZmlnLmgNCj4gPiAg
ICAgdm9pZCAqbWVzaF9jb25maWdfY3JlYXRlX2NvbmZpZyh2b2lkKTsNCj4gPiAgICAgdm9pZCBt
ZXNoX2NvbmZpZ19yZWxlYXNlX2NvbmZpZyh2b2lkICpjb25maWcpOw0KPiA+ICAgICB2b2lkICpt
ZXNoX2NvbmZpZ19nZXRfY29uZmlnKGNvbnN0IGNoYXIgKmRpcik7DQo+ID4gICAgIHZvaWQgKm1l
c2hfY29uZmlnX2dldF9jb25maWdfYmFja3VwKGNvbnN0IGNoYXIgKmRpcik7DQo+ID4gICAgIGJv
b2wgbWVzaF9jb25maWdfcmVzdG9yZV9iYWNrdXAoY29uc3QgY2hhciAqZGlyKTsNCj4gPiAgICAg
Ym9vbCBtZXNoX2NvbmZpZ19zYXZlX2NvbmZpZyhjb25zdCBjaGFyICpkaXIsIHZvaWQgKmNmZyk7
DQo+ID4NCj4gPiBUaGUgaW1wbGVtZW50YXRpb24gb2YgdGhlc2UgQVBJIHJvdXRpbmVzIGRlcGVu
ZHMgb24gdGhlIHVuZGVybHlpbmcNCj4gPiBzdG9yYWdlIGRpcmVjdG9yeSBzdHJ1Y3R1cmUgYW5k
IGNhbiBiZSBzcGVjaWZpYyB0byBhIGNob3Nlbg0KPiA+IGNvbmZpZ3VyYXRpb24gZmlsZSBmb3Jt
YXQuDQo+IA0KPiBJIGRvbid0IGxpa2UgdGhlIGFzc3VtcHRpb24gdGhhdCBlYWNoIG5vZGUgaXMg
c3RvcmVkIGluIGEgc2VwYXJhdGUgZmlsZSwgYW5kIHRoZXJlDQo+IG5lZWRzIHRvIGJlIGEgYmFj
a3VwIGZpbGUuDQoNCkkgdGhpbmsgSSB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBzYXlpbmcgYWJv
dXQgKkhvdyogdGhlIG5vZGUgZGF0YSBpcyBwZXJzZXZlcmVkLCBhbmQgdGhhdCB0aGUgdW5kZXJs
eWluZyBzdG9yYWdlIG1pZ2h0IG5vdCBiZSBhIHR5cGljYWwgZmlsZSBzeXN0ZW0uDQoNCldlICpk
byogbmVlZCBhIG1lY2hhbmlzbSB0byBnZXQgdG8gYW4gZWFybGllciB2ZXJzaW9uIG9mIGEgTm9k
ZSBpZiB0aGVyZSBpcyBjb3JydXB0aW9uIGRldGVjdGVkIGluIHRoZSBtb3N0IHJlc2VudCB2ZXJz
aW9uIChwZXJoYXBzIGFuIHVuZXhwZWN0ZWQgbG9zcyBvZiBwb3dlciBkdXJpbmcgYSB3cml0ZSBv
cGVyYXRpb24pLiAgVGhhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGUgY3VycmVudCBiYWNrdXAgc3lz
dGVtLiAgV2hldGhlciB0aGlzIGlzIGFjY29tcGxpc2hlZCBieSByZWFkaW5nIGEgYmFja3VwIGZp
bGUgb3IgIlJvbGxpbmcgQmFjayIgdGhlIGhpc3Rvcnkgb24gYSBqb3VybmFsIChvciBnaXQgcmVw
bywgb3Igd2hhdGV2ZXIpIHdlIGRvIG5lZWQgdGhhdCBiYWNrdXAuDQoNCkJ1dCB3ZSBjb3VsZCBj
ZXJ0YWlubHkgaGlkZSB0aGUgbWVjaGFuaXNtIG9mIGJhY2tpbmcgdXAgKGFuZCBvZiByZXZlcnRp
bmcgdG8gYSBiYWNrZWQgdXAgdmVyc2lvbikuDQoNCj4gT25lIG9mIHRoZSBzdG9yYWdlIGZvcm1h
dHMgSSBoYWQgaW4gbWluZCBpcyBhIHNpbmdsZSB0cmFuc2FjdGlvbmFsIGRhdGFiYXNlDQo+IChz
b21lIGZsYXZvciBvZiBiZXJrZWxleSBkYiwgb3IgbWF5YmUgZXZlbiBzcWxpdGUpIHRoYXQgd291
bGQgaG9sZCBhbGwgdGhlDQo+IG5vZGVzLg0KPiANCg0K
