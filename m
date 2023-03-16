Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484BEC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 07:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCPH3N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCPH3M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 03:29:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B99A7607B
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678951751; x=1710487751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0TOYOdR1lessY0FCAjVjcyHA7j85QV37oIZij37QG4M=;
  b=fkdWeUyhFXgkeJpULYbAEHpmxeH1mBYKCqCg7rVsd2sF6GWg1x80tdQw
   FyLa1hkhp2ADIDc/++5BNmirYgoHGNTIFtw/fR4XkLO8omxgPejHtPuqR
   +PDiHrE9ib9PBCScHXeuAmPDBy55vMfxg6Oz26a2dmvAFIePtBnZX4SYY
   ceRuEvfyWudaoEVoPTHkO3lGZadhRyLfLdF3aig0yO73CJwSHWgIcwWso
   TYGH9IMMvBH1H7i4QvazHLWLnSFSxELcHMX0oiF2oAB1RwlRPmnkvN8YT
   9oyCrf9cKdIccexDLj/D23pXSWCRm9+2xc08qF90C87vn7piov7dXSA5l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="318311045"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318311045"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853905480"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="853905480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2023 00:29:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:29:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:29:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7dtIg9NtnzV+nEGIJ1+tX1JjIXEk9kb7YZumyEUUU/uSxm4m5F/+D6m6rnq2eDEVnxdjbkSVY1NhQekvzGgoyM5mrw0Tzg5Dwx+ydyYHV+DU9foSrS5c58ho11PZLKV+2WvaQVjFrWR0Qy/iRoprMzUn38Ljdrb5s0h9CkLd6LLUQwbX4qBqbh3rF25o0vcY5pbYUTkSdVIwhF0cNYPtJmI6sZORAl8Gl1ywt+M5GKQ8FxJ7Clanxfit3AgAB8zNexX70pH6aLaA5C8GWiinChgSGHQ4Y4IZJ49VYhsgTHvjRKgpZ2jHvZedKp7XSdRWfBPJHAZzHYGf2ymgztiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TOYOdR1lessY0FCAjVjcyHA7j85QV37oIZij37QG4M=;
 b=Iyia1RODQ3Ou5p8O30Qbw8ub+QnM61jFdOUYhiJcU9/3xCQeE+tbFif31fooo4v3TRn4M5KjAJ56KehYFscMwlqZV1jWYE3uUS9L9MwBgwpYYXFR7YeEORkz8WVnFfkt1iK6H2aKTPaxxWouZORTvxtGzfbKu6vvpj7D5t9avskJ79tVyZdAwPslGHKsJgQnq/8VESkIlD0ICPfkbuLIyf07aZbK5yy5jqavlzTYuEwUCCrteuv8rjBUSBEe68LMWrwesxbLbbFX+9YrdSxCeo1KvdnfUWKikWv5Kz/2X1/TU3jvYUTPbAPrbM/mAtd/FJrzffuuFW5+QHnCuuAoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1829.namprd11.prod.outlook.com (2603:10b6:903:124::11)
 by CYYPR11MB8360.namprd11.prod.outlook.com (2603:10b6:930:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:29:06 +0000
Received: from CY4PR11MB1829.namprd11.prod.outlook.com
 ([fe80::dd53:eb23:8cc7:a91f]) by CY4PR11MB1829.namprd11.prod.outlook.com
 ([fe80::dd53:eb23:8cc7:a91f%7]) with mapi id 15.20.6178.033; Thu, 16 Mar 2023
 07:29:05 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v2 2/2] ACPI: utils: acpi_evaluate_dsm_typed - fix
 redefinition error
Thread-Topic: [PATCH v2 2/2] ACPI: utils: acpi_evaluate_dsm_typed - fix
 redefinition error
Thread-Index: AQHZV5x6fi/yxT+P5EucD0Bdnx7cbq783z4AgAAi4dA=
Date:   Thu, 16 Mar 2023 07:29:04 +0000
Message-ID: <CY4PR11MB1829C74ABF558789D4A2BFE6F5BC9@CY4PR11MB1829.namprd11.prod.outlook.com>
References: <20230316002559.32562-1-kiran.k@intel.com>
 <20230316002559.32562-2-kiran.k@intel.com>
 <CABBYNZKbPqR8W8M8gjSdC2C=QL+A8Xs5w9jOzw=Z3O3R6r4jng@mail.gmail.com>
