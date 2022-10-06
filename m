Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55945C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 20:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiJFUtL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiJFUsm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 16:48:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C76CAE40
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665089267; x=1696625267;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nhPKw9Ww8tkRu2se32H+kMHybWpaY/SZa701mMr0rj0=;
  b=EBeEA7IJP9YeveBXD7YBrFZWpKrCVQ+LyITfuMNqoeSBOiwBFqqfmPo2
   qHRJy7wxYxU20FaJZGLOBd/r2Q/fBEmre+CslQSKgq+BhveBrEWLbHAA3
   ckf6nxU+iPWwpIKoBiIS0w0hmBcf+Wx4s9ijFQAo7aSTKOFpvLgQnn+ie
   oGs8WBCnDeBGrnDxIJhEULg71lzrbIIRDD7xf7qoWeWN63s5NjhYyyRbj
   n9k1kGiycLlNz+Ar5pxgOoamZS9lf1n1ifsIMxCel/Uo25+GikIY/DMb7
   UvhGon0iSpgbz8tLGOzpnwDUep80YWnx0w5qheshXddhSmvq1N7GQZbS7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="367692829"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="367692829"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 13:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="627162325"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="627162325"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2022 13:47:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:47:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 13:47:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 13:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDSMssrKpGri45xdOMq7lmhc9q5r5JIVfuXK6Rw+HnjJ2ZsMMzSe9gsx9gKcPWUNpZbp7WBidRIkCQ1yCn14JYXx9rwN+JrM6xJgH8ZGW3pKuJPM5mTMQeVK5VQ8GXccpynxMHDX1C2wcmOmv2PmHtIIm2OwN9N+CAZpADPmjd7VU6qcwY9RCZXXxy3mshQMPBg9IxoOVoL9aAd/G6ZgPK928CaDHRofMKWxdFrIr7V/IMQ6rolhuU8269qzftbT7wKbCVN+AmT2uZQGThPmOk7PRiOSAZN0uW/HZ+UJtOw5Yx+nbUIzal5DZQVkIclm3+ETIL45P2nkiJYR0wiwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhPKw9Ww8tkRu2se32H+kMHybWpaY/SZa701mMr0rj0=;
 b=P4Y+RBnylvUVDO5sloC2XXEbC7EM0KI552k0/jhJOhuZNtDzF6vJmr6vvkOZvMmdIhQmZQ67WAEh/m74xrfTxDcy9mSsuHV8+Co9pKpZ3MzNZ52EXqUlCRRES73nwH/Z1u4OjX1X6oJm9YIcVE+CS9E5RBLZA0alhhpM0Jwk05ZkZzscJE9E+uqxHLHYZVM70baaRdd6Z3b39rlk3jtOaNaBOHREmpC3kfxIp0xfvr2W16KVXCvYXRBUHtSmI+x0cSy8L/lD4HWu1NlZa/syOTh5TcabTJzy+VHg+Qv8+jsTbYhNo410aY8orHA6noz7SLehtwYnHcXrjHRp1hy9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.34; Thu, 6 Oct 2022 20:47:44 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 20:47:44 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@loytec.com" <isak.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Topic: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Index: AQHY2ZRs0icQv9CpDkexcqqSsS9WE64B1pqA
