Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8747C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F8C20737
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YrXj50Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgFIOfg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:35:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:12841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFIOfd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:35:33 -0400
IronPort-SDR: 94U1HuDyqoEe1HJT+Ak8oh6LD5X/kmoNq6yNk/wVqnrI/S7gnB13JU/Cg8eRRGMYzjJJF7oyHa
 NCzXM3Qt3Tmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 07:35:21 -0700
IronPort-SDR: BHJIcbNCQHI0Ps6wbrY9ZhtiMRblT9qhFQf+MFsaoVvpOV9hc9a71u/GV/eeVaZhjAAaed5C3Y
 5gggwX3Nz38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="259009909"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 07:35:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 07:35:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 9 Jun 2020 07:35:20 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 07:35:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 07:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz2XVKZUn4pxib/Ze/q+54wfBuSNE2l5r2C/mfVpVw7sWv9Lm1dAUOL33pvXXaOoOaUcg6ZQ4eHP5dLF6wEjYFd1wOi/Q/0i6gfMmwFkUj9CWeeJp/puupBwVZYgHJ2Uyfly9T5/Pr4bZ4wjog4qHVswUEHmgLmjBSpXEqliIgI0e/SWeqLMKhnx9npENG3dgFbmpaX7dNI7Vtx/e8hayTa6nLgdZtmqRkIqByXK8PjIbAx2zio4TtQt/0f97RhgdU/J0t4A6q07eFFdXBB37GmA3YwkEVF3SEqjoMqzjzlhHg8UuZ6zK3ejqmj09V4icTP5YEUG933rujBBtQMElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwCmtNeBMBw5VuvE4ORA5D8MVCT1YQghFU98Y+pHo5c=;
 b=FP4KTMsE3nmNlyUrAoRNUNeklwFu4iQue1IZvA2TJF9FlIiikKjDE0NIlh2iYYti4eaM1V8KG9wrgMepC1xpjZGeH/ctMkg9NwVNno1MIfBXWcWkBRHcbFq243WVQ7BECje8F0USQC11savsC+RUiMx5VfP/91iymrwOxD2Zv1X3NNphMIBO77D0HP/s9ihRrobrFnJnkb2NNDl3hs9Ye+zYtrulcAvA+orvOkiK2tUDuLLQSb+Vwc0y5pLw4XfdXHcLr7q6te8YhRFXBhOqgru2O+UXGj05VI/KxG4evIUmpsjKA/EKqHxrQx4njFOnCoDh8XX9ChvTQjfqXoekGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwCmtNeBMBw5VuvE4ORA5D8MVCT1YQghFU98Y+pHo5c=;
 b=YrXj50KyJjWhoo6bYwfgpRurqGBKAQYjfMMZlKwGoPRco3f2WaqPL4ubulPTyDpfUISQ6n/hyUCUwBJPPy3edSBBin5M36IQym0ChkuQSBAweG4nmvV8lwUdoB4wSoNvPXwRlKQfiebOJDWRbDSduTYHH7Z90a354mQ1hbxUons=
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 14:35:16 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6%8]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:35:16 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
Subject: Re: [PATCH BlueZ 4/4] mesh: Add "node is busy" check for Leave()
 method
Thread-Topic: [PATCH BlueZ 4/4] mesh: Add "node is busy" check for Leave()
 method
Thread-Index: AQHWPhJchTJt116Dnk6FsUiB/wQfUqjQWj0A
Date:   Tue, 9 Jun 2020 14:35:16 +0000
Message-ID: <2834dda267bce2e21f195650dfb08ad148d234df.camel@intel.com>
References: <20200609035909.51061-1-inga.stotland@intel.com>
         <20200609035909.51061-5-inga.stotland@intel.com>
