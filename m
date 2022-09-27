Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F4C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 23:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiI0Xhs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiI0Xhq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 19:37:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA01D1E1A
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664321865; x=1695857865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y4XYYNYdUdtSY8xurJnO6gveYL1Iwt1g3uxqDRXbSTA=;
  b=TgAEaI5EaWkICNPr5SlMNX+ymtkMbVmz7zwXR+cyPKXDHW7lS6+rpkHX
   ZKkn+StC+BARbjoHkzdJXRaH75B9AosI0N1EFi1jVOkmAI4zzvzI2tLh6
   7TT3T02P2IAvV4cA0BFtcH6bXhqM9/0U+BYPlurZ0Q7q+a5f82zWYpMww
   GWTsnR5tBTvLeSfFrN4TIXlDY8PiEgUMOzGYAVQWlBElUsfPE0LAB6x+W
   BYWgIePERblrtt9A5x+2dH4rY9VsXa4uesXCDn+3oTxO9gFSP1xmNqsMJ
   zQuCCEj6zJ9nhTTZCM2vnKp4e4l9SsT1rtJJO13NkfQeM3+ZCGN0FDZuo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281178272"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="281178272"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 16:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="866753922"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="866753922"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2022 16:37:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:37:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:37:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 16:37:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 16:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd4c1seSo1qg4WGET9Bs0oiCi4ifgD10kkUKzDqdkirwA0u3E/TNr+uXmsi9i89rVPu9kBk0xGZkCqmgHQD/i/Gg5iqFgCHM5+8DtSxDBxZinH0+qxkBJa9MoVMrZPNIAYxSJGMKDiGyxNi50ETgMK7VfyW5v3wMIkjtePLvPzzvQRDcrD7uXs09jIISB/dOGNNkswdr49dD5iSda27D0VxmxeKsrz5omTTk24KzWxj5c6QGyt27gGExf2gM9UxNw8vahl5QeI5TBLKqg+9b+Cq5G6PuO/V6MgJlOO0U3KUn5sP7t8bz6rrCXTQ92Vf7RzEyVXGIsMF1ts78VTj0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4XYYNYdUdtSY8xurJnO6gveYL1Iwt1g3uxqDRXbSTA=;
 b=DnPPzWXZeXfmoh2IJC0JXQDAB/d6s1yC67wT8Zmn5De24f/PVr6O4zTt3B9KmjjVal8lLlwOw/DkqwB9SWzGYBMUMG3Fz1+pycUHNBkTUu86P21Oy8o1bI/AKtLGKnV4ceyHEvolg9w8E37MiFdOze0y3Z7l6Wj5sc5u5/ecNO9OsxkvIDL2cgaxLOVLQghhhgbINkduvAX2SMcdkkz7uDZh2dQfLhjx4Qb0RGmnE44Umj+iZYqaBXtxgFmVrtAxmxRYR9ZYRswjrSf1wJb5fYzfOyqn4D4P2A/WmlV/E3/tYlc/cdnqdf3y9V9x7aRohroX0mRhqYaBGjINCCirPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 23:37:41 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::11ef:309b:d5c6:6dad]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::11ef:309b:d5c6:6dad%5]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 23:37:41 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>
