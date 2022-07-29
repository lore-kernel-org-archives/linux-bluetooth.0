Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42330C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 06:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiG2GBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 02:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2GBb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 02:01:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE019006
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659074490; x=1690610490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7DxW7GV1mLnaw9E9eQ6rZ6o6j+CZ7nPe12XyuACQjCg=;
  b=PcKr2jFJmIZa+hR3Dp1OieNhcx++pvsHfcCHQtRMuUyqqZoqqASpbvDH
   +00JbrzZKmnVpmAqsTbdFeBrCOQmPbt9MMXGIPQTx5nW1FCwwqwsntz7r
   vj67Mz7RXR2Wp4Jl16r5Jn3+t6Y4+20erT/60Qm7bymZVgs474icgtsZn
   kJTlRw4KL+DOAeseORpMVVEjmE/8eMBgcYMfxJpylHc0mdxOor0zmOJn4
   bsJ83erZnnm8nyPUKaUsnz15PpXb3UFPPNpqwBYuOsUmsaJXGC+2H51j3
   JQDGshj9LcRViB0MLNwi7hqjMrXf1LI21gwVGzOV4NKAbGxNMty8t0Myx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286248952"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="286248952"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928623571"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 23:01:15 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 23:01:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 23:01:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 23:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neMJZytSnaWaBQdkZZFQ+SIBOkR2s8UbYddItFa/cShjQVxsvg0XqDtibhBJEm7upqj2RJqWaoEFGIyJ2AnuWXWzQtEANH/FhDhXM9d4XZJ7doMz7doBVQcPlOfV5HZudIFMMAqQShCfDtjsS0mcTvY98MFBPPM24sVCc9BBuORjDxkb9KBiaIwl46Ji+F/deIuTN3FIIBJ4OR3VfAZAOoTn4OtJj3ISXxjKZNQw5daBQ7aNYE1m4Fw7k3BkK+olmaSQDhQuANf3sa5VQK9i7tq/XeA2BKlyyTnr+sHqqE/GV2ns5iBlUPPwuELynhHt+tHMu1LlWjZjBo+iz/0ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DxW7GV1mLnaw9E9eQ6rZ6o6j+CZ7nPe12XyuACQjCg=;
 b=GQU9H4z9FGqh2zxrqzbRkLUvvOwSAAD8TnTkOnBiQAu3pUCLg69OKdTLtmryfhnU6+DyWMJXagg9W8EmmzlOgMPxUi9ebzcY7b4+hGdmT82MWb4tUYA/sVXk95PaqX1nL/dQdLkxrQzz/AoNQiHpBdQyXos3CHqjsyEYR5Po+UM+wquPVho+Vhnl8C3Y0kmv4mO5upsCjaA1l1fCs9jMTNqjJn7VOn3nOiC3V2o4AzlEAaTk6Qg71W0r821g4YjEUchzsilliEQPXMF4kl/ZsZokqNaDjrC9TGnA4LL0+tCrTHJoKSWgcoNsh/YyibsJffV933tvrucxwLyeKA2cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 06:01:13 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::b001:3aca:1ff6:6dba]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::b001:3aca:1ff6:6dba%7]) with mapi id 15.20.5458.025; Fri, 29 Jul 2022
 06:01:10 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Set global bus earlier
