Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 20:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiJFU7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiJFU7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 16:59:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4092C148B
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665089951; x=1696625951;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UbYi6yYGIeFBMNVjB+UPzNrm0ugCFnQNHO/MwUJQvuo=;
  b=bkAoTJ8YLxMSLSgsNBmpcpw6G0sZfnDuiG1hFMC39cx1a3IE6EvUfWVs
   AxZ/iA49BbZgyv+F4OHshScISO0AL4aZexRf1QNV57llBjh/ByFL4XJ/7
   eJPwiHTGMFmzqYbWHhfeSu/x+bIMBHefD9heKuVUWtoCkv3wCOoR6IWKG
   2/xNWmiq8viUNSwA51G5DiI1DLAkHCtuoSfvxBxBFzvljitsyx4+nBSAc
   eDA13W/yp0dkXnJGghS/jkLlU4T/WZYoaYRh/g9J7Y7ugOa3aykCl1Bvs
   YySAkzLZJYcxcXPVAdRPGpv4aDKTZhTdXsXVmIuuS1+IATXTtNlpG/CcD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="389860040"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="389860040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 13:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="687595531"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687595531"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 13:59:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:59:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 13:59:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 13:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOK7c58u0PblhAy74P2azFltbMH/lmDbIgHWnmvHKjQ8PjtSfgCmCtdeJWAdBJuRIwlS0ZTMVAXDRktRo5vg3TmWxzkHr5wfrWO6JHQ19wJgWBZFYWwEF+HgeM8a4Zp+y4T/O5Xx9BnO0ehUDVJ2UCQg9+z80sKpyW8Kfp9ouiLuANIJ6f0j04DHuSFlVp57Ihc9Ks3ijVnpu2Tk/O0/gJP9fsJsRC50SdJany/6111gDP+ZrUAbQqVH3ZRj4pBet8gUhcc4kfa+LUBQCW1qWvgWeCMhAEvDbP0qXZKnKXeuIJKjKf0/uuJIcZCXzwR0KpKm0c+vkHGFQEDdeY+Olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbYi6yYGIeFBMNVjB+UPzNrm0ugCFnQNHO/MwUJQvuo=;
 b=ny0csZUaQwcN/CkKaPuv4iJ4+3AaNgdY9mReLG6FiYQ6NL7DQ8OUIwz2x6qiH+1iXEScVwkogtbsvdGFXVa7u5/XSU7+PTMCW+76EXu8qQ0W0WjkiV1YUJAf5hNvzrZpaglD1AfG1fb67axlTgk3kv+QZ2O1ilEaWSoOvBYoQ/zSJG54pROEDpTaF4/jjr5uv6zjBb0WtEGzw1WUF9vqL8kcRZo9S78P2HLSGVTBl+A6kI51HYrgVPYL15p2TWqtsFB10HdTvbBPVGDrm33Ic/l1LTySoq7Pzfeqw+UG0pGN6B4g35cBFYJhzEpL3rU+9Dt61X4z+4HLYqXYbPRKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 20:59:09 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 20:59:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@loytec.com" <isak.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/4] Mesh: Fixes for friendship procedures
