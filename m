Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0696CC4707F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 03:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7BA6124C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 03:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhE0DpV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 23:45:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:55059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhE0DpV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 23:45:21 -0400
IronPort-SDR: QSXzxjLjcmT+/wOR7TExGY2gVqG4N4GNdwJx/qJcrMrJ2SleeyyvLQ+jwM3s8kj+bbkjhaz6v9
 aLKFVN480uXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189761138"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="189761138"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 20:43:48 -0700
IronPort-SDR: w1u+X92URbYBEjFSBDF0LAny0AxrfnhYuNG6Q9AbARK2slyw6RzPKxA1mz1fvYOoTl2+PAPd6X
 xcRWeuT1h97A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="443366361"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2021 20:43:46 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 26 May 2021 20:43:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 26 May 2021 20:43:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 26 May 2021 20:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogjxPpdeebwRLxIMdSbSYM7fIWTbV3jIggwlBby3zoClorlyk3p2SM/kWVuPmmV3mMNVDRc1zvM9xAXiWZ959uPURqY4PABy/F6c3Xj5oEJQTEMVW/230ZRxIQYzchuz3YGSHdNwQqDJX4YmNNWKghUfDl0BghU9XMUoFVr5JMsos4UEGroxdeAFMa6+xpDRM5BawF54noxhD/331bDtmFTgsWg0C39VaAl55+iVShPWf16ZYfb5dTP27VtV5OTP6T4zpsgfJxF7Hb0in9m9YJZY6NAqdP0vwaDDcu3Z6oP4ZENuOBWu+ETu8+uLclTMk948rZwXjBDkbTbMyd6qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8cjce9HZBZfE2dRPo95lvjV/t723G9Yb/3gwdXlFto=;
 b=VimrCaZ8S/RqM9XQU6X53OSnnrX1U1XEpdHE+9eGZbOd/l0SzBbFrkJYvXv5BTm/T0wvvhYMLu4af/GH10TBb+sZfNRkgvtsuyDbsNpX6b1aft4eC82O8ipAeG6mdfNp/sM1THi6/zvaVuuOIAm/907i/z1UA6Zb3poLg93QB+2dY9lEWM7KSFwxbg1BCGOd2oiEiq5bT5t39VQ2ntKXW9e07TagfFU6rOt9xLNFXt9CEJ7dVeDBARt9xp/UlI0MO3BVlE5Ptbs64Yt/t4hOuHc97+PoU58wIBHM/Q+SwKcfLyF9z6XNiO+UC59RaBN8BKsVP1kgnIa7puL8lp7eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8cjce9HZBZfE2dRPo95lvjV/t723G9Yb/3gwdXlFto=;
 b=o5PREls0T6srOcCoAD6uxgS1zo2/3gdr6Upp6gbWsujYDggru++xtnLTqMSRg/Z4ml0cI/JaxJsth3GNh7+qWYcKrmzK0jFCr6d7ClFkVhltusZiwpR3/PSx5dWoc5w5+XvwDXjTX7XTvJxIEp0f4+77MI+8QZgZ0PAfx4HX3Uw=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3534.namprd11.prod.outlook.com (2603:10b6:805:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 03:43:44 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::acc9:8813:eb2b:3480]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::acc9:8813:eb2b:3480%7]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 03:43:44 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "karl.westin@loytec.com" <karl.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Mesh: Possibility to combine functionality of bluetooth daemon
 and bluetooth-mesh daemon
Thread-Topic: Mesh: Possibility to combine functionality of bluetooth daemon
 and bluetooth-mesh daemon
Thread-Index: AddSRA+l/nJ10uo2QpybqLxzHaKHBQAZm4wA
Date:   Thu, 27 May 2021 03:43:44 +0000
Message-ID: <19a594fe9e76de00331e16346e316a50c06d0f0b.camel@intel.com>
References: <GV0P278MB012962632005A4784A9F243995249@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GV0P278MB012962632005A4784A9F243995249@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: loytec.com; dkim=none (message not signed)
 header.d=none;loytec.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38d50f8-6fb1-4a3b-5f31-08d920c1a0cb
