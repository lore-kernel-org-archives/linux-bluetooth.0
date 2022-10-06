Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 20:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiJFUzl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiJFUzi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 16:55:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8C7392C
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665089737; x=1696625737;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ChDOMFrq8JxNHRhBF9Ug6M4u7lIkYR11L49nfbzjMSc=;
  b=O/oRX+r5/qIoVn7RLtaxoTFnKCQbg/A5yHeyQHrUYimZy7zoKTs4OfDv
   sbZYk8Wqq5hkKf5slpytuMUtFwqKFGh7UACx62/P+Np7P1WOsJVt+5FnB
   CjRuhh3rXlZkSGfiZgdhLr6OilX+K+wdnNMIIwPNjFdpEkALMi2PtYoTW
   vct+uuyIMmZiBesLJGvTnb0vPEOe5ODwtO6Qo4heUSxK84sfT8kf9CaBS
   YIsZYPl5QMRSG/KBsrUR8QAAVXU8niqgzPGCVKfAFE+LjrPskONKmEdw9
   At22ItR5iI61XxskUXZGIphyMs9XQRjPWeRVfnOSHC+Gh9V6nlMn9cNG6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303545740"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="303545740"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 13:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="619993664"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="619993664"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2022 13:55:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:55:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:55:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 13:55:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 13:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcsxXY6MsUU3dgDTVxdWk9IgP7ymlBzGDxkNiYE0d1a5y+zQ5MNxADFhDEiAMc/4TRONGUy9CG1mOiv2HxBsIH8/lLT8if0EsLS49Dz3N/SgoUO2WuY7iUXQj6sKWK6SXnCdpzSInbMBTlU5ckaBVWiVvoGmk6Ah6yBW2Q18YMjHJcRnGraK3EzgA34yBklYiHpxVpMsX3EueyTh0pHMAUK/XVF71Dn0Z4acwtsgmRjQ7O7iqh9pp2jy/xfgkd+ti9t2ih3A69ecP30YrGXc2uwVzWELwfPN2z4yRoOv8NLThhRh4jFvxwvhiANogosZvmjC5glPCfF+X/PnWmjfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChDOMFrq8JxNHRhBF9Ug6M4u7lIkYR11L49nfbzjMSc=;
 b=TxweVH7EI9+WqG2PV+EKI0AlLNtrGF3ZWCIo7r6b5t98BeK3BCs+386rZSgvTnAKu0CrbCyHb2lE0rcMH/v22h0YoOOCki2pMGaGc4LKvmbYHzy2QbFPKMRZkCmMYTInh/vEtYVvazlAf7g3Rq4DYLIs8kou/XMVPynkgpAsSTSYvbQ5r+m2+1ApdxjWAuTTZhKe0+uXsB6AHWtEJXDUiPW7TyWdt+Lz7qIg5ODyHXnBetqcy1vHdAVMh0EnQklx9WJ/vPGdxaW1flVFIs88z+wclZIHIqN2n2zSfTUSm7v2qC3JWEWfNN8dGxvURL50UIust7E+D8UyHaF2738pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 20:55:10 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 20:55:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@loytec.com" <isak.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Topic: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Index: AQHY2ZRgur1htrK7GUOmXNyNl6ZlBa4B2K6A
Date:   Thu, 6 Oct 2022 20:55:10 +0000
Message-ID: <4c8e20487a5ee71088bf6374bae8fd55a95055b3.camel@intel.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
         <20221006145927.32731-6-isak.westin@loytec.com>
