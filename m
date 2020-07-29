Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C92EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0032075D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 19:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IzqVh0O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2TAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:00:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:43521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2TAV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jul 2020 15:00:21 -0400
IronPort-SDR: n9upjyvRNFOQ76IexNv6WYtpPs+y31X29J5CHbB3BecT+WfhIRlASkBigR9Ae4UsUakoGoBDUg
 yoM5wXueaMVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139012151"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="139012151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 12:00:20 -0700
IronPort-SDR: VR4hlc29uoHnLLljoMlXCp0JTTR87mEC+47lDO3m8QebynPgyFBpFwVlKKlrWVtgCl1bCG+n/K
 8CP6Ggo1pKwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="364936755"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2020 12:00:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jul 2020 12:00:14 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 12:00:11 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 Jul 2020 12:00:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 29 Jul 2020 12:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5YiF8timS+0JZksA8QpdP3mrKMbG3GaaCClDb8rpgE9rE5G4mHTvob31hEEX6xFuOSn0Jvvk43YE8WG0jDfhTwLZATaflCl+Bg/o7vLxAb9CcVH+nrSJpiZtcZTEyz1jzP3WQNqY6ZbBw0IG8DWMbYVTjxfjndTg+H7KOqnd0i/vBGG6KcNdOoJZMlv3tM1umcO1aehGhboajqV+0te4H4gLLr289iFbAhItGEXXFdXHn50vgK/mRyT3PtQrI/DlcGoATV/odH7AZkmGlo21LAO7ARZqTVvxlWN+UiPrf4XKIBaSPG8ePh9m6e/8OfDisgsHrmZXHMdGPdOMnPqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMGSaUZv+GwxbM75J8qwHnvLuqkL59Ol4IizClQbXNU=;
 b=FEXLMMYNMFegwrQJWUnvanLmK1zdKK5KEek+VFSTicBToQyDisHfxi/aVSIcQQxev8bOTf8IRN2GojYp1kT4ZhsWDxnQwSL9FTRARCwYQCz/COeqPtTk41eaARelc2AcbwQlJfaRx3L+SCwU4h3CzwnKLVnYyeek3Tifl676HvIDF5sVtuCcHEPbXAHn68/JUutxs2HeVHWrbcInQuP5csvwAH8IW4ozS/1Gv9Iuw4XJszg+oTEiEnE5h85/kn02pDKcqtB7DtGJWkeVLr3RR+Sbx/UIxa3Azoj7kmj9USCXJknAdGp4UQCYzzfw+qIVtTq7wSyRVa6nQeIzupke9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMGSaUZv+GwxbM75J8qwHnvLuqkL59Ol4IizClQbXNU=;
 b=IzqVh0O3t6Nt8mQ6Mqh0D3us4JJ1tl/v5NoeLUfKl6kVbp0VRfMvnR/kuSpW0Y6pLGFcctAkJqDt3rCGMe8VRsdH3Th9V4sM4kqWi3sZb10OPOCS2edNBp3ecDYI6pPmPOyhCNrT1gqL2ooCpltqIGJcIuUla1iu+DNA/HHAUMc=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1792.namprd11.prod.outlook.com (2603:10b6:300:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 19:00:06 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 19:00:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix calculation of model publication period
Thread-Topic: [PATCH BlueZ] mesh: Fix calculation of model publication period
Thread-Index: AQHWZQp4nxpLU+HfMEalOO9lNtaAUqke6toA
Date:   Wed, 29 Jul 2020 19:00:05 +0000
Message-ID: <c0cacac96a78fbc11162df2fea419c9d48d01524.camel@intel.com>
References: <20200728181051.22075-1-inga.stotland@intel.com>
In-Reply-To: <20200728181051.22075-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 625592b1-7dff-4cf8-7a54-08d833f19b5f
x-ms-traffictypediagnostic: MWHPR11MB1792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1792C9EAE325C0ECC8640C82E1700@MWHPR11MB1792.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0uC+nGiY0l+uRhL01UTGolagSR9EDGwJOitX7DN+I6WDhVL/goTicqPDOkFJjgVvwPbm14VrEyZbrSe/hJWFH2mLGK5R2nZfZyZMQQyiCY39foHJPIuBiZF3vDiEh10OpPx60Yg+j+WfnIepEidxS/+IpGNmafVsIke0WImujdrHl/zHQ9QJIyqsM32BCo0tl6GQqz4opVNSSMPJA3PI70lyvBOCsjd1hHazhXQzhbmdupoPrZJghysq/bujB3F5Nppird4sD5EWNjaMyUFTFoHTZAOA1nviYE4WAhUNdVQ25VTfUPJ5P6guMpq5hB3V9QUaz1umY+2MVR11CJrKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(83380400001)(26005)(71200400001)(6486002)(478600001)(186003)(36756003)(5660300002)(2616005)(6636002)(64756008)(76116006)(316002)(2906002)(6506007)(6512007)(110136005)(66476007)(66556008)(86362001)(66946007)(66446008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Kz9CklAf6OOXbJIZrXTpWslvW5eTnaY20Lz0OUHXo6prdKroobOeppTzKLb41dIxtvGq3nCscN7CsVln+eqz5FLrZtrQVOfAfi7w97/gKiLFRNmlnbpmKa6BCKsAp+LgOlsaoGaalxnazijE9A8TQyQcuM7G20j4+OeGieTgY7rugcKuwRDtFQ7UtTIk8Fz0UbCMrkr6iPI2cWcuhM1FVJVfkSLVq3M6vY5X3CB26dnz8IHWCK9A7xXBa5+ohswuzLBwP6dRkkiFgUHUlU4xn/rSdQ4vFC1huOrQcrSkxRAVooztjzISWiXGXKD5RZAW9T+Zc4WqL1x0Kr6xfIN8f+wh9YwXfw0r8Uzu3BKx4TNhGQBoMYKd1W1B9D71A32X6f9Pr1Yy9RJo955zDS2z/r8OzP7A1cFTrIChUwa929s1iNAj5ivYKSwXMOnQsj0H2aPa6VfmIIo00kmGpCMjd6Y1O+o2y/OPfiRdn6hAM4aMSzbGOj8SbooIyVl5k72h
Content-Type: text/plain; charset="utf-8"
Content-ID: <50B7FBDDB810A648AFFCDC382286C825@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625592b1-7dff-4cf8-7a54-08d833f19b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 19:00:05.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra95I4nVuWTRT2vficIahqeoFr+s7o5j3YctT1dYdNz+ywgqJzvPKoeHNRYu2tnRlht48IS/CVoD50bhgjd3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1792
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTA3LTI4IGF0IDExOjEwIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIHRoZSBleHRyYWN0aW9uIG9mIGJpdCBmaWVsZHMgZnJvbSBt
b2RlbCBwdWJsaWNhdGlvbg0KPiBwZXJpb2Qgb2N0ZXQgcmVjZWl2ZWQgYXMgcGFydCBvZiBDb25n
aWYgUHVibGljYXRpb24gU2V0IG1lc3NhZ2UuDQo+IA0KPiBUaGUgc3RlcCByZXNvbHV0aW9uIGZp
ZWxkIGlzIGV4dHJhY3RlZCBhcyB1cHBlciAyIGJpdHMgKHNoaWZ0IGJ5IDYpDQo+IGFuZCB0aGUg
bnVtYmVyIG9mIHN0ZXBzIGZpZWxkIGlzIGV4dHJhY3RlZCBieSBtYXNraW5nIGxvd2VyIDYgYml0
cy4NCj4gLS0tDQo+ICBtZXNoL21vZGVsLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5jDQo+IGluZGV4IDMxMTk3YjM2My4uZWY3
NjY4MTQ3IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4gKysrIGIvbWVzaC9tb2RlbC5j
DQo+IEBAIC0xNzAsMjAgKzE3MCwyMSBAQCBzdGF0aWMgc3RydWN0IG1lc2hfbW9kZWwgKmdldF9t
b2RlbChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50OF90IGVsZV9pZHgsDQo+ICANCj4gIHN0
YXRpYyB1aW50MzJfdCBwdWJfcGVyaW9kX3RvX21zKHVpbnQ4X3QgcHViX3BlcmlvZCkNCj4gIHsN
Cj4gLQlpbnQgbjsNCj4gKwlpbnQgc3RlcF9yZXMsIG51bV9zdGVwczsNCj4gIA0KPiAtCW4gPSBw
dWJfcGVyaW9kID4+IDI7DQo+ICsJc3RlcF9yZXMgPSBwdWJfcGVyaW9kID4+IDY7DQo+ICsJbnVt
X3N0ZXBzID0gcHViX3BlcmlvZCAmIDB4M2Y7DQo+ICANCj4gLQlzd2l0Y2ggKHB1Yl9wZXJpb2Qg
JiAweDMpIHsNCj4gKwlzd2l0Y2ggKHN0ZXBfcmVzKSB7DQo+ICAJZGVmYXVsdDoNCj4gLQkJcmV0
dXJuIG4gKiAxMDA7DQo+ICsJCXJldHVybiBudW1fc3RlcHMgKiAxMDA7DQo+ICAJY2FzZSAyOg0K
PiAtCQluICo9IDEwOw0KPiArCQludW1fc3RlcHMgKj0gMTA7DQo+ICAJCS8qIEZhbGwgVGhyb3Vn
aCAqLw0KPiAgCWNhc2UgMToNCj4gLQkJcmV0dXJuIG4gKiAxMDAwOw0KPiArCQlyZXR1cm4gbnVt
X3N0ZXBzICogMTAwMDsNCj4gIAljYXNlIDM6DQo+IC0JCXJldHVybiBuICogMTAgKiA2MCAqIDEw
MDA7DQo+ICsJCXJldHVybiBudW1fc3RlcHMgKiAxMCAqIDYwICogMTAwMDsNCj4gIAl9DQo+ICB9
DQo+ICANCg==
