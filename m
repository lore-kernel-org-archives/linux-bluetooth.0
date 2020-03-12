Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C0C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B13720716
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="i1Ckh42J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCLSUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:20:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:56717 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCLSUf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 14:20:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="322554962"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2020 11:20:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:20:27 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 11:20:27 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 11:20:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G06YHDWF8k/pUdL95/80m6vn/duSIbrqqyKW/b7gan3WQIVe6pMgA18qeXXcFtE/zukMPfvj7zHpysied24fCdyHmiG9XCunExapZsyqPwNdvAye9FjIVyBHwyzer2tDzqrdTMlMBmFxiclEklmNhSyEe/7FRHG3UuVjqEdfSql382QVGBAxs2Jmo8p/5vqj2pfoSQf4fW6viwqlW2D9sfRYA/3FYQLbHHGPI4EZmGmUKoqaxzdFrmta3ZT8CG6WxCENH5DlbY7BQRvvHEZoIc7uDWMhrA30cGwQTnOiXCFRrby2NKP+rGxM1Q6rGDdS6TFqjqjBngM5cdZZsXndVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1FyCJInXUu48SlocdoNrbOPoWiV2kTmyc5CPXMUKt8=;
 b=MMQf9uEyPYpfIpJMq8c3yiriZNsRpsjtIOOc+MGJCccvt0Sxy6CIeSd5GKL+WK98POz8b7qGhgoxdMeYrzgfrh5cTQydAjC9Pf/lewp5rqsyz4IwhzR4ZQ991rFefGPn0RnMRpnt58kGHPDVpcgZRxPTU1j8ZFCyg51XyXFEwzHlnvGsxHqqorc+7DgY27pSjIzehjy4fleXNg8NGMDCM6ntKkppquLwCaik2MXADYiu9zB/YlgSC1IJkUWSLhfe7wVVFQYWd1Dpzq8sqK+j8HXfzXM3QAITTl8Ju+5sbtaXJiZoXeSodFyRp/55GcWuTgVp4QebMGDYczcKytt6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1FyCJInXUu48SlocdoNrbOPoWiV2kTmyc5CPXMUKt8=;
 b=i1Ckh42JxR0X+3uQo3vcbldsP1TX4tH7/tVNOd+a7CqI7Q3UOFm6y69IuV7U/Ud0IAkc+p/JGtyf165GT65TPq8wN4lfLrKvZT5XRCam4kw575zvvG59FjU1pyT5yt4zdvmLz3FEipC1UNghHWT3tdJDHmSTtbfmOs3AONCkjFU=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 18:20:26 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 18:20:26 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] test/test-mesh: Add support for static OOB in the
 agent
Thread-Topic: [PATCH BlueZ] test/test-mesh: Add support for static OOB in the
 agent
