Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB8C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88AC206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tK4nDwRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgAHRbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:31:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:49176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgAHRbT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 12:31:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="217571543"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2020 09:31:18 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 09:31:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 09:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eux33iF9oTi+whJbRZtt120p6TRHMxrqA77feRmYKEt5ZlyV+JwuWJCGhitKvVcXBHQwhkmwQc8Hp4bz+u6pj1vmD6IpDRAu1oTpPUVNUFatzu2YbT6BjFuqCk2UNofqn8eyorYXyIKAzZAavU2Zs7AId5VI9V9A8ngz4nG9eM7s99RlIYKqpJMCeKCEqcyMET7vFq//5R0V5xm0EBbd4Isla3MzUiBAClxnuNHb6oybZyr2deGPFh7NI3IRyfOCgONAo/3s1OjXB5du1brJjkrgr/XMndKoHfz7gGtnHvD21Hs+Xg8/0Bzy/qUJf3UrMAVdavPsq0SC83XjmhpVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jRJiI8icb1A46ZoK1y26lIY6M5CYLhbdkZ2GNd7MYk=;
 b=DVMcgcARlhcxdro61+fQyik5qQzSaSi6X/FJjPNLIc8gXQzmQaoa/1eLJRjG76SbuMV0Xerhw98w19vPQLnU4CivChUkYDuiJVvaa02DhnZUb/YUtA+F1XNDZbN23EuIS0vaAIl/nl+StRHF2MK5Ej5SqahyFGwl7RsTTgO3XAhyfQTrU+cYzXdO5EIIpYIx53REJQiRLVV7vY+SToumvCZepRt5nvRqLyz/EHZj0Sdym9Id9VOszV9Cd21QsY9EwO12g6VpGwPhbNhWY+aMcBrMeSAWpwzpAduL6Ol2LAY41AswK+H/fPiz9dqlbO6unjdYSG7ryX9I/ATwZMXC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jRJiI8icb1A46ZoK1y26lIY6M5CYLhbdkZ2GNd7MYk=;
 b=tK4nDwRxSM7PKF2rPgmjiG86g+lByoNKxANJqX1+Us6lS+9ZFNQe9spCEezcjiNXOTw5SmR3IqPTM1J/cFQz4noXGhFTfSxzhhXMBjvSBLs1KcBjUO/lvNL63s5fBLCt6qUR9dYeoujBi4v+hSKGaSRTtM5yo08Cl/52Z3MFcWY=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1864.namprd11.prod.outlook.com (10.175.61.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 17:31:17 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 17:31:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix IV recovery
Thread-Topic: [PATCH BlueZ] mesh: Fix IV recovery
Thread-Index: AQHVxgR/8xapfAtCSUOKccW41kLVXKfhBtKA
Date:   Wed, 8 Jan 2020 17:31:16 +0000
Message-ID: <89614c82891524958af2a7c75c1792b0c9ca4467.camel@intel.com>
References: <20200108091604.15185-1-rafal.gajda@silvair.com>
In-Reply-To: <20200108091604.15185-1-rafal.gajda@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba551eb5-fb94-42e7-81a4-08d794609126
x-ms-traffictypediagnostic: CY4PR11MB1864:
x-microsoft-antispam-prvs: <CY4PR11MB18648457F5AFFDC36BFD8E5EE13E0@CY4PR11MB1864.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(8936002)(5660300002)(478600001)(81156014)(81166006)(36756003)(8676002)(186003)(26005)(71200400001)(2616005)(6506007)(2906002)(110136005)(6512007)(86362001)(6486002)(66946007)(66556008)(66476007)(64756008)(66446008)(91956017)(316002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1864;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jl0pnbwRk4ua5WosHy1j+LA4YmswmjyhxzRXfle23bIypSk4YqtwobcmsoOF7qAHAJk1uYGJrMsO5I/tAkVZJPTs921xJkSa63FbPRwP/KvHxKRtqGq15boPH8FwEOp3J+wZ24hpjTL3i0zEe3edj1dyDUpU8zqKJPeHLr2Pmzal4fO0mZRRayh46sKJ+nb+F1ZvVHHMZz7V1psPPaR4jLz4iI8//wqPyqTuVgUX07uqHkx17UT//k6inBTHcvxYpbDeqFSrikU+aw4vsqYbpqLHOdTR6OvsJ0oPU7MaZQKgEVy6LZ9Vm2qO29zQKZO0G9iPGxcw7hF+gJ+aea6OA+LZK7Rjgxbpcimt7SlezF/w6ER4Ysg3uRU8cz8+Y1sE5fg/RhzaxLNnQFB/DasLASuGapCbX0iRyqxtZvaEfQHldzTmwgzATeI5ct8t9OhT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F2B3D9E66794499EDAD056D0EDDE3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba551eb5-fb94-42e7-81a4-08d794609126
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 17:31:16.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+c/uoXqM0j9/0kQuGzVxTo69hM6N/rlAUeNZjXaW9madezYNGYTWthozXUVSATprvzUeUPbN2LL8kC2bqcJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1864
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUmFmYcWCLA0KDQpPbiBXZWQsIDIwMjAtMDEtMDggYXQgMTA6MTYgKzAxMDAsIFJhZmHFgiBH
YWpkYSB3cm90ZToNCj4gVGhpcyBwYXRjaCBmaXhlcyBzYXZpbmcgSVYgcmVjZWl2ZWQgaW4gU05C
IHRvIHN0b3JhZ2UuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IFByZXZp
b3VzbHkgYWZ0ZXIgY3JlYXRpbmcgbmV3IG5vZGUgd2l0aCBJViAwIChvciBsb2FkaW5nIG5vZGUg
d2l0aCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gSVYgPiAwIGJ1dCBhZnRl
ciBsb25nIGluYWN0aXZpdHkpIGZpcnN0IHJlY2VpdmVkIFNOQiBzaG91bGQgdXBkYXRlIElWICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAoYW5kIHJlc2V0IHNlcXVlbmNlIG51bWJl
ciB0byAwIGlmIG5lY2Vzc2FyeSkuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCj4gVGhlIGJ1ZyB3b3VsZCBwcmV2ZW50IG5ldyBJViBiZWluZyBzYXZlZCBpbiBz
dG9yYWdlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
PiB3aGljaCByZXN1bHRlZCBpbiBzZXF1ZW5jZSBudW1iZXIgYmVpbmcgc2V0IHRvIDAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IG9uIGZpcnN0
IFNOQiByZWNlaXZlZCBhZnRlciBldmVyeSBkYWVtb24gcmVzZXQgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gYnV0IElWIG5ldmVyIGJlaW5n
IHVwZGF0ZWQuICAgICAgICAgICAgICAgIA0KPiAtLS0NCj4gIG1lc2gvbmV0LmMgfCAyMCArKysr
KysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMN
Cj4gaW5kZXggNWJlOTUwODZkLi4xNTk4OTMzZDQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMN
Cj4gKysrIGIvbWVzaC9uZXQuYw0KPiANCg0KPC4uLj4NCg0KPiBAQCAtMjczNywyNiArMjczMCwy
NyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfaXZfaXZ1X3N0YXRlKHN0cnVjdCBtZXNoX25ldCAqbmV0
LCB1aW50MzJfdCBpdl9pbmRleCwNCj4gIAkJfQ0KPiAgCX0gZWxzZSBpZiAoaXZ1KSB7DQo+ICAJ
CS8qIElnbm9yZSBiZWFjb25zIHdpdGggSVZVIGlmIHRoZXkgY29tZSB0b28gc29vbiAqLw0KPiAt
CQlpZiAoIWxvY2FsX2l2dSAmJiBuZXQtPml2X3VwZF9zdGF0ZSA9PSBJVl9VUERfTk9STUFMX0hP
TEQpIHsNCj4gKwkJaWYgKCFuZXQtPml2X3VwZGF0ZSAmJg0KPiArCQkJCW5ldC0+aXZfdXBkX3N0
YXRlID09IElWX1VQRF9OT1JNQUxfSE9MRCkgew0KPiAgCQkJbF9lcnJvcigiVXBkYXRlIGF0dGVt
cHRlZCB0b28gc29vbiIpOw0KPiAgCQkJcmV0dXJuOw0KPiAgCQl9DQo+ICANCj4gLQkJaWYgKCFs
b2NhbF9pdnUpIHsNCj4gKwkJaWYgKCFuZXQtPml2X3VwZGF0ZSkgew0KPiAgCQkJbF9pbmZvKCJp
dl91cGRfc3RhdGUgPSBJVl9VUERfVVBEQVRJTkciKTsNCj4gIAkJCW5ldC0+aXZfdXBkX3N0YXRl
ID0gSVZfVVBEX1VQREFUSU5HOw0KPiAgCQkJbmV0LT5pdl91cGRhdGVfdGltZW91dCA9IGxfdGlt
ZW91dF9jcmVhdGUoDQo+ICAJCQkJCUlWX0lEWF9VUERfTUlOLCBpdl91cGRfdG8sIG5ldCwgTlVM
TCk7DQo+ICAJCX0NCj4gLQl9IGVsc2UgaWYgKGxvY2FsX2l2dSkgew0KPiArCX0gZWxzZSBpZiAo
bmV0LT5pdl91cGRhdGUpIHsNCj4gIAkJbF9lcnJvcigiSVZVIGNsZWFyIGF0dGVtcHRlZCB0b28g
c29vbiIpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKChpdl9pbmRleCAtIGl2
dSkgPiAobG9jYWxfaXZfaW5kZXggLSBsb2NhbF9pdnUpKQ0KPiArCWlmICgoaXZfaW5kZXggLSBp
dnUpID4gKG5ldC0+aXZfaW5kZXggLSBuZXQtPml2X3VwZGF0ZSkpDQo+ICAJCW1lc2hfbmV0X3Nl
dF9zZXFfbnVtKG5ldCwgMCk7DQo+ICANCj4gLQlpZiAoaXZ1ICE9IG5ldC0+aXZfdXBkYXRlIHx8
IGxvY2FsX2l2X2luZGV4ICE9IG5ldC0+aXZfaW5kZXgpIHsNCj4gKwlpZiAoaXZ1ICE9IG5ldC0+
aXZfdXBkYXRlIHx8IGl2X2luZGV4ICE9IG5ldC0+aXZfaW5kZXgpIHsNCg0KV291bGQgaXQgYmUg
ZmFpciB0byBzYXkgdGhhdCB0aGlzIGlzIHRoZSAqb25seSogY2hhbmdlIHRvIHRoZSBjb2RlIHRo
YXQgZml4ZXMgdGhlIGxvZ2ljIHRoYXQgd2FzDQptYWxmdW5jdGlvbmluZz8NCg0KSWYgc28sIEkg
d291bGQgbGlrZSB0byBzaHJpbmsgdGhpcyBwYXRjaCB0byBqdXN0Og0KDQotCWlmIChpdnUgIT0g
bmV0LT5pdl91cGRhdGUgfHwgbG9jYWxfaXZfaW5kZXggIT0gbmV0LT5pdl9pbmRleCkgew0KKwlp
ZiAoaXZ1ICE9IGxvY2FsX2l2dSB8fCBpdl9pbmRleCAhPSBsb2NhbF9pdl9pbmRleCkgew0KDQoN
Cm9yLCBicmVha2luZyB0aGlzIGludG8gYSAyLXBhdGNoIHBhdGNoc2V0LCB3aGVyZSBvbmUgb2Yg
dGhlIHBhdGNoZXMgcmVtb3ZlcyB0aGUgbG9jYWwgY2FjaGluZyBvZiBpdnUgYW5kIGl2aSwNCmFu
ZCB0aGUgc2Vjb25kIHBhdGNoIGZpeGVzIHRoZSBhY3R1YWwgYnVnLg0KDQo+ICAJCXN0cnVjdCBt
ZXNoX2NvbmZpZyAqY2ZnID0gbm9kZV9jb25maWdfZ2V0KG5ldC0+bm9kZSk7DQo+ICANCj4gIAkJ
bWVzaF9jb25maWdfd3JpdGVfaXZfaW5kZXgoY2ZnLCBpdl9pbmRleCwgaXZ1KTsNCg==