In-Reply-To: <20221006145927.32731-6-isak.westin@loytec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|DM4PR11MB6455:EE_
x-ms-office365-filtering-correlation-id: 8d16cfcf-389c-4ee2-9085-08daa7dd0ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YBX3NycuefxcZYkhgiJlNjs9V8wYiUtl4I31CNaSEPK5P9Qr9au+FqGm/ImlYFy9gvpIQutDc7ix0nQhizKVnsdZ+rcx85QkCGGpdmU1VPxVTwQAWFD4im0mWCBAFIVJLeQUlRIuUqyFTRPiQ0rIxY5K572B9tBbfN+oXh8s7oxRmLGUl5N0XDlgk1bwOmQO2stOA796Nyn9GbH9hHAVS6ORf3f0W4OgVFW0+W6Cco4pa8C2ymmMsTwgZY0Esa96jAhePDEnnMRlUXRNPoOcNGOqBOuxulB41QNiqN6fQ0rEEdOxR6BWTYsvbwoB9hvtDKbT0ZzcbnECXC2ucAMmzsF+pok9MePOokWM9ptEoGKEqej6mtWqSMXPpqSTt3pWkfDiGMCr/7lVhEeuEd1yGd9Xw4+XJbn1fPHgBS98M9uqPOQtncWbei/3NHtIeTa1SqucOhblM8cIz3p0i3DfrI7+o1ng6faOVOnINNWZojkCVl+vdgeZF0WARjvseEgIkYn4M/Rmq0mutIlZmXPJCtLVJUBY3AJnHWylLhGVB1fGSDEEdlY3xh2xImMGRbK0jaBTt+/nNcD/HbPd2gsHNvOfY91odO9WfYqY1f0GARzcNea9yPclnJUgWe4MHbcCyRLWoZ6Alr6h/RfQZhGTXzj5xStFa0FFMoFBmNw2okP1h0K0Tox7JtWnAfZcYTMU1KboXGhraUm2p7Vah0uVFUKK6E7zT//VNnRGM6RQA6EJcPIFSVyqs8ZJDyd++MhZP11LQLDVfkb6JLdvYnY5bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(26005)(6506007)(64756008)(8676002)(38100700002)(66476007)(66946007)(38070700005)(66556008)(76116006)(82960400001)(86362001)(36756003)(66446008)(71200400001)(2616005)(6512007)(316002)(122000001)(110136005)(186003)(2906002)(8936002)(83380400001)(6486002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhGaE45blVmVmMwRkxjRmJMaXN2ekxTM3p1UnM1cktPa2IxaHdmQU5RZ0Rj?=
 =?utf-8?B?N1pvVGppUHBXdFBBTkFqMWRwRmJsN1dJakxNbXFuRC9Tdys2ZDNnczIrb29O?=
 =?utf-8?B?SjVXZzFWQ1FlWURGbGFETXJEa0NZcEM1SXdkNWI0d1BTOS9UM3ltL2hpYVpr?=
 =?utf-8?B?TlpST002REU4dkdROTZwWmJhZ2p6YnVuOGRtR1NxTDVHRzVKcHhlcXR6c0g1?=
 =?utf-8?B?WjREVlVvZnRPQjdGVUM4RWo3VnhKQnVrYTcxbUxjVDA4QzFsWUJPZzM4RUlh?=
 =?utf-8?B?SEM2RWZ1WHlNL1VHMUszNGtTWE5QYmZBOU0vRU5oWmpuTzcycHhhOVQxd3Ft?=
 =?utf-8?B?bHpObmVQRWkwRzJwV2g1VTJUTFExZ0F2QnJzaFFhZGZETWZLMWJPQ21xbXBL?=
 =?utf-8?B?MDhNc0krcUs3dGZrVEVURVEvNFByYjBpemhZVzkxTXl4cEVxcFpyY09jc0Ry?=
 =?utf-8?B?ZjNmQnFieGdpMDRyUHFFa3VpNGh2SlRsdTRlUldhUndDL1lQTHBuaXlCc2M4?=
 =?utf-8?B?Rzh3YVAzdjdablNXaUtkanIvejB5VmpYa0tkWVFWSkptZTVJd3VmQTZjQity?=
 =?utf-8?B?SEZXK2N3eEFpWTdhdEtVRktEWXhDb1ZFc0w3R0pTZHVPS1Z2K2RZTTFvMkk1?=
 =?utf-8?B?WDlKV05rZ0M2bGJHQ2NMRW1PVkNpa2VEeWxnbGRyeFQ2RUd6THdxTTRFNmtR?=
 =?utf-8?B?bkhwdktyc3NUaW5zRjQ4R3A4TjlkL3RGbll1YVNMTXM5a0dBc0puQmMzd2Vy?=
 =?utf-8?B?aDI0YURmTmpDbVV5SnNrNTFLSDdicHFERm9lUm1tTXdJNUxlVnRmWllST3Vy?=
 =?utf-8?B?dHVaYURDUnBoWnlhTXJVekwxdzNjR0lYN2VQbVpwSHlROStBSzVXZ1ZhU1JU?=
 =?utf-8?B?SFBXM255cTZueXMwTUpabXVmME1PM0pmeDlnb295MG1acGE2YkJNbGdTN0hB?=
 =?utf-8?B?Q01pRHZuRldrZU5OVklNVjV6YmZLRTBOOEtuMm1McTZWRGNhbmhNcnkxaWRh?=
 =?utf-8?B?dVBJbW5SSGRuenhZUGFuYjRERmo2WnNqV0JzT1FTcnJhcGtrTWtmNzhuMlFW?=
 =?utf-8?B?am5FTG0xN2x3R1VhaDZFZk5zaWRvL1BBREVieWZRd2hBR0ZUYmRhV0pXUG1R?=
 =?utf-8?B?V3ppQnR1UTcvWlBrZUhMMXR4L1YwK2d4enova2lwWkJkbjljeWRxVTlmZUNz?=
 =?utf-8?B?UjRlOXhMcjF2UEpCbEVpKzZSb1QyL0VIQkYzVW83NHVuNWlOdmYrUWFTcmxy?=
 =?utf-8?B?c0pMeHVISVVjcmhoVEhKdENUM2ZzR0xsZmNLRXNnN1BWWlBYeThSQkxVVXYz?=
 =?utf-8?B?cTVScURJUVRISkRyTW03aDJRVjBXd3lJTnNpVGd0ditNRHdyaDgyc1BHOHli?=
 =?utf-8?B?NXhmVGZ6QzFzSDBsV3lBYWY0MXdkYWZqSjRvUUhleHRvWGx2ZlhGUmpsS0Ny?=
 =?utf-8?B?M25ZeXNXa3lRMks3WnpOVzIvWGZFNHAramFlN0JiTmJLZ2cwZG1mYW8vUFQ5?=
 =?utf-8?B?eFFTaHNMdDY5YjNuSTdtOHY0blVxVDBYcVlsMTFSZW9SbTNZQUFiQnQrU2pU?=
 =?utf-8?B?Qk5IU0I1dUUzblZ0RkVvY2trRW01L0hJZFp4blR6Ly9GTFVTS2lGc2xQZ0hw?=
 =?utf-8?B?cHJJU1dzekw0VnlGem84KzFCQ2NkdW9xZlZtT0E2YWprbzQ2cWdUUGIyUzNF?=
 =?utf-8?B?Q3duSmhHd241VHJTR0Q0T1RnMWt0NWxmZGtpTVFzRUo4Y2pqZWliREIwbkw3?=
 =?utf-8?B?eXpxb0lsOFdkZ05JbDBFb2grK3ExTm1QZjRDWlVqeHZ5OVF1Sm96QVFaVWNr?=
 =?utf-8?B?YkhLS2NnNlI1SjVEaHNEazMvQnBPM2gxTFRPazNMYS9oQjN6Q25BUXFEMG9o?=
 =?utf-8?B?ejFMem1LdE5jR292WXc1S1lHbU4vc0lpa2RmV0w5SHkzTUEzQWhpRjBpaDhu?=
 =?utf-8?B?ZHJDNVFIRGdwOUFiZjQwRGRaQ0Q1RGM1MHpXenNsb29MdmhwNWY3K2lweVJt?=
 =?utf-8?B?azZhZlh3cGhVbDhGMDI0RW5za01ra2Q5aEwzdGprM3NYQXcxamZPS2JyL09P?=
 =?utf-8?B?ekZPbDhMcmJWRTczRlFYMWtFZy9jWGNlMjFza2sxWU5ibzl5LzNicCtWNUth?=
 =?utf-8?Q?VafrSYMFqgq1lpfLvae7Lppk8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C5940B1E3835F4BA428681CFD17D843@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d16cfcf-389c-4ee2-9085-08daa7dd0ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 20:55:10.1351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jP8A3mmX+D8ofattUlDeiNiStAeD4mNlkzNlsLie3J8iJ69z3RjAKTMTOMbyOzr7Gev4z6sai8PQkF8fBIioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywKCkhhdmUgeW91IHJ1biB0aGlzIHBhdGNoIHRocm91Z2ggYW55IHJ1bnRpbWUgYW5h
