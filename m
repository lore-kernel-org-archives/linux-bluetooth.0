Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B297C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKAPjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKAPjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 11:39:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DEA15FF3
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667317179; x=1698853179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P+GY59lZ7VivS5ohJAgU79zgPQ6TGHjv7b4mBLcDn1g=;
  b=QHXtZoqzhsqNEX2JJeLPKsPIpnDprtmPECr++U15IBjeI3w6fywOgqZW
   V3Fm+fYnTPmEOGte7Nu/5j4P21x7eS9YK83n/FY/xM5hOz2eoNw+fQKv3
   pXItIUrQogq+4wRSdkzRQ2MN6nBNh3nBzkbB+wK1dtGtFv16EvKm1V7qC
   ITSzkha4knaTLHkWSw8AHl394Bp6tDf+3GL4A9+hEDxLEbjxmSKFnxUId
   WyLDtEeabRHz+/yY1QR9ssTr6mGtKyYrAy+bRK/3TDkqFQPgPzeRDiEyo
   ULh1ePKiHk4rv+xVKBeGkMIONdNHJq4ZeIKXCngJPoIUdMOjAVhSNJgSa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395476307"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395476307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="611881624"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="611881624"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 08:39:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 08:39:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 08:39:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 08:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtIpbWU3TPgHZcdW72KMi/FeNX/vpx/jh8rampZISl6f71tjeJ02glk+3yC0TVstFwQ74viX2hIgm3DHT/x+C6mWdQTZ94FLnpMn5yqUd+ohztBiidetQ6nQJld7UDalF6SIvS65ewUTv27SrIgkblxIrWAO7AOWXu0qsFCw1CQ2OIka7bIZe2yGPw51xTRPRhTL/o2B/cidUZ7330Z1SQtvFFDeOZ1rHRk2D7vFxpmrVVOTXYygCgnMpBOCG1wl9Yn7Faj+lCqQtJuZRzzT9WfMQgnk3BVq2K1wuMtMfkFu3TnHtTqvWtg3EvN8KDXhbniv1i+VYe57Zhc7osR4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+GY59lZ7VivS5ohJAgU79zgPQ6TGHjv7b4mBLcDn1g=;
 b=K3FYGyVgz9ED0zH/dwLwZGo+nr+P8Hx+XZnaijGDAIlv09XhV1uzawWnPZPScwat9zPZpsEzHU69Ao/HNVtLCi4oSuu2svxT8hQq1JhhV1zzK1rPpVa5z1qZyY4K/QeLM03Kkv17VnK0aXGouwGUG6/VRDk1/6Uz3B4D/MCe23HU0wb+QxK8THcib9rxVadDfSadnXCgr0yBS/4Up+3xORSO9QIKQwoP512qBRromFwKEyQs+GvXDzOc5Xb5j8YEcWqnu8MA/OvvZqzc97Giy3g+su8wn6WcIBowASpWgzLTEg+93co6ndrEVR6Y9JES4JXdgjY9D4h0kwhRlXBbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 15:39:31 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:39:31 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "Vasut, Marek" <marex@denx.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Topic: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Index: AQHY7XR1tGR1PoJWs0+u/R5GlIi3Va4pJVOAgAEQBwA=
Date:   Tue, 1 Nov 2022 15:39:31 +0000
Message-ID: <a6b973add812ec308978c90c763b3a62735ce2e0.camel@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
         <CABBYNZ+myLec0HOja45=U=QuvkQEyLjRAuacT+Qwbi36v7qOjA@mail.gmail.com>
