Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A4C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AE82074A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="puEWcxxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgH1RgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:36:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:64854 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgH1RgE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 13:36:04 -0400
IronPort-SDR: EPHBRsj+gjasJ+bm+kYB4yswRrS0ikBnleV0yChgFQTEF08gUTtxphasAa9nRNJAGDlyrK/Baf
 e5aPtLt1qtig==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="154254105"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="154254105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:35:13 -0700
IronPort-SDR: q4a7eScRhstM2sgsSvhsL8KCcnnM3dCGyia1HREiQOQHudacGDaRO7QIu2yG6BDF0LkwFUDVEu
 oz5uSdR/6/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="324094034"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2020 10:35:13 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 10:34:48 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Aug 2020 10:34:48 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 28 Aug 2020 10:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNBZDgjEljqvyeNPA6wOxHuTbnb4AtQyttl+4XtRIc3V5aUtGyhaVuUYA9itoQQXXQtj9A09y8od04niLiTysMd9jdkZgjInDOIwXvSekZyN0kbjTkzmCLgwHeyB/dbqz9JIbIb3dfjRV+jZyc2AMdYnuInMlkxL311AdOmNJdLG8NMHib3iZlnfZ6qUAUehDDk5qb12AeofrXN4KCUaC3OspIlYPBCr+fgvausDaZ0plHKIkaFZmfkx8ITu7FRYBYNZwXiHB98GD4mzn+94RcOSpzR3ssS+yDvrXp17m3VY5ouC34JecNBKiaWvdBxrq5N/Xvy93xfiL0xsyUPrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMr1GxgMjRpsPToq3JjaJECrbwcuy8yBRCL/IRAedMk=;
 b=QPvMaw++2I7a32a30QprUD2Qgq3N9DZa2+tjOdF8ADdirSg8KDV1D8hVFNu/9rIMwLhKUCKCTctclAps2mzwoPx2NCwl6r/KX+KYyEKCOqIMRV7cyCvRXChFm+tVeJ5/TvTgakv2+tgBxe19jbDlrYdlMGNwZL9nBkw7Pp24pAzuLaazCvtXAzMIePGOTMVGT+7l1cO/7hLd2q5m9DaTgqfhHwnrmPTfppxMRVGAZ8cdaFZJSS3eC4qMNgZd8CwnvgA/gAvAHK0HIt0xuHTbFHdgLGe/+NGsf2f7XFhBrCXpT9e41cgULOnv2fb0RbONpxm2hFYEyuxTi0C2KjvP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMr1GxgMjRpsPToq3JjaJECrbwcuy8yBRCL/IRAedMk=;
 b=puEWcxxR3wMkcuInFCLtZA1XkXBPSvQhTfk+k4+CkTYjthOF8oZ+kUSE1J/6Qfr7DPq7znsx5YKOylisHrIcDVy6TsyYi8xg7DQ5XKAUsEGcXjnsnz5soJ/J7tI801KxtYrgA0M4MWhgkR2kmx6sBSJueW2VtrRbkPgFBpZvu+I=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1952.namprd11.prod.outlook.com (2603:10b6:300:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 17:34:47 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 17:34:47 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Store key indices as integers in node
 config
Thread-Topic: [PATCH BlueZ v2] mesh: Store key indices as integers in node
 config
Thread-Index: AQHWfVt6m8N4Q+6Zx0Cs9huLKSxS86lNyFQA
Date:   Fri, 28 Aug 2020 17:34:47 +0000
Message-ID: <dd5100bf840a4b0536143ece14c220d4a0f08962.camel@intel.com>
References: <20200828165112.4937-1-inga.stotland@intel.com>
In-Reply-To: <20200828165112.4937-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab83732b-45e4-4673-2af3-08d84b78a8cf
x-ms-traffictypediagnostic: MWHPR11MB1952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB195258A89A0C3E42B075F986E1520@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRXFHh/b4+My16j3hZZLDN/ryNKBaFvfAO8T/diui1ygS6fXggxpzBOjkmFFk/LL5G6XkfjWf/NUWdrAsUcxfQXS4cwMJZ1Icb3IltH6PC3SLwrccnVj+ttU2Ci5Dz/fVU+NMKRuabDLz5qW23YLc2e5uz49CagcYDSJO1wJHFmUPCpm5MOKz/jRerCIkn1SD4C0peD2r/U3Pqt9FV3hSujn1eATJJo8jbfv8LQFWcaQWKcikk6od/+Qq7d9R0xDJLbmq1SP7yMhytCb5/gUbgJQOJ6Nk+6kT/UZwZFtTDvkHrptlaCzs6qe8RTRHjbgWlVqzdgBTkxOOnM6FHIv3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(71200400001)(6512007)(66556008)(66476007)(64756008)(36756003)(6636002)(498600001)(66446008)(83380400001)(6486002)(2616005)(110136005)(6506007)(86362001)(8936002)(2906002)(8676002)(186003)(66946007)(76116006)(91956017)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8cvditHpN5rs2FMEzn9de+rWXywB1sVDo83vk8fBuSty5ssVXdhdDF/yUQKgH/hTzgbBfMVklwYTja9sqFfexFq8ejfQg9viMw2ecWtd9asEGD+dUd//yzwvwTxFaF99xdBLLZL/NrE7E/1dutZU37cgebYqTnG9yNnsSaVykuP5FXZPdsaX5MjEpriQPENtZsQ2xeF8X778TKQij6QUbjIpQCoUqhMtU6CZNBpEjmLy8LQ1cZ9xrCEXN4cfllK4mrNCtVAzvpnx6JNlD+y3JCoQGMp4OUj3YJ6bgRjHNLwPH05M02Rasekd4yqdoB4WATKH3kbVmo0R8E1fKrPN6GAzCy/o/prcURbIDWJwa3DII/O578FzLb7+Icbfxg/Ay0ZfjgASXSySnIXYDZnvKwS/Okdsv1C9iWEsqN2leQffY7M3I9rUilVN/Cv4wMvvxk7K9b4Mw1tK7X7TBhiup2hLxjqj8LX8g8KHt3GfePx48+bQ6TkzwWSrs3A+d2sCH1AKJJT4+sCPr8ndCCWE3FBhTYnhvB+q9DZa4vh04wrsfCTV/1fO2Acxf2mJxArebxRsx9xIxC0ILkB7sBEhUKviyS6/uzAXw3pNgTERxyI9JvFxu4BsHJ38zeeOXv6KZ2MsMKbZ3wTQSw5sziGuYw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F9934AFBFA1341ABF1D1351157D2F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83732b-45e4-4673-2af3-08d84b78a8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 17:34:47.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz9o84cPop3n0n733q4AU3Iq0eU2mX6/ESSuIs+OKFGXHQtqm4hc+dqF0anMWGRG6Ly6djYoyOWNZxwGlWZH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMjAtMDgtMjggYXQgMDk6NTEgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFN0b3JlIE5ldEtleSBhbmQgQXBwS2V5IGluZGljZXMgYXMgaW50ZWdlcnMg
aW5zdGVhZCBvZiBoZXggc3RyaW5ncy4NCj4gVGhpcyByZW1vdmVzIHVubmVjZXNzYXJ5IHN0cmlu
ZyBtYW5pcHVsYXRpb25zIHdoaWxlIG5vdCBhZmZlY3RpbmcNCj4gdGhlIGNvbmZpZ3VyYXRpb24g
ZmlsZSByZWFkYWJpbGl0eS4NCj4gLS0tDQo+ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8IDEw
MiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMgYi9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0KPiBp
bmRleCA2M2I2YzM5ODguLjMwYzkwMTcwZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLWNvbmZp
Zy1qc29uLmMNCj4gKysrIGIvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMNCj4gQEAgLTI0OSwyMSAr
MjQ5LDMxIEBAIHN0YXRpYyB2b2lkIGphcnJheV9zdHJpbmdfZGVsKGpzb25fb2JqZWN0ICpqYXJy
YXksIGNoYXIgKnN0ciwgc2l6ZV90IGxlbikNCj4gIAl9DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBi
b29sIGdldF9rZXlfaW5kZXgoanNvbl9vYmplY3QgKmpvYmosIGNvbnN0IGNoYXIgKmtleXdvcmQs
DQo+ICsJCQkJCQkJCXVpbnQxNl90ICppbmRleCkNCj4gK3sNCj4gKwlpbnQgaWR4Ow0KPiArDQo+
ICsJaWYgKCFnZXRfaW50KGpvYmosIGtleXdvcmQsICZpZHgpKQ0KPiArCQlyZXR1cm4gZmFsc2U7
DQo+ICsNCj4gKwlpZiAoIUNIRUNLX0tFWV9JRFhfUkFOR0UoaWR4KSkNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KPiArDQo+ICsJKmluZGV4ID0gKHVpbnQxNl90KSBpZHg7DQo+ICsJcmV0dXJuIHRydWU7
DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBqc29uX29iamVjdCAqZ2V0X2tleV9vYmplY3QoanNvbl9v
YmplY3QgKmphcnJheSwgdWludDE2X3QgaWR4KQ0KPiAgew0KPiAgCWludCBpLCBzeiA9IGpzb25f
b2JqZWN0X2FycmF5X2xlbmd0aChqYXJyYXkpOw0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IHN6
OyArK2kpIHsNCj4gLQkJanNvbl9vYmplY3QgKmplbnRyeSwgKmp2YWx1ZTsNCj4gLQkJY29uc3Qg
Y2hhciAqc3RyOw0KPiArCQlqc29uX29iamVjdCAqamVudHJ5Ow0KPiAgCQl1aW50MTZfdCBqaWR4
Ow0KPiAgDQo+ICAJCWplbnRyeSA9IGpzb25fb2JqZWN0X2FycmF5X2dldF9pZHgoamFycmF5LCBp
KTsNCj4gLQkJaWYgKCFqc29uX29iamVjdF9vYmplY3RfZ2V0X2V4KGplbnRyeSwgImluZGV4Iiwg
Jmp2YWx1ZSkpDQo+IC0JCQlyZXR1cm4gTlVMTDsNCj4gLQ0KPiAtCQlzdHIgPSBqc29uX29iamVj
dF9nZXRfc3RyaW5nKGp2YWx1ZSk7DQo+IC0JCWlmIChzc2NhbmYoc3RyLCAiJTA0aHgiLCAmamlk
eCkgIT0gMSkNCj4gKwkJaWYgKCFnZXRfa2V5X2luZGV4KGplbnRyeSwgImluZGV4IiwgJmppZHgp
KQ0KPiAgCQkJcmV0dXJuIE5VTEw7DQo+ICANCj4gIAkJaWYgKGppZHggPT0gaWR4KQ0KPiBAQCAt
MjczLDI4ICsyODMsNiBAQCBzdGF0aWMganNvbl9vYmplY3QgKmdldF9rZXlfb2JqZWN0KGpzb25f
b2JqZWN0ICpqYXJyYXksIHVpbnQxNl90IGlkeCkNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4g
IA0KPiAtc3RhdGljIGJvb2wgZ2V0X2tleV9pbmRleChqc29uX29iamVjdCAqam9iaiwgY29uc3Qg
Y2hhciAqa2V5d29yZCwNCj4gLQkJCQkJCQkJdWludDE2X3QgKmluZGV4KQ0KPiAtew0KPiAtCXVp
bnQxNl90IGlkeDsNCj4gLQlqc29uX29iamVjdCAqanZhbHVlOw0KPiAtCWNvbnN0IGNoYXIgKnN0
cjsNCj4gLQ0KPiAtCWlmICghanNvbl9vYmplY3Rfb2JqZWN0X2dldF9leChqb2JqLCBrZXl3b3Jk
LCAmanZhbHVlKSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+IC0Jc3RyID0ganNvbl9vYmpl
Y3RfZ2V0X3N0cmluZyhqdmFsdWUpOw0KPiAtDQo+IC0JaWYgKHNzY2FuZihzdHIsICIlMDRoeCIs
ICZpZHgpICE9IDEpDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiAtCWlmICghQ0hFQ0tfS0VZ
X0lEWF9SQU5HRShpZHgpKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gLQkqaW5kZXggPSAo
dWludDE2X3QpIGlkeDsNCj4gLQlyZXR1cm4gdHJ1ZTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZv
aWQgamFycmF5X2tleV9kZWwoanNvbl9vYmplY3QgKmphcnJheSwgaW50MTZfdCBpZHgpDQo+ICB7
DQo+ICAJaW50IGksIHN6ID0ganNvbl9vYmplY3RfYXJyYXlfbGVuZ3RoKGphcnJheSk7DQo+IEBA
IC01OTQsMTEgKzU4MiwyMyBAQCBmYWlsOg0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0K
PiArc3RhdGljIGJvb2wgd3JpdGVfaW50KGpzb25fb2JqZWN0ICpqb2JqLCBjb25zdCBjaGFyICpk
ZXNjLCBpbnQgdmFsKQ0KPiArew0KPiArCWpzb25fb2JqZWN0ICpqdmFsdWU7DQo+ICsNCj4gKwlq
dmFsdWUgPSBqc29uX29iamVjdF9uZXdfaW50KHZhbCk7DQo+ICsJaWYgKCFqdmFsdWUpDQo+ICsJ
CXJldHVybiBmYWxzZTsNCj4gKw0KPiArCWpzb25fb2JqZWN0X29iamVjdF9kZWwoam9iaiwgZGVz
Yyk7DQo+ICsJanNvbl9vYmplY3Rfb2JqZWN0X2FkZChqb2JqLCBkZXNjLCBqdmFsdWUpOw0KPiAr
CXJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+ICBib29sIG1lc2hfY29uZmlnX25ldF9rZXlfYWRk
KHN0cnVjdCBtZXNoX2NvbmZpZyAqY2ZnLCB1aW50MTZfdCBpZHgsDQo+ICAJCQkJCQkJY29uc3Qg
dWludDhfdCBrZXlbMTZdKQ0KPiAgew0KPiAtCWpzb25fb2JqZWN0ICpqbm9kZSwgKmphcnJheSA9
IE5VTEwsICpqZW50cnkgPSBOVUxMLCAqanN0cmluZzsNCj4gLQljaGFyIGJ1Zls1XTsNCj4gKwlq
c29uX29iamVjdCAqam5vZGUsICpqYXJyYXkgPSBOVUxMLCAqamVudHJ5ID0gTlVMTDsNCj4gIA0K
PiAgCWlmICghY2ZnKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+IEBAIC02MTgsMTMgKzYxOCw5IEBA
IGJvb2wgbWVzaF9jb25maWdfbmV0X2tleV9hZGQoc3RydWN0IG1lc2hfY29uZmlnICpjZmcsIHVp
bnQxNl90IGlkeCwNCj4gIAlpZiAoIWplbnRyeSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+
IC0Jc25wcmludGYoYnVmLCA1LCAiJTQuNHgiLCBpZHgpOw0KPiAtCWpzdHJpbmcgPSBqc29uX29i
amVjdF9uZXdfc3RyaW5nKGJ1Zik7DQo+IC0JaWYgKCFqc3RyaW5nKQ0KPiArCWlmICghd3JpdGVf
aW50KGplbnRyeSwgImluZGV4IiwgaWR4KSkNCj4gIAkJZ290byBmYWlsOw0KPiAgDQo+IC0JanNv
bl9vYmplY3Rfb2JqZWN0X2FkZChqZW50cnksICJpbmRleCIsIGpzdHJpbmcpOw0KPiAtDQo+ICAJ
aWYgKCFhZGRfa2V5X3ZhbHVlKGplbnRyeSwgImtleSIsIGtleSkpDQo+ICAJCWdvdG8gZmFpbDsN
Cj4gIA0KPiBAQCAtNzI0LDggKzcyMCw3IEBAIGJvb2wgbWVzaF9jb25maWdfd3JpdGVfdG9rZW4o
c3RydWN0IG1lc2hfY29uZmlnICpjZmcsIHVpbnQ4X3QgKnRva2VuKQ0KPiAgYm9vbCBtZXNoX2Nv
bmZpZ19hcHBfa2V5X2FkZChzdHJ1Y3QgbWVzaF9jb25maWcgKmNmZywgdWludDE2X3QgbmV0X2lk
eCwNCj4gIAkJCQkJdWludDE2X3QgYXBwX2lkeCwgY29uc3QgdWludDhfdCBrZXlbMTZdKQ0KPiAg
ew0KPiAtCWpzb25fb2JqZWN0ICpqbm9kZSwgKmphcnJheSA9IE5VTEwsICpqZW50cnkgPSBOVUxM
LCAqanN0cmluZyA9IE5VTEw7DQo+IC0JY2hhciBidWZbNV07DQo+ICsJanNvbl9vYmplY3QgKmpu
b2RlLCAqamFycmF5ID0gTlVMTCwgKmplbnRyeSA9IE5VTEw7DQo+ICANCj4gIAlpZiAoIWNmZykN
Cj4gIAkJcmV0dXJuIGZhbHNlOw0KPiBAQCAtNzQ0LDIwICs3MzksMTIgQEAgYm9vbCBtZXNoX2Nv
bmZpZ19hcHBfa2V5X2FkZChzdHJ1Y3QgbWVzaF9jb25maWcgKmNmZywgdWludDE2X3QgbmV0X2lk
eCwNCj4gIAlpZiAoIWplbnRyeSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IC0Jc25wcmlu
dGYoYnVmLCA1LCAiJTQuNHgiLCBhcHBfaWR4KTsNCj4gLQlqc3RyaW5nID0ganNvbl9vYmplY3Rf
bmV3X3N0cmluZyhidWYpOw0KPiAtCWlmICghanN0cmluZykNCj4gKwlpZiAoIXdyaXRlX2ludChq
ZW50cnksICJpbmRleCIsIGFwcF9pZHgpKQ0KPiAgCQlnb3RvIGZhaWw7DQo+ICANCj4gLQlqc29u
X29iamVjdF9vYmplY3RfYWRkKGplbnRyeSwgImluZGV4IiwganN0cmluZyk7DQo+IC0NCj4gLQlz
bnByaW50ZihidWYsIDUsICIlNC40eCIsIG5ldF9pZHgpOw0KPiAtCWpzdHJpbmcgPSBqc29uX29i
amVjdF9uZXdfc3RyaW5nKGJ1Zik7DQo+IC0JaWYgKCFqc3RyaW5nKQ0KPiArCWlmICghd3JpdGVf
aW50KGplbnRyeSwgImJvdW5kTmV0S2V5IiwgbmV0X2lkeCkpDQo+ICAJCWdvdG8gZmFpbDsNCj4g
IA0KPiAtCWpzb25fb2JqZWN0X29iamVjdF9hZGQoamVudHJ5LCAiYm91bmROZXRLZXkiLCBqc3Ry
aW5nKTsNCj4gLQ0KPiAgCWlmICghYWRkX2tleV92YWx1ZShqZW50cnksICJrZXkiLCBrZXkpKQ0K
PiAgCQlnb3RvIGZhaWw7DQo+ICANCj4gQEAgLTk5NSw2ICs5ODIsNyBAQCBzdGF0aWMgc3RydWN0
IG1lc2hfY29uZmlnX3B1YiAqcGFyc2VfbW9kZWxfcHVibGljYXRpb24oanNvbl9vYmplY3QgKmpw
dWIpDQo+ICAJY2FzZSAzMjoNCj4gIAkJaWYgKCFzdHIyaGV4KHN0ciwgbGVuLCBwdWItPnZpcnRf
YWRkciwgMTYpKQ0KPiAgCQkJZ290byBmYWlsOw0KPiArDQo+ICAJCXB1Yi0+dmlydCA9IHRydWU7
DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+IEBAIC0xNDY4LDE5ICsxNDU2LDYgQEAgc3Rh
dGljIGJvb2wgd3JpdGVfdWludDMyX2hleChqc29uX29iamVjdCAqam9iaiwgY29uc3QgY2hhciAq
ZGVzYywgdWludDMyX3QgdmFsKQ0KPiAgCXJldHVybiB0cnVlOw0KPiAgfQ0KPiAgDQo+IC1zdGF0
aWMgYm9vbCB3cml0ZV9pbnQoanNvbl9vYmplY3QgKmpvYmosIGNvbnN0IGNoYXIgKmRlc2MsIGlu
dCB2YWwpDQo+IC17DQo+IC0JanNvbl9vYmplY3QgKmp2YWx1ZTsNCj4gLQ0KPiAtCWp2YWx1ZSA9
IGpzb25fb2JqZWN0X25ld19pbnQodmFsKTsNCj4gLQlpZiAoIWp2YWx1ZSkNCj4gLQkJcmV0dXJu
IGZhbHNlOw0KPiAtDQo+IC0JanNvbl9vYmplY3Rfb2JqZWN0X2RlbChqb2JqLCBkZXNjKTsNCj4g
LQlqc29uX29iamVjdF9vYmplY3RfYWRkKGpvYmosIGRlc2MsIGp2YWx1ZSk7DQo+IC0JcmV0dXJu
IHRydWU7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBjb25zdCBjaGFyICptb2RlX3RvX3N0cmluZyhp
bnQgbW9kZSkNCj4gIHsNCj4gIAlzd2l0Y2ggKG1vZGUpIHsNCj4gQEAgLTE4NzIsNyArMTg0Nyw3
IEBAIGJvb2wgbWVzaF9jb25maWdfbW9kZWxfcHViX2FkZChzdHJ1Y3QgbWVzaF9jb25maWcgKmNm
ZywgdWludDE2X3QgZWxlX2FkZHIsDQo+ICAJaWYgKCFyZXMpDQo+ICAJCWdvdG8gZmFpbDsNCj4g
IA0KPiAtCWlmICghd3JpdGVfdWludDE2X2hleChqcHViLCAiaW5kZXgiLCBwdWItPmlkeCkpDQo+
ICsJaWYgKCF3cml0ZV9pbnQoanB1YiwgImluZGV4IiwgcHViLT5pZHgpKQ0KPiAgCQlnb3RvIGZh
aWw7DQo+ICANCj4gIAlpZiAoIXdyaXRlX2ludChqcHViLCAidHRsIiwgcHViLT50dGwpKQ0KPiBA
QCAtMTg4MSw4ICsxODU2LDcgQEAgYm9vbCBtZXNoX2NvbmZpZ19tb2RlbF9wdWJfYWRkKHN0cnVj
dCBtZXNoX2NvbmZpZyAqY2ZnLCB1aW50MTZfdCBlbGVfYWRkciwNCj4gIAlpZiAoIXdyaXRlX2lu
dChqcHViLCAicGVyaW9kIiwgcHViLT5wZXJpb2QpKQ0KPiAgCQlnb3RvIGZhaWw7DQo+ICANCj4g
LQlpZiAoIXdyaXRlX2ludChqcHViLCAiY3JlZGVudGlhbHMiLA0KPiAtCQkJCQkJcHViLT5jcmVk
ZW50aWFsID8gMSA6IDApKQ0KPiArCWlmICghd3JpdGVfaW50KGpwdWIsICJjcmVkZW50aWFscyIs
IHB1Yi0+Y3JlZGVudGlhbCA/IDEgOiAwKSkNCj4gIAkJZ290byBmYWlsOw0KPiAgDQo+ICAJanJ0
eCA9IGpzb25fb2JqZWN0X25ld19vYmplY3QoKTsNCg==
