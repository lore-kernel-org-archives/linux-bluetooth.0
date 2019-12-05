Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5E1C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 00:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6C82073B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="XiYCeJxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLEA27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:28:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:26167 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfLEA25 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 19:28:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 16:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="236485205"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2019 16:28:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Dec 2019 16:28:56 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Dec 2019 16:28:56 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Dec 2019 16:28:56 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 4 Dec 2019 16:28:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMk6pt9I7/aJcxbAN9dOgw8JTak5Ezbz1aEK/OrkizE+pGWqMdcjkaZdDeSYl49iazlBLmbebet5JpxKPhMsyzPb7axC3wUdmqKodqs/yb5TDbgH4uTZh/y7+VG0EB6M6U+JoNuis1+LMxP2xihW9H8cy2B7SvXyV553zb2LWqBg50TKiiLB1v1rzRHXyCrXBHdABSM5cpJaXxKFdAZYETH+pDe3wljj0H629iD4xLLt0IgY45rIszAn/Z1fGOYfZa0q0pIkrgcxT1LT/yZUqpsn2RJJx59cKjTrWQhC9KFpsSiTLTjOUcUUTL3XZZ3lsjMw32wNFbXIliZi3Wkpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3wSfbfdIXAVA+/5ReBGRqZbnSYteoLoCN5qFyfUYzI=;
 b=iFVu0muHTlmVHiOifzG1ju6ElQi3+LYSocLxmV8bGwRhxlTHRAmahKg/IJoKbxNr5e2L9FZRYXylE3PETKBD+78lSN4b+Gb3jsocA/QwmpAeaF79KkZzGYeEazDpFXA7bsQIYpQQlUSVYCWR6N82vhTrc+NwdiHfm08y+bTq+mRG4Hj4jdRVB3stH5lkW2cngjeBTgbqt18eOySB4lTXdNwqeNfL6W8np9ia+hsYh6fiR5YWTDZNgQYDXxT5iTdGh2h0sCmRi5puBnOfUEfDcqBaJpRmHYxF09NJlaMHGfBNvpv+aoRT/OhW+EBazV7jPhCDGtgNGck0mLV4hXUjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3wSfbfdIXAVA+/5ReBGRqZbnSYteoLoCN5qFyfUYzI=;
 b=XiYCeJxB2E15P2cAH1vJmLCNxlyOoLq/FqHTbea+aHAemGrdKUbgS8jkn4yW37y17OgUX1HUpBrz0P+W4fftbPxHRikKUIms/lqH9TBxA2yaWiSRwcqBcZ3dZj4srZh74MzYzrpkNQKYcRQcyrv++HDZ6SfzTNPXV/1hHMWkqcg=
