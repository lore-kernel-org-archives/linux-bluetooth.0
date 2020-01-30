Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB11C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F620CC7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sL/WONe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgA3TeS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:34:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:10664 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgA3TeS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 14:34:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 11:34:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="277884791"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2020 11:34:15 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jan 2020 11:34:14 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jan 2020 11:34:14 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jan 2020 11:34:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Jan 2020 11:34:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX4OTAytNic/sxO+c1kWZ/c4f52psBmxltkfDYSnMnk/RLcSv8XPfeqU7B71TNKyrNYi2B84lLM6c24H+mnKvrDjDjhvO2MvICqNJ8VE2HEMkqeZO9ppRoVpGtaiqcoGn7M2jM7sTD4jyrsYmScOemW2td1kOZhykLAmDvRn8VcOIDAVtcTXw3ePRTdwtCH2RtHHcS5y+Xl7DsrlW4uDMmQcWsRCC+fGLFhj4jtvUZLbqnSLjJ2qTRihk/khi2FGRA9o0THSAoOy+oNQV9wjZe2kLgwJWjEXXHlEDIbqpnj/DoCebghgJIMqLKzMscl64P7wTt7DJOOJnpSra83PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcDfyZXHolCaeh2foA3eF5K4fAiOYHuBF24oP5UDs44=;
 b=JEDfcKQjXFJ22QS6oZiZPCXu5wJQvEnpl+TLvBBQF7B9oUlms+Oc5zzujzE0/LtzF1loqRC5WzvJxuFVcZBAfSqkVOzgT5Jw34/9VNG9vwI/65pAUxC1IV8frGTx4MKvqIrxp9H66DYL8yYPZrMqPSUgXtbUbNUIrr+CAqc7qIs5gtjMMcDsIhmQQGZqNFDfBUeR/+g5MoB9Rn61MT9hRI8inO/+HJbiyQkHq0pCvTe8OIClEOx8/45DvccjFe9SAsTlPSwVj0H4bUsWTKnlm7aDdkR3XiDXPrBU4MHmugqzptlkbfYo10uDtFrcwfSJ4rR9Fm0HQU6qEtpTGHExbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcDfyZXHolCaeh2foA3eF5K4fAiOYHuBF24oP5UDs44=;
 b=sL/WONe0iScjSYmUzVTD9X0hVGSNlkFJOean/Wg/rn+0Wp1lGHrcmzSZb87Dtq+0Z/UW8zvp7n5jdDbvy3/M7GBfyo8uuq4U0qGry4BAx9mk8zYCsAAxePivEIOXnCF587UvhnZqVaQjQRvwyjpHv6sFq3Zvaz4aNpkYjydgIvo=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2722.namprd11.prod.outlook.com (52.135.242.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 19:34:10 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 19:34:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ v5 0/5] mesh: Add NVM storage of Replay Protection
 List
Thread-Topic: [PATCH BlueZ v5 0/5] mesh: Add NVM storage of Replay Protection
 List
