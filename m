Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC2FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97DA60EE7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhI0U3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:29:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:65201 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236986AbhI0U3E (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:29:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="222667565"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="222667565"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 13:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="553466450"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2021 13:27:24 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 13:27:24 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 13:27:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 13:27:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 13:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BieXVlq8PGc44JjMD/EYvx+Tpy2rAG8+nPV62NU8KTSuXc+uT66RSlG6t7xR+aQDESRw6TiBE/RpHVOg7vBpt76bMkheKSPEL9DxoByrNQTjkBr6eSjuCU4Dp3fjUiq/0T4O/VSjM+E903rRateCd3nL9r5Jkckj+Z1Q5GkQBMvmU7KMVsfqr36yh5+QAVgKUJzNrlOPujUaCGqEwlBBvtd/TGazlzUup1mY49DkRLm0uFQQ6TFGh7Mmp1Lp+FpvzHYsMOioe6xrlhonJVAms+tFkW/Wkxw8Bgps2TJBwM+RO1bDuknzW3TyeLGaUtiI8bAFJy0SsnybBoeoE4/AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o655UvvKeyvP29AzGFewRzfva3KYVFGV9n62JXpO/Oo=;
 b=c1n74PcR5TUjzz1RhfS6gfQxU0dJEbF+QoeRLHRglEz/baLdmIOTmgJ9SaEeq9nYSPU1HlxfXb/b9SYpM4SoM3guM8CkRtsPQUI58FjpMhtRu0wJR7P7WqVNvs/Fbki+BiiAnR5Mgh2SjHx8gwuz32p37ZVtSVi7GT0mLuUdtJf/stgDOB9g+3XNqnyNCMt3oMNwifYoMrhfsKfUotaplZAsCiYWCYvX0ak128s0IyeEZkORxoKW+8YuFcPIP2hBWQSXAebTt0wp8+GlKDyhSAxLNEtq8jKr5zqNnyNIY69r9pDsomu7NXpBP7txn9qFm4BiO7LA1iIPFEXhCXrpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o655UvvKeyvP29AzGFewRzfva3KYVFGV9n62JXpO/Oo=;
 b=IbtQeXxvU+Jk8YPCD3IE9SFUUDXG2r9xo4PdWrOVmWYQcz9ENYAo2afOllKu5fwKn+P4L0nYZ/TdS2Mexjnsx5YtiU6x5QtptosoSmJmA7qA5/COB71tI0K9OxyJvEwiOsQpAB11kFsGBNYOayBY8lJbo77FfWNqMAjnheyTX68=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3054.namprd11.prod.outlook.com (2603:10b6:805:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 20:27:22 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 20:27:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 00/20] Mesh Configuration Database
Thread-Topic: [PATCH BlueZ 00/20] Mesh Configuration Database
Thread-Index: AQHXsCrbwtDWD/QNhU+WHBW1IvyXSau4W8+A
Date:   Mon, 27 Sep 2021 20:27:22 +0000
Message-ID: <ff95e7b41e93c79f176ca9f841ec781e980bd58f.camel@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec5c23e8-c635-4627-d529-08d981f53654
x-ms-traffictypediagnostic: SN6PR11MB3054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3054B709A7761D5D6E61A57AE1A79@SN6PR11MB3054.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Z0c4I+EJTRbxBtEyEDDZgMTsSeqxO51f1E4/xQ9JOUG05+dH57iMN74TicyhK/BNoKv8dC5lcWzjz55IHxOyFQJxnsfOgtZpNA2O8z/Nk5mw0NdtBXZTfM1Vi8AFWUCZU+sqsDTGHefo+e/WEXyscvLQUqKra2eVRHOBw8pqthVOj04KTEMPGJ78p7FHFfKfy6P+7GwoNkJZGXNdnr3SsQYPfBnsg14kRc0EzTNBj5WbPSblSpB48OTAjlTsNFdWtxihELrm1Xg3YxErQaA84Fkoc832WTuS9Os7aRLc7BQuYYY5F2OsjfbRQqUecuouoImtXQ8kGcSAwyrxhcjWzE0bqboXVX/ueEWupdajwbqKyd0WAybypxJ0VH1f+qGSVxsF6jf2mz7zx+jQmII9pYKhJ9U4u6uOPzlc7FWyZTfw6PlLEGNoz0Q5TpP43tetLDYOQsW6pEkfXAVByvClrqfgAu+dougBP7IAVYY+DcQc+gzY3anWz6I0wKNKSRX7Z14AQKlKR5JWHeOpu8ClJIcw4KDY75J3ioxT2tr18nT1+OnATHv2mG4bYAHEV/5FqZawP+iETefNH0sKbfgO+7YQTZ7G0ZZcOt023foFDoC+oIL1ThPddkxyG2849D2JyKIjmSCPS8Q5Fxat1uPtagWHjIwMlmi/WvfjOzOXOFl+g+SNxC+ZvOHCi6snFAxN4PVsocghk/AwLi5Sbk7f6GPM0MJX0jlavAvGwD8jWxwnBaC8FfX32PSCEACoGnw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(76116006)(38070700005)(2616005)(71200400001)(122000001)(316002)(86362001)(6636002)(6506007)(110136005)(83380400001)(36756003)(38100700002)(508600001)(64756008)(66556008)(6486002)(26005)(8676002)(5660300002)(66476007)(2906002)(8936002)(6512007)(66446008)(66946007)(186003)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmhHRkd4M0IyeEdDWWt1RjYzUFlQb3hUbHZNaFVqemJFS3cwWWVGZjl6NGlU?=
 =?utf-8?B?WnBaWGhTbk9HK0F2ck9seFgvODRvNzBjbGREampnLzlaYXdkQVZDMWlTRG82?=
 =?utf-8?B?bTlLRUR6YUZLQm5xZ2JBWFlieUpVdmoxdmlOMDhwSUxvbVNOdDN6TnJGNWhK?=
 =?utf-8?B?ckNCTW9ucDBkTjY0SkdGZHNwbEo1dU9UUUNNdTZldHQ3cWNVaXptUmFTSEQw?=
 =?utf-8?B?OWl5UFBJT3lUMmljS1RMMEFpQnA2OGlTZiszMCtDTlNlYzdJeG81Rk9wZ0kr?=
 =?utf-8?B?OUZsRDU0NW10SEhQb3l4ZnlLQWZ2N0piQ3BYR1BpeDFVaS9vWlZjSEltb0o1?=
 =?utf-8?B?c3UwZVBNNFlyczZGSjhPTStScXZzRUtHK1IvQS9sRVhQQjlIeDJ0NnQ5amR1?=
 =?utf-8?B?TUU3MlhuVllzRHE5MTBsRVBVckdRVkc3anYwczV5d1Y4YTF4UisyS3psRzVj?=
 =?utf-8?B?ZXkyRGhuOXJnNCt2NWFRL2t5bXNzTXNMcEYvNkpXdGRWT3AwYW1UWTErM3h1?=
 =?utf-8?B?L2RWek93M21XM1FYRnU4NzA0bU5jTXRLMVVlYXRIYUFMUW13NTlqTWxoSEFH?=
 =?utf-8?B?a2VOcUI4UGtlaDNkeTZuNURMeFRuVlVvRk40Y1RoMnZLTkJ5V3FvWUFOQUsv?=
 =?utf-8?B?UW9IT2NJZjNCZjZoc1dFNmx2RGJDN0g0MUJ2VnRmbzZObTcrZmNJckl3VEth?=
 =?utf-8?B?Y2tCWFVCT3JEei9ZVk8vNndTTHo4eG5DYVFaL0d3TXQxZ1NrOWhyTzZiVWpa?=
 =?utf-8?B?S0tMak41TjJkRE01Mm9DTG5CamliNVB5bHZKUW1zWm1ubzdBNFdQSEhFMlND?=
 =?utf-8?B?aGhDbUdONXptUkQ1RzhGY290Z25kKzduZ2pHdVFPZzl6VWorNVVrTnFTcjRL?=
 =?utf-8?B?eGttekNNZ1dSRmtBaDBsQ3J2Q1lUNjlvZWdvRmdtb2hESjdmeTMwZU5Na0N1?=
 =?utf-8?B?R25UYnBIeEJKWStnQ0dLc0dWWng5NGNWYlRvVFcrRjNrcWwrQ0dXcHNTVlps?=
 =?utf-8?B?TE9OVUNrTXFEaXM0b3JMY3VkWDM4VFk5V0VQdDFlNnIvKzQycWxQczhKVlZp?=
 =?utf-8?B?Q0hGUjc4RWgvdTl0NEE2djZtMlpZcStQT1czaGxHSTE2VHF3TDlNL1h0RHFS?=
 =?utf-8?B?ZmJQK3lVbEw0b24xZStldTl6MndlQ0tTTzc3anZUemFYdENpZ1BuaUxUc0VV?=
 =?utf-8?B?S3JsU29pQVRHQzNIdTlWY05GTFBKMnRleFlCNmJhQVhhRkZwSElzQTFaNVIv?=
 =?utf-8?B?Wnd4UFV1VDZvaHl2MEtSQmJ0VkJnNE9ERFhmQXhPbkJjOXREQjNyb0VEQUxQ?=
 =?utf-8?B?NFlJWmZiYS8yOW9HdTZuWUpUcytvY21wSFJOK3NwQTJHdUcxUmpaWVprRjli?=
 =?utf-8?B?TThMQTJBUzJuU3RWVFVxeDRrRjNodWx4ZERieHlRQTFvMlUzb0sxTTRXUmta?=
 =?utf-8?B?M0h5bXFRaW5USktxSVo3Ly9DbFBPei8wMWdoRDhFNWVZdVMvNUpkbThrbmox?=
 =?utf-8?B?SlBwdEZyNkxZeGF5ckJKRVZSNnR2VmN5OHh5Qis3aDA2ZUlZNFpTV3hrU3dZ?=
 =?utf-8?B?RVE3ZkMrYkoyMDN5T2FsNUluVlUyZlp0Z040cFJ6ay9vRk5PVi83b25TQVhm?=
 =?utf-8?B?OUdTbzFTdUFYK2lZUTdJb2NLcmJ0V0Erb0pGTjFiYUFyN0FKOFZib3pUR2Zt?=
 =?utf-8?B?eEFqSjkyblkvdkpTZXVHYjVQUVRyWWFyeWViSE1PcStKaktWUHhCZUdGNU0w?=
 =?utf-8?Q?OIYXcKINsjoiSWxnrzEUNATW6k4pj+HQZZpK1gm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1729AF673D850842BDEFCE89AE50F39C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5c23e8-c635-4627-d529-08d981f53654
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 20:27:22.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45XxLzQFLHXYRi4gPCJc9RoaSQgseDAMIDEa+7VBObjRJEpv7zmICnI/AWcFMr/O0PKP4CLRSg4+hMVrhpBneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3054
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

V2l0aCB2ZXJ5IG1pbm9yIHR3ZWVrcyAodG8gYXZvaWQgaW50cm9kdWNpbmcsIHRoZW4gcmVtb3Zp
bmcgb2Jzb2xldGUgbmFtaW5nKSBQYXRjaHNldCBoYXMgYmVlbiBhcHBsaWVkLg0KDQpPbiBXZWQs
IDIwMjEtMDktMjIgYXQgMjA6MjUgLTA3MDAsIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggc2V0IChJIGFwb2xvZ2l6ZSBmb3IgaXRzIHNpemUsIGJ1dCB0aGlzIGNhbm5vdCBiZSBo
ZWxwZWQpDQo+IGltcGxlbWVudHMgc3VwcG9ydCBmb3IgdGhlIG5ld2x5IHB1Ymxpc2hlZCBNZXNo
IENvbmZpZ3VyYXRpb24gRGF0YWJhc2UNCj4gUHJvZmlsZS4NCj4gDQo+IFRoZSBjaGFuZ2VzIGFy
ZSBtb3N0bHkgY29udGFpbmVkIHRvIHRvb2xzL21lc2gtY2ZnY2xpZW50LmMgYW5kIHRvb2xzL21l
c2gNCj4gc3ViZGlyZWN0b3J5LiBUaGUgb25seSBleGNlcHRpb24gaXMgdGhlIGludHJvZHVjdGlv
biBvZiBhIG5ldyBELUJ1cyBtZXNoDQo+IEFQSSBtZXRob2QgRXhwb3J0S2V5cygpIG9uIG9yZy5i
bHVlei5tZXNoLk1hbmFnZW1lbnQxIGludGVyZmFjZS4NCj4gDQo+IFRoZSBuZXcgZnVuY3Rpb25h
bGl0eSBhbGxvd3MgdG8gZXhwb3J0IGEgc25hcHNob3Qgb2YgbWVzaCBzdGF0ZQ0KPiBmcm9tIHRo
ZSBwb2ludCBvZiB2aWV3IG9mIG1lc2ggcHJvdmlzaW9uZXIvY29uZmlndXJhdGlvbiBtYW5hZ2Vy
IGluDQo+IGEgc3RhbmRhcmQgZm9ybWF0IHRoYXQgY2FuIGJlIHVzZWQgZm9yIHRvIHRyYW5zZmVy
cmluZyB0aGUgIm93bmVyc2hpcCINCj4gb2YgdGhlIG1lc2ggY29uZmlndXJhdGlvbiB0byBhbm90
aGVyIHByb3Zpc2lvbmVyL2NvbmZpZ3VyYXRpb24gbWFuYWdlci4NCj4gDQo+IFRoZSBjaGFuZ2Vz
IGJyZWFrIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGggZm9yIHRoZSBwcmV2aW91cw0KPiB2
ZXJzaW9ucyBvZiBjb25maWctZGIuanNvbiB0aGF0IHdlcmUgZ2VuZXJhdGVkIHdoZW4gdXNpbmcN
Cj4gbWVzaC1jZmdjbGllbnQgdG9vbC4gVGhpcyBjYW4gYmUgYW1lbmRlZCBieSBtYW51YWxseSBj
b3JyZWN0aW5nIHRoZQ0KPiBmaWVsZCBuYW1lcyBhbmQgcHJvcGVydHkgdmFsdWVzLg0KPiANCj4g
SW5nYSBTdG90bGFuZCAoMjApOg0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogU2F2ZSBwcm92
aXNpb25lciBpbmZvDQo+IMKgIHRvb2xzL21lc2gtY2ZnY2xpZW50OiBBZGQgdGltZXN0YW1wIHRv
IGNvbmZpZyBkYXRhYmFzZQ0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogVXBkYXRlIHN0b3Jl
ZCBOZXRLZXkgYW5kIEFwcEtleQ0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogS2VlcCB0cmFj
ayBvZiB1cGRhdGVkIGtleXMNCj4gwqAgdG9vbHMvbWVzaDogQWRkIG5ldyBpbmZvIHRvIHN0b3Jl
ZCByZW1vdGUgbm9kZXMNCj4gwqAgdG9vbHMvbWVzaC1jZmdjbGllbnQ6IE92ZXJ3cml0ZSBjb25m
aWcgdmFsdWVzIHdoZW4gYWRkaW5nIG5ldyBvbmVzDQo+IMKgIHRvb2xzL21lc2gtY2ZnY2xpZW50
OiBTdG9yZSByZW1vdGUgbm9kZSdzIG1vZGVsIGJpbmRpbmdzDQo+IMKgIHRvb2xzL21lc2gtY2Zn
Y2xpZW50OiBTdG9yZSByZW1vdGUgbm9kZSdzIG1vZGVsIHN1YnMNCj4gwqAgdG9vbHMvbWVzaC1j
ZmdjbGllbnQ6IERpc2FsbG93IG1vZGVsIGNvbW1hbmRzIHcvbyBjb21wb3NpdGlvbg0KPiDCoCB0
b29scy9tZXNoLWNmZ2NsaWVudDogU3RvcmUgcmVtb3RlJ3MgbW9kZWwgcHVibGljYXRpb24gaW5m
bw0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogQ2hlY2sgdGhlIHJlc3VsdCBvZiBjb25maWcg
c2F2ZQ0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogUmVuYW1lIG1lc2gtZGIgQVBJcyBmb3Ig
Y29uc2lzdGVuY3kNCj4gwqAgdG9vbHMvbWVzaC1jZmdjbGllbnQ6IFNhdmUgcmVtb3RlIG5vZGUg
ZmVhdHVyZSBzZXR0aW5nDQo+IMKgIHRvb2xzL21lc2gtY2ZnY2xpZW50OiBTdG9yZSByZW1vdGUn
cyBoZWFydGJlYXQgc3ViL3B1Yg0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIGdyb3Vw
IHBhcmVudCBhZGRyZXNzIGZvciBEQiBjb21wbGlhbmNlDQo+IMKgIGRvYy9tZXNoLWFwaTogQWRk
IEV4cG9ydEtleXMgY2FsbA0KPiDCoCBtZXNoOiBJbXBsZW1lbnQgRXhwb3J0S2V5cygpIG1ldGhv
ZA0KPiDCoCB0b29scy9tZXNoLWNmZ2NsaWVudDogU3RvcmUgVVVJRHMgaW4gc3RhbmRhcmQgZm9y
bWF0DQo+IMKgIHRvb2xzL21lc2gtY2ZnY2xpZW50OiBFeGNsdWRlZCBhZGRyZXNzZXMgcHJvcGVy
dHkNCj4gwqAgdG9vbHMvbWVzaC1jZmdjbGllbnQ6IEV4cG9ydCBjb25maWd1cmF0aW9uIGRhdGFi
YXNlDQo+IA0KPiDCoGRvYy9tZXNoLWFwaS50eHTCoMKgwqDCoMKgwqAgfMKgwqAgNTYgKysNCj4g
wqBtZXNoL2tleXJpbmcuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDI4NiArKysrKysrKy0NCj4gwqBt
ZXNoL2tleXJpbmcuaMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAyICsNCj4gwqBtZXNoL21hbmFn
ZXIuY8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMzUgKysNCj4gwqB0b29scy9tZXNoLWNmZ2NsaWVu
dC5jIHzCoCAyMTIgKysrKysrLQ0KPiDCoHRvb2xzL21lc2gvY2ZnY2xpLmPCoMKgwqAgfMKgIDI4
NCArKysrKystLS0NCj4gwqB0b29scy9tZXNoL2tleXMuY8KgwqDCoMKgwqAgfMKgwqDCoCA0ICst
DQo+IMKgdG9vbHMvbWVzaC9tZXNoLWRiLmPCoMKgIHwgMTI2MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+IMKgdG9vbHMvbWVzaC9tZXNoLWRiLmjCoMKgIHzCoMKg
IDY2ICsrLQ0KPiDCoHRvb2xzL21lc2gvbW9kZWwuaMKgwqDCoMKgIHzCoMKgIDEzICstDQo+IMKg
dG9vbHMvbWVzaC9yZW1vdGUuY8KgwqDCoCB8wqAgMjA1ICsrKysrLS0NCj4gwqB0b29scy9tZXNo
L3JlbW90ZS5owqDCoMKgIHzCoMKgIDExICstDQo+IMKgMTIgZmlsZXMgY2hhbmdlZCwgMjIwNiBp
bnNlcnRpb25zKCspLCAyMjggZGVsZXRpb25zKC0pDQo+IA0KDQo=
