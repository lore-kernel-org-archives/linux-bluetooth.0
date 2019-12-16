Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC968C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE54206D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="I1/Lidea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfLPQ3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:29:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:44465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQ3M (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 11:29:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 08:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="205161660"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2019 08:29:11 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 08:29:10 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 08:29:10 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 08:29:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzETOU4vlepzwTpvELRmkbB8bIh0C0QCBLds5/qHzBvUEN1zlsOB8k5+5XQdBpjFbG2PU8l3ih2n6hw+bDRv1xV1siXvYvAXrqnbbLzVysKs7KrOcgBKvJPZjCGuQ1LbklcO2ghAZxKX30VOoFmpuzaoohUZeT9+vWyBBnQ4nPA07qwXpOVwLEnkQx+bWihqPIOEcScYTH4IBu6nnqWoZuCcK4VWOf4tC6EcaKwodIy9dKleLr8k+MBJ9fKQmL+yUbQVv2jAG6B63qnFV/CPADUzw1v83NZAdZ0t0dU5Y1JTDeoRIUKf8TfC6XeowA/vmj/GnNPngTfpgw1r/eVERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AinBjXRH3mSmKVJMRYfmZTnTCDMSEMRZz2iZVz3l1OU=;
 b=YSQQGB61yPNhZuML5WB34Ra3cgjGpB2QLdqd5EiF9CfUoDvLAMkigFhVtj1Gu7SbGvdAhGSXOf2nq/oZ57XC71ALCWo1QMHaTK+GdvUkV8F+GmSYcUmdURXlapRX2DJ5/Uth6Zw8giuKcZaxo6FeZkQ5qJMXtFMLapdkHh3vMB4Uh090LO3BTj0nPak/nLGe5oRZMQdh+XlIRFBZlXwTeC6BUDR63J28pxqExlPd9HPNVfGZEsLSfKIeoxuGaHD/GE1mpeN6i/8Jo1mM/5ZpNpfHtYe16wraPV0sfa5C1rqWbhzJrAZGtAvPmtx/RPAWN7puv6BEbP3nADRTo+tW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AinBjXRH3mSmKVJMRYfmZTnTCDMSEMRZz2iZVz3l1OU=;
 b=I1/LideayNXVCwHSTWSptP/0WL8/nXqdZ34T2AVVULkDa7fr2Glw4N6TyJ0uR4WoqH5GNrU/t/fOw360G2D3kVIkoc09SAVXES/pF4mPPNjYrvXyl50HszEokJJ3L6cFkdQmMUtfY54rhnpEN93aFiUdO3ny5CZcAjG1zBdCdkY=
