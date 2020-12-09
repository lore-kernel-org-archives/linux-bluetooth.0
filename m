Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCF1C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 00:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B5D23AA8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgLIAlN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:41:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:26589 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730820AbgLIAlM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 19:41:12 -0500
IronPort-SDR: Pfld9mpD7FleNrN19z5sw5fywHVtCEPFDh1ndwWeIiKU3Xx9Hg6vixdEPpu6XNfV1sFOi1pqpt
 BMQXJlZbPc3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="173235528"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="173235528"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:40:32 -0800
IronPort-SDR: JmDt6qqCTJi8gL1PF0KaCj6uGuHndnCATrrqnxswuuUV5+LWQ7ndUUGSCJ92KUJiMCHUJQf3nC
 cBLSF0qtmsaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407842312"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2020 16:40:31 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 16:40:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 16:40:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 16:40:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 16:40:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOQpuntP1YStZWxHAf47kzswyLJmvGg1Sej9CCfo58WJbjgmCj0uBpOR7Ofgcy2B8MiGHbXjxEwa/U84Wnh/mt6V/ve+yOV/NM/iLcP8NVw9Oki9CZQk9AitiHEG8iIKjOmpak0U5fileqKykAKBG9LsRFv+3wNXu9qvDgQn24AuMaqKof2YsePS3mowm3nhtn5n9STS9WjMyaYKokOtUKPD1BS9X3kTG/YLgmewYFiyGCoqO6fbDt4YGDLbhRF+tfZbw7vlxcQePaXSA8cBt96Vra8pWOo7wJzOgHoIA+ID3m6bCP8YJTcPEAIii3126x+/Yy0wk6YdAt3Knwax3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv7L3UFnFgqNVjfv3vM2h9PjLkY7mPUhRn0B8+QhkUQ=;
 b=Z2LScNEAhRW+/IE8mrpx3/2vTP/NDkJs+MJ6KEhBEKbvl1LPm0vVD/tiRNeMwlp8NYnuWpNnh4LpjbS4DbKNmejT+jBKH03DLHuL7avxPrthSMH7dGvFrMWhoPaOKfjZflJt4ZXW0vCZCg6Usgx94bQE0r7TLNEc+30z2O7kNaAuoc+5PzNd13VcxiZPqnfQr6FIGbOkkZzzxp3wDM+PImVllYkbACct0tkFJyyZnq3ybnSXde+MFAGw7GpbevIkpBVcKlRktE9Nu0pq/lHUfvtqIAajww0A1OvN3amgWgY6f4yFTd939tA7Cu9FDBvFtrRfIGRIhregqagALWhQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv7L3UFnFgqNVjfv3vM2h9PjLkY7mPUhRn0B8+QhkUQ=;
 b=s+sxsFpDalFVHoxWA1bb+oxRRB4zN63ZwaLBk3B2jI6ZT9UfOb5odKdHRihG+8a2ymv7/eiD7ksTBCT4YwMo0zhBAXyBVUgxQpfrOTdeZhjGi7AXJEyg/uNgsrELPSHeBzxuy7HDaInkqeDoeucLtfZ57QyOgTh019KukS8CHfU=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BY5PR11MB3990.namprd11.prod.outlook.com (2603:10b6:a03:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Wed, 9 Dec
 2020 00:40:27 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984%2]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 00:40:27 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: linux-next-2020-12-04: Failed to send firmware data (-38) with
 AX210
Thread-Topic: linux-next-2020-12-04: Failed to send firmware data (-38) with
 AX210
