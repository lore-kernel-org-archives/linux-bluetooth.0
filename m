Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F2C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E000420828
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="guFKEyzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLJR5C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:57:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:1666 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJR5C (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 12:57:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 09:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="225228193"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2019 09:56:59 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 09:56:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 10 Dec 2019 09:56:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU2rk3pM1mlfj2MIXHq9XifkNKm5fAjsI2AYdrgLvKYEcWMGLV8xW3qR8HV4XRZHqUYW2Z1ePacxrYfovjyH86Ko4jvHHlRPR8gZeM8i+RsjUgTf5sEGHmPSWzUr+0G2WfcIJefFPRkchPwrkGTrnK+5WPY69gMiQuMq1HBpcpHnRDwkQKzI9WzsQbt/6ok9ORALM75olYA5vv2NhyFLGEvdxVDF2Zi37jF253fBxoE3WyqDVc7XpVtRcwI4iTH7po/fOzMPvlMqv02ok8OSYkq3whEt5eyZg2u/qWBo3IPWeckvetgwt11rw+PUHa8xkf/KNVKouOS5OLa6zDxUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvQ+DcZuGSX815soawOzu3lK/qjT7ogk8rK+OOwrb+o=;
 b=CB7KThk46iCNfFb70Sd0pUkPIQuixt9DaEU9f235s0md/0c3ELME9WmgLMonGuVxd7Hi6OIotNL9ey+YNQLzWnqZe/QDZsj+SDqJuvJZYbTSGxZ+8qLeKUQVMiEyK2YgZthUsqSjddtgj12fierBPBydiI7lTTkQuqfC/P8VrbL43wOHP/9SQKPckjd8RvwPdJefBEoRC9SYlJ1Bsbe0UxWclHpPpR2K2tE0TDbWHyDOwIKxAlcvSTpcp5+FDDMzooFSB7Jnnl/NxWuL1QCL7kfwgnveyr6MHLCTM0CVf97rZqKq+TOZWQB806ZJoRKWjVMvhcfqU7iqgP6+xljd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvQ+DcZuGSX815soawOzu3lK/qjT7ogk8rK+OOwrb+o=;
 b=guFKEyzzDlpGzjKS5HebJWlGU9BVDPDWrSv/yDbiLBpSKcjEOK2CxkuL5Z6YRFYS3LjiXvZt698zeInK2ENlWIWh/WKztwFPKyQ3zz9+f3+1bMK0pg06Na7OeM0maLUlfGPP8Bnbxf+deBZ0E5is12iPqeu/QegTuOiMgmp5GXc=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1527.namprd11.prod.outlook.com (10.172.70.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 17:56:57 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:56:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] tools/mesh-cfgclient: Fix appkey/netkey commands
Thread-Topic: [PATCH BlueZ v2] tools/mesh-cfgclient: Fix appkey/netkey
 commands
