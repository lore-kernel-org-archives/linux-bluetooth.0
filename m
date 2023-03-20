Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F22C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 20:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCTUPD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCTUOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 16:14:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D830B17
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679343277; x=1710879277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5W2JNzGfvbDfkGQNsI9n5lhhImY7NPcqzijiu003PhM=;
  b=D9gJJxQ8rKX0py9K9yqBdVVT98XNlk1zqikFzdpE3t4qlCwITzojlUan
   qTZN1gRc9QtIeUAbwWv5jLwTh47gfJzZWVH7AZcpsGwBgf62SPguwQIK3
   EZjUVfdG5urVPQE6dATe8RnEdiiRoXNJyekDBja+QCwI5d5xujrPrgDyo
   Z7G4ps+glwROERmTrPKVrYJHz67BEAd7kyrGxZT0KWJl2Ek4JaWzIssp6
   8f6Ge6WaXYQwntip3uQGmlAfXHMzTL8873hRFZIbLGT94I9kNIc7rCfWX
   VJH2vcGRAusTZWeUOV7ZfCOL+cvTMeedefwGPqBAtFKvoMDgiZ3skL6M6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366493678"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366493678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745530839"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="745530839"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2023 13:14:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 13:14:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 13:14:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 13:14:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 13:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPfp2H0UN2rx8pk5gW4T0N493Nzmcvgi7KiMTta+3A+6m16+Qqf39wYmeVcpIN8npZFBsHhn4bipbp6aqRT6uAu+Qz4BDIzsE5DLaAbdVbDb2GEvxvvz13pojr53HpsOWVC0y51yntqaQCu9c8pLIETo99I5arS52puGKl1a9N+iyTGs+HqWkkJwsFnPirKOPHdswIECYOmBOnR4cgTvkrzVecH3cCKsh2BnzhOYadfjPjJOz5P9pX4rWZCI6PiY/t5gOjS+7dy/ChWXhI3FBTHh83BQpNt8Hcc+zDqwvkE41p/mNlz9YWRiy1zw9udYZO0DNOY+BbaVl0+m7kqQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W2JNzGfvbDfkGQNsI9n5lhhImY7NPcqzijiu003PhM=;
 b=oHe8Jhv50sT+tmd4rCvevocdaoVNpGd8x6LmD0c8OxHLClD71UkU3qFoX02+k86amwwKynUEHj8SDjO3uWgg4gm+BRS1hqB/UALslUoZ5O940zj+mcAH0HgNsmFnoqQ3OD8HDZilRsFv3OwOZEYRsDQNmFwPRZEaNLMbkT0TnXmchNKjH2WZbeCVwJBqs57USS4+m+oZXZ3xLEuVgNUNjUmcVZVe2VrlJKu0nZJxsPUB1uKRb6xcXAfG12r93w7OOyVOQFx6ANoQbpgAFJxu+jeLvD23CVwTpUweRe679bOCZlCo7+LeYJwkRv/Ba/oCFlATPv9NIU/JTj8uoxJI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 20:14:28 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::f0a6:4316:85cf:f597]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::f0a6:4316:85cf:f597%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 20:14:28 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "inga.stotland@gmail.com" <inga.stotland@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "brian.gix@gmail.com" <brian.gix@gmail.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Add local address check
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Add local address check
Thread-Index: AQHZW1bFVZCVb+RTT0eLfAywyeuCqa8EGnaA
Date:   Mon, 20 Mar 2023 20:14:28 +0000
Message-ID: <3476a5a39e8f65123a22be58e9b9e5a4b6fae2c1.camel@intel.com>
References: <20230320175825.321702-1-inga.stotland@gmail.com>
In-Reply-To: <20230320175825.321702-1-inga.stotland@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4556:EE_|DS7PR11MB7857:EE_
x-ms-office365-filtering-correlation-id: e589c177-2019-40b7-c3d5-08db297fb59f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJw2mdQts8/pHhCE7t1BgN0EFARKK9qX/DUNe1wQIrUUvhdzPzAH7y4F91CgJSw01QfMpgMkSHBL4DRPL6gqJDxNFn4jVU39Paro+U+IDhL+KtVl6JYNKNlPhjswY16+O8RZ/hZq24rqMywBvPEsI8kFWtVZXiTdPwqXqib/4iR8t01dVZ427x0GuZmbKXhQSxzpAQE7A3JxUxBq/jRuxc0FcMyFEs+o9EfJGaxWAokn6P8WFT/2+B4JNWkeNoJvedGPpm9+lCz5a88ynpZHiTvq7LJNF9EPAk8vIsnPt9HByhNy+O490PrNx/uhkD/f4dwJ1Nbf9TL0HPQAGD1MZGUsfta/u7ICSEQYbkECe75rhhrjdGBEKONcuWqpUxfs4mLTpqxvU7wIW6D7dXJlwKG3kPH61Fjmi4xgfpyDWTfUNxp4trnUXhEGonyt0e6Fu4ckTq22H1x+OhZz9RuuQpBCMwwyooeftWwfW6Je4hWSzRSd11boWawtCFJ6N75Z1WZZ9oxhwT2nrixYcxXARxSyETYL2tRPoRTEsjfVg0dvtTiIATTssGQ/F54sCe+QwC4cSMLyXQJdYDhJ8FB46m6JbcjTiWYnIoBSFuwc9Wwr84838bxbQf5gOTwemYe8QOzsK/sRXgZuMYDShSZasHnLpEKra0sK8z1n+WzT8DKgXe5zOnh0Vr4MzqCNKArjRcm4QCUYjUuUtSijtg/djg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199018)(86362001)(36756003)(71200400001)(83380400001)(66556008)(64756008)(316002)(4326008)(91956017)(76116006)(66946007)(478600001)(66446008)(8676002)(66476007)(186003)(6512007)(26005)(6506007)(2616005)(110136005)(6486002)(38100700002)(38070700005)(8936002)(5660300002)(41300700001)(82960400001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blcrZCtZeEpuTmxlYjlqazlFanZYK1hIWm1FeFEyL1pNb0RzbDNIdkY3dVZx?=
 =?utf-8?B?L0lJTGpzT21Vdk90M2pmaU9mNWZYSE9wMG9wVGVGVUg3S1hBdWkwU0ZOVFp1?=
 =?utf-8?B?NkhoUkdPSG1TeEkyR0QxODd1eG4wWHBvWXNjRG5pYjRFb3Y2OXp6QUZXS3l1?=
 =?utf-8?B?RmVFSE85eXh5cm0zWENETHM3T3EzN29CeVJvRHhmZzVCSmlvSDA2aDQvb2p0?=
 =?utf-8?B?eDZVTHVvN3V5RTZHMnRFcWpkSnVBcDIxNFlPN2QwSko5SXZMRmhvaVVETFNm?=
 =?utf-8?B?VkFpVXBlUlBxUFVZK3dZQ0FCWkxCZy9kOXlZYkFVeGNFU042TElncmtvekk5?=
 =?utf-8?B?WW43QXVSd1c5eTgyZFRRSHppUmZUenMxM044Q2xoY1ZRYXU2SWtacGVEcHF2?=
 =?utf-8?B?SkpWSWIzLzRZN3V4U1ljb1BjY0NoWmN0YXpGL2hoL2l5TG1JSUdod3FUK2Jv?=
 =?utf-8?B?aXo2b2c0SFI0Qi8yQWFiOThFUnRVVDFibUkwZ2VsREM2RkN1SjRLeGRiZWJE?=
 =?utf-8?B?YmpEejh5SXhFU1d2ZlNZUjJwT1d1TnFUajdCcXQyMU9IWitrZ1ovRWNndCtO?=
 =?utf-8?B?V1VaM0xhNWRuV1dJNnVLb05zTnZsOWdlenVCME0zR1JqS0ZITThtZE9Ienla?=
 =?utf-8?B?R3BLeW5ZT1NZaVNqTGpKRnZGZ1hPUUduem5ETGFRN0EyY1JUYVF3ci9EVzRu?=
 =?utf-8?B?ZDIvMUpCNitPcTVyRUVGY0FRV0VyWHd1ZHBRZ2paR0c2RDRVWVBTUFJvTklW?=
 =?utf-8?B?UUJ3QlZuczV3a29BZmxaVHlKd2xCcDIvQzBPaERpRXpDaHl3WUV0RmgzUVc1?=
 =?utf-8?B?czc1cnkrYjdHRVpnQVI1a2RGOVVqM25iTmp6ZVNHUytHVlNTdll4MEMvVm1Z?=
 =?utf-8?B?c082alJXVmFiamtvZWUzQzcrc0RqRlRvd3p6UHhlTGgxZG1ZQ3FsWTFwcEpG?=
 =?utf-8?B?MFRKbVAyL3pCQXFPbENwT0RJUUF3d2NQN2NBNUM4cVpabUNMeUxWcVNTVlZl?=
 =?utf-8?B?dExHeUh2T2xTZHAvdENBbnZJRlVodzdrR0tsQ2NYcHFMaUlPTWdLRGF3eHZY?=
 =?utf-8?B?bHhYZWNkTEJBMUhhTTFoc0o4YmgzWW9BaHhoT3g2ZGZWOTNLWno4U2prSEQz?=
 =?utf-8?B?UkwrdUFxdEt5SXN2ZVRYNHhROC9PZmhvU0hOcW92RG55MFh2eWlveStXaHJ0?=
 =?utf-8?B?dXVxZEZKK1QzVFBvQSsveHJFOHJXZFJFRGxaUmpGQzJCVFpWSnJVblRuWWsr?=
 =?utf-8?B?MHhKUWc1R21XWjRsTjVWa0UxM0ZUQVRkR0dwY2J2cm9hd21ZdGFETHhNMWV2?=
 =?utf-8?B?c2RNTzAzaWVlL3VCYWhwVXlNZTEzQ25iZlZDUWdaUWJlVjJ2Nk1IczVhamox?=
 =?utf-8?B?MkEyeWxwVXVSb3dqYUVqK2RoZUp6MVp3S1BrOTUwS3VneGhLTS96cHVoOGFy?=
 =?utf-8?B?YVYyd3QvWmphTUNwU2ZvR01vRjNiTkpoYmhacHltdXVOQXF0SDNqd3JEM1Rx?=
 =?utf-8?B?Wml5Tm9BZEljUzhOSytLdVpmdkJuWm51Mnk4ZEw1ckVlazY5TWwwVzZHSkgx?=
 =?utf-8?B?blJTNVFBWnlRZWgyMDlqRmhKWldqMjYxUk1VODNoUDJXKzAyY0JpblpKK0o2?=
 =?utf-8?B?ZEJLUks1YVlld0pnd3J2QnNOZkFzTFJWc3R3NldOK3M3NXZPeHBCUWhhOHZq?=
 =?utf-8?B?S1FxRUxaYjBsRTZEbkJiWndEc2ZiYmd3c1JqV3ZsMGtEL3pGT3U1SEVwVmJY?=
 =?utf-8?B?RldSdWFWN3YzSjl6clVrOHFsZ1NnRldRNCsxcnVReFNMb3pkelNlU21iZjF6?=
 =?utf-8?B?ZGpWQjB0bWhwVUI3OEpIZnF4Qy9XbGVmTlR3R0FsUkFXZ3ZzUEJZdDZQTzVN?=
 =?utf-8?B?bzNoTG9OclZQNXh4bERhY2JZSWUvc1lUdFVJWnFyL3RQMzJhaGQySnI3djUy?=
 =?utf-8?B?VHZHN2FuWi9lWHVPcFhRcE9xeEFIVlVFZGwzR1owU1hpeWo1QWREb2xrZHRW?=
 =?utf-8?B?WjlmMEswQU1sUVY1cWRDMGpWTGNqbndSUTY5R0VUTld1d0FjTjVsOU5IVEx3?=
 =?utf-8?B?WDhEV2xsSElnOU9yM2NCRlVzNXAzOFljNGk4ZzVpNzNZZUNvandpdEV6YlZa?=
 =?utf-8?B?aWtIWWlDK0o3U0p1TlVyN1hrZ2JmczhZS3dXcmFoUitRSHJ6Rmk2ZHVSOFNx?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9230AA548CDE2A46827B7E03FFC78766@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e589c177-2019-40b7-c3d5-08db297fb59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 20:14:28.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYcfVKAdn1tPXxrRiH25x4jz51PwpsI2ZFw4AodADzRTMcSWQtTn3zBqF2elZCd8TFvu2drSR+OdUNx/xsNVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RG8gbm90IGFwcGx5OiBmaXggbm90IG5lZWRlZC4KCk9uIE1vbiwgMjAyMy0wMy0yMCBhdCAxMDo1
OCAtMDcwMCwgSW5nYSBTdG90bGFuZCB3cm90ZToKPiBUaGlzIGFkZHMgYSBjaGVjayBpZiBhIHJl
cXVlc3QgdG8gc3RhcnQgc2Nhbm5pbmcgZm9yIHVucHJvdmlzaW9uZWQKPiBkZXZpY2VzIGlzIGlz
c3VlZCB3aXRoIHRoZSBsb2NhbCBhZGRyZXNzLgo+IC0tLQo+IMKgdG9vbHMvbWVzaC1jZmdjbGll
bnQuYyB8IDE0ICsrKysrKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC1jZmdjbGll
bnQuYyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMKPiBpbmRleCA2ZDJkMzQ0MDkuLjgzNjliMzQ1
ZCAxMDA2NDQKPiAtLS0gYS90b29scy9tZXNoLWNmZ2NsaWVudC5jCj4gKysrIGIvdG9vbHMvbWVz
aC1jZmdjbGllbnQuYwo+IEBAIC01OCw2ICs1OCwxMiBAQAo+IMKgI2RlZmluZSBERUZBVUxUX0NG
R19GSUxFwqDCoMKgwqDCoMKgwqAiY29uZmlnX2RiLmpzb24iCj4gwqAjZGVmaW5lIERFRkFVTFRf
RVhQT1JUX0ZJTEXCoMKgwqDCoCJleHBvcnRfZGIuanNvbiIKPiDCoAo+ICsvKgo+ICsgKlRoZSBk
ZWZhdWx0IHVuaWNhc3QgYWRkcmVzcyBhc3NpZ25lZCB0byBhIG5vZGUgZ2VuZXJhdGVkIHdpdGgK
PiArICogQ3JlYXRlKCkgbWV0aG9kCj4gKyAqLwo+ICsjZGVmaW5lIE9XTl9QUklNQVJZX0FERFLC
oMKgwqDCoMKgwqDCoDB4MDAwMQo+ICsKPiDCoHN0cnVjdCBtZXNoY2ZnX2VsIHsKPiDCoMKgwqDC
oMKgwqDCoMKgY29uc3QgY2hhciAqcGF0aDsKPiDCoMKgwqDCoMKgwqDCoMKgdWludDhfdCBpbmRl
eDsKPiBAQCAtNzc3LDcgKzc4Myw3IEBAIHN0YXRpYyB2b2lkIGF0dGFjaF9ub2RlX3JlcGx5KHN0
cnVjdCBsX2RidXNfcHJveHkKPiAqcHJveHksCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqAvKiBSZWFkIG93biBub2RlIGNvbXBvc2l0aW9uICovCj4gLcKgwqDCoMKg
wqDCoMKgaWYgKCFjZmdjbGlfZ2V0X2NvbXAoMHgwMDAxLCAxMjgpKQo+ICvCoMKgwqDCoMKgwqDC
oGlmICghY2ZnY2xpX2dldF9jb21wKE9XTl9QUklNQVJZX0FERFIsIDEyOCkpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9yKCJGYWlsZWQgdG8gcmVhZCBvd24gY29tcG9z
aXRpb24iKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gQEAgLTg2OCw3ICs4NzQs
NyBAQCBzdGF0aWMgdm9pZCBzY2FuX3N0YXJ0KHZvaWQgKnVzZXJfZGF0YSwgdWludDE2X3QKPiBk
c3QsIHVpbnQzMl90IG1vZGVsKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2Nhbl9k
YXRhICpkYXRhOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKG1vZGVsICE9ICgweGZmZmYwMDAw
IHwgUlBSX1NWUl9NT0RFTCkpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKG1vZGVsICE9ICgweGZmZmYw
MDAwIHwgUlBSX1NWUl9NT0RFTCkgfHwgZHN0ICE9Cj4gT1dOX1BSSU1BUllfQUREUikKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqBkYXRhID0gbF9tYWxsb2Moc2l6ZW9mKHN0cnVjdCBzY2FuX2RhdGEpKTsKPiBAQCAtMjM2NCw4
ICsyMzcwLDggQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZQo+ICpqb2luX2NvbXBsZXRl
KHN0cnVjdCBsX2RidXMgKmRidXMsCj4gwqDCoMKgwqDCoMKgwqDCoGtleXNfYWRkX25ldF9rZXko
UFJJTUFSWV9ORVRfSURYKTsKPiDCoMKgwqDCoMKgwqDCoMKgbWVzaF9kYl9hZGRfbmV0X2tleShQ
UklNQVJZX05FVF9JRFgpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmVtb3RlX2FkZF9ub2RlKGFw
cC51dWlkLCAweDAwMDEsIDEsIFBSSU1BUllfTkVUX0lEWCk7Cj4gLcKgwqDCoMKgwqDCoMKgbWVz
aF9kYl9hZGRfbm9kZShhcHAudXVpZCwgMHgwMDAxLCAxLCBQUklNQVJZX05FVF9JRFgpOwo+ICvC
oMKgwqDCoMKgwqDCoHJlbW90ZV9hZGRfbm9kZShhcHAudXVpZCwgT1dOX1BSSU1BUllfQUREUiwg
MSwKPiBQUklNQVJZX05FVF9JRFgpOwo+ICvCoMKgwqDCoMKgwqDCoG1lc2hfZGJfYWRkX25vZGUo
YXBwLnV1aWQsIE9XTl9QUklNQVJZX0FERFIsIDEsCj4gUFJJTUFSWV9ORVRfSURYKTsKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqBtZXNoX2RiX2FkZF9wcm92aXNpb25lcigiQmx1ZVogbWVzaC1jZmdj
bGllbnQiLCBhcHAudXVpZCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxvd19hZGRyLCBoaWdo
X2FkZHIsCgo=