x-ms-traffictypediagnostic: SN6PR11MB3534:
x-microsoft-antispam-prvs: <SN6PR11MB3534442D49AD19B52F5D0001E1239@SN6PR11MB3534.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkdjRlk6IJeCK8kgEpROLnK7jsVMSmjDgJlM0gRv/iJfogCs4DWEwmXy0JZmZ24aG5NBx/fSnEkquX9LMzbMNBW2px73S1S+jVRSzE8pcNphp9IyTFeJYFRx80ebskAafAFEQsLc5HvJUf5y6Gvdj15BsrLqqG1BK6b471Hzm6bjolNqBZ81n3PreRLevz5wRKXHj+ENxEydmf++UJL3Mo22BiBhhTZNMSycY1QcihYRygT/9aptHd7qgS/2TAcw5NJ/q1brRpQnnIBY6lvRHvYe1OnyGKyCHSKKDJLdZk/YkO27aEfwzBt9C4d/Q1wf9QhKQLvkJdtnNtiVSSIlncMtOaM0vy4llw1q1WvxY+M0XzQdQpD8NUMmyVzkfkYOq4Ifc0E/VAQCe7XRfCB+8xweRIzvoNSBMdi5zK64p/KX53IQrqdPOdKza/ECMS4Vb14AfZSuuoQmdQ0pHdoTUdYxD/OMYh06LoojcgY1dhQ27CR492KC1if3ACUir6U71WQDJ+yah2TQ1haU/iWbqkw2mBW4Vhs9xphd54LvIn5+FoQlDcRiC7cJCvSfbeDQPuv/aw/0wTAO6XBJ1ywhtbp5jZhl9nQNS6vpJ+POQoQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(26005)(6512007)(2906002)(83380400001)(186003)(122000001)(86362001)(8936002)(38100700002)(8676002)(6506007)(6486002)(71200400001)(64756008)(66556008)(66476007)(76116006)(66946007)(91956017)(316002)(2616005)(66446008)(110136005)(36756003)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UCtvZVA3eGxCWEVUdjZjNllSRVg4Y2FPMWFHTDV4WUhLd0ZvdjMwTzJSamFn?=
 =?utf-8?B?a3M1eVU0bk5xUklaRjc5M0FDS3VrU003cXU3dDBMWkU3OEhWYTFqem1vYnFN?=
 =?utf-8?B?Y2E2R2NSVHEwRHZlV2JpUEJqb211NjlpeXBzdmh3V05ZWCs1Ui84cFNtSzFT?=
 =?utf-8?B?OGU3WFRYSkZvc3BjMzViRnI1S1Rwck02N0RkS2d1NmRqUTJ3K1g5ckk0SS82?=
 =?utf-8?B?b0YxaGFZY2pDNm1BM1hrTStTTmNyd0Ria2FXVlBoR2FPQkw5dlJzSzd4RUQ3?=
 =?utf-8?B?Z25peE53QTBiT3pRRzFKM2w0Z0dydjhnM3lwR1kydThndkgvMVdDMTk4dnNL?=
 =?utf-8?B?QmdNMDl3dmdrRHlndTFzTDQ3bjBIQmU0UllrVS9ab2JUbEk4a3Y2SldYZ1Iv?=
 =?utf-8?B?TjRaaFZRTXcraGRyTy8vekM4ZHNTWEh0dEpXNVlReWpIWldhL0djVndsRWJX?=
 =?utf-8?B?NlJtbTdQV2xwblN0OFdkTEtsTENod0YwK0ZvS0RtbWZaUGErSHZSY1pDUTE2?=
 =?utf-8?B?SktmYnc5NG4zdU5LYmVqelBaeUFkM1AvWDZkaGlwZEdNYWNnbS9GUVVMVTVj?=
 =?utf-8?B?cHllTTdYK2ZDT3ZpcG83NXZVMlMzVVluZ1dTTThYeVQrVXNVOGd0d0lSNDY1?=
 =?utf-8?B?QkF2ekdRK2FXaXUvWldUN2FOVGs4aHNMOSszQm5uMW1jTWRQclJWRmFSTWla?=
 =?utf-8?B?eTVrbWhqSEpyWVRPbDhkTDhXM1Yxdk5JcjFua3h2eUJyRCtvbXZlRVZiUWhv?=
 =?utf-8?B?N2JsL2twcWdoZThKRVFweEU5QTJab0JZQjhIYTFiNmg3TlYvODZIT2J1Rjd3?=
 =?utf-8?B?RnBnTSsvMU1wSFRNL2EySmFkNThxRjR3bVNsdGk3MytuQ1lFd2k5cEYrTS9a?=
 =?utf-8?B?NHYxMnA4QWtBVU4rc0ZXbzVRQ1BnOHYwUjVuZXdMUllKU1VKRlVTazRkZDlz?=
 =?utf-8?B?a1kwZEFiUS85UUVFOWRnNGlobkRpQXl3MkhlNGthSktXQktiNGYwTmpYU20y?=
 =?utf-8?B?VjhJRE1PRlJUQm5qQTNHYkU0TDJubGh6QVhneUU4ekw0clZWM1BjeTJzUkl6?=
 =?utf-8?B?UlVNcEVsMFpsb3p2Y3lIQVdZL3dxM0Zld1Yxd0Z5MG9sNzNmZGFtanFlMWVK?=
 =?utf-8?B?ZkpZeEhYdFZoK1ZBcDA2c3E5L0hsd1cvbHNBZks0OG5rNHZQcVc2bGxhWmdj?=
 =?utf-8?B?cWR1NVRzVVcvTDFyaTZZVm55cm5ac0VtR24xaHZXQUFYRGVtcGl4ZXFkczFF?=
 =?utf-8?B?UjJrbjFhSGF5aCt5SVdBeHhJdUswY0NmSzRlNkVEUEJxZGlRUktVdkNtL2V0?=
 =?utf-8?B?N3BWdjNRbTlxcUptT0dkRUcyOERvWFQ2cHFSaUowZGczclZkVERQVkovblda?=
 =?utf-8?B?MlpjOGx5MzRaRjk4dTJFbVFadTBhekhGMisyUUpmOGxGb0c2WVhSTU5abnh6?=
 =?utf-8?B?TjNaTGdMVXJqU3Fhbkw5RXZFQ3N5V2hUdHliQ2hFaUxYaFNJc2RsMDJOMmFv?=
 =?utf-8?B?TmdsbHBVR3Z2WVNyc2RFTCtUM1ZueDZvdjBRN3R6S3N0N2E2OWU5ZVVORmV2?=
 =?utf-8?B?MitXUFdtdUY0NnFyTXJmNXM1NENGbklCenZWcGtQVlRuQVhqS2FqMnU4Yllu?=
 =?utf-8?B?MW9yeEhmV3JPaGlIdjV1elhxTGFKUk9Gc0NlcUZ6eGtlWFlzVGNEUE1zNWVD?=
 =?utf-8?B?OHc5SWpSV00vUVpXbENhZzlBM2d4SkZVTFhDSEFnNkduOTMwQ0Jrc280S0xF?=
 =?utf-8?B?b2lMd0VvMmNGSCtxSVRRRTdiWG1tb1dKdVNodVZqaFNTa2YzeVZPNlRSOElx?=
 =?utf-8?B?eW1hTVlLTzZPKy9FTmNjdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0071BAE644866344B74630E2A38B882D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38d50f8-6fb1-4a3b-5f31-08d920c1a0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:43:44.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+GadREi0Vs+QsZwLRl82g5HQSNC3sJ00Te2DbhqgygwU1JYAriXKeWM6jOKKXju3uj+O7K02Za4HgjAknK5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3534
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywNCg0KWW91ciBxdWVzdGlvbiBpcyBmaW5lIGZvciB0aGUgbGlzdC4gSSBhbSBwYXJ0
IG9mIG15IGNvbXBhbmllcyAgQmx1ZVogc3VwcG9ydCB0ZWFtLCBzcG9lY2lmaWNhbGx5IHN1cHBv
cnRpbmcNCk1lc2guDQoNCk9uIFdlZCwgMjAyMS0wNS0yNiBhdCAxNTozMCArMDAwMCwgSXNhayBX
ZXN0aW4gd3JvdGU6DQo+IEhpIGxpbnV4LWJsdWV0b290aCBkZXZlbG9wZXJzLA0KPiANCj4gSSBo
b3BlIG15IHF1ZXN0aW9uIGlzIG5vdCB1bnN1aXRhYmxlIGZvciB0aGlzIG1haWxpbmcgbGlzdC4N
Cj4gDQo+IEkgaGF2ZSByZWFkIGluIHRoZSBhcmNoaXZlcyBvZiB0aGlzIG1haWxpbmcgbGlzdCB0
aGF0IHRoZSBCbHVldG9vdGggbWVzaCBkYWVtb24gbmVlZHMgZXhjbHVzaXZlIGFjY2VzcyB0byBh
DQo+IEJsdWV0b290aCBjb250cm9sbGVyLg0KPiBJZiBJIHVuZGVyc3RhbmQgdGhhdCBjb3JyZWN0
bHkgKGp1c3QgdG8gYmUgY2xlYXIpLCBpdCBtZWFucyB0aGF0IHdoZW4gSSBvbmx5IGhhdmUgb25l
IGNvbnRyb2xsZXIsIEkgaGF2ZSB0bw0KPiBjaG9vc2UgYmV0d2VlbiBlaXRoZXIgdXNpbmcgbWVz
aCBvcGVyYXRpb25zIG9yICJub3JtYWwiIEJsdWV0b290aCBvcGVyYXRpb25zIChub3JtYWwgaGVy
ZSBtZWFuaW5nIGFsbA0KPiBvcGVyYXRpb25zIHRoYXQgdGhlIHJlZ3VsYXIgQmx1ZXRvb3RoIGRh
ZW1vbiBhbHJlYWR5IHBlcmZvcm1zKS4NCg0KVGhhdCBpcyBjb3JyZWN0Lg0KDQo+IEluIG15IGNv
bXBhbnkgd2UgYXJlIG5vdyBkZXZlbG9waW5nIGEgQmx1ZXRvb3RoIG1lc2ggbGlnaHRpbmcgc29s
dXRpb24gYnkgdXNpbmcgdGhlIEJsdWV0b290aC1tZXNoIGRhZW1vbiBpbg0KPiBhbiBlbWJlZGRl
ZCBMaW51eCBlbnZpcm9ubWVudCAod2l0aCBvbmx5IG9uZSBCbHVldG9vdGggY29udHJvbGxlciBh
dHRhY2hlZCB2aWEgSENJKS4gV2UgaGF2ZSBhIGN1c3RvbSBtZXNoDQo+IGFwcGxpY2F0aW9uIHRo
YXQgaXMgdXNpbmcgdGhlIG1lc2ggREJVUyBhcGkgdG8gcGVyZm9ybSBtZXNoIG9wZXJhdGlvbnMu
IEkgYW0gY3VycmVudGx5IGxvb2tpbmcgaW4gdG8gaG93IHdlDQo+IGNhbiBhZGRpdGlvbmFsbHkg
YWxsb3cgdGhpcyBhcHBsaWNhdGlvbiB0byBwZXJmb3JtIG90aGVyIEJsdWV0b290aCBvcGVyYXRp
b25zIChpLmUuIGFjdGluZyBhcyBhbiBvYnNlcnZlciwNCj4gYW5kIGluIHRoZSBmdXR1cmUgYWxz
byBhcyBhIGNlbnRyYWwgZGV2aWNlKS4NCj4gDQo+IFdoZW4geW91IGhhdmUgdGltZSwgSSB3b3Vs
ZCBiZSBpbnRlcmVzdGVkIHRvIGhlYXIgeW91ciBnZW5lcmFsIHRob3VnaHRzIGFib3V0IHRoaXMg
dG9waWMuIFdoZXRoZXIgb3Igbm90IHlvdQ0KPiBiZWxpZXZlIGl0IGlzIGRvYWJsZSBvciBpZiBp
dCBwZXJoYXBzIGFscmVhZHkgaXMgYSBwYXJ0IG9mIGEgbG9uZy10ZXJtIHBsYW4uDQo+IEkgYW0g
YWxzbyBpbiBnZW5lcmFsIG9wZW4gdG8gaGVscCBjb250cmlidXRpbmcgdG8gdGhlIHByb2plY3Qu
DQoNCk91ciByb2FkbWFwIGZvciBtZXNoIHN1cHBvcnQgaW5jbHVkZXMgY2hhbmdlcyB0byB0aGUg
bGludXggYmx1ZXRvb3RoIGtlcm5lbCBtb2R1bGUsIHRoYXQgd2lsbCBhbGxvdyBTZW5kaW5nIGFu
ZA0KUmVjZWl2aW5nIG1lc2ggYWR2ZXJ0aXNpbmcgcGFja2V0cyBvdmVyIHRoZSBNR01UIGludGVy
ZmFjZS4gIFdoZW4gY29tcGxldGUsIGl0IHdpbGwgYmUgcG9zc2libGUgZm9yIGJvdGggdGhlDQpj
bGFzc2ljIEJsdWV0b290aCBkYWVtb24gKGJsdWV0b290aGQpIGFuZCB0aGUgTWVzaCBkYWVtb24g
KGJsdWV0b290aC1tZXNoZCkgdG8gc2hhcmUgYSBzaW5nbGUgY29udHJvbGxlci4NCg0KV2UgZXhw
ZWN0IHRoaXMgdG8gd29yayBPSyBtdWNoIG9mIHRoZSB0aW1lLi4uICBiYXNpY2FsbHkgd2hlbiBu
b3QgbXVjaCBpcyBoYXBwZW5pbmcgd2l0aCBBQ0wgb3IgU0NPIGxpbmtzLiAgQW5kDQpldmVuICp3
aXRoKiBBQ0wgYW5kIFNDTyBsaW5rcywgd2UgZXhwZWN0IHZlcnkgbGlnaHQgb3V0Ym91bmQgdHJh
ZmZpYyB0byB3b3JrIE9LLiAgV2hlbiB0aGVyZSBhcmUgbm8gQUNML1NDTw0KY29ubmVjdGlvbnMg
YWN0aXZlLCB0aGluZ3Mgd2lsbCB3b3JrIHByZXR0eSBtdWNoIGFzIG5vcm1hbC4gIEhvd2V2ZXIs
IGFueSBoaWdoLXRyYWZmaWMgZGF0YSBsaW5rIG9yaWVudGVkIHVzYWdlDQp3aWxsIGhhdmUgYSB2
ZXJ5IG5lZ2F0aXZlIGFmZmVjdCBvbiBhIHNpbmdsZSBjb250cm9sbGVycyBhYmlsaXR5IHRvIGJl
IGFuIGFjdGl2ZSBtZXNoIG1lbWJlciwgd2hpY2ggbWVhbnMgdGhhdA0KZXZlbiAqYWZ0ZXIqIHRo
ZSBzaGFyZWQtY29udHJvbGxlciBzeXN0ZW0gaXMgcmVhZHkgZm9yIGluY2x1c2lvbiBpbiB0aGUg
a2VybmVsIGFuZCBibHVldG9vdGgtbWVzaGQgZGFlbW9uLCBpdA0Kd2lsbCBzdGlsbCBiZSByZWNv
bW1lbmRlZCB0aGF0IGEgc2VwZXJhdGUgY29udHJvbGxlciBiZSB1c2VkIGluIG1vc3QgY2FzZXMu
IA0KDQoNCj4gVGhhbmsgeW91IGZvciB5b3VyIHRpbWUsDQo+IElzYWsNCj4gDQoNCkJlc3QgUmVn
YXJkcywNCkJyaWFuDQo=
