Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C07C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8221524680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LAaejlTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgANOoC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:44:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:18706 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgANOoB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:44:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="305163217"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 06:43:59 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:43:54 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:43:54 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:43:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRZG/+5c5MmvhYemxKHyRcABp1iEJ1KKD1B56PoD9QmhFnGK6mCXD6b13AjAz/U2DSktVYj/Z1xVKj2xtcm/G3lm2Jb1uG/vP4GwP6LCB9Xep9YfKdPvFiHC+/qfTk6gGBZdh56bjcQ17Y4I6rG+4CFpR2gJeTHNZsDvf3dNadB08juxdnbosIizelh8XR9nCm+ZMEri9/nVedwB+pBb15D5619tlhGU3TZD8q51TBD4oiDoVh2Tf8aGa8ogdaSS/Ycday5+91E3xAEv9/zwWLMsOEf+4VbBPcrO9xMG6BGM7+wfvjxNL3GsBnzqcetAnnaMjzeEHG8VUGrdkUFucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVVwdlw5FfaYTpMYgfcALS/6q22l/Sq19NwEqh+ue6w=;
 b=ZN582AHqv/hVhAWG6RKnQj3Lx0QPze5IfFB8WGUgLJfAyIE0uZUYMLHAHGRXfpSFZgLU0haPz8q0FnHttO/ESvh0xXhE1o7fDVAfQZf61lML/LEWThg9g0IW5IFJYKOOzlVCWfSMdBoYaX7yPKHJL5Xb0SqpVurV7IwHpp6OAeYsErid87yMq39aacGxLSQ2GGScBvaFsZ/RxaAWSGhNuHzD1V3rK2KD8CEMdoH3CarDea3s3eKAMNSpLtggo2SDCmp4nwqqrsTs8iARkHbCuM8rALSIfseSlQEP/YVZFsblwMJTtMlucXStKN3ZQrV2svl4lOGfGZpmwrGoc1U0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVVwdlw5FfaYTpMYgfcALS/6q22l/Sq19NwEqh+ue6w=;
 b=LAaejlTbqlixO4Tbqp3wWKEE1yLbAjmyal6kzUBqzI7S+2Vdy5owZw0cwe9roimTBgWrLyWYPxODpu1cYi9LcFpe2Bsn+ckDVhpcg+BCXyFWXHDmnZ9V2WQJy6shlBSl9MAHDLX59ICUqupO+F57FrFDPONfLal8mU39bijZLSg=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:43:50 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:43:50 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v2] mesh: Correctly generate NetKey list
