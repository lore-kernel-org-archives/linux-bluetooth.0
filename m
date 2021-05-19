Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03314C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA9A61355
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhESSfN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:35:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:55943 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhESSfM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:35:12 -0400
IronPort-SDR: emnYz21mBLJskAfEOEUxmY24w5fRXWz/fGA+qxkvE0wAzmp4w3T9RKm+yRQ0C4AoAt5t2w7/BY
 7UoWDUPortqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200743767"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200743767"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:33:52 -0700
IronPort-SDR: gcToqOKrTDx2H3jBYndq3ZauWuASIk+/L0LmXLBmy1Ws8tjwRvNPPvGTGILxGvhx0c8ss3HdvX
 JgE5iPFBfpRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="433595882"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2021 11:33:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 19 May 2021 11:33:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 19 May 2021 11:33:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 19 May 2021 11:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKHJMdYH6/LFxLi3c/bvzZCOzpZulRznst2zsfyVNRW5hoqLdxWIA+r0j18YC2cQgwZtVAcGOHLwg+RPHaLD5rd4LBv6NHmyNXyGZh5jCtywiFE3+M506JovKg2NveJKbYKWcw9C8+CakI8hq7kfSzWJ0ucibLP2tDhvOqlg+jBGHV79blV96JuEk/k/UHlcxyn6voFgsenP92U+QTsYffHjOk61/9h+8QUiShYFy6apxOeFXK9s6iagXz/Xca4QwRLT0hP2ksBLwV8cngg0OMVGUhiSvlTlY/l8iGYW0JmFmbDlz13RwvcgASqdqeruBg/mQ2ERPE6w9SOIhdAhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZ0TprF9kDhzWm8svSUGSUqo2BW/tiEws78FfZMOLs=;
 b=BU1AxMtLBr6ei8sDtIJsZEYpDnTuuVnEBYinUIl5qlC1C2Ynv+POT3Axiuoy4ESHdw8UK8vIMv39vXu4fA3OWBZOQeaVv4xfcYP/MkJqDr3FOJ6bAum8X/9tSIHENoqlYdZtPkMhpIRdeQ91vVfEJIDVlA2NHiKogVG5ZuYs5Wr69HJSIzoWlGOHuKqLXfXG9eivgpLPPkVXEqBo2pfiuIoulMJtnE6Y6PLOw73cibJ2QhVhvkTP3TeatEhcNG0zqYTtab3RP0PJsOUKgPsjkJNwyzX2D/m5Jftl23KL+3EE0/C0T7xtfdG5S5AipR/43B/8UF9a8FIX/prLt/Xdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZ0TprF9kDhzWm8svSUGSUqo2BW/tiEws78FfZMOLs=;
 b=aWd4TdwbIOzx5rz14by9fHs9oSxW3sdBYNb6lSjO3ndK4KLMZBqk80U63R0hEFST5XwmOHILkCnW5JDIG8jRxmWIEK9RCMes586BZbQrJe6x/JYoR/8e+KDjeyZrxJ9fy7kJZxwHGxRumRiTg2W7RYToj0u4YYfzPs3Sb1cArU8=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3022.namprd11.prod.outlook.com (2603:10b6:805:d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 18:33:50 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 18:33:50 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "tedd.an@linux.intel.com" <tedd.an@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 1/5] mesh: Fix delivery of PB-ACK to acceptors
Thread-Topic: [PATCH BlueZ v2 1/5] mesh: Fix delivery of PB-ACK to acceptors
Thread-Index: AQHXTNvpYfct+bxr1kKe9JoJuYPr7KrrIHAAgAAA3IA=
Date:   Wed, 19 May 2021 18:33:50 +0000
Message-ID: <cc032551703a8532e29d06531a43e34343925065.camel@intel.com>
References: <20210519182150.1680987-1-brian.gix@intel.com>
         <20210519182150.1680987-2-brian.gix@intel.com>
         <d09fc978849b33606d169a24f7405b31e334b066.camel@linux.intel.com>
