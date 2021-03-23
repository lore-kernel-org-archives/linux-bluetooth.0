Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F9AC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931A8619BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhCWUwH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:52:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:49845 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233281AbhCWUvu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 16:51:50 -0400
IronPort-SDR: vPXby26+AmzH8X10ppXbBXhx1i0DI48SMgFpwf9aliRoioZ+Mr6kYxWF4HQEzlQ6lADQSJMZKz
 6GNpyTUg5JRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190660750"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190660750"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 13:51:50 -0700
IronPort-SDR: 6P5B3tq9XjhWaWpcn9BPIvnBQCtDQaUV4iEgE3EFhsPZJzZEy6O+XjZw2fWaaCbazyVuiABSxj
 x34n0hijKZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="524983502"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2021 13:51:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 13:51:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 13:51:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 13:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDl/58M6j4aBc638LIR/YYva/HuS3wnE2MfmuOslLNBd9aUONIM253n7WJ6A59qYrMVJFFqNzN7zWUm79ftILsv/KaLGyZeO9LFelW9hNqggCHy9cwjLphZrW5iwDvR4P2cDIjix1GHceCD05YtvP3v+x8cefSdBlIP5IwzEDogH+lkzCuotxMyumV2+mFbU10fee3jpsgzAciFYJBaAbjNyxki0yyqIFZVVGwTffPXA6ISI6S4IcGygWcvnw7bNlBs0tZEA/hygoZNUjYQfL+77yhiItLeaxWcGflKmar43t7QBoa9SAC2N0hF7D75JKOZhDjx4MmceN86a6BnuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9ZvP3oWE8k5A/lEUwu9cJxes5yAoZbW6FE5owbpAbo=;
 b=QYfDsTxrudJmGwcA/slKGESut1VF6IZtQeR5PEu0WayCDGscMH7SdP/vcV8bFM540cD9C/uueKNgZmPh7MsqLrDVMwRQCXsaY8A1qeo3aoFVWaDDIMlckrWTdEX6UY/vVpy9W0WwjkyOCKRluKbVv1DF3kC2G//r2zU5hGSXQUOzfG9ILBc12QeLQdYdC1ggJryWmxoVskW6oYcdA/eVWsb9psYa+3W6CRKxEbVlaDSqjZ8lIQWajd8o8cUZUs3nWKCeb4NHxAPi1xnSR3obb1RVpqYDz7SJCr8zNoCdU9QJMKlsS08x3vFwhc79IHNzoH0OBn/eaXDCXkA1zZHTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9ZvP3oWE8k5A/lEUwu9cJxes5yAoZbW6FE5owbpAbo=;
 b=U1CJmvvwwrvqFwkE8mR+o38HAVBKNoAlXg1H3DjfD0h7W/X6/Baqng0LlTn5BR5v50o+A6jKgSqEDGuYz8UCbfizc9d/cQnZPH2esNG55E8DaLE0iVk292k0/O1a0EzsKrcGh/9pUN4jUvhdqWwp6PxLnPU+xspSEqj35i+AQVw=
