Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660AEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F8964E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhBWWv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:51:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:16407 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbhBWWsT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 17:48:19 -0500
IronPort-SDR: zqV7wH79AgMRoA+xefG2vKorGoThO/VJZiZvqDmdARIgKFhRXDf58nS1JVwrMn8FfcSuJPzkmy
 FG/eKD5hQi9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="181540110"
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="181540110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 14:47:34 -0800
IronPort-SDR: EkA0LR73z2/tc4L0CIjhaRSW3mAFOvVou9O/nmyUjHd6XTFQ2UZ5x5hhIGXHo/niKqyAa74FxD
 Sw3chiXSQagA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="432964528"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2021 14:47:34 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 14:47:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 14:47:34 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 14:47:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nog041hzC9/TTP2cyMXovJMhpVcyw+v0MDFOHseXRDMDhyqrTnX8IYsBKk9dI5nhIkDWamOBG24dPxoU1hzGhxT0vx2S1bAzt+ikrJNcV7+LWf9iugTWw+nnDoHLN2daIL7UXOaGCDR2y80SVOjsvTuOqMN8nDCUKpm1iA8T6be0yw2WbRLPoDzdbvHKHCuxqh3/60GigXvnGD8XqxTkcnTqi9XU1H8GJuXkBb4r3KYzcFy7HkFdkZ2OpW2pf264WjaOlnf6l6yFbjIm7Xw3Nd4gxRpO3WSaW8dDWptaxBPhAX8ijiS0G8wNaFi5pGMO64w7lBNBPs9SaMONaWX+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVc7feHSQ1bzDW6sbwKpmcT+r5zs3lEmj6jtUFJ2cSI=;
 b=UIVX8WtJernWCLqHPkWLOSKCCoQVgY1/Wf0pGGz7N1g+v2rNOdWTD+ydH3pLeu5AkJEe2S/P+Kb6XpgZ/g6OjXQd+AtmHBjz360v3eymU+m/J4wCQj1zHfpkulXjYTD3cvBj1mKeVlHoEC48fQs03cr88Bh9n1RVdj30NSaK0rsl4WaQZ88nxxLQAY2UUwb4nK+3gl3GCRp0knh7APBoVUEUEipackariAfu4lxTUSkDUHKVm7EC4HmILN8Yytf+s/ii+5wjG4wH6Qci6cSBveN8At7oogWohOineEmoBwQtXioxgFvfGArEeSJGk5ZTHc7VIWI9/QdgBNAQ7QRw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVc7feHSQ1bzDW6sbwKpmcT+r5zs3lEmj6jtUFJ2cSI=;
 b=E7qhCMOF5MB4vDmG0ZbAMltMeZtoJjIm46WthOserlOxD/uqvrUbO7dVhOg2ONbU+jpJYzXSwaHb32hoc3UkOCfnXLEtHZqmWYbefwTaZHGyNKBMuZOSRaJCZHQ2h7G2c3SfLfXBaYQYhgD8tiLMUHoH7VbINgSkZbRkMSwZjsU=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 22:47:32 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::4459:c317:c9b0:e822]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::4459:c317:c9b0:e822%8]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 22:47:32 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [BlueZ,1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
Thread-Topic: [BlueZ,1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
Thread-Index: AQHXChuvaDO4W6BI3U2027NhN9teDapl0WoA
Date:   Tue, 23 Feb 2021 22:47:32 +0000
Message-ID: <F7A26AFA-B4BB-40EC-884F-7ED3787033B6@intel.com>
References: <20210223190904.1718994-1-luiz.dentz@gmail.com>
 <6035597f.1c69fb81.b6540.2f16@mx.google.com>
In-Reply-To: <6035597f.1c69fb81.b6540.2f16@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.45.21011103
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.164.224.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1424f929-9dcd-4f4d-2e31-08d8d84d01da
x-ms-traffictypediagnostic: CO1PR11MB4948:
x-microsoft-antispam-prvs: <CO1PR11MB4948BCB44AE70A52367598DAFF809@CO1PR11MB4948.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5QAHWAnJ8pEKPgZnZrWh/wB6d8Oy/2VsDNFTvZfnAYRvlUl9pi83wK3526mKIPaMOUoNbLoBdcnfH48RsMV5cid6WwtYkvOTjuraJj9x5b/5N0cJTe3cNKOU5gRJDk2jMf5Mk2jFB+Vf05x2DaXu/5HQ7lqHgr8kO30nQ5WS7z3iuH0xt+uGjaQNG4rxrehy6OlAIsJvE/uBNx8SAjsX2r1V2KChtW0pWpWI3ZJMCnbGzQ/UIdi6U6qARZYLXfhevqniVFIoy45u+4UfWAkvCdXsnorzc2bK8zcVVXgiz26gnX81w6Mosn0BrhmCEkgHc8Wa0bJKEYxpDja5BBT/z22AfFTz2sjIM0yQ7TIirqCAU4Pfy6R1s3n5P1rVUWL+BUVNcunl/FIBJ3g2rTDkN3CtWOio7rs/akzmQI8U+5cx202OFr6yij/PSHmbTFMoW/cmZKG15KBEYz17rdY5w8l4geqgbY4Y9GJRR8CSA0M5Xb4f5QglNTbbBzmvVu5KVk7fHTEdnf1gH1jYaadysHB4/yRjYsWPfbn6/zqJwA7YrB2GN2GCsrEPpGY1w8zvrGYrqwEG6ts9y0ZyTtgfWaAa91si/A3Rqua8QRnwACoLbFMdx+wrTw1djfwqU+2HVpvZDsBf4GGRh+vveXmpQKNyV84jgF9DA8Gsy+y7mQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(66476007)(6506007)(83380400001)(2906002)(66946007)(110136005)(6486002)(478600001)(76116006)(66556008)(186003)(64756008)(8936002)(71200400001)(5660300002)(36756003)(66446008)(86362001)(6512007)(33656002)(8676002)(2616005)(316002)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?djNNUkFQT2RrWVNGSHF0VUxKSVdPRmpjMzlvZVQ3U3ZzNHVjY012VFFzOVgy?=
 =?utf-8?B?OHhHSWpleFpXaTlnU0hmMGJGZlZBa3hWY3drNVFtNENlSTNVeDFFVlQ4azZG?=
 =?utf-8?B?Z3AyR3V4SU9zZ2llamU4bFJuYURzQSs5NGRyWEhBdFdhNjZBdEdUVjRqbnFM?=
 =?utf-8?B?dUFYcysvNEFHVGp1R0xmdGRibFUzV1ltRkY5aWhwb3V5cDBicGJwWmNmZDdW?=
 =?utf-8?B?RTZqZjJrMElKM0U3Nlc2RmtJbDhSWUs2SXRsYlJ4N2xIR3JtUzBhUVZQVzIx?=
 =?utf-8?B?cFZWSGk3ZkFXTU9QRFZaT0JWV25ldCtUOTNrbTdQVGdTOU0xVkppTEhiSkxu?=
 =?utf-8?B?VWFhQXRjUU5HNW80NWlHU1VVSUhpbVNnT1dRSTNPOGR0T0FGL2pZNEw4dDlW?=
 =?utf-8?B?VVc5VnVjY1NtczcxdUpCK3VKeTA5Q20rYzRoOE9IMzYrREF6a2ZnRmM3cXhQ?=
 =?utf-8?B?bGp1UUVhNG1uQ2NQNGRZL3prU21aUnhjWmdqL0RNVUZLcmZDdFdGdEJnOTd1?=
 =?utf-8?B?a2s0TGVtSEFDOTc1Nndiem9JWVA3Q1E5M3h0cDhvNGdST2hibE1sV1RxNkNv?=
 =?utf-8?B?NDJMRmJNVElxTzViY29Rc0tYdnprSktrbFljLzAxRG9VdVlxNkVGczJNV3la?=
 =?utf-8?B?Y3lsZWVqcDEzbmxsMXg1QlhsK3JDa0d5Nkd5YzhCWGc4UzQrUmxIQzRJcFd2?=
 =?utf-8?B?UEwrWjdsbTdOd24xaUJSWWFaVHJERTdaZHFzR1dMWDdpckxXcDV4MGZvM2xo?=
 =?utf-8?B?aitENlVNQmlKRzFUVE1SUmlidU9iNFkxWmNDSURLSVl6NW1CN2pKbURQbVQy?=
 =?utf-8?B?MzVtNzhWaFVvdyt2US9wS3BzalpuRXVPSDgxQkFEc3Z3ZXU4RDRBRld6U0ZE?=
 =?utf-8?B?YWtEQ2tINkxVY2I4Nkc2Z1NMY0dITE40MEIvQjVtS0VDYStxRXlJNWR0dkhJ?=
 =?utf-8?B?T05IV0RpcFgwZXpLVEgxc1RDSFBLeGFBc2FISURhNW9sUVhhZ3dxeFdXaXA2?=
 =?utf-8?B?VXZIeGRHZE1PcW5TeE9iNDlkWkVpQjdWTC9mU043Nmw1Q1N2aG83UFd3KzZB?=
 =?utf-8?B?Z3B0UkdCb0Y2akQ1UGxkYUNWOEV5dU9YazJYVnZRbCtyNDhZcWh0UmZ1K0NZ?=
 =?utf-8?B?V3NFOXN1MEM0M2lISW9PSS9Eb09DN3dlYjFNSHMyME56ZjhIUUh4VE01eWFQ?=
 =?utf-8?B?aENxcUlEMkVHc1JuRjJXZVVqTFhJUS9icGdweUQwMkZCeDlERi9BNDJ3YzIy?=
 =?utf-8?B?S2EwNFMrcGIwem5hdjY3K3BEbklOaTNnTEQ2VGQvb1ZyRk5hd1NnMnZkTnM2?=
 =?utf-8?B?ZDVkb1Q5clRrZ2Y5VHBnK2dXRjRqTnltcFI0a2dvVUIvaFFGRmpqMnhVNkRs?=
 =?utf-8?B?YjhSR2NVOGxWOVZXMEJZZS9GMzNXY0tPRkc3L2F0aHZWeUh4aEdhQnc0bmJF?=
 =?utf-8?B?aFJieDhZbGdOemxld0RaQzZFckNTbjFtOUpQa1cyWSs4VUZ2ck1yMnBncnd1?=
 =?utf-8?B?NUtnemg4WkxZaXFmR0c0bHdrVlI0eGhrbnd0Mnc2NHNSUGVQVXlpbEtFNzRk?=
 =?utf-8?B?amIxdGgxVTlhT05uejJZUkxaTzdRR3hBZklNVE1iQUp0WDRTUU9SbjNIanZD?=
 =?utf-8?B?eUJSV0hhN2krbVRTN0U0RnVtYjZCZFdWeWp2YW52V241L2RnK3ZYaGxicURM?=
 =?utf-8?B?VTUxN2l0a0xvU1o2aUpUTVJ4YXMxKzZxaDd3TmpwNGFwQjFLMU4vY293bFgr?=
 =?utf-8?Q?XItdalINonbe9CliwqCov2WcPcuSraXG9JvQCOd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5B7569A72D48943BC7C37B75833F655@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1424f929-9dcd-4f4d-2e31-08d8d84d01da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 22:47:32.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELLV/9CS9Z0vwkUNY7KkzwRYZF1sgpT3TA4HNzpYUfAWSHtfgEDZeZZfFGnpF067UPFIeXetkCHlY6+koYxJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeg0KDQrvu79PbiAyLzIzLzIxLCAxMTo0MCBBTSwgImJsdWV6LnRlc3QuYm90QGdtYWls
LmNvbSIgPGJsdWV6LnRlc3QuYm90QGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBUaGlzIGlzIGF1
dG9tYXRlZCBlbWFpbCBhbmQgcGxlYXNlIGRvIG5vdCByZXBseSB0byB0aGlzIGVtYWlsIQ0KDQog
ICAgRGVhciBzdWJtaXR0ZXIsDQoNCiAgICBUaGFuayB5b3UgZm9yIHN1Ym1pdHRpbmcgdGhlIHBh
dGNoZXMgdG8gdGhlIGxpbnV4IGJsdWV0b290aCBtYWlsaW5nIGxpc3QuDQogICAgVGhpcyBpcyBh
IENJIHRlc3QgcmVzdWx0cyB3aXRoIHlvdXIgcGF0Y2ggc2VyaWVzOg0KICAgIFBXIExpbms6aHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9
NDM3MzMxDQoNCiAgICAtLS1UZXN0IHJlc3VsdC0tLQ0KDQogICAgIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjDQogICAgVGVzdDogQ2hlY2tQYXRjaCAtIFBBU1MNCg0KICAgICMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KICAgIFRlc3Q6IENoZWNrR2l0TGludCAtIFBBU1MNCg0K
ICAgICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KICAgIFRlc3Q6IENoZWNrQnVpbGQg
LSBGQUlMDQogICAgT3V0cHV0Og0KICAgIGNvbmZpZ3VyZS5hYzoyMTogaW5zdGFsbGluZyAnLi9j
b21waWxlJw0KICAgIGNvbmZpZ3VyZS5hYzozMzogaW5zdGFsbGluZyAnLi9jb25maWcuZ3Vlc3Mn
DQogICAgY29uZmlndXJlLmFjOjMzOiBpbnN0YWxsaW5nICcuL2NvbmZpZy5zdWInDQogICAgY29u
ZmlndXJlLmFjOjU6IGluc3RhbGxpbmcgJy4vaW5zdGFsbC1zaCcNCiAgICBjb25maWd1cmUuYWM6
NTogaW5zdGFsbGluZyAnLi9taXNzaW5nJw0KICAgIE1ha2VmaWxlLmFtOiBpbnN0YWxsaW5nICcu
L2RlcGNvbXAnDQogICAgcGFyYWxsZWwtdGVzdHM6IGluc3RhbGxpbmcgJy4vdGVzdC1kcml2ZXIn
DQogICAgY29uZmlndXJlOiBlcnJvcjogRW1iZWRkZWQgTGludXggbGlicmFyeSA+PSAwLjM3IGlz
IHJlcXVpcmVkDQoNClRoZXJlIHdhcyBhbiBpc3N1ZSB3aXRoIERvY2tlciBpbWFnZSBhbmQgaXQg
aXMgcmVzb2x2ZWQgYnkgbm93Lg0KUGxlYXNlIHdhaXQgZm9yIHRoZSBuZXh0IHRlc3QgcmVzdWx0
Lg0KDQogICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogICAgVGVzdDogTWFrZUNo
ZWNrIC0gU0tJUFBFRA0KICAgIE91dHB1dDoNCiAgICBjaGVja2J1aWxkIG5vdCBzdWNjZXNzDQoN
Cg0KDQogICAgLS0tDQogICAgUmVnYXJkcywNCiAgICBMaW51eCBCbHVldG9vdGgNCg0KDQo=