In-Reply-To: <d09fc978849b33606d169a24f7405b31e334b066.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277c2cc3-e7ed-4e7c-f8e4-08d91af4a5ab
x-ms-traffictypediagnostic: SN6PR11MB3022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3022A724BC98DC57678D650CE12B9@SN6PR11MB3022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNpOqm84HHwV8FM8LVZxmwKphhNJcDg0pDvcU9SFWdd7OsgA7bc+fgp/gvXavDiL9cFbsm8+t+xr9EK7eDcsticjcbWNskeCHlDcMPezOur/01wd6ShycnklyqIaCONccq/zA2o2x/Te3j3WHBe9Gr2odS4GWt0xzHY24ly/zge5hYuJUrffJuccIJf3q3+evOh4hmbTYU+Tesn23FOMoxlr2Frkq5rxtU4r23GgQdJhZbFpKJ4S3O1h3WqpTSKTqGNiCgioYLipT5Ho5n/FSPP4+NNstLGxAO7/UxNkcF1DTHjHfqTxIsiS4gUkqztiMlVH8Wyv1JoNNyvRets0Bj7vu8W6GIbQhTF9lSUpBnT6CNGPdTbP0q0JmpZgCbX84qCQZSwPiajomLxMXcWbLyVypbF5WZVUfreN5mSmRP6FyGZLAjCJwmlTAd3OWn7l7yBgE/G46aNDGaK1mUKlrlaow0zfb2uth0c7P+SmVOm1qB+Npqpvtm876vWJjbyxOeHBlJby/m7VkwSqF0VUb0CLHhDyrqZ+RDGFMDwUoIWReFXRBDaBN4ZuMRaXxCXDWsa3hE6LFHzwLu2ecNxFy6yg2jNkwoWxLnBqTjBvyuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(396003)(376002)(66446008)(71200400001)(186003)(478600001)(4326008)(76116006)(91956017)(8676002)(6486002)(66556008)(6512007)(64756008)(86362001)(36756003)(66476007)(2616005)(2906002)(6506007)(26005)(83380400001)(122000001)(316002)(8936002)(38100700002)(110136005)(5660300002)(4744005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmJFak0vdTJpU3pTNDdBQUgxaVNveW43N21WdUNjN3REVWpxOHRXWGVIMUFP?=
 =?utf-8?B?a1B3eVViNVEzbHFOYkRxazlOSmNqZGthNytESDF1L0RyUGNBVzBWeDFZSm9y?=
 =?utf-8?B?WWNwa1lRN1dEbmtWOGVUaWpELzNtVkloYUVKVGJCU2Fhei9VaXFRa1AyQnhz?=
 =?utf-8?B?TU1vQ0tEZHVxYlFjaHRpMmFybzVBT21VRHFBWE9PN0VMYk9VVHpkRUNGZ0Ny?=
 =?utf-8?B?Q2wyOXB5MmtRSnhRZ3BMVytIRUhaNWl2Z0tNZzRWUzUweCtlOHM0Wmg3TDlZ?=
 =?utf-8?B?dWwrbDNLZno5WkxWT0hXQzZIZnI3cXpWVlE1NWhtNWtCaFNSRmg3WWFuVXhU?=
 =?utf-8?B?UWUydDRVSDlNNHpNM2I4Q2Z3VjdMaHpCVjFqdkFuQzJJRHllWHpSMHg5aHVZ?=
 =?utf-8?B?eXNxZ2RLZkZTdW1YWHlVTjIydFI2MmNZN2IwZzVMZGQzQmp5VlhON3NYZkR5?=
 =?utf-8?B?U21kZjM5dkZXYjNlWm8vYW1DeW9WRUNvMnlGYWVhM1J1NkNhZWNyUXZML2NE?=
 =?utf-8?B?UlJnUW4yQTc5TERiSDZqTExDbFVZbWlqYzU2Z1dTdjRhUFhTc1I5TWlJeDhk?=
 =?utf-8?B?RDR0bWVreFZEUWNqalVDM1ZrY0p4YW1ESTJaOFhsMW1qTzhwb3BVYTJtRmVG?=
 =?utf-8?B?dit6N1d6b3VXcnBzdWlienJMQ3hQcjN2M2w5MWFTaTl4NHRpNWF6RXRJdVhp?=
 =?utf-8?B?b1o4ZEtCQmVIRGNFT3FqWWhweHFGOVRJOXFRVlpxN0lzdE0wRVlsd0Vwb0lC?=
 =?utf-8?B?NUlHYkpLWWpqRC9rMjZQME1HbWlmVHpNbXcyOHNHc2I2Z2RTV25LN0x5dHR0?=
 =?utf-8?B?MEZyK0M4MEt6K3I2MVplZTVWb0NWZXR1d0luMk1uUlFCODk4WlBjUUkwaEVw?=
 =?utf-8?B?M0xISlBjV2VCUE5CMFVsYUJoanhDendnNHZ5SDJMbm82TmlwcDU0L0lHSi9l?=
 =?utf-8?B?ZW84bUdpcldpNDgrSDJVMTBuZlJQUkdsc3hzZXpmSUhFRUZkd3VZYzNBVTJz?=
 =?utf-8?B?N3RWT0dGR3k2R2cxRWl5V1FSaXd0aCs5dWF3V0R2aXpBM1BVdjdqcHFjYjlN?=
 =?utf-8?B?NElrNU5nTmovc3doUTI0NW5GaGNDVHdocHhjUTJMUWRMR0ZWd2M2N2FKZ1Uy?=
 =?utf-8?B?eDUzU0pjNHJ1L2Irc042MGpsT1lLVmRMZ3N3OS9hWnRqeVFOcGZudFE5dzZS?=
 =?utf-8?B?b3NVRmJoaG1KcGRLbkc5N0dsNUZmcXluVk4xN2hNRTZlb1pFc25NVXlsTW95?=
 =?utf-8?B?aXNHQis3ZWJreFdQZnFWSVIyZmVIaS9CbnpjUnpiak94VDB6cnc1SGdyd1Bh?=
 =?utf-8?B?OU5rVXlqMVY0RVBaWVJMdUtQQkVMUjNxRlMybTRNc1pjc0JIWURub29RT0Ry?=
 =?utf-8?B?dXJ5Q2lrcWg3YTl4a01hdUxvWkFpOFZhMFdaVHNSaEVMUU1XQkVhWExjVzVG?=
 =?utf-8?B?Qk5XODRMVldXZ0ZIN2w3RE5OUFVHbHdqTldSeC8rd2RnaGlibGpVL1Q0V3Ft?=
 =?utf-8?B?b2E2WVVGVkU1TlA2SVdESUF2ODE0a3FVdENSeDdsYUdsbjVjK2xlZnJ6MjZL?=
 =?utf-8?B?M3pBRnVaYlF4ZjdJanlRR0FVK2l6NTNiSnVPUnNQNHRsY1Y3L0tBamF3M3Nv?=
 =?utf-8?B?M2F0ZmhFL29YUXB4TnZZS1A4ZWVXb2J0ckI2UkRqaU83cEVRalFSanNMeitx?=
 =?utf-8?B?WGtObzhya3dBZTJ0UVkzc25RRG5vM3NrdnhxaTJGTnd0MWZoa1pwYlRSQ01y?=
 =?utf-8?B?R1ZrM3J2WnlJSDhZUzlYMXNGdjJEUlpNcG5kZHpqN1JiK2tLbGRSbE1UTkR6?=
 =?utf-8?B?dEErYS8vQjlDdTI1WHhYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71066DA582D4E4CAF222611DB588B06@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277c2cc3-e7ed-4e7c-f8e4-08d91af4a5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 18:33:50.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6veyCNKGD/4diplLXHyoDP7OODLwRyKF5IzPi+PwWF6wJ8taH9J49h18z2YCm0TfU5fBHJ/P/qYQ4jWIu5A3LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3022
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTE5IGF0IDExOjMwIC0wNzAwLCBUZWRkIEhvLUplb25nIEFuIHdyb3Rl
Og0KPiBIaSBCcmlhbiwNCj4gDQo+IE9uIFdlZCwgMjAyMS0wNS0xOSBhdCAxMToyMSAtMDcwMCwg
QnJpYW4gR2l4IHdyb3RlOg0KPiA+IFJ3bW92ZSB1bm5lZWRlZCBpbml0aWFsaXphdGlvbiB0aGF0
IHByZXZlbnRlZCB0aGUgQWNjZXB0b3Igcm9sbCBvZiBldmVyDQo+IA0KPiBOb3JtYWxseSBjaGVj
a3BhdGNoLnBsIGlzIGdvb2QgYXQgY2F0Y2hpbmcgYSB0eXBvIGJ1dCBpdCBjb3VsZG4ndCBjYXRj
aCAiUndtb3ZlIi4NCg0KVGhhbmtzIFRlZGQgLS0gSWYgbm8gb3RoZXIgaXNzdWVzIGFyZSBmb3Vu
ZCwgSSB3aWxsIGZpeCB3aGVuIGl0IGlzIGFwcGxpZWQuDQoNCj4gPiByZWNvZ25pemluZyBhIHZh
bGlkIFBCLUFDSy4NCj4gPiAtLS0NCj4gPiAgbWVzaC9wYi1hZHYuYyB8IDEgLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tZXNoL3Bi
LWFkdi5jIGIvbWVzaC9wYi1hZHYuYw0KPiA+IGluZGV4IGM3NGRhZTc5Zi4uODNmOTIyYWE4IDEw
MDY0NA0KPiA+IC0tLSBhL21lc2gvcGItYWR2LmMNCj4gPiArKysgYi9tZXNoL3BiLWFkdi5jDQo+
ID4gQEAgLTM1OCw3ICszNTgsNiBAQCBzdGF0aWMgdm9pZCBwYl9hZHZfcGFja2V0KHZvaWQgKnVz
ZXJfZGF0YSwgY29uc3QgdWludDhfdCAqcGt0LCB1aW50MTZfdCBsZW4pDQo+ID4gIAkJZmlyc3Qg
PSAhc2Vzc2lvbi0+bGlua19pZDsNCj4gPiAgCQlzZXNzaW9uLT5saW5rX2lkID0gbGlua19pZDsN
Cj4gPiAgCQlzZXNzaW9uLT5sYXN0X3BlZXJfdHJhbnNfbnVtID0gMHhGRjsNCj4gPiAtCQlzZXNz
aW9uLT5sb2NhbF9hY2tlZCA9IDB4RkY7DQo+ID4gIAkJc2Vzc2lvbi0+cGVlcl90cmFuc19udW0g
PSAweDAwOw0KPiA+ICAJCXNlc3Npb24tPmxvY2FsX3RyYW5zX251bSA9IDB4N0Y7DQo+ID4gIAkJ
c2Vzc2lvbi0+b3BlbmVkID0gdHJ1ZTsNCj4gDQo+IFJlZ2FyZHMsDQo+IFRlZGQNCj4gDQo=
