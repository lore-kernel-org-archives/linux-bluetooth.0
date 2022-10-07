Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 15:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJGPIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJGPIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 11:08:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84146102500
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665155323; x=1696691323;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=r30oSdHXVk0ohZootkpPJFUHZgfzvfIzz6iF37MJk8c=;
  b=i2EaNLvm/dKUf6tl9IvvgmA7FCBMrfdVCwxJxH5A7KhlooMV7xMP0IDv
   ORB3JfRC8jNs3UClgD2Cm88EtjdC6w9ayGdCvumnnqusKx67yLw/bLpJZ
   kYSce1cxvYlwE3H+Tj564XXJLv8LFDPAZb7qURutC3lI7XeIavSf+G4yU
   o7KD7/EwzzfSlxYiv8zSKW1m3FRE9zbm9hmlYtBKs/56OfHxCCLILYYlT
   RIejkMRA9oggTB7XK2445SJFvM3vWByVu3kHPqffIqCR/A0qKAyA/Onh/
   3SiRniKf5MZrgfAZ3AWY5AluHkQ/NoImNkDb/Mj+aTAnylhwzf5Nehxkq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="284125334"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="284125334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="658361181"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="658361181"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2022 08:08:42 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:08:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:08:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 08:08:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 08:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGpuaeUc0fItG39EtKjGYiSs9ko0tnAlCeTovwdmdaVI6zRmglw0Pd9eXTVKBlqhsl1REkXhJfD4qqqB2Swf0USrdWh3H+RIgg7dDTXLXqUxfmzzr4UXLImuacZ11QUs+HQlB0PuhM/+e7OqFtxOkWxalFXbIpXqAhfh+Bjs8psY9ymQIYzkWHOi1xcxByMPSLw4gTdw+w+NdACgBk+Vebz7lHkZmSc6XCyCVAK1kSCCsO6MKJJSRdpK+r89FjF5UVFkuVCEvidTjkZVzbxwQPSCChhN7wyoD8i05hwD/w3/EkSrxDZ/DQM3V2N6lyeQ7pwE3KgCS9xEvlH5n9+kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r30oSdHXVk0ohZootkpPJFUHZgfzvfIzz6iF37MJk8c=;
 b=HEYGQiDZi9fYqwG2nllNhky6OCqHMpKRPsTlWnk/aP5pxHBVNUZjNyXHg57oEZW/MjRdCSbkoR3Dkms1n0EMwmpQ4wY1KxgFMvJZzYMK8NeO948DMYe/buwWzd/3rFon+t0CTrjsxp+tnN1kCT1dNp3T9+qVHBvuzxewg6Ek+L08VTmOfs/wu82gLKurzaLOM6sQ3t4o0BCCiYVOrn7FGU0ZfywWINWHhAQBWpLKugru/iNBEkn/74P9xLr3kKF44LT/qCfu68TBMfOTksXFpdImQIMAqnPKiGyrX67DCquqY5RKdtoGV1lYXFuJQKIkhk2UCal248UzeIEW33owQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 15:08:40 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 15:08:40 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@loytec.com" <isak.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Topic: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Index: AQHY2ZRs0icQv9CpDkexcqqSsS9WE64DCjOA
Date:   Fri, 7 Oct 2022 15:08:40 +0000
Message-ID: <0fceb67e62627b97ac096f85850be6da890a3212.camel@intel.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
         <20221006145927.32731-7-isak.westin@loytec.com>