Thread-Topic: [PATCH BlueZ 0/4] Mesh: Fixes for friendship procedures
Thread-Index: AQHY18rxIzd3rpyb/keiVltfPn5Skq4B3V0A
Date:   Thu, 6 Oct 2022 20:59:08 +0000
Message-ID: <c25f6563094a69baa300f50d4264460f8f35f641.camel@intel.com>
References: <20221004082530.25719-1-isak.westin@loytec.com>
In-Reply-To: <20221004082530.25719-1-isak.westin@loytec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|PH0PR11MB5596:EE_
x-ms-office365-filtering-correlation-id: f4583e15-8da2-4702-1559-08daa7dd9cf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcMKQ6SxowjMQTE7rg7RPe50EUC//LSHnyrprxzmunR0CY6jg/nLprkqtewQ0qhsqBQtZJB8KTLyM3dvTf2RGT8Dq84GW1iGNJwMsxpIGH1y+oH5kZyQW4DF5Yd9yi1vef65/eCkuqWw4GRAYp/+/Rb+w/tJYvhK87M+2Ne4e82tHfXdDRfK2pc1afcdLvJU5bNZbpwwgP0WPnJ7wPlByPI7RjCxyN4p2Y5Fd0TA1uvJzszSaYHvcksOoHnyfWKld9vV7/36HHjdxJKCCSQhyvTQwYQoKhRBAqKngLB1sF+5PzRtlAvGnlpLF8iAL7mBVYPSR7fEGafaHSCbyoNS68Cl616kHjEKmMwoGBCFJioDXf3vJ++qHlWp5gPfyQANXa1XdS0GJLQ2q4OrH2EXsvS/r6MVkmI07XBJi7uPYhfSBN3tZgIRlBjka+I+xppEJ6iE8cQvvbs9SG18Zrb3ZREKgdQmFNeRdI+RAoYStLx5VTK0AdXjuKviF1vQxhN6f5n7jRxQfU+0/OAs6koroYZgHhHhXzwpdKta7dLggWdwveg4vx5Rm5GJKlS35uI+mCHwE1G3ad26tUXXlelD0RytgwIwYA+SZ3DB9Icnj2FzFkVOKt+NGpoZFs0iS2fyjz4j7hm5HyIj5eOPKg0C0ikOVS+Td1vXffQne8xQoXQ3RWgQ6nmHLuDEq4CzdvHCmbXgfq1T++6R4JZun3xq97QBc68rc/lJPuHhoD8heK5QQnIGXhWfovfgijczd+6QABlcj0b/hLIWlnCyBlF9oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(6512007)(110136005)(122000001)(36756003)(86362001)(66556008)(91956017)(316002)(76116006)(38070700005)(66476007)(5660300002)(4744005)(66446008)(8676002)(66946007)(41300700001)(186003)(8936002)(2616005)(64756008)(83380400001)(6486002)(71200400001)(478600001)(26005)(38100700002)(82960400001)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZlMWdlWTVrN1RIdGxPZks5THV2MWY3UWFDT051ZmZ6Y0IvaGtyVWdlaHk2?=
 =?utf-8?B?VERGbDAvSDVUaE5HcE9RRDNDOFBWUkhzY2FreTd6dTR1YXh1MUVaMmZpQmlR?=
 =?utf-8?B?RlZtNjV2VUlsUVdSMnVFVHZVd3Rid05rTEplejg2S21pNmNJcHlodlZzSDBY?=
 =?utf-8?B?SDRHUUVycmNYbklobS96enA0QjdHNlhRcitvRXJubXJheUlvNks1d1JyQ1NN?=
 =?utf-8?B?ZWNxTUNOM2VkNXoyQnlrNG92YXFDZTVxbjZBZnNzb3pEVk83dEJMdTVweG5m?=
 =?utf-8?B?UFJmaHZQeit4R21adXdRVmZKVGxGOThTdXB2OWJTMjhNa0VhM3NReHJBUjF2?=
 =?utf-8?B?ODducDZzZytiMEI2ZGNFYStNd3RPVWQ2QTJpL0Vtd0RlM0FYNEk3V2ZxQzZK?=
 =?utf-8?B?WmNqaXF5d0RHd1dCUTdjVEZYREpVSzV3Ui91YmNqUGZTVDdEUHhtaGJrUnlU?=
 =?utf-8?B?N0FvbTdFMm1YUkFpcVNOYmtrSGxEZ1Btb3JRNEZ1UnFBRnFzMjh0VnkrZTF6?=
 =?utf-8?B?c0syOUZVQy9ibEdPcHVXY1VGbFloV0JPVEt4NmJxNUg3M0p6TmdKczRIcE9Z?=
 =?utf-8?B?V05BdlJQbGI0S2dUbzRFZ3YwcnBqR0JmWTYzNmYwaHF6WVp2STFkd29la21K?=
 =?utf-8?B?WDd4NVl4b1FLQm5oZE5KNFl1Z2F3VzVXbklPbkt1alZxWFRILzdrZU8vYzJ3?=
 =?utf-8?B?R21IV1ZLak43VDZZelZKNXlXMWlIMW93NVFoeW5HcXE2UnVSOTdlUGV2aXZC?=
 =?utf-8?B?SDlqZEhoRjF2L0FqdG9lbHFLdDZQSW1jb2o2dm5EMndIU0lYL3Y4Z2NPMWlv?=
 =?utf-8?B?eUpTSUx2SFBYejdNWTYxdmdSeEFkRHYvdWpRNi9nNFF5bXhUN1BLUkMvRk9s?=
 =?utf-8?B?NDN3ZzlEb2JwTy8xY0svQWNxU2QrSWJQWXI1Z1pKWUhYQWN1MVFhdDJLbEM1?=
 =?utf-8?B?WUErbjhQVldaRmRkZUMwcXdGZ3RqWXExT0pGL2NCSXlCQ0hKZEZ5eDJHSU9O?=
 =?utf-8?B?SFNEWk5PWUVqU2pzcDQvVUJwUGlTY0craU43SDNHZFAxSjJQUG5IcDN4VFZI?=
 =?utf-8?B?dzdESit5cTJTaFdwcVB5aENZYStHd3NCSkVicVNkMW1nblFZNVdvU1AxVVRk?=
 =?utf-8?B?cWthZE5SMWVxUkNFWkc2Mi9CNVhNUzJaM3hzWEdxY0wwdEFKZ1Y4ck1BQnpp?=
 =?utf-8?B?Sy8rY096ZUg5Z2dtMml6bmNFUHQ1WGQwSklFdDhoemtiZmVMYytUdFRSOWxJ?=
 =?utf-8?B?aUFkMmhHOGlEWjF2VncrMkhCRnpWSHVKMFRxMWx4VFp6QnJweldnZ0VldnB4?=
 =?utf-8?B?VHoxeDEyc3JRMGtGZ3Vhd0YxSzluSHVNUC9BOFNvV3pNd2M1ckowNTBKK01x?=
 =?utf-8?B?ZlZNekdvZ3Z6ZHdyaEJLMjhiMDRMOUVxeEZjekUrWmVJaXJyU2JLSjN6MWxZ?=
 =?utf-8?B?endYUk8yUE52OUFsRWljMFI2U1ZyREk4bnlwdDNoVWo4Rjl0Z1IzQ0t5bHJE?=
 =?utf-8?B?d1dHWWZvaDRGaHJzMGJubFJMd3hqTXF4cDdVN0pENjZmOVlsUTdjUnZLK3J0?=
 =?utf-8?B?N2pXLy9qV3JkNEVHTWh4L256Z0lPSnJLY1VyMlFKUFQxb0kzVXNoeWd4ekpx?=
 =?utf-8?B?UDVaNUxoNHExQklZTFFJSnhYcndZdzNZditSODJGdnVJdEltSG1PdVduWVdW?=
 =?utf-8?B?RWRJS2Z5d1F4SVhjKyswb3JzWFN4NUR2cmVPaEhRU1FNYlBFRmFkVWRCRlZL?=
 =?utf-8?B?U2NPMGk2ZjU2WWVHVGhLc0FmLzVBbTY3UGNHa3IwU00yaUR3S3NGZUEyQzBy?=
 =?utf-8?B?RGdTZnlWMFhmWWJOYS8zMzMyY29EWjNrSHNMb1dYQjErRmlhcEUxWlR0emZ1?=
 =?utf-8?B?UXB1WTdobVVnU1lRMzQ3MjVpWGNsVlpXb0dOYVZVYkVIb3dIL1l3TStic2Y2?=
 =?utf-8?B?LzRtVyszK0hGaGdIb1FYMzRCYmIzdHp6SjdYSjlSbU5DTUlvNTl4WTBwSXpP?=
 =?utf-8?B?MTBnTWJBb01KeWdJQTM1MDhxbk1kbGRkRUtkc1BYaTYxL2Q2U3V4eUxhMllC?=
 =?utf-8?B?K1h4WkV6azhNNGdDdHVDZTdsUmtGUXBMRUowcExkTUptR2hoSVMxeG51Qmpx?=
 =?utf-8?Q?hYDMCOl0zUJ+prKuXTnvy0dL/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44AE3DF361D4E24097D40E94E4EBCE87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4583e15-8da2-4702-1559-08daa7dd9cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 20:59:08.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9vBQE8Ic4BHoJm6vYDDcaZSvNLDKSXrsUoVY9pMTi2YfzQdXnCGlNHJu7HP/gc7VblkNyM01PzjFpGHi6+wvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5596
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZC4uLiBUaGFua3MhDQpPbiBUdWUsIDIwMjItMTAtMDQgYXQgMTA6MjUg
KzAyMDAsIElzYWsgV2VzdGluIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IEhlcmUgYXJlIGEgZmV3
IHBhdGNoZXMgdGFyZ2V0aW5nIHRoZSBtZXNoIGZyaWVuZHNoaXAgYmVoYXZpb3VyLiBGb3VuZA0K
PiBkdXJpbmcgUFRTIHRlc3Rpbmcgb2Y6DQo+IMKgIC0gTUVTSC9OT0RFL0ZSTkQvRk4vKg0KPiAN
Cj4gSGFwcHkgZm9yIGFueSBmZWVkYmFjay4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gSXNhaw0K
PiANCj4gSXNhayBXZXN0aW4gKDQpOg0KPiDCoCBtZXNoOiBDb3JyZWN0IHNpemUgb2YgZnJpZW5k
IGNhY2hlDQo+IMKgIG1lc2g6IFZlcmlmeSBwYWRkaW5nIGJpdHMgaW4gRnJpZW5kIFBvbGwgbWVz
c2FnZXMNCj4gwqAgbWVzaDogUXVldWUgYSBmcmllbmQgdXBkYXRlIG9uIElWIFVwZGF0ZSBjaGFu
Z2UNCj4gwqAgbWVzaDogQWx3YXlzIHJlbGF5IG1lc3NhZ2VzIGZyb20gTG93IFBvd2VyIG5vZGVz
DQo+IA0KPiDCoG1lc2gvZnJpZW5kLmMgfMKgIDIgKy0NCj4gwqBtZXNoL25ldC5jwqDCoMKgIHwg
NTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAt
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkN
Cj4gDQoNCg==