Thread-Topic: [PATCH BlueZ v2] mesh: Correctly generate NetKey list
Thread-Index: AQHVxzd3EZlTeGzC00qhSwGAdPcfYqfqQ6GA
Date:   Tue, 14 Jan 2020 14:43:50 +0000
Message-ID: <937f6c4d1f2cf13c619e846a48520a764bcb1012.camel@intel.com>
References: <20200109215432.28295-1-inga.stotland@intel.com>
In-Reply-To: <20200109215432.28295-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce095713-58cf-4d15-c1bd-08d799002b5b
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1805018F6C8C8F041275B646E1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(4326008)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(6636002)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsebApcYze2u30fYLv809FBy8ibLiHrADEBEA6h5VXhcTgDFpGvgVj+6eugOeQA62sSbka/Nhw2hH5vFe2RXWWR1UopMVnrEF7n1FfPVn/dWzJaxhhHLWOfoC/BD+BtJOZ8Hi9oCeNccacfV/y2O8jD/EMUbPvQdypsWpEczXOBmIZnIMp+HJjnJ0Hf44Zr4UQkV7zocTZX/7kndc7o+smp0i0imrmMMuaAqAMWMx7XnCyU7521hcx7dV8PKeEiwTo+s4ukh9yUcRQFqsPDj4HsjgfXHz0wna6t9mANks1VXc4qQD3y1wLVJ6riCH+8+8UNfMWqWVdBveSJvbmIdGwMbYYVzB8XiHeYxjnjwJneFdbkefjsAf2M4m5anvZkiPXcf8z8g1QiDqoCkBWqSo4H9Nwmtms6ieDC6rbk8NoRgBjHrm8yeYuzB1OqqIpoO
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB4B277D3EF5444B72ED3D06808C0A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce095713-58cf-4d15-c1bd-08d799002b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:43:50.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReCKJ889/CfjSwV6nDcTLiYrAytVyv5hx7CIhEXlQmEWLOORPgBWXNwQkxb8BNUh4tE4MBtA+qGG9/m4e9ZC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDEzOjU0IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBXaGVuIHJlc3BvbmRpbmcgd2l0aCBOZXRLZXkgTGlzdCBTdGF0dXMsIHBhY2tl
ZCBOZXRLZXkgaW5kaWNlcyBpbnRvDQo+IDMgb2N0ZXRzIHBlciBwYWlyLiBJZiBudW1iZXIgb2Yg
TmV0S2V5cyBpcyBvZGQsIGFwcGVuZCB0aGUgbGFzdCBrZXkNCj4gaW5kZXggYXMgYSAyLW9jdGV0
IHZhbHVlLg0KPiAtLS0NCj4gIG1lc2gvbmV0LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+
IGluZGV4IDBhNGQyZTcyYy4uZGZhZjdjY2VmIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+
ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTEwNjUsMjYgKzEwNjUsNDYgQEAgYm9vbCBtZXNoX25l
dF9nZXRfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIG5ld19rZXksIHVpbnQxNl90IGlk
eCwNCj4gIGJvb2wgbWVzaF9uZXRfa2V5X2xpc3RfZ2V0KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1
aW50OF90ICpidWYsIHVpbnQxNl90ICpzaXplKQ0KPiAgew0KPiAgCWNvbnN0IHN0cnVjdCBsX3F1
ZXVlX2VudHJ5ICplbnRyeTsNCj4gLQl1aW50MTZfdCBuLCBidWZfc2l6ZTsNCj4gKwl1aW50MTZf
dCBudW1fa2V5cywgcmVxX3NpemUsIGJ1Zl9zaXplOw0KPiArCXN0cnVjdCBtZXNoX3N1Ym5ldCAq
c3VibmV0Ow0KPiAgDQo+ICAJaWYgKCFuZXQgfHwgIWJ1ZiB8fCAhc2l6ZSkNCj4gIAkJcmV0dXJu
IGZhbHNlOw0KPiAgDQo+ICAJYnVmX3NpemUgPSAqc2l6ZTsNCj4gLQlpZiAoYnVmX3NpemUgPCBs
X3F1ZXVlX2xlbmd0aChuZXQtPnN1Ym5ldHMpICogMikNCj4gKw0KPiArCW51bV9rZXlzID0gbF9x
dWV1ZV9sZW5ndGgobmV0LT5zdWJuZXRzKTsNCj4gKwlyZXFfc2l6ZSA9IChudW1fa2V5cyAvIDIp
ICogMyArIChudW1fa2V5cyAlIDIpICogMjsNCj4gKw0KPiArCWlmIChidWZfc2l6ZSA8IHJlcV9z
aXplKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gLQluID0gMDsNCj4gLQllbnRyeSA9IGxf
cXVldWVfZ2V0X2VudHJpZXMobmV0LT5zdWJuZXRzKTsNCj4gKwkqc2l6ZSA9IHJlcV9zaXplOw0K
PiArDQo+ICsJLyogUGFjayBOZXRLZXkgaW5kaWNlcyBpbiAzIG9jdGV0cyAqLw0KPiArCWZvciAo
ZW50cnkgPSBsX3F1ZXVlX2dldF9lbnRyaWVzKG5ldC0+c3VibmV0cyk7IG51bV9rZXlzID4gMTsp
IHsNCj4gKwkJdWludDMyX3QgaWR4X3BhaXI7DQo+ICANCj4gLQlmb3IgKDsgZW50cnk7IGVudHJ5
ID0gZW50cnktPm5leHQpIHsNCj4gLQkJc3RydWN0IG1lc2hfc3VibmV0ICpzdWJuZXQgPSBlbnRy
eS0+ZGF0YTsNCj4gKwkJc3VibmV0ID0gZW50cnktPmRhdGE7DQo+ICsJCWlkeF9wYWlyID0gc3Vi
bmV0LT5pZHg7DQo+ICsJCWlkeF9wYWlyIDw8PSAxMjsNCj4gKw0KPiArCQlzdWJuZXQgPSBlbnRy
eS0+bmV4dC0+ZGF0YTsNCj4gKwkJaWR4X3BhaXIgKz0gc3VibmV0LT5pZHg7DQo+ICsNCj4gKwkJ
bF9wdXRfbGUzMihpZHhfcGFpciwgYnVmKTsNCj4gKwkJYnVmICs9IDM7DQo+ICsNCj4gKwkJbnVt
X2tleXMgLT0gMjsNCj4gKwkJZW50cnkgPSBlbnRyeS0+bmV4dC0+bmV4dDsNCj4gKwl9DQo+ICAN
Cj4gKwkvKiBJZiBvZGQgbnVtYmVyIG9mIE5ldEtleXMsIGZpbGwgaW4gdGhlIGVuZCBvZiB0aGUg
YnVmZmVyICovDQo+ICsJaWYgKG51bV9rZXlzICUgMikgew0KPiArCQlzdWJuZXQgPSBlbnRyeS0+
ZGF0YTsNCj4gIAkJbF9wdXRfbGUxNihzdWJuZXQtPmlkeCwgYnVmKTsNCj4gLQkJbiArPSAyOw0K
PiAgCX0NCj4gIA0KPiAtCSpzaXplID0gbjsNCj4gIAlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0K
