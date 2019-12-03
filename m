Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF5FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46DD20409
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IpHUUHAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLCSuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:50:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:20139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfLCSuW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 13:50:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 10:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="213531172"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2019 10:50:21 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 10:50:20 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 10:50:20 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Dec 2019 10:50:20 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 3 Dec 2019 10:50:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1nguXxLGf+KiwCnFwS4XdLIKFQAAOCT1shOT9sHLFlUWx6V+oGHFkRxHRL1xwQHndvRsvGdu6JqPMTcII5TqExg3Q6q18ll70/3/9HJe8qIYldmEn6FsBLxJj1LcPJARkqXl9bzqiyNVRLW6JtHN5kJT1u2zeLy7O1ew5OwqDMLuDZU6G90AIa61WpqqvvwsTymhmwbqByA+Pe0vUS1vFcawij1YGXUmGXqIRi3wYlBWaRUJRjaWRGvBixsSoWEZEGu7ID15l3PE8CRDaAC6kzglq6q7iLwop0wPfaM274LFNp1gBBKPJZOnHkYMgUM3QownoXUlhnWSbS8ZiVXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2rNfuK3UKbTVEqHE6Xep+8cBNspfOHD6O0W5joMWBk=;
 b=fc6JU1iX5qlcQ2jPpDM0hvZ0GGWU/7QCbqoPPgXFqX/nUjCxpaDAd/733cKoodpN25cb+I5E2PUqVZTAG5JN44a/cLpx9YERPl6Vm76ZULuvj/676oJPp9JRc/U5x9BZ94NQxzfpbB1pImrjZyV4c6mPmYKpFCsGoURgzivfariPoz3Y6UM25tgJMxyv0A4MKmAZshQDFd6VQkfu4hNpTNVYzn8Qkyr9ylFeATR3NwOk8c5W3wjpaDnSrR41oUQx4l+aSw2Hry3JNMBfuXPLlKpQu+7ILu0lU+cVS+m1mWWXvU7cCjQKvXyeRv4JD5aaR7qBfXjdNoeHannofvjrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2rNfuK3UKbTVEqHE6Xep+8cBNspfOHD6O0W5joMWBk=;
 b=IpHUUHAziwaPnHUnYWrHmvdHhJzEkOqQwMZUgRahmNI0qlGXA1igzbJ709hj2ZQvPo8OJYI0tMPQYgeFlwrVez6Btv8xyPzRdg942lCgA+SZrXaTunBsUGh0JANVKO3mqp1QF3bgdBSSjdBhCDkLEVdncSqEW7oKRLyoYO/yhAU=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1368.namprd11.prod.outlook.com (10.173.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 18:49:59 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 18:49:59 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] mesh: Fix string of public-oob and static-oob
Thread-Topic: [PATCH 1/1] mesh: Fix string of public-oob and static-oob
Thread-Index: AQHVqcDK7lEP/clTbUeq6GuZPiWn5KeowWoA
Date:   Tue, 3 Dec 2019 18:49:59 +0000
Message-ID: <4edddf7f571f90c0ea8b0cb072dea166690d470e.camel@intel.com>
References: <CGME20191203100133epcas5p1bf4b021f6cabcba3b5ff67965ccfec56@epcas5p1.samsung.com>
         <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66c510bf-708d-4082-eefc-08d778219942
x-ms-traffictypediagnostic: CY4PR11MB1368:
x-microsoft-antispam-prvs: <CY4PR11MB1368A885ED2A2D3819CA8F4EE1420@CY4PR11MB1368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(71190400001)(229853002)(6486002)(110136005)(102836004)(14454004)(478600001)(2906002)(6512007)(7736002)(86362001)(66476007)(66556008)(64756008)(26005)(256004)(71200400001)(66446008)(76176011)(11346002)(25786009)(186003)(6436002)(3846002)(118296001)(6116002)(4744005)(6506007)(6246003)(305945005)(91956017)(446003)(76116006)(2616005)(8936002)(81156014)(316002)(8676002)(5660300002)(36756003)(2501003)(66946007)(81166006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1368;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvq59gocYmKoCvYRVyvk9u2JxhiWCmSVfUL/CnDaWiDsM3hMwYBPS1krLi+cegirD6D2GjbPvW5PYY0Ds3KXWD4q4LxLJpWb2bz5T0CaR/c3qCnppOI2/AQq2TxIbyKCuU3BVYj+gB8IjEgEucjbioVqYyh8xWGiYSTbR+Citgz5kds8nn8MMWXD2ee4i/z6Y1SSxRZ8JW3qsRpfBJ9vWw3Z55ZONMvT/qGJZm1uiQjwMKHwSWj5P0ncmuucQk0MVTrXcDjW8sDHfofI9uAeSiLBfh/zmn9o2WkptxSlScXPmMyRXT0NkjAFcgnodEpMjsPsAZrZCLdOJBf3ooWjjIYGb4ZLpI+E6RjZndQ7JDxQop27plH/R1YKTUaYqo88idwc2wF7xR5QrqY13n+Aqg13p9zKkPU38YF/kwr42B8gAMar8gun1hYgw/ZF71sC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C22602FB025CEC4B94A306D38423CD08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c510bf-708d-4082-eefc-08d778219942
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 18:49:59.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q61fCiEbB90tcGgjy99ALnNC4tRcwGx2BYAAu1YQZ+NYgPpZYI2kKkF9CMJvsqS+qyUVo9CZYevZbi36DtDhGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1368
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMDMgYXQgMTU6MzEgKzA1MzAsIFByYXRoeXVzaGEg
TmVsbHVyaSB3cm90ZToNCj4gRnJvbTogUHJhdGh5dXNoYSBOIDxwcmF0aHl1c2hhLm5Ac2Ftc3Vu
Zy5jb20+DQo+IA0KPiBGaXggc3RyaW5nIHR5cG8gYXMgcGVyIG1lc2gtYXBpLnR4dA0KPiAtLS0N
Cj4gIG1lc2gvYWdlbnQuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL2FnZW50LmMgYi9t
ZXNoL2FnZW50LmMNCj4gaW5kZXggNWE1NTcwYS4uOWY5Mzk5ZiAxMDA2NDQNCj4gLS0tIGEvbWVz
aC9hZ2VudC5jDQo+ICsrKyBiL21lc2gvYWdlbnQuYw0KPiBAQCAtMTMxLDkgKzEzMSw5IEBAIHN0
YXRpYyB2b2lkIHBhcnNlX3Byb3ZfY2FwcyhzdHJ1Y3QgbWVzaF9hZ2VudF9wcm92X2NhcHMgKmNh
cHMsDQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgDQo+IC0JCWlmICghc3RyY21wKHN0ciwgIlB1
YmxpY09PQiIpKQ0KPiArCQlpZiAoIXN0cmNtcChzdHIsICJwdWJsaWMtb29iIikpDQo+ICAJCQlj
YXBzLT5wdWJfdHlwZSA9IDE7DQo+IC0JCWVsc2UgaWYgKCFzdHJjbXAoc3RyLCAiU3RhdGljT09C
IikpDQo+ICsJCWVsc2UgaWYgKCFzdHJjbXAoc3RyLCAic3RhdGljLW9vYiIpKQ0KPiAgCQkJY2Fw
cy0+c3RhdGljX3R5cGUgPSAxOw0KPiAgCX0NCj4gIA0K
