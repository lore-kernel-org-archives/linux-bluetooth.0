Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C1C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31EB2082F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 23:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="udZyjgyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDHXE7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:04:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:43637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgDHXE6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 19:04:58 -0400
IronPort-SDR: WL40ReBaP4d0Pv6v9E4ddS3jScQzHQylRQJQ19WqDKxLveNkZG6hpDzrNOS0CqgFXB58s4aRND
 M8+ymOJ4UwUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 16:04:56 -0700
IronPort-SDR: pMwGyVcU/k1DEFEXwyo7FARTp7jtTc1KmowRzXK+6WbM+k6SfZUJNqmvHqoCHlEvWYYYKI4Fps
 g62JoyanzH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="275605452"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2020 16:04:56 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 16:04:56 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX114.amr.corp.intel.com (10.22.240.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 16:04:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 16:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUMu2RiBhip0nemlY7MIcch/XNaurjfzo+dfVhgR3AwUDyFhE34CHpcksvoIkISMZsTg9Q38gw3wcIT0n0mNy2LkvysMGISpB+vk/FVzWco2f4HO3JyDeKyxUOUcB6bq+n5tu4U8iEFCOUh/Nkk8fRKdZI0qjq/l2MErMWM/EOPDgHDaLSDqFmK1zi8GHAQreN027GbJVMotCGW55jB0PM87txA3K9vKmPWQmyDC/TCdO9ZoK+wzKISAn+LbbR8LfCnDGoO18Esfz3iE4bcLR1jPwVZlKS7uj+6r4Zt8KlFalQlQUgpBGKA1nb7OkTdy2QfRaW/ILK9QRwC9w3jeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz7yagNGVnjLouOPXeo8dUj/xG9vcQEW1/jit+mQ2hQ=;
 b=T8I6Rlzg8glo1oycFFugOw+0AdJ7gC289SqiFAhWx+QYiERF5frbzn3lfZ7ugs+ias+hjjbXT3Lziv5wdhlqIBX8GwSLNCerr9bHmZYz3j87Qx86JvteIx5E3y94xDapBM4uqyZfjqptnasq2tsDtr7qRQkPTfyMqtI9//K55kDC+0qQ//7PorG/EnYesE7M3c7wXnnkIxbULEjwhcCzneRRf+cDWbX6QgHKkivtXqex6lTKSpNym0J2g87XW57f+6MRacORUTFWMREW97dGsj2VadoVukSqJ2z2ovYctKcynHAmTXbQEo5s9V65R02743X43ZT/Thlejv39XkC6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz7yagNGVnjLouOPXeo8dUj/xG9vcQEW1/jit+mQ2hQ=;
 b=udZyjgyRPZVQFbgwaShtzybb33drU1TfVM53VSPbEIAvSv1hVC4D1ktNm+dql3Sikxav5nAY652Jwpwy0MLtxJVaaq1EiDtX2tivitKwM56PLzaRdw8gpsb1j0N+YTeQZkWK7HP4DfgFCt14Cc+hsCRZD3nMdLIbusdx4rQydOw=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1550.namprd11.prod.outlook.com (2603:10b6:301:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Wed, 8 Apr
 2020 23:04:54 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1%5]) with mapi id 15.20.2900.015; Wed, 8 Apr 2020
 23:04:54 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 2/4] doc/mesh: Change API to deliver tokens via
 JoinComplete
Thread-Topic: [PATCH BlueZ 2/4] doc/mesh: Change API to deliver tokens via
 JoinComplete
Thread-Index: AQHWDefN6p1sL9IzsUCqNwlPXTo1Sahv2GgA
Date:   Wed, 8 Apr 2020 23:04:53 +0000
Message-ID: <d558edc0826b1d5749513752989e7661c1f2d80f.camel@intel.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
         <20200408205255.45112-3-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200408205255.45112-3-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 031bcf43-31cf-46e5-1127-08d7dc113fdb