Thread-Topic: [PATCH BlueZ v2] mesh: Set global bus earlier
Thread-Index: AQHYn/12UuDmwmfT00SLyqQx6wR/962U4TeA
Date:   Fri, 29 Jul 2022 06:01:10 +0000
Message-ID: <2e1acb1b01a42f4e6503cc12d5e866bf355655b5.camel@intel.com>
References: <20220725080549.4163484-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20220725080549.4163484-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d244c948-762a-4f56-2fe9-08da7127bc6e
x-ms-traffictypediagnostic: MN0PR11MB6112:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9770FQ3LRj9bnk/F6V4IM5pR9D+GOmJ/47iSCaoE9Ezb5OLW3/9AkZIJt7NNNRkwIPM9JefiDGYKCxyGdvZNcyYW0wbOC0CMU3azHouaE3E5c1mrtT3sBziNInxHQh0CBvq7X4M4WxKjCrwn5GBwYvqLwYXuLdA49vMHrKJtzBD2xLmn4kwRoVS+SKG7ud0KCZwJWVbONxLWbtQc/48K80Qf+q4iG0YtoNgTxxtJ9eft1+ZxtoXv4g7JP1GbeEshOYF0sHqQUKQKybZcmhJ+/eW3LVwYmB+RmIAcFF3KpM4lBn3N7SFiO3bY9qylTdcLm2hzJ2dTH5TOXZDxNXgbg5cpcF86QtKddOKkkAT6jfK1262J+Y8P7dZA6pSGA/BW17bBy23CWUW1aAX81kS+kR4m9jWHf5vnvr8RsOQDrjF4U1m+V4Rovhu4r8k7aEHfB+p25f6GRXfp1SSRhp09eixrxILDkMmzWKQzlrlZ1m9HbQejbiJW3rxx3S4qxoo6GSMK4ptcXO6mh3eeJ/rvfap3GbQ7GXZFkDStVNp3h821LAq3zCFnhL+6wmUSLirESzQqcvoeFbj+1iDaZrrGBQz+ACyYH2ecVNqpIkLc/ONEg5Mcgd3v1GTQJnIvUIH1wzF1+BBkRFP2AVyVZjNN1ck7afaE0h17SBDMsHM+fDgTkPtS2nZTJ+cEmQpkATRibjtqjijB/rTwmhPSPoR5JRVwBKYod+GNH/PJ5u8o1Z2FFop7TAvF91IzHh0WqjuQfgCKP1eKT/RgNSpzruJ5F54AnSYMSvTbArB2c1UY3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(376002)(346002)(36756003)(38070700005)(186003)(5660300002)(122000001)(83380400001)(2616005)(86362001)(26005)(82960400001)(6512007)(66476007)(66446008)(66946007)(38100700002)(91956017)(64756008)(8936002)(66556008)(8676002)(6506007)(71200400001)(110136005)(6486002)(107886003)(4326008)(41300700001)(316002)(76116006)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a20xOUVnc0ZzektmeTlFeXBHbnpuR1Y0Vkwyc255R1VicENwaG4zdUwwYVh0?=
 =?utf-8?B?UjNQYitnelhRVTJQLzUrQ3VPMVk3WDF6bGVFa0FzcnZmbmRVT1NKN3BLRmhX?=
 =?utf-8?B?RWZYMUlyQ2Raa2ZRUHBGZ3NYRDZxRnZLVk9LdFZuUUtBYXhtb1duU05GVlB0?=
 =?utf-8?B?aElJWUs0ZzZyalcwZGxjYm9pQXpIYis1WG1nZlpnelV0RXg5YUx3M3gyUE5y?=
 =?utf-8?B?WFpjSWtZcDFhOVkxU2NZSGs3NVZ3WWdZOVhvZGNOUHpkRGY2dUVoQ3Ixd1BN?=
 =?utf-8?B?V3ZVdDZYc2dDTDN4RlM1TVg2OHBmWFl4cXR5eStXYU40QXg1OEJRdXlCMDhI?=
 =?utf-8?B?a3FQRUZEelQwdWZOS2RRbmJicTlIRzNrV3ZVd3FISlBsL1JmU1RUL1M0blNE?=
 =?utf-8?B?c1FMM1BZU1FFeGFEZTZoUi9XS2E5eG1ldXJBRXJCaTNLaXROZ0pDbTlDdkFn?=
 =?utf-8?B?elh2NlVYaHhhcWYvMC9LQmtaUnV6c1QwV0g2TFQ5TkdMVzNGdVk0Q3BzYnBs?=
 =?utf-8?B?YWU3VHpuamRsL1hzUys1TXFDeFBvbFJldmUxZzR3NXZ0ZG1zR0ZvVzlIRG9M?=
 =?utf-8?B?dW81NVczU25zcEdBbnZiSzVRektLeDFUaU5PTEMzR2hPRGQrS2tvQ3BwVFpT?=
 =?utf-8?B?Smt2Y0RJRjhPZ29ic05Ra1laV0ZpQ2JXdTBhR1E4TW1KK091eGo0ek9YTzdC?=
 =?utf-8?B?R1BIV2NQV3ZGZG1rdDQ5VkhoM3Vkd2xVT1BqQXRCUWxzdVIvMlJGY0ZNZFdD?=
 =?utf-8?B?anovRTNDaUNVOXlObXFiVEZkNTh5NWU5L1d1bk05ZGV5NFdKSVBCUmtDQUJo?=
 =?utf-8?B?dmVvWFd5M3ZqMHVGZDRZS1RUL2tpZzBTOVJjTWYrZEx3Smo0VzlTUWdielF6?=
 =?utf-8?B?dm1nTWZGa0Rjc3owdUdENFloYkVqWk16bURjWmF5TU1qRCt2MXF2VEQ2S1N6?=
 =?utf-8?B?Yk5VSG1CUHFBOWxKNVJJR0phblBNd3pqUGwyRGZtTmUvR2RHSVYyVGtiN1R1?=
 =?utf-8?B?c0R4VVlXSmhkSFFvUGpONXdaUWFxU09XaFpFbEc1Nld3TjRncExCNjhGNWxZ?=
 =?utf-8?B?UlphUmlnVnp5cUlpS2lhZnhjRU5pamtxSWNQejhsSnI5RzFTZThkRUtxOGdX?=
 =?utf-8?B?ZUxQUlg1Mzh6QTQvNEJQTGVpeVdKQUptY3M4d0JvaG5YUFVRNWZKc0gyUnMr?=
 =?utf-8?B?eDNsckttOVFLbk1Bck5tS093N2JpU2tQMUU1SHorT2RWRjFSUGdEWWlnSTc0?=
 =?utf-8?B?cW1FOElzcWNmZThpM1dxVTEzb1NaM1U3dE1qUU1rL2RQcW1NSXMvU0dRU2kw?=
 =?utf-8?B?L2JFZk5lQWI1Q29XRVRtL1kzcHR6bzl2NGxHKzRtcmZOWmxTUUxqRnRCU0JP?=
 =?utf-8?B?RlJ2UlZTMWtyUElJWWFOZzRXWkx5Y1RXa0x1M21aaXdEUEtpV09MbkRiWDVZ?=
 =?utf-8?B?WUVORTBsSDRoQVZBY05zUGNINGlSTmR2bHNKNVVJeXgvejdpVzkySmVjQkZu?=
 =?utf-8?B?VnVGZWdiUytaeWJWMWFUWFcweFprRHhRVHViY3AvT2hkSTRhTWhyaytBQ3pk?=
 =?utf-8?B?RWdCTlB4YzZFOEVSeUYrS282S1h4MC9FbW1xRHhSVmpXYkl2Y1BvOHQydVJK?=
 =?utf-8?B?aUovSFZyZVJ6RnlraXpzZ2RYNmZHaUwrdHRZalBSanpKTzIxVVd6ZzBBU3Z1?=
 =?utf-8?B?S3IwRFBlOE9kbFF1enp1d2k2KzN1N3V5VzRCc1gwT2ZmWjJTWUEvRFVTUGdP?=
 =?utf-8?B?blVpYkN2aDRwYk9XY0hUcmxTbnpnMmQ1T0JuVk5KRjF1NTZGcytKRG4yMjZU?=
 =?utf-8?B?SFJKSzBHdGM0SmFnUlZURlEwYk1lMCt5K05kSHZqNTV4N0FrSDdQVWdqekpp?=
 =?utf-8?B?TVRxaDBIZDl6V1VuOTRjcHdNTlovdWJuQWRSRzBVdEwyaVM0b29TTkNEU01w?=
 =?utf-8?B?UUFMYllnL3B5WkFER1BkQ0MwWGJvazVaL2pVb0Y1ZElxMkZWbEdNVjloamJ6?=
 =?utf-8?B?L0laRGJpYW9RN1F6WnpHSnBBYTFIaEYzN2JGZzJvMlh0THZVUWVOY2ZUMDBm?=
 =?utf-8?B?VXJ4ekVUOWFxUnFpZGZPUW8yaERvbWRTRkVIMlc5bEQvTjNub1IvMFR2Sldq?=
 =?utf-8?B?SHJDUkpXaFhFNjdaeTlLdlM2OUo1UnBXSGczeHNNd2MrLzFmVmJkaGVoL1M4?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0854F163B725499F4C019B4725FA0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d244c948-762a-4f56-2fe9-08da7127bc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 06:01:10.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loCfolLVShgkN2m8hyZfX1QXxGFuud3yLc4cnZk40Yyvhmc0L5o3B9Il6AiEyFWX75DKfEWtEod6ToCDKO6R9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwKCk9uIE1vbiwgMjAyMi0wNy0yNSBhdCAxMDowNSArMDIwMCwgTWljaGHFgiBM