Thread-Index: AQHWzNMZ6g8PVaaogkGzMdmsISyPgKnt3W1Q
Date:   Wed, 9 Dec 2020 00:40:24 +0000
Message-ID: <BYAPR11MB3141EC7D2A5E98DCCE285AFFF5CC0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <ece7cd5c-14ff-5a6d-29b5-c6a16b2638e8@gmail.com>
In-Reply-To: <ece7cd5c-14ff-5a6d-29b5-c6a16b2638e8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.182.244.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38eb1ef-f811-4a3d-6117-08d89bdb063a
x-ms-traffictypediagnostic: BY5PR11MB3990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39904DCAD95FEC696AF7D17CF5CC0@BY5PR11MB3990.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1TzvzrpL1EEo7wDwUXLEgc6JD6z0vJJC05J9KQ8A+f0KGcFY9tm6ZhSkvS8f/PS/8eCRfWgQ0LV/hfoVFb0Bw0V/mT0l3LZQ72uFLr4/3Fs8WOWbKp2lNhqAEebeeZ9/Me24O8MFmqeDqwl4/djZaywftuEatvc0B3et3S5+qmTZ0H3A2/2IWZh/9Imztqt1oWwbLUy6AsFwZFGjuvdeLpeR3gmMOKIhsvfGu8KjsxAynyHqk5yv6IwMXuXdijgISelOLoDhuHhiTWfa2qqNKPtpBG0ssBX8+OPqkDoqHYXQr9J6k0XH5j+6BrglBJ4J9mm1e5iyqiWaOCd5QTIq7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(54906003)(9686003)(2906002)(66446008)(107886003)(6666004)(6506007)(86362001)(4326008)(53546011)(508600001)(5660300002)(83380400001)(7696005)(55016002)(110136005)(64756008)(8676002)(8936002)(26005)(71200400001)(52536014)(76116006)(33656002)(66946007)(66476007)(186003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NjgzaEJjc0FaZ3hlSEJFN3lVcHhlOVBYaWZjK1c5QkZYc2RDY3I3Wkx2bG1v?=
 =?utf-8?B?MnFYNDYxdjlNaHFDRG9DdU5JNSt4b2U0WTh4K0hqY2FxOStWcmZ1YW9ZaXBE?=
 =?utf-8?B?WDJtRHk4NVFmSUNLeUtvbVBVMHpBMW54cHczYTZVWWNJeFlwUG5GdW12R015?=
 =?utf-8?B?bWVKTUtEMEhXV1Z0d1FFV05aMXJIOHRXL0ZTSmFsVXY2NW4yZUN6VjhQYlI1?=
 =?utf-8?B?QUh3NGl1T2p1aVM2akw4YmczOEg4NklXenY3UkcrWHZNUHR1bk81TUJ5S2Np?=
 =?utf-8?B?YmRzckNJMGttNVoxcHQyekhITmcxanczTjVhSUs1MldDRGRKVUdLTHZIMjF4?=
 =?utf-8?B?TE50Y0ZTNDVBZjdqM2Y4MXdUWWQ0aG5nZVM2VXcxci85TnpUbVR3djBRckdw?=
 =?utf-8?B?OThFbnFnSzZDdUZPYmsvMTZXbjc3M0FCektLeGRETGZudjl1azdDd2VFR0Vq?=
 =?utf-8?B?MVZ2UWEzSExnbVdSd0YydCs2R3h5ZS9XcHJ3eSt3UEdZMURzY2F0aVQzSEY5?=
 =?utf-8?B?M29mREJ5a3NGeEpaY2E1eGRHVklBNXBXTmxmRFIwa2VaYU14SHBheTNEVHJW?=
 =?utf-8?B?WTZqamtVZFkwSW5ZS3l6ajRnbmFXWGQrem1DTUM2R2JoMmxWK1c5czF2ODEy?=
 =?utf-8?B?MGpkb2k4UGlCUTZlVjNmOGM3RC9CMnVqbG9wSTh5ak0xMmpsYmttUnJURXlz?=
 =?utf-8?B?TXVtK0EyaXZSOStTZ212TDlBK3VkNTBaQVVJdTM4WmQyMUpSdis1N2c5MnVN?=
 =?utf-8?B?NWJCSHdCNVE5MkNIRmRKcytlN3RWYW1qNEZjWWd0T1ZKaStMRHpZN2l1dVVF?=
 =?utf-8?B?c1JPb1FhNnBnUmhaejQ1Tml6aEczNk9nOStiMHhNeXlpREJXRkFXT2xZVEhD?=
 =?utf-8?B?dzhGVnc0SGU4SzdxV3dpUk1BWWNmb1FwNDQwK0lUSXF0TEFUTkVCZG1HQ3h6?=
 =?utf-8?B?ellPdDZZSzVzRzlYTlB5RGVLRW1BZGF4YjFjOGdmNTVMSjZvZG9OY3VMMTV0?=
 =?utf-8?B?TlNlNCt0MkFSQWtsYTVYT2pwUkVqL1Z5QmM1bDBSek5mWHZaS1NPb2l2L3pL?=
 =?utf-8?B?cDMyRXYwZEVtZktoUEdKOUFROThMNlBBVnlNV1pCck9GMUJvZFZ0M05jbFU4?=
 =?utf-8?B?ekMyazNhS2NLU2ZVNjQ3aTFXbEIwUC8yUTd4cE5BT2NUM2dkSVJ0M2o1ZWJq?=
 =?utf-8?B?VzVmTWF3d1pxSlVTZlR1WUNSbFFjdllxZXBXK0pPNUx3QzBMSnFyWm1NQTBX?=
 =?utf-8?B?MHREcnJIeFkyemF3blZYZkRqUWovakVkSjdDVUFGU2h3YWgva1p5VEY1aGwz?=
 =?utf-8?Q?8G117TyoB0aYF2VZ6gjgBAIo12taJWVEBq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38eb1ef-f811-4a3d-6117-08d89bdb063a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 00:40:24.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPiLZ/VuY1m1TGRTvc07P5+m9ARNgiw/dYJVvx/DKzwbpKOnO7tnjvHM97+gjvvo0nralQtK6wqxz7RPHgFnXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3990
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSGVpbmVyIEthbGx3ZWl0LA0KDQpQbGVhc2UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIHRl
c3QgZW52aXJvbm1lbnQuDQoNCjEuICAgY2F0ICAvcHJvYy9jcHVpbmZvDQoyLiAgIElzIHRoaXMg
YW4gaW50ZXJtaXR0ZW50IGlzc3VlID8NCjMuICAgQXJlIHlvdSB1c2luZyBhbnkgc3BlY2lmaWMg
ZGlzdHJvID8NCg0KSSBkaWRuJ3Qgb2JzZXJ2ZSBhbnkgc3VjaCBpc3N1ZSBvbiBteSBzeXN0ZW0u
DQoNClRoYW5rcywNCktpcmFuDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBEZWNlbWJlciA4LCAyMDIwIDE6MjYgQU0NCj4gVG86IEssIEtpcmFuIDxraXJhbi5rQGlu
dGVsLmNvbT47IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gQ2M6IEJs
dWVaIGRldmVsb3BtZW50IDxsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBsaW51eC1uZXh0LTIwMjAtMTItMDQ6IEZhaWxlZCB0byBzZW5kIGZpcm13YXJlIGRhdGEg
KC0zOCkgd2l0aCBBWDIxMA0KPiANCj4gV2l0aCBhbiBBWDIxMCBjYXJkIEkgZ2V0ICJGYWlsZWQg
dG8gc2VuZCBmaXJtd2FyZSBkYXRhICgtMzgpIiBvbiBsaW51eC1uZXh0DQo+IGZyb20gRGVjIDR0
aCBpbiBjYXNlIG9mIGEgY29sZC1ib290IGFmdGVyIHBvd2VyLWN5Y2xlLg0KPiANCj4gImhrOiBi
dCBjb2RlID0gMHgwMDFmIiBpcyBhIHByaXZhdGUgZGVidWcgbWVzc2FnZSB0byBjaGVjayB3aGlj
aCBCVCBjb2RlIGlzDQo+IG1hcHBlZCB0byBFTk9TWVMgKC0zOCkuIEZyb20gd2hhdCBJIGZvdW5k
IDB4MWYgaXMgIlVuc3BlY2lmaWVkIGVycm9yIi4NCj4gDQo+IFRoZSBzZWNvbmQgYXR0ZW1wdCB0
byBsb2FkIHRoZSBmaXJtd2FyZSBpcyBzdWNjZXNzZnVsIHRoZW4uDQo+IA0KPiANCj4gWyAgICA0
LjE5MjcxOF0gQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyDQo+IFsgICAgNC4xOTI3NTZdIEJsdWV0
b290aDogU3RhcnRpbmcgc2VsZiB0ZXN0aW5nDQo+IFsgICAgNC4xOTI3ODVdIEJsdWV0b290aDog
RmluaXNoZWQgc2VsZiB0ZXN0aW5nDQo+IFsgICAgNC4xOTI5MzddIEJsdWV0b290aDogSENJIGRl
dmljZSBhbmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkDQo+IFsgICAgNC4xOTMwNjdd
IEJsdWV0b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbICAgIDQuMTkzMTA4
XSBCbHVldG9vdGg6IEwyQ0FQIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbICAgIDQuMTkz
MTk1XSBCbHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gWyAgICA0LjI0
MjM0Ml0gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgcmV2aXNpb24gaXMgMA0KPiBbICAgIDQuMjQy
NDM1XSBCbHVldG9vdGg6IGhjaTA6IFNlY3VyZSBib290IGlzIGVuYWJsZWQNCj4gWyAgICA0LjI0
MjQ5NV0gQmx1ZXRvb3RoOiBoY2kwOiBPVFAgbG9jayBpcyBlbmFibGVkDQo+IFsgICAgNC4yNDI1
MzNdIEJsdWV0b290aDogaGNpMDogQVBJIGxvY2sgaXMgZW5hYmxlZA0KPiBbICAgIDQuMjQyNTcw
XSBCbHVldG9vdGg6IGhjaTA6IERlYnVnIGxvY2sgaXMgZGlzYWJsZWQNCj4gWyAgICA0LjI0MjYw
OV0gQmx1ZXRvb3RoOiBoY2kwOiBNaW5pbXVtIGZpcm13YXJlIGJ1aWxkIDEgd2VlayAxMCAyMDE0
DQo+IFsgICAgNC4yNDI2NTddIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciB0aW1lc3RhbXAg
MjAxOS40MCBidWlsZHR5cGUgMQ0KPiBidWlsZCAzOA0KPiBbICAgIDQuMjYxOTc3XSBCbHVldG9v
dGg6IGhjaTA6IEZvdW5kIGRldmljZSBmaXJtd2FyZTogaW50ZWwvaWJ0LTAwNDEtMDA0MS5zZmkN
Cj4gWyAgICA0Ljg1NTgxM10gQmx1ZXRvb3RoOiBCTkVQIChFdGhlcm5ldCBFbXVsYXRpb24pIHZl
ciAxLjMNCj4gWyAgICA0Ljg1NTg3M10gQmx1ZXRvb3RoOiBCTkVQIHNvY2tldCBsYXllciBpbml0
aWFsaXplZA0KPiBbICAgIDUuODE5Mzg4XSBCbHVldG9vdGg6IGhrOiBidCBjb2RlID0gMHgwMDFm
DQo+IFsgICAgNS44MTk0MzhdIEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIHNlbmQgZmlybXdh
cmUgZGF0YSAoLTM4KQ0KPiBbICAgIDUuODIwMDY5XSBCbHVldG9vdGg6IGhjaTA6IEludGVsIHJl
c2V0IHNlbnQgdG8gcmV0cnkgRlcgZG93bmxvYWQNCj4gWyAgICA2LjM2MjI0OF0gQmx1ZXRvb3Ro
OiBoY2kwOiBEZXZpY2UgcmV2aXNpb24gaXMgMA0KPiBbICAgIDYuMzYyMzg0XSBCbHVldG9vdGg6
IGhjaTA6IFNlY3VyZSBib290IGlzIGVuYWJsZWQNCj4gWyAgICA2LjM2MjQzOV0gQmx1ZXRvb3Ro
OiBoY2kwOiBPVFAgbG9jayBpcyBlbmFibGVkDQo+IFsgICAgNi4zNjI1NTFdIEJsdWV0b290aDog
aGNpMDogQVBJIGxvY2sgaXMgZW5hYmxlZA0KPiBbICAgIDYuMzYyNjA1XSBCbHVldG9vdGg6IGhj
aTA6IERlYnVnIGxvY2sgaXMgZGlzYWJsZWQNCj4gWyAgICA2LjM2MjY2MF0gQmx1ZXRvb3RoOiBo
Y2kwOiBNaW5pbXVtIGZpcm13YXJlIGJ1aWxkIDEgd2VlayAxMCAyMDE0DQo+IFsgICAgNi4zNjI3
MjZdIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciB0aW1lc3RhbXAgMjAxOS40MCBidWlsZHR5
cGUgMQ0KPiBidWlsZCAzOA0KPiBbICAgIDYuMzY0NTA4XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5k
IGRldmljZSBmaXJtd2FyZTogaW50ZWwvaWJ0LTAwNDEtMDA0MS5zZmkNCj4gWyAgICA5LjAyMDU0
MF0gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9hZCB0byBjb21w
bGV0ZQ0KPiBbICAgIDkuMDIxNDQzXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIGxvYWRlZCBp
biAyNTk5MTM2IHVzZWNzDQo+IFsgICAgOS4wMjI3NzhdIEJsdWV0b290aDogaGNpMDogV2FpdGlu
ZyBmb3IgZGV2aWNlIHRvIGJvb3QNCj4gWyAgICA5LjA1MDA5OV0gQmx1ZXRvb3RoOiBoY2kwOiBE
ZXZpY2UgYm9vdGVkIGluIDI3NzIzIHVzZWNzDQo+IFsgICAgOS4wNTI2MzNdIEJsdWV0b290aDog
aGNpMDogRm91bmQgSW50ZWwgRERDIHBhcmFtZXRlcnM6IGludGVsL2lidC0wMDQxLQ0KPiAwMDQx
LmRkYw0KPiBbICAgIDkuMDU1MjI0XSBCbHVldG9vdGg6IGhjaTA6IEFwcGx5aW5nIEludGVsIERE
QyBwYXJhbWV0ZXJzIGNvbXBsZXRlZA0KPiBbICAgIDkuMDYwMTg0XSBCbHVldG9vdGg6IGhjaTA6
IEZpcm13YXJlIHRpbWVzdGFtcCAyMDIwLjQyIGJ1aWxkdHlwZSAxIGJ1aWxkDQo+IDE1NzkxDQoN
Cg==