Subject: Re: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
Thread-Topic: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
Thread-Index: AQHY0sQ9aXRhrXpe4kGe/J1F7Q6x7a3z7rsA
Date:   Tue, 27 Sep 2022 23:37:41 +0000
Message-ID: <72f0133e435ae22c13457b1a902b974b3770e2af.camel@intel.com>
References: <20220927225514.278400-1-brian.gix@intel.com>
In-Reply-To: <20220927225514.278400-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4748:EE_|DM4PR11MB6455:EE_
x-ms-office365-filtering-correlation-id: 1765e5ee-506d-4e0c-2afc-08daa0e1453f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvfMUumppAfvY6JVRUYyvxoFq1pF4MTlVguKW9OxK7SzQOqvNnrEATdsnv2rQzbIlIvsVyB5r1vieRaueMT7upqtpUs5yDJaadSWx+os86ViydJqiDQ8fi8wEFpPdSj2FDToP4jlWidTvkIw2x33G31yLdBgvthX/Uixd8Vunf4crJjXv8NZNJdbS6U1vrkwmNunv5KENi/XWp4SCg20GlwZGGR+QXj26FC1uCunTCayB7bZrvTzJXGpon0mFsQ/d0dm6d1/xJnZahbMHdZPf0GGBNNFleqIgoj+wFXGRdkjnJlVLAE+UV3dY1/sb6IUaQeqfSikyzXmlPk92PPKYBC0KsdZI/C/vfhOJpiRfYmCngpNNSec4JR91Y0kQ/XWhTnTrsBgIdf3420iK+RdCskmEdWeRu0gQzSSqE516HXj4VDiWmnNya/bYstSRf9MRASYzcoLgJvLiU4WUuSgXIodwWay6fDBPh6uFTK6QdyV6mOWZN4NQtLKSjY6Wm5JDYdNijI4iwXnm8DZ+MUTwIWfFc2dHYqzaxNg7TQlpPnsWUU1Qz1vtg+QsOv2v+THNaTBhao1A0aqx5tD/zuLzVDiaq3BO8508T+Cnk2t8SRNWookvBaJPz35PcEY4CcSgX1EwISVfw+IM+hJ7Ixl88d9v4mzYBf0MJ8+JebPitYwLhvq4USNzlyvKhoFKM6tpYkG2lPnlt7QxLukqaFsjyNiKn6w9/fY7J3FWBR6Cj+yeifmXSWwZTmbuRjEEpbSwrlbbE0TywGHLQSuIdW3XtN1JPpwjI3KUcms4m7uza0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(82960400001)(38100700002)(86362001)(36756003)(38070700005)(122000001)(2906002)(186003)(5660300002)(6512007)(2616005)(26005)(478600001)(6486002)(71200400001)(6506007)(41300700001)(76116006)(316002)(8676002)(110136005)(91956017)(66476007)(66446008)(66946007)(4326008)(66556008)(8936002)(64756008)(80283002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3BIRXdhSkNiU3RHRytYRDl2Z1RhaEYvZFV1d0Zsc3M2OXBOTnlnb09BTDRP?=
 =?utf-8?B?R2Z4VnVVZ3U3dEZEOFNObjRkMlhZdmJjNWcwb0JzRXpHVHBUYTVmZXFNUmY3?=
 =?utf-8?B?TDJadmFiRjNMWWE3dU1aeDIvOG1jYmRSeTBmcnFzOWtOS2ZOZ1hMV21mcWJ6?=
 =?utf-8?B?K1pFcW9hQTBzWnljRHZCUTVBQlhyS280cUlYRGlMc3BMSUpRSCtUWVNteXQ0?=
 =?utf-8?B?cDFhUERaYXFIWE5pTTJXQzI3TWJzWDNFei9Iai9NRFFNWTVueDJSQkcvMFNG?=
 =?utf-8?B?cUFqMmxQN3dVelN1dlVHWllWamRWdWVTZ1pma3lWc0IxaXBHNk9FTnBOc1JR?=
 =?utf-8?B?d3VROUk5eXhHN29UNnBXZktQUUlPZXRFYllWY1JjQmlTL3kyWHNWR1RmRmJD?=
 =?utf-8?B?TnU5Tk5DdGs2bjZuK3VVVEdycXFOYTJGR2FReWhEeUFqeTRhOGYrMFdYZnRu?=
 =?utf-8?B?eXZDbTVWWTNjZ0RrYzVUTmFqbjB3cDNET29VcGI1UG1iWVFYaG9DTmpnRC8w?=
 =?utf-8?B?bDlDemtVNXV2VmczR1I2SmdsbGlYWkpkY3pQNHJLc045TUp0R1Z1SWR6K0JL?=
 =?utf-8?B?YUJXdFFESTMyNnMrb0dVNmhCTmVxb2lNNFpKazVRZDNnK0ZmQUhOdXVSdnhC?=
 =?utf-8?B?Q0pFcGxDMy9IeGlxa0JGaVlBdjFRSEZVMFROSXAwdmIwN0FqMFdDV3ljbERp?=
 =?utf-8?B?TmxZSzU5WlM2RjV2RTcwSDhtM3dvR0dtd2xMU05oby9mTUxieGV2UkF4K0JX?=
 =?utf-8?B?YnRFUDVSb05JY0svL21RbXk0SmVrcHFDN3Z2TkVRRUhMREk1MWJPTFNMNG81?=
 =?utf-8?B?S2Nxc1NVVkljNnNYMHgxUm9CWTlacmNHNkZyL0NkaWMxTUpaZlBuOHJaLzFt?=
 =?utf-8?B?OUpPa1dVQ2lzZFdFUmw3aHFPMUMvanJDSFpZYml5b3ZaVzlMbUFvajROZk5L?=
 =?utf-8?B?QXo2R2JnQ2pvWTE0RGJVWFgwY1pVR3NhaElhUnFVbmREbDlQNHdaMXJ5SUR6?=
 =?utf-8?B?NlNjVnB6T3pJenozUDN3TE1rVU5oTkp4N1dycWlsZjRQWHVvSTFNUjdTbThY?=
 =?utf-8?B?bkJleDZacVg3Wm55dnhIekVyRDdqOVhPUVpKTHpHcmtyeEZ4ZTQydnhFYkpv?=
 =?utf-8?B?UUR6YzJxSlZFNWR1RHRuUlNLcTNIdk1VSXQ2SG9xMXZQOGdxeUdUd3R2NVV5?=
 =?utf-8?B?WjVpQU9pOHphU205ZFBaMXJuTjBTcHRyZmpQOG5DZURKdktqY3JlZERxQWJS?=
 =?utf-8?B?TDh6emt0amsycnVGaDdlbGdBVlluSTUxdkFGSyt4VWFFTlJkbXc4WFl1b1VM?=
 =?utf-8?B?T0FoTCtXMDB4ZHJCMGVKdlFqZ3huMkp0bitwcE9QSkdiMXFvbFBhaG1xbWVZ?=
 =?utf-8?B?cnAxeUtXWUI5L3NjTnI5LzVsWVRPVVRSeWZMUzRLRHFLZko1VUY2NldoaCtL?=
 =?utf-8?B?RmpwRE8ycWl0T2ZHUjF5NUFiQTAxNXJZdDlPbnNyN2xDUG9nWUZpcWNrd25n?=
 =?utf-8?B?clNnMHJiYjVhQkpIRHN3a3dwb21GYXJxZkFpVFZQWUtDVExEdHZoNVlJN3Rp?=
 =?utf-8?B?VERXM1QyenNOd1hnNTlhOG1Eb0tVT1paOE81NWwvQ3d3UjFlb085UHF1bWtC?=
 =?utf-8?B?eTc0eUVzZnBiMmZGTGptU2xuSWYzOVpnM04vNkRvY2tCa1I3eEtscXBiRXBo?=
 =?utf-8?B?L3I5eGtMbDVmR2czWVJJdnZqc0M0aW1WeDBDTTU4S05ZNGhLYnlCQXlmZ2pW?=
 =?utf-8?B?bFVOenA5alNSZFZNV1k2UkhKZk0wTTBCbExPNk9wN0ZiTVlwT2lTaHdGTHYw?=
 =?utf-8?B?NVVUTWRPN2UxbyszTXZKaEJOUGgyYzd1c3J5WVdRMWN4cTJMSDAxVXBFa0Zx?=
 =?utf-8?B?Sm11anNXRWVCeTFzeGtjWjVzOCtFUERmcGNMZE8wbEI3TTkzcGVERitNR3lU?=
 =?utf-8?B?THVwbkhaeXVGTEhTYzg2S2ZZd3JneGdOeEtLU2FuUkYrbHV0Q01UMVQ5RnZU?=
 =?utf-8?B?RktEY2M3eDN2SVNFWjRqbWg5UUE3WE5CYmJuOUtNSHFFZSt2cDlXSnJOazRB?=
 =?utf-8?B?bi9vTXFaeVBabm44NFJZZkhEVTNEWjJhNGEzK2xHc0VMelBqVU9qSWRhT2ph?=
 =?utf-8?Q?LF/MMF0AhuGu+Oq8RYLYNStwZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC0035A42C6B00498064DEBB9DD2AE3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1765e5ee-506d-4e0c-2afc-08daa0e1453f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 23:37:41.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NYAPAY5df2PARLZ8gmWH3uJyPoFWBlcDhnXvm4eK6e1aLH0c3v1B4wTU7x25gxRTpnqVxJuEZyDclX9hF9Bkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCkkgdGVzdGVkIG9uIG15IGxvY2FsIG1hY2hpbmUgYW5kIG5vdCBhYmxlIHRv
IHJlcHJvZHVjZSB0aGUgaXNzdWUgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaC4NCg0KVGVzdGVk
LWJ5OiBUZWRkIEhvLUplb25nIEFuIDx0ZWRkLmFuQGludGVsLmNvbT4NCg0KDQpPbiBUdWUsIDIw
MjItMDktMjcgYXQgMTU6NTUgLTA3MDAsIEJyaWFuIEdpeCB3cm90ZToNCj4gVGVzdGVyIHdhcyBm
YWlsaW5nIGJ5IG5vdCBjbGVhcmluZyB0aGUgSENJIHF1ZXVlIG9mIGV4cGVjdGVkIGV2ZW50cw0K
PiAtLS0NCj4gwqB0b29scy9tZXNoLXRlc3Rlci5jIHwgMTIgKysrKysrKysrKysrDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9t
ZXNoLXRlc3Rlci5jIGIvdG9vbHMvbWVzaC10ZXN0ZXIuYw0KPiBpbmRleCA2NzgxYmQ1NjUuLmQ3
YjNiNmY5YiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC10ZXN0ZXIuYw0KPiArKysgYi90b29s
cy9tZXNoLXRlc3Rlci5jDQo+IEBAIC0xMzQ1LDYgKzEzNDUsMTAgQEAgc3RhdGljIGNvbnN0IHVp
bnQ4X3Qgc2VuZF9tZXNoX2NhbmNlbF8yW10gPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAweDAyDQo+
IMKgfTsNCj4gwqANCj4gK3N0YXRpYyBjb25zdCB1aW50OF90IG1lc2hfY2FuY2VsX3JzcF9wYXJh
bV9tZXNoW10gPSB7DQo+ICvCoMKgwqDCoMKgwqDCoDB4MDANCj4gK307DQo+ICsNCj4gwqBzdGF0
aWMgY29uc3Qgc3RydWN0IGdlbmVyaWNfZGF0YSBtZXNoX3NlbmRfbWVzaF9jYW5jZWxfMSA9IHsN
Cj4gwqDCoMKgwqDCoMKgwqDCoC5zZW5kX29wY29kZSA9IE1HTVRfT1BfTUVTSF9TRU5EX0NBTkNF
TCwNCj4gwqDCoMKgwqDCoMKgwqDCoC5zZW5kX3BhcmFtID0gc2VuZF9tZXNoX2NhbmNlbF8xLA0K
PiBAQCAtMTM1Myw2ICsxMzU3LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2VuZXJpY19kYXRh
IG1lc2hfc2VuZF9tZXNoX2NhbmNlbF8xID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgLmV4cGVjdF9h
bHRfZXYgPSBNR01UX0VWX01FU0hfUEFDS0VUX0NNUExULA0KPiDCoMKgwqDCoMKgwqDCoMKgLmV4
cGVjdF9hbHRfZXZfcGFyYW0gPSBzZW5kX21lc2hfY2FuY2VsXzEsDQo+IMKgwqDCoMKgwqDCoMKg
wqAuZXhwZWN0X2FsdF9ldl9sZW4gPSBzaXplb2Yoc2VuZF9tZXNoX2NhbmNlbF8xKSwNCj4gKw0K
PiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9jb21tYW5kID0gQlRfSENJX0NNRF9MRV9TRVRf
QURWX0VOQUJMRSwNCj4gK8KgwqDCoMKgwqDCoMKgLmV4cGVjdF9oY2lfcGFyYW0gPSBtZXNoX2Nh
bmNlbF9yc3BfcGFyYW1fbWVzaCwNCj4gK8KgwqDCoMKgwqDCoMKgLmV4cGVjdF9oY2lfbGVuID0g
c2l6ZW9mKG1lc2hfY2FuY2VsX3JzcF9wYXJhbV9tZXNoKSwNCj4gwqB9Ow0KPiDCoA0KPiDCoHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZ2VuZXJpY19kYXRhIG1lc2hfc2VuZF9tZXNoX2NhbmNlbF8yID0g
ew0KPiBAQCAtMTM2Myw2ICsxMzcxLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2VuZXJpY19k
YXRhIG1lc2hfc2VuZF9tZXNoX2NhbmNlbF8yID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgLmV4cGVj
dF9hbHRfZXYgPSBNR01UX0VWX01FU0hfUEFDS0VUX0NNUExULA0KPiDCoMKgwqDCoMKgwqDCoMKg
LmV4cGVjdF9hbHRfZXZfcGFyYW0gPSBzZW5kX21lc2hfY2FuY2VsXzIsDQo+IMKgwqDCoMKgwqDC
oMKgwqAuZXhwZWN0X2FsdF9ldl9sZW4gPSBzaXplb2Yoc2VuZF9tZXNoX2NhbmNlbF8yKSwNCj4g
Kw0KPiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9jb21tYW5kID0gQlRfSENJX0NNRF9MRV9T
RVRfQURWX0VOQUJMRSwNCj4gK8KgwqDCoMKgwqDCoMKgLmV4cGVjdF9oY2lfcGFyYW0gPSBtZXNo
X2NhbmNlbF9yc3BfcGFyYW1fbWVzaCwNCj4gK8KgwqDCoMKgwqDCoMKgLmV4cGVjdF9oY2lfbGVu
ID0gc2l6ZW9mKG1lc2hfY2FuY2VsX3JzcF9wYXJhbV9tZXNoKSwNCj4gwqB9Ow0KPiDCoA0KPiDC
oHN0YXRpYyB2b2lkIHNldHVwX211bHRpX21lc2hfc2VuZChjb25zdCB2b2lkICp0ZXN0X2RhdGEp
DQoNClJlZ2FyZHMsDQpUZWRkIEhvLUplb25nIEFuDQoNCg==
