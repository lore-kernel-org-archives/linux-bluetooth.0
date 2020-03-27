Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A43CC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BAE2074F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Eq3wsL8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Psu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:48:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:30516 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgC0Psu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 11:48:50 -0400
IronPort-SDR: 8Q7YBA6w2ng9eOKwnV8nfH0Ct0U8coso85AefEff0aXkgzpoHuWIr6igf/7QbHbP8xTupy9ysm
 FgZ1j3rt1v6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 08:48:49 -0700
IronPort-SDR: RslbV5j2V162bC8O5G+zljiPLKBvKXTaSyAcrkIQTtcdJS5csZZhMfI/Ish3iZ6geu5HVSTTiE
 el4fUkrUT9dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="447457322"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 08:48:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 08:48:48 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 08:48:48 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Mar 2020 08:48:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 08:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDCaZ3cSJm5VzU5/ho58NZbwS+7H1MXxR0PhxToojl+sypAQTtDxjacVNaNy3foG8SlqaO1Z9+uXtuBxtWIrycgXMOPSD2q2nHkEfmlmHdn0nJSXIzL6lLstdBCdTUMbRAXixkBoe4IxXspHoESxb+tWbuiC3az6hs2Yh5+IAB5Or8tuzWoXQUP8b0qrTHLJ6/2pwypEX8/bmzT0KNV9VuZN9HMBwvwVkcyFSDtCmV3kirqXV7E+nj7wgWHnFiVIv0TJ7B7SKH7XEfxKOSrxRp3Sc5kpGtqv9Tnq0XmtzcdG7wNfs7jYnh1QK2D0gykWnBsY2q7/ZfJLDg3ZaxY1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6MR0a6LoT3ALwDwejd0luKOQuDPw5mfY6fJbzPFj3g=;
 b=gBjkTo+nZ9mRPo60bagXWDJgLVYxlp4PLMe9s/OprUh4thmkOYYJgxE8jRLU2T8KXJDYHMP4NB4o01P8m16ofxUv2R8eH9BpKecO56HVX3iT6pqLiltY2C8mXzvST466BtRTPOVnrFQsxAghAUs8mrkR93puxmRxsA4k80twlq4WiKIjJAVil8C/b+yTQ/7hR2SbLh1wxTyIjdjqFcJ8jQeTG7SK4UjyaJEQ/IxSzEt0X2aebCWRqNTnz6e+bLRZg2Rfig6uxclNnM4y3hufytf0v8MXqxslo9g1PvvTES2CCT+2F/+iM66zOR4iif5Nial3Ewz7cQyswkbOaRk+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6MR0a6LoT3ALwDwejd0luKOQuDPw5mfY6fJbzPFj3g=;
 b=Eq3wsL8LMFQRISqx1YImUVTOOyoakS/gnpxmldcyxtPaN+eoWWgrWhaSnErjOiY7hTcFig05BGL4Ft9+lFkSryFQ71gayncY8X4oFKN6KkWJZuNPb54K1mtxuOmAKAHkpvyR7+z2qyGsbzaPapuWRWSPTibM1OwsfQt9Dcy6htY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by SA9SPR01MB0003.namprd11.prod.outlook.com (2603:10b6:806:45::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 27 Mar
 2020 15:48:41 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:48:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add net key index to send_seg()
Thread-Topic: [PATCH BlueZ] mesh: Add net key index to send_seg()
Thread-Index: AQHWBDo2O+813TI47E64bvQkX/NNMqhcleoA
Date:   Fri, 27 Mar 2020 15:48:41 +0000
Message-ID: <4ef38cfb7149f3b52f8ee4e76d718ef25d64fd71.camel@intel.com>
References: <20200327131800.7637-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200327131800.7637-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca7f2963-ac4b-47f6-05e8-08d7d26652f5
x-ms-traffictypediagnostic: SA9SPR01MB0003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA9SPR01MB00033345C34B4B2FB9345DEEE1CC0@SA9SPR01MB0003.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(346002)(376002)(81156014)(81166006)(6486002)(6512007)(5660300002)(26005)(186003)(6506007)(2616005)(36756003)(316002)(2906002)(66556008)(64756008)(71200400001)(8676002)(478600001)(8936002)(107886003)(66446008)(110136005)(66476007)(86362001)(54906003)(4326008)(76116006)(91956017)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:SA9SPR01MB0003;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5VAIZS/pEn/CXWm9OJIH/a0PNM60IM8JDbPs1oN3vzCU3kV+p7Lypew7jn9mDkJ7i4SDuSvq+TmG6UUk9hSGu05m8dfdO9X7dnsN7pqyvX2o6l9APLxPPsu2ACEq8JpS4662wmQOBd/gXNFDqQu5QyVZAdRzE1kHWvnDupnidw7wOwrRgQrP+x5gW0348r6c9b6kl2wtri+E+dlgcEjJ5xV9DOWuHpmrB1QfMoDWOp4ZjZDmZ6J/TFclQ3FWV3H+7yeErsR9ybYPg2L7jzZBudUZsrskbSYv2AEnKP+JgBCTDYgWadxTFYViw/iOjBk48WeXry8hbuVgLYFG86nJ37+PCtd+IDDd6AdEg4F5CZqPHrR27itmF4CiHSN0wXDmD6LoERNC1aIRG6QeNJWeQptYcsyLpSSwpKSr8NcOqJA7MZkaZF54VDagC2pBRDX
x-ms-exchange-antispam-messagedata: SnH+1LUBgjQVucpnYQGc4iEV8XxNzLH8WmEVZAZvTlXWPoI1KTsMuzd2TeFQGdcp/poJT+5iXE0BrhfLI0p43z8Zck9gu7CxFoauKkvGM8nsaypZk0pKCZgbL5MBrnyEEhtHs/2P94S1jS9r0JqgAQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <22958FA97FA6F74EA46E983744437624@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7f2963-ac4b-47f6-05e8-08d7d26652f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 15:48:41.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Et0+Impspkqj3J0DJtc7JFXfhb5d5prz/v8ZfjAc8P9yNi51Qcxz8iIcwiN8XIXooyH3L/lwfJS/yNw/uOr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9SPR01MB0003
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KSSBsaWtlIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gZml4IGhlcmUsIGJ1
dCBJIGhhdmUgYSBzbGlnaHRseSBkaWZmZXJlbnQgc3VnZ2VzdGlvbi4NCg0KVGhlcmUgaXMgb25l
IHVzZSBjYXNlIHdoaWNoIGlzIGJlaW5nIG1pc3NlZCBoZXJlOiBSZXNlbmRzIG9mIHNlZ21lbnRz
IG9mIGEgc2VnbWVudGVkIERldmljZSBLZXkgbWVzc2FnZSwgd2hpY2gNCmRvIG5vdCBoYXZlIGEg
Ym91bmQgbmV0X2tleSwgYW5kIGNhbiB1c2UgKmFueSogbmV0X2lkeC4NCg0KV2hlbiB0aGUgaW5p
dGlhbCBPdXRnb2luZyBtZXNzYWdlIGlzIGNvbXBvc2VkIGluIG1lc2hfbmV0X2FwcF9zZW5kKCks
IHRoZSBuZXRfaWR4IGlzIGtub3duLCBhbmQgc2hvdWxkIGJlIGZpeGVkDQpmb3IgdGhlIGxpZmUg
b2YgdGhlIHNlZ21lbnRlZCBzZW5kIHByb2NlZHVyZS4gSSB0aGluayB3ZSBzaG91bGQganVzdCBh
ZGQgbmV0X2lkeCB0byB0aGUgbWVzaF9zYXIgc3RydWN0dXJlLCBhbmQNCnVzZSB0aGF0IGVhY2gg
dGltZSBhIHNlZ21lbnQgbmVlZHMgdG8gYmUgcmVzZW50Lg0KDQpBbmQgdGhlbiBuZXh0LCB3ZSB3
aWxsIHByb2JhYmx5IG5lZWQgdG8gbWFrZSBzdXJlIG91ciBvdXRnb2luZyBBQ0tzIHRvIGluY29t
aW5nIFNBUiBtZXNzYWdlcyBhcmUgc2VudCBvbiB0aGUNCmNvcnJlY3QgbmV0X2tleS4NCg0KT24g
RnJpLCAyMDIwLTAzLTI3IGF0IDE0OjE4ICswMTAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25layB3
cm90ZToNCj4gRnJvbTogUHJ6ZW15c8WCYXcgRmllcmVrIDxwcnplbXlzbGF3LmZpZXJla0BzaWx2
YWlyLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBuZXQga2V5IGluZGV4IHRvIHNlbmRfc2Vn
KCkuIFRoaXMgZml4ZXMgcHJvYmxlbSB3aXRoDQo+IHVzaW5nIGludmFsaWQgbmV0d29yayBrZXkg
dG8gZW5jcnlwdCBhcHBsaWNhdGlvbiBtZXNzYWdlcy4NCj4gLS0tDQo+ICBtZXNoL25ldC5jIHwg
MjYgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25ldC5j
IGIvbWVzaC9uZXQuYw0KPiBpbmRleCAwMzQzYzRjNDkuLmM5YWI4NDNmYSAxMDA2NDQNCj4gLS0t
IGEvbWVzaC9uZXQuYw0KPiArKysgYi9tZXNoL25ldC5jDQo+IEBAIC0xNTI4LDcgKzE1MjgsOCBA
QCBzdGF0aWMgdm9pZCBmcmllbmRfYWNrX3J4ZWQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQz
Ml90IGl2X2luZGV4LA0KPiAgCWxfcXVldWVfZm9yZWFjaChuZXQtPmZyaWVuZHMsIGVucXVldWVf
ZnJpZW5kX3BrdCwgJmZybmRfYWNrKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGJvb2wgc2VuZF9z
ZWcoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHN0cnVjdCBtZXNoX3NhciAqbXNnLCB1aW50OF90IHNl
Zyk7DQo+ICtzdGF0aWMgYm9vbCBzZW5kX3NlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2
X3QgbmV0X2lkeCwNCj4gKwkJCQkJc3RydWN0IG1lc2hfc2FyICptc2csIHVpbnQ4X3Qgc2VnKTsN
Cj4gIA0KPiAgc3RhdGljIHZvaWQgc2VuZF9mcm5kX2FjayhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwg
dWludDE2X3Qgc3JjLCB1aW50MTZfdCBkc3QsDQo+ICAJCQkJCQl1aW50MzJfdCBoZHIsIHVpbnQz
Ml90IGZsYWdzKQ0KPiBAQCAtMTY4NCw2ICsxNjg1LDcgQEAgc3RhdGljIHZvaWQgYWNrX3JlY2Vp
dmVkKHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIHRpbWVvdXQsDQo+ICAJc3RydWN0IG1lc2hf
c2FyICpvdXRnb2luZzsNCj4gIAl1aW50MzJfdCBzZWdfZmxhZyA9IDB4MDAwMDAwMDE7DQo+ICAJ
dWludDMyX3QgYWNrX2NvcHkgPSBhY2tfZmxhZzsNCj4gKwl1aW50MTZfdCBuZXRfaWR4Ow0KPiAg
CXVpbnQxNl90IGk7DQo+ICANCj4gIAlsX2luZm8oIkFDSyBSeGVkICgleCkgKHRvOiVkKTogJTgu
OHgiLCBzZXEwLCB0aW1lb3V0LCBhY2tfZmxhZyk7DQo+IEBAIC0xNzM0LDcgKzE3MzYsOSBAQCBz
dGF0aWMgdm9pZCBhY2tfcmVjZWl2ZWQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIGJvb2wgdGltZW91
dCwNCj4gIAkJbF9pbmZvKCJSZXNlbmQgU2VnICVkIG5ldDolcCBkc3Q6JXggYXBwX2lkeDolMy4z
eCIsDQo+ICAJCQkJaSwgbmV0LCBvdXRnb2luZy0+cmVtb3RlLCBvdXRnb2luZy0+YXBwX2lkeCk7
DQo+ICANCj4gLQkJc2VuZF9zZWcobmV0LCBvdXRnb2luZywgaSk7DQo+ICsJCW5ldF9pZHggPSBh
cHBrZXlfbmV0X2lkeChuZXQsIG91dGdvaW5nLT5hcHBfaWR4KTsNCj4gKw0KPiArCQlzZW5kX3Nl
ZyhuZXQsIG5ldF9pZHgsIG91dGdvaW5nLCBpKTsNCj4gIAl9DQo+ICANCj4gIAlsX3RpbWVvdXRf
cmVtb3ZlKG91dGdvaW5nLT5zZWdfdGltZW91dCk7DQo+IEBAIC0zMDU4LDggKzMwNjIsOCBAQCBi
b29sIG1lc2hfbmV0X2ZsdXNoKHN0cnVjdCBtZXNoX25ldCAqbmV0KQ0KPiAgCXJldHVybiB0cnVl
Ow0KPiAgfQ0KPiAgDQo+IC0vKiBUT0RPOiBhZGQgbmV0IGtleSBpbmRleCAqLw0KPiAtc3RhdGlj
IGJvb2wgc2VuZF9zZWcoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHN0cnVjdCBtZXNoX3NhciAqbXNn
LCB1aW50OF90IHNlZ08pDQo+ICtzdGF0aWMgYm9vbCBzZW5kX3NlZyhzdHJ1Y3QgbWVzaF9uZXQg
Km5ldCwgdWludDE2X3QgbmV0X2lkeCwNCj4gKwkJCQkJc3RydWN0IG1lc2hfc2FyICptc2csIHVp
bnQ4X3Qgc2VnTykNCj4gIHsNCj4gIAlzdHJ1Y3QgbWVzaF9zdWJuZXQgKnN1Ym5ldDsNCj4gIAl1
aW50OF90IHNlZ19sZW47DQo+IEBAIC0zMDY4LDcgKzMwNzIsNiBAQCBzdGF0aWMgYm9vbCBzZW5k
X3NlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgc3RydWN0IG1lc2hfc2FyICptc2csIHVpbnQ4X3Qg
c2VnTykNCj4gIAl1aW50OF90IHBhY2tldF9sZW47DQo+ICAJdWludDhfdCBzZWdOID0gU0VHX01B
WChtc2ctPnNlZ21lbnRlZCwgbXNnLT5sZW4pOw0KPiAgCXVpbnQxNl90IHNlZ19vZmYgPSBTRUdf
T0ZGKHNlZ08pOw0KPiAtCXVpbnQzMl90IGtleV9pZCA9IDA7DQo+ICAJdWludDMyX3Qgc2VxX251
bTsNCj4gIA0KPiAgCWlmIChtc2ctPnNlZ21lbnRlZCkgew0KPiBAQCAtMzEwOSwxMCArMzExMiwx
MyBAQCBzdGF0aWMgYm9vbCBzZW5kX3NlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgc3RydWN0IG1l
c2hfc2FyICptc2csIHVpbnQ4X3Qgc2VnTykNCj4gIAl9DQo+ICAJcHJpbnRfcGFja2V0KCJDbHIt
TmV0IFR4IiwgcGFja2V0ICsgMSwgcGFja2V0X2xlbik7DQo+ICANCj4gLQlzdWJuZXQgPSBnZXRf
cHJpbWFyeV9zdWJuZXQobmV0KTsNCj4gLQlrZXlfaWQgPSBzdWJuZXQtPm5ldF9rZXlfdHg7DQo+
ICsJc3VibmV0ID0gbF9xdWV1ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0Y2hfa2V5X2luZGV4LA0K
PiArCQkJCQkJCUxfVUlOVF9UT19QVFIobmV0X2lkeCkpOw0KPiArCWlmICghc3VibmV0KQ0KPiAr
CQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gLQlpZiAoIW5ldF9rZXlfZW5jcnlwdChrZXlfaWQsIG1z
Zy0+aXZfaW5kZXgsIHBhY2tldCArIDEsIHBhY2tldF9sZW4pKSB7DQo+ICsJaWYgKCFuZXRfa2V5
X2VuY3J5cHQoc3VibmV0LT5uZXRfa2V5X3R4LCBtc2ctPml2X2luZGV4LCBwYWNrZXQgKyAxLA0K
PiArCQkJCQkJCSAgICAgcGFja2V0X2xlbikpIHsNCj4gIAkJbF9lcnJvcigiRmFpbGVkIHRvIGVu
Y29kZSBwYWNrZXQiKTsNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgCX0NCj4gQEAgLTMyNzIsMTEg
KzMyNzgsMTEgQEAgYm9vbCBtZXNoX25ldF9hcHBfc2VuZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwg
Ym9vbCBmcm5kX2NyZWQsIHVpbnQxNl90IHNyYywNCj4gIA0KPiAgCQlmb3IgKGkgPSAwOyBpIDwg
NDsgaSsrKSB7DQo+ICAJCQlmb3IgKHNlZyA9IDA7IHNlZyA8PSBzZWdfbWF4ICYmIHJlc3VsdDsg
c2VnKyspDQo+IC0JCQkJcmVzdWx0ID0gc2VuZF9zZWcobmV0LCBwYXlsb2FkLCBzZWcpOw0KPiAr
CQkJCXJlc3VsdCA9IHNlbmRfc2VnKG5ldCwgbmV0X2lkeCwgcGF5bG9hZCwgc2VnKTsNCj4gIAkJ
fQ0KPiAgCX0gZWxzZSB7DQo+ICAJCWZvciAoc2VnID0gMDsgc2VnIDw9IHNlZ19tYXggJiYgcmVz
dWx0OyBzZWcrKykNCj4gLQkJCXJlc3VsdCA9IHNlbmRfc2VnKG5ldCwgcGF5bG9hZCwgc2VnKTsN
Cj4gKwkJCXJlc3VsdCA9IHNlbmRfc2VnKG5ldCwgbmV0X2lkeCwgcGF5bG9hZCwgc2VnKTsNCj4g
IAl9DQo+ICANCj4gIAkvKiBSZWxpYWJsZTogQ2FjaGU7IFVucmVsaWFibGU6IEZsdXNoKi8NCg==
