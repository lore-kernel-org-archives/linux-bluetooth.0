Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B20C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406092080D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hjynxxl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgFRPlf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:41:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:42787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgFRPlS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 11:41:18 -0400
IronPort-SDR: FV32J1+6D7D+BtBtJniF7VWRLZ7jpgXcxw7en7n5c8dGt86oWQN//Xwgp3CQUoOEuXlA6SCcnJ
 c+h0U+UwVR5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="129980294"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="129980294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:41:16 -0700
IronPort-SDR: BiwZ69OM8EbQUdfpz/Xy8U8EJyTNCmLt4yzHHWGBto9zUHbSqgJQaLcViydPqE2ofH2jyXlau+
 X10DYAwZKwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="383555808"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2020 08:41:16 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:41:15 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:41:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTgb7IAPvKRanNAjIT4SMalKIFbo0VVFuelBCghdFqz/7kveyXUuLPk9SEoyIBDVDOwsg3HSX0MOaJ8OJ+4k3yL6Kj3XloLjmslSuxlZL7XXXVK7v8BxT0cflzwj2C98t0ibky/6WTlELoK3RrsqiiH4rVfSqM9LwJ/ioL0U6unCx4/nqW9aqYW1WkJ+h7AuoclMYGBzPviU15dVKVc9wO/wpR7NpGwq+9+dKXpOZuHws78piEZVXJchWhicM0TswNBZhJ82xW9vKrJtfoTDb4HBuYI17hiyHf3wHG9hK2ghy4G+jD/mB+IjsvCajQFpO7+ft2SmnwU5OixotGOiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFFYYyppdIrBF0EQkrC1RgCcmzDBl2Xk2CAtkUjWaU=;
 b=HvKhKyMCSuJg/4BOIYK6EyUnPn6FkyeeX96NS4682hw+e4xFZbhVvjvd5vlqWvEsQiQXIcF+KbxUhxyHGFfK40etnHWB5OaWbkRo4H1cQR4m/1cYvqq3Lw3dEgh/mGgDXoOWcFmq68ScZiXWUJd+Vi56SmpFNQVS4Y9fQy1tqzibEuMVJ8WA9/y5CtPsolsM56Iec6sewsYpqf3UikulvFbzPtagNRVzAYanUtpkGEGapkVof3lvLorlHb8qxbHupiFSfwwZ/vk7ZAG8TDRLkCpw7bruYOMk+WFFoKX/ek8F22CVZ3UNPOWOUsCucQaKb3upP+JyYwrynmchJpeTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFFYYyppdIrBF0EQkrC1RgCcmzDBl2Xk2CAtkUjWaU=;
 b=hjynxxl89uzcrVGVGVvnwjHxlCmU3hj+3I6jFy78hPHpntuyiDAM4DzZHS8ENNX/sbUOpDHV5ifP+GDdzoEYRbw2KZ0wVaUmpZ3XGAOueR8ZqCYniTZdKTh1skX8hbMzox7UeRrQaATW48zQ5A3HgTozBd4IesRo+ytrKceayVw=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR1101MB2110.namprd11.prod.outlook.com (2603:10b6:301:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 15:41:14 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 15:41:14 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Thread-Topic: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Thread-Index: AQHWRAoF4QbQWbpp20aM35Tw6qEvMKjehbaA
Date:   Thu, 18 Jun 2020 15:41:14 +0000
Message-ID: <f4c0a48f8d7c30b7c12bdcce84cf8ee172709daa.camel@intel.com>
References: <20200616181436.50319-1-brian.gix@intel.com>
In-Reply-To: <20200616181436.50319-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b3b638b-b6df-438f-ba35-08d8139e08af
x-ms-traffictypediagnostic: MWHPR1101MB2110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2110161EDEA2F85E55A63ABEE19B0@MWHPR1101MB2110.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3+pJ5KXFLTcsNIwQzrHMQ6sBZhqEHkDxDdg/TKrNWgGg5wFr27Zzd+Ml5fkRAaf9KerK0GzlWSHBpfEB0a1BdW2JfnBx0CI3CQEX4BeiPNAPcKTe/QqIP9Q6vVMxqmvQT1oC+0Jnql/YJuIcCxpQTeIdn5DuCvT10a4wnqEPlTBzGXrHhmAFcvtBNEYARpEVifuSEjsDsKeuayR7g4elg3epO69162rFm15F3dQLxQ6wDpUdi83l9CtfoCyMNwpeS+2oEtSvDx+zcoGEzt4C/TviBUyQmZKO/S+8cU2FAWN7xSjxaLDICXmkBSNu7IpayBqHNBYc6eSvJDOvn89Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(5660300002)(316002)(83380400001)(4326008)(6512007)(54906003)(8936002)(107886003)(478600001)(8676002)(6486002)(186003)(36756003)(2906002)(66946007)(66476007)(66556008)(6916009)(86362001)(2616005)(26005)(6506007)(76116006)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4DcfA7wlgINrZezR9pqMVeM6nns4NgL7JkBoosxPqoVAsWSZlW5sz0tfSt/QNbjAnhxVO+MNjG31sOP4A83ehZ1i3D5IVk1p7/U/FSFo/Uv64YznMVYGlSgx1iemq9gzHlfWsIHyxk5cDXqi6zhWAvEQ5TT1a5KyLldgw3EnKmweaUcm1CrWKqRv2EKew0bjS/6nCwdGHvUBDA83avXvlOAeUWv9yHoDwRw0aYWg0hF+XtLx388Pm7o1XZNPXnBgiqiB6FGMtOdq3288a0WYx813UYZQ36JAKdrQJacReWcZb2UHvMHRrYumDToOMQB84VyJdQJqsM3iZ3w8Z1FXVc0kDW3ivLV5nmkbVM8pgLuciNPAiJEen0J5WgpbImJ57D1t8FpR3ai2o6Mh1XxNuwECNFZlbVd78TAwxJ4EZT3reZ2kdEwiygqHV41FtvdA4Cch5UllqHW3WM11yUP8DmD+XX3CRKiaLs4Ppw7sC762Jwu7RAkewQphpgcdBYDN
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEE42F08A5CDD946B831C477F1870D58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3b638b-b6df-438f-ba35-08d8139e08af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:41:14.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY5XiCwSgUsR8uxaBQgbFxeu372k369qltY5QSUxqPnqnz1MT3V62Fr0fDVwgOUM3mlqvz1VVSSLV22FR/kIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2110
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTA2LTE2IGF0IDExOjE0IC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IFdlIHJlcXVpcmUgdGhlIHN1Y2Nlc3NmdWwgcmV0dXJuIG9mIEpvaW5Db21wbGV0ZSgp
IG1ldGhvZCBiZWZvcmUNCj4gaGFuZGxpbmcgc3Vic2VxdWVudCBBdHRhY2goKSBvciBMZWF2ZSgp
IG1ldGhvZCBjYWxscy4gVG8gc2ltcGxpZnkgdGhlDQo+IGNvbnN0cnVjdGlvbiBvZiBBcHBsaWNh
dGlvbnMsIHdlIHdpbGwgYWNjZXB0IG9uZSBvZiB0aGVzZSBjYWxscyB1cCB0byAxDQo+IHNlY29u
ZCBwcmlvciB0byByZWNlaXZpbmcgdGhlIGZpbmFsIHJldHVybiBzdGF0dXMgb2YgSm9pbkNvbXBs
ZXRlLA0KPiB3aGljaCB0ZWxscyB1cyB0aGF0IHRoZSBBcHBsaWNhdGlvbiBpcyByZWFkeSB0byB1
c2UgdGhlIG5vZGUuDQo+IA0KPiBJZiB0aGUgbm9kZSBpcyBzdGlsbCBub3QgcmVhZHkgYWZ0ZXIg
dGhlIGRlZmVycmFsLCBBdHRhY2ggYW5kL29yIExlYXZlDQo+IHdpbGwgZmFpbC4NCj4gLS0tDQo+
ICBtZXNoL21lc2guYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2guYyBiL21lc2gvbWVzaC5j
DQo+IGluZGV4IGFiMjM5M2RlYi4uYmMxNzAzNzFkIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2gu
Yw0KPiArKysgYi9tZXNoL21lc2guYw0KPiBAQCAtMTA0LDYgKzEwNCwxMCBAQCBzdGF0aWMgc3Ry
dWN0IGxfcXVldWUgKnBlbmRpbmdfcXVldWU7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICpz
dG9yYWdlX2RpcjsNCj4gIA0KPiArLyogRm9yd2FyZCBzdGF0aWMgZGVjYWxyYXRpb25zICovDQo+
ICtzdGF0aWMgdm9pZCBkZWZfYXR0YWNoKHN0cnVjdCBsX3RpbWVvdXQgKnRpbWVvdXQsIHZvaWQg
KnVzZXJfZGF0YSk7DQo+ICtzdGF0aWMgdm9pZCBkZWZfbGVhdmUoc3RydWN0IGxfdGltZW91dCAq
dGltZW91dCwgdm9pZCAqdXNlcl9kYXRhKTsNCj4gKw0KPiAgc3RhdGljIGJvb2wgc2ltcGxlX21h
dGNoKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo+ICB7DQo+ICAJcmV0dXJuIGEgPT0g
YjsNCj4gQEAgLTYzNCwxMiArNjM4LDI2IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2Ug
KmF0dGFjaF9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICAJdWludDY0X3QgdG9rZW47DQo+
ICAJY29uc3QgY2hhciAqYXBwX3BhdGgsICpzZW5kZXI7DQo+ICAJc3RydWN0IGxfZGJ1c19tZXNz
YWdlICpwZW5kaW5nX21zZzsNCj4gKwlzdHJ1Y3QgbWVzaF9ub2RlICpub2RlOw0KPiAgDQo+ICAJ
bF9kZWJ1ZygiQXR0YWNoIik7DQo+ICANCj4gIAlpZiAoIWxfZGJ1c19tZXNzYWdlX2dldF9hcmd1
bWVudHMobXNnLCAib3QiLCAmYXBwX3BhdGgsICZ0b2tlbikpDQo+ICAJCXJldHVybiBkYnVzX2Vy
cm9yKG1zZywgTUVTSF9FUlJPUl9JTlZBTElEX0FSR1MsIE5VTEwpOw0KPiAgDQo+ICsJbm9kZSA9
IG5vZGVfZmluZF9ieV90b2tlbih0b2tlbik7DQo+ICsJaWYgKCFub2RlKQ0KPiArCQlyZXR1cm4g
ZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfTk9UX0ZPVU5ELCAiQXR0YWNoIGZhaWxlZCIpOw0K
PiArDQo+ICsJaWYgKG5vZGVfaXNfYnVzeShub2RlKSkgew0KPiArCQlpZiAodXNlcl9kYXRhKQ0K
PiArCQkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX0JVU1ksIE5VTEwpOw0KPiAr
DQo+ICsJCS8qIFRyeSBvbmNlIG1vcmUgaW4gMSBzZWNvbmQgKi8NCj4gKwkJbF90aW1lb3V0X2Ny
ZWF0ZSgxLCBkZWZfYXR0YWNoLCBsX2RidXNfbWVzc2FnZV9yZWYobXNnKSwgTlVMTCk7DQo+ICsJ
CXJldHVybiBOVUxMOw0KPiArCX0NCj4gKw0KPiAgCXNlbmRlciA9IGxfZGJ1c19tZXNzYWdlX2dl
dF9zZW5kZXIobXNnKTsNCj4gIA0KPiAgCXBlbmRpbmdfbXNnID0gbF9kYnVzX21lc3NhZ2VfcmVm
KG1zZyk7DQo+IEBAIC02NTAsNiArNjY4LDE5IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3Nh
Z2UgKmF0dGFjaF9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICAJcmV0dXJuIE5VTEw7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGRlZl9hdHRhY2goc3RydWN0IGxfdGltZW91dCAqdGlt
ZW91dCwgdm9pZCAqdXNlcl9kYXRhKQ0KPiArew0KPiArCXN0cnVjdCBsX2RidXMgKmRidXMgPSBk
YnVzX2dldF9idXMoKTsNCj4gKwlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZyA9IHVzZXJfZGF0
YTsNCj4gKwlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnJlcGx5Ow0KPiArDQo+ICsJbF90aW1lb3V0
X3JlbW92ZSh0aW1lb3V0KTsNCj4gKw0KPiArCXJlcGx5ID0gYXR0YWNoX2NhbGwoZGJ1cywgbXNn
LCAodm9pZCAqKSB0cnVlKTsNCj4gKwlsX2RidXNfc2VuZChkYnVzLCByZXBseSk7DQo+ICsJbF9k
YnVzX21lc3NhZ2VfdW5yZWYobXNnKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBsX2Ri
dXNfbWVzc2FnZSAqbGVhdmVfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCQkJCQkJc3Ry
dWN0IGxfZGJ1c19tZXNzYWdlICptc2csDQo+ICAJCQkJCQl2b2lkICp1c2VyX2RhdGEpDQo+IEBA
IC02NjYsMTQgKzY5NywzMyBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpsZWF2ZV9j
YWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICAJaWYgKCFub2RlKQ0KPiAgCQlyZXR1cm4gZGJ1
c19lcnJvcihtc2csIE1FU0hfRVJST1JfTk9UX0ZPVU5ELCBOVUxMKTsNCj4gIA0KPiAtCWlmIChu
b2RlX2lzX2J1c3kobm9kZSkpDQo+IC0JCXJldHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJP
Ul9CVVNZLCBOVUxMKTsNCj4gKwlpZiAobm9kZV9pc19idXN5KG5vZGUpKSB7DQo+ICsJCWlmICh1
c2VyX2RhdGEpDQo+ICsJCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfQlVTWSwg
TlVMTCk7DQo+ICsNCj4gKwkJLyogVHJ5IG9uY2UgbW9yZSBpbiAxIHNlY29uZCAqLw0KPiArCQls
X3RpbWVvdXRfY3JlYXRlKDEsIGRlZl9sZWF2ZSwgbF9kYnVzX21lc3NhZ2VfcmVmKG1zZyksIE5V
TEwpOw0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKwl9DQo+ICANCj4gIAlub2RlX3JlbW92ZShub2Rl
KTsNCj4gIA0KPiAgCXJldHVybiBsX2RidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihtc2cp
Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkZWZfbGVhdmUoc3RydWN0IGxfdGltZW91dCAq
dGltZW91dCwgdm9pZCAqdXNlcl9kYXRhKQ0KPiArew0KPiArCXN0cnVjdCBsX2RidXMgKmRidXMg
PSBkYnVzX2dldF9idXMoKTsNCj4gKwlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZyA9IHVzZXJf
ZGF0YTsNCj4gKwlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnJlcGx5Ow0KPiArDQo+ICsJbF90aW1l
b3V0X3JlbW92ZSh0aW1lb3V0KTsNCj4gKw0KPiArCXJlcGx5ID0gbGVhdmVfY2FsbChkYnVzLCBt
c2csICh2b2lkICopIHRydWUpOw0KPiArCWxfZGJ1c19zZW5kKGRidXMsIHJlcGx5KTsNCj4gKwls
X2RidXNfbWVzc2FnZV91bnJlZihtc2cpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBjcmVh
dGVfam9pbl9jb21wbGV0ZV9yZXBseV9jYihzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZywNCj4g
IAkJCQkJCQkJdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0K