b3dhcy1SemVjaG9uZWsgd3JvdGU6Cj4gU29tZSBpbyBpbXBsZW1lbnRhdGlvbnMgbWlnaHQgd2Fu
dCB0byBlaXRoZXIgbWFrZSBjYWxscyB0byBvdGhlciBELQo+IEJ1cwo+IHNlcnZpY2VzLCBvciBw
cm92aWRlIGFkZGl0aW9uYWwgb2JqZWN0cy9pbnRlcmZhY2VzIHRoYXQgYWxsb3cKPiBhcHBsaWNh
dGlvbnMgdG8gZmluZS10dW5lIHRoZWlyIG9wZXJhdGlvbiwgc28gYWxsb3cgdGhlbSB0byB1c2Ug
dGhlCj4gYnVzCj4gZXZlbiBiZWZvcmUgaW5pdGlhbGl6aW5nIG1lc2ggRC1CdXMgaW50ZXJmYWNl
cy4KPiAtLS0KPiDCoG1lc2gvZGJ1cy5jIHwgOCArKysrKysrKwo+IMKgbWVzaC9kYnVzLmggfCAx
ICsKPiDCoG1lc2gvbWFpbi5jIHwgMiArKwo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL21lc2gvZGJ1cy5jIGIvbWVzaC9kYnVzLmMKPiBpbmRl
eCBhN2FiZGM0MjguLjZlNjJhYmQyNyAxMDA2NDQKPiAtLS0gYS9tZXNoL2RidXMuYwo+ICsrKyBi
L21lc2gvZGJ1cy5jCj4gQEAgLTc1LDYgKzc1LDExIEBAIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAq
ZGJ1c19lcnJvcihzdHJ1Y3QKPiBsX2RidXNfbWVzc2FnZSAqbXNnLCBpbnQgZXJyLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAiJXMiLCBlcnJvcl90YWJsZVtlcnJdLmRlZmF1bHRfZGVzYyk7Cj4gwqB9Cj4gwqAKPiArdm9p
ZCBkYnVzX3NldF9idXMoc3RydWN0IGxfZGJ1cyAqYnVzKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKg
ZGJ1cyA9IGJ1czsKPiArfQo+ICsKPiDCoHN0cnVjdCBsX2RidXMgKmRidXNfZ2V0X2J1cyh2b2lk
KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZGJ1czsKPiBAQCAtODIsNiArODcsOSBA
QCBzdHJ1Y3QgbF9kYnVzICpkYnVzX2dldF9idXModm9pZCkKPiDCoAo+IMKgYm9vbCBkYnVzX2lu
aXQoc3RydWN0IGxfZGJ1cyAqYnVzKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoGlmIChkYnVzICE9
IGJ1cykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOwo+ICsK
CgpTaW5jZSBkYnVzX3NldF9idXMoKSBpcyBjYWxsZWQgcHJpb3IgdG8gZGJ1c19pbml0KCksIHdv
dWxkbid0IGl0IG1ha2UKc2Vuc2UgIHRvIGVsaW1pbmF0ZSBhbiBpbnB1dCBwYXJhbWV0ZXIgZm9y
IGRidXNfaW5pdCgpIGFuZCB0byBwZXJmb3JtIGEKY2hlY2sgKGRidXMgIT0gTlVMTCkgYW5kIGFs
c28gZWxpbWluYXRlwqAKImRidXMgPSBidXMiIHN0YXRlbWVudCBhdCB0aGUgZW5kIG9mIGRidXNf
aW5pdCgpPwoKCj4gwqDCoMKgwqDCoMKgwqDCoC8qIE5ldHdvcmsgaW50ZXJmYWNlICovCj4gwqDC
oMKgwqDCoMKgwqDCoGlmICghbWVzaF9kYnVzX2luaXQoYnVzKSkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiBkaWZmIC0tZ2l0IGEvbWVzaC9kYnVzLmgg
Yi9tZXNoL2RidXMuaAo+IGluZGV4IDhmMDA0MzRkNi4uYWI4YjBhMmNjIDEwMDY0NAo+IC0tLSBh
L21lc2gvZGJ1cy5oCj4gKysrIGIvbWVzaC9kYnVzLmgKPiBAQCAtMTQsNiArMTQsNyBAQAo+IMKg
I2RlZmluZSBERUZBVUxUX0RCVVNfVElNRU9VVMKgwqDCoDMwCj4gwqAKPiDCoGJvb2wgZGJ1c19p
bml0KHN0cnVjdCBsX2RidXMgKmRidXMpOwo+ICt2b2lkIGRidXNfc2V0X2J1cyhzdHJ1Y3QgbF9k
YnVzICpidXMpOwo+IMKgc3RydWN0IGxfZGJ1cyAqZGJ1c19nZXRfYnVzKHZvaWQpOwo+IMKgdm9p
ZCBkYnVzX2FwcGVuZF9ieXRlX2FycmF5KHN0cnVjdCBsX2RidXNfbWVzc2FnZV9idWlsZGVyICpi
dWlsZGVyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHVp
bnQ4X3QgKmRhdGEsCj4gaW50IGxlbik7Cj4gZGlmZiAtLWdpdCBhL21lc2gvbWFpbi5jIGIvbWVz
aC9tYWluLmMKPiBpbmRleCBkZDk5YzMwODUuLjAxODBjMzc2OCAxMDA2NDQKPiAtLS0gYS9tZXNo
L21haW4uYwo+ICsrKyBiL21lc2gvbWFpbi5jCj4gQEAgLTI3OCw2ICsyNzgsOCBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBkb25lOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBk
YnVzX3NldF9idXMoZGJ1cyk7Cj4gKwoKSXQgaXMgYmV0dGVyIHRvIGNhbGwgZGJ1c19zZXRfYnVz
IGZyb20gd2l0aGluIHJlYWR5X2NhbGxiYWNrKCkKCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChkYnVz
X2RlYnVnKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbF9kYnVzX3NldF9kZWJ1
ZyhkYnVzLCBkb19kZWJ1ZywgIltEQlVTXSAiLCBOVUxMKTsKPiDCoMKgwqDCoMKgwqDCoMKgbF9k
YnVzX3NldF9yZWFkeV9oYW5kbGVyKGRidXMsIHJlYWR5X2NhbGxiYWNrLCBkYnVzLCBOVUxMKTsK
CkJlc3QgcmVnYXJkcywKCkluZ2EK
