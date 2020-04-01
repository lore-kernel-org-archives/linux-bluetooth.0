Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C066C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A397206F6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Fb61LxzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbgDATKQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:10:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:42983 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbgDATKQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 15:10:16 -0400
IronPort-SDR: oqePL2XP38a+faBzegVAK5r93hxHLWXbjDPKxp3VHF5YbRQo+pxj4P11rt6Wk585B21iEqv9Lf
 pvQvNYj6UMwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 12:10:15 -0700
IronPort-SDR: zZhuSZxzPtCZ94Qqr7lV4Va8PnxPq5ASiezq47rq3YQesr8/05GG+fYuMKIX6HErt2HTZq8b1u
 agEHrcGMy3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="252737380"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2020 12:10:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 12:10:15 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 12:10:14 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 12:10:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Apr 2020 12:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg2wBF40IWkDY0JT2a8lGC9y+7viLHGJRR/g2Nt/k1Wq249s5rni7OhqJWZZ9xYqt2hZ/9xAKseimYoMHkSR2D9DOmU+dlct6r3iTN3nGg6NzfLgDsnsoHD8oSgtSr61VsxDAUsWu+cwYzK/FlUX8rfLu+aJQG9jfRM0cNlB362V8sbX0OxJfJPQ9liwZduZl52cObFzv5IbfhoOK5nNb0H/BdaCAHL3qiMBcaORllLoyHmogvloawi74nyga/4wRxe1gAW56+v6+WgwCjxWvGrUr9W0+F93ooXO2q/SwcqryWTDy1Kv72qKkdd8XnrO4F3RPvvkfs5fpmAXwsWatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phtq812f53nxDqGzfPvO/fE+Krr00PLEXNHIGxi8Y00=;
 b=Al4iGSxi+htgjFfU4kwQBR+0Wk9wBeTuVlvz+ouMLYLuBPICSi055oka4MOeFbAo9uU4T+Yb9541TF4xP+4YEWD7HwJgcrbsqqR0nNMi5Tj9+3q5t3UHSZWZFmC9cUi//iGIiK1yLcoHy7V6zjX9h4McdN182ETddtPwS3sRwYkai/HGpfFPUkLXaeaEVkG5kI4Vzb94iVYLxsarbcnva16HdZQ9SNtfhL2P585mJOyzFxjMuYYp99YAWjxhDNPRE7Gb3LoVhUbv+BmmSgmqSMMYYM6+hYMnQR/UiFW0msvDYj6MtVh5nDUJlxZi9XuQyFgqX5PF3ODGeicTyMT2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phtq812f53nxDqGzfPvO/fE+Krr00PLEXNHIGxi8Y00=;
 b=Fb61LxzJ65Q/FGMBXzkjcvuf4Tee9bhh8/huPH95Hux1BhTOB5B0ZCqNcNKErC2UI94fabwFaHNQ9sdM4uRDlbey1+0r9S66jfKQhVmg4l26TaHPHgYCTv5kZsBvOERtM2fKidZvUfbpWbxd4ekuCmmqOPoy1xtJmakPDl7P15s=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 19:10:13 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 19:10:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 1/6] tools/mesh-cfgclient: Display unprovisioned
 OOB data
Thread-Topic: [PATCH BlueZ v2 1/6] tools/mesh-cfgclient: Display unprovisioned
 OOB data
Thread-Index: AQHWCA/bReDbx7aQ5k2PxeVgGRZTFKhkojYA
Date:   Wed, 1 Apr 2020 19:10:12 +0000
Message-ID: <c466664d9f69298e114bc48524d82cd25b679150.camel@intel.com>
References: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
         <20200401102502.746-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200401102502.746-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f6d4d64-271c-460f-4f5f-08d7d6704e18