Date:   Thu, 6 Oct 2022 20:47:44 +0000
Message-ID: <1431ea67c9b2146ee632d47503f0f666687df47d.camel@intel.com>
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
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|DM4PR11MB6502:EE_
x-ms-office365-filtering-correlation-id: f9ed02d7-8d52-48a1-71dd-08daa7dc0511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHaVR0Mk56K8V6aYVSV9jhbPlj2x3e4L90NgDnNpTH8Ey0OqpSHwK22d6PCiohb5UmcRVJERZs+ws3MnIAd7ySUDF3q759tCA87z4moMStinrNFrXlcrfd7UK2v7FMHBrEB/71KP3x7rl0dZOpq0ngYgH454fvhkQsjg+PManCuaVFLh+cMHK1FMYRFQjAwvR03v4akw6yxdtAt69kXbre4VyNA4kegp9Cs1dRRCVXGsH+Rzy2wtzZTLvmi0xiaxOqjrmRD/GXXeS70PJ5InXUreq1rzxeLY53RqcPkv+00cLKK+wXsRM8EmLHy8pEH+9eL1QU5c9p68U5MdEUDbfuUvzGu1Rzb4V88QKZQKuETMUzcYQaD2RDlbadwdrSgt9aVuM0sMbot1ejv3JpKH5zAghQQt9ziGK59eNLhNAbvLAZ9Cxx+OUL8HUyF6Gz5KKAoaX6Im5uZZNPJi2B00V/M4MycHKlyF3+r6Fvh414Irz9rEMbBJyj0nCLboIhAyhPetCkCvXVnxP5kx0xuO/Pl+fJkFaiZ/iAcUN/uHCaKGTNtELtW4ybOzdYUPCe85OG0P3/a8g/F21iU768VNEgAglwsM7SPIrrenz0aCLVudWV9Wz2aYg7y4vEWAeJLmamPdAcfCyNPeqDOKwKHLq9DN5v0Q6IEhxBAKT9Hy11Yz6Zt2PSNl/SNpMOpJmwU7VKR71gzZLmOzqt00PW4tHCYeRuJ8ruFlE4wcAGNwEfJBQOb3Zno01jap4xOF68FrE9ZAfQ4h8v7bnmGGWH3Kwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(2616005)(186003)(82960400001)(38070700005)(122000001)(38100700002)(2906002)(41300700001)(5660300002)(83380400001)(8936002)(110136005)(64756008)(6486002)(478600001)(26005)(6512007)(6506007)(71200400001)(316002)(66476007)(66446008)(76116006)(66556008)(8676002)(66946007)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFN4L284dDllVGQ3aTlRU1pySGFtZXZYMDZXSnlvMHlQY1Vob3QyM3JoTnFj?=
 =?utf-8?B?cE9UaFJpLzJ3clFLM3JlUkFmWGlFZDU1aEswQ2V6V1pwOGkvTkN5V2UvRWZD?=
 =?utf-8?B?dTI2YlRZUTBpY1NaRFZPdmxjVk95cTVTWWZTdGRucDBQRlZrSzluSjk5Ynlv?=
 =?utf-8?B?bVJ3UGZtMEhxdzBqamxIZ3djT2Nnc0NNQUlxWTdFb3Nvam83N1FWZjRDUEJv?=
 =?utf-8?B?MW5aKzNUUmJXSm1mNW9MVVg0dHE4eDFlNjRsNlU4aG9CM3VPdEtTU3luNTVV?=
 =?utf-8?B?NEZyc1F5UjRINjBHNkFWTWFYQVhxeFBVL3NkTEFqNG1ITC9RZjNkTG9qdnRi?=
 =?utf-8?B?Q084aGZ5cUd6R2ZPMUpyZzJucUsrRGkyVVpXUk9aQ1FrNUJ3L0xwSVBPVXdT?=
 =?utf-8?B?RXBoV0tQcHNJWk9rcGlYVmRQZE5rM1pCV0V3TkNLMlViZ3pTK3hUV0xUZnU4?=
 =?utf-8?B?ajk4WHd6cHUzeHBJMzZ0T2ZOVURXWEF4RVEwMkI0bTBlK3MwclRmWmR4Nnc1?=
 =?utf-8?B?dWNrSkhPRjlrZ0ZvVFVLMWRtNWtXYmw4dEhiTXJsN3dKUWlWS1VRMUFDbmtk?=
 =?utf-8?B?UnkvVTlNb1BPUFI4cUtnSG9lbXNMRTVTeXV0NFQrclJkY0ZqUTN4ckpqRk9k?=
 =?utf-8?B?dW41RTdaaWFOa3pUSThDckhPT2RnYmpZK2IydnZ1VkhENEY1SFpYNk1VVzJu?=
 =?utf-8?B?NCtaZjBIMFBNMWhqeStIVy9TajZ5T21WblByZHpHbEpxM2xiUHB4QzdXdERm?=
 =?utf-8?B?RXNnYy95MWlaZTg5SEoydmMyaDlNVlBiZEVlV2xvdHpSc0lFNUs3ZXZtZGpF?=
 =?utf-8?B?ZXYzYVdHTEduTmtDdDVMVWZ1MUx4RzFaM2RtZ05lUVU2cUNjWXlyZXRCTG9n?=
 =?utf-8?B?Z0NpODBpSE0xLzFHcDV6QlMwdS9zdUhOMEN5OVVBWWFqcVE1cy8reGJmY3lP?=
 =?utf-8?B?ZzhFRTNwUjZ6ckhnblk2TWVvaFdldFRaV0tSSUQ0eG9JUDR3d1hMOVNWeFkz?=
 =?utf-8?B?cXJMOFVyY3d4aEVIWUlmbXREMW5GcDU3N3JYUzNYcU83Zm9scFR4VnNDRzZo?=
 =?utf-8?B?ZGtPWm5BWHNuK0x6SFFrNU00Ym9ha0hhYWxKZldqWmd3L3c2QzVvcGdrbllP?=
 =?utf-8?B?ZkxnenFIRHBTTHh5cE1Rb3lIYWZ3bTlFbDh1cVFHZUgwYmN5NlBiR0RPL3ho?=
 =?utf-8?B?QWRhTUphTlYwVUN6dDNkVlNaUmNxVjcvM1hOSU5vaXBNTG5EYTV6Zi9IdlNG?=
 =?utf-8?B?dDQ0TVUxL2JLTWh5QTVtU0drVFZRMG9MUW90NDRlSXgvZTM1MzVmUTllaWtB?=
 =?utf-8?B?Z2dJdElaM1FOYzZ5MXU5emxEL2Zzd1lvdzhaRjR2N2p1dkxLVjJSZ2FFSlF2?=
 =?utf-8?B?VEhIQXhIalBtdGMrVFE3cVZ2dlZOVWh2a1Y0SXJqaHNvT3lHTmZaalNQTlE5?=
 =?utf-8?B?Q3ppWXVKTDhlNlVuUVAraFJ0V1VERGtpQlFCakJxTTRUV2xOZWNKWlhxa1g4?=
 =?utf-8?B?SkQzT0hKL2ZSSTYxUHlYNlZLaDY0RVhYdVloZ1BJbWo4YlNyb3ZmcVN0NzBy?=
 =?utf-8?B?NGRJMmRTOW8zajFLZlVneEYyejFNZWJLOUhtS2pTNFo4UmdyWVJ2eWI3dnZR?=
 =?utf-8?B?eEhOT3NpM0FSSy9MSjNFcTNWTUZRd1k4Q1NkVTN0T2Q3MHBBVmYrUWtYV3I2?=
 =?utf-8?B?d2hEVzJzZ1EwOTYvcHFsRTdRRDBDUHhaTzI1L05WUjM3eXc1YTRDS3k1WFVY?=
 =?utf-8?B?SGI5Mi81VWR5LzAreWRwVlFpbC9YVmpaKytUWGt1YjE5cjJHYU8wbXZsL1ZY?=
 =?utf-8?B?dXRYWGoxZDFzaEtDcG5UQnB6bGRxb0M5eUU1K1ZCK3RoSnhDWUp4UmcydkFS?=
 =?utf-8?B?bm9jVGdaY25vRTVnME9uRDUzSGxIbVBUZk92ajZGNHEyNGNTZGpZYURNbHIv?=
 =?utf-8?B?RjdZTTcydVFrZUJBMGtja3dENUpMV28zeTJlWHBIVHlBdTU0WldUK0dSNlRn?=
 =?utf-8?B?WUdEeWpGQktVMWt1eE4zc0p4V3FiQTdQM2Z6blVNcTRyRTVRSjE3TlJFd1M3?=
 =?utf-8?B?Um9TWXRBMDB4VmNWT2hDVFlZcEI0Ni9xZDFSTlJkdzJ2dVRJSCtBVzNXbm1W?=
 =?utf-8?Q?sdFDA2KnyyCF+4ve6R9j8Mark?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED2846B9EE7504A9491AB9123325619@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed02d7-8d52-48a1-71dd-08daa7dc0511
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 20:47:44.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00LMc/nzUebCry5o8VC7Sg0+gnzTOtCrT38hPaIIHKXWUSNJIzxe+FyRqj0wbEw0w6I40UIErW0B9NNcwaxx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywKCk9uIFRodSwgMjAyMi0xMC0wNiBhdCAxNjo1OSArMDIwMCwgSXNhayBXZXN0aW4g
d3JvdGU6Cj4gVGhlIG1lc3NhZ2UgY2FjaGUgc2hvdWxkIGJlIGEgc3RyaWN0IHJpbmcgYnVmZmVy
LCBzdXBwcmVzc2VkIG1lc3NhZ2UKPiBzaG91bGQgbm90IG1vdmUgdG8gdGhlIGZyb250IG9mIHRo
ZSBxdWV1ZS4KPiAtLS0KPiDCoG1lc2gvbmV0LmMgfCAzICstLQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9tZXNoL25l
dC5jIGIvbWVzaC9uZXQuYwo+IGluZGV4IGU5NWFlNTExNC4uOGJlNDVlNjFhIDEwMDY0NAo+IC0t
LSBhL21lc2gvbmV0LmMKPiArKysgYi9tZXNoL25ldC5jCj4gQEAgLTEwMjgsMTIgKzEwMjgsMTEg
QEAgc3RhdGljIGJvb2wgbXNnX2luX2NhY2hlKHN0cnVjdCBtZXNoX25ldAo+ICpuZXQsIHVpbnQx
Nl90IHNyYywgdWludDMyX3Qgc2VxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Lm1pYyA9IG1pYywKPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoG1z
ZyA9IGxfcXVldWVfcmVtb3ZlX2lmKG5ldC0+bXNnX2NhY2hlLCBtYXRjaF9jYWNoZSwgJnRzdCk7
Cj4gK8KgwqDCoMKgwqDCoMKgbXNnID0gbF9xdWV1ZV9maW5kKG5ldC0+bXNnX2NhY2hlLCBtYXRj
aF9jYWNoZSwgJnRzdCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1zZykgewo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbF9kZWJ1ZygiU3VwcmVzc2luZyBkdXBsaWNhdGUg
JTQuNHggKyAlNi42eCArICU4Ljh4IiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3JjLCBzZXEsCj4gbWljKTsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbF9xdWV1ZV9wdXNoX2hlYWQobmV0LT5tc2dfY2FjaGUsIG1zZyk7
CgpUaGUgcHVycG9zZSBvZiB0aGlzIGJpdCBvZiBjb2RlIHdhcyB0byBtYWludGFpbiBhIGNhY2hl
IG9mIHRoZSBYIG1vc3QKcmVjZW50bHkgcmVjZWl2ZWQgcGFja2V0cyBpbiB0aGUgb3JkZXIgbW9z
dCByZWNlbnRseSBzZWVuLCB3aGljaCB3YXMKd2h5IHRoZSByZS1vcmRlcmluZyB0b29rIHBsYWNl
LiBXYXMgdGhpcyBjYXVzaW5nIGluY29ycmVjdCBiZWhhdmlvciwgb3IKYXJlIHlvdSBkb2luZyB0
aGlzIGFzIGEgc3RyZWFtbGluZT8KCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gdHJ1ZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCgo=
