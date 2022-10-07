Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97097C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJGO4c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGO4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 10:56:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC5B03C6
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665154589; x=1696690589;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IPhA6/0k0AYNN/dmy6KgS1pI8GmGaSq7gzYDdh0bF94=;
  b=Uvt6Ayhu5OSki6sl4aJI7Xpjh8Eb1ZXFgIPjn2t6bvlS4RdvTosc/L8e
   TTbl4q/MoIyoYDvyiQ4b9mqbIwY3AWSk1DnEOB4GLxEZdX9IfxF6kLl7D
   kb1is85DuVTx8hDBmIDKyKcL6jQ/W8D4uGsJWyBxlKGp0Cl1I8n6DFVbi
   6w23rUIi3M6N34zN/0oX0YaqDAniQBJ+PAz9d9txpWMY7fDXxjUt4JRiU
   n5Ugz+5HamNvw6BIbce5odCchSEb22PGqlr8v0pI38RPBiqgmbb4xLorP
   PruIhJHrzRIc4460Lm8FQ6k9v+XEVya5iOuwajKhtNe9jf6CDSdx4P/sr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="283474050"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="283474050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 07:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="625168666"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="625168666"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 07 Oct 2022 07:56:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 07:56:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 07:56:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 07:56:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 07:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwp6+oKVTtrmX8sx8X0+fNpP3JZtKk3D3sZcBrkiZ38/iPTFsEfNES9n89jySXD5JwV/allw6o5Kh/qWf6JAR6wIRKjPvEhMymTC3XT4Du1Ur/B+iCg0XSzNSVMIcU6TSpNU770dvFvQqeRYKTBB0yxb41rD119vL6+oaCPRwmCgFtGkQSWQLI4WMt2qV6lpKae0JN0jaIhzkzlKuhm7xxRk0Z/azFXdipxcbunUs4RuUL6sZXHh+LXU88zPGAWK9gh4eyfYDtG0W3BsPdUtt81OsABd+aHqanYXTCkLo/qVfVEmyCxlsPTZyqlOxfainfeoU0TJiONMzD0qcemxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPhA6/0k0AYNN/dmy6KgS1pI8GmGaSq7gzYDdh0bF94=;
 b=VF8TfoFYUjpFx6JNlYsSuNbjVdFf2tYBhBvEOG/K6PL2i0jnGrLkcpMOE431KrdjXi/Kk0ayamGew9ncsbOGqRVSn0Rci9nx/V527HHZx1HQ6KfB3bRep+DQGuNcHSyITMsH3mNjnLX54790M5BZn9oQHMAVc8RVQqVjcVEhADI2itYminY7hXrOZSe5h5tkHdbOHPA5K7rWDy/skTrEVrQuVzFJKwhMxYTa+bq2EmmCXz2gfy+GhFB767j0jjBQrTPtLkJNl2TVtMxCuoiQO/7auJiRYp6F2LmfylhWYg2zpBTtCtyhXI3sMb5TkucMlqTq0CpqgWCMWqcYoHZwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 14:56:26 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 14:56:25 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "karl.westin@loytec.com" <karl.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Topic: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Index: AQHY2ZRgur1htrK7GUOmXNyNl6ZlBa4B2K8AgAC6nACAAAAcAIAAc2GA
Date:   Fri, 7 Oct 2022 14:56:25 +0000
Message-ID: <1e71b8f27ce13c7b57933dc41971a3b511aaee9c.camel@intel.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
         <20221006145927.32731-6-isak.westin@loytec.com>
         <4c8e20487a5ee71088bf6374bae8fd55a95055b3.camel@intel.com>
          <GV0P278MB01298DB6AC0C593245E3FCFB955F9@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GV0P278MB01298DB6AC0C593245E3FCFB955F9@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|PH8PR11MB6831:EE_
