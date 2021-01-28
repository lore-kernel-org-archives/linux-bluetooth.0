Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F84C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 22:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3764DEE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 22:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA1WV3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:21:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:35771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhA1WVY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 17:21:24 -0500
IronPort-SDR: kJZbkys4Da/WG9xCEoSvUFuv4VEfQYPZ4En6EsFwYghDinMOxgVHSfecegggSNKaKrE9qeQpuA
 ET05KAj+JhIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180465362"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="180465362"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 14:20:43 -0800
IronPort-SDR: yp0hagjyuRp7zCIc26p14/X5md5QiOWszMHAt7e70ef3AheTD5o9DKf8cHGdxVe3nkrnwEojLM
 z2YAoIFY/DCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="389023050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2021 14:20:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 14:20:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 14:20:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 28 Jan 2021 14:20:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 28 Jan 2021 14:20:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqbc1RNeg31+mf/+umzARlDgiIXz0yYpGejJ3FShy6een4XtubDLoo6ukssMHu6nK289Ao/MCpZhO0AoDRZ64qsSO7AIxWAXgBlmdh4fyC0bWiQvwGeCihuelxPKddW9yJ1hzNRT/p3gOnvK/Tmz4QJ7Of141HJOB6DX7Uu66B61e61qUMNa3lvKgsbItufBPsnO/O28mHOJ6oS5VIMh8b3TuGeHKTUHuAW8zsnjxq3Qf+1r/NCP+LrYkBpphXXnoMwvzLf6sZgO9tbarnayrcYkVBLIZAQInlDw3Aph+m+0hlsNASU81RYAzYlQKCm4rBSInvlUZ0O8dVhE+tvujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCOvyzZimNbmeE5sOOWwRfOSLGW/oIwAGQCiwBdBELk=;
 b=dDiDjiLUsqm4sx4GQvRiRgHtbogZ9LHIY2YKEmFplsRSchQfZ+2nBmdfVAZYL1EkUnv0EG0DCnftCSG/X+Q2Y4LRPJ/UtkKBSWy/X98DXX+taSYSz/8hySHOGyMPmuOLLsd+p7koWbeVLv+zXr9JLr3f06shl2mDRGe1g3MoJD2S9qrH4kKEZW3HCXkUkSbUvv/kCEHOYBEApywLe/Btb8mz+HOPvSGqayi0wGSwNS001qbIsMF0/kyR6hfb+GHszLTlb2qpRcFE1+RGs23JItlb5zJhm4akinXnvvun/VEybTtIpK1R2w5b51DOQee0oBdIIdAMktf50YI4dY13ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCOvyzZimNbmeE5sOOWwRfOSLGW/oIwAGQCiwBdBELk=;
 b=hj+5ZNN/4bu9eF1pbspcMVZezeL9OcX6pOrhFE3sooJCkGRJNMZe1/FJ900ql4dw/w/N0oDr5R9SFOef7+TrLd0+PDYcw5C2Z/YP0/G3mNgG3952S/EPnqC+Jcb/Yvz6zq3oujIuv/5fPUHlnnmwD6GoxlX0Uu4jjJNreWHYVlM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1536.namprd11.prod.outlook.com (2603:10b6:301:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 22:20:41 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%9]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 22:20:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "denkenz@gmail.com" <denkenz@gmail.com>