Received: from MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 20:51:48 +0000
Received: from MN2PR11MB4741.namprd11.prod.outlook.com
 ([fe80::b882:37e2:4d6a:1ccf]) by MN2PR11MB4741.namprd11.prod.outlook.com
 ([fe80::b882:37e2:4d6a:1ccf%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 20:51:48 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version before
 download
Thread-Topic: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version
 before download
Thread-Index: AQHXIBa6NZ6Tvo4t+0iqq6OPeq6DCaqRlyeA
Date:   Tue, 23 Mar 2021 20:51:48 +0000
Message-ID: <0702034E-2AC9-4AB3-89F1-0E282650F7D8@intel.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.45.21011103
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.115.118.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d86078f9-67bf-46d7-3e2b-08d8ee3d7a3d
x-ms-traffictypediagnostic: BL1PR11MB5287:
x-microsoft-antispam-prvs: <BL1PR11MB5287CAD67A181A4C53341E20FF649@BL1PR11MB5287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iedC6ImlQIMkbBodqOZ30GpiaxvDCV0B95k1XErUQATF6GdZisEb/rFHs9AtC/BBtfhMp2rDZbbi1CeCpYwKWrVqjv0y9yCoZ8JXV6+ylFxILxStlXrDKjg6SsO7a1E7ivwtQMv/oqhMaLlc1MDyNoezw1Xgft3GwCv1tNewhwqps13V9YUufRe2/KWw3CFw1VGPxK8MIP5HzArxKEz51xARWY1f6TCVT47L6b3jMGv9cxmQpfpKbDjlk8bVc2XuUxAjwLzCi+fHFKmlUzEyIJKwAep/4Vk/B/CMbqnc2pYy/pxpAgsZydSCGghdtz3eDItSBkoVbZFKV5rR89kZwYon9nZtmnrUBigzPF2wVDtQBwGQJXFdyKEAmgHGk33Q922T8911t+fUPAoVKln0GgdkguMzY/hTTr4Zk1eHeKiu5DA3vTQfedtnCN1rEkDmhwIPdHX5gFPyr/1/MM3XTc5JjlUZ95LiX+Bf/Ia2oWFFLrOSqvSjKYPILz38ElcBYDIUo55NTFAnkNMGcpe+CtaGg++AAGo4WXZUcAIKLgNetiWV0lNbXIWH9cjYsrEBCQGqav7SZtdJ01gMJ6xrAvJ+s10O0VYNY2XraPARH6+VCrvzX+vuz6z78n6kDnYyl15ukfKOl/foXar3m4ogVXemrYI+bAecaDdjdvTv/OPEpExVWQS1wFNtZqfbpuuR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4741.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(83380400001)(64756008)(2906002)(66946007)(66446008)(6486002)(66476007)(71200400001)(478600001)(76116006)(2616005)(91956017)(33656002)(110136005)(316002)(66556008)(6506007)(86362001)(5660300002)(186003)(36756003)(8676002)(8936002)(38100700001)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c2N5Wmlqd3c0NHRzdjIwalJCYkhjaHQyWFJaL3htaDZCNkYvcDF6VTIvUWl5?=
 =?utf-8?B?dWxoREp3UXYremZwTjFzM1V3NENaYnkxNklGVXNncW1zWERRdDJZL05OeHNs?=
 =?utf-8?B?RVMvaHdDVDhXWjlLWUR2VGQ3VTdoRGJ1eXNXTCtJekdzN01qQUpTZityeURM?=
 =?utf-8?B?WU5aa2p0RThHSnNQQTdkVUNQZzdvSFBBRGd2YWxDWmxOZytJNi9PY1NTR0ky?=
 =?utf-8?B?c2VQY0plRXE4akJ5UTJKckNVVkVlTEMxQVBzV1YxbkZpVWdETmZWS3FBTFdk?=
 =?utf-8?B?OEpoN2RvNUUzZ1pjbHRQWUhvSldHNDJQMnQ3djRaVFdEL00zRVRJQ1djR2Rq?=
 =?utf-8?B?TXY0WkhZRFZ4cnZ4ZHJTY2ptdWJLSGwvSWdXNVpPVmFvN0IweDNqeURkSUI0?=
 =?utf-8?B?Q0N1YTM3K3NWdWc4RThJZ09PZCtpdWxNUVpzMjhkY25yQXN3WEVoUy9GOUZR?=
 =?utf-8?B?dmVBZzJrOWl1NEZ4SDcyMURrR0JOUENRcUM1WmxiZWdCbmdJZ2tEZTZTVDJL?=
 =?utf-8?B?SW1FME0zTDBFeUEwT3BUWDhmUk5EU0tNL3ZTMHAwSURFYzhKTU91R2NBT1dR?=
 =?utf-8?B?VGZUbmUwTWlUczkxYW1NK2RjZmVqcGIyM0ZHQ000cmphcUc2ZVlnNVNnTU1S?=
 =?utf-8?B?YkR6eTE2YkduTDFsd0tiT29xMmVOZWVERGFGZDVHcEVmUnlEQkxXN2RwWXJ6?=
 =?utf-8?B?TktHOXBIZ2pBM1o0ZEJUZUhneUkxbm5WdUdVdWhHZHpUdWRaTlR1dW9LUFNP?=
 =?utf-8?B?MG04V3lXZTVCZmJaTmNTWG1VcjA5V2hKMFN1L1l6OUVWUjVQU1FPWVJGT1M5?=
 =?utf-8?B?R2VKL2twak9KbUxTMjJ1S2EwUVpqSnVwNHRyRGVTR1FJMXA4b0JsUXJ2KzRG?=
 =?utf-8?B?TmFwTWNqT0hpOHpJLzJhYW92M3pHcUVXTWtJQnlQbjczc29NZFFZSHdqVVdj?=
 =?utf-8?B?QXM0SEwwY21jSjBGTFFReURSK2RYVUJsTUIwclZGajZTVDlGaVJlOHN0djY3?=
 =?utf-8?B?MU5sYmZzZ1NOV0o2SmJ5NUUyUlNpcS9ScnJvaXlSZXVCTFdsMHJrRU40N3Jh?=
 =?utf-8?B?T1V3OFA2eGNRc0RobXlZYUREVHh4Ym40Q3F5V1JWL2tWbkpNb3ZZRjZUbms4?=
 =?utf-8?B?RVZHMk00ci9tRkhsRXo0V3hSN3VLdHlCR0Rjbmxmd3ZwUnZsajltdUJNc1RW?=
 =?utf-8?B?Y1U0SHZ6ZDhEVVhIZWN5a0hQeVZIRDlOVEdXU2RGSmFYSzVwQlNFSGQ3UzJL?=
 =?utf-8?B?OHpQQXlhR3VTaVZEZlRlL0xwTGF1UW1mbG91UGtiZlF1NDF6VlJ0WUxXK25n?=
 =?utf-8?B?VVR4VjNoTEdremEyVzBWK3YxbGo2dFBDb2Y3SGhMclZhZ2NCYUJzVUZsV2Uw?=
 =?utf-8?B?TFZUTnk3ZmlKbnR2b2ZFdHo3dmdiUnN5UjNaelpyU0x6Tm50bDJ3OVdtVTVk?=
 =?utf-8?B?RXFSRkowdHhiaHN3MlR3bjVxemVoZDRpVWhoMVI2MEtneS9xUFBmOUV2ZWhI?=
 =?utf-8?B?R2xKNmlneDY2VjB2REdZRXlSZWJQTlU0QkY5QWtobFJrMTVBMlNCZnJmdUdY?=
 =?utf-8?B?S29aVlB0cFMxaElxWUw4M1FjYWVRQ0kvNFNEYkt4UHk0Tk1lVlR2dk9LQnFV?=
 =?utf-8?B?WXlzaU0zempaMlJDdG41RU5aL3hYcGF5S055a2RDNlB0d3NPSkpUNGs5U25M?=
 =?utf-8?B?UTBXdzRUK0dOMlJIU2JwcHg5QUNBVzdnOVUza2lOR3VZYm1wNWdEbWFLcCtT?=
 =?utf-8?B?ZFhpUXZkS1ZlVjROMDN3TzFyL3d2Qk42eVlWcEVnT0FkdThtVTM2ck5LK2Vu?=
 =?utf-8?B?N0NoVW51WWszZnAyS01rZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BDFCB68F9D3E9479D73A6556BEA2FA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4741.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86078f9-67bf-46d7-3e2b-08d8ee3d7a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 20:51:48.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+9COzkQo8h2lGu9U7WSQbFrdRKZ1tYaefS2rts98fSGWE5r4FEWnqunrjV/r6BX67LlbZhU4VthMWdafrB9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0K77u/T24gMy8yMy8yMSwgMTI6MDAgUE0sICJMdWl6IEF1Z3VzdG8gdm9uIERl
bnR6IiA8bHVpei5kZW50ekBnbWFpbC5jb20+IHdyb3RlOg0KDQogICAgRnJvbTogTHVpeiBBdWd1
c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPg0KDQogICAgVGhpcyBjaGVj
a3MgdGhlIGZpcm13YXJlIGJ1aWxkIG51bWJlciwgd2VlayBhbmQgeWVhciBhZ2FpbnN0IHRoZQ0K
ICAgIHJlcGVjdGl2ZSBsb2FkZWQgdmVyc2lvbi4gSWYgZGV0YWlscyBhcmUgYSBtYXRjaCwgc2tp
cCB0aGUgZG93bmxvYWQNCiAgICBwcm9jZXNzLg0KDQogICAgU2lnbmVkLW9mZi1ieTogTHVpeiBB
dWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPg0KICAgIC0tLQ0KICAg
IHYyOiBBZGQgcGF0Y2ggdGhhdCBtb3ZlciBjaGVja3MgZm9yIG9wZXJhdGlvbmFsIG1vZGUgYWZ0
ZXIgdGhlIHZlcnNpb24NCiAgICBjaGVja2luZy4NCiAgICB2MzogRml4IG5vdCBjaGVja2luZyBm
b3Igb3BlcmF0aW9uIG1vZGUgYmVmb3JlIHVzaW5nIGJ0aW50ZWxfcmVhZF9ib290X3BhcmFtcw0K
ICAgIHNpbmNlIHNvbWUgbW9kZWxzIGRlcGVuZCBvbiB0aGF0IHRvIGNvbnRydWN0IHRoZSBmdyBm
aWxlbmFtZS4gQWxzbyBhdHRlbXB0IHRvDQogICAgY2xlYW51cCBkdXBsaWNhdGVkIGNvZGUuDQog
ICAgdjQ6IEZpeCBmb3J3YXJkaW5nIC1FQUxSRUFEWSB3aGVuIGZpcm13YXJlIGhhcyBhbHJlYWR5
IGJlZW4gbG9hZGVkLg0KICAgIHY1OiBGaXggbm90IGFkdmFuY2luZyBmd19wdHIuDQogICAgdjY6
IEZpeCBidHVzYl9zZXR1cF9pbnRlbF9uZXdfZ2V0X2Z3X25hbWUgZXJyb3IgY2hlY2tpbmcgZm9y
IGRkYy4NCiAgICB2NzogRGlzYWJsZSB2ZXJzaW9uIGNoZWNraW5nIGZvciBXc1AvU2ZQLg0KICAg
IHY4OiBSZWFsbHkgZGlzYWJsZXMgdmVyc2lvbiBjaGVja2luZyBmb3IgV3NQL1NmUC4NCiAgICB2
OTogUmVpbnRyb2R1Y2UgYm9vdGxvYWRlciBjaGVja3MgYW5kIGFkZCB3b3JrYXJvdW5kIGZvciB2
ZXJzaW9uIGNoZWNraW5nIHdoZW4NCiAgICBvcGVyYXRpb24gYW5kIHZlcnNpb24gY2Fubm90IGJl
IHJlYWQuDQogICAgdjEwOiBGaXggYnVpbGQgZXJyb3Igd2hlbiBCVF9DT05GSUdfSU5URUwgaXMg
bm90IHNldC4NCg0KICAgICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgICB8IDEwNiArKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogICAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWwuaCAgIHwgICA1ICstDQogICAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgICAgIHwg
IDE4ICsrKysrLQ0KICAgICBkcml2ZXJzL2JsdWV0b290aC9oY2lfaW50ZWwuYyB8ICAgNyArKy0N
CiAgICAgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0p
DQoNCkkgZGlkIGEgcXVpY2sgY2hlY2sgd2l0aCB2MTAgYW5kIGFsbCB0ZXN0cyBwYXNzZWQvZXhw
ZWN0ZWQuDQoNClRlc3QgU2NlbmFyaW9zOg0KQ29sZCBib290OiBFeHBlY3QgdG8gZG93bmxvYWQg
ZmlybXdhcmUNClJlYm9vdDogRXhwZWN0IG5vIGZpcm13YXJlIGRvd25sb2FkaW5nIA0KRlcgdXBn
cmFkZTogRXhwZWN0IHRvIGRldGVjdCBmaXJtd2FyZSBjaGFuZ2UgYW5kIGRvd25sb2FkIG5ldyBm
aXJtd2FyZS4NCg0KVGhQLCBUeVA6IEFsbCAzIHRlc3RzIHBhc3NlZA0KV3NQLCBTZlA6IENvbGQg
Ym9vdCwgUmVib290IHBhc3NlZC4gRlcgdXBncmFkZSBkaWRuJ3Qgd29yayBkdWUgdG8ga25vd24g
aXNzdWUuDQoNClRlc3RlZC1ieTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+
DQoNCg0KUmVnYXJkcywNClRlZGQNCg0K