In-Reply-To: <20200609035909.51061-5-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 (3.36.3-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddb53ec5-217e-43ea-b69b-08d80c825403
x-ms-traffictypediagnostic: MW3PR11MB4666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4666537700ADC211C62BFB07FB820@MW3PR11MB4666.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kx4Kpi9rrDV2x9MGAPxcRPO0/o6zR2WjGiOhbbmmkApWDRt4kjoYwtjV1LIzfXgw7ojPRBg4ojsD9gE4J9wnKT3CYwarodr9U+De2J4v1NyUhCil0QAx5ru7i73krcEpcsTvn5tZTdimajxUV0WRXdi32Q1c+ZcIWnJDRUzBAc9+iG30u3feYUasD2C/RgDjwpSYm4J1k9kvdQjeRbrgMWICCxz7VgW5v2Jn8u29jag1VZZ/w6jkyfsMU5ohHUZSEfmzmvZzolgDMxUsAA7hFH8EIFd1HEamxUopCbqTcajwaWHlMWEFUbqtV7e28PQBw6KlDxLDN+670N9VCmZIBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(39860400002)(366004)(346002)(136003)(478600001)(26005)(6636002)(186003)(6506007)(6486002)(6512007)(37006003)(316002)(54906003)(4326008)(6862004)(86362001)(66476007)(8936002)(66446008)(66556008)(64756008)(76116006)(91956017)(83380400001)(66946007)(71200400001)(8676002)(5660300002)(2616005)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aSsb2pr+JwxXDSdbuAfb/kC6qKp1VZuaSGosp2nzOfg8Yu9w4ob5IP62eP4w/lYqKYzlW8rB7arsJlmkdL18MxYhNM0YO3aG5Ww7MCNJNDE/DOU5Lc7eSkXdX7lGkZihDLRBJC58yPw0dSpTvx+0wxj3iuUysjF2my9hEkWkicTC07MKBipTzfsMlWGVgDZ/Q6yspixYzRugOC+dgUfv8ZUwZdObBpYKb1HnRTpAtuQeudgEn+VfCrO9q/QJCsD/VAoG/3SJHePT7ryGGz8yjOn3CrhhzpOY8CrIDmW+dJJzeMJUW8d4tgCocSnkQZgQUpSTdqHird8f7WHIJPO6QuHJ5xy9jU1XzDAAdoD+/agGutZaCzg1bkPQA9eNQ9UVg81pBmjJbEg1trkXAj5UWUJ3INPO/afkj+Jfa61YdEZfB/75Z62nh3SqP2vTdvnqXPQIj9xf2CJYFF52AlB7Iq9hcM0FcEBemTCiVeGvctc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AAD17469041E94698B6C7EC481EEAB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb53ec5-217e-43ea-b69b-08d80c825403
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 14:35:16.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T047iiNZIb9a7M9JubIGqGLjJCjfl4IQ8SfpG9ro4E3RGExXukc1i3tBkWcHqT4pLZNw1Pza0jl0YBgPAgngpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGxlYXNlIGRpc3JlZ2FyZCB0aGlzIHBhdGNoLiBOZWVkcyBtb3JlIHRob3VnaHQuIFBhdGNoZXMg
MS0zIHN0aWxsDQpva2F5Lg0KDQpPbiBNb24sIDIwMjAtMDYtMDggYXQgMjA6NTkgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgaW50cm9kdWNlcyB0aGUgZm9sbG93aW5nIGJlaGF2
aW9yIGNoYW5nZSBmb3IgTGVhdmUoKSBtZXRob2Q6DQo+IA0KPiBJZiBMZWF2ZSBtZXRob2QgaXMg
Y2FsbGVkIGZvciBhIG5vZGUgdGhhdCBpcyBiZWluZyBwcm9jZXNzZWQgYXMgYSByZXN1bHQNCj4g
b2YgYSBDcmVhdGUsIEltcG9ydCwgSm9pbiBvciBBdHRhY2ggbWV0aG9kIGNhbGxzIGluIHByb2dy
ZXNzLCBub2RlIHJlbW92YWwNCj4gaXMgbm90IGFsbG93ZWQgYW5kIG9yZy5ibHVlei5tZXNoLkVy
cm9yLkJ1c3kgZXJyb3IgaXMgcmV0dXJuZWQuDQo+IC0tLQ0KPiAgZG9jL21lc2gtYXBpLnR4dCB8
ICAyICsrDQo+ICBtZXNoL21lc2guYyAgICAgIHwgIDUgKysrKy0NCj4gIG1lc2gvbm9kZS5jICAg
ICAgfCAxOSArKysrKysrKysrKysrKysrKy0tDQo+ICBtZXNoL25vZGUuaCAgICAgIHwgIDIgKy0N
Cj4gIDQgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kb2MvbWVzaC1hcGkudHh0IGIvZG9jL21lc2gtYXBpLnR4dA0KPiBp
bmRleCBlODVmMGJmNTIuLmIyZWFkYzM1NyAxMDA2NDQNCj4gLS0tIGEvZG9jL21lc2gtYXBpLnR4
dA0KPiArKysgYi9kb2MvbWVzaC1hcGkudHh0DQo+IEBAIC0xMjYsNiArMTI2LDggQEAgTWV0aG9k
czoNCj4gIA0KPiAgCQlQb3NzaWJsZUVycm9yczoNCj4gIAkJCW9yZy5ibHVlei5tZXNoLkVycm9y
LkludmFsaWRBcmd1bWVudHMNCj4gKwkJCW9yZy5ibHVlei5tZXNoLkVycm9yLk5vdEZvdW5kDQo+
ICsJCQlvcmcuYmx1ZXoubWVzaC5FcnJvci5CdXN5DQo+ICANCj4gIAl2b2lkIENyZWF0ZU5ldHdv
cmsob2JqZWN0IGFwcF9yb290LCBhcnJheXtieXRlfVsxNl0gdXVpZCkNCj4gIA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9tZXNoLmMgYi9tZXNoL21lc2guYw0KPiBpbmRleCBhNTkzNWMyMTYuLjBhOTMz
ZmZlZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLmMNCj4gKysrIGIvbWVzaC9tZXNoLmMNCj4g
QEAgLTY1NSwxMyArNjU1LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKmxlYXZl
X2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4g
IHsNCj4gIAl1aW50NjRfdCB0b2tlbjsNCj4gKwlpbnQgcmVzdWx0Ow0KPiAgDQo+ICAJbF9kZWJ1
ZygiTGVhdmUiKTsNCj4gIA0KPiAgCWlmICghbF9kYnVzX21lc3NhZ2VfZ2V0X2FyZ3VtZW50cyht
c2csICJ0IiwgJnRva2VuKSkNCj4gIAkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9S
X0lOVkFMSURfQVJHUywgTlVMTCk7DQo+ICANCj4gLQlub2RlX3JlbW92ZShub2RlX2ZpbmRfYnlf
dG9rZW4odG9rZW4pKTsNCj4gKwlyZXN1bHQgPSBub2RlX3JlbW92ZShub2RlX2ZpbmRfYnlfdG9r
ZW4odG9rZW4pKTsNCj4gKwlpZiAocmVzdWx0ICE9IE1FU0hfRVJST1JfTk9ORSkNCj4gKwkJcmV0
dXJuIGRidXNfZXJyb3IobXNnLCByZXN1bHQsIE5VTEwpOw0KPiAgDQo+ICAJcmV0dXJuIGxfZGJ1
c19tZXNzYWdlX25ld19tZXRob2RfcmV0dXJuKG1zZyk7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9t
ZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDdlYzA2NDM3Yi4uYTRjNjBjY2IxIDEw
MDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtODgs
NiArODgsNyBAQCBzdHJ1Y3QgbWVzaF9ub2RlIHsNCj4gIAljaGFyICpzdG9yYWdlX2RpcjsNCj4g
IAl1aW50MzJfdCBkaXNjX3dhdGNoOw0KPiAgCXVpbnQzMl90IHNlcV9udW1iZXI7DQo+ICsJYm9v
bCBidXN5Ow0KPiAgCWJvb2wgcHJvdmlzaW9uZXI7DQo+ICAJdWludDE2X3QgcHJpbWFyeTsNCj4g
IAlzdHJ1Y3Qgbm9kZV9jb21wb3NpdGlvbiBjb21wOw0KPiBAQCAtMzQ0LDE2ICszNDUsMjEgQEAg
c3RhdGljIHZvaWQgZnJlZV9ub2RlX3Jlc291cmNlcyh2b2lkICpkYXRhKQ0KPiAgICogVGhpcyBm
dW5jdGlvbiBpcyBjYWxsZWQgdG8gZnJlZSByZXNvdXJjZXMgYW5kIHJlbW92ZSB0aGUNCj4gICAq
IGNvbmZpZ3VyYXRpb24gZmlsZXMgZm9yIHRoZSBzcGVjaWZpZWQgbm9kZS4NCj4gICAqLw0KPiAt
dm9pZCBub2RlX3JlbW92ZShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAraW50IG5vZGVfcmVt
b3ZlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUpDQo+ICB7DQo+ICAJaWYgKCFub2RlKQ0KPiAtCQly
ZXR1cm47DQo+ICsJCXJldHVybiBNRVNIX0VSUk9SX05PVF9GT1VORDsNCj4gKw0KPiArCWlmIChu
b2RlLT5idXN5KQ0KPiArCQlyZXR1cm4gTUVTSF9FUlJPUl9CVVNZOw0KPiAgDQo+ICAJbF9xdWV1
ZV9yZW1vdmUobm9kZXMsIG5vZGUpOw0KPiAgDQo+ICAJbWVzaF9jb25maWdfZGVzdHJveV9udm0o
bm9kZS0+Y2ZnKTsNCj4gIA0KPiAgCWZyZWVfbm9kZV9yZXNvdXJjZXMobm9kZSk7DQo+ICsNCj4g
KwlyZXR1cm4gTUVTSF9FUlJPUl9OT05FOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgYm9vbCBhZGRf
bW9kZWxzX2Zyb21fc3RvcmFnZShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLA0KPiBAQCAtMTM1Miw2
ICsxMzU4LDggQEAgc3RhdGljIGJvb2wgYWRkX2xvY2FsX25vZGUoc3RydWN0IG1lc2hfbm9kZSAq
bm9kZSwgdWludDE2X3QgdW5pY2FzdCwgYm9vbCBrciwNCj4gIAkvKiBJbml0aWFsaXplIGNvbmZp
Z3VyYXRpb24gc2VydmVyIG1vZGVsICovDQo+ICAJY2ZnbW9kX3NlcnZlcl9pbml0KG5vZGUsIFBS
SU1BUllfRUxFX0lEWCk7DQo+ICANCj4gKwlub2RlLT5idXN5ID0gdHJ1ZTsNCj4gKw0KPiAgCXJl
dHVybiB0cnVlOw0KPiAgfQ0KPiAgDQo+IEBAIC0xNDU5LDYgKzE0NjcsOSBAQCBzdGF0aWMgdm9p
ZCBnZXRfbWFuYWdlZF9vYmplY3RzX2NiKHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbXNnLCB2b2lk
ICp1c2VyX2RhdGEpDQo+ICAJc3RydWN0IGtleXJpbmdfbmV0X2tleSBuZXRfa2V5Ow0KPiAgCXVp
bnQ4X3QgZGV2X2tleVsxNl07DQo+ICANCj4gKwlpZiAocmVxLT50eXBlID09IFJFUVVFU1RfVFlQ
RV9BVFRBQ0gpDQo+ICsJCXJlcS0+YXR0YWNoLT5idXN5ID0gZmFsc2U7DQo+ICsNCj4gIAlpZiAo
IW1zZyB8fCBsX2RidXNfbWVzc2FnZV9pc19lcnJvcihtc2cpKSB7DQo+ICAJCWxfZXJyb3IoIkZh
aWxlZCB0byBnZXQgYXBwJ3MgZGJ1cyBvYmplY3RzIik7DQo+ICAJCWdvdG8gZmFpbDsNCj4gQEAg
LTE2NzQsNiArMTY4NSw4IEBAIHZvaWQgbm9kZV9hdHRhY2goY29uc3QgY2hhciAqYXBwX3Jvb3Qs
IGNvbnN0IGNoYXIgKnNlbmRlciwgdWludDY0X3QgdG9rZW4sDQo+ICAJcmVxLT5hdHRhY2ggPSBu
b2RlOw0KPiAgCXJlcS0+dHlwZSA9IFJFUVVFU1RfVFlQRV9BVFRBQ0g7DQo+ICANCj4gKwlub2Rl
LT5idXN5ID0gdHJ1ZTsNCj4gKw0KPiAgCXNlbmRfbWFuYWdlZF9vYmplY3RzX3JlcXVlc3Qoc2Vu
ZGVyLCBhcHBfcm9vdCwgcmVxKTsNCj4gIH0NCj4gIA0KPiBAQCAtMjM0Nyw2ICsyMzYwLDggQEAg
dm9pZCBub2RlX2ZpbmFsaXplX25ld19ub2RlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHN0cnVj
dCBtZXNoX2lvICppbykNCj4gIAlmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMobm9kZSk7DQo+ICAJ
bWVzaF9hZ2VudF9yZW1vdmUobm9kZS0+YWdlbnQpOw0KPiAgDQo+ICsJbm9kZS0+YnVzeSA9IGZh
bHNlOw0KPiArDQo+ICAJLyogUmVnaXN0ZXIgY2FsbGJhY2sgZm9yIHRoZSBub2RlJ3MgaW8gKi8N
Cj4gIAlhdHRhY2hfaW8obm9kZSwgaW8pOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9ub2Rl
LmggYi9tZXNoL25vZGUuaA0KPiBpbmRleCBlMjZkNDEwYzguLmMyMDE2NzBiOCAxMDA2NDQNCj4g
LS0tIGEvbWVzaC9ub2RlLmgNCj4gKysrIGIvbWVzaC9ub2RlLmgNCj4gQEAgLTMwLDcgKzMwLDcg
QEAgdHlwZWRlZiB2b2lkICgqbm9kZV9yZWFkeV9mdW5jX3QpICh2b2lkICp1c2VyX2RhdGEsIGlu
dCBzdGF0dXMsDQo+ICB0eXBlZGVmIHZvaWQgKCpub2RlX2pvaW5fcmVhZHlfZnVuY190KSAoc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSwNCj4gIAkJCQkJCXN0cnVjdCBtZXNoX2FnZW50ICphZ2VudCk7
DQo+ICANCj4gLXZvaWQgbm9kZV9yZW1vdmUoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSk7DQo+ICtp
bnQgbm9kZV9yZW1vdmUoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSk7DQo+ICB2b2lkIG5vZGVfam9p
bihjb25zdCBjaGFyICphcHBfcm9vdCwgY29uc3QgY2hhciAqc2VuZGVyLCBjb25zdCB1aW50OF90
ICp1dWlkLA0KPiAgCQkJCQkJbm9kZV9qb2luX3JlYWR5X2Z1bmNfdCBjYik7DQo+ICB1aW50OF90
ICpub2RlX3V1aWRfZ2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUpOw0K