Subject: Re: [PATCH BlueZ v3 0/2] Fix 32 bit Compiler Errors
Thread-Topic: [PATCH BlueZ v3 0/2] Fix 32 bit Compiler Errors
Thread-Index: AQHW9QGhmDd4lBc5u0WMSaVdesiDUKo9nZsA
Date:   Thu, 28 Jan 2021 22:20:41 +0000
Message-ID: <1530928e428dcdfbf8b0c57c0c6cb049362b37f8.camel@intel.com>
References: <20210127231005.1579325-1-brian.gix@intel.com>
In-Reply-To: <20210127231005.1579325-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ebf29c-01a0-46ae-9232-08d8c3daf2ba
x-ms-traffictypediagnostic: MWHPR11MB1536:
x-microsoft-antispam-prvs: <MWHPR11MB15360864774E4DFA6D553D87E1BA9@MWHPR11MB1536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUvqfYkvlT1BAInmdRuW38G8GE0TB6cVutFYQ6Ntih9lM6YNT718Balo2FeI2+jcWPtxCrbU1VnKN5KnoUgsORObSVFS0g/8wPGoHENAK5BUQoEe/4FFv+4DGgcJJATzB1YBBMBvS9JNKm9NRC2TzS7ueoQDe/+BH7JAmRKhR1ef1knceb3lHd1kgYFZ7fIGEdbyFSlaa15XaPXlWTfUrhggC4fcfPZYlXVrgypaAwrmqUZJ+m+Pph/k6Be2gqKQvHCzkoJ0R1WMVrVU4knqzsV46A8klsr+ZdMqggctb7szAZDR9jpJUO1uhGXTK9A68HCOTjfx4izl+dwVLD3PpXd2/f1n+W0jjG0yrM6lXNbclwAALKIviQHSg/Kq0xleGtE/HnqyZZD8ljCf5tKiN9hO0mG8qd6JVc6UmBiMXV/GRGG/Vm/dc879ZY5jCsNLPtj8IyHXBGAYYr0BDiygeR9W4V4ChTLIiBzeNcQfCdyJ4FwTqlCjdwLwsV8RqEC3cELhWumNF0sKSM8zo8yVMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(66476007)(6512007)(8936002)(2616005)(71200400001)(8676002)(6486002)(6916009)(66556008)(4744005)(478600001)(86362001)(64756008)(76116006)(83380400001)(4326008)(66446008)(2906002)(186003)(26005)(91956017)(36756003)(5660300002)(66946007)(54906003)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NVhIa3NEbDdFanJ6aXFJTHc5cXRSNlRiZlpaWmEwOFd2K1BuNE52V2xpYVp0?=
 =?utf-8?B?ZTVLS2l5Ni9pQ3hmd2ExRGJ2TU5KNGZ2R2dUNm5GUGNxMEg2M3hWR2lUdE5v?=
 =?utf-8?B?Mjhoak1vc2tuVW9YTVl3VzlWbnpXSDZBUHpuWEVZdzZORG5TSHdjYk5udnBU?=
 =?utf-8?B?NTdLcys4ZXE1Rklua0YraXNuZ0FpaGVuVUFyZGMxMnNQaGNlUlJhOHhsRTIx?=
 =?utf-8?B?eGdXL3ZOejcwWWpRbnVVUjhvM2lUUU9lS2xsVmd3MGtXYUZzNmNJR3l4Z3ky?=
 =?utf-8?B?dVMyaGRrTlRKa0JYblJQWTBQc0dCQXRmd0RmdGE2QU56T1pJdDVPdmtXcU5s?=
 =?utf-8?B?ZGFQSWpIdXdNd2dwVUMwQnRhaGtQcUx3QXlFNTE5RE0yUGtXcVEreDk3WVd3?=
 =?utf-8?B?VXUyaS9XSlVKaXFsNzZuTCs2S05JbnltQkdDZ3RIRjlYcmRBaEZpNWs5YXlI?=
 =?utf-8?B?N1pGRGhtamIzYUFwTXdRZGFOSnhGSXJyTzNzR1VFcHY1MC9GSE1uQ3k1NThx?=
 =?utf-8?B?cjRYM09neEc1Q3V6cVYwT0JQT29yS0pzMTYxUVNzbzhJbm5oQVg4ZU9TNG5y?=
 =?utf-8?B?Y3g4WVJpbC9pTWZBOEVXaUhMVFp5azZQaHExcDlJL1QyeU5odGVnSEg3c2lH?=
 =?utf-8?B?OHltSWRicHUwZ2syWlllaDB0ZDR5N3prMFoxY2pTZzFmMjNieWVEVnNBQ1R3?=
 =?utf-8?B?YXpIZXh5eUpJMzdYNGxiemJjaVFEUlJ4YzVldDBnanRnZzhmbHgxbzlvUDN4?=
 =?utf-8?B?dUFpeldZTzc0QXROayt2TVVNeG1FWWxxTmFaUHhMTmR2bk1RN2gyMFN1UUUw?=
 =?utf-8?B?NjdPcEtNUHozUFJOd2o1NjlQRjFIeml0YWhUUWM4SmxwY1owa3IzTzE1UnJ6?=
 =?utf-8?B?ZFVkZmt6MGpiRzEzY0lQaUdIQ05Cb3BUWGhpNU9zaHhHMkpjYzhMZ0krenpn?=
 =?utf-8?B?cjhJbUREcy9mc1VIZHQ4M2V2SkZzekZVK1FHWjdRaExhMzVoTDBhSVROcFpU?=
 =?utf-8?B?R3V4UkpBUzFXWC9nMUs5ZkVGR3E5K0NkR0dGLzZiUGUrUWJ5STh6d1NuSlB1?=
 =?utf-8?B?SW15TDdYcEJ4Z0hkWFIxMnRBSVk2R0U5TmdUWEdWdys1enJXbWtpbCtVNDVi?=
 =?utf-8?B?dmdoOFBCRm5TS2w4dGdDZmJXaytYNVByS1hIMzN1K2lHbkxzcW0zbU43elNB?=
 =?utf-8?B?UDIvai9RcmhZNndJWDB4U3p6UW9KODZtaG8xMS9SS3hMamxoZ0k5TnJJOXJP?=
 =?utf-8?B?SFV0SndKRndHKzFFNkx2VkRWdWJwOGN0YkJoN05PeVNoL0xCbXArQUwwVVI3?=
 =?utf-8?B?VEduZGdVR09zN2ZJVDZPWXRuRjFFRE1VNnV1OWRYanNpejFFRWh4UVRYd1hS?=
 =?utf-8?B?bzdVcVV6emVlWHZOWkFHaEQ0eXJieFFMV3dWclRSa0RZNnlRZGZiVUVSWG1a?=
 =?utf-8?Q?eatbDk+/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C187AFF0D3F2FB48B612D1F03CC77869@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ebf29c-01a0-46ae-9232-08d8c3daf2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 22:20:41.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqSwGWsV4HGcYukSsQY/DeQz/zl0ayQYWQSl8k/ygD+2MS3j23hSplqz1V3HGnoChMAZ72mBIa1mxlNl7Vw8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1536
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMjEtMDEtMjcgYXQgMTU6MTAgLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gSW4gYSBjb3VwbGUgcGxhY2VzIHRoZSBzaXplb2YoKSBtYWNybyBoYXMgYmVlbiBh
c3N1bWVkIHRvIHJldHVybiBhDQo+IChsb25nIHVuc2lnbmVkKSB2YWx1ZSwgYW5kIHNvIHRoZSBz
dHJpbmcgZm9ybWF0ZXIgJWx1IGhhcyBiZWVuIHVzZWQgdG8NCj4gcHJpbnQgb3V0IHdhcm5pbmdz
IGRlcml2ZWQgZnJvbSB0aGlzIGFzc3VtcHRpb24uIFdoaWxlIGNvcnJlY3Qgb24gNjQgYml0DQo+
IHN5c3RlbXMsIHRoaXMgaXMgYW4gaW5jb3JyZWN0IGFzc3VtcHRpb24gb24gMzIgYml0IHN5c3Rl
bXMuDQo+IA0KPiBUaGVzZSB0d28gY2hhbmdlcyBleHBsaWNpdGx5IGNhc3QgdGhlIHNpemVvZiBy
ZXR1cm4gdG8gbG9uZyBpbiB0aGUNCj4gYWZmZWN0ZWQgY2FzZXMuDQo+IA0KPiB2MjogRml4IGJs
dWV6LnRlc3QuYm90IHdhcm5pbmdzDQo+IA0KPiB2MzogSnVzdCB1c2UgJXp1IGZvcm1hdCBkZXNj
cmlwdG9yLCB3aGljaCBzaG91bGQgYmUgYXJjaGl0ZWN0dXJlIGFnbm9zdGljLg0KPiANCj4gQnJp
YW4gR2l4ICgyKToNCj4gICBhZHZlcnRpc2luZzogRml4IGZvcm1hdGVyIGZvciBzaXplX3QgZGF0
YSB0eXBlDQo+ICAgdG9vbHMvbWdtdC10ZXN0ZXI6IEZpeCBmb3JtYXR0ZXIgZm9yIHNpemVfdCB2
YWx1ZQ0KPiANCj4gIHNyYy9hZHZlcnRpc2luZy5jICAgfCAyICstDQo+ICB0b29scy9tZ210LXRl
c3Rlci5jIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0K