Thread-Index: AQHV1say8YQMfj5k4EGhcJCjYB7Y26gDmu6A
Date:   Thu, 30 Jan 2020 19:34:10 +0000
Message-ID: <73eed33a0d242713baa0fa58920a07ee61df879b.camel@intel.com>
References: <20200129170732.1607-1-brian.gix@intel.com>
In-Reply-To: <20200129170732.1607-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b03926-54f0-4479-1e2a-08d7a5bb6141
x-ms-traffictypediagnostic: BN7PR11MB2722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2722D2E4DE4C9BC40B7496C6E1040@BN7PR11MB2722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(316002)(64756008)(66476007)(4326008)(66446008)(66556008)(6486002)(478600001)(6512007)(66946007)(186003)(5660300002)(36756003)(26005)(71200400001)(6916009)(81166006)(8936002)(2616005)(81156014)(8676002)(86362001)(2906002)(76116006)(6506007)(91956017)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2722;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V57fKkuj6pk5sHuOWRC2fSJSGrFo3yymlj5oOlPhoqvjm8KFXp+0ERluTSrz5v1cHnLEaHjQxxDGmr3tqeObWo3hPkPqHowz/CL76/PJzWj0YOY3W9i1kWXhqx8RHFWejJST5jYdXkW/RFz2qOPfl9URGLDJxDCjeIUJW47Wp34NRQitpl3pMhbeX0Vsev8/CwfL+2zr/niSH7IHpbLeiFt4J5RKoBW5/mKDTa5JcFISggkQ8/8sw8bD9ZoRfkSHlFtcVeLFFpxIx7eLeCrp8PRQhOM7zCEMzLMZG+iVrCqeC1UJHIyj7COol3ZibcrysMMdOZ2Kt+vpDQhH0WVuyyz0lQsRc9mN0p8bpHf3xW46wTrhWU2Iy5KkkHmohJE4KiSfLRei7oTuv+lxENe6EJ3U67NM0wXoobc8DS5DxsUgOk/bf89+k/brHPShqs0v
x-ms-exchange-antispam-messagedata: vtojRBD+cNp64PyXmTpGFs/p5ZDiso2xSbFBmtckbFkRn93t5rbuSuPA1MiVnVVnp2yl9vKOtuary/Mp+FHXVgdHUcDiFJH0kpAqHnn4D38XK4IV2IdVtsqwZQa177dTsDh3V6+5reyZbCO0X3oWKA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B3487737CCE85488BCB0A4CFCD7AC86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b03926-54f0-4479-1e2a-08d7a5bb6141
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 19:34:10.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfMlW5x5DWIhsfmeT620oZ0+L4nLiWxmxCoHQIG32IjUglMwZ3h6+eDG5BGgFjfQ9oJ3kEhC5o9K15xiDDubGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2722
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBXZWQsIDIwMjAtMDEtMjkgYXQgMDk6MDcgLTA4MDAsIEJy
aWFuIEdpeCB3cm90ZToNCj4gVmVyc2lvbiA1OiBFeHRyYSBjbGVhbi11cCBmaXhlcyBhZGRlZCBm
b3IgbWFsZm9ybWVkIFJQTCB0cmVlcywgYW5kDQo+IGl2X2luZGV4IGRpcnMgY3JlYXRlZCAiYXMg
bmVlZGVkIiBpbnN0ZWFkIG9mIGF0IFJQTCBpbml0aWFsaXphdGlvbi4NCj4gKHBhdGNoIDUvNSkN
Cj4gDQo+IFZlcnNpb24gNDogU3R5bGUgZ3VpZGUgZml4ZXMgZnJvbSBJbmdhIChwYXRjaCA1LzUp
Lg0KPiANCj4gVmVyc2lvbiAzOiBGaXggcHJvYmxlbSBmb3VuZCBieSBSYWZhxYIgcmVsYXRpbmcg
dG8gdGhlIGhhbmRsaW5nIG9mDQo+IHNlcXVlbmNlIG51bWJlcnMgb2YgbWVzc2FnZXMgYmVpbmcg
aGFuZGxlZCBpbnRlcm5hbGx5IChsb29wLWJhY2tzKSwNCj4gd2hpY2ggd2VyZSBiZWluZyByZWpl
Y3RlZCBieSB0aGUgUmVwbGF5IFByb3RlY3Rpb24gTGlzdCAocGxlYXNlIHNlZQ0KPiBwYXRjaCAz
LzUpLg0KPiANCj4gVmVyc2lvbiAyOiBGaXggcGF0aCBjb25zdHJ1Y3Rpb24gY29kZSB3aGVuIGZp
cnN0IHJlYWRpbmcgUlBMIGZyb20gTlZNDQo+IA0KPiANCj4gQW4gb3ZlcnNpZ2h0IGxlZCB0byBs
b3Npbmcgb3VyIFJlcGxheSBQcm90ZWN0aW9uIExpc3Qgd2l0aCBldmVyeQ0KPiByZS1ib290LiBU
aGlzIHBhdGNoLXNldCBtYWtlcyBhIG51bWJlciBvZiBSZXBsYXkgUHJvdGVjdCBMaXN0DQo+IG1v
ZGlmaWNhdGlvbnMgdGhhdCBjdWxtaW5hdGUgaW4gYWRkaW5nIHJwbC5jL2gsIHdoaWNoIHN0b3Jl
cyB0aGUgbGF0ZXN0DQo+IGl2X2luZGV4L3NlcXVlbmNlIHZhbHVlcyBmb3IgZWFjaCBub2RlIHRo
YXQgaGFuZGxlcyBhbiBpbmNvbWluZyBwYWNrZXQuDQo+IA0KPiBUaGUgZmlyc3QgNCBwYXRjaGVz
LCBkb2VzIHNvbWUgbWFpbnRlbmFuY2UgcmVxdWlyZWQgdG8gaGFuZGxlIFJQTA0KPiBhY2NvcmRp
bmcgdGhlIHRoZSBNZXNoIFNwZWNpZmljYXRpb24uDQo+IA0KPiANCj4gQnJpYW4gR2l4ICg1KToN
Cj4gICBtZXNoOiBSZWxvY2F0ZSB0cmVlIGRlbGV0aW9uIHRvIHV0aWwuYy9oDQo+ICAgbWVzaDog
TW92ZSBSZXBsYXkgUHJvdGVjdGlvbiB0byBtZXNoL25ldC5jDQo+ICAgbWVzaDogQ2xlYW4tdXAg
dW5uZWVkZWQgU2VxdWVuY2UgTnVtYmVyIGluY3JlbWVudHMNCj4gICBtZXNoOiBBcHBseSBSZXBs
YXkgUHJvdGVjdGlvbiB0byBhbGwgaW5jb21pbmcgcGFja2V0cw0KPiAgIG1lc2g6IEFkZCBOVk0g
c3RvcmFnZSBvZiBSZXBsYXkgUHJvdGVjdGlvbg0KPiANCj4gIE1ha2VmaWxlLm1lc2ggICAgICAg
ICAgIHwgICAxICsNCj4gIG1lc2gvYXBwa2V5LmMgICAgICAgICAgIHwgMTAyIC0tLS0tLS0tLS0t
LS0tDQo+ICBtZXNoL2FwcGtleS5oICAgICAgICAgICB8ICAgMyAtDQo+ICBtZXNoL21lc2gtY29u
ZmlnLWpzb24uYyB8ICAyMCArLS0NCj4gIG1lc2gvbW9kZWwuYyAgICAgICAgICAgIHwgIDE2ICst
LQ0KPiAgbWVzaC9uZXQuYyAgICAgICAgICAgICAgfCAxMjggKysrKysrKysrKysrKysrLS0tDQo+
ICBtZXNoL25ldC5oICAgICAgICAgICAgICB8ICAgMyArDQo+ICBtZXNoL3JwbC5jICAgICAgICAg
ICAgICB8IDI4OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBt
ZXNoL3JwbC5oICAgICAgICAgICAgICB8ICAzMCArKysrKw0KPiAgbWVzaC91dGlsLmMgICAgICAg
ICAgICAgfCAgMjUgKysrKw0KPiAgbWVzaC91dGlsLmggICAgICAgICAgICAgfCAgIDEgKw0KPiAg
MTEgZmlsZXMgY2hhbmdlZCwgNDY4IGluc2VydGlvbnMoKyksIDE1MCBkZWxldGlvbnMoLSkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBtZXNoL3JwbC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbWVz
aC9ycGwuaA0KPiANCg==
