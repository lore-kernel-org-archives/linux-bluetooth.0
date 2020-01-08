Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A70C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4302206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Rxy31t+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAHWFG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:05:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:58348 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHWFG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 17:05:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 14:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="223673560"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 14:05:05 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 14:05:04 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 14:05:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 14:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP5MUyYVb13OPFae+8jLqQ5M+N67IJ2RP0G+fUjdDdGGRMGtP+zbL8bEUlDaiFI6OhTa/VuFqEIxHT8r35NDijitVyBe2TWv0KC5VTzGm+lfCWCAgHy8fdTDci3jI96yd6J7ArbfofUA5Xs3CfBljsXTfqhGA7eLRSUCgIMeH4/9IwP3lUHlx0UBNx+RdxWg3FMNXnXTkr6G40I/mCTArUpZcMW7fTB6uCTihFH4eSGNOS8VQLa9Qg9gXZdBhlHEJ4mgxsNM86VJ26PruH7YEi5qMzbCFPRtwySJdWapUCcgSmPP+m+1ijlxgGd3p9J+aJRS8J7i3UhKxL0IK/5XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNLgJ+GC0HaLIaX7XiGR/PMPMn4uVLu57Fn7f6mwMvE=;
 b=kRisEUpAacpnCnYZeRCqgorh1E4A+HzS0hGIP37VmG3m6gOVZWEgp+yEbpTLBcsRXMTM9RGz1V2NF9tmCEXSnOYN/u9RfnGf08FTFF5G4fTZaivTrZVWMLxW5A4t6fe90Kp+5qEy0f4RIxrkslsHqifTi24Q9RqmVO9vVbsjwcRQRX5Wejsm8RIEIqXK9KlcIRQnExEmmDg/O4wuqhHFP40M+8muZFUjyWMy0komzd6ed85N3uEGUxKH2o8wBFP8zQL/zIQ2wxdqmwa/TKoZYr9zDdOO6vUSt0Lj3EwPPGif5WofcDbWOwlUhOqA+Ovo911RL6j80N2RlevdFqnUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNLgJ+GC0HaLIaX7XiGR/PMPMn4uVLu57Fn7f6mwMvE=;
 b=Rxy31t+sm5jstqk6kZ7FSz1VIRBU8e4Lz7aCnTM6ICxs4YU3iTGL6Z5Rn/GRYWPhOA8yYX+YLiM9/7c8NT93S/fdzQkwV6Fbmw23iLnk23LLB4cV2yV+o8jDZ7rEuB+CY4PvZybs9Gi5ytn01bgvxWCNAocJgPmyUb1cQb0Fc8o=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1253.namprd11.prod.outlook.com (10.173.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Wed, 8 Jan 2020 22:05:03 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 22:05:03 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix BeaconFlags property type
Thread-Topic: [PATCH BlueZ] mesh: Fix BeaconFlags property type
Thread-Index: AQHVxm3fXiJ6CfxSKUGJIcQFCgYjY6fhUn0A
Date:   Wed, 8 Jan 2020 22:05:03 +0000
Message-ID: <83b940e3521b4b681f5ebc5a5d5de717c9da2bd5.camel@intel.com>
References: <20200108215114.10555-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200108215114.10555-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2fd50d-32c7-46d5-847e-08d79486d012
x-ms-traffictypediagnostic: CY4PR11MB1253:
x-microsoft-antispam-prvs: <CY4PR11MB125354CF47133CAAA8EEFA57E13E0@CY4PR11MB1253.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(2616005)(4744005)(8676002)(81166006)(81156014)(6506007)(36756003)(5660300002)(6512007)(186003)(71200400001)(26005)(8936002)(86362001)(76116006)(66476007)(91956017)(66446008)(478600001)(66946007)(6486002)(66556008)(316002)(64756008)(2906002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1253;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j70SUMaj82fk8rPqCRdowi3wjGNDzdkSEpTwSg2t+wp/0pQQ7roMH55R4dPMiOIa7UDR02PWWlvzI9+Iv8VMYG0ae7dM6WdXKZYtPHMOSbwVJZV9HVOuIQXVTdEB48Z7Ggw5p5BjoAuNHjrz81Wf89KMziri5Bt7/DVaq6T3ivxHdrr/XVKDjJXGDIHXrEUbsiqkC9Hpsqq3ptJ/K6dahSqTvFqnHU2jSp6UhSManfho+fD5UQxmfuugCDRwKRQP0jySy6XhYB9st2STD8M2L08HqHFeKgTxKOejhourLXHqzb6WRLK9JLnTE5mzkkwURuM6b6Zp0dhb0OOQY/7eHlA81RdkgVaGHATuK63W21Uw76ZuWZ//xWFP8oL+/Q9AJZJ2zcoBZuyFnCQ/1b3eYdnG5kRJSKftiq+Th3nlKzEVjFlAKNpKKqdczzbGzIgg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6782D8F474EC0947823A110183256208@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2fd50d-32c7-46d5-847e-08d79486d012
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 22:05:03.2937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjjnaxxNs3RIC0XE7qJFue/X/fX5mbPnH2KtUDnD/mYdBE3jUDu0X/iybqTcoY9cqQuk5JLpuBZHHPcrx/6z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1253
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDIyOjUxICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBwcm9wZXJ0eSBpcyBhbiB1aW50OCwgbm90IGEgYm9v
bGVhbi4NCj4gDQo+IC0tLQ0KPiAgbWVzaC9ub2RlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNo
L25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDAzMjIxNjc3NC4uMTNkNGQzNDE4IDEwMDY0
NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtMjM1OCw3
ICsyMzU4LDcgQEAgc3RhdGljIHZvaWQgc2V0dXBfbm9kZV9pbnRlcmZhY2Uoc3RydWN0IGxfZGJ1
c19pbnRlcmZhY2UgKmlmYWNlKQ0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfcHJvcGVydHkoaWZhY2Us
ICJGZWF0dXJlcyIsIDAsICJhe3N2fSIsIGZlYXR1cmVzX2dldHRlciwNCj4gIAkJCQkJCQkJCU5V
TEwpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfcHJvcGVydHkoaWZhY2UsICJCZWFjb24iLCAwLCAi
YiIsIGJlYWNvbl9nZXR0ZXIsIE5VTEwpOw0KPiAtCWxfZGJ1c19pbnRlcmZhY2VfcHJvcGVydHko
aWZhY2UsICJCZWFjb25GbGFncyIsIDAsICJiIiwNCj4gKwlsX2RidXNfaW50ZXJmYWNlX3Byb3Bl
cnR5KGlmYWNlLCAiQmVhY29uRmxhZ3MiLCAwLCAieSIsDQo+ICAJCQkJCQliZWFjb25mbGFnc19n
ZXR0ZXIsIE5VTEwpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfcHJvcGVydHkoaWZhY2UsICJJdklu
ZGV4IiwgMCwgInUiLCBpdmluZGV4X2dldHRlciwNCj4gIAkJCQkJCQkJCU5VTEwpOw0K