In-Reply-To: <CABBYNZKbPqR8W8M8gjSdC2C=QL+A8Xs5w9jOzw=Z3O3R6r4jng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1829:EE_|CYYPR11MB8360:EE_
x-ms-office365-filtering-correlation-id: ffa7209d-83a2-4263-258b-08db25f01f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWbyn6Bdxz+9xXK9vCvlSeT/f3iPIfl0F/N5jw+4snZn8rZpkjnbduPh/Gq5SqHb4gn1XtlZ+cjaJAOhjKYXdBhxXb8eOFyvDFXFo/C+o1X/7p3rkThWjb8ZiHw/xFMh2d3xgAD5CfH7Cbl5hnJi/qRalB3HxAHCxc0octAnQ/ttTfgQx7WCiN/3u8m+lIwBiY2x9m6CGWDQC73TdZRtO4QXhKBfDj2hoYU/6tSqOBmoGfc+pfQYcSRGQlJLFaMO7XSJqzJ1GJ+KFR3vbLqk3CMkTr7nY88yuJtrOL/XR+9q86YMhClAaWyMHCdOR7bFC/FnotRnk3RJ8VEJuSIVwLEo1WONKizwclUBuNpFEzobqLNGfL4wm4/ZsMPIlfQuSDBf2Ja5RFqMd0Dvxg+5Y7KmJfx66WCdJupnavIpzkf6/BbPIPsCoTXNURfmxeLEUu6aPJ78xGFDo9HMk0oZDc1Woa/CDuJVp+hHKkuwSEXrGDwOdyVl9/lk23whoZVLpakp9Ji+QPvdXGi92bQCq0ZAwwU5W6FmEJjdh+Jxc/rbb1bHRieYUDFpTZVCbcHvs4ERZ67tQF4MWfBeXOl6l5xjRSKaArpILvqZLUsS8Gmt2kKKLLUmaKMhUDmbNB7/9OMQ3FxL34ghUSg0JNkf7BCUeOqP2oV/orrCcfUlaAJHJs2OpdvhrAn73rZbvyZ7/+hnidl4UotuYUZcnz647g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1829.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(26005)(53546011)(6506007)(7696005)(71200400001)(8676002)(478600001)(83380400001)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(54906003)(107886003)(9686003)(316002)(186003)(41300700001)(52536014)(8936002)(5660300002)(6916009)(4326008)(38100700002)(122000001)(2906002)(82960400001)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Z1cFgyUU1IT0VOdjY2VTljL01RcEY4cUY2NmkxbUtRTjhEQXZXYlZ6UTh1?=
 =?utf-8?B?VnZyS2hZeWsxazMzRHkzL0xqT20xSjFRMTNvNU43K1dLY1VzSFJjRzVMVmFL?=
 =?utf-8?B?RkZydDloY2tJZ2tZRWt6SENLRWZpTWlnS2tmckFXQnFSNjNQbWQvbGF3Q2FO?=
 =?utf-8?B?bUw2UUZSamFGRWJ4Z0NOKzRFT2ZtN3dMd1JsbkJHSDBlUFhRSnBwTHk5Y21C?=
 =?utf-8?B?dDl5ZHhOSUlPZW1pcjhuTUZPV3ljanVEL3huelZqRXN6UUdqZzFpS0M3MTQw?=
 =?utf-8?B?NU5CWEVFV1BGVmgyc1NuQjQ0ZndadDkwd1Y3N2tvMG1RaUdwcy9zZVF6QmVt?=
 =?utf-8?B?Z3BJd0o3UGxZTzB2citRVit4VFY1MEhrSFNDbmNkYmk3R1hDQ0NmUlhRK2k1?=
 =?utf-8?B?VEtTbDUzQVpiM01sQnVUTE51RWpWUmhxMU5LcU5LTTNneldHQXFjUm11a3NY?=
 =?utf-8?B?QnhTQ0RuM2ZrVm1ZZ09abWNkTG9MYklERWZMWUl5bUJwRS9JdDNqREh2dHN4?=
 =?utf-8?B?TUE5ak13ejl4OGdteU9pWnB6a1NIb1lqY3RYbjljY3FEc0VsRGFrcTJQQ0lG?=
 =?utf-8?B?L2s0aTFkQ1NDZ2dGeHM5ZzRLZUhvSHA2WXBSQm1kRkF5MGc3Q0lCdTZuQjFa?=
 =?utf-8?B?UFlLMmUrTWNHNW1Ea2luOUpmdERIb2pWSmRmNnp3SzYzT0xVMHVmTEEvcWpn?=
 =?utf-8?B?N2FPVHVjKzNJWWRFeGpIMDFKL2Y1Y29FUkcxVFNFdFphdzRMNkdyMVE4VWt3?=
 =?utf-8?B?cDl0RDJsRGxmOFRIZWVwZUJPdnE2dVdZSURBcDZHVkpmcG41M3pjVEo4Ujlz?=
 =?utf-8?B?cmF5dGlEeUZCdWdkY1kvN1JCbFBpRnJxMUQxUVIvNktuR3Z3d2dTTUhteW4z?=
 =?utf-8?B?SnVuaUU0K1F3ekw1aGR6Rzd3dG4vMThPK3hvVEhEU254NU5CeW9WMHUyL3M2?=
 =?utf-8?B?Z01pSXNJclVQMDJjc0p5Rmo1SEFIQ0dROVpqMU1KaldRUEppNE5MV3Iwb255?=
 =?utf-8?B?cFpJZGx1RGp0UGJnTWdibkFIU3NkT2I5TVVPb0Z4RXVoRzFmTCtmZUNkUUd6?=
 =?utf-8?B?bWppSDJFUG1RZFI4SEV2QldZaVJhcjc2ZEJic2wwZGc2L2FRR1dUOHpQeDZS?=
 =?utf-8?B?ZFVTNGNWa0V1aGJjb3AxZWZiSHZ0SHJYYkRHSHE4dFdKcTdGQWM2NksxRmZX?=
 =?utf-8?B?alUrVDF5bEd3ZzJZWmNpdkIybXpMb0VycjdUQ212T0lvNFVvT3h2T3JwSmtY?=
 =?utf-8?B?YXYyQzVvOTNybExITElKWFRjalI5di9vaUwxRmVibUtsNU1XREtDdDF0WFBq?=
 =?utf-8?B?UGJpTmtrZEF1SVF1N09GNHV3QnJ1bTVsaU9zS3FoNjdXajNSK2wxOFAvZnJS?=
 =?utf-8?B?b2ZPMEhubVpVa1AvWG9NeWRGNVU3ek84a292Nk5EZUM2Q29iUVJKY0F1WEww?=
 =?utf-8?B?TzJhcGN5WjQrTHhYcnM0azZHa3hFaDRqVVNxRFFjSUk1cUp6SkxHZGdUOTZF?=
 =?utf-8?B?aGF4RktaamJBaEVadlhPMnNQTXgrdGVwcktEQnFDNHh3MkN0REtUYURpQ0ww?=
 =?utf-8?B?NDhzaDA0S0I0MTg4Q0RUZDJPUFk1Vk9uemlrT2ZqcFgrQ2gwV1JQdEZINEdn?=
 =?utf-8?B?TXovUU5WUFJTYlZCNU1kaGpPSWFoa3pSUGFsNWRwSW0zUVM2QU5vSFNoY2hq?=
 =?utf-8?B?N29tcU9UZFNYY3EwZTZuMTN1MVBQajN3WXVmOUs1NnMxOE1NY3hUd1p2RjFJ?=
 =?utf-8?B?SU9PSzE3YmFURHJUdGpqU1ZtNE9HQVZ2U2RhbUgrUDM5dFdMVi9oYStEdkZj?=
 =?utf-8?B?WUhHMmY2anRHY29mSnErU2lmREFwcmdPMzQ1YzhPNkNzRnY0SXl2V3VGK0hz?=
 =?utf-8?B?STFnekpac2cvTk5WV0MvQmVkZUQvZEE1SjJqRHZIOTNpWWIzakNNS2FCdk5m?=
 =?utf-8?B?T2dBQWFoaGtjUTlQUlUzQ2xHd0ZiazNVdHlzd1VVUjhBNW41Vk9DRWNiWWpQ?=
 =?utf-8?B?MDZOOXYxajJYQkZOOEFrZlY5UGFTM0s2QllJWE5peXpaeGFxQVhsbkUzaERt?=
 =?utf-8?B?RGI2VXhxdFJ3SGNiNW5yZTkrWHRSbHkzSjVwYkVQWWwrMzVIT05zamY0OHpN?=
 =?utf-8?Q?xENo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1829.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa7209d-83a2-4263-258b-08db25f01f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:29:04.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5P5acnsSvUphG3Fv52AbAlYryi/4kZejmuv2AFD+sYWdcPaaygPS0tK+9bxenHpnljoy+qPyrqlYeCODo0DqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8360
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDE2LCAyMDIzIDEwOjUyIEFNDQo+IFRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBTcml2YXRzYSwgUmF2
aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT47IFR1bWt1ciBOYXJh
eWFuLCBDaGV0aGFuDQo+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIEFDUEk6IHV0aWxzOiBhY3BpX2V2YWx1YXRlX2RzbV90
eXBlZCAtIGZpeA0KPiByZWRlZmluaXRpb24gZXJyb3INCj4gDQo+IEhpIEtpcmFuLA0KPiANCj4g
T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgNTozMuKAr1BNIEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IGFjcGlfZXZhbHVhdGVfZHNtX3R5cGVkIGZ1bmN0aW9uIG5l
ZWRzIHRvIGJlIGdhdXJkZWQgd2l0aCBDT05GSUdfQUNQSQ0KPiA+IHRvIGF2b2lkIHJlZGVmaW50
aW9uIGVycm9yIHdoZW4gc3R1YiBpcyBhbHNvIGVuYWJsZWQuDQo+ID4NCj4gPiBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi4vZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jOjEzOg0KPiA+IC4uL2lu
Y2x1ZGUvYWNwaS9hY3BpX2J1cy5oOjU3OjE6IGVycm9yOiByZWRlZmluaXRpb24gb2YNCj4gJ2Fj
cGlfZXZhbHVhdGVfZHNtX3R5cGVkJw0KPiA+ICAgIDU3IHwgYWNwaV9ldmFsdWF0ZV9kc21fdHlw
ZWQoYWNwaV9oYW5kbGUgaGFuZGxlLCBjb25zdCBndWlkX3QgKmd1aWQsLi4NCj4gPiAgICAgICB8
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYzoxMjoNCj4gPiAuLi9pbmNsdWRlL2xpbnV4L2FjcGku
aDo5Njc6MzQ6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2YNCj4gPiAnYWNwaV9ldmFsdWF0
ZV9kc21fdHlwZWQnIHdpdGggdHlwZSAndW5pb24gYWNwaV9vYmplY3QgKih2b2lkICosIGNvbnN0
DQo+ID4gZ3VpZF90ICosIHU2NCwgIHU2NCwgIHVuaW9uIGFjcGlfb2JqZWN0ICosIGFjcGlfb2Jq
ZWN0X3R5cGUpJw0KPiA+IHtha2EgJ3VuaW9uIGFjcGlfb2JqZWN0ICoodm9pZCAqLCBjb25zdCBn
dWlkX3QgKiwgbG9uZyBsb25nIHVuc2lnbmVkDQo+ID4gaW50LCBsb25nIGxvbmcgdW5zaWduZWQg
aW50LCAgdW5pb24gYWNwaV9vYmplY3QgKiwgdW5zaWduZWQgaW50KSd9DQo+ID4gICA5NjcgfCBz
dGF0aWMgaW5saW5lIHVuaW9uIGFjcGlfb2JqZWN0DQo+ID4gKmFjcGlfZXZhbHVhdGVfZHNtX3R5
cGVkKGFjcGlfaGFuZGxlIGhhbmRsZSwNCj4gPg0KPiA+IEZpeGVzOiAxYjk0YWQ3Y2NjMjEgKCJB
Q1BJOiB1dGlsczogQWRkIGFjcGlfZXZhbHVhdGVfZHNtX3R5cGVkKCkgYW5kDQo+ID4gYWNwaV9j
aGVja19kc20oKSBzdHVicyIpDQo+IA0KPiBUaGlzIHNob3VsZCBwcm9iYWJseSBiZSBzZW50IHRv
IHRoZSBBQ1BJIGxpc3QvbWFpbnRhaW5lciwgYnV0IGZpcnN0IG1ha2Ugc3VyZQ0KPiB0aGVyZSBp
c24ndCBhbHJlYWR5IGEgZml4IHdoaWNoIHdvdWxkIG1lYW4gd2UgaGF2ZSB0byB1cGRhdGUgYmx1
ZXRvb3RoLW5leHQNCj4gdG8gc3RvcCB0aGlzIGtpbmQgb2YgZXJyb3IuDQo+IA0KT2suIEl0IGxv
b2tzIHRoaXMgaXNzdWUgaXMgcHJlc2VudCBpbiBsaW51eC1wbSB0cmVlLiBJIGhhdmUgcHVzaGVk
IHRoZSBwYXRjaCBvdmVyIHRoZXJlLiBJIHdpbGwgbGV0IHlvdSBrbm93IG9uY2UgaXRzIG1lcmdl
ZCBzbyB0aGF0IHlvdSBjYW4gcmViYXNlIGJsdWV0b290aC1uZXh0LiBUaGFua3MNCg0KUmVnYXJk
cywNCktpcmFuDQoNCg==
