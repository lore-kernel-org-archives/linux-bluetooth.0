Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9BCC33CB7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BD121734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 18:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Wm1JJUyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgAaSZQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:25:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:21561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAaSZP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jan 2020 13:25:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 10:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="324554128"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2020 10:25:15 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 10:25:14 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jan 2020 10:25:14 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 31 Jan 2020 10:25:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 31 Jan 2020 10:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y78vwEuxGQ8/WbNmgkDBpyKsqHd/YuYotNkp/eOhPJU/e12nAANdBzI6tlWvLsU+KIMno97LVHjzN86hO4ZBh0i1UFWvkoJrJoxRBDArggWlLT3GyPF0UNYRaHnMtZM++rVKz3D+SHZw9WxRjjeVjQ5ujIf9qgLHN7sxKXX9nbclH9hy+Yy+MXBg+PRyPN2TU1z2I15daPlzOYXpkdo6mtasRQfXpAJ5yVQ15ulpKbi6Y1QrjEviym0UuiAV9MuHBDSNZr8cyeqOXwWacvV6bFPi/Z6vjjaJ0sJ166G0yLvQa59CzBI3L9Yp1bs2EWcwPmML6gKdM7u2apPwRQD1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bGDT08RgO7y+GWIge1jxgUJTQPBFA0zov1RcnNL3Ro=;
 b=mKc8SQJvl3Xm+POwkXRjb6fORNpdJjViX5ZGxwgsZIBH5XRsZJyQWC+c1AYLa91G8j0UP5r32ZkuDsXULBkE8SYXnCrR1y0u7P09h9gh4ZdslYsPudBOCkUS26mOioW93lTNDTfkC914GTV9a1vTW1w5i/aHv6EVL+RU3XNZc0jacuzx1HCT2EwjBCFuKcQQ7JRVx8VKI4X+eFgENqWTUreuMZ0a10axmfihYenbOFNdwoncJP16KaeI0lF6sUd96l6q14L3A+dJ+EwCOcdp6Ig21BVG3gfbAMZnAQJnYSjyWRGDTHlSeDIZZ9CdFAdMhUjw4lUkqxEgMOPIVoqKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bGDT08RgO7y+GWIge1jxgUJTQPBFA0zov1RcnNL3Ro=;
 b=Wm1JJUyGk80tJKx/y7Ri/2QVOCD5Dnihc3GKziSkH5RI7jfIPx9jRyYvfru0FWhAgR9E16eksTq1A03amHBnvKT5xwQ/RuLOnMkFUCcMj/o+bzsUZ0Bc2HBxLQNJMUygQ3O14Fw3dmwaeC+R9A1QGONZQNDbrOHC7HvMzjX8maU=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2562.namprd11.prod.outlook.com (52.135.246.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 18:25:13 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 18:25:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Re-arrange replay protection check and add
Thread-Topic: [PATCH BlueZ] mesh: Re-arrange replay protection check and add
Thread-Index: AQHV1sgeMzXOXXlapUOcW5+ZsJGvDKgFGfwA
Date:   Fri, 31 Jan 2020 18:25:12 +0000
Message-ID: <f2d88ca114aa6ac2843f9dea810a872726760866.camel@intel.com>
References: <20200129171750.6456-1-brian.gix@intel.com>
In-Reply-To: <20200129171750.6456-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0dcec03-1948-4972-88b8-08d7a67ae98b
x-ms-traffictypediagnostic: BN7PR11MB2562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2562A9821CC7D8BEFF5FA4B3E1070@BN7PR11MB2562.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(6916009)(66476007)(107886003)(64756008)(66556008)(66446008)(66946007)(6486002)(2906002)(91956017)(76116006)(36756003)(2616005)(81156014)(186003)(8676002)(86362001)(4326008)(8936002)(316002)(81166006)(5660300002)(6506007)(478600001)(26005)(71200400001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2562;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oorP6fUAoPJzf9OWMhWFB3xnh4IWR/DB23OKS9fnZCc+/1vipJnNpjj+L7qL11uS8EBlPAqB2ezgxnafsEGPV6fQM2C8e4RXKovxv9CS+jwSTNsDqfRFpzKRekEuNit4+r0mO6SS9PBYnKMjdtSqZn7d/EOp6NDKeYB1Jy2MfGVABr7EhM0g0lWcY/RE6vG5Rr5yDSyEIG7EyQaS72nHFLBnvNWXYFoN+Uaql244hcEzidz68iPCmj9pgJ6z4rL9vUB4n3GgcOZSwg7aU6clDPPfitD/05l2KRo3MwcyZwc8Bb3P+ccHrG3YWgcsgiJt5FXkgtWL8ssxlwcIs7VWw5/uidF8T8xwQENG+KlWiQbrh3AwzVLZlbLgQ1MTIGD4w+wZgmG1X4/6fl0M/JipvGKAlCfoz/f0br+7FDtMkCrqX9F5pM86i0flXPjptStG
x-ms-exchange-antispam-messagedata: HTg/aqj2ltl70ePWcuI0+6UEpq3vv4VoP1ep2KnGaZ5k/4G/6fSSL7yidGl05gLP9OOp51A85+a9YBwJmz7Ksz1YmaRZuaydss9j0Ir6kjTu9N9YUw2JtkKENNVjctgjSE2cq9UX+I6yB7fOgNKFJw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE615D98016507499B8A90B77201BFB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dcec03-1948-4972-88b8-08d7a67ae98b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 18:25:12.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yB68VZlOU4qmJPpQWbJcKBKvEE3y1r/gxwgloTEeICXF0TgJgWGAg6H6S+uBxAcVCm4DiWY9tDM3ovTC4nOx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2562
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIHR3ZWVrcyBmcm9tIEluZ2ENCg0KT24gV2VkLCAyMDIwLTAxLTI5
IGF0IDA5OjE3IC0wODAwLCBCcmlhbiBHaXggd3JvdGU6DQo+IFJlLWFycmFuZ2VkIGZvciBlZmZp
Y2llbnRjeS4gUmVwbGF5IFByb3RlY3Rpb24gd2FzIHNldCB1cCBhcyBhbiBhdG9taWMNCj4gY2hl
Y2stYW5kLWFkZCBvcGVyYXRpb24uIE5vdyB3ZSBjaGVjayB0aGUgbWVzc2FnZSBlYXJseSBzbyB3
ZSBjYW4NCj4gZGlzY2FyZCBpdCB3aXRob3V0IHRha2luZyBmdXJ0aGVyIGFjdGlvbiwgYW5kIG9u
bHkgYWRkIGl0IHRvIHRoZSBSUEwNCj4gb25jZSBmdWxseSB2ZXJpZmllZCB0aGF0IGl0IHdhcyBh
dXRob3JpemVkIGFuZCBhZGRyZXNzZWQgdG8gdXMuDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwg
MjMgKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgbWVzaC9uZXQuYyAgIHwgNjIgKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9uZXQuaCAg
IHwgIDcgKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDQ3IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbW9kZWwuYyBiL21lc2gvbW9kZWwu
Yw0KPiBpbmRleCA5MmEwMDQ5NmMuLjU3NGI2NjIxYSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tb2Rl
bC5jDQo+ICsrKyBiL21lc2gvbW9kZWwuYw0KPiBAQCAtOTY0LDEwICs5NjQsMTIgQEAgYm9vbCBt
ZXNoX21vZGVsX3J4KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGJvb2wgc3ptaWN0LCB1aW50MzJf
dCBzZXEwLA0KPiAgCQkvKiBVbmljYXN0IGFuZCBub3QgYWRkcmVzc2VkIHRvIHVzICovDQo+ICAJ
CXJldHVybiBmYWxzZTsNCj4gIA0KPiAtCWNsZWFyX3RleHQgPSBsX21hbGxvYyhzaXplKTsNCj4g
LQlpZiAoIWNsZWFyX3RleHQpDQo+ICsJLyogRG9uJ3QgcHJvY2VzcyBpZiBhbHJlYWR5IGluIFJQ
TCAqLw0KPiArCWNycGwgPSBub2RlX2dldF9jcnBsKG5vZGUpOw0KPiArCWlmIChuZXRfbXNnX2No
ZWNrX3JlcGxheV9jYWNoZShuZXQsIHNyYywgY3JwbCwgc2VxLCBpdl9pbmRleCkpDQo+ICAJCXJl
dHVybiBmYWxzZTsNCj4gIA0KPiArCWNsZWFyX3RleHQgPSBsX21hbGxvYyhzaXplKTsNCj4gIAlm
b3J3YXJkLmRhdGEgPSBjbGVhcl90ZXh0Ow0KPiAgDQo+ICAJLyoNCj4gQEAgLTk5NSwxNiArOTk3
LDYgQEAgYm9vbCBtZXNoX21vZGVsX3J4KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGJvb2wgc3pt
aWN0LCB1aW50MzJfdCBzZXEwLA0KPiAgCQlnb3RvIGRvbmU7DQo+ICAJfQ0KPiAgDQo+IC0JLyog
cHJpbnRfcGFja2V0KCJDbHIgUnggKHByZS1jYWNoZS1jaGVjaykiLCBjbGVhcl90ZXh0LCBzaXpl
IC0gNCk7ICovDQo+IC0NCj4gLQljcnBsID0gbm9kZV9nZXRfY3JwbChub2RlKTsNCj4gLQ0KPiAt
CWlmIChuZXRfbXNnX2luX3JlcGxheV9jYWNoZShuZXQsICh1aW50MTZfdCkgZGVjcnlwdF9pZHgs
IHNyYywNCj4gLQkJCQljcnBsLCBzZXEsIGl2X2luZGV4KSkgew0KPiAtCQlyZXN1bHQgPSB0cnVl
Ow0KPiAtCQlnb3RvIGRvbmU7DQo+IC0JfQ0KPiAtDQo+ICAJcHJpbnRfcGFja2V0KCJDbHIgUngi
LCBjbGVhcl90ZXh0LCBzaXplIC0gKHN6bWljdCA/IDggOiA0KSk7DQo+ICANCj4gIAlmb3J3YXJk
LnZpcnQgPSBkZWNyeXB0X3ZpcnQ7DQo+IEBAIC0xMDczLDcgKzEwNjUsNyBAQCBib29sIG1lc2hf
bW9kZWxfcngoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgYm9vbCBzem1pY3QsIHVpbnQzMl90IHNl
cTAsDQo+ICAJCSAqIEVpdGhlciB0aGUgbWVzc2FnZSBoYXMgYmVlbiBwcm9jZXNzZWQgaW50ZXJu
YWxseSBvcg0KPiAgCQkgKiBoYXMgYmVlbiBwYXNzZWQgb24gdG8gYW4gZXh0ZXJuYWwgbW9kZWwu
DQo+ICAJCSAqLw0KPiAtCQlyZXN1bHQgPSBmb3J3YXJkLmhhc19kc3QgfCBmb3J3YXJkLmRvbmU7
DQo+ICsJCXJlc3VsdCB8PSBmb3J3YXJkLmhhc19kc3QgfCBmb3J3YXJkLmRvbmU7DQo+ICANCj4g
IAkJLyogSWYgdGhlIG1lc3NhZ2Ugd2FzIHRvIHVuaWNhc3QgYWRkcmVzcywgd2UgYXJlIGRvbmUg
Ki8NCj4gIAkJaWYgKCFpc19zdWJzY3JpcHRpb24gJiYgZWxlX2lkeCA9PSBpKQ0KPiBAQCAtMTA4
OCw4ICsxMDgwLDEzIEBAIGJvb2wgbWVzaF9tb2RlbF9yeChzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
LCBib29sIHN6bWljdCwgdWludDMyX3Qgc2VxMCwNCj4gIAkJCWJyZWFrOw0KPiAgCX0NCj4gIA0K
PiArCS8qIElmIHRoaXMgbWVzc2FnZSBoYW5kbGFibGUgYnkgdXMsIGFkZCB0byBSUEwgKi8NCj4g
KwlpZiAocmVzdWx0KQ0KPiArCQluZXRfbXNnX2FkZF9yZXBsYXlfY2FjaGUobmV0LCBzcmMsIHNl
cSwgaXZfaW5kZXgpOw0KPiArDQo+ICBkb25lOg0KPiAgCWxfZnJlZShjbGVhcl90ZXh0KTsNCj4g
Kw0KPiAgCXJldHVybiByZXN1bHQ7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0
LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDE5ZjNiODdiNy4uZDg1ZGY2M2RhIDEwMDY0NA0KPiAt
LS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTM3NTksOSArMzc1OSw4
IEBAIHN0YXRpYyBib29sIGNsZWFuX29sZF9pdl9pbmRleCh2b2lkICphLCB2b2lkICpiKQ0KPiAg
CXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiAtYm9vbCBuZXRfbXNnX2luX3JlcGxheV9jYWNo
ZShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgaWR4LA0KPiAtCQkJCXVpbnQxNl90IHNy
YywgdWludDE2X3QgY3JwbCwgdWludDMyX3Qgc2VxLA0KPiAtCQkJCXVpbnQzMl90IGl2X2luZGV4
KQ0KPiArYm9vbCBuZXRfbXNnX2NoZWNrX3JlcGxheV9jYWNoZShzdHJ1Y3QgbWVzaF9uZXQgKm5l
dCwgdWludDE2X3Qgc3JjLA0KPiArCQkJCXVpbnQxNl90IGNycGwsIHVpbnQzMl90IHNlcSwgdWlu
dDMyX3QgaXZfaW5kZXgpDQo+ICB7DQo+ICAJc3RydWN0IG1lc2hfcnBsICpycGU7DQo+ICANCj4g
QEAgLTM3ODIsNDkgKzM3ODEsNTAgQEAgYm9vbCBuZXRfbXNnX2luX3JlcGxheV9jYWNoZShzdHJ1
Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgaWR4LA0KPiAgCQkJCQkJTF9VSU5UX1RPX1BUUihz
cmMpKTsNCj4gIA0KPiAgCWlmIChycGUpIHsNCj4gLQkJaWYgKGl2X2luZGV4ID4gcnBlLT5pdl9p
bmRleCkgew0KPiAtCQkJcnBlLT5zZXEgPSBzZXE7DQo+IC0JCQlycGUtPml2X2luZGV4ID0gaXZf
aW5kZXg7DQo+IC0JCQlycGxfcHV0X2VudHJ5KG5ldC0+bm9kZSwgc3JjLCBpdl9pbmRleCwgc2Vx
KTsNCj4gKwkJaWYgKGl2X2luZGV4ID4gcnBlLT5pdl9pbmRleCkNCj4gIAkJCXJldHVybiBmYWxz
ZTsNCj4gLQkJfQ0KPiAtDQo+IC0JCWlmIChzZXEgPCBycGUtPnNlcSkgew0KPiAtCQkJbF9kZWJ1
ZygiSWdub3JpbmcgcGFja2V0IHdpdGggbG93ZXIgc2VxdWVuY2UgbnVtYmVyIik7DQo+IC0JCQly
ZXR1cm4gdHJ1ZTsNCj4gLQkJfQ0KPiAgDQo+IC0JCWlmIChzZXEgPT0gcnBlLT5zZXEpIHsNCj4g
LQkJCWxfZGVidWcoIk1lc3NhZ2UgYWxyZWFkeSBwcm9jZXNzZWQgKGR1cGxpY2F0ZSkiKTsNCj4g
KwkJLyogcmV0dXJuIHRydWUgaWYgKGl2X2luZGV4IHwgc2VxKSB0b28gbG93ICovDQo+ICsJCWlm
IChpdl9pbmRleCA8IHJwZS0+aXZfaW5kZXggfHwgc2VxIDw9IHJwZS0+c2VxKSB7DQo+ICsJCQls
X2RlYnVnKCJJZ25vcmluZyByZXBsYXllZCBwYWNrZXQiKTsNCj4gIAkJCXJldHVybiB0cnVlOw0K
PiAgCQl9DQo+IC0NCj4gLQkJcnBlLT5zZXEgPSBzZXE7DQo+IC0NCj4gLQkJcnBsX3B1dF9lbnRy
eShuZXQtPm5vZGUsIHNyYywgaXZfaW5kZXgsIHNlcSk7DQo+IC0NCj4gLQkJcmV0dXJuIGZhbHNl
Ow0KPiAgCX0NCj4gIA0KPiAtCWxfZGVidWcoIk5ldyBFbnRyeSBmb3IgJTQuNHgiLCBzcmMpOw0K
PiAtDQo+IC0JLyogUmVwbGF5IENhY2hlIGlzIGZpeGVkIHNpemVkICovDQo+IC0JaWYgKGxfcXVl
dWVfbGVuZ3RoKG5ldC0+cmVwbGF5X2NhY2hlKSA+PSBjcnBsKSB7DQo+ICsJLyogU1JDIG5vdCBp
biBSZXBsYXkgQ2FjaGUuLi4gc2VlIGlmIHRoZXJlIGlzIHNwYWNlIGZvciBpdCAqLw0KPiArCWVs
c2UgaWYgKGxfcXVldWVfbGVuZ3RoKG5ldC0+cmVwbGF5X2NhY2hlKSA+PSBjcnBsKSB7DQo+ICAJ
CWludCByZXQgPSBsX3F1ZXVlX2ZvcmVhY2hfcmVtb3ZlKG5ldC0+cmVwbGF5X2NhY2hlLA0KPiAg
CQkJCWNsZWFuX29sZF9pdl9pbmRleCwgTF9VSU5UX1RPX1BUUihpdl9pbmRleCkpOw0KPiAgDQo+
ICsJCS8qIFJldHVybiB0cnVlIGlmIG5vIHNwYWNlIGNvdWxkIGJlIGZyZWVkICovDQo+ICAJCWlm
ICghcmV0KQ0KPiAgCQkJcmV0dXJuIHRydWU7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKCFycGxfcHV0
X2VudHJ5KG5ldC0+bm9kZSwgc3JjLCBpdl9pbmRleCwgc2VxKSkNCj4gLQkJcmV0dXJuIHRydWU7
DQo+ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICt2b2lkIG5ldF9tc2dfYWRkX3JlcGxh
eV9jYWNoZShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3Qgc3JjLCB1aW50MzJfdCBzZXEs
DQo+ICsJCQkJCQkJdWludDMyX3QgaXZfaW5kZXgpDQo+ICt7DQo+ICsJc3RydWN0IG1lc2hfcnBs
ICpycGU7DQo+ICsNCj4gKwlpZiAoIW5ldCB8fCAhbmV0LT5ub2RlIHx8ICFuZXQtPnJlcGxheV9j
YWNoZSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJcnBlID0gbF9xdWV1ZV9yZW1vdmVfaWYobmV0
LT5yZXBsYXlfY2FjaGUsIG1hdGNoX3JlcGxheV9jYWNoZSwNCj4gKwkJCQkJCUxfVUlOVF9UT19Q
VFIoc3JjKSk7DQo+ICsNCj4gKwlpZiAoIXJwZSkgew0KPiArCQlsX2RlYnVnKCJOZXcgRW50cnkg
Zm9yICU0LjR4Iiwgc3JjKTsNCj4gKwkJcnBlID0gbF9uZXcoc3RydWN0IG1lc2hfcnBsLCAxKTsN
Cj4gKwkJcnBlLT5zZXEgPSBzcmM7DQo+ICsJfQ0KPiAgDQo+IC0JcnBlID0gbF9uZXcoc3RydWN0
IG1lc2hfcnBsLCAxKTsNCj4gLQlycGUtPnNyYyA9IHNyYzsNCj4gIAlycGUtPnNlcSA9IHNlcTsN
Cj4gIAlycGUtPml2X2luZGV4ID0gaXZfaW5kZXg7DQo+IC0JbF9xdWV1ZV9wdXNoX2hlYWQobmV0
LT5yZXBsYXlfY2FjaGUsIHJwZSk7DQo+ICsJcnBsX3B1dF9lbnRyeShuZXQtPm5vZGUsIHNyYywg
aXZfaW5kZXgsIHNlcSk7DQo+ICANCj4gLQlyZXR1cm4gZmFsc2U7DQo+ICsJLyogT3B0aW1pemUg
c28gdGhhdCBtb3N0IHJlY2VudCBjb252ZXJzYXRpb25zIHN0YXkgZWFybGllc3QgaW4gY2FjaGUg
Ki8NCj4gKwlsX3F1ZXVlX3B1c2hfaGVhZChuZXQtPnJlcGxheV9jYWNoZSwgcnBlKTsNCj4gIH0N
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmggYi9tZXNoL25ldC5oDQo+IGluZGV4IGZmMGE5YmIy
Yi4uNmZlZGQ2OWQ3IDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5oDQo+ICsrKyBiL21lc2gvbmV0
LmgNCj4gQEAgLTM3OSw2ICszNzksNyBAQCB2b2lkIG1lc2hfbmV0X3NldF9wcm92KHN0cnVjdCBt
ZXNoX25ldCAqbmV0LCBzdHJ1Y3QgbWVzaF9wcm92ICpwcm92KTsNCj4gIHVpbnQzMl90IG1lc2hf
bmV0X2dldF9pbnN0YW50KHN0cnVjdCBtZXNoX25ldCAqbmV0KTsNCj4gIHN0cnVjdCBsX3F1ZXVl
ICptZXNoX25ldF9nZXRfZnJpZW5kcyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCk7DQo+ICBzdHJ1Y3Qg
bF9xdWV1ZSAqbWVzaF9uZXRfZ2V0X25lZ290aWF0aW9ucyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCk7
DQo+IC1ib29sIG5ldF9tc2dfaW5fcmVwbGF5X2NhY2hlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1
aW50MTZfdCBpZHgsDQo+IC0JCQkJdWludDE2X3Qgc3JjLCB1aW50MTZfdCBjcnBsLCB1aW50MzJf
dCBzZXEsDQo+IC0JCQkJdWludDMyX3QgaXZfaW5kZXgpOw0KPiArYm9vbCBuZXRfbXNnX2NoZWNr
X3JlcGxheV9jYWNoZShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3Qgc3JjLA0KPiArCQkJ
CXVpbnQxNl90IGNycGwsIHVpbnQzMl90IHNlcSwgdWludDMyX3QgaXZfaW5kZXgpOw0KPiArdm9p
ZCBuZXRfbXNnX2FkZF9yZXBsYXlfY2FjaGUoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90
IHNyYywgdWludDMyX3Qgc2VxLA0KPiArCQkJCQkJCXVpbnQzMl90IGl2X2luZGV4KTsNCg==