Received: from BN6PR11MB1265.namprd11.prod.outlook.com (10.173.32.12) by
 BN6PR11MB1748.namprd11.prod.outlook.com (10.175.98.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 16:29:06 +0000
Received: from BN6PR11MB1265.namprd11.prod.outlook.com
 ([fe80::24f7:813e:ce6b:b8e0]) by BN6PR11MB1265.namprd11.prod.outlook.com
 ([fe80::24f7:813e:ce6b:b8e0%11]) with mapi id 15.20.2538.019; Mon, 16 Dec
 2019 16:29:06 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Cleanup unused LPN code
Thread-Topic: [PATCH BlueZ] mesh: Cleanup unused LPN code
Thread-Index: AQHVsfN5MMhafE7jwkixlCZGqT2Z8qe89/UA
Date:   Mon, 16 Dec 2019 16:29:05 +0000
Message-ID: <656ab3977303b949933989dc525de5d5218de38b.camel@intel.com>
References: <20191213202502.3504-1-brian.gix@intel.com>
In-Reply-To: <20191213202502.3504-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 680beda3-a28f-4290-cd6a-08d7824511e2
x-ms-traffictypediagnostic: BN6PR11MB1748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17483764CFFA79A00D9463BFE1510@BN6PR11MB1748.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(2906002)(4001150100001)(76116006)(478600001)(186003)(66946007)(6506007)(4326008)(6486002)(6916009)(8676002)(6512007)(2616005)(8936002)(71200400001)(81166006)(81156014)(5660300002)(86362001)(316002)(107886003)(64756008)(26005)(66446008)(66556008)(36756003)(66476007)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR11MB1748;H:BN6PR11MB1265.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64ne1VFLxjPgDBnoEvIVo7vGO+iqB0wXTLwUA3RSjbCOsiWvLcZckkMfcei2Ml7NzGU9o7KOx79hcNiv30acEFzyu4IxDR8e9+QlUASR9DE+pk8aMC4kEi0JQVG1ZIiqf8PQzIf0xxHJBR/J8tvaSUZyEz8LK32L/Rm54jiGzJNgMvfJO0E+QYT3dLMlbwB7LwyQR6wjV5BLnuUKaIV+bmr53DHAUw6MDsIIQDh6t2RJcCv5r50iDoKdzOvce6IW4qlxVdRKrP3oVZzOinI9evsapKljsJa+DFrRhS40UJYDyDdE3O1v+qbsq73L9yGn9iKIKDGGokl4XaTVdu3TczFFLvkzySSyi0nRBL33U0cvPmtKXctJmfmlXjah4l+wobFlisl4rZr2nEWiUR3GUK1dIFkWqUfO/zbnyiZE9Q70YeUrbZ+TWWCk+JuTROa1
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDED165C6FC79047B0961A2FA9D8BEC1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 680beda3-a28f-4290-cd6a-08d7824511e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 16:29:05.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKCc8ciV/ek2oTOFnJa9ShDHjXXOMwRASjrY0nJZc9v6PGB3KU7+0ge0CU5tLtZmse+YUbRZVJvxZoH9JFzLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1748
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMTItMTMgYXQgMTI6MjUgLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gVGhlIGRhZW1vbiBkb2VzIG5vdCBzdXBwb3J0IHRoZSBMUE4gcm9sZSwgYW5kIHRo
aXMgaXMgdW5yZWZlcmVuY2VkIGNvZGUuDQo+IC0tLQ0KPiAgbWVzaC9uZXQuYyB8IDU2ICsrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVz
aC9uZXQuaCB8ICAyIC0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNTAg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMN
Cj4gaW5kZXggZTcwOGIyYWE0Li4wNDg1MDg2YmMgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMN
Cj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAtMTE4LDcgKzExOCw2IEBAIHN0cnVjdCBtZXNoX25l
dCB7DQo+ICAJdWludDMyX3Qgc2VxX251bTsNCj4gIAl1aW50MTZfdCBzcmNfYWRkcjsNCj4gIAl1
aW50MTZfdCBsYXN0X2FkZHI7DQo+IC0JdWludDE2X3QgZnJpZW5kX2FkZHI7DQo+ICAJdWludDE2
X3QgdHhfaW50ZXJ2YWw7DQo+ICAJdWludDE2X3QgdHhfY250Ow0KPiAgCXVpbnQ4X3QgY2hhbjsg
LyogQ2hhbm5lbCBvZiByZWNlbnQgUnggKi8NCj4gQEAgLTE1NTAsMTAgKzE1NDksNiBAQCBzdGF0
aWMgdm9pZCBzZW5kX25ldF9hY2soc3RydWN0IG1lc2hfbmV0ICpuZXQsIHN0cnVjdCBtZXNoX3Nh
ciAqc2FyLA0KPiAgCWlmIChzcmMgJiAweDgwMDApDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCS8q
IFdlIGRvbid0IEFDSyBzZWdtZW50cyBhcyBhIExvdyBQb3dlciBOb2RlICovDQo+IC0JaWYgKG5l
dC0+ZnJpZW5kX2FkZHIpDQo+IC0JCXJldHVybjsNCj4gLQ0KPiAgCWhkciA9IE5FVF9PUF9TRUdf
QUNLTk9XTEVER0UgPDwgT1BDT0RFX0hEUl9TSElGVDsNCj4gIAloZHIgfD0gc2FyLT5zZXFaZXJv
IDw8IFNFUV9aRVJPX0hEUl9TSElGVDsNCj4gIA0KPiBAQCAtMTk0Nyw4ICsxOTQyLDcgQEAgc3Rh
dGljIGJvb2wgc2VnX3J4ZWQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIGJvb2wgZnJuZCwgdWludDMy
X3QgaXZfaW5kZXgsDQo+ICANCj4gIAkJaWYgKHNhcl9pbi0+ZmxhZ3MgPT0gZXhwZWN0ZWQpIHsN
Cj4gIAkJCS8qIFJlLVNlbmQgQUNLIGZvciBmdWxsIG1zZyAqLw0KPiAtCQkJaWYgKCFuZXQtPmZy
aWVuZF9hZGRyKQ0KPiAtCQkJCXNlbmRfbmV0X2FjayhuZXQsIHNhcl9pbiwgZXhwZWN0ZWQpOw0K
PiArCQkJc2VuZF9uZXRfYWNrKG5ldCwgc2FyX2luLCBleHBlY3RlZCk7DQo+ICAJCQlyZXR1cm4g
dHJ1ZTsNCj4gIAkJfQ0KPiAgCX0gZWxzZSB7DQo+IEBAIC0xOTY2LDggKzE5NjAsNyBAQCBzdGF0
aWMgYm9vbCBzZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgYm9vbCBmcm5kLCB1aW50MzJf
dCBpdl9pbmRleCwNCj4gIAkJc2FyX2luLT5rZXlfYWlkID0ga2V5X2FpZDsNCj4gIAkJc2FyX2lu
LT5sZW4gPSBsZW47DQo+ICAJCXNhcl9pbi0+bGFzdF9zZWcgPSAweGZmOw0KPiAtCQlpZiAoIW5l
dC0+ZnJpZW5kX2FkZHIpDQo+IC0JCQlzYXJfaW4tPm1zZ190aW1lb3V0ID0gbF90aW1lb3V0X2Ny
ZWF0ZShNU0dfVE8sDQo+ICsJCXNhcl9pbi0+bXNnX3RpbWVvdXQgPSBsX3RpbWVvdXRfY3JlYXRl
KE1TR19UTywNCj4gIAkJCQkJaW5tc2dfdG8sIG5ldCwgTlVMTCk7DQo+ICANCj4gIAkJbF9kZWJ1
ZygiRmlyc3QgU2VnICU0LjR4Iiwgc2FyX2luLT5mbGFncyk7DQo+IEBAIC0xOTk0LDggKzE5ODcs
NyBAQCBzdGF0aWMgYm9vbCBzZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgYm9vbCBmcm5k
LCB1aW50MzJfdCBpdl9pbmRleCwNCj4gIA0KPiAgCWlmIChzYXJfaW4tPmZsYWdzID09IGV4cGVj
dGVkKSB7DQo+ICAJCS8qIEdvdCBpdCBhbGwgKi8NCj4gLQkJaWYgKCFuZXQtPmZyaWVuZF9hZGRy
KQ0KPiAtCQkJc2VuZF9uZXRfYWNrKG5ldCwgc2FyX2luLCBleHBlY3RlZCk7DQo+ICsJCXNlbmRf
bmV0X2FjayhuZXQsIHNhcl9pbiwgZXhwZWN0ZWQpOw0KPiAgDQo+ICAJCW1zZ19yeGVkKG5ldCwg
ZnJuZCwgaXZfaW5kZXgsIHR0bCwgc2VxLCBuZXRfaWR4LA0KPiAgCQkJCXNhcl9pbi0+cmVtb3Rl
LCBkc3QsDQo+IEBAIC0yMDE0LDE1ICsyMDA2LDEyIEBAIHN0YXRpYyBib29sIHNlZ19yeGVkKHN0
cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIGZybmQsIHVpbnQzMl90IGl2X2luZGV4LA0KPiAgCQls
X3RpbWVvdXRfcmVtb3ZlKHNhcl9pbi0+c2VnX3RpbWVvdXQpOw0KPiAgDQo+ICAJCS8qIGlmIHRo
aXMgaXMgdGhlIGxhcmdlc3Qgb3V0c3RhbmRpbmcgc2VnbWVudCwgc2VuZCBOQUsgbm93ICovDQo+
IC0JCWlmICghbmV0LT5mcmllbmRfYWRkcikgew0KPiAtCQkJbGFyZ2VzdCA9ICgweGZmZmZmZmZm
IDw8IHNlZ08pICYgZXhwZWN0ZWQ7DQo+IC0JCQlpZiAoKGxhcmdlc3QgJiBzYXJfaW4tPmZsYWdz
KSA9PSBsYXJnZXN0KQ0KPiAtCQkJCXNlbmRfbmV0X2FjayhuZXQsIHNhcl9pbiwgc2FyX2luLT5m
bGFncyk7DQo+ICsJCWxhcmdlc3QgPSAoMHhmZmZmZmZmZiA8PCBzZWdPKSAmIGV4cGVjdGVkOw0K
PiArCQlpZiAoKGxhcmdlc3QgJiBzYXJfaW4tPmZsYWdzKSA9PSBsYXJnZXN0KQ0KPiArCQkJc2Vu
ZF9uZXRfYWNrKG5ldCwgc2FyX2luLCBzYXJfaW4tPmZsYWdzKTsNCj4gIA0KPiAtCQkJc2FyX2lu
LT5zZWdfdGltZW91dCA9IGxfdGltZW91dF9jcmVhdGUoU0VHX1RPLA0KPiArCQlzYXJfaW4tPnNl
Z190aW1lb3V0ID0gbF90aW1lb3V0X2NyZWF0ZShTRUdfVE8sDQo+ICAJCQkJaW5zZWdfdG8sIG5l
dCwgTlVMTCk7DQo+IC0JCX0gZWxzZQ0KPiAtCQkJbGFyZ2VzdCA9IDA7DQo+ICAJfSBlbHNlDQo+
ICAJCWxhcmdlc3QgPSAwOw0KPiAgDQo+IEBAIC0yNzUyLDcgKzI3NDEsNyBAQCBzdGF0aWMgdm9p
ZCBiZWFjb25fcmVjdih2b2lkICp1c2VyX2RhdGEsIHN0cnVjdCBtZXNoX2lvX3JlY3ZfaW5mbyAq
aW5mbywNCj4gIA0KPiAgYm9vbCBtZXNoX25ldF9zZXRfYmVhY29uX21vZGUoc3RydWN0IG1lc2hf
bmV0ICpuZXQsIGJvb2wgZW5hYmxlKQ0KPiAgew0KPiAtCWlmICghbmV0IHx8ICFJU19VTkFTU0lH
TkVEKG5ldC0+ZnJpZW5kX2FkZHIpKQ0KPiArCWlmICghbmV0KQ0KPiAgCQlyZXR1cm4gZmFsc2U7
DQo+ICANCj4gIAlpZiAobmV0LT5iZWFjb25fZW5hYmxlID09IGVuYWJsZSkNCj4gQEAgLTI5MjQs
MzMgKzI5MTMsNiBAQCB2b2lkIG1lc2hfbmV0X3N1Yl9saXN0X2RlbChzdHJ1Y3QgbWVzaF9uZXQg
Km5ldCwgdWludDE2X3QgYWRkcikNCj4gIAkJCTAsIDAsIDAsIG1zZywgbik7DQo+ICB9DQo+ICAN
Cj4gLS8qIFRPRE86IGNoYW5nZSB0byB1c2UgbmV0IGluZGV4ICovDQo+IC1ib29sIG1lc2hfbmV0
X3NldF9mcmllbmQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGZyaWVuZF9hZGRyKQ0K
PiAtew0KPiAtCWlmICghbmV0KQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gLQluZXQtPmJl
YV9pZCA9IDA7DQo+IC0NCj4gLQlsX2luZm8oIlNldCBGcm5kIGFkZHI6ICU0LjR4IiwgZnJpZW5k
X2FkZHIpOw0KPiAtCWlmICghZnJpZW5kX2FkZHIpDQo+IC0JCXRyaWdnZXJfaGVhcnRiZWF0KG5l
dCwgRkVBVFVSRV9MUE4sIGZhbHNlKTsNCj4gLQllbHNlDQo+IC0JCXRyaWdnZXJfaGVhcnRiZWF0
KG5ldCwgRkVBVFVSRV9MUE4sIHRydWUpOw0KPiAtDQo+IC0JbmV0LT5mcmllbmRfYWRkciA9IGZy
aWVuZF9hZGRyOw0KPiAtDQo+IC0JcmV0dXJuIHRydWU7DQo+IC19DQo+IC0NCj4gLXVpbnQxNl90
IG1lc2hfbmV0X2dldF9mcmllbmQoc3RydWN0IG1lc2hfbmV0ICpuZXQpDQo+IC17DQo+IC0JaWYg
KCFuZXQpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JcmV0dXJuIG5ldC0+ZnJpZW5kX2FkZHI7
DQo+IC19DQo+IC0NCj4gIGJvb2wgbWVzaF9uZXRfZHN0X3JlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5l
dCwgdWludDE2X3QgZHN0KQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX2Rlc3RpbmF0aW9uICpkZXN0
ID0gbF9xdWV1ZV9maW5kKG5ldC0+ZGVzdGluYXRpb25zLA0KPiBAQCAtMzQ5Myw4ICszNDU1LDYg
QEAgdWludDE2X3QgbWVzaF9uZXRfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBtZXNoX25ldCAqbmV0KQ0K
PiAgCQlmZWF0dXJlcyB8PSBGRUFUVVJFX1BST1hZOw0KPiAgCWlmIChuZXQtPmZyaWVuZF9lbmFi
bGUpDQo+ICAJCWZlYXR1cmVzIHw9IEZFQVRVUkVfRlJJRU5EOw0KPiAtCWlmIChuZXQtPmZyaWVu
ZF9hZGRyICE9IFVOQVNTSUdORURfQUREUkVTUykNCj4gLQkJZmVhdHVyZXMgfD0gRkVBVFVSRV9M
UE47DQo+ICANCj4gIAlyZXR1cm4gZmVhdHVyZXM7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9tZXNo
L25ldC5oIGIvbWVzaC9uZXQuaA0KPiBpbmRleCA5MGNhODMyOGIuLjA3Yjg3ODMwZCAxMDA2NDQN
Cj4gLS0tIGEvbWVzaC9uZXQuaA0KPiArKysgYi9tZXNoL25ldC5oDQo+IEBAIC0yNzksOCArMjc5
LDYgQEAgdm9pZCBtZXNoX25ldF9zZXRfZnJuZF9zZXEoc3RydWN0IG1lc2hfbmV0ICpuZXQsIGJv
b2wgc2VxKTsNCj4gIHVpbnQxNl90IG1lc2hfbmV0X2dldF9hZGRyZXNzKHN0cnVjdCBtZXNoX25l
dCAqbmV0KTsNCj4gIGJvb2wgbWVzaF9uZXRfcmVnaXN0ZXJfdW5pY2FzdChzdHJ1Y3QgbWVzaF9u
ZXQgKm5ldCwNCj4gIAkJCQkJdWludDE2X3QgdW5pY2FzdCwgdWludDhfdCBudW1fZWxlKTsNCj4g
LWJvb2wgbWVzaF9uZXRfc2V0X2ZyaWVuZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3Qg
ZnJpZW5kX2FkZHIpOw0KPiAtdWludDE2X3QgbWVzaF9uZXRfZ2V0X2ZyaWVuZChzdHJ1Y3QgbWVz
aF9uZXQgKm5ldCk7DQo+ICB1aW50OF90IG1lc2hfbmV0X2dldF9udW1fZWxlKHN0cnVjdCBtZXNo
X25ldCAqbmV0KTsNCj4gIGJvb2wgbWVzaF9uZXRfc2V0X2JlYWNvbl9tb2RlKHN0cnVjdCBtZXNo
X25ldCAqbmV0LCBib29sIGVuYWJsZSk7DQo+ICBib29sIG1lc2hfbmV0X3NldF9wcm94eV9tb2Rl
KHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIGVuYWJsZSk7DQo=