x-ms-office365-filtering-correlation-id: 7099a70d-6da9-4812-6594-08daa8741b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RaEPJbSz507pjjmTHfxKiLKYGmeiq4G4Gs62azooKR1TVynhJL6xDLZXyBF1QzzX/sBXLiYe7MJjGyTy6cGbPOjUMafmHsAwdjv2zK7+sLfNSHdxOJyY+FgsbCsKlsXKlnUxqW1gGiF/GwYCzitr0e/cPSyEJsbPK4I73Hum1RbZljKwXJjy8s9jf+4OYZxQiffxxVwImCRJ4BjEfew6Ouw+NF3Nw7tdmOnolzJoNw8v0MS+nhIRRjdPfB2YFSPN+zNhzaVvF0CZySxXSJyR0E3BSv/GUMBxj/qo30g0R7hsVoPuhS2o42S1BmZUbizScMdZBc07Edo7uadr3RWADborxK+K282U0Oa/GJQAwzXHVun/KDd1StBYIDTT5uohB1bL5VW/7u5HxJUngTq5VYs3EV0SFgCTv8u00hf/4qS7rz2y+1NWJo90GGQ6leJDGPJFFMJtTRX9DpEr1nZF7ABjgcT3nXXvyQlYUtbgzHVnTrzorP0/pANUtJSEKmhyhdoeMaxDISQB37XKAXkB0c833/oFgKq3GAVMP2ifZoWqD7gZfQwfunTPuDUYTSiqSMk/3hP0F4nRULUJ9hN1R855fTCjNT3rAMzpBTdZ+8twUTRX0N7FRAaFWTHhvUWh6VAOsQPgt6dQs9TZk71ZcqV+Ih+orb+iaEcliZrjtHwsw+XAHgSL97xQNpY36AwFNSseHh7h3WDF4Melcjh+tq5PuW/P4M2AjlVR1877Qc6WXjiJrcPDPOlx1zt3mAuSXHxvNjs2q3b/BvdTj8hMEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(122000001)(8676002)(66446008)(83380400001)(64756008)(66476007)(38070700005)(26005)(86362001)(66946007)(5660300002)(76116006)(91956017)(6512007)(8936002)(6486002)(41300700001)(186003)(66556008)(6506007)(2906002)(36756003)(478600001)(71200400001)(82960400001)(2616005)(316002)(38100700002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFFTRDRKanpTdy80d0J0dU5LOUhxV1VtZHVBV041cXlBNkN6MlRXYmNRMDhV?=
 =?utf-8?B?eEh6R0o0ZU9jOGdVRHdJWnJvc3VZbWY2anRZYnRUeWdMKzhvYnFoWmxTYlEw?=
 =?utf-8?B?S1dLb3o1V2dlaXNMdnFrdHFWekZDZ1Q1Z204dHlNNVM2eUJVd1lXMmZ4S1dt?=
 =?utf-8?B?NU5OSDBSYzZtTHM3YXVRSDBPeFpKeGlSNi9uQzNXQnMvNU1aZ0RJeTRJbjBn?=
 =?utf-8?B?c2cwa2VteUdTa3hMMnIyZG5WNXA5b0lCM0Y2Yy9tcGovK01NTERIU0pvY0t4?=
 =?utf-8?B?aCtiWWtVakpBem9RTWdpTmpEdERYRStmTG5MZkZXWWh2MTkrS3RFSHAwMWxr?=
 =?utf-8?B?dEpwdzhBRkdhU2lhYjNOeVQ5MGIxbXhoVG5iNmJBSjUrRUNGS0ViaUlEZVFk?=
 =?utf-8?B?cmttUEtGWlZYRE5lMXlWSk1QWGIzY3FVSXRpWlJuMHhuS2dFNkNObWhiblpZ?=
 =?utf-8?B?RE1nenU2WWJkNFlwdGRsNW51NjRudzZYRGR0YUlUQkx4dHpuemNxNDJNeUZq?=
 =?utf-8?B?VXl4UlB3b01KZ0RveHFKVGhNNm1nTnVDRmMrYkZFK3BQMkl2Szd5R1VoV3FK?=
 =?utf-8?B?Y2VxVzdoMGJIcnNTejJqWDVuVG1pVldmRnFHdkpOWWhKVTdTcWVsRjFzbWhv?=
 =?utf-8?B?L0U5SnhQWWN1bkhsRWlvSVVTV0Q5QmVNWkJaQVZJTEFIelN0ZzBTNTB1US9N?=
 =?utf-8?B?Y0l1UTIyN3I0K210VUtTUW9DS0RwYm0yR2JGZ2hGR1dOUlhIVXhNMEtqQnBP?=
 =?utf-8?B?OS9vSVRyVWhFb0ZXN2F4Tjd2TTVEQU05cjk5dmJZNDVncjVVbmZMWjlQc0to?=
 =?utf-8?B?OFdISVJBYWdQYUlyM3NEWTlGbXNtbXZIMlBaQTh3ZWR5dXlvU2NaN3o2aDZZ?=
 =?utf-8?B?S01UNjRNb3RUc3JtYkpvaWhKb1ZPUkNXaFphTEtQV3BCbDE5d1paaVZROGFS?=
 =?utf-8?B?NEhFbi8yUHF0S2RJMHh2WVVTMzhPNGkrYTdzeHNjTEtqbkNPd1o1SmxWdzdQ?=
 =?utf-8?B?THJmYnpwaGtRdmEvU0Fxa0cwQWFXeW9qUU80aW9qaVNqeENnR3ZaN3VJZDRO?=
 =?utf-8?B?ZG1jRTlSbHlkOW9oVE9GWVRkQXpWMklRdlNWQ1g0azQ2MjJPU3VNNEhjUElM?=
 =?utf-8?B?c3lVS09lQTI3WnZRL2dBUDhQQ2FuUEtMN01nQkJaKzhZT2VZQUJ0SjY5ZDFI?=
 =?utf-8?B?cmVhT2t2b2xibUVhSmNhMENjVW13T0JuOWhnYTA0VHByc0FrSkZFdWxib0VS?=
 =?utf-8?B?aVBhckJZM2VXbEl6eTRkQ1Q1aStibDVoemR3QjN4eHFEVkNQVlYzSGI3T2Vy?=
 =?utf-8?B?RUQ0UkthL1RPODJtMjJSZGdSaHZpZC9ac2FIREhzdGJVeTJxMjk1TFFucjV2?=
 =?utf-8?B?end6N3FzZkhhbjlMQ3kxZTZOdHVhazd2RFpQd1A5T3VLNlBsbFczTlVZRWxq?=
 =?utf-8?B?SkRqQ2N5TnRRb3FKNnduR2hSNlhEUEU5SERqSkFObytGdU05cGIxTlJNcWRY?=
 =?utf-8?B?c2VubCtTUXhSWXcwWWlzdndVclptSVZieUlOb1VvOTlRRXRtYzNTS0NDVll6?=
 =?utf-8?B?cERKbkU5T1o0b3c3NHFwWVZMSEJpVjVKMFljSjJMQXQzdkJlOG8rUkFEOWpn?=
 =?utf-8?B?T09VZE45QjROYlphMXE4aDQyV09abm14Y2JxazQxdTdxLzFLczNSbThwSGYz?=
 =?utf-8?B?alQrNndIdkdYeGFkSno3QjdpK09mZHozNG9nbVQxaFNWRjJLNWU2SGozbE9L?=
 =?utf-8?B?cVpReFVrRVphMlkyN3hlNDJvMDdKcytUTHRiYVZQRDVUR3E2b0lvSitMWnMv?=
 =?utf-8?B?b0ZqRjZoRFRWcHBZR3hlL1VwS0ltTDcwQ2pNQk1ZdnFjY0VyWlhzWFhaWEJH?=
 =?utf-8?B?NVcwS3VERDJNdlgyQkFtL1Q1RVErSUt1ZUtaWXpYR3VSS3hha1FEQzNTVGJa?=
 =?utf-8?B?YnFmY01IS211eXJlV2RWWFh5akRqdXh4eTE5VEpMZ203L2l6REhDVjlBVE0v?=
 =?utf-8?B?WDl5c2dLMVhzUnIzeGxBdUdGQlVwL1FPZHhjVW1JZUdPcWMwM3B2MU9IdUE5?=
 =?utf-8?B?VVRHcS9McTlKeGpKeEZyR2k2WEhJRzNJenhLR3Zhd2VIOWUzd25hbGNlMzZR?=
 =?utf-8?Q?1LPk2IKJ8BVH+pDkmMoVfas3O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B484F50B9CB7A46A290DB47013AF42D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7099a70d-6da9-4812-6594-08daa8741b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 14:56:25.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNp2yQPVdaZT+9JaQDZ30rH+wdBKuux5am5LIE45/k3BwO3Wg9PZSqYI5Qu8/9qaTwdoLD4/bQoYLI4BawSZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywKCk9uIEZyaSwgMjAyMi0xMC0wNyBhdCAxMzozMyArMDAwMCwgSXNhayBXZXN0aW4g
d3JvdGU6Cj4gSGkgQnJpYW4sCj4gCj4gPiBIaSBJc2FrLAo+ID4gCj4gPiBIYXZlIHlvdSBydW4g
dGhpcyBwYXRjaCB0aHJvdWdoIGFueSBydW50aW1lIGFuYWx5c2lzIChsaWtlIHZhbGdyaW5kCj4g
PiBldGMpIHRvIGVuc3VyZSBpdCBoYXMgaW50cm9kdWNlZCBubyBtZW1vcnkgbGVha3M/Cj4gPiAK
PiA+IEkgYW0gcGFydGljdWxhcmlseSBjb25jZXJuZWQgd2l0aCBhbnkgbF90aW1lb3V0X3JlbW92
ZSgpIGNhbGxzIHRoYXQKPiA+IGRvbid0IGltbWVkaWF0ZWx5IHNldCB0aGUgZnJlZWQgdGltZXIg
cG9pbnRlciB0byBOVUxMLCBhbmQgYW55IG5ldwo+ID4gbF90aW1lb3V0X2NyZWF0ZSgpIGNhbGxz
IHRoYXQgYXJlIG5vdCBwcmVjZWRlZCB3aXRoIGEgY2hlY2sgdGhhdAo+ID4gdGhlcmUgaXMgbm90
IGFscmVhZHkgYSB2YWxpZCBwb2ludGVyIG9jY3VweWluZyB0aGUgc2VnX3RpbWVvdXQgb3IKPiA+
IG1zZ190aW1lb3V0IG1lbWJlcnMuCj4gPiAKPiAKPiBJIHRlc3RlZCBpdCB3aXRoIHZhbGdyaW5k
IGFuZCBmb3VuZCBubyBtZW1vcnkgbGVha3MuIEhvd2V2ZXIsIGl0IGlzCj4gcGVyaGFwcyBhbnl3
YXkgYSBiZXR0ZXIgcHJhY3RpY2UgdG8gdXNlIGxfdGltZW91dF9tb2RpZnkoKSA/Cj4gSWYgc28s
IEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoLgoKV2hhdCdzIGltcG9ydGFudCB0byByZW1lbWJlciBh
Ym91dCB0aGUgbF90aW1lb3V0KiBmdW5jdGlvbnMgaXMgdGhhdAp0aGV5IGRvIG5vdCBjbGVhbi11
cCBhZnRlciB0aGVtc2VsdmVzLCB5b3UgbXVzdCByZW1vdmUgdGhlbSB3aGVuIHlvdQphcmUgZG9u
ZSwgYW5kIHlvdSBuZWVkIHRvIGJlIGNhcmVmdWwgdG8gbm90IGRvdWJsZS1mcmVlLgoKWW91IGNh
biBmcmVlIGFuZCB0aGVuIGNyZWF0ZSBpZiB5b3UgYXJlIG1vcmUgY29tZm9ydGFibGUgd2l0aCB0
aGF0IHRoZW4KbF90aW1lb3V0X21vZGlmeSwgYnV0IGZvbGxvdyB0aGUgcnVsZSBvZiB0aHVtYiB0
byBzZXQgdGhlIHBvaW50ZXJzIHRvCk5VTEwgYWZ0ZXIgeW91IGhhdmUgZnJlZWQgdGhlIHRpbWVy
LCBhbmQgbWFrZSBzdXJlIHlvdSBmcmVlIHRoZSB0aW1lcnMKYmVmb3JlIGNyZWF0aW5nIGEgbmV3
IG9uZS4gQW5kIGZyZWUgdGhlIHRpbWVycyB0aGF0IGhhdmUgZmlyZWQgd2hpY2gKeW91IGRvIG5v
dCBpbnRlbmQgdG8gcmVzdGFydC4gTWFueSBvZiB0aGUgdGltZXJzIGluIHRoZSBTQVIgc3lzdGVt
IApuZXZlciB0cmlnZ2VyIGlmIHRoZSBtZXNzYWdlcyBhcmUgZmxvd2luZyBhcyB0aGV5IHNob3Vs
ZCwgYW5kIHNvIHNvbWUKcG90ZW50aWFsIG1lbW9yeSBsZWFrcyBkb24ndCBnZXQgY2F1Z2h0IGJ5
IHZhbGdyaW5kICp1bmxlc3MqIGFuCiJhYm5vcm1hbCIgdGltZXIgZmlyZSBvY2N1cnMuICBXZSd2
ZSBoYWQgdG8gYWRkcmVzcyBhIGxvdCBvZiB0aG9zZS4KCj4gCj4gPiBPbiBUaHUsIDIwMjItMTAt
MDYgYXQgMTY6NTkgKzAyMDAsIElzYWsgV2VzdGluIHdyb3RlOgo+ID4gPiBXaGVuIGEgU0FSIHRy
YW5zbWlzc2lvbiBoYXMgYmVlbiBjb21wbGV0ZWQgb3IgY2FuY2VsZWQsIHRoZQo+ID4gPiByZWNp
cGVudAo+ID4gPiBzaG91bGQgc3RvcmUgdGhlIGJsb2NrIGF1dGhlbnRpY2F0aW9uIHZhbHVlcyBm
b3IgYXQgbGVhc3QgMTAKPiA+ID4gc2Vjb25kcwo+ID4gPiBhbmQgaWdub3JlIG5ldyBzZWdtZW50
cyB3aXRoIHRoZSBzYW1lIHZhbHVlcyBkdXJpbmcgdGhpcyBwZXJpb2QuCj4gPiA+IFNlZQo+ID4g
PiBNc2hQUkZ2MS4wLjEgc2VjdGlvbiAzLjUuMy40Lgo+ID4gPiAtLS0KPiA+ID4gwqBtZXNoL25l
dC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gPiA+IMKgMSBmaWxlIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBkaWZm
IC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMKPiA+ID4gaW5kZXggMzc5YTZlMjUwLi5l
OTVhZTUxMTQgMTAwNjQ0Cj4gPiA+IC0tLSBhL21lc2gvbmV0LmMKPiA+ID4gKysrIGIvbWVzaC9u
ZXQuYwo+ID4gPiBAQCAtNDYsNiArNDYsNyBAQAo+ID4gPiAKPiA+ID4gwqAjZGVmaW5lIFNFR19U
TyAyCj4gPiA+IMKgI2RlZmluZSBNU0dfVE8gNjAKPiA+ID4gKyNkZWZpbmUgU0FSX0RFTMKgwqDC
oMKgwqDCoMKgIDEwCj4gPiA+IAo+ID4gPiDCoCNkZWZpbmUgREVGQVVMVF9UUkFOU01JVF9DT1VO
VMKgwqDCoMKgwqDCoMKgwqAgMQo+ID4gPiDCoCNkZWZpbmUgREVGQVVMVF9UUkFOU01JVF9JTlRF
UlZBTMKgwqDCoMKgwqAgMTAwCj4gPiA+IEBAIC0xNjYsNiArMTY3LDcgQEAgc3RydWN0IG1lc2hf
c2FyIHsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgYm9vbCBzZWdtZW50ZWQ7Cj4gPiA+IMKgwqDCoMKg
wqDCoMKgIGJvb2wgZnJuZDsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgYm9vbCBmcm5kX2NyZWQ7Cj4g
PiA+ICvCoMKgwqDCoMKgwqAgYm9vbCBkZWxldGU7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIHVpbnQ4
X3QgdHRsOwo+ID4gPiDCoMKgwqDCoMKgwqDCoCB1aW50OF90IGxhc3Rfc2VnOwo+ID4gPiDCoMKg
wqDCoMKgwqDCoCB1aW50OF90IGtleV9haWQ7Cj4gPiA+IEBAIC0xNDkzLDEzICsxNDk1LDI3IEBA
IHN0YXRpYyB2b2lkIGluc2VnX3RvKHN0cnVjdCBsX3RpbWVvdXQKPiA+ID4gKnNlZ190aW1lb3V0
LCB2b2lkICp1c2VyX2RhdGEpwqAgc3RhdGljIHZvaWQgaW5tc2dfdG8oc3RydWN0Cj4gPiA+IGxf
dGltZW91dAo+ID4gPiAqbXNnX3RpbWVvdXQsIHZvaWQgKnVzZXJfZGF0YSnCoCB7Cj4gPiA+IMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBtZXNoX25ldCAqbmV0ID0gdXNlcl9kYXRhOwo+ID4gPiAtwqDC
oMKgwqDCoMKgIHN0cnVjdCBtZXNoX3NhciAqc2FyID0gbF9xdWV1ZV9yZW1vdmVfaWYobmV0LT5z
YXJfaW4sCj4gPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG1lc2hfc2FyICpzYXIgPSBsX3F1ZXVl
X2ZpbmQobmV0LT5zYXJfaW4sCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbWF0Y2hfbXNnX3RpbWVvdXQsIG1zZ190aW1lb3V0KTsKPiA+ID4gCj4g
PiA+IMKgwqDCoMKgwqDCoMKgIGxfdGltZW91dF9yZW1vdmUobXNnX3RpbWVvdXQpOwo+ID4gPiDC
oMKgwqDCoMKgwqDCoCBpZiAoIXNhcikKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybjsKPiA+ID4gCj4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFzYXItPmRlbGV0ZSkg
ewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSW5jb21wbGV0ZSB0aW1lciBleHBpcmVkLCBjYW5jZWwg
U0FSIGFuZCBzdGFydAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZGVs
ZXRlIHRpbWVyCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2FyLT5kZWxldGUgPSB0cnVlOwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsX3RpbWVvdXRfcmVtb3ZlKHNhci0+c2VnX3Rp
bWVvdXQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzYXItPnNlZ190aW1l
b3V0ID0gTlVMTDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2FyLT5tc2df
dGltZW91dCA9IGxfdGltZW91dF9jcmVhdGUoU0FSX0RFTCwKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW5tc2dfdG8sIG5ldCwgTlVMTCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybjsKPiA+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDC
oMKgwqDCoCBsX3F1ZXVlX3JlbW92ZShuZXQtPnNhcl9pbiwgc2FyKTsKPiA+ID4gwqDCoMKgwqDC
oMKgwqAgc2FyLT5tc2dfdGltZW91dCA9IE5VTEw7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIG1lc2hf
c2FyX2ZyZWUoc2FyKTsKPiA+ID4gwqB9Cj4gPiA+IEBAIC0xOTU2LDcgKzE5NzIsOSBAQCBzdGF0
aWMgYm9vbCBzZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwKPiA+ID4gYm9vbAo+ID4gPiBm
cm5kLCB1aW50MzJfdCBpdl9pbmRleCwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSZS1TZW5kIEFDSyBmb3IgZnVsbCBtc2cgKi8KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZW5kX25ldF9h
Y2sobmV0LCBzYXJfaW4sIGV4cGVjdGVkKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2UgaWYgKHNhcl9pbi0+ZGVsZXRlKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogSWdub3JlIGNhbmNlbGVkICovCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gPiA+IMKg
wqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1aW50MTZfdCBsZW4gPSBNQVhfU0VHX1RPX0xFTihzZWdOKTsKPiA+ID4gCj4gPiA+IEBAIC0x
OTk2LDYgKzIwMTQsOSBAQCBzdGF0aWMgYm9vbCBzZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5l
dCwKPiA+ID4gYm9vbAo+ID4gPiBmcm5kLCB1aW50MzJfdCBpdl9pbmRleCwKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNhcl9pbi0+bGVuID0gc2VnTiAqIE1BWF9TRUdfTEVO
ICsgc2l6ZTsKPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChzYXJfaW4tPmZsYWdzID09
IGV4cGVjdGVkKSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFJlbW92
ZSBtZXNzYWdlIGluY29tcGxldGUgdGltZXIgKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbF90aW1lb3V0X3JlbW92ZShzYXJfaW4tPm1zZ190aW1lb3V0KTsKPiA+ID4gKwo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogR290IGl0IGFsbCAqLwo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VuZF9uZXRfYWNrKG5ldCwgc2FyX2lu
LCBleHBlY3RlZCk7Cj4gPiA+IAo+ID4gPiBAQCAtMjAwNiw2ICsyMDI3LDExIEBAIHN0YXRpYyBi
b29sIHNlZ19yeGVkKHN0cnVjdCBtZXNoX25ldCAqbmV0LAo+ID4gPiBib29sCj4gPiA+IGZybmQs
IHVpbnQzMl90IGl2X2luZGV4LAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogS2lsbCBJbnRlci1TZWcgdGltZW91dCAqLwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbF90aW1lb3V0X3JlbW92ZShzYXJfaW4tPnNlZ190aW1lb3V0KTsKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNhcl9pbi0+c2VnX3RpbWVvdXQgPSBOVUxMOwo+
ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFN0YXJ0IGRlbGV0
ZSB0aW1lciAqLwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzYXJfaW4tPmRl
bGV0ZSA9IHRydWU7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNhcl9pbi0+
bXNnX3RpbWVvdXQgPSBsX3RpbWVvdXRfY3JlYXRlKFNBUl9ERUwsCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5tc2df
dG8sIG5ldCwgTlVMTCk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gdHJ1ZTsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiAKPiA+IAo+ID4gCgo=