In-Reply-To: <20221006145927.32731-7-isak.westin@loytec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|MW3PR11MB4683:EE_
x-ms-office365-filtering-correlation-id: 9f0b1ebf-97de-4368-b128-08daa875d157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WRzYzIRpvCsIzkc7YkXX5667DSJdxSmc0j5+VY88VMN1ZhyeSu7ablkDYZoY7Kt9/sn9WwRdOgnzeOWNbh3CpTZupyU69Zu3LcDemtclC+JqDb1kLLptKpHMeXR4d/e7wJvFLXzKSLD5Zb0z5phbJmsR6wgv8ZovGxLaTLrI39smK/tkB4M04Dq47LwS/MArBCEcaXznbYK14xslIyvZ/XDF3FkW2kDnrqHgOnvsYMOqYY3igNd7fCsiiiHMxr+eazjwjUSOyxZNDFubpxn2bCfMOzfGIglo74Ftl5G6moVQtUJ2AyLRbPxK8/Cehc6XYQ9QcqW7UebvJlfNqoiCoaDzC2jD2pZ2Bp/gcvcS1uGXrTCsyf2kfxnWWAlGZavCCjkXCJ2OtO2A8tjbl9gD3tHusF7/O8dY1O5Z9gm1WmCqqbBH8N3lsF9USh0/dJgsU+tj1xisZU78fyF6WbU6wOM+w4mD3fS+uJZOKh1/sljo0ScuYQBMXLX7bBWQM7lU6rGVhQi8WOb6D1CJDVj4iZYGIuaUs3KjVtKK0ub+wbmq0DuvVEVLzEL7enUboXIxq7yNwT+y+ICYFlYdwVYZoVzlAXs/cj4L6P+av48VtK07QP/iw/CIkwSmfJ2laDCJWG74U39D7CjVNKVzbo5XGtng8RHJcIeso2VG/rXLJRPhr4F5KO4MMke3tgyHZGbLkH5x+2Wcjp5Dlmy44ZIQ1z6WCZryp6NNSH8jX/7iJQqvaotG5+/dFGW6hYfIkXAXgi+DGJwU2goEhlytV0sDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(316002)(478600001)(6486002)(82960400001)(6506007)(38100700002)(122000001)(26005)(36756003)(6512007)(5660300002)(186003)(83380400001)(2616005)(8936002)(41300700001)(4744005)(2906002)(91956017)(8676002)(76116006)(71200400001)(86362001)(110136005)(38070700005)(66476007)(66446008)(66946007)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzNVUzRiZnVURWR1N3BaZFlTZDZHNEd1ZThJL2g1YkltcDFwb3VlaE1nY1lJ?=
 =?utf-8?B?bDZwYWVtdzE4YVNFcGliOFczVG5DTGJXNHA1TDFuTC9QS25qR01MMU9GNm14?=
 =?utf-8?B?N2ZSeUExWnBaVkloc3VQd211SDJuU0J2R0R1WlNzUlg2cDB5UVZWSnNpVXBM?=
 =?utf-8?B?OUthcFl4WG1oTllFSFNoWUdGbEVmZ0pRR0l6RjhKZC92andQMUtZWmxCdllj?=
 =?utf-8?B?T2h3Z3IrS2pGOEJRYWwwK0tIZ3pSM3E0TlNCbHVzMkNqL3FGNjBibklLQU9i?=
 =?utf-8?B?RzdVZHREbGc2QWllTkhpWll0OGdwK2hDZGt6T1RZK25rOHBXTE16YitzeGhw?=
 =?utf-8?B?RmdYdG5GdWRlZlAwY0V1ZFB3K3hhQk90djYwSG9NeFdaS09sQkRNeEx2dGk5?=
 =?utf-8?B?RkZuazh1RXJRK0drWWh3ZDB1QzVBVmVNZGlGZmI0RXVWVVZrQXhMY2RZL012?=
 =?utf-8?B?MW43cTdtWmNPaHRCbHdObFp6bDFwOW5DMXgwellEa2JadEpjRlo0Z2pmSnFt?=
 =?utf-8?B?ZjkrUktHNlZlbDhleWU5eVpqMGdLYTR4S2I2NDRGYzJ2a1gxbnhqdkl4bFJt?=
 =?utf-8?B?UTJHWnNBRG83bWpqNXBHNlJ6QkZDVklOM21BakdBZWNZckl3TVl0TkdKQmJE?=
 =?utf-8?B?QTBMNjN2TWpxYU5ZUkFmY0t6SkJKS25ZYmhucXd5eGZCcTNVNjhhbFdTd2lW?=
 =?utf-8?B?UzhpMllmUDVpQy9xN1pTTTdZeExlWnN1UU1sWFpwOFJWVGhoam9RTWZqQlF2?=
 =?utf-8?B?NDBzS3JWc3QyZ2l3cHdobW5WWEN2T2RYd3FYVmg4Qkh1MmFocG53YlJmQ0c4?=
 =?utf-8?B?OHZjYmdCWG9zRFBpYXdJeElmREJMQXh1eFJqcjYvUWxBWE9TRSsvQVlSaS9h?=
 =?utf-8?B?UkJnOUVRdWVJa01Eb3crZ1UxK1JQbElEZDQrRjY3a2d0d2FkVGtPSFhOL0U4?=
 =?utf-8?B?c24ra3ZwMGRWdG1qWFB0cXVFY1BOWnA3OVp3THozRFJYR3JVSElrWHIzWXRC?=
 =?utf-8?B?VlU4NVF6V3VPeFpiVnBtckVKYS9rQm9nbW1WRzQ0cVZta1lMY0p6RUpiYXYz?=
 =?utf-8?B?STlXbktXY1pNUEVSbm1ZeVgxS2Z2VVRKK0FYNGZDNUhOWnZNQWN2Z2pLaS9r?=
 =?utf-8?B?NjcvcDNWa2pyRkR0S3QrQ2FEdEYzcG9rbWlWeFB6ZVBHNng3UWJiSDhML1BZ?=
 =?utf-8?B?Ym1yYXlHZXlwRFcyeUpTanVvdmNCL0lUWXJqc3NJcC80K2tMUHU5U3dWQnFs?=
 =?utf-8?B?MGpicmxtdzhBSjhBTUQvb1ZkN1JsbFp3VGFWRGJESVJ1L1AzT3JTcm1La1Yx?=
 =?utf-8?B?ZnlvZXFLTUJ4ZytyN1BrU3FBZndscDNUVitOcDV3MlBTRlVWeldMRXNxOE1G?=
 =?utf-8?B?N1R3MU1YZUNONlFIVGRaa1loNzBoenpMZU9odzMxSzk5QzRvRTZ4aFoxSUN5?=
 =?utf-8?B?TVJYREZPNm5wajRJYzRtNm9jVFdRcUNtdHg3dG5NVmJzTjA1cFBSdzN3Nm9N?=
 =?utf-8?B?SUZDdW9JbitBbkRiNHBCaU1ISnhXTjZMMEpLT2o2Z2YxcjlTT2ZGZWdKWmQ4?=
 =?utf-8?B?WE5XaEQ3RkZpSkZMc3IxM0RyNlVxb2VlSll2dDFZTWd4WWtPbDZMd3Q1WFZo?=
 =?utf-8?B?aDRCZWtsd1NpTDVtNWhXUEE0b0dHSmxydmFUUVZxNDVBMWZScEdkWE5DRVF4?=
 =?utf-8?B?V282bUVHUVVsOEpDWWJJNTBVNGdGNzYwS2VuMlh4NmVTSFRGRDYrOGRqVjIz?=
 =?utf-8?B?d1hhOG05VUJTOTQxVEdZUmw4NHB0OEZFUnJWemRhUkN3M0FhVDg4WmVzY1JO?=
 =?utf-8?B?Y0FVTnlycjgxMnVOWWkvbVg3MW9DL1A2eURRVzJSclZZTEloWHBGOFo0ai9q?=
 =?utf-8?B?RzhRNGViOWdOYktCN2pMZVAwbjE0djhlc0dOaUVmbytuTWdIM2c0YU1pTUt1?=
 =?utf-8?B?ZFU2b1o3Q0dtRXpLTlEvK1pNVStXRE91Z3ZCS28wcHYwV2ppUkxLS2cxUDV4?=
 =?utf-8?B?U1V6R0RQclNPbUNrMlVsa2NMQjlaT3B5bnJia3pQRTNxUGRTU21ydW01Mm4v?=
 =?utf-8?B?b1NETXNlU0pXT1VmcS95NXh1ZDB4V1FsYXhhSlpHTUVWV0R0UWhZOXNYY1dY?=
 =?utf-8?Q?YQfUEbRrFwKfRXZ2/Y+XSdc3q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <750557F916C8E94099175E3D13BBABE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b1ebf-97de-4368-b128-08daa875d157
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 15:08:40.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s94ftGetLTY/n9HWinx6p2jpsERRy6rPbh9qy02s07S92y+BQvdVfUvxnJ0GNA2Qa0W+6B0z9Ne8MXZGFcukNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