x-ms-traffictypediagnostic: MW3PR11MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4572139B04ECE280349457E9E1C90@MW3PR11MB4572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(39860400002)(366004)(346002)(136003)(376002)(36756003)(5660300002)(186003)(66446008)(6506007)(86362001)(8676002)(107886003)(76116006)(64756008)(6486002)(66556008)(66476007)(66946007)(71200400001)(4326008)(478600001)(8936002)(110136005)(26005)(316002)(2906002)(2616005)(6512007)(81166006)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zS0PM/kvVjUYR4IjdUWz6bBRINHX+ijt0BQo7o0SEXK+pV93ctcGizAwVHseUKhsUWRm/AFzrWWwxfL+fMZ+PqK8xl+KrgcuSRW4Q7cv5OATpzZe7A99shJdagYJZ22QnOf+2+N5Mkbl6deOJdkr/jPtsmDGiIN8ljzFgeOkRCSeXX+WU+FylVTpmXVC1kJ/P+fPqyor4H1qpKpDehqsFJIdNb8thQXdz0z84Os+YmTnBVVKZgEv8hnlYruZVm2wlwK3I3B2bcArSEMh8JbAFpi2VUBrrtJ0kN+fwx2QfxtgYV8exrsWPYeYgayiuo0m2cVlFpETRZQqYypX2NVQnv41IzBixlZ94otZNLHmHObANadPNIvFKW/Wsz51ajE0G81KL8spCNqCEp5CTPbRiEV0tSd3cyIX1OkihZMVgDfvDkKZCTTLgSzOHTGTwXBM
x-ms-exchange-antispam-messagedata: 5R7J1zgObMK1nj2ZaH9LMYoi+uuzNYQMm4FJZ1MtwMGCx4cgUx3eMXZu5mjaD3yzd6DTqZqbcMnZpDFcJlbl5ncWPNV5tTEXKmm/yPl3adSjRjnQm2ohpLqPigyavJk/tKbS3W1+txtwltB2RPOzTw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DEC9EF2E54E5A4E8988F3927EFEFFB8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d4d64-271c-460f-4f5f-08d7d6704e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 19:10:12.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARnHI3IGmE2SxLFKghPOlq9dVHJxbTaYrFEeQnLQeJEi7IJv45BfPYdda4bRkmVd4/Rvq77EdnTrxf73dgf2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KVGhpcyBwYXRjaHNldCB3YXMgYXBwbGllZCB3aXRoIHNvbWUgc3R5bGUt
Z3VpZGUgZml4ZXMgKHBhdGNoZXMgNCBhbmQgNSkuICBQbGVhc2UgcmVtZW1iZXINCnRvIHJ1biBj
aGVja3BhdGNoIHByaW9yIHRvIHN1Ym1pdHRpbmcgcGF0Y2hlcy4NCg0KT24gV2VkLCAyMDIwLTA0
LTAxIGF0IDEyOjI0ICswMjAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gLS0t
DQo+ICB0b29scy9tZXNoLWNmZ2NsaWVudC5jIHwgMTMgKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNo
LWNmZ2NsaWVudC5jIGIvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiBpbmRleCBhZTEzYzQ0MDku
LjQzNTg4ODUyYiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiArKysg
Yi90b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+IEBAIC0xNTMzLDYgKzE1MzMsMTkgQEAgc3RhdGlj
IHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqc2Nhbl9yZXN1bHRfY2FsbChzdHJ1Y3QgbF9kYnVzICpk
YnVzLA0KPiAgCWJ0X3NoZWxsX3ByaW50ZigiXHQiIENPTE9SX0dSRUVOICJVVUlEID0gJXNcbiIg
Q09MT1JfT0ZGLCBzdHIpOw0KPiAgCWxfZnJlZShzdHIpOw0KPiAgDQo+ICsJaWYgKG4gPj0gMTgp
IHsNCj4gKwkJc3RyID0gbF91dGlsX2hleHN0cmluZ191cHBlcihwcm92X2RhdGEgKyAxNiwgMik7
DQo+ICsJCWJ0X3NoZWxsX3ByaW50ZigiXHQiIENPTE9SX0dSRUVOICJPT0IgPSAlc1xuIiBDT0xP
Ul9PRkYsIHN0cik7DQo+ICsJCWxfZnJlZShzdHIpOw0KPiArCX0NCj4gKw0KPiArCWlmIChuID49
IDIyKSB7DQo+ICsJCXN0ciA9IGxfdXRpbF9oZXhzdHJpbmdfdXBwZXIocHJvdl9kYXRhICsgMTgs
IDQpOw0KPiArCQlidF9zaGVsbF9wcmludGYoIlx0IiBDT0xPUl9HUkVFTiAiVVJJIEhhc2ggPSAl
c1xuIiBDT0xPUl9PRkYsDQo+ICsJCQkJCQkJCQlzdHIpOw0KPiArCQlsX2ZyZWUoc3RyKTsNCj4g
Kwl9DQo+ICsNCj4gIAkvKiBUT0RPOiBIYW5kbGUgdGhlIHJlc3Qgb2YgcHJvdmlzaW9uaW5nIGRh
dGEgaWYgcHJlc2VudCAqLw0KPiAgDQo+ICAJZGV2ID0gbF9xdWV1ZV9maW5kKGRldmljZXMsIG1h
dGNoX2RldmljZV91dWlkLCBwcm92X2RhdGEpOw0K
