Return-Path: <SRS0=W+hJ=YV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D05CA9EC0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED6B208C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YdpqWmuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJ1Qt4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:49:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:56341 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfJ1Qt4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Oct 2019 12:49:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 09:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="211484872"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 28 Oct 2019 09:49:55 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 09:49:55 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 09:49:54 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Oct 2019 09:49:54 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.57) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 28 Oct 2019 09:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFCuGQkNB5EnBKgbXF2IUbHRYsaOfdslDpiTNnOwbyGyyujko/FuWzuZUw/QTtDoKo/dOypAJZw3xFmJwa+Vua24pOrCE3wkZrLIWdpoBEUeWel2NtXyGFxwQwhtWx8ScjELV95O8gMZZm8CUkJV27LH/+PzldNobRq5GFo8MYJd2IcBsAtluMTIxrlFHzJRnEJsgz6cFaA3CUOwAHT2bnQHmSgtEi18JUxt7f2NqWZFheddiK6VwYYhI8H5IrUd9lqzMlZ9nUJPwFq3DHeRMnZgg4KRUE9xRMcijNyZCr1mZ6VAfVe08FoCSUKbCM8GNJcaPy+rm6HwGXye+Kr6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urkqSi2Gw+qLWlTNykXxhKfBuEm4rLaPwY98VgoGt44=;
 b=cudyO+1v+J7U1emqOO+2xzqw53tdLJIkW3Kt/qrODlxiKeoEQs3ZT9P3MWw8uq4lWCybtSn7i6a4C3xMmTCXWuWB1/zEZru6uU0RV930Qbf9Zx/lo9agXYuZAoYO5rzuLLOr+4YB3qmEepqtzPPtQVZ6EO0i7dOwf+cRi7D3iY2KBDkZCVctgyf/ySNSb8cETnj/z12BthKFlkF2eXVms4554IYA4LKLjvCZjQZbVIcUIFa4xm/gZQXHwo3GnKrPFczYbMjZ8C1VjOwdFdaYkktmIv+nFIhtErG+pizS+pbyCbyVJUWwxfpA8c9113ZNubVM63Vg9Anq/GINPZlLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urkqSi2Gw+qLWlTNykXxhKfBuEm4rLaPwY98VgoGt44=;
 b=YdpqWmuzVXXAp0fiN9yyIP72Qt5RxZ9C83TNNwJt4ehTKcHNkg1Y70eddwUtQnfW5C16LtIQURMVR+kPHLix+9WuiAonpq+5c8aAZPDzR0qObrDcPOl3ccGekVeZMbv2UlYAEyY+JvsSjtcA+9ixur3JK1+41Brlb+WeSZeJAw4=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2342.namprd11.prod.outlook.com (10.173.191.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 16:49:53 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501%10]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 16:49:52 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix reading/writing key indices
