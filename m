Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F9C43445
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C0C2075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nXtUKDqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgFRPlZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:41:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:30271 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbgFRPlD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 11:41:03 -0400
IronPort-SDR: VhKUWIf8jxgaGyceQE+jCHXdyl2pBSr/n6U0QKwFLj8Fzo1SC9359XFzlbYOJQdOXQgTEo/za1
 ti4DqzLAAenQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="131020476"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="131020476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:41:01 -0700
IronPort-SDR: asNPvwGZnporke1aE8V8yyFSc9BqdF7eEmRfjdXlKSeW9xsK2xoNYApfmYZxHFtIbVQ6PlodD/
 v4SXQTgzuqLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="352449330"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2020 08:41:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:41:01 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jun 2020 08:41:01 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jun 2020 08:41:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 08:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0kteMZ0rBv3kjIVA6xE+QSn5H6cqM1zBDGgzl7llyw+Gh89HyUhWfDc465VzHZviDwYUmmw0ApUuY7rQixAaEpea0pD0otjM7+VUqNFzf9SsCr5DoUw5/Uw5qA77Lar5S0n9AMyg8AdIkwycf5X3OV4I4fhaJWkyypJmwtdPycRXXt7+vm3riMYgr1mhg9tQ0REiM2g68t3nfkDjFLhe9GvLmAkXoK4yheIhNaEX6s7YjVXUETUkUHrae7tQ3vuc92Fnyzj2nwdRBRghy25VD8M5nqCyXdM8hX5EHhx/ecJ2X3dPNqOMqKw0kQHve0ZPzLl5oVXsfpGrLVtgC7nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcroUzwYVI9MpPFMv8D9wARYXGmIfzOuq4mhK34Mkn0=;
 b=CI9xKxNdaHn+hWZjFO7bOmTTZ3fFAS5lOn35nuh98JUzwRbMjWQ950wWQGKOp5IP7rCh1s7T1+WU7BQqEfJvh+O08OKzkJPr9msMzNDIWkxc/suQJi4KWErp+ysDT6qROahcoyU642wq9Fjh93dbwMo7qYEHD1/1jzNiTBYk8go835vjsI4Wk8Xq7m53vCb4Hge1VFWC+WFeujZf+Tx4BaZtRmbs8Fy3w87NAGtnszssnoPeYvff7QfDnotoJXbxAUTrpzXBuf+hYXyVvrEMwH/RAdUeLCfBIttQEtxSfnWQ53MA5Mqz5AzuScNUliAl+4wa5XqFROiCqnKJIF//4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcroUzwYVI9MpPFMv8D9wARYXGmIfzOuq4mhK34Mkn0=;
 b=nXtUKDqME/c1Dxhhin0MWl/J9xfln5qYszF/qXKvkFZMrLlIR7vWH6lF6eYSfgHKphWt3YHDL5JOigEY9m6n8q9LxOZUx/jvAe4qbtvzwUQboEdTsqFtXz5fu68MED5EIEMev4v7/vgxGFc7sXTXcQuHQQuXBlG8FeSAQWsR7OM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1437.namprd11.prod.outlook.com (2603:10b6:301:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 15:40:57 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 15:40:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Replace BeaconFlags with just IvUpdate
Thread-Topic: [PATCH BlueZ] mesh: Replace BeaconFlags with just IvUpdate
Thread-Index: AQHWROW0Cb67WPTJQUOhDdoTX3h6Uqjeg+sA
Date:   Thu, 18 Jun 2020 15:40:56 +0000
Message-ID: <0699780dc4a367561f9a14ba2adf3fe9cc060bb1.camel@intel.com>
References: <20200617202657.42474-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200617202657.42474-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a91a43a2-f374-4e5c-b3ea-08d8139dfe4f
x-ms-traffictypediagnostic: MWHPR11MB1437:
x-microsoft-antispam-prvs: <MWHPR11MB1437809BAABEF642B74840BFE19B0@MWHPR11MB1437.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y33Eq7N25gSHbDpICK/NCqgVgTXSg1SRzjO2ztxOlIQaKIvQHeBOAJ1jzUXSHBpjbC1SDPSl0KmmIk3gDzB4KcL9P+k+yYB4imKDIh8tLjJtLvp1zVuTOnouCUYXJD0LspIi3Cf2XTlbZwWwy/2HBoRA6Wz+dtWhkLGG7REzJZLqtY81ee1+Z73W8Zzuvr/hKn1S4LhJcuI+ctbukXfWcsjT7IFAjmp8y9+RNt+6KK4goOBywWYwES3Otvh70Z1SlTaQlwEA4mB4eJuP06B2mJwgY5dy+IwrnBeBtaF/tb2D0F9p7Q6blfDecaM/6DHFtIvxpUG4F4TxJgViAm/SnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(8676002)(2906002)(6512007)(5660300002)(6486002)(478600001)(8936002)(2616005)(66556008)(186003)(66476007)(83380400001)(66446008)(6506007)(76116006)(110136005)(86362001)(316002)(36756003)(66946007)(64756008)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 40GyRhP1thWfnHnJe7LSHqLy/Oj3r3YbE/8ubn/L0ewO2Hmx6eGjgBYy4/O5vX7tBi1mPOyblSQ8B4EeS+y6kKEbvhGZ1ggftFg7kODhAyFhKshLhO9AhT1c+3jSdpsM4m+WiuEKbwg08Ir7AlcIMVMscgPLGVxs6Mi4xBIx+H4Xp/mASWGfaKGXJkz0hTIJxbaaFFVdx6isViyqOVvREwCdSHEaPnqXO3E4WtQaYM6gW/S217hMnTxKE0JctW1YlUWPvSOJs6C/zapnEGOLXKnFQYAXs90UA8lCyJjhUb3vG70Ez0qx2BpOYLq6MN4Xtfx2w8MLnngW9kcuwU7lDGoZUXVm2yqfUgC9JmlgZwYP4X700n0khp8PpEq2mQCIycWOR4Y+3hae0fyzyV33PGAtnWKwKX4oqG3Wq/zSGYzabb8fMEb7oj5+gbEnl0+XPMEVtyd8u7KgpFLATnGOExhlPWGEEcZ/glOonttvjJlVeh4kJX7ZgrH0lOA5b1Hk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CACA7340DB6E9847A9375CF079E6432E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a91a43a2-f374-4e5c-b3ea-08d8139dfe4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:40:56.8771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUhJhF/S9S1i7j32tJtMpakYHwEQfPUyYsIhfSmI/Zkq/tiWSQRStTBC8REK9h3R9s0Mkj0wZ3Io7vm89ErIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1437
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTA2LTE3IGF0IDIyOjI2ICswMjAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gVG8gaW1wb3J0IG5vZGVzLCBhcHBsaWNhdGlvbnMgbmVlZCBq
dXN0IEl2SW5kZXggYW5kIEl2VXBkYXRlLiBLZXlSZWZyZXNoDQo+IHBoYXNlIGluIHVuZGVyIHBy
b3Zpc2lvbmVyJ3MgY29udHJvbCwgc28gd2UgZG9uJ3QgbmVlZCB0byBleHBvc2UgaXQuDQo+IA0K
PiBNb3Jlb3ZlciwgQmVhY29uRmxhZ3MgcHJvcGVydHkgZGVhbHQganVzdCB3aXRoIHRoZSBwcmlt
YXJ5IG5ldCBrZXksIGFuZA0KPiBlYWNoIHN1Ym5ldCBrZXkgaXMgcmVmcmVzaGVkIHNlcGFyYXRl
bHkuDQo+IC0tLQ0KPiAgZG9jL21lc2gtYXBpLnR4dCB8ICA4ICsrKystLS0tDQo+ICBtZXNoL25v
ZGUuYyAgICAgIHwgMTIgKysrKysrKystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL21lc2gtYXBp
LnR4dCBiL2RvYy9tZXNoLWFwaS50eHQNCj4gaW5kZXggN2ZiYWIzMmI2Li4wZjEwYTdjODkgMTAw
NjQ0DQo+IC0tLSBhL2RvYy9tZXNoLWFwaS50eHQNCj4gKysrIGIvZG9jL21lc2gtYXBpLnR4dA0K
PiBAQCAtNDMxLDExICs0MzEsMTEgQEAgUHJvcGVydGllczoNCj4gIAkJVGhpcyBwcm9wZXJ0eSBp
bmRpY2F0ZXMgd2hldGhlciB0aGUgcGVyaW9kaWMgYmVhY29uaW5nIGlzDQo+ICAJCWVuYWJsZWQg
KHRydWUpIG9yIGRpc2FibGVkIChmYWxzZSkuDQo+ICANCj4gLQl1aW50OCBCZWFjb25GbGFncyBb
cmVhZC1vbmx5XQ0KPiArCWJvb2xlYW4gSXZVcGRhdGUgW3JlYWQtb25seV0NCj4gIA0KPiAtCQlU
aGlzIHByb3BlcnR5IG1heSBiZSByZWFkIGF0IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUgZmxh
Zw0KPiAtCQlmaWVsZCBzZXR0aW5nIG9uIHNlbnQgYW5kIHJlY2VpdmVkIGJlYWNvbnMgb2YgdGhl
IHByaW1hcnkNCj4gLQkJbmV0d29yayBrZXkuDQo+ICsJCVdoZW4gdHJ1ZSwgaW5kaWNhdGVzIHRo
YXQgdGhlIG5ldHdvcmsgaXMgaW4gdGhlIG1pZGRsZSBvZiBJVg0KPiArCQlJbmRleCBVcGRhdGUg
cHJvY2VkdXJlLiBUaGlzIGluZm9ybWF0aW9uIGlzIG9ubHkgdXNlZnVsIGZvcg0KPiArCQlwcm92
aXNpb25pbmcuDQo+ICANCj4gIAl1aW50MzIgSXZJbmRleCBbcmVhZC1vbmx5XQ0KPiAgDQo+IGRp
ZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDYxNDBmZGY5Zi4u
ODdjM2JiNDZmIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUu
Yw0KPiBAQCAtMzIsNiArMzIsNyBAQA0KPiAgI2luY2x1ZGUgIm1lc2gvbWVzaC1kZWZzLmgiDQo+
ICAjaW5jbHVkZSAibWVzaC9tZXNoLmgiDQo+ICAjaW5jbHVkZSAibWVzaC9uZXQuaCINCj4gKyNp
bmNsdWRlICJtZXNoL25ldC1rZXlzLmgiDQo+ICAjaW5jbHVkZSAibWVzaC9hcHBrZXkuaCINCj4g
ICNpbmNsdWRlICJtZXNoL21lc2gtY29uZmlnLmgiDQo+ICAjaW5jbHVkZSAibWVzaC9wcm92aXNp
b24uaCINCj4gQEAgLTIxODMsNyArMjE4NCw3IEBAIHN0YXRpYyBib29sIGJlYWNvbl9nZXR0ZXIo
c3RydWN0IGxfZGJ1cyAqZGJ1cywgc3RydWN0IGxfZGJ1c19tZXNzYWdlICptc2csDQo+ICAJcmV0
dXJuIHRydWU7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBib29sIGJlYWNvbmZsYWdzX2dldHRlcihz
dHJ1Y3QgbF9kYnVzICpkYnVzLCBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZywNCj4gK3N0YXRp
YyBib29sIGl2dXBkYXRlX2dldHRlcihzdHJ1Y3QgbF9kYnVzICpkYnVzLCBzdHJ1Y3QgbF9kYnVz
X21lc3NhZ2UgKm1zZywNCj4gIAkJCQkJc3RydWN0IGxfZGJ1c19tZXNzYWdlX2J1aWxkZXIgKmJ1
aWxkZXIsDQo+ICAJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4gIHsNCj4gQEAgLTIxOTEsMTAgKzIx
OTIsMTMgQEAgc3RhdGljIGJvb2wgYmVhY29uZmxhZ3NfZ2V0dGVyKHN0cnVjdCBsX2RidXMgKmRi
dXMsIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbXNnLA0KPiAgCXN0cnVjdCBtZXNoX25ldCAqbmV0
ID0gbm9kZV9nZXRfbmV0KG5vZGUpOw0KPiAgCXVpbnQ4X3QgZmxhZ3M7DQo+ICAJdWludDMyX3Qg
aXZfaW5kZXg7DQo+ICsJYm9vbCBpdnU7DQo+ICANCj4gIAltZXNoX25ldF9nZXRfc25iX3N0YXRl
KG5ldCwgJmZsYWdzLCAmaXZfaW5kZXgpOw0KPiAgDQo+IC0JbF9kYnVzX21lc3NhZ2VfYnVpbGRl
cl9hcHBlbmRfYmFzaWMoYnVpbGRlciwgJ3knLCAmZmxhZ3MpOw0KPiArCWl2dSA9IGZsYWdzICYg
SVZfSU5ERVhfVVBEQVRFOw0KPiArDQo+ICsJbF9kYnVzX21lc3NhZ2VfYnVpbGRlcl9hcHBlbmRf
YmFzaWMoYnVpbGRlciwgJ2InLCAmaXZ1KTsNCj4gIA0KPiAgCXJldHVybiB0cnVlOw0KPiAgfQ0K
PiBAQCAtMjI5NSw4ICsyMjk5LDggQEAgc3RhdGljIHZvaWQgc2V0dXBfbm9kZV9pbnRlcmZhY2Uo
c3RydWN0IGxfZGJ1c19pbnRlcmZhY2UgKmlmYWNlKQ0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfcHJv
cGVydHkoaWZhY2UsICJGZWF0dXJlcyIsIDAsICJhe3N2fSIsIGZlYXR1cmVzX2dldHRlciwNCj4g
IAkJCQkJCQkJCU5VTEwpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfcHJvcGVydHkoaWZhY2UsICJC
ZWFjb24iLCAwLCAiYiIsIGJlYWNvbl9nZXR0ZXIsIE5VTEwpOw0KPiAtCWxfZGJ1c19pbnRlcmZh
Y2VfcHJvcGVydHkoaWZhY2UsICJCZWFjb25GbGFncyIsIDAsICJ5IiwNCj4gLQkJCQkJCWJlYWNv
bmZsYWdzX2dldHRlciwgTlVMTCk7DQo+ICsJbF9kYnVzX2ludGVyZmFjZV9wcm9wZXJ0eShpZmFj
ZSwgIkl2VXBkYXRlIiwgMCwgImIiLCBpdnVwZGF0ZV9nZXR0ZXIsDQo+ICsJCQkJCQkJCQlOVUxM
KTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX3Byb3BlcnR5KGlmYWNlLCAiSXZJbmRleCIsIDAsICJ1
IiwgaXZpbmRleF9nZXR0ZXIsDQo+ICAJCQkJCQkJCQlOVUxMKTsNCj4gIAlsX2RidXNfaW50ZXJm
YWNlX3Byb3BlcnR5KGlmYWNlLCAiU2VxdWVuY2VOdW1iZXIiLCAwLCAidSIsDQo=