Thread-Index: AQHVr4GugxZBhs2fJEusMdpQhhtBZaezp2gA
Date:   Tue, 10 Dec 2019 17:56:57 +0000
Message-ID: <4aec86b307223738973afefc3f187f4ebd2c9517.camel@intel.com>
References: <20191210174522.14155-1-inga.stotland@intel.com>
In-Reply-To: <20191210174522.14155-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a291fd80-7510-4a11-7bc6-08d77d9a5983
x-ms-traffictypediagnostic: CY4PR11MB1527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB15275640FF232D2FBA842778E15B0@CY4PR11MB1527.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(64756008)(66476007)(6486002)(66556008)(86362001)(5660300002)(76116006)(66446008)(498600001)(81166006)(71200400001)(8676002)(91956017)(2906002)(81156014)(6506007)(186003)(36756003)(2616005)(6512007)(66946007)(6636002)(26005)(110136005)(8936002)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1527;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFSo7l9c3lEpdZSQFjPXQp9nq0gZZyKVHTZNZF8ORbajfOG+05eaF2D/hR24oDhnrOBGJaTfHktiuHrJN2kYzWwBD8APhMELgXBmAT8H9Bxf75RzCqTBB+yY1CQ2XfKAtL7wuScRaZy6JeYdwiYvSSEPkBJBeWRyqsfsCnYP/07BqdJcWW1cvJPTmEMgnFAt2CNGqCFnJXRow/gaOTEI7cNpDrgT9CFLn58G0mW6WOHxdI/vEmlVAiHil0wzh3Cr51Apk7M1OKaR4TB5/CeyLubpzTRSARGYKEpaWg+yWNsb5kd+iz4f9NIT8fx7dhCyrDcw5wkIIbfjrnPODWvZP5gjfkFnJChCiWzVhRS/m6Mgiv2+p3qSLi81GoMqwznY+9wgMEu+l9zz4gZxPtsKNaGR3mkXN35Z/6Y90jLWxLxQjPF896phkY2vNz37OuUR
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA32B902DD2634C82E17585FB10F7AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a291fd80-7510-4a11-7bc6-08d77d9a5983
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 17:56:57.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk97Q7iNi4B50ph9FVFqL9dxWrQQnm3WtB6ecldod2rqZmLtQYMuXdcVGpuMA5bDJOiYJCt2d/T0BTkhcaTDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1527
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMTAgYXQgMDk6NDUgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgdGhlIGNoZWNrcyBmb3IgdGhlIHByZXNlbmNlIG9mIEFw
cEtleXMgYW5kIE5ldGtleXMuDQo+IC0tLQ0KPiAgdG9vbHMvbWVzaC9rZXlzLmMgICB8IDI1ICsr
KysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIHRvb2xzL21lc2gvcmVtb3RlLmMgfCAxNyArKysr
KysrKysrKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL2tleXMuYyBiL3Rvb2xz
L21lc2gva2V5cy5jDQo+IGluZGV4IDBjZThjZTgxMS4uNzdiMzJkYTYzIDEwMDY0NA0KPiAtLS0g
YS90b29scy9tZXNoL2tleXMuYw0KPiArKysgYi90b29scy9tZXNoL2tleXMuYw0KPiBAQCAtMzcs
OSArMzcsMTggQEAgc3RydWN0IG5ldF9rZXkgew0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IGxfcXVl
dWUgKm5ldF9rZXlzOw0KPiAgDQo+IC1zdGF0aWMgYm9vbCBzaW1wbGVfbWF0Y2goY29uc3Qgdm9p
ZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gK3N0YXRpYyBib29sIGFwcF9rZXlfcHJlc2VudChjb25z
dCBzdHJ1Y3QgbmV0X2tleSAqa2V5LCB1aW50MTZfdCBhcHBfaWR4KQ0KPiAgew0KPiAtCXJldHVy
biBhID09IGI7DQo+ICsJY29uc3Qgc3RydWN0IGxfcXVldWVfZW50cnkgKmw7DQo+ICsNCj4gKwlm
b3IgKGwgPSBsX3F1ZXVlX2dldF9lbnRyaWVzKGtleS0+YXBwX2tleXMpOyBsOyBsID0gbC0+bmV4
dCkgew0KPiArCQl1aW50MTZfdCBpZHggPSBMX1BUUl9UT19VSU5UKGwtPmRhdGEpOw0KPiArDQo+
ICsJCWlmIChpZHggPT0gYXBwX2lkeCkNCj4gKwkJCXJldHVybiB0cnVlOw0KPiArCX0NCj4gKw0K
PiArCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGJvb2wgbmV0X2lkeF9tYXRj
aChjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiBAQCAtMTAyLDcgKzExMSw3IEBAIHZv
aWQga2V5c19hZGRfYXBwX2tleSh1aW50MTZfdCBuZXRfaWR4LCB1aW50MTZfdCBhcHBfaWR4KQ0K
PiAgCWlmICgha2V5LT5hcHBfa2V5cykNCj4gIAkJa2V5LT5hcHBfa2V5cyA9IGxfcXVldWVfbmV3
KCk7DQo+ICANCj4gLQlpZiAobF9xdWV1ZV9maW5kKGtleS0+YXBwX2tleXMsIHNpbXBsZV9tYXRj
aCwgTF9VSU5UX1RPX1BUUihhcHBfaWR4KSkpDQo+ICsJaWYgKGFwcF9rZXlfcHJlc2VudChrZXks
IGFwcF9pZHgpKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlsX3F1ZXVlX3B1c2hfdGFpbChrZXkt
PmFwcF9rZXlzLCBMX1VJTlRfVE9fUFRSKGFwcF9pZHgpKTsNCj4gQEAgLTEyMSw4ICsxMzAsNyBA
QCB2b2lkIGtleXNfZGVsX2FwcF9rZXkodWludDE2X3QgYXBwX2lkeCkNCj4gIAkJaWYgKCFrZXkt
PmFwcF9rZXlzKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4gLQkJaWYgKGxfcXVldWVfcmVtb3Zl
X2lmKGtleS0+YXBwX2tleXMsIHNpbXBsZV9tYXRjaCwNCj4gLQkJCQkJCQlMX1VJTlRfVE9fUFRS
KGFwcF9pZHgpKSkNCj4gKwkJaWYgKGxfcXVldWVfcmVtb3ZlKGtleS0+YXBwX2tleXMsIExfVUlO
VF9UT19QVFIoYXBwX2lkeCkpKQ0KPiAgCQkJcmV0dXJuOw0KPiAgCX0NCj4gIH0NCj4gQEAgLTE0
MCw4ICsxNDgsNyBAQCB1aW50MTZfdCBrZXlzX2dldF9ib3VuZF9rZXkodWludDE2X3QgYXBwX2lk
eCkNCj4gIAkJaWYgKCFrZXktPmFwcF9rZXlzKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4gLQkJ
aWYgKGxfcXVldWVfZmluZChrZXktPmFwcF9rZXlzLCBzaW1wbGVfbWF0Y2gsDQo+IC0JCQkJCQkJ
TF9VSU5UX1RPX1BUUihhcHBfaWR4KSkpDQo+ICsJCWlmIChhcHBfa2V5X3ByZXNlbnQoa2V5LCBh
cHBfaWR4KSkNCj4gIAkJCXJldHVybiBrZXktPmlkeDsNCj4gIAl9DQo+ICANCj4gQEAgLTE1Miwx
NCArMTU5LDE0IEBAIHN0YXRpYyB2b2lkIHByaW50X2FwcGtleSh2b2lkICphcHBfa2V5LCB2b2lk
ICp1c2VyX2RhdGEpDQo+ICB7DQo+ICAJdWludDE2X3QgYXBwX2lkeCA9IExfUFRSX1RPX1VJTlQo
YXBwX2tleSk7DQo+ICANCj4gLQlidF9zaGVsbF9wcmludGYoIiUzLjN4LCAiLCBhcHBfaWR4KTsN
Cj4gKwlidF9zaGVsbF9wcmludGYoIjB4JTMuM3gsICIsIGFwcF9pZHgpOw0KPiAgfQ0KPiAgDQo+
ICBzdGF0aWMgdm9pZCBwcmludF9uZXRrZXkodm9pZCAqbmV0X2tleSwgdm9pZCAqdXNlcl9kYXRh
KQ0KPiAgew0KPiAgCXN0cnVjdCBuZXRfa2V5ICprZXkgPSBuZXRfa2V5Ow0KPiAgDQo+IC0JYnRf
c2hlbGxfcHJpbnRmKENPTE9SX1lFTExPVyAiTmV0S2V5OiAlMy4zeFxuIiBDT0xPUl9PRkYsIGtl
eS0+aWR4KTsNCj4gKwlidF9zaGVsbF9wcmludGYoQ09MT1JfWUVMTE9XICJOZXRLZXk6IDB4JTMu
M3hcbiIgQ09MT1JfT0ZGLCBrZXktPmlkeCk7DQo+ICANCj4gIAlpZiAoIWtleS0+YXBwX2tleXMg
fHwgbF9xdWV1ZV9pc2VtcHR5KGtleS0+YXBwX2tleXMpKQ0KPiAgCQlyZXR1cm47DQo+IGRpZmYg
LS1naXQgYS90b29scy9tZXNoL3JlbW90ZS5jIGIvdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiBpbmRl
eCA2NzNjN2IwZmIuLjI1ZThkMjNmOCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC9yZW1vdGUu
Yw0KPiArKysgYi90b29scy9tZXNoL3JlbW90ZS5jDQo+IEBAIC00MSw5ICs0MSwxOCBAQCBzdHJ1
Y3QgcmVtb3RlX25vZGUgew0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IGxfcXVldWUgKm5vZGVzOw0K
PiAgDQo+IC1zdGF0aWMgYm9vbCBzaW1wbGVfbWF0Y2goY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9p
ZCAqYikNCj4gK3N0YXRpYyBib29sIGtleV9wcmVzZW50KHN0cnVjdCBsX3F1ZXVlICprZXlzLCB1
aW50MTZfdCBhcHBfaWR4KQ0KPiAgew0KPiAtCXJldHVybiBhID09IGI7DQo+ICsJY29uc3Qgc3Ry
dWN0IGxfcXVldWVfZW50cnkgKmw7DQo+ICsNCj4gKwlmb3IgKGwgPSBsX3F1ZXVlX2dldF9lbnRy
aWVzKGtleXMpOyBsOyBsID0gbC0+bmV4dCkgew0KPiArCQl1aW50MTZfdCBpZHggPSBMX1BUUl9U
T19VSU5UKGwtPmRhdGEpOw0KPiArDQo+ICsJCWlmIChpZHggPT0gYXBwX2lkeCkNCj4gKwkJCXJl
dHVybiB0cnVlOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIGludCBjb21wYXJlX3VuaWNhc3QoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYiwg
dm9pZCAqdXNlcl9kYXRhKQ0KPiBAQCAtMTA0LDcgKzExMyw3IEBAIGJvb2wgcmVtb3RlX2FkZF9u
ZXRfa2V5KHVpbnQxNl90IGFkZHIsIHVpbnQxNl90IG5ldF9pZHgpDQo+ICAJaWYgKCFybXQpDQo+
ICAJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAtCWlmIChsX3F1ZXVlX2ZpbmQocm10LT5uZXRfa2V5
cywgc2ltcGxlX21hdGNoLCBMX1VJTlRfVE9fUFRSKG5ldF9pZHgpKSkNCj4gKwlpZiAoa2V5X3By
ZXNlbnQocm10LT5uZXRfa2V5cywgbmV0X2lkeCkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0K
PiAgCWxfcXVldWVfcHVzaF90YWlsKHJtdC0+bmV0X2tleXMsIExfVUlOVF9UT19QVFIobmV0X2lk
eCkpOw0KPiBAQCAtMTQ2LDcgKzE1NSw3IEBAIGJvb2wgcmVtb3RlX2FkZF9hcHBfa2V5KHVpbnQx
Nl90IGFkZHIsIHVpbnQxNl90IGFwcF9pZHgpDQo+ICAJaWYgKCFybXQtPmFwcF9rZXlzKQ0KPiAg
CQlybXQtPmFwcF9rZXlzID0gbF9xdWV1ZV9uZXcoKTsNCj4gIA0KPiAtCWlmIChsX3F1ZXVlX2Zp
bmQocm10LT5hcHBfa2V5cywgc2ltcGxlX21hdGNoLCBMX1VJTlRfVE9fUFRSKGFwcF9pZHgpKSkN
Cj4gKwlpZiAoa2V5X3ByZXNlbnQocm10LT5hcHBfa2V5cywgYXBwX2lkeCkpDQo+ICAJCXJldHVy
biBmYWxzZTsNCj4gIA0KPiAgCWxfcXVldWVfcHVzaF90YWlsKHJtdC0+YXBwX2tleXMsIExfVUlO
VF9UT19QVFIoYXBwX2lkeCkpOw0K