Received: from BN6PR11MB1265.namprd11.prod.outlook.com (10.173.32.12) by
 BN6PR11MB1524.namprd11.prod.outlook.com (10.172.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 00:28:40 +0000
Received: from BN6PR11MB1265.namprd11.prod.outlook.com
 ([fe80::24f7:813e:ce6b:b8e0]) by BN6PR11MB1265.namprd11.prod.outlook.com
 ([fe80::24f7:813e:ce6b:b8e0%11]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 00:28:40 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] build: Include dependancies for ell/settings.[ch]
Thread-Topic: [PATCH BlueZ] build: Include dependancies for ell/settings.[ch]
Thread-Index: AQHVqtdKjfGbLzn9l0ynj4M9uxjsK6eqsDKA
Date:   Thu, 5 Dec 2019 00:28:40 +0000
Message-ID: <2673755eb55d895ac0790d4b1e41a7a3d94e0a31.camel@intel.com>
References: <20191204191516.13178-1-brian.gix@intel.com>
In-Reply-To: <20191204191516.13178-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e04fb8-1906-4f6c-d173-08d7791a1414
x-ms-traffictypediagnostic: BN6PR11MB1524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB152441F76E35C3312E671AB1E15C0@BN6PR11MB1524.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(71200400001)(6246003)(71190400001)(118296001)(107886003)(99286004)(5640700003)(4326008)(14454004)(316002)(478600001)(2501003)(14444005)(25786009)(36756003)(6916009)(26005)(186003)(76176011)(2906002)(6486002)(229853002)(6506007)(305945005)(11346002)(7736002)(2616005)(6436002)(102836004)(66946007)(8936002)(5660300002)(2351001)(8676002)(6116002)(6512007)(3846002)(64756008)(81156014)(66476007)(81166006)(66446008)(76116006)(91956017)(66556008)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR11MB1524;H:BN6PR11MB1265.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9WA322ekXTPAAxo2Tp6qu6KJvwH8OYQIGhqw8ri4mwlKhZxhH4i5Jv74QizodG95z3Bv5Bmmgi/0pEDETP2z7qwlfUom0jc0RY9phgJnTcReV6YQ0ecPXIg86wf4FgUwzHDX5hf7VgghRZp7887GOkcVgm26gAuP/cXWP1pCLolB8eHC3+uNUjaeq1nbEhDtWPr2fosl33guhJiS2UCrERaNNSRCilIua+qNXYjCZK/40B+4Jkvibm+B/8R8JtR0c76zkYJJG04GKNsLMtwtvYBdhfz7u6UdD/LiAZi1ObkKgW6cWGiOFlKtfEvpXzF8wtEYx0UPb/cx3OQN2GE5ZWmull7onGPQEt0UMaEW15qEsDznq+L6sXkqwSOH/ckzDqCLNONdWSEsyJ5czg8by1INI9SwSLazRUGP4ZP4+nNgztSIBKwQIL9D0h2rZji
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2374E14BF4F1E4C95339211435B204C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e04fb8-1906-4f6c-d173-08d7791a1414
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 00:28:40.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p5+AQFdcEbTG4mQmZQ6jh+X9gtQafRBAkhDnQ42oC3WyIFuGkWSuRC47INQ7Le1STaCHVFRwkk9MzNgVHaTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1524
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIHNwZWxsaW5nIGNvcnJlY3Rpb25zDQoNCk9uIFdlZCwgMjAxOS0xMi0wNCBh
dCAxMToxNSAtMDgwMCwgQnJpYW4gR2l4IHdyb3RlOg0KPiBJbmNsdWRpbmcgc2V0dGluZ3MuW2No
XSBpbiBhIGJ1aWxkIHJlcXVpcmVzIHRoZSBmb2xsb3dpbmcgY2hhaW5lZA0KPiBkZXBlbmRhbmNp
ZXM6DQo+IFBFTQ0KPiBDRVJUDQo+IEtFWQ0KPiBQS1NDNQ0KPiBCQVNFNjQNCj4gLS0tDQo+ICBN
YWtlZmlsZS5hbSB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NYWtlZmls
ZS5hbSBiL01ha2VmaWxlLmFtDQo+IGluZGV4IDhkNDE5ZmIzMC4uODM2YTRmY2QyIDEwMDY0NA0K
PiAtLS0gYS9NYWtlZmlsZS5hbQ0KPiArKysgYi9NYWtlZmlsZS5hbQ0KPiBAQCAtMTIxLDEyICsx
MjEsMjIgQEAgZWxsX2hlYWRlcnMgPSBlbGwvdXRpbC5oIFwNCj4gIAkJCWVsbC9pby5oIFwNCj4g
IAkJCWVsbC9pZGxlLmggXA0KPiAgCQkJZWxsL21haW4uaCBcDQo+ICsJCQllbGwvc2V0dGluZ3Mu
aCBcDQo+ICAJCQllbGwvc3Rydi5oIFwNCj4gIAkJCWVsbC9zdHJpbmcuaCBcDQo+ICAJCQllbGwv
dXRmOC5oIFwNCj4gIAkJCWVsbC9kYnVzLmggXA0KPiAgCQkJZWxsL2RidXMtc2VydmljZS5oIFwN
Cj4gLQkJCWVsbC9kYnVzLWNsaWVudC5oDQo+ICsJCQllbGwvZGJ1cy1jbGllbnQuaCBcDQo+ICsJ
CQllbGwva2V5LmggXA0KPiArCQkJZWxsL2NlcnQuaCBcDQo+ICsJCQllbGwvcGVtLmggXA0KPiAr
CQkJZWxsL2Jhc2U2NC5oIFwNCj4gKwkJCWVsbC9wa2NzNS5oIFwNCj4gKwkJCWVsbC9hc24xLXBy
aXZhdGUuaCBcDQo+ICsJCQllbGwvcGtjczUtcHJpdmF0ZS5oIFwNCj4gKwkJCWVsbC9jZXJ0LXBy
aXZhdGUuaCBcDQo+ICsJCQllbGwvcGVtLXByaXZhdGUuaA0KPiAgDQo+ICBlbGxfc291cmNlcyA9
IGVsbC9wcml2YXRlLmggZWxsL21pc3NpbmcuaCBcDQo+ICAJCQllbGwvdXRpbC5jIFwNCj4gQEAg
LTEzOSwxMCArMTQ5LDE2IEBAIGVsbF9zb3VyY2VzID0gZWxsL3ByaXZhdGUuaCBlbGwvbWlzc2lu
Zy5oIFwNCj4gIAkJCWVsbC9pby5jIFwNCj4gIAkJCWVsbC9pZGxlLmMgXA0KPiAgCQkJZWxsL21h
aW4uYyBcDQo+ICsJCQllbGwvc2V0dGluZ3MuYyBcDQo+ICAJCQllbGwvc3Rydi5jIFwNCj4gIAkJ
CWVsbC9zdHJpbmcuYyBcDQo+ICAJCQllbGwvY2lwaGVyLmMgXA0KPiAgCQkJZWxsL2NoZWNrc3Vt
LmMgXA0KPiArCQkJZWxsL3BlbS5jIFwNCj4gKwkJCWVsbC9jZXJ0LmMgXA0KPiArCQkJZWxsL2tl
eS5jIFwNCj4gKwkJCWVsbC9wa2NzNS5jIFwNCj4gKwkJCWVsbC9iYXNlNjQuYyBcDQo+ICAJCQll
bGwvdXRmOC5jIFwNCj4gIAkJCWVsbC9kYnVzLXByaXZhdGUuaCBcDQo+ICAJCQllbGwvZGJ1cy5j
IFwNCg==