Thread-Index: AQHV9/WsWLempb4GT0WRULANvcRfFKhFReGA
Date:   Thu, 12 Mar 2020 18:20:26 +0000
Message-ID: <7c8f999877a31bf7e057701d718b61c4cd9f6604.camel@intel.com>
References: <20200311223712.31784-1-inga.stotland@intel.com>
In-Reply-To: <20200311223712.31784-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5954131-ffe6-4385-6af2-08d7c6b2099b
x-ms-traffictypediagnostic: MW3PR11MB4745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4745FE1BBD614ECAA39A56E4E1FD0@MW3PR11MB4745.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(5660300002)(478600001)(81166006)(8936002)(2616005)(6636002)(186003)(26005)(6506007)(81156014)(86362001)(76116006)(6486002)(316002)(91956017)(66556008)(36756003)(8676002)(66446008)(6512007)(64756008)(110136005)(66946007)(2906002)(66476007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4745;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgqDMflynRr+jEICK4oIbL/wsHri8CicaQ5NGv2gos5shqy77m3CZ+/hiqgddhOCGdfBld+zr7AWcaEywQcp/yJ9s2Q2qAFIDmhz+tSqgUFeJg8kfxKPXlWVj8A2tBPCw9RSNkE8g3+Kd+kmXUlMT1pVQnUa9f1OlEFYb34ChQHk7561wpFy2zuF3mDoLoWcfkIceMhXLaOlGqV0FFl8FFA/Z8lQlpbczA1K1kHhheMPcedh+OCrDSxmfLx4xkF4j4LpcrzjXTqLUYyDMcl0Q00pGbsZyTaL0EeGzci9Pab20dO7AxqEq3dgsX2lPobUPmnxIVn2KwCkqTT3chTwh4TqfPq2Wj+INno2IEE4/UiwZVKDFQ4wOk/a+7LjZ+Z9c7+f5WddK5lmMkMuaIqkh7thwwrypYG+7drNtfdY0xnInj3UZm+GB5fcxlVCGAZG
x-ms-exchange-antispam-messagedata: dI+72TyUCJ0QFtqwPtuYJzs0Z1aCLJh4rL1MOai4dWmor2sP8UGEU9aHRIuyI5pm36+g+jUSVcDkajoDNxl1Nv9IR4W5ucJZ6/jp8icJga4lRpe6SrCuQQLRI7aNg4Pu0KoLgFRPA5Ejj140mnvsog==
Content-Type: text/plain; charset="utf-8"
Content-ID: <08C74BD2455A6548911D96780846DE35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5954131-ffe6-4385-6af2-08d7c6b2099b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 18:20:26.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdw4nN15Xq8e6OCXBFEoi5XGAoB1DgMzP4vRzJg1H+v7AkHMx9pUjD4UO3zubvsuuq6x3qOGFKG1EPbaq+t6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgd2l0aCBTdGF0aWMgT09CIGVuYWJsZWQgYnkgZGVmYXVsdA0KT24gV2VkLCAyMDIw
LTAzLTExIGF0IDE1OjM3IC0wNzAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIGFsbG93
cyB0byBkaXNwbGF5IGEgMTYtb2N0ZXQga2V5IHRvIGJlIGVudGVyZWQgb24gdGhlIHJlbW90ZQ0K
PiBkZXZpY2UgZHVyaW5nIHByb3Zpc2lvbmluZy4NCj4gLS0tDQo+ICB0ZXN0L2FnZW50LnB5IHwg
MTkgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0L2FnZW50LnB5IGIvdGVzdC9hZ2VudC5weQ0KPiBp
bmRleCA3NzhkYmUwOTIuLmFmOWVkZDM1YyAxMDA3NTUNCj4gLS0tIGEvdGVzdC9hZ2VudC5weQ0K
PiArKysgYi90ZXN0L2FnZW50LnB5DQo+IEBAIC0zLDYgKzMsNyBAQA0KPiAgaW1wb3J0IHN5cw0K
PiAgaW1wb3J0IGRidXMNCj4gIGltcG9ydCBkYnVzLnNlcnZpY2UNCj4gK2ltcG9ydCBudW1weQ0K
PiAgDQo+ICB0cnk6DQo+ICAgIGZyb20gdGVybWNvbG9yIGltcG9ydCBjb2xvcmVkLCBjcHJpbnQN
Cj4gQEAgLTE3LDYgKzE4LDEyIEBAIEFHRU5UX1BBVEggPSAiL21lc2gvdGVzdC9hZ2VudCINCj4g
IA0KPiAgYnVzID0gTm9uZQ0KPiAgDQo+ICtkZWYgYXJyYXlfdG9fc3RyaW5nKGJfYXJyYXkpOg0K
PiArCXN0cl92YWx1ZSA9ICIiDQo+ICsJZm9yIGIgaW4gYl9hcnJheToNCj4gKwkJc3RyX3ZhbHVl
ICs9ICIlMDJ4IiAlIGINCj4gKwlyZXR1cm4gc3RyX3ZhbHVlDQo+ICsNCj4gIGNsYXNzIEFnZW50
KGRidXMuc2VydmljZS5PYmplY3QpOg0KPiAgCWRlZiBfX2luaXRfXyhzZWxmLCBidXMpOg0KPiAg
CQlzZWxmLnBhdGggPSBBR0VOVF9QQVRIDQo+IEBAIC0yNyw2ICszNCw3IEBAIGNsYXNzIEFnZW50
KGRidXMuc2VydmljZS5PYmplY3QpOg0KPiAgCQljYXBzID0gW10NCj4gIAkJb29iID0gW10NCj4g
IAkJY2Fwcy5hcHBlbmQoJ291dC1udW1lcmljJykNCj4gKwkJI2NhcHMuYXBwZW5kKCdzdGF0aWMt
b29iJykNCj4gIAkJb29iLmFwcGVuZCgnb3RoZXInKQ0KPiAgCQlyZXR1cm4gew0KPiAgCQkJQUdF
TlRfSUZBQ0U6IHsNCj4gQEAgLTQ2LDMgKzU0LDE0IEBAIGNsYXNzIEFnZW50KGRidXMuc2Vydmlj
ZS5PYmplY3QpOg0KPiAgCWRlZiBEaXNwbGF5TnVtZXJpYyhzZWxmLCB0eXBlLCB2YWx1ZSk6DQo+
ICAJCXByaW50KHNldF9jeWFuKCdEaXNwbGF5TnVtZXJpYyAoJyksIHR5cGUsDQo+ICAJCQkJc2V0
X2N5YW4oJykgbnVtYmVyID0nKSwgc2V0X2dyZWVuKHZhbHVlKSkNCj4gKw0KPiArCUBkYnVzLnNl
cnZpY2UubWV0aG9kKEFHRU5UX0lGQUNFLCBpbl9zaWduYXR1cmU9InMiLCBvdXRfc2lnbmF0dXJl
PSJheSIpDQo+ICsJZGVmIFByb21wdFN0YXRpYyhzZWxmLCB0eXBlKToNCj4gKwkJc3RhdGljX2tl
eSA9IG51bXB5LnJhbmRvbS5yYW5kaW50KDAsIDI1NSwgMTYpDQo+ICsJCWtleV9zdHIgPSBhcnJh
eV90b19zdHJpbmcoc3RhdGljX2tleSkNCj4gKw0KPiArCQlwcmludChzZXRfY3lhbignUHJvbXB0
U3RhdGljICgnKSwgdHlwZSwgc2V0X2N5YW4oJyknKSkNCj4gKwkJcHJpbnQoc2V0X2N5YW4oJ0Vu
dGVyIDE2IG9jdGV0IGtleSBvbiByZW1vdGUgZGV2aWNlOiAnKSwNCj4gKwkJCQkJCQlzZXRfZ3Jl
ZW4oa2V5X3N0cikpOw0KPiArDQo+ICsJCXJldHVybiBkYnVzLkFycmF5KHN0YXRpY19rZXksIHNp
Z25hdHVyZT0neScpDQo=