x-ms-traffictypediagnostic: MWHPR11MB1550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15504FA7578064D70CEC8781FBC00@MWHPR11MB1550.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(6506007)(6916009)(66446008)(76116006)(5660300002)(2906002)(6486002)(66946007)(4326008)(66476007)(36756003)(66556008)(6512007)(478600001)(54906003)(81156014)(316002)(8676002)(186003)(2616005)(81166007)(26005)(8936002)(86362001)(71200400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Bha9d2mGHro8IVmTWdRbgou+qBien0h76AeUmbVIM5XftbAobqUcN5/RrVc0nbNXC4IxjC8hblPFs+9HDlYEikDqkPTf0i0pI0E0xP7OXJ1sR4vmRpUBQ/02vRZVjBNkBE3crieDFHTAgNWUInp2oBWwamawF+qd2ivpRNgrNco2rA9Mz2fQAWpPgACbb/K1xRZJYmL1QkPUqloi0E89lISKjv724kf+uzTIAqT4HDB/z8cGRoNdor8c+2OIGEP+z8zoapxM7e/7e0yHRTU/wH2Cmvw4uPbu2pRPEm7/LGwTZaEJq8qHqnSFoYj2s7dxa4a4Z4PNmqMryJ/44G7b4TLLuJESZwQ5e3EYIugne+NpFrD4SItQTsItLlAwXC5fHNtVs8+lyF4qyLtSIcNu7nx07n8Dc8VAgfiNHtwv2IQE9Q1/T/PBJ3yqxRref3v
x-ms-exchange-antispam-messagedata: fmPEetQWRJzyJsijOIk3XlqFZotNoCP2RhASGxl2e+i1UnFYRQsgSDHfckeqVDOlaGvw8AcnD3lFQaqszi+F/PVZkAjJKIMy33WeD6s+lKULXOc0+tflgZ2au4JcC50QSotktXbdT8hqAMSzfr0Fow==
Content-Type: text/plain; charset="utf-8"
Content-ID: <118430ADB8831E498EC7F4AE9795CEAC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 031bcf43-31cf-46e5-1127-08d7dc113fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 23:04:53.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeDreG0hhlXlu+kopxLfhOji+K//UQAT8lqjA4n6ULnfBjayws4CupxQmdSgYaAFVm3ic0RZh7nx+uZnystYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1550
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBXZWQsIDIwMjAtMDQtMDggYXQgMjI6NTIgKzAyMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBJZiBBcHBsaWNhdGlvbiBpcyBub3QgYmUgYWJsZSB0
byByZWxpYWJseSBzdG9yZSB0aGUgdG9rZW4sIHRoZSBkYWVtb24NCj4gd2lsbCBlbmQgdXAgd2l0
aCBhIHVuY29udHJvbGxhYmxlIG5vZGUgaW4gaXRzIGRhdGFiYXNlLg0KPiANCj4gTGV0J3MgZml4
IHRoZSBpc3N1ZSBieSBhbHdheXMgZGVsaXZlcmluZyB0b2tlbnMgdXNpbmcgSm9pbkNvbXBsZXRl
IGNhbGwsDQo+IGFuZCBleHBlY3RpbmcgYSByZXBseSAtIGlmIHRoZSBhcHBsaWNhdGlvbiByZXR1
cm4gYW4gZXJyb3IsIGRhZW1vbiB3aWxsDQo+IGdldCByaWQgb2YgdGhlIG5vZGUuDQo+IC0tLQ0K
PiAgZG9jL21lc2gtYXBpLnR4dCB8IDIyICsrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RvYy9tZXNoLWFwaS50eHQgYi9kb2MvbWVzaC1hcGkudHh0DQo+IGluZGV4IGM3Mzc0
NzAzYi4uMDhlMzQwOTZkIDEwMDY0NA0KPiAtLS0gYS9kb2MvbWVzaC1hcGkudHh0DQo+ICsrKyBi
L2RvYy9tZXNoLWFwaS50eHQNCj4gQEAgLTI5LDYgKzI5LDEwIEBAIE1ldGhvZHM6DQo+ICAJCXRo
ZXJlZm9yZSBhdHRlbXB0aW5nIHRvIGNhbGwgdGhpcyBmdW5jdGlvbiB1c2luZyBhbHJlYWR5DQo+
ICAJCXJlZ2lzdGVyZWQgVVVJRCByZXN1bHRzIGluIGFuIGVycm9yLg0KPiAgDQo+ICsJCVdoZW4g
cHJvdmlzaW9uaW5nIGZpbmlzaGVzLCB0aGUgZGFlbW9uIHdpbGwgY2FsbCBlaXRoZXINCj4gKwkJ
Sm9pbkNvbXBsZXRlIG9yIEpvaW5GYWlsZWQgbWV0aG9kIG9uIG9iamVjdCBpbXBsZW1lbnRpbmcN
Cj4gKwkJb3JnLmJsdWV6Lm1lc2guQXBwbGljYXRpb24xIGludGVyZmFjZS4NCj4gKw0KPiAgCQlQ
b3NzaWJsZUVycm9yczoNCj4gIAkJCW9yZy5ibHVlei5tZXNoLkVycm9yLkludmFsaWRBcmd1bWVu
dHMNCj4gIAkJCW9yZy5ibHVlei5tZXNoLkVycm9yLkFscmVhZHlFeGlzdHMsDQo+IEBAIC0xMjMs
NyArMTI3LDcgQEAgTWV0aG9kczoNCj4gIAkJUG9zc2libGVFcnJvcnM6DQo+ICAJCQlvcmcuYmx1
ZXoubWVzaC5FcnJvci5JbnZhbGlkQXJndW1lbnRzDQo+ICANCj4gLQl1aW50NjQgdG9rZW4gQ3Jl
YXRlTmV0d29yayhvYmplY3QgYXBwX3Jvb3QsIGFycmF5e2J5dGV9WzE2XSB1dWlkKQ0KPiArCXZv
aWQgQ3JlYXRlTmV0d29yayhvYmplY3QgYXBwX3Jvb3QsIGFycmF5e2J5dGV9WzE2XSB1dWlkKQ0K
PiAgDQo+ICAJCVRoaXMgaXMgdGhlIGZpcnN0IG1ldGhvZCB0aGF0IGFuIGFwcGxpY2F0aW9uIGNh
bGxzIHRvIGJlY29tZQ0KPiAgCQlhIFByb3Zpc2lvbmVyIG5vZGUsIGFuZCBhIENvbmZpZ3VyYXRp
b24gQ2xpZW50IG9uIGEgbmV3bHkNCj4gQEAgLTE1NSwxMSArMTU5LDE0IEBAIE1ldGhvZHM6DQo+
ICAJCXVuaWNhc3QgYWRkcmVzcyAoMHgwMDAxKSwgYW5kIGNyZWF0ZSBhbmQgYXNzaWduIGEgbmV0
X2tleSBhcyB0aGUNCj4gIAkJcHJpbWFyeSBuZXR3b3JrIG5ldF9pbmRleCAoMHgwMDApLg0KPiAg
DQo+ICsJCVdoZW4gY3JlYXRpb24gZmluaXNoZXMsIHRoZSBkYWVtb24gd2lsbCBjYWxsIEpvaW5D
b21wbGV0ZSBtZXRob2QNCj4gKwkJb24gb2JqZWN0IGltcGxlbWVudGluZyBvcmcuYmx1ZXoubWVz
aC5BcHBsaWNhdGlvbjEgaW50ZXJmYWNlLg0KPiArDQo+ICAJCVBvc3NpYmxlRXJyb3JzOg0KPiAg
CQkJb3JnLmJsdWV6Lm1lc2guRXJyb3IuSW52YWxpZEFyZ3VtZW50cw0KPiAgCQkJb3JnLmJsdWV6
Lm1lc2guRXJyb3IuQWxyZWFkeUV4aXN0cywNCj4gIA0KPiAtCXVpbnQ2NCB0b2tlbiBJbXBvcnQo
b2JqZWN0IGFwcF9yb290LCBhcnJheXtieXRlfVsxNl0gdXVpZCwNCj4gKwl2b2lkIEltcG9ydChv
YmplY3QgYXBwX3Jvb3QsIGFycmF5e2J5dGV9WzE2XSB1dWlkLA0KDQpJIHdvdWxkIGxpa2UgdG8g
YmV0dGVyIHVuZGVyc3RhbmQgdGhlIHJhdGlvbmFsZSBiZWhpbmQgdGhpcyBBUEkgY2hhbmdlLg0K
DQpXaGF0IHNpdHVhdGlvbiBleGFjdGx5IGFyZSB3ZSB0cnlpbmcgdG8gYWRkcmVzcyBoZXJlOg0K
LSBhbiBhcHAgY2FsbGluZyBJbXBvcnROb2RlIG9yIENyZWF0ZSBtZXRob2RzIHdpdGhvdXQgdGhl
IGNhcGFjaXR5IHRvDQphY3R1YWxseSBzdG9yZSB0aGUgcmV0dXJuZWQgdG9rZW4/DQotIGFuIGFw
cCBjYWxsaW5nIEltcG9ydE5vZGUgb3IgQ3JlYXRlIG1ldGhvZHMgYW5kIGNyYXNoaW5nIGJlZm9y
ZQ0KcmVjZWl2aW5nL3N0b3JpbmcgdGhlIHRva2VuPw0KDQoNCj4gIAkJCQlhcnJheXtieXRlfVsx
Nl0gZGV2X2tleSwNCj4gIAkJCQlhcnJheXtieXRlfVsxNl0gbmV0X2tleSwgdWludDE2IG5ldF9p
bmRleCwNCj4gIAkJCQlkaWN0IGZsYWdzLCB1aW50MzIgaXZfaW5kZXgsIHVpbnQxNiB1bmljYXN0
KQ0KPiBAQCAtMjA0LDExICsyMTEsOCBAQCBNZXRob2RzOg0KPiAgCQlUaGUgdW5pY2FzdCBwYXJh
bWV0ZXIgaXMgdGhlIHByaW1hcnkgdW5pY2FzdCBhZGRyZXNzIG9mIHRoZQ0KPiAgCQlpbXBvcnRl
ZCBub2RlLg0KPiAgDQo+IC0JCVRoZSByZXR1cm5lZCB0b2tlbiBtdXN0IGJlIHByZXNlcnZlZCBi
eSB0aGUgYXBwbGljYXRpb24gaW4NCj4gLQkJb3JkZXIgdG8gYXV0aGVudGljYXRlIGl0c2VsZiB0
byB0aGUgbWVzaCBkYWVtb24gYW5kIGF0dGFjaCB0bw0KPiAtCQl0aGUgbmV0d29yayBhcyBhIG1l
c2ggbm9kZSBieSBjYWxsaW5nIEF0dGFjaCgpIG1ldGhvZCBvcg0KPiAtCQlwZXJtYW5lbnRseSBy
ZW1vdmUgdGhlIGlkZW50aXR5IG9mIHRoZSBtZXNoIG5vZGUgYnkgY2FsbGluZw0KPiAtCQlMZWF2
ZSgpIG1ldGhvZC4NCj4gKwkJV2hlbiBpbXBvcnQgZmluaXNoZXMsIHRoZSBkYWVtb24gd2lsbCBj
YWxsIEpvaW5Db21wbGV0ZSBtZXRob2QNCj4gKwkJb24gb2JqZWN0IGltcGxlbWVudGluZyBvcmcu
Ymx1ZXoubWVzaC5BcHBsaWNhdGlvbjEgaW50ZXJmYWNlLg0KPiAgDQo+ICAJCVBvc3NpYmxlRXJy
b3JzOg0KPiAgCQkJb3JnLmJsdWV6Lm1lc2guRXJyb3IuSW52YWxpZEFyZ3VtZW50cywNCj4gQEAg
LTc3MCw2ICs3NzQsMTAgQEAgTWV0aG9kczoNCj4gIAkJcGVybWFuZW50bHkgcmVtb3ZlIHRoZSBp
ZGVudGl0eSBvZiB0aGUgbWVzaCBub2RlIGJ5IGNhbGxpbmcNCj4gIAkJTGVhdmUoKSBtZXRob2Qu
DQo+ICANCj4gKwkJSWYgdGhpcyBtZXRob2QgcmV0dXJucyBhbiBlcnJvciwgdGhlIGRhZW1vbiB3
aWxsIGFzc3VtZSB0aGF0IHRoZQ0KPiArCQlhcHBsaWNhdGlvbiBmYWlsZWQgdG8gcHJlc2VydmUg
dGhlIHRva2VuLCBhbmQgd2lsbCByZW1vdmUgdGhlDQo+ICsJCWZyZXNobHkgY3JlYXRlZCBub2Rl
Lg0KPiArDQo+ICAJdm9pZCBKb2luRmFpbGVkKHN0cmluZyByZWFzb24pDQo+ICANCj4gIAkJVGhp
cyBtZXRob2QgaXMgY2FsbGVkIHdoZW4gdGhlIG5vZGUgcHJvdmlzaW9uaW5nIGluaXRpYXRlZCBi
eQ0K
