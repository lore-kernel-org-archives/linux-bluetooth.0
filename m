Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95715C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE061027
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhJHWmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:42:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:32754 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhJHWmk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 18:42:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213745328"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213745328"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 15:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="485152331"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2021 15:40:43 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 8 Oct 2021 15:40:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 8 Oct 2021 15:40:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 8 Oct 2021 15:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePyccqWHLlKlXtnpCwk4RLV1HqxItgzCtKnIyUMVzLfcn8kd1p7dEt4YE2SGKcdj2Bu7Bx/n/QtUIYhRX3HwsQSJbOlxJTVb+XP4BiwuBNutlCY/aV7UCAL2v0ZlkP1ZHWOLc8YlM5RBpbjZOCiWUBEhpZo+LJ5PPyv+3l4np0kie7eCci6Kvj5MZA6AxnkwzkBInCntBrSTwjXRuenqHLqOz8OEQR9HlbE7y+N1lQhSRLjOJshSLaeIN2bzgMBAr//LwOttA47c8FQTRJmCcxs2X2pwqICWGKcneZ+hpY1plrEWUKhTgf0OPlAP8rJVGYcrH82LR5i/tes4RPTKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UU/DzQvbeiLsNL2A/XSrnIkIgIvuKcRCZoJv/+K+nY=;
 b=jgreuciiVTpI+6JuOXoj08a/4Cvv+A5IK3UodugN3zWp11TjdPqlap/pke58E4PIsjDuGVQaPH7fcw9cQDsT66jdJdvxsX2gHLIogpNPu/3urYcZlkHbnudCRSr010RVKTp7DcWn+T8stmrfAAmu0z3D5rWyBXoEfHWlliTGYD0eY8dHuSSBd+YEOsfeH0iego1GW4KDQ/1V6e7d9mCrPS0beG5mXCDJRKjEM5lK5Nt46/4pltfvzYjF8L06N50bdjxj3hG3GRJ5i5VWuiQJ6IIiDuSx7v2yXHgnS2Pga8dwBVS6S36t6fGynWIWSXvM1xqVszb0Tukco2fNCyAEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UU/DzQvbeiLsNL2A/XSrnIkIgIvuKcRCZoJv/+K+nY=;
 b=JAsEkakczYL1Dr/U7L8iq9jdDYS8XV+4eJ9Te6YCM5tkkLNsGg25av/OTRXYEkpo1oHgo930C9/1qkVNS9OT8yWsihW8NcImu8mw+BdoHBCbO3wAC1LcVj9N/PFGPa8lvDAx1tQJPuD5sF+0EUcqGHJFpVx7M6egWjQ1lWPiLaE=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 22:40:42 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9%6]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 22:40:42 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfg-client: Fix NULL pointer
 dereferencing
Thread-Topic: [PATCH BlueZ] tools/mesh-cfg-client: Fix NULL pointer
 dereferencing
