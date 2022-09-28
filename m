Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D4C04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiI1R1C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiI1R0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 13:26:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C3C6DFA0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664385998; x=1695921998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hCVmZXurCZTITZEtn3BP5MnoAvi6ogTpZooaWRZEQnQ=;
  b=laL07IjgvX+n0POWERVoz60C0R1z9gCNJKiEHFkoe92vQeYaj3ir08MY
   9IrOC22xOZJe0ZmzxWJJz5y5cyTJPohndRk4zEjW2fLpKjgq/PL95ly8U
   Ft09Y7n/Ez7GH+g3EGogVvD622mT2mfnnm+0hOWqVf+bltRq5ljb2M5I/
   JT5COwibf47NNqMRmxyvw0Cj1w4+rrUSb0FhmOAwtVOHCGMQ1V3Bd7bWn
   vMN3mwBf7KibHQSXCODWCVzb+owsRdXF/nPejoHZ0ykgDc9tKKn7LPZBe
   XFw3gcWGdG0LbRRUtUX0XmqOzfrI4uCw4sa0d0cKUtiWkOhKmAFAJZkRn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363508816"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="363508816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 10:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573127026"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="573127026"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 10:26:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:26:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:26:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 10:26:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 10:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjBOtCz1KcRlxuE4dTAaHFczOevdmRpQh41zujY7dy/OKJpyV2O+hlrXvsp659dKPDONDH5ta3QIgPa4taTB7JziJXV2jBlnG/xK6t00IgZSZjc4aQbQMyZfPlagBqlwMttE126A/Izyf9mAzc9yzVVNZHBaSeo9jaOQg3Z0Iajnle6Udrir2AYVhrmrNt+fMDDxd5C/MvmTSUkDW8d3SXSuhNcx0iqPiFVvX/puBC0qFJuWHayyh6HTl6voAcyu1sGr1Xm+FppOmaGk9FpVDcsauD5HL1HjxwYMAosI58z5yscSOKTybUb/+hl2pfFG+A2qZ5FNw7asxlxa5udU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCVmZXurCZTITZEtn3BP5MnoAvi6ogTpZooaWRZEQnQ=;
 b=ncJJHAlNSsJnfBSMcJmO2I28cHhTXfoHN5HYMcNyBtO/fj0K36e1mbXcP590atpT3SK47QhWCr63RZmklhNdk57xX+11kiF0CB2r+e1YTgusDWYFxChrTXgwDw7X5xAed84CN9DRjKlg7fB8SGXHlDX/hbLo8uzxfK+p1t25N9nFmqHokeCs+yUCpJkaVneGlBrNQacGmQUGjOFV0cSjiRnnTvfM22YevWTM5S7IdusCdqg2l8hWQzlRZO417rOutOMtK9khZWRp10WZT3cTzxutqmzxZ55ao0fBZQ8yug/BwsGIqX66t9B/fgtprWGtgxKQH6+br91o4TsgaG+FwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SJ0PR11MB5680.namprd11.prod.outlook.com (2603:10b6:a03:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Wed, 28 Sep
 2022 17:26:31 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:26:30 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "An, Tedd" <tedd.an@intel.com>
Subject: Re: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
Thread-Topic: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
Thread-Index: AQHY0sQ9BR4LP2iN00S3FEHqh6Dl/q31GVqA
Date:   Wed, 28 Sep 2022 17:26:30 +0000
Message-ID: <554c963e5923cb7b0c216b975f5af1482dc832dd.camel@intel.com>
References: <20220927225514.278400-1-brian.gix@intel.com>
In-Reply-To: <20220927225514.278400-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|SJ0PR11MB5680:EE_
x-ms-office365-filtering-correlation-id: 03187e38-0b75-4249-27d2-08daa1769534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfFPZpDnmORIn/+dMFdMU4Fx5ZGaVh9j3cHxhnSwG2Ey24VGHw03G773uoU0LHCOVp8s7Q7o5lzSgQQLIq0G/dfWHhmhheJRJ4dAQ75VsaiEB5gYk/aXU+GfAoQnqqM3zXEoIk6ZmproT16c/ezRK/9g0wpvyGvzSjHATWJ46EYYGIM4gB6cXpBYOgmqleMU5w+n4oXwht58PEcFNzd93gi479WGHm+rKc1PhlIXVrZWswwBovUEf5GkGtcL68+LCLepI/uNDyzma0O3V7gFRibj/S7pfDV2/f5J2ML12qEtrkvVfJDduApMHPS6m6tMmb2u56pKi1FSFz/7hrv1EFcYL4WBIGcsj51GYvszKFXfX7qrZPvCo2Y6mSxQGtBoix/zJcC44719UO3DPK0B7YikXErUYQC5lIyu5CoF7Q6VMZG9zUmcrTT1uZy3i0nPsiu5SP5S8Hz5rurhXHDSu3mqYfDqEG3/zigTj/ELP0+bahca8Ciq3L7YK503cDu4FZsKrOlP8/BpMDUkI1aemZo5rvZf68PdjtDSkohlQx7sU2g07dCnvjRbFB8Tx+rKa8v5HOaactaIQ7m7T3YS/elENE2w09d70uP1/1krWT81WKqUmAUPKb9rXx4BrIQ6Nmoy9HxhJUJ2/7+bFRildeK8b3CoEFdrp02s9YcpKWArGpfyuPSshF97cKhjsxcht7G+dPWp6rFVLswwD061THZZMbJc7TyZKduR7kOU0VF5syZ3rVXz4uOCkcy5Hv6PDiXAqdYmxjgtTNTdqxlMgHl4mT7fZjthtHTQBd2ezow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(6916009)(54906003)(6486002)(8676002)(91956017)(71200400001)(478600001)(38070700005)(38100700002)(36756003)(316002)(5660300002)(66446008)(64756008)(4326008)(41300700001)(66476007)(66556008)(122000001)(76116006)(66946007)(82960400001)(8936002)(2616005)(107886003)(186003)(6506007)(86362001)(26005)(6512007)(2906002)(80283002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25hZ0xkTk5qMTN1N3c4SFNxV29SbEh6Q3hEUU1KQzJ4ZmoyUDhpbVBrMlpV?=
 =?utf-8?B?TXhKblZ4U1c5K05HcmlCZGRUTjBZL1QwUGR6dnNZRlZQb1U0MkZDbFc3TjFG?=
 =?utf-8?B?MUEzcEp1R0czQzBqaHNrYzBDU3ZwclNVeTErT3pBVW9wUEw0eGcwVWk2YzI1?=
 =?utf-8?B?ckRjcmtzZ3lJOXBnVnF3Q3o1VG4rMTBrbkU1b1loc1hSYW1WTFErZ2M5ZFhM?=
 =?utf-8?B?bXRYNTZ4dG1vajMzOFNQekVUZ3NGd2tCT2hpS3h1VXE1T3AreDFtcE8zT2JW?=
 =?utf-8?B?aWNjLzVnR1psbTE0U3dIS2o4Y3BhakxjRGtoK1NFeDd3Y1I2U0trVDFBUDJh?=
 =?utf-8?B?WXdFcHlEOGwxM0tzNGFzcENpQ3pWRkZtOHdQeC9Xc0lpb3h3MDByWE5IMHFt?=
 =?utf-8?B?b2RqY3NmVVhURnhmbWxyaCt3S1NzdWcyd3NON1VpLy9pWTRhbEVjTXUveE9O?=
 =?utf-8?B?STNOSitXaUFZcFNvclJrajdqT2F5SXowZTJHVzhPT2RrTlJaR3ZwRTVUOEdk?=
 =?utf-8?B?RmZyeXljcDU0aXZscGVpRmxNbFhuOFZPZnV0cFlGOSthdSsyQlFyMzgwZWdM?=
 =?utf-8?B?cGV3S2J5eENIWUtZaU5oVWRiM0dLN2hpblZ3QkZWU3NpSUNtT3hZekpIR0gw?=
 =?utf-8?B?ZGZHRC95TU92SlJzTjJNTzIzRXhWSEFxbzlKaFBRUHIzY1lHSjhCQ2s1RjNp?=
 =?utf-8?B?Z2QxNU9tVEplTG0yckhURkR1cWtmRzlMS1diMk81aTBubytXakFPQmo0VUZQ?=
 =?utf-8?B?QWlhQ1NLVlVJT3dwcktQNnZjYmtoeWZhZkJFbHlMcnpESTJtcE80MlhjR0dh?=
 =?utf-8?B?VlJBRzhnclp3WWsyM3hKMmpXc3VtKzN3U3hpK1R4ME9tUm41RDdvQlNrL2dw?=
 =?utf-8?B?YWRZeStUYkMwUFozdzloRkZpaEZ5ZFkwQ1FpN2tFNlNVMGlNbzV2ZEpyZHVq?=
 =?utf-8?B?Z2JRUFZ4MHN0cE1PT2ZQUVJiOGNJbWZvVVZWVEJuTGRvcU1iQkFyWi9HbGdY?=
 =?utf-8?B?d3ZJTHJsNkY3THpPdkxldVBNWkZzQkZCK3hZUU5OUUZ4djc2N0REQmcydWts?=
 =?utf-8?B?cCtHZjdZZEFWeTJPa2tJaHpySHh4QUJZRjIwNnpabGdMbVVFYWVTUWhKc01m?=
 =?utf-8?B?a3FrV3hXOXRoUVBRQTIvMThNS1ludjN6L2Z2RjFRc0x4ZXBnRnQ3bUZ3UDlu?=
 =?utf-8?B?dzVWcDVwS0F5cWEvT1REWE8zbEg2cVpHUXh3Vm5raEhRUEUvNG01ZFlldzA4?=
 =?utf-8?B?aFNTWHFiT0JNRnBBS0N6WXE2QkMvVVpCYUZmR3lxOU1GUURRSzI2cXYyNEFz?=
 =?utf-8?B?Tmc4NUhiVjhHaGVtWWRiNlBaNnVKUFpsM3BVbGdaSHNocXYvLy81Mit1Q3Mx?=
 =?utf-8?B?b0FQMmFWWGNDZ1RHUGZybnJFZ0tlcFB6bnc2V0Nnbm5Wb3ZoTkR2MTFmYW9S?=
 =?utf-8?B?RHVJanNHeUxyOVY2bWZveUQzaTUrR0xBVXdOZndvZkpaSVZiUGpTZTR0dmI1?=
 =?utf-8?B?WEhPRDByaFExNXBlM0NWNFNtdFhzQy9PZmhzZ1dMVXlNVGlXdWV6M2V4UFBw?=
 =?utf-8?B?a1pCVzdwdXdhRldRMTFNT2F0WGVzWHZRRFRhN25DamwrNVZVWlRnZnpoMUVD?=
 =?utf-8?B?eUVoeEJtQ2ZCOHpkQWZNVEYxdnJmckNibnlseTMxUDRuSE1MTHRBMTdsbHRo?=
 =?utf-8?B?T016K296OWdKWmdBVnBHaDVrSTcwNzlDR3lqcmdNVlhtTlFLaTFhNnJEbXdq?=
 =?utf-8?B?Y2RNUGtXSE0yN3hxcVF0NFFDVHI0S3l5TDF3UTdBMkhRSHRCQkNGQnVnWUFP?=
 =?utf-8?B?U1RnQ1VrZWpUTFNvV1FEeHBMR3dab3hsd0VVNHNYQ0dPRGZrMWR2MlRyR1lx?=
 =?utf-8?B?T3RhL2JVeFFaUDN4N1lxdis3MXhUQ0d2b21PdExNVmNLa1dCM3Zmd09kcy85?=
 =?utf-8?B?a3IvaVJRVitBeUJPckZUNnJkMnVYczNHTGV4Wll2RTBlS3ovL1hCQTh6L29u?=
 =?utf-8?B?Zm1QY0xmYjQ5OWRpYzhJS2pOd2dDUzNRd2xaQXdEeXMwaEdtU1VQQWxEUU9y?=
 =?utf-8?B?cXBpRmZ5UzBUOFBWNitDVFd0R1BBMGlrZjAvTWR2ZEd1RFVkSWxwSUlxT0s2?=
 =?utf-8?Q?Ny+NDqCV3n/34z4M1K1KD2uuo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97AE0811F2ABAE478122028533387033@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03187e38-0b75-4249-27d2-08daa1769534
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:26:30.7470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9SrunWmDtroM5mgmBBW32ZNBr1Lr7JMna0xbgQ639Z11YUYWBqsmNCmO8Ojzefy0znAUbufrqdr6S9nplzhpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5680
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgVGVkZCwNCg0KVGhpcyBwYXRjaCB3YXMgdXBzdHJlYW1lZCB0byB0aGUgQmx1ZVogdHJlZS4g
Q291bGQgeW91IGFkZCBtZXNoLXRlc3Rlcg0KdG8gQ0k/DQoNCk9uIFR1ZSwgMjAyMi0wOS0yNyBh
dCAxNTo1NSAtMDcwMCwgQnJpYW4gR2l4IHdyb3RlOg0KPiBUZXN0ZXIgd2FzIGZhaWxpbmcgYnkg
bm90IGNsZWFyaW5nIHRoZSBIQ0kgcXVldWUgb2YgZXhwZWN0ZWQgZXZlbnRzDQo+IC0tLQ0KPiDC
oHRvb2xzL21lc2gtdGVzdGVyLmMgfCAxMiArKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gtdGVzdGVy
LmMgYi90b29scy9tZXNoLXRlc3Rlci5jDQo+IGluZGV4IDY3ODFiZDU2NS4uZDdiM2I2ZjliIDEw
MDY0NA0KPiAtLS0gYS90b29scy9tZXNoLXRlc3Rlci5jDQo+ICsrKyBiL3Rvb2xzL21lc2gtdGVz
dGVyLmMNCj4gQEAgLTEzNDUsNiArMTM0NSwxMCBAQCBzdGF0aWMgY29uc3QgdWludDhfdCBzZW5k
X21lc2hfY2FuY2VsXzJbXSA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoDB4MDINCj4gwqB9Ow0KPiDC
oA0KPiArc3RhdGljIGNvbnN0IHVpbnQ4X3QgbWVzaF9jYW5jZWxfcnNwX3BhcmFtX21lc2hbXSA9
IHsNCj4gK8KgwqDCoMKgwqDCoMKgMHgwMA0KPiArfTsNCj4gKw0KPiDCoHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZ2VuZXJpY19kYXRhIG1lc2hfc2VuZF9tZXNoX2NhbmNlbF8xID0gew0KPiDCoMKgwqDC
oMKgwqDCoMKgLnNlbmRfb3Bjb2RlID0gTUdNVF9PUF9NRVNIX1NFTkRfQ0FOQ0VMLA0KPiDCoMKg
wqDCoMKgwqDCoMKgLnNlbmRfcGFyYW0gPSBzZW5kX21lc2hfY2FuY2VsXzEsDQo+IEBAIC0xMzUz
LDYgKzEzNTcsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnZW5lcmljX2RhdGENCj4gbWVzaF9z
ZW5kX21lc2hfY2FuY2VsXzEgPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2FsdF9ldiA9
IE1HTVRfRVZfTUVTSF9QQUNLRVRfQ01QTFQsDQo+IMKgwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2Fs
dF9ldl9wYXJhbSA9IHNlbmRfbWVzaF9jYW5jZWxfMSwNCj4gwqDCoMKgwqDCoMKgwqDCoC5leHBl
Y3RfYWx0X2V2X2xlbiA9IHNpemVvZihzZW5kX21lc2hfY2FuY2VsXzEpLA0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoC5leHBlY3RfaGNpX2NvbW1hbmQgPSBCVF9IQ0lfQ01EX0xFX1NFVF9BRFZfRU5B
QkxFLA0KPiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9wYXJhbSA9IG1lc2hfY2FuY2VsX3Jz
cF9wYXJhbV9tZXNoLA0KPiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9sZW4gPSBzaXplb2Yo
bWVzaF9jYW5jZWxfcnNwX3BhcmFtX21lc2gpLA0KPiDCoH07DQo+IMKgDQo+IMKgc3RhdGljIGNv
bnN0IHN0cnVjdCBnZW5lcmljX2RhdGEgbWVzaF9zZW5kX21lc2hfY2FuY2VsXzIgPSB7DQo+IEBA
IC0xMzYzLDYgKzEzNzEsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnZW5lcmljX2RhdGENCj4g
bWVzaF9zZW5kX21lc2hfY2FuY2VsXzIgPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2Fs
dF9ldiA9IE1HTVRfRVZfTUVTSF9QQUNLRVRfQ01QTFQsDQo+IMKgwqDCoMKgwqDCoMKgwqAuZXhw
ZWN0X2FsdF9ldl9wYXJhbSA9IHNlbmRfbWVzaF9jYW5jZWxfMiwNCj4gwqDCoMKgwqDCoMKgwqDC
oC5leHBlY3RfYWx0X2V2X2xlbiA9IHNpemVvZihzZW5kX21lc2hfY2FuY2VsXzIpLA0KPiArDQo+
ICvCoMKgwqDCoMKgwqDCoC5leHBlY3RfaGNpX2NvbW1hbmQgPSBCVF9IQ0lfQ01EX0xFX1NFVF9B
RFZfRU5BQkxFLA0KPiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9wYXJhbSA9IG1lc2hfY2Fu
Y2VsX3JzcF9wYXJhbV9tZXNoLA0KPiArwqDCoMKgwqDCoMKgwqAuZXhwZWN0X2hjaV9sZW4gPSBz
aXplb2YobWVzaF9jYW5jZWxfcnNwX3BhcmFtX21lc2gpLA0KPiDCoH07DQo+IMKgDQo+IMKgc3Rh
dGljIHZvaWQgc2V0dXBfbXVsdGlfbWVzaF9zZW5kKGNvbnN0IHZvaWQgKnRlc3RfZGF0YSkNCg0K
