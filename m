Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 20:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiBDUeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:34:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:61234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238501AbiBDUeU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644006860; x=1675542860;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FsVGmmkIiPMPPdAEUbG1iqDMnWCxJ4l/InnKSy0bgvg=;
  b=J0PtILnp6DsoW59LwXGK0kctPa2GYFVekMGNqXAsowsECI0aRjXxbDdg
   1mzp6KSw6WCHsLF73FKf4LBfQM7ihwrvoTZO+oR1eCmYeSN0zE+c6YZVY
   9Geoqvue21oqUnJ5pTiMB9WenKPI0c6wWRjmRrgAVd4L4dCbRhRnIg1VJ
   nCSynyDW1FAA3qZP2fjQ0sfEZNyy6aZUIN90yWilrDPRIVQ3Cc1HaQOmz
   pEobBAWjMbZNh+SEocfxCKQBkI6Ns8F9n2d7d3px+Wpfw8SAzj8U9OwtM
   cbNUw5N7HZVVxUPd3QAIszJHj1RQrvNQMyEEvto7ZHpJVegYO3KO3mOKg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="311738796"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="311738796"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 12:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="483725879"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2022 12:34:20 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 12:34:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 12:34:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 4 Feb 2022 12:34:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 4 Feb 2022 12:34:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyvekACOdueeX3YAE2Yr/zzovfQTL7+3IIYQLniwmWUQyEubEMiVTXJYjWlT201fG1mEJuz2ON3KxFg5vLY/iz9QFXNUj0DjcTlYo0hb/y7J5KRaV4a00oZemtsaRD+mJqKRf+VVrUsKCOhxN9Xmzf/Cf0DUJCQasFwqSm02nTZd4GbSEaR2bPA2dwVbBxQ/TQQD2YsZqnVjj3kVBidrNb5YBbOHOKS3UoeKV3oyfTHms2HwdGeyFt5gl8LmxWIKTwqfXys19lxI9r1XhyoeHafWDCaSnxSYVRLg7WjgpLR/vusIuWa5T299C4ir6nAC5CxpK62e4bskIXIxuTb0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsVGmmkIiPMPPdAEUbG1iqDMnWCxJ4l/InnKSy0bgvg=;
 b=S/CdCN41O9fJXgCviQGDb2mrHBgqll9QAlSLKrisw46l53HXh+bFTwZezLQ4dbrxM5b+4gAHsBCTd42C3Dl21xCsANLudkYK9C7NhiKJEdhXWSuKgHZd4eTplj5/AajsoRSCRLBUv5WNTjMecZXu+Ge+36jljpd4MU764sFDAIj2K+G4lh9vpd8wzRsAbh92Euwjyor/bTDxYq16iY4RP28lWAAEdl1QRROWnm2MMX7BuYJV+cIsa9W/vXGTmIb7Si4AWzrkngWhaA10Wd8nzfcN7vGz5fpBT51d0DpE6esCJLj7u13aK9XAJ6nakKLZ3JMbwxJ8ZhgkU7g2F/0sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by BL0PR11MB3458.namprd11.prod.outlook.com (2603:10b6:208:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 20:34:16 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 20:34:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Skip unneeded logs
Thread-Topic: [PATCH BlueZ] mesh: Skip unneeded logs
Thread-Index: AQHYGQu5lSG6IGw2DkWeN04CVfsT+6yD2w+A
Date:   Fri, 4 Feb 2022 20:34:16 +0000
Message-ID: <de1aea56d2a1ef00b5de886d0780c76353739596.camel@intel.com>
References: <20220203143800.746093-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20220203143800.746093-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e43ae0-ed2d-4ccc-6511-08d9e81db684
x-ms-traffictypediagnostic: BL0PR11MB3458:EE_
x-microsoft-antispam-prvs: <BL0PR11MB34586FDC727C1C34D068F18CE1299@BL0PR11MB3458.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Bw5o64sxepOn2Pf2kcRNCpcJqdGgVRUQyVg4kQ/YpFjUDyYqNepVY4ZBpR+EcF7FYNT0NgktGtSvAVdSloQLbgMUA9JdjA/CdkCn+n9MBHITzTOVHL+YcwE+QDmedaxXKHa40FJiDaw+ZAX7RVrn8r7T9hwmmsLSQafKSswzwSkbUcIAnfASld2CAwlqZsgaB5ufjw60flIMBLsaVKB9wPg36vdAKh7MvVLTrBcStuD29i+NPWXDrDudEKfja70gVc5tiDpxM+Ty8kZW4+2sW0y+fjYUjZpHysaDuUQX49zhn7yzcMTg4c5TVMwxtRMsQ/Mdu4HpUfQ0Y8aifFPSukq7dScdIVr3sEZ8t86kpQFMAFVfrSYIO3ziyrfgMcHTJ6+6Yn52hSkfXl3lripNaBSJj81OCPqA1xfy9X9xwdc5sZVXl04XVdVImhQbFnAkD3ICPRLq6AsrvMxhDWNReILpwqVX5x7dkw3JTC8FLYKkC2K5SnD7uluDYELISH6GizNbDsDcC5j8ZTh3K+AGhnBCm2nw4Q3e+BvT5l9j1PK/xPTrhMc8hBhdrK4imrh9SLGFLlwBSIV4hdigEalsLjzr0VIOxLJtR3aHGFeQtuRTHbBs+cy/To8ghchWIIlqcQQgEyLIp8Xtvb8LB8SxbAwgqRoN+ogWWfbup4v8SpFqrbCpGBI7YyHyPdCNTy4SG398mvfdGbQSeHwpOTOng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(122000001)(5660300002)(91956017)(64756008)(83380400001)(6486002)(110136005)(36756003)(316002)(508600001)(86362001)(6512007)(6506007)(82960400001)(2906002)(66476007)(71200400001)(66446008)(66556008)(38070700005)(26005)(186003)(38100700002)(8676002)(8936002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3FJUDdVNitYcnV3ZWltdTF2VWh4Y2RML2hRSFdFWEJ3QzgybW5uZ0tWaEVj?=
 =?utf-8?B?czkyYVpPM21kaUtXV2tNcjNIUEdrc1dFZlNoVGJNWGxNMDVncVpHc3pUbTJV?=
 =?utf-8?B?NnN3OHRHMm5HdmlPOVFtUHMwbEw5S0h0RnRXRkdrVTkybFQwQWlDV0ptSS9l?=
 =?utf-8?B?U3BKbTNrLzVRVnlTWm9WSlZhOUlVWVlnTFNIVUNHSWRtN2VieHhPV05PVk05?=
 =?utf-8?B?SjZuQXFnTXgyNmVZaSs1cnEvNE4rMTVpeTBTZW02Vkk5WHc5aGlVVmEyZU5q?=
 =?utf-8?B?R2I1eVlNbWJkaXNuWXRySjI0S3BWTzRBVlVFbTZpd0xVR01wem1PQTQ2bGhy?=
 =?utf-8?B?bitlL0N6NjkydWRvdmNjRnZmUm8wQ2hBand6VG1CR3VvdkZURjhlNTZHa0xE?=
 =?utf-8?B?TDBmcWxKcmVGR2habjNpbW1ja21HSURXNWZQTUp2Y2lLNnlQU2o4R0R1SndM?=
 =?utf-8?B?THRyK05vMnVsNEtrcGpNaGMrUkhlZGFVaE5laFhmeDMrcHBnNFY2R3pneS96?=
 =?utf-8?B?RUYvcTZkTUlBdXFaOHF4VXc4eVJPdWUxYVM5QXFPblg5ZHBjWmlvVFh5d2NH?=
 =?utf-8?B?TXo1WlJMakVaT1owaklkbnRZTCt0c0l2QWpObytoQkhCL0dzMEtranFNNERp?=
 =?utf-8?B?RVpCeXdlcFZlUi9OQldXQm9ZOGViRnlNN1Z4Z21teUg4dDQ4OHEyMm1kMTR3?=
 =?utf-8?B?N25qeGoxY1pNMW1jV3hETUV3eEpLWDgzSENIRTBoSlRsUU9UR1B2cE16TUVi?=
 =?utf-8?B?aHpZdmFHd0dRZUg0eU4xYWZCMGovanBaWHJjTEoxZGgwdFlFcy9BL0JTZ3hs?=
 =?utf-8?B?NTg1eFVPZU1PV2UzQzJzUUdtVTVPczJUNStnNVlUaFZzQ2FKTXl3RW1tdXlK?=
 =?utf-8?B?WWN0SGs2MHBjWkRHSFpqMnc3VWJpVEZZeURYVU1VSG9INzBlVEpMVTR3WDdF?=
 =?utf-8?B?V05sUXhIRXBGOXZaaWtZbGd5STh1bTB6ZnR4aDdDcEptUlRTaVAvRG54OWhq?=
 =?utf-8?B?dklWa2paelFDQlU5aDI1MEdRYjNrM3dhd3lZdGlTSGhTeTFpeW5PNU13eW4x?=
 =?utf-8?B?Q0tnWUMrUE4raXVQZ3F4bVZNZWt2WWVYNmVwZWRXWDNTMVdhYXBGZ2JWSXZh?=
 =?utf-8?B?R3FoSXh0V1FMQWhJL2dhR3pjdDVoeThJWUlsRW9XTlBqNXJqTTFaK0phRFBC?=
 =?utf-8?B?cStMZ3kzZGhjT2UvTkl4NGQxNFV0d3RFUUhXWGUrcjluQzlRcENuWXZqUDlY?=
 =?utf-8?B?a1F6UnhFOHhhRGxVdldYWXgxQlJSOUgyS3Q3YVVUcDAwMENORjgycmtkS054?=
 =?utf-8?B?ZklNejhJcEl1NEhhSkhzNHZQbkNBMGlFRDRsTFJMNkc3eU11enhBaFNVdU1k?=
 =?utf-8?B?VHFhNHR2QlgxU00weDFvc1Zqd0Q2QXJxSzBSUHdkb0tVcXBGeHdCSGo4UmNN?=
 =?utf-8?B?UTJhWnphTGZTSTE2dWlUdCtEcE54SkhMZGhmNGYvczhrdTlIZHk4ekhXSGJ2?=
 =?utf-8?B?TEE1NmNvQU85V3RmV2MyYTN2L1JWeEE2b3FLNGNKT3Z6RDg2U0pCV0pCMTl2?=
 =?utf-8?B?NzhIeGV0VU9ZMTVpM1h5a2MzQ2tVandxdi9MMTA4TFplaWVpT25lV0NBbFhO?=
 =?utf-8?B?TElZNWxpVTFYOHRueE84akNnV1FmZ0ZQc1FGMW5ZYTRlUmZSZDU3WVBhYnRi?=
 =?utf-8?B?dG9oa1dKNU5lOG1VTkMrVHJvWFdzTkhTSzdFcGRSQ3VWS3IyKzFDMERoT1VR?=
 =?utf-8?B?T3hjUFNoS3RJaG9qaGFIb1pUWU5sb0ZLajc3VUhMNzU4SDJCZWhMYWczcFl0?=
 =?utf-8?B?cHI0YjFQeTZqTmUzSzlnOWZwSGRVZ0JtUERpU1JKVEZzZzd5YWsyU3QwNUxT?=
 =?utf-8?B?VitEdDBhOVRRU1BSS0N3MVpXdFF1Ryt5V3RjZDFUQzdCazBhQlpTUm93Mzkz?=
 =?utf-8?B?ZWNTQzJCZVBqUUR4b0lmajJmQUFVUVdnYnlsaWhLckwrMHAzYkxtM3k2RDIw?=
 =?utf-8?B?Y3h3WkZmQWNTMlQ5U3Uza2FuZE9oT2U2aUwzd1U0TTdqRVZqT1V2UjdxVU15?=
 =?utf-8?B?am5vUzZoUmc1em9WVWlRcDh1Y3BJQUxIL1VNd0YyZTVCTnhKeXo4QWdlYlpu?=
 =?utf-8?B?b3NvOFEySjEza3VJNEMrem1JcG1wY0VoWlM0b3luMCtMTUNkT2xPWTYzSDNk?=
 =?utf-8?Q?W8akdD28FSc8eKaQChCAads=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC57D03F07A5D74DB2E4A964ED64FD4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e43ae0-ed2d-4ccc-6511-08d9e81db684
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 20:34:16.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7f0urvLZTG/WEGOoTDAV2I2C7JuKL4TTIfkQCawgS7VLhFplVAwUqs0Qzmru9pPMo1kNhKhB/BOuFlynEJzMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3458
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMjItMDItMDMgYXQgMTU6MzggKzAxMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiAtLS0NCj4gwqBtZXNoL2tleXJpbmcuYyB8IDIgKy0NCj4g
wqBtZXNoL3JwbC5jwqDCoMKgwqAgfCAyICstDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9rZXlyaW5n
LmMgYi9tZXNoL2tleXJpbmcuYw0KPiBpbmRleCBiNDQwOTExNTQuLmQ4MWU1ZTQxMiAxMDA2NDQN
Cj4gLS0tIGEvbWVzaC9rZXlyaW5nLmMNCj4gKysrIGIvbWVzaC9rZXlyaW5nLmMNCj4gQEAgLTIw
Nyw3ICsyMDcsNyBAQCBib29sIGtleXJpbmdfcHV0X3JlbW90ZV9kZXZfa2V5KHN0cnVjdCBtZXNo
X25vZGUgKm5vZGUsIHVpbnQxNl90IHVuaWNhc3QsDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBz
bnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBkZXZfa2V5X2Rp
cik7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoGlmIChta2RpcihrZXlfZmlsZSwgMDc1NSkgIT0g
MCkNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKG1rZGlyKGtleV9maWxlLCAwNzU1KSAhPSAwICYmIGVy
cm5vICE9IEVFWElTVCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9y
KCJGYWlsZWQgdG8gY3JlYXRlIGRpciglZCk6ICVzIiwgZXJybm8sIGtleV9maWxlKTsNCj4gwqAN
Cj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+IGRpZmYg
LS1naXQgYS9tZXNoL3JwbC5jIGIvbWVzaC9ycGwuYw0KPiBpbmRleCA2YmIzNTMyYjIuLjEyMTNl
ZTY2ZSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9ycGwuYw0KPiArKysgYi9tZXNoL3JwbC5jDQo+IEBA
IC04MCw3ICs4MCw3IEBAIGJvb2wgcnBsX3B1dF9lbnRyeShzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
LCB1aW50MTZfdCBzcmMsIHVpbnQzMl90IGl2X2luZGV4LA0KPiDCoMKgwqDCoMKgwqDCoMKgaXZf
aW5kZXgtLTsNCj4gwqDCoMKgwqDCoMKgwqDCoHNucHJpbnRmKHNyY19maWxlLCBQQVRIX01BWCwg
IiVzJXMvJTguOHgvJTQuNHgiLCBub2RlX3BhdGgsIHJwbF9kaXIsDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aXZfaW5kZXgsIHNyYyk7DQo+IC3CoMKgwqDCoMKgwqDCoGlmIChyZW1vdmUoc3JjX2ZpbGUpIDwg
MCkNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJlbW92ZShzcmNfZmlsZSkgPCAwICYmIGVycm5vICE9
IEVOT0VOVCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9yKCJGYWls
ZWQgdG8gcmVtb3ZlKCVkKTogJXMiLCBlcnJubywgc3JjX2ZpbGUpOw0KPiDCoA0KPiDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHJlc3VsdDsNCg0K