Thread-Index: AQHXvHUeE2nAc/+UUkeifqFLimEBk6vJsiGA
Date:   Fri, 8 Oct 2021 22:40:42 +0000
Message-ID: <af4f6dd5f1b8cc038967d582d3950a9fbbe21f1a.camel@intel.com>
References: <20211008184830.24276-1-inga.stotland@intel.com>
In-Reply-To: <20211008184830.24276-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b188218-a922-4a2c-2852-08d98aaca8ec
x-ms-traffictypediagnostic: SN6PR11MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2879EE61E93E714D03F11C61E1B29@SN6PR11MB2879.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PynYh8/wwntsNf19LOaivsr7xZuoBaOmFMWNIqcR73iR7+vAwFQaITnMG75mplU4Vtc2GwtIFJwaYKH8gu9FED/WCid5b3pe5zEpNJm8KP2rCAPYoVIROJasd1GQt3yMi4Uw7bqvMcXdjT1OsoSFDXk67szkeDnE2l6s9Mfzm2cRA4ImDwe+uUxu4jt60iXtR6qVrdvEIP4sl7Zk3ezcQ7pVb9VTdbglAKfca4OPa6w1RhUuM1OjEgZO67faN58CNg8r/vEHRHckeGSNS1PywGM5IjQpWiVkkjjNoS4kaZec2uIypxQYTral6FWORgFY2EsWqK73dgAII2W0PJsQo4Vx9Hq6byH42mucBp/rKi+ylzJiJi9Ia9PfQ/wn0Ow7+VAzj41OEEG6HdEclh+HRspsiVW5hiV0dIKZT2oxK4xFMo3SGGs8U7Onrmc2AmTU0SlC1f2ei5DFpabniSk6SmPu6X1i3EMU234HZ0TmQdHgovnaD9BtAw5TORIDqtCylISlEqpFxmtlotWSl4KgXQ63Xg4H2gwEAfYDLOB4rJanmUzvgMyv+e/UFJAfLj9JtAgeoclkw/9F9J9A5gdPnrRF5PrbwGwg1UX0hDXdik/yeT7XaTqyQkq9LpN/Ig8kc+/fI7PKBXSZIqj+EoiaVQHGoHAQmYWdOFnvJF94QYcsO2b0IYrdUkurNPI2qNuk9UCDFjhyxm7Ek5RaE5W8JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(38070700005)(38100700002)(36756003)(8676002)(5660300002)(86362001)(8936002)(83380400001)(66946007)(186003)(71200400001)(26005)(91956017)(66476007)(76116006)(66446008)(66556008)(2906002)(6506007)(2616005)(316002)(6486002)(508600001)(110136005)(64756008)(122000001)(6636002)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXgvd1RGMU13aTgwNXJBbERmdkxGdFlyV1dhd1B5S0IwbzltbHYzMk5FU0Zw?=
 =?utf-8?B?SzVRSzdaWXlVRlp6Smt6bW1xMHZJREpsY055bWwxaGw5aUVpS2U3RWcwd0hO?=
 =?utf-8?B?T1oxNDlGUThnbytMcGtMTmd1RXdkUlYyMGRHWmVJamF1WEtpbDdUWWNKZXZC?=
 =?utf-8?B?OFAyMTFtY1U5bzE1KzBSaTBnOWdqMS80eFpZNk03ek11cEpienhaWGhDQ0Ex?=
 =?utf-8?B?V1VlUmE1ZXNwbUFFY0FMazFSeEdMcG5vVnF0MmNJR0lrbFVaSXFOUUJTdVBx?=
 =?utf-8?B?U010UElrckZLQ2U3M3NNaHRNeHR6eEJJSmxuNXZNRDFlektvcTloZVNNalRU?=
 =?utf-8?B?UDRDWC9ybUJIMDc3WmkreElWSWNtMVNrTUdkQTJ5L2J0Z1BnT0Z2aGVaRjlB?=
 =?utf-8?B?WjlQMFdMeFhxVDljVzlXWnFycEdXQkV5TDdnNHMxOG92ODFmbUFKUmExcVdz?=
 =?utf-8?B?YVczUzFBQnlCVmpRWDZYV3ptbm9hTkJycXpKM0FvcnhvQ2tDMzFEWndpNzk2?=
 =?utf-8?B?ZGdEQ2YzOFdEdkNGVnRMVzkwNDgyejIyZmtRUy9qT2tDa1RxTmRoU2o3ZkpV?=
 =?utf-8?B?UmJCYjQ0R1B1MUFlNEg1WU1KSjdLL1BFL2hXZXFRdFloaFVZRzByd1dWU3Z1?=
 =?utf-8?B?Y3Y3b2FybjlCR2pPcnNYQTJnR0pHVTFjMlBnUUhvN3MvV2FlUlhXSUY0VFYr?=
 =?utf-8?B?TTlxODFhV3JhdzFzZVJnWUtab3BnQzRqZWI2L0RTbHNoaWxUeHBxRWljT2c2?=
 =?utf-8?B?amlzK0pmU2JDZHk0WW9yMlNOT0dGMEZBNmVWWlB4UkxEVjU2RHJoZmo3cVhq?=
 =?utf-8?B?S2R2S0JmbHdGMTl2YzFMYjNyUGl2M01YdGg3ZEVuTUl5STYvWFJDdko5aStt?=
 =?utf-8?B?YnB1dTRZMTNNeXZIUEJsTSthOTFmbnlrNWpoZVIrRVAyajhHWnVyM2J1Vm0x?=
 =?utf-8?B?WUZvbENtakZFS2VuS2VDaERnVDZHejdOL2thM1lFaDV4bkVJdzZrQ21EclV5?=
 =?utf-8?B?aFRSN0tYbllmTHpaYVhGSmIwV3gxMU4xLzhpRS8weExSLzlpaS9BMzZCNEVr?=
 =?utf-8?B?TDJDUzYvZGhRZmxPbUJ1OVpnSTNLR1ZhOW5tTjlFTmR6ZVdHSXk1ZnVKUmVO?=
 =?utf-8?B?amg3ZVcxWTNHckV2TVFmYXdVTHpENzd6d28ySkFySVVTSUVoYmlsSzdMSmx2?=
 =?utf-8?B?UjV4UTFKbERGck5sUmJjNFNHMWZBYTNCajVNL2dOSUN4dStxdVV1ek5kbG1J?=
 =?utf-8?B?VUdMVitIZ2gzSjNxOFdrVkdvYVZVekZ2NUYvaWZZbWFpUlhCYitaKzZaTW9N?=
 =?utf-8?B?UUVzUlovZENUdU9GZTlkMVZCNU9XbDBkZWFxZjBQTGdBN2VidnlWOTFwWVh0?=
 =?utf-8?B?enNGdVhvMm55Skk0YXR3bjQxK0pSeENMblpKZTdZTkxzRlVZV1NaN0daeVVL?=
 =?utf-8?B?VGl1TDRkU2tIMWhIUlhYbEd5dGYrTTkvZ2NNOU1INDZKT3dZR0xZN202dGcr?=
 =?utf-8?B?MXpuN1hiaVRwaVlLMG83YlZoRmdlTXZNa2gzWkcrUXhkYUE5eTJRNklJQW9i?=
 =?utf-8?B?LzAySGJlRWJpMWt1VTlNUExXZWQxWFRHZmFtOEdjVHJOcEtZcmtPK1FuZjNw?=
 =?utf-8?B?cGVQNTBodE16Q2YzQUhNU1NhdkF3U2JCclZCaDB5dWR4WWxIbVJrRmc2Wjgy?=
 =?utf-8?B?bmZDa1NkajZOTjkxYTdCMmEwTE9YWXFkM0tibXVuUm9Ed1BrWlZMbXBDTHQ1?=
 =?utf-8?Q?fFl9wcBXGd9RCUm7NrFqPXslGSlIlBBcivu4iag?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F55EEE7FBF6F419E82C7A123D261D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b188218-a922-4a2c-2852-08d98aaca8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 22:40:42.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEwVadCWXlFCA33e5IhZE0/ddo40TB005AZiQ1pX+WPb6RqiEtnjxxQmYekMVvuXx5naYGDuos+BWDgnD4GGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBGcmksIDIwMjEtMTAtMDggYXQgMTE6NDggLTA3MDAsIEluZ2Eg
