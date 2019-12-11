Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F9C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9871222C4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 22:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yZy+iqAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLKWz6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:55:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:40214 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLKWz6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 17:55:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 14:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="216081950"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2019 14:55:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 14:55:57 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 14:55:56 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:55:56 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 11 Dec 2019 14:55:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcOMl6Tcm9yp6qyBlCYi1KrwNbPc80HUzSVIzMbW5quTSCExk3KcD84YwCO6OTZa7pcYpqRkClCC/IWQNyde88/4pBRQIbFYE0/Y8qFYECIyR1muI0Ib254glrmMcMW2OP/OcrpDEyWvUtbuq2T/O7sUBfdl4cFtKgvVNyulH9fYlZ7Nq1hRpAlVX1FaTQAkIEFYCu3y4YNkIeBDa6c/C7B6mu9opbZ0EME5gQQB8wRj38lRzwivShxJ40MlJ65y23lWaxC0jPIHrFEMbcZi3Oip8/0NUAUvKj92iS/5orXYngxdurlmmm+h/nOCgsuaDzkUeaMpZ94jghLlaXXNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0KsSGGEyTXxqR7cHySL4vene5u/u/XR1TFMBYZtAr8=;
 b=A9W17ilnyv6ijCYBtbzYx2JRHOyXpfXHtTYQezpxySrDHgWaN2MPdb0UHdwoCTtqZR/20EBhXGnQdFaok8X2f9cAJ3aBfnBmvf0wA/J1mS6JOJ3yhQxA9neMJ/ozEOR7wXWdDItpt11UsFGemgyyXRDgoSapOsfgf1RjVhv62rr5tQsSwQfT0n5zskR8xKUXsvNXK1q5TJ8THdWjvzOkkinzjn592L/guG/OF4EgBjqFYGFavM10Anp93jnuzQIaO3xauwclhmfkkwfQVxaoLdyLGAw3NkLGq7BoMmsCOK813oj6crJcBs3E7WSy+t0mDdMu3qf/LFA1IA1SMlX27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0KsSGGEyTXxqR7cHySL4vene5u/u/XR1TFMBYZtAr8=;
 b=yZy+iqAUBqmYQPTPqEdHDKNAZnN7PMgtwwLNZW2Ny09IhgSv35JAVflcJX0U11TKNd9gchvD6e0gbL84S74y4opVLuSu+JbbRqAJ9HZdjtHU/xfB9jr5KaXN574fB/B4x0xjukU+jWcZ/x7ViO+2wP9ZCtoW+ZEmP/MbPE4uolM=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB2845.namprd11.prod.outlook.com (52.135.95.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Wed, 11 Dec 2019 22:55:47 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 22:55:47 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Topic: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Thread-Index: AQHVr6551J/iTUNml0e+fQaBypqmNqe1UIMAgAA8XoA=
Date:   Wed, 11 Dec 2019 22:55:46 +0000
Message-ID: <bc1fa0d405c20057517b773141db868c26f0ef35.camel@intel.com>
References: <20191210230600.23035-1-inga.stotland@intel.com>
         <85224a83d7e93ec11da47e1a2852f35a3a170115.camel@intel.com>
In-Reply-To: <85224a83d7e93ec11da47e1a2852f35a3a170115.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda57dfc-bc3f-4178-e612-08d77e8d42d7
x-ms-traffictypediagnostic: SN6PR11MB2845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28459A635804661ED9F18069FB5A0@SN6PR11MB2845.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(66446008)(66556008)(8936002)(64756008)(36756003)(478600001)(2906002)(186003)(81166006)(81156014)(8676002)(110136005)(316002)(6506007)(66476007)(26005)(66946007)(91956017)(76116006)(6486002)(5660300002)(86362001)(4001150100001)(71200400001)(2616005)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2845;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/dcv4PfaZchtwtDXxwTq8np8fDGtLjzytU8MEuaENLTzCMs0Mzlvc/nBH0cqZ454krdBSPym8JjW0QDXkOauGTkyz7kztqiktmJtbD0nJeBIWRKZLUAcHK02i0aXufDegK6CuHpII9JPdgvvIZbEa/Oz56C5KP+wpTIaSkdrHuXwOrZjDT+l3XSgwQr+Y90aG/8/grx+ECZ6I2CT3HNLSMf7GvDWJLPcdhna7lZpOclG2kGHQdPbEeH6lkMNE9B3pnVNFBKqQgcscn1ZEFUQtTswpvZGWdIJnCQehtdA+3xGMDCTGF8jbSYvnbqRZQJP61go+OoAmupxAYeEnjhoq5XWEJwK29F0wjYTkxAefAAJ7fLuI8Xzs08fK2u6CGVdfUhHcOK3qtQ3riLEDKCmMHmpoeY7oz64ykbtKAlAZyfMMXflzSpYdPa+BAfyxiO
Content-Type: text/plain; charset="utf-8"
Content-ID: <5552036838077A45B3A6B9C0465163F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cda57dfc-bc3f-4178-e612-08d77e8d42d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 22:55:47.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHjWQ7+rdOT6L1V4oZS+UssmJzpR5o2BfIJDSgyTYA7L2KsU80i1iAmoF9D+jqM7ASjh8s9O5iSfrTzTzhEuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2845
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCk9uIFdlZCwgMjAxOS0xMi0xMSBhdCAxOToxOSArMDAwMCwgR2l4LCBCcmlh
biB3cm90ZToNCj4gSGkgSW5nYSwNCj4gDQo+IE9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxNTowNiAt
MDgwMCwgSW5nYSBTdG90bGFuZCB3cm90ZToNCj4gPiBUaGlzIHJlbW92ZXMgdW5uZWNlc3Nhcnkg
aG91c2VrZWVwaW5nIGZvciBoY2kgY29udHJvbGxlcnMNCj4gPiAtLS0NCj4gPiAgbWVzaC9tZXNo
LW1nbXQuYyB8IDIyICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L21lc2gvbWVzaC1tZ210LmMgYi9tZXNoL21lc2gtbWdtdC5jDQo+ID4gaW5kZXggMjcyNzJkNGQy
Li4yY2YyZWJhYzIgMTAwNjQ0DQo+ID4gLS0tIGEvbWVzaC9tZXNoLW1nbXQuYw0KPiA+ICsrKyBi
L21lc2gvbWVzaC1tZ210LmMNCj4gPiBAQCAtNDIsMTQgKzQyLDggQEAgc3RydWN0IHJlYWRfaW5m
b19yZXEgew0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RhdGljIHN0cnVjdCBtZ210ICptZ210X21l
c2g7DQo+ID4gLXN0YXRpYyBzdHJ1Y3QgbF9xdWV1ZSAqY29udHJvbGxlcnM7DQo+ID4gIHN0YXRp
YyBzdHJ1Y3QgbF9xdWV1ZSAqcmVhZF9pbmZvX3JlZ3M7DQo+ID4gIA0KPiA+IC1zdGF0aWMgYm9v
bCBzaW1wbGVfbWF0Y2goY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gPiAtew0KPiA+
IC0JcmV0dXJuIGEgPT0gYjsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgc3RhdGljIHZvaWQgcHJvY2Vz
c19yZWFkX2luZm9fcmVxKHZvaWQgKmRhdGEsIHZvaWQgKnVzZXJfZGF0YSkNCj4gPiAgew0KPiA+
ICAJc3RydWN0IHJlYWRfaW5mb19yZWcgKnJlZyA9IGRhdGE7DQo+ID4gQEAgLTEwMSwyMyArOTUs
MTQgQEAgc3RhdGljIHZvaWQgcmVhZF9pbmZvX2NiKHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBs
ZW5ndGgsDQo+ID4gIHN0YXRpYyB2b2lkIGluZGV4X2FkZGVkKHVpbnQxNl90IGluZGV4LCB1aW50
MTZfdCBsZW5ndGgsIGNvbnN0IHZvaWQgKnBhcmFtLA0KPiA+ICAJCQkJCQkJdm9pZCAqdXNlcl9k
YXRhKQ0KPiA+ICB7DQo+ID4gLQlpZiAobF9xdWV1ZV9maW5kKGNvbnRyb2xsZXJzLCBzaW1wbGVf
bWF0Y2gsIExfVUlOVF9UT19QVFIoaW5kZXgpKSkNCj4gPiAtCQlyZXR1cm47DQo+ID4gLQ0KPiA+
IC0JbF9xdWV1ZV9wdXNoX3RhaWwoY29udHJvbGxlcnMsIExfVUlOVF9UT19QVFIoaW5kZXgpKTsN
Cj4gDQo+IEkgdGhpbmsgYmVmb3JlIGFwcGx5aW5nIHRoaXMsIHdlIHNob3VsZCByZS13b3JrIHRo
ZSBjb250cm9sbGVyIGluZGV4IHRvIGJlIGNvbnNpc3RlbnRseSB1aW50MTZfdCwgcmF0aGVyIHRo
YW4NCj4gdGhlIGF3a3dhcmQgbWl4IG9mIGludCBhbmQgdWludDE2X3QuDQoNCkkgYWdyZWUgdGhh
dCBjb25zaXN0ZW5jeSB3b3VsZCBiZSBnb29kLg0KSG93ZXZlciwgSSBkaXNhZ3JlZSB0aGF0IHRo
aXMgbmVlZHMgdG8gYmUgYSBwYXJ0IG9mIHRoaXMgcGF0Y2g6IHRoaW9zDQpwYXRjaCByZW1vdmVz
IGNvZGUgdGhhdCBpcyBub3QgbmVlZGVkLiBOb3RoaW5nIHRvIGRvIHdpdGggaW5kaWNlcy4NCg0K
PiANCj4gPiAtDQo+ID4gLQlpZiAobWdtdF9zZW5kKG1nbXRfbWVzaCwgTUdNVF9PUF9SRUFEX0lO
Rk8sIGluZGV4LCAwLCBOVUxMLA0KPiA+IC0JCQlyZWFkX2luZm9fY2IsIExfVUlOVF9UT19QVFIo
aW5kZXgpLCBOVUxMKSAhPSAwKQ0KPiA+IC0JCXJldHVybjsNCj4gPiAtDQo+ID4gLQlsX3F1ZXVl
X3JlbW92ZShjb250cm9sbGVycywgTF9VSU5UX1RPX1BUUihpbmRleCkpOw0KPiA+ICsJbWdtdF9z
ZW5kKG1nbXRfbWVzaCwgTUdNVF9PUF9SRUFEX0lORk8sIGluZGV4LCAwLCBOVUxMLA0KPiA+ICsJ
CQkJcmVhZF9pbmZvX2NiLCBMX1VJTlRfVE9fUFRSKGluZGV4KSwgTlVMTCk7DQo+ID4gIH0NCj4g
PiAgDQo+ID4gIHN0YXRpYyB2b2lkIGluZGV4X3JlbW92ZWQodWludDE2X3QgaW5kZXgsIHVpbnQx
Nl90IGxlbmd0aCwgY29uc3Qgdm9pZCAqcGFyYW0sDQo+ID4gIAkJCQkJCQl2b2lkICp1c2VyX2Rh
dGEpDQo+ID4gIHsNCj4gPiAgCWxfd2FybigiSGNpIGRldiAlNC40eCByZW1vdmVkIiwgaW5kZXgp
Ow0KPiA+IC0JbF9xdWV1ZV9yZW1vdmUoY29udHJvbGxlcnMsIExfVUlOVF9UT19QVFIoaW5kZXgp
KTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgcmVhZF9pbmRleF9saXN0X2NiKHVp
bnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW5ndGgsDQo+ID4gQEAgLTE1Nyw5ICsxNDIsNiBAQCBz
dGF0aWMgdm9pZCByZWFkX2luZGV4X2xpc3RfY2IodWludDhfdCBzdGF0dXMsIHVpbnQxNl90IGxl
bmd0aCwNCj4gPiAgDQo+ID4gIHN0YXRpYyBib29sIG1lc2hfbWdtdF9pbml0KHZvaWQpDQo+ID4g
IHsNCj4gPiAtCWlmICghY29udHJvbGxlcnMpDQo+ID4gLQkJY29udHJvbGxlcnMgPSBsX3F1ZXVl
X25ldygpOw0KPiA+IC0NCj4gPiAgCWlmICghcmVhZF9pbmZvX3JlZ3MpDQo+ID4gIAkJcmVhZF9p
bmZvX3JlZ3MgPSBsX3F1ZXVlX25ldygpOw0KPiA+ICANCg0KQmVzdCByZWdhcmRzLA0KDQpJbmdh
DQo=