Thread-Topic: [PATCH BlueZ v2] mesh: Fix reading/writing key indices
Thread-Index: AQHVh42FtcHnZoMT+kiEul/sFzVY9KdwUFOA
Date:   Mon, 28 Oct 2019 16:49:52 +0000
Message-ID: <ba8773a34a1c68f408176bdd9963c221b511f384.camel@intel.com>
References: <20191020212949.21492-1-inga.stotland@intel.com>
In-Reply-To: <20191020212949.21492-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6322343e-9169-40e4-c1cb-08d75bc6dadd
x-ms-traffictypediagnostic: CY4PR1101MB2342:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB234278BBE2D7A5CBE8BC05ABE1660@CY4PR1101MB2342.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(8936002)(81156014)(81166006)(8676002)(71200400001)(6436002)(25786009)(76116006)(86362001)(14454004)(36756003)(6486002)(476003)(478600001)(6246003)(2906002)(14444005)(256004)(6512007)(66066001)(66946007)(26005)(5660300002)(6116002)(71190400001)(4001150100001)(102836004)(186003)(3846002)(6506007)(305945005)(2501003)(7736002)(229853002)(6636002)(118296001)(446003)(2616005)(66476007)(66556008)(64756008)(66446008)(91956017)(76176011)(99286004)(486006)(11346002)(316002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2342;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yb+ZhHwzufx4Ahab+mg7JEdz6Qz0sb0KzpPxQAovSXS8RHM0q86y3esqHEkuCLdnZpvveRtPBN9T5//CNqQN5knAjt2mlkIC21JDykHuMytjinqgK2yNfvvX5oheSrZPO2Ul7qlKJ+1nMUZFVLTgAb8vHURwjRifdpgMDoK3eMkCtZ2oERMqy1hTvOEXMKRAwYM85M/kNy3+pCIjWGFEj5EFlB04/QOz/QqYhw59Qd2C1egvtjo7JFBFF+Ee8MKuofWEnDt1lxwcJl7QL7fsWZPfIiDiDUhNj1qz4f+jMuUfPzsopICr0tUytHiUbQCzbjj+deyxWCIBN6JE2CnfsdLkInL79GYszFqkSYgqoWDRmx7BSJIXihVPpCh1qfW8ijWC7BlFHwwp8GaPeBUH/3rhr9XsTV1nLMUojToU0vvbEcuO3bNzCiIUJfRlOugz
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F8FE8E50BB55349A0CE327D9CD41C89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6322343e-9169-40e4-c1cb-08d75bc6dadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 16:49:52.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btSY4H0IJY7uhJHdxGEeRyCj7fUSd0/q+YjMYP3t/cW50UjZmQ+A9GIPK9UqP8XIayAPESYs1PpJ3nmACOhewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2342
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzLg0KDQpPbiBTdW4sIDIwMTktMTAtMjAgYXQgMTQ6MjkgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgaW5jb25zaXN0ZW5jeSB3aGVuIHJlYWRp
bmcvd3JpdGluZyBOZXRLZXkgYW5kIEFwcEtleQ0KPiBpbmRpY2VzIHRvL2Zyb20gSlNPTiBjb25m
aWcgc3RvcmFnZToNCj4gCS0gd2hlbiB3cml0aW5nLCBjb252ZXJ0IGFuIGludGVnZXIgdG8gaGV4
IHN0cmluZw0KPiAJLSB3aGVuIHJlYWRpbmcsIGNvbnZlcnQgaGV4IHN0cmluZyB0byB1aW50MTYg
aW50ZWdlcg0KPiAtLS0NCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwgNjcgKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MCBp
bnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21l
c2gtY29uZmlnLWpzb24uYyBiL21lc2gvbWVzaC1jb25maWctanNvbi5jDQo+IGluZGV4IGRmNThj
YmQ3ZC4uODY1ZmJkZjA3IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0K
PiArKysgYi9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0KPiBAQCAtNDUsNyArNDUsNyBAQA0KPiAg
I2RlZmluZSBNSU5fU0VRX0NBQ0hFX1ZBTFVFCSgyICogMzIpDQo+ICAjZGVmaW5lIE1JTl9TRVFf
Q0FDSEVfVElNRQkoNSAqIDYwKQ0KPiAgDQo+IC0jZGVmaW5lIENIRUNLX0tFWV9JRFhfUkFOR0Uo
eCkgKCgoeCkgPj0gMCkgJiYgKCh4KSA8PSA0MDk1KSkNCj4gKyNkZWZpbmUgQ0hFQ0tfS0VZX0lE
WF9SQU5HRSh4KSAoKHgpIDw9IDQwOTUpDQo+ICANCj4gIHN0cnVjdCBtZXNoX2NvbmZpZyB7DQo+
ICAJanNvbl9vYmplY3QgKmpub2RlOw0KPiBAQCAtMjYzLDEzICsyNjMsMTYgQEAgc3RhdGljIGpz
b25fb2JqZWN0ICpnZXRfa2V5X29iamVjdChqc29uX29iamVjdCAqamFycmF5LCB1aW50MTZfdCBp
ZHgpDQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgc3o7ICsraSkgew0KPiAgCQlqc29uX29iamVj
dCAqamVudHJ5LCAqanZhbHVlOw0KPiAtCQl1aW50MzJfdCBqaWR4Ow0KPiArCQljb25zdCBjaGFy
ICpzdHI7DQo+ICsJCXVpbnQxNl90IGppZHg7DQo+ICANCj4gIAkJamVudHJ5ID0ganNvbl9vYmpl
Y3RfYXJyYXlfZ2V0X2lkeChqYXJyYXksIGkpOw0KPiAgCQlpZiAoIWpzb25fb2JqZWN0X29iamVj
dF9nZXRfZXgoamVudHJ5LCAiaW5kZXgiLCAmanZhbHVlKSkNCj4gIAkJCXJldHVybiBOVUxMOw0K
PiAgDQo+IC0JCWppZHggPSBqc29uX29iamVjdF9nZXRfaW50KGp2YWx1ZSk7DQo+ICsJCXN0ciA9
IGpzb25fb2JqZWN0X2dldF9zdHJpbmcoanZhbHVlKTsNCj4gKwkJaWYgKHNzY2FuZihzdHIsICIl
MDRoeCIsICZqaWR4KSAhPSAxKQ0KPiArCQkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAkJaWYgKGpp
ZHggPT0gaWR4KQ0KPiAgCQkJcmV0dXJuIGplbnRyeTsNCj4gQEAgLTI3OCw2ICsyODEsMjggQEAg
c3RhdGljIGpzb25fb2JqZWN0ICpnZXRfa2V5X29iamVjdChqc29uX29iamVjdCAqamFycmF5LCB1
aW50MTZfdCBpZHgpDQo+ICAJcmV0dXJuIE5VTEw7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBib29s
IGdldF9rZXlfaW5kZXgoanNvbl9vYmplY3QgKmpvYmosIGNvbnN0IGNoYXIgKmtleXdvcmQsDQo+
ICsJCQkJCQkJCXVpbnQxNl90ICppbmRleCkNCj4gK3sNCj4gKwl1aW50MTZfdCBpZHg7DQo+ICsJ
anNvbl9vYmplY3QgKmp2YWx1ZTsNCj4gKwljb25zdCBjaGFyICpzdHI7DQo+ICsNCj4gKwlpZiAo
IWpzb25fb2JqZWN0X29iamVjdF9nZXRfZXgoam9iaiwga2V5d29yZCwgJmp2YWx1ZSkpDQo+ICsJ
CXJldHVybiBmYWxzZTsNCj4gKw0KPiArCXN0ciA9IGpzb25fb2JqZWN0X2dldF9zdHJpbmcoanZh
bHVlKTsNCj4gKw0KPiArCWlmIChzc2NhbmYoc3RyLCAiJTA0aHgiLCAmaWR4KSAhPSAxKQ0KPiAr
CQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlpZiAoIUNIRUNLX0tFWV9JRFhfUkFOR0UoaWR4KSkN
Cj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJKmluZGV4ID0gKHVpbnQxNl90KSBpZHg7DQo+
ICsJcmV0dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBqc29uX29iamVjdCAqamFycmF5
X2tleV9kZWwoanNvbl9vYmplY3QgKmphcnJheSwgaW50MTZfdCBpZHgpDQo+ICB7DQo+ICAJanNv
bl9vYmplY3QgKmphcnJheV9uZXc7DQo+IEBAIC0yODgsMTYgKzMxMywxMyBAQCBzdGF0aWMganNv
bl9vYmplY3QgKmphcnJheV9rZXlfZGVsKGpzb25fb2JqZWN0ICpqYXJyYXksIGludDE2X3QgaWR4
KQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBzejsgKytpKSB7
DQo+IC0JCWpzb25fb2JqZWN0ICpqZW50cnksICpqdmFsdWU7DQo+ICsJCWpzb25fb2JqZWN0ICpq
ZW50cnk7DQo+ICsJCXVpbnQxNl90IG5pZHg7DQo+ICANCj4gIAkJamVudHJ5ID0ganNvbl9vYmpl
Y3RfYXJyYXlfZ2V0X2lkeChqYXJyYXksIGkpOw0KPiAgDQo+IC0JCWlmIChqc29uX29iamVjdF9v
YmplY3RfZ2V0X2V4KGplbnRyeSwgImluZGV4IiwgJmp2YWx1ZSkpIHsNCj4gLQkJCWludCB0bXAg
PSBqc29uX29iamVjdF9nZXRfaW50KGp2YWx1ZSk7DQo+IC0NCj4gLQkJCWlmICh0bXAgPT0gaWR4
KQ0KPiAtCQkJCWNvbnRpbnVlOw0KPiAtCQl9DQo+ICsJCWlmIChnZXRfa2V5X2luZGV4KGplbnRy
eSwgImluZGV4IiwgJm5pZHgpICYmIG5pZHggPT0gaWR4KQ0KPiArCQkJY29udGludWU7DQo+ICAN
Cj4gIAkJanNvbl9vYmplY3RfZ2V0KGplbnRyeSk7DQo+ICAJCWpzb25fb2JqZWN0X2FycmF5X2Fk
ZChqYXJyYXlfbmV3LCBqZW50cnkpOw0KPiBAQCAtNDE5LDIxICs0NDEsNiBAQCBzdGF0aWMgYm9v
bCByZWFkX2RldmljZV9rZXkoanNvbl9vYmplY3QgKmpvYmosIHVpbnQ4X3Qga2V5X2J1ZlsxNl0p
DQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBib29sIGdldF9rZXlfaW5k
ZXgoanNvbl9vYmplY3QgKmpvYmosIGNvbnN0IGNoYXIgKmtleXdvcmQsDQo+IC0JCQkJCQkJCXVp
bnQxNl90ICppbmRleCkNCj4gLXsNCj4gLQlpbnQgaWR4Ow0KPiAtDQo+IC0JaWYgKCFnZXRfaW50
KGpvYmosIGtleXdvcmQsICZpZHgpKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gLQlpZiAo
IUNIRUNLX0tFWV9JRFhfUkFOR0UoaWR4KSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+IC0J
KmluZGV4ID0gKHVpbnQxNl90KSBpZHg7DQo+IC0JcmV0dXJuIHRydWU7DQo+IC19DQo+IC0NCj4g
IHN0YXRpYyBib29sIHJlYWRfYXBwX2tleXMoanNvbl9vYmplY3QgKmpvYmosIHN0cnVjdCBtZXNo
X2NvbmZpZ19ub2RlICpub2RlKQ0KPiAgew0KPiAgCWpzb25fb2JqZWN0ICpqYXJyYXk7DQo+IEBA
IC01NzAsNiArNTc3LDcgQEAgYm9vbCBtZXNoX2NvbmZpZ19uZXRfa2V5X2FkZChzdHJ1Y3QgbWVz
aF9jb25maWcgKmNmZywgdWludDE2X3QgaWR4LA0KPiAgDQo+ICAJam5vZGUgPSBjZmctPmpub2Rl
Ow0KPiAgDQo+ICsJbF9kZWJ1ZygibmV0S2V5ICU0LjR4IiwgaWR4KTsNCj4gIAlqc29uX29iamVj
dF9vYmplY3RfZ2V0X2V4KGpub2RlLCAibmV0S2V5cyIsICZqYXJyYXkpOw0KPiAgCWlmIChqYXJy
YXkpDQo+ICAJCWplbnRyeSA9IGdldF9rZXlfb2JqZWN0KGphcnJheSwgaWR4KTsNCj4gQEAgLTk2
NSwxNCArOTczLDE5IEBAIHN0YXRpYyBib29sIHBhcnNlX2JpbmRpbmdzKGpzb25fb2JqZWN0ICpq
YXJyYXksIHN0cnVjdCBtZXNoX2NvbmZpZ19tb2RlbCAqbW9kKQ0KPiAgCW1vZC0+YmluZGluZ3Mg
PSBsX25ldyh1aW50MTZfdCwgY250KTsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBjbnQ7ICsr
aSkgew0KPiAtCQlpbnQgaWR4Ow0KPiArCQl1aW50MTZfdCBpZHg7DQo+ICsJCWNvbnN0IGNoYXIg
KnN0cjsNCj4gIAkJanNvbl9vYmplY3QgKmp2YWx1ZTsNCj4gIA0KPiAgCQlqdmFsdWUgPSBqc29u
X29iamVjdF9hcnJheV9nZXRfaWR4KGphcnJheSwgaSk7DQo+ICAJCWlmICghanZhbHVlKQ0KPiAg
CQkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IC0JCWlkeCA9IGpzb25fb2JqZWN0X2dldF9pbnQoanZh
bHVlKTsNCj4gKwkJc3RyID0ganNvbl9vYmplY3RfZ2V0X3N0cmluZyhqdmFsdWUpOw0KPiArDQo+
ICsJCWlmIChzc2NhbmYoc3RyLCAiJTA0aHgiLCAmaWR4KSAhPSAxKQ0KPiArCQkJcmV0dXJuIGZh
bHNlOw0KPiArDQo+ICAJCWlmICghQ0hFQ0tfS0VZX0lEWF9SQU5HRShpZHgpKQ0KPiAgCQkJcmV0
dXJuIGZhbHNlOw0KPiAgDQo=