U3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggZml4ZXMgYSBudW1iZXIgb2YgcG90ZW50aWFs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jaW5nDQo+IGNhc2VzLg0KPiAtLS0NCj4gwqB0b29scy9t
ZXNoL2NmZ2NsaS5jwqAgfCAyIC0tDQo+IMKgdG9vbHMvbWVzaC9tZXNoLWRiLmMgfCAzICsrLQ0K
PiDCoHRvb2xzL21lc2gvcmVtb3RlLmPCoCB8IDYgKysrKysrDQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvbWVzaC9jZmdjbGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggMmJmMWExNTAz
Li5mODE1YzUxM2MgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysrIGIv
dG9vbHMvbWVzaC9jZmdjbGkuYw0KPiBAQCAtNjY4LDggKzY2OCw2IEBAIHN0YXRpYyBib29sIG1z
Z19yZWN2ZCh1aW50MTZfdCBzcmMsIHVpbnQxNl90IGlkeCwgdWludDhfdCAqZGF0YSwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYnRfc2hlbGxfcHJpbnRmKCJQZXJpb2RcdFx0JWQgbXNcbiIsIHB1Yi5w
ZXJpb2QpOw0KPiAtDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHViLnJ0eF9j
bnQgPSBkYXRhWzldICYgMHg3Ow0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHB1
Yi5ydHhfaW50ZXJ2YWwgPSAoKGRhdGFbOV0gPj4gMykgKyAxKSAqIDUwOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ0X3NoZWxsX3ByaW50ZigiUmV4bWl0IGNvdW50XHQlZFxu
IiwgcHViLnJ0eF9jbnQpOw0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC9tZXNoLWRiLmMgYi90
b29scy9tZXNoL21lc2gtZGIuYw0KPiBpbmRleCAxMjA1NWMxYTkuLjFhMWJhMzgwYiAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvbWVzaC9tZXNoLWRiLmMNCj4gKysrIGIvdG9vbHMvbWVzaC9tZXNoLWRi
LmMNCj4gQEAgLTI1MDgsNyArMjUwOCw4IEBAIHZvaWQgKm1lc2hfZGJfcHJlcGFyZV9leHBvcnQo
dm9pZCkNCj4gwqDCoMKgwqDCoMKgwqDCoGphcnJheSA9IGpzb25fb2JqZWN0X25ld19hcnJheSgp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKganNvbl9vYmplY3Rfb2JqZWN0X2FkZChleHBvcnQsICJzY2Vu
ZXMiLCBqYXJyYXkpOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqB3cml0ZV9ib29sKGV4cG9ydCwg
InBhcnRpYWwiLCBmYWxzZSk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghd3JpdGVfYm9vbChleHBv
cnQsICJwYXJ0aWFsIiwgZmFsc2UpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bF93YXJuKCJGYWlsZWQgdG8gd3JpdGVcInBhcnRpYWxcIiBwcm9wZXJ0eSIpOw0KPiDCoA0KPiDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIGV4cG9ydDsNCj4gwqB9DQo+IGRpZmYgLS1naXQgYS90b29s
cy9tZXNoL3JlbW90ZS5jIGIvdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiBpbmRleCAwNTRkYTUzMDAu
LjZlYzIyMGE2ZiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiArKysgYi90
b29scy9tZXNoL3JlbW90ZS5jDQo+IEBAIC0yODEsNiArMjgxLDkgQEAgYm9vbCByZW1vdGVfdXBk
YXRlX25ldF9rZXkodWludDE2X3QgYWRkciwgdWludDE2X3QgbmV0X2lkeCwgYm9vbCB1cGRhdGUs
DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBrZXkgPSBsX3F1ZXVlX2ZpbmQocm10LT5uZXRfa2V5
cywgbWF0Y2hfa2V5LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBM
X1VJTlRfVE9fUFRSKG5ldF9pZHgpKTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFrZXkpDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZmFsc2U7DQo+ICsNCj4gwqDCoMKg
wqDCoMKgwqDCoGtleS0+dXBkYXRlZCA9IHVwZGF0ZTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDC
oGlmIChzYXZlKQ0KPiBAQCAtMzQzLDYgKzM0Niw5IEBAIGJvb2wgcmVtb3RlX3VwZGF0ZV9hcHBf
a2V5KHVpbnQxNl90IGFkZHIsIHVpbnQxNl90IGFwcF9pZHgsIGJvb2wgdXBkYXRlLA0KPiDCoA0K
PiDCoMKgwqDCoMKgwqDCoMKga2V5ID0gbF9xdWV1ZV9maW5kKHJtdC0+YXBwX2tleXMsIG1hdGNo
X2tleSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTF9VSU5UX1RP
X1BUUihhcHBfaWR4KSk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICgha2V5KQ0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKg
wqBrZXktPnVwZGF0ZWQgPSB1cGRhdGU7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc2F2
ZSkNCg0K