In-Reply-To: <CABBYNZ+myLec0HOja45=U=QuvkQEyLjRAuacT+Qwbi36v7qOjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 8c1663f5-a727-40ea-5904-08dabc1f4511
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: af5Z5g87Baflxybita8npC2Qjzv4uW1hIUacY4BSycY6nn+5x/7F+NapQJzQnMMBFWentZtwR0ydTX3jTveCENOSMUzHV6wpxydItQ5kl4Olf6z/Y1KRvibhgABUcYwZ0EfqNf2GCHaVCbMUdjA0eiTmB5wcKOXTa8FWJ2WxZwL8nve1Y8Hp1bqcApxZjrGQ/i9p9jS/HTh/6EajH34gVJ8Dczds4naf0sJZlAfOvnVPFGM1WR/aNge1j2niYNytF0Xj1ulCtNISD65sTt+qDoMQbD2UPUm9D8VaMaBmuTRTa7isV/L4aVA2Gz21kRbd5zOYvsRxFD1dmR+sC/lQAKU1laskFPOxCwXG9wB7dPKIHXitNWwfPOjkjwzbbi8aZiKvg1O+ikci3KyffZ3w1GIMcNPBa+GmTgtqIydkCvz4ivSLVUWwnSGTk69U5EoLpPm83fFX6LB144BBG1y7vfiplUhcwYhS8Z7JDp+ECbx4QkltbNpSc1nRDbe5IPDF/XpvVo2v+YoGdn0kSEGrB4VQfvmfjpvGiLKtANZNoyIDOeTk187xsuJlPJiWEk6RP5/XD0HEWDWZmDUyToUZWq+oLLIC5AYIPoArkDpXNondrVnC4An4Pu0ShbSCe/2HvugiVDtxPgiQ/EMpfJ3Qnqj9DLNMcgw/5MkrEfd55DCbGLIiRvEJbcFmgbDKAcLH8VLoEgHmrW7FlmywT+54ddPj+UuMyVTSJhtbAKEqjjpuCFxsfJpuYtNVd33D6OwPaN5DRDm5omCN4lj1peJcFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(478600001)(54906003)(6916009)(71200400001)(6486002)(122000001)(316002)(82960400001)(4326008)(2616005)(66556008)(5660300002)(66446008)(2906002)(53546011)(66946007)(8676002)(66476007)(64756008)(6506007)(91956017)(76116006)(8936002)(38100700002)(6512007)(86362001)(38070700005)(83380400001)(41300700001)(4001150100001)(36756003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJNOHJTU1g5SDJCdjFBOWZKYmhlcDdmbDZobThORGo3REtmVHFvejVUZ0hk?=
 =?utf-8?B?V00wajZWNzV4MzJkNUsyWlBCbTBYQlpYZjVIMmJKQ3MyQytJRTlJNHpkbkdJ?=
 =?utf-8?B?NEhrNE84bGROSFVUeG5jM1o3Y0pBbEhqVThlN0ZlTi9pNFBmM3NHLzh4UDJ1?=
 =?utf-8?B?VlFkREZFSjdQT2xoOTlBclNyZ0NuQ3FiUkNrMzhrdVR1REFKRnUyeHlwWkg5?=
 =?utf-8?B?OUNXZjloelZRV1FXVEFDTnE3TUlBalpndWhocTF3MDZ0WEdWUzB4Y0ppWFlK?=
 =?utf-8?B?ZTRNd3dhK1E2eXFvbmt6TUIyeDMxWUlhMVpkdmxpWEwyT1c0alJLSHBsNjZ1?=
 =?utf-8?B?RjhtZ1Z3RjF6b0NheU9YWDREc1hxeVJOc3I5a1paaWVRZmNKM2VSWlV5WE1K?=
 =?utf-8?B?MnRqcG5oMmwrQUx0dCtVR2VtSmN1SFNEVlg4QkdSTzZWM3grenNPalhhcENq?=
 =?utf-8?B?NVIrV3drWjg4MU5vU25CTDVuUmlvQVYxaWdRYnpUMytMVlF2a25pVnBCSjI0?=
 =?utf-8?B?YUFYeFUzbDVNUDM5U3RvWUhVNWtVd2c4WHU4azloTHkxMXY1ZlVjMkx6V0p1?=
 =?utf-8?B?NHNhWWV2U2w5SU01TjBoRjFOdnJ1c1lMZ05nYkphWmtTM1NsNnQyUDZjUHNN?=
 =?utf-8?B?MnBwcFZWZmNlb0hHVk81UHJjdytsbTkrVzRkK29pQnJPbkRhQ1k0L0t5YWhn?=
 =?utf-8?B?RGhxT21ISTdLb2txdzdEMmF5TTE4eVBITEYyVUdKNVl6ZVkrVWxpRSthbXNK?=
 =?utf-8?B?QUp0Yzh1VExxZjdPdHczUTlVL2prZU94QUg3Q256YmRLM2tZYXFtanJUTnQy?=
 =?utf-8?B?Qm9WMjBEaFBYS0s4Q0sxQ0VFczBoSDhDKy9iZ3ZJQ2owWVgxc2IzSUZrSEpR?=
 =?utf-8?B?cmNRRUtMclh0T1ZiNks2UkFrQU1GSXE3UXVMZmgrd1ZXN2YvODF5dmx0N2Vv?=
 =?utf-8?B?cGZaRDdDN2pnMVp3eUIreEtmaWd0bDNMc0pWeWQwdHVrYVlhUm9TU01leU10?=
 =?utf-8?B?VU9hSHpJdE9rMzdSN2VNV29NNWhxOVl4TFFvSjgxT2I0WmVyN0RBMVUxaGg1?=
 =?utf-8?B?UHl6OCtTMFZPOC9TeGNTT3ZDcUFhZUIzWElvWkFFV3dYSTB0Z2pIeTl2MW1D?=
 =?utf-8?B?VWdQZG5TbWp2WDlEbHdzT281c2NTYW9PWlNGS1NWTDlYY1hENXptTTI4NWNo?=
 =?utf-8?B?d2F1UnU3SVZ4eHZQUGFTOTd1MWJyVVBsUkVWSzM1bkc2cG5SWkJabVRPbjM5?=
 =?utf-8?B?VjdIVGFOSlBZVlJVZkJaSUw5SmE5MnR2MlBLRWU4TnoyMUZFK2JEZmd1eHps?=
 =?utf-8?B?OGZYOFJUcFpGUjhjTDc5djNTZTduTXhUOWdCR0pLYTBzVVJFQjFxTVVYaThL?=
 =?utf-8?B?RUFUSWJYVlRpOXA5YzcxUHcveXNKYmMxV0VER1BGaDFKZjhCNFFvUmNUSUFI?=
 =?utf-8?B?eGlhbE1RRmZDNUxXTVBmeTdOUTQ2L3RkS0JQMDJDUjdsazNtdTVWOG9DVEN3?=
 =?utf-8?B?QS9wVHNZWDdOSjBpVEF6b3NOZ3hjUElIOUhSdVhmaTBwbUwzTldyTFJNNUsy?=
 =?utf-8?B?cmNFdU92dnhZNStqa0FtU2lzN0lGTFJuTGRxaDZjTExoWmdMbm1la0g5UU9p?=
 =?utf-8?B?YnNlNXpFeXdjWmhGMms0TzRjMFRuS0RPRTMxZXdlRGNJVlRKOWpRRVZZaXJi?=
 =?utf-8?B?bFJIMkxyamEzVnNESVZEYjJLSnJVRlZDNlczTloyUnViWHlnOGEyOFpHYXdK?=
 =?utf-8?B?Yk5NSFBjVmljZldwYjJwS21MZEVDSFVHa2ttQWtDZXZYSm1NSWlvV3Bvd3Q2?=
 =?utf-8?B?SnRTTmN1Nmg4RktOSlIwOU91UTQyby9USU1UVnZOOWpXMzNsaUFzT1hVQVds?=
 =?utf-8?B?bUxKNXFMWU9iaktQM3RIeUMwVGN2UmpwWTl1NTJwTTcrNW04TG9FK3pucmRh?=
 =?utf-8?B?ZDVqRDR5a0E1Q1FVYW1tMUZHQmkvdEZCNlE3Q2E3Njl5L09kVlJacHl1T1VE?=
 =?utf-8?B?L24xbllzSVRselRZbGMzL3VBOVJ6L045OXRvNDhray9RM3pNYWF3TkVSa1VF?=
 =?utf-8?B?YXo2YTVteUVxSzhhSGE0bmIvRnV6dHdXOWQ3WUxNUzhOcUVWbkE1K0RVUWpM?=
 =?utf-8?Q?TO2E0W/CJadDtjx745eBE+HeT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C805EE78399BCB43B22B625D8B400479@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1663f5-a727-40ea-5904-08dabc1f4511
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:39:31.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfffnfkTOSbwKMRHWLA+QnNUxHZO3cT4pkt+vNsmraFTiQCV/naC1amszZZSAmQc8FIArs+lhHsuDzwnGagWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwKCk9uIE1vbiwgMjAyMi0xMC0zMSBhdCAxNjoyNSAtMDcwMCwgTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiB3cm90ZToKPiBIaSBCcmlhbiwKPiAKPiBPbiBNb24sIE9jdCAzMSwgMjAyMiBh
dCAzOjAyIFBNIEJyaWFuIEdpeCA8YnJpYW4uZ2l4QGludGVsLmNvbT4KPiB3cm90ZToKPiA+IAo+
ID4gVGhlIG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoKSBjb21tYW5kIHdhcyB1c2luZyB0aGUgZGVw
cmVjYXRlZAo+ID4gaGNpX3JlcXVlc3QgbWVjaGFuaXNtIHJhdGhlciB0aGFuIGhjaV9zeW5jLiBU
aGlzIGNhdXNlZCB0aGUgd2FybmluZwo+ID4gZXJyb3I6Cj4gPiBoY2kwOiBIQ0lfUkVRLTB4ZmNm
MAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBCcmlhbiBHaXggPGJyaWFuLmdpeEBpbnRlbC5jb20+
Cj4gPiAtLS0KPiA+IMKgbmV0L2JsdWV0b290aC9tc2Z0LmMgfCAzNiArKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDI1IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9t
c2Z0LmMgYi9uZXQvYmx1ZXRvb3RoL21zZnQuYwo+ID4gaW5kZXggYmVlNmE0YzY1NmJlLi5iZjVj
ZWU0ODkxNmMgMTAwNjQ0Cj4gPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL21zZnQuYwo+ID4gKysrIGIv
bmV0L2JsdWV0b290aC9tc2Z0LmMKPiA+IEBAIC03NDMsMTcgKzc0MywxMiBAQCBfX3U2NCBtc2Z0
X2dldF9mZWF0dXJlcyhzdHJ1Y3QgaGNpX2RldiAqaGRldikKPiA+IMKgfQo+ID4gCj4gPiDCoHN0
YXRpYyB2b2lkIG1zZnRfbGVfc2V0X2FkdmVydGlzZW1lbnRfZmlsdGVyX2VuYWJsZV9jYihzdHJ1
Y3QKPiA+IGhjaV9kZXYgKmhkZXYsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1OCBzdGF0dXMsCj4gPiB1MTYgb3Bjb2RlLAo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0Cj4gPiBz
a19idWZmICpza2IpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2b2lkCj4gPiAqdXNlcl9kYXRhLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggc3RhdHVzKQo+ID4gwqB7Cj4gPiAtwqDC
oMKgwqDCoMKgIHN0cnVjdCBtc2Z0X2NwX2xlX3NldF9hZHZlcnRpc2VtZW50X2ZpbHRlcl9lbmFi
bGUgKmNwOwo+ID4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgbXNmdF9ycF9sZV9zZXRfYWR2ZXJ0aXNl
bWVudF9maWx0ZXJfZW5hYmxlICpycDsKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG1zZnRfY3Bf
bGVfc2V0X2FkdmVydGlzZW1lbnRfZmlsdGVyX2VuYWJsZSAqY3AgPQo+ID4gdXNlcl9kYXRhOwo+
ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1zZnRfZGF0YSAqbXNmdCA9IGhkZXYtPm1zZnRfZGF0
YTsKPiA+IAo+ID4gLcKgwqDCoMKgwqDCoCBycCA9IChzdHJ1Y3QgbXNmdF9ycF9sZV9zZXRfYWR2
ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlCj4gPiAqKXNrYi0+ZGF0YTsKPiA+IC3CoMKgwqDCoMKg
wqAgaWYgKHNrYi0+bGVuIDwgc2l6ZW9mKCpycCkpCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4gPiAtCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBFcnJvciAweDBDIHdv
dWxkIGJlIHJldHVybmVkIGlmIHRoZSBmaWx0ZXIgZW5hYmxlZAo+ID4gc3RhdHVzIGlzCj4gPiDC
oMKgwqDCoMKgwqDCoMKgICogYWxyZWFkeSBzZXQgdG8gd2hhdGV2ZXIgd2Ugd2VyZSB0cnlpbmcg
dG8gc2V0Lgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIEFsdGhvdWdoIHRoZSBkZWZhdWx0IHN0YXRl
IHNob3VsZCBiZSBkaXNhYmxlZCwgc29tZQo+ID4gY29udHJvbGxlciBzZXQKPiA+IEBAIC03NjYs
NyArNzYxLDYgQEAgc3RhdGljIHZvaWQKPiA+IG1zZnRfbGVfc2V0X2FkdmVydGlzZW1lbnRfZmls
dGVyX2VuYWJsZV9jYihzdHJ1Y3QgaGNpX2RldiAqaGRldiwKPiA+IAo+ID4gwqDCoMKgwqDCoMKg
wqAgaGNpX2Rldl9sb2NrKGhkZXYpOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIGNwID0gaGNpX3Nl
bnRfY21kX2RhdGEoaGRldiwgaGRldi0+bXNmdF9vcGNvZGUpOwo+ID4gwqDCoMKgwqDCoMKgwqAg
bXNmdC0+ZmlsdGVyX2VuYWJsZWQgPSBjcC0+ZW5hYmxlOwo+ID4gCj4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoc3RhdHVzID09IDB4MEMpCj4gPiBAQCAtODA0LDMxICs3OTgsMjMgQEAgaW50IG1zZnRf
cmVtb3ZlX21vbml0b3Ioc3RydWN0IGhjaV9kZXYgKmhkZXYsCj4gPiBzdHJ1Y3QgYWR2X21vbml0
b3IgKm1vbml0b3IpCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbXNmdF9yZW1vdmVfbW9uaXRv
cl9zeW5jKGhkZXYsIG1vbml0b3IpOwo+ID4gwqB9Cj4gPiAKPiA+IC12b2lkIG1zZnRfcmVxX2Fk
ZF9zZXRfZmlsdGVyX2VuYWJsZShzdHJ1Y3QgaGNpX3JlcXVlc3QgKnJlcSwgYm9vbAo+ID4gZW5h
YmxlKQo+ID4gLXsKPiA+IC3CoMKgwqDCoMKgwqAgc3RydWN0IGhjaV9kZXYgKmhkZXYgPSByZXEt
PmhkZXY7Cj4gPiAtwqDCoMKgwqDCoMKgIHN0cnVjdCBtc2Z0X2NwX2xlX3NldF9hZHZlcnRpc2Vt
ZW50X2ZpbHRlcl9lbmFibGUgY3A7Cj4gPiAtCj4gPiAtwqDCoMKgwqDCoMKgIGNwLnN1Yl9vcGNv
ZGUgPSBNU0ZUX09QX0xFX1NFVF9BRFZFUlRJU0VNRU5UX0ZJTFRFUl9FTkFCTEU7Cj4gPiAtwqDC
oMKgwqDCoMKgIGNwLmVuYWJsZSA9IGVuYWJsZTsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqAgaGNp
X3JlcV9hZGQocmVxLCBoZGV2LT5tc2Z0X29wY29kZSwgc2l6ZW9mKGNwKSwgJmNwKTsKPiA+IC19
Cj4gPiAtCj4gPiDCoGludCBtc2Z0X3NldF9maWx0ZXJfZW5hYmxlKHN0cnVjdCBoY2lfZGV2ICpo
ZGV2LCBib29sIGVuYWJsZSkKPiA+IMKgewo+ID4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgaGNpX3Jl
cXVlc3QgcmVxOwo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgbXNmdF9jcF9sZV9zZXRfYWR2ZXJ0
aXNlbWVudF9maWx0ZXJfZW5hYmxlIGNwOwo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1zZnRf
ZGF0YSAqbXNmdCA9IGhkZXYtPm1zZnRfZGF0YTsKPiA+IMKgwqDCoMKgwqDCoMKgIGludCBlcnI7
Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghbXNmdCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAg
aGNpX3JlcV9pbml0KCZyZXEsIGhkZXYpOwo+ID4gLcKgwqDCoMKgwqDCoCBtc2Z0X3JlcV9hZGRf
c2V0X2ZpbHRlcl9lbmFibGUoJnJlcSwgZW5hYmxlKTsKPiA+IC3CoMKgwqDCoMKgwqAgZXJyID0g
aGNpX3JlcV9ydW5fc2tiKCZyZXEsCj4gPiBtc2Z0X2xlX3NldF9hZHZlcnRpc2VtZW50X2ZpbHRl
cl9lbmFibGVfY2IpOwo+ID4gK8KgwqDCoMKgwqDCoCBjcC5zdWJfb3Bjb2RlID0gTVNGVF9PUF9M
RV9TRVRfQURWRVJUSVNFTUVOVF9GSUxURVJfRU5BQkxFOwo+ID4gK8KgwqDCoMKgwqDCoCBjcC5l
bmFibGUgPSBlbmFibGU7Cj4gPiArwqDCoMKgwqDCoMKgIGVyciA9IF9faGNpX2NtZF9zeW5jX3N0
YXR1cyhoZGV2LCBoZGV2LT5tc2Z0X29wY29kZSwKPiA+IHNpemVvZihjcCksICZjcCwKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIQ0lfQ01EX1RJTUVPVVQpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBtc2Z0
X2xlX3NldF9hZHZlcnRpc2VtZW50X2ZpbHRlcl9lbmFibGVfY2IoaGRldiwgJmNwLCBlcnIpOwo+
IAo+IEV4Y2VwdCBpZiB0aGlzIGZ1bmN0aW9uIGlzIG9ubHkgc3VwcG9zZWQgdG8gYmUgY2FsbGVk
IGZvciBhIHNhZmUKPiBjb250ZXh0ICh3aGljaCBjYW4gYmxvY2spIHdlIHNob3VsZCBhY3R1YWxs
eSB1c2UgaGNpX2NtZF9zeW5jX3F1ZXVlLgoKVGhpcyBjYWxsIGlzIG1hZGUgZnJvbSBtc2Z0X2Rv
X29wZW4oKSB3aGljaCBoYXMgb25lIGNhbGw6IApmcm9tIGhjaV9kZXZfaW5pdF9zeW5jKCksIHdo
aWNoIGFsc28gY2FsbHMgYW9zcF9kb19vcGVuKCkuCgpGcm9tIHdpdGhpbiBhb3NwX2RvX29wZW4o
KSwgd2UgYXJlIGFsc28gY2FsbGluZyBfX2hjaV9jbWRfc3luYygpLCBhbmQKaWYgd2UgYXNzdW1l
IHRoYXQgdGhhdCBoYXMgYmVlbiB0ZXN0ZWQgYW5kIGlzIHdvcmtpbmcsIHRoZW4gbWFraW5nIHdo
YXQKaXMgZXNzZW50aWFsbHkgdGhlIGlkZW50aWNhbCBjYWxsIGhlcmUgc2hvdWxkIGJlIGZpbmUu
CgpPdGhlcndpc2UsIHdlIHNob3VsZCBhbHNvIHJlY29kZSBhb3NwX2RvX29wZW4gdG8gdXNlIHRo
ZQpoY2lfY21kX3N5bmNfcXVldWUgYXMgd2VsbC4KCgo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIHJl
dHVybiBlcnI7Cj4gPiArwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gwqB9Cj4gPiAKPiA+IMKg
Ym9vbCBtc2Z0X2N1cnZlX3ZhbGlkaXR5KHN0cnVjdCBoY2lfZGV2ICpoZGV2KQo+ID4gLS0KPiA+
IDIuMzguMQo+ID4gCj4gCj4gCgo=