NnRoIHBhdGNoIG9mIDYgYXBwbGllZC4gU3RpbGwgY29uc2lkZXJpbmcgcGF0Y2ggNS4KCk9uIFRo
dSwgMjAyMi0xMC0wNiBhdCAxNjo1OSArMDIwMCwgSXNhayBXZXN0aW4gd3JvdGU6Cj4gVGhlIG1l
c3NhZ2UgY2FjaGUgc2hvdWxkIGJlIGEgc3RyaWN0IHJpbmcgYnVmZmVyLCBzdXBwcmVzc2VkIG1l
c3NhZ2UKPiBzaG91bGQgbm90IG1vdmUgdG8gdGhlIGZyb250IG9mIHRoZSBxdWV1ZS4KPiAtLS0K
PiDCoG1lc2gvbmV0LmMgfCAzICstLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9tZXNoL25ldC5jIGIvbWVzaC9uZXQu
Ywo+IGluZGV4IGU5NWFlNTExNC4uOGJlNDVlNjFhIDEwMDY0NAo+IC0tLSBhL21lc2gvbmV0LmMK
PiArKysgYi9tZXNoL25ldC5jCj4gQEAgLTEwMjgsMTIgKzEwMjgsMTEgQEAgc3RhdGljIGJvb2wg
bXNnX2luX2NhY2hlKHN0cnVjdCBtZXNoX25ldAo+ICpuZXQsIHVpbnQxNl90IHNyYywgdWludDMy
X3Qgc2VxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1pYyA9IG1pYywKPiDC
oMKgwqDCoMKgwqDCoMKgfTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoG1zZyA9IGxfcXVldWVfcmVt
b3ZlX2lmKG5ldC0+bXNnX2NhY2hlLCBtYXRjaF9jYWNoZSwgJnRzdCk7Cj4gK8KgwqDCoMKgwqDC
oMKgbXNnID0gbF9xdWV1ZV9maW5kKG5ldC0+bXNnX2NhY2hlLCBtYXRjaF9jYWNoZSwgJnRzdCk7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1zZykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbF9kZWJ1ZygiU3VwcmVzc2luZyBkdXBsaWNhdGUgJTQuNHggKyAlNi42eCAr
ICU4Ljh4IiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3JjLCBzZXEsCj4gbWljKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbF9xdWV1ZV9wdXNoX2hlYWQobmV0LT5tc2dfY2FjaGUsIG1zZyk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKg
Cgo=