bHlzaXMgKGxpa2UgdmFsZ3JpbmQKZXRjKSB0byBlbnN1cmUgaXQgaGFzIGludHJvZHVjZWQgbm8g
bWVtb3J5IGxlYWtzPwoKSSBhbSBwYXJ0aWN1bGFyaWx5IGNvbmNlcm5lZCB3aXRoIGFueSBsX3Rp
bWVvdXRfcmVtb3ZlKCkgY2FsbHMgdGhhdApkb24ndCBpbW1lZGlhdGVseSBzZXQgdGhlIGZyZWVk
IHRpbWVyIHBvaW50ZXIgdG8gTlVMTCwgYW5kIGFueSBuZXcKbF90aW1lb3V0X2NyZWF0ZSgpIGNh
bGxzIHRoYXQgYXJlIG5vdCBwcmVjZWRlZCB3aXRoIGEgY2hlY2sgdGhhdAp0aGVyZSBpcyBub3Qg
YWxyZWFkeSBhIHZhbGlkIHBvaW50ZXIgb2NjdXB5aW5nIHRoZSBzZWdfdGltZW91dCBvcgptc2df
dGltZW91dCBtZW1iZXJzLiAKCk9uIFRodSwgMjAyMi0xMC0wNiBhdCAxNjo1OSArMDIwMCwgSXNh
ayBXZXN0aW4gd3JvdGU6Cj4gV2hlbiBhIFNBUiB0cmFuc21pc3Npb24gaGFzIGJlZW4gY29tcGxl
dGVkIG9yIGNhbmNlbGVkLCB0aGUgcmVjaXBlbnQKPiBzaG91bGQgc3RvcmUgdGhlIGJsb2NrIGF1
dGhlbnRpY2F0aW9uIHZhbHVlcyBmb3IgYXQgbGVhc3QgMTAgc2Vjb25kcwo+IGFuZCBpZ25vcmUg
bmV3IHNlZ21lbnRzIHdpdGggdGhlIHNhbWUgdmFsdWVzIGR1cmluZyB0aGlzIHBlcmlvZC4gU2Vl
Cj4gTXNoUFJGdjEuMC4xIHNlY3Rpb24gMy41LjMuNC4KPiAtLS0KPiDCoG1lc2gvbmV0LmMgfCAz
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9tZXNoL25ldC5j
IGIvbWVzaC9uZXQuYwo+IGluZGV4IDM3OWE2ZTI1MC4uZTk1YWU1MTE0IDEwMDY0NAo+IC0tLSBh
L21lc2gvbmV0LmMKPiArKysgYi9tZXNoL25ldC5jCj4gQEAgLTQ2LDYgKzQ2LDcgQEAKPiDCoAo+
IMKgI2RlZmluZSBTRUdfVE/CoDIKPiDCoCNkZWZpbmUgTVNHX1RPwqA2MAo+ICsjZGVmaW5lIFNB
Ul9ERUzCoMKgwqDCoMKgwqDCoMKgMTAKPiDCoAo+IMKgI2RlZmluZSBERUZBVUxUX1RSQU5TTUlU
X0NPVU5UwqDCoMKgwqDCoMKgwqDCoMKgMQo+IMKgI2RlZmluZSBERUZBVUxUX1RSQU5TTUlUX0lO
VEVSVkFMwqDCoMKgwqDCoMKgMTAwCj4gQEAgLTE2Niw2ICsxNjcsNyBAQCBzdHJ1Y3QgbWVzaF9z
YXIgewo+IMKgwqDCoMKgwqDCoMKgwqBib29sIHNlZ21lbnRlZDsKPiDCoMKgwqDCoMKgwqDCoMKg
Ym9vbCBmcm5kOwo+IMKgwqDCoMKgwqDCoMKgwqBib29sIGZybmRfY3JlZDsKPiArwqDCoMKgwqDC
oMKgwqBib29sIGRlbGV0ZTsKPiDCoMKgwqDCoMKgwqDCoMKgdWludDhfdCB0dGw7Cj4gwqDCoMKg
wqDCoMKgwqDCoHVpbnQ4X3QgbGFzdF9zZWc7Cj4gwqDCoMKgwqDCoMKgwqDCoHVpbnQ4X3Qga2V5
X2FpZDsKPiBAQCAtMTQ5MywxMyArMTQ5NSwyNyBAQCBzdGF0aWMgdm9pZCBpbnNlZ190byhzdHJ1
Y3QgbF90aW1lb3V0Cj4gKnNlZ190aW1lb3V0LCB2b2lkICp1c2VyX2RhdGEpCj4gwqBzdGF0aWMg
dm9pZCBpbm1zZ190byhzdHJ1Y3QgbF90aW1lb3V0ICptc2dfdGltZW91dCwgdm9pZCAqdXNlcl9k
YXRhKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWVzaF9uZXQgKm5ldCA9IHVzZXJf
ZGF0YTsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWVzaF9zYXIgKnNhciA9IGxfcXVldWVfcmVt
b3ZlX2lmKG5ldC0+c2FyX2luLAo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtZXNoX3NhciAqc2Fy
ID0gbF9xdWV1ZV9maW5kKG5ldC0+c2FyX2luLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1hdGNoX21zZ190aW1lb3V0LCBtc2dfdGltZW91dCk7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgbF90aW1lb3V0X3JlbW92ZShtc2dfdGltZW91dCk7Cj4gwqDC
oMKgwqDCoMKgwqDCoGlmICghc2FyKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFzYXItPmRlbGV0ZSkgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBJbmNvbXBsZXRlIHRpbWVyIGV4cGlyZWQsIGNhbmNlbCBTQVIgYW5kIHN0YXJ0Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRlbGV0ZSB0aW1lcgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc2FyLT5kZWxldGUgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBs
X3RpbWVvdXRfcmVtb3ZlKHNhci0+c2VnX3RpbWVvdXQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzYXItPnNlZ190aW1lb3V0ID0gTlVMTDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc2FyLT5tc2dfdGltZW91dCA9IGxfdGltZW91dF9jcmVhdGUoU0FSX0RFTCwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5tc2dfdG8sIG5ldCwgTlVMTCk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoGxfcXVldWVfcmVtb3ZlKG5ldC0+c2FyX2luLCBzYXIpOwo+IMKgwqDCoMKg
wqDCoMKgwqBzYXItPm1zZ190aW1lb3V0ID0gTlVMTDsKPiDCoMKgwqDCoMKgwqDCoMKgbWVzaF9z
YXJfZnJlZShzYXIpOwo+IMKgfQo+IEBAIC0xOTU2LDcgKzE5NzIsOSBAQCBzdGF0aWMgYm9vbCBz
ZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgYm9vbAo+IGZybmQsIHVpbnQzMl90IGl2X2lu
ZGV4LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IFJlLVNlbmQgQUNLIGZvciBmdWxsIG1zZyAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNlbmRfbmV0X2FjayhuZXQsIHNhcl9pbiwgZXhwZWN0ZWQp
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biB0cnVlOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoc2FyX2luLT5kZWxldGUpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBJZ25vcmUgY2FuY2VsZWQg
Ki8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBmYWxzZTsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHVpbnQxNl90IGxlbiA9IE1BWF9TRUdfVE9fTEVOKHNlZ04pOwo+IMKgCj4g
QEAgLTE5OTYsNiArMjAxNCw5IEBAIHN0YXRpYyBib29sIHNlZ19yeGVkKHN0cnVjdCBtZXNoX25l
dCAqbmV0LCBib29sCj4gZnJuZCwgdWludDMyX3QgaXZfaW5kZXgsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzYXJfaW4tPmxlbiA9IHNlZ04gKiBNQVhfU0VHX0xFTiArIHNpemU7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHNhcl9pbi0+ZmxhZ3MgPT0gZXhwZWN0ZWQpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogUmVtb3ZlIG1lc3NhZ2UgaW5jb21w
bGV0ZSB0aW1lciAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX3RpbWVvdXRf
cmVtb3ZlKHNhcl9pbi0+bXNnX3RpbWVvdXQpOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC8qIEdvdCBpdCBhbGwgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHNlbmRfbmV0X2FjayhuZXQsIHNhcl9pbiwgZXhwZWN0ZWQpOwo+IMKgCj4gQEAgLTIwMDYs
NiArMjAyNywxMSBAQCBzdGF0aWMgYm9vbCBzZWdfcnhlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwK
PiBib29sIGZybmQsIHVpbnQzMl90IGl2X2luZGV4LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyogS2lsbCBJbnRlci1TZWcgdGltZW91dCAqLwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbF90aW1lb3V0X3JlbW92ZShzYXJfaW4tPnNlZ190aW1lb3V0KTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNhcl9pbi0+c2VnX3RpbWVvdXQgPSBOVUxM
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogU3RhcnQgZGVsZXRlIHRp
bWVyICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNhcl9pbi0+ZGVsZXRlID0g
dHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2FyX2luLT5tc2dfdGltZW91
dCA9IGxfdGltZW91dF9jcmVhdGUoU0FSX0RFTCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbm1zZ190bywgbmV0LCBOVUxM
KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOwo+IMKgwqDC
oMKgwqDCoMKgwqB9Cj4gwqAKCg==
