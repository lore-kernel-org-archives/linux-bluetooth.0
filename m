Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbhLWHDe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:03:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:23617 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346702AbhLWHDd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 02:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640243013; x=1671779013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hMNwT+54p61kPYyu/Av/VBiasSIE0PMGFQuRpEjtCt4=;
  b=IuVu/2KiwoQ7tT0KS74irThBwPZBOouMQZ1vsUToI/ddgqF/d3lkmXkC
   vobjj1z7Ct4MmTwjhTlZokz/ciwkn2zeVB1dEGqseNGg6ytzTvmoC99MD
   0N8OV02MH+wj4myibghJxQ9fK0T+U2kStH9sCYs1MwPreLZoe7y0gV3Vp
   Zj6jC7sjpFbheXhb0dPHoUaX485FDW3VjZyutEWzzxMHHdZ4ifouyIHIS
   VkS/R1ukwVV4mky0Y05VAY/wjYuG1a3g1X16f4KPzj0fg1fIKhQtPfUsh
   cCH80i4qGVRYEcsrVVbxW71FqygJh85C+k91m2nNXs3S5gPnCLDmeBG8i
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="301535799"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="301535799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="485002872"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 23:03:33 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 23:03:32 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 23:03:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 22 Dec 2021 23:03:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 22 Dec 2021 23:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TetX1igEl86MFlvgFTBdISgoD+J+PPaJXVH6jYJgrhzrnTaF5pTTEIQ/oqnUdA30bSLJTxpYuQYnv2S0BTGdvoHjJmCwUTUykMJtP4KWy6mr8hWdTPRTrLPQFdd2scYA+8xbrtnWUhASNB+64S8m3YKS/qydTO0aD8gqcJ0XUyfvqsDfbENoZkhcM/UsV6V2VFSBdOeuDsmY76k5ahF82lnLEdn2AcCwYpCmQTqixvfMtitZUQ7yFwQ1oajDLkkhhJxfDAklK7M53ONUTjyOE0z3brgP3SSZI+BxB4aiavH5mSj4kDKPA8D8uMTrFyDRtenaEiDF3dpSFZmEwDm8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMNwT+54p61kPYyu/Av/VBiasSIE0PMGFQuRpEjtCt4=;
 b=OEQujfEQsrriKW89XKd4lN8SlEYc25YC1iDiQa2cusa5xRvJ3l0q1GhRCPBrQTwQfbGPrX6EvoCAopzJ41hKzmnEt6xx8fs7FUYWbhOOZIziu2vnvgpJitY1i1cdy+t+HLbvHyRpqd7AOaLjv4lo1RUE7Q4pxo8ucRuNr4mVUAbaEfZbRRleYQRBfBLQYcehGRYNwLwxOvpi0zlAmkaw+2O9YivfwgZ4t5/+02WGdb1yu970mHuu92iqFU0Mp8nc92CWhR9qz0jWGLXfFN/y457/rMvokE0/28tcyE+HMbkN0RThalbKge62L7dXQsD4/N1aBdKehvW7qh0QxMVPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1711.namprd11.prod.outlook.com (2603:10b6:300:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 07:03:29 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f%5]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 07:03:29 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Topic: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Index: AQHX8sFUOehkja9FU0C9xWapVmNOIKw+MCkAgAD3iQCAAARoAIAAhMIA
Date:   Thu, 23 Dec 2021 07:03:29 +0000
Message-ID: <f1ffad7eebc385d43f4f48d138021860f8e582cd.camel@intel.com>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
         <B5187291-3173-4BFB-8465-25AB75BA328E@holtmann.org>
         <39a9b9c68cdb9fbf32f3c6023c0272b53d37d668.camel@intel.com>
         <768826DA-51CF-4EA2-B582-89BFE843EBAE@holtmann.org>
In-Reply-To: <768826DA-51CF-4EA2-B582-89BFE843EBAE@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bef4eac2-d6ca-4544-6154-08d9c5e2531e
x-ms-traffictypediagnostic: MWHPR11MB1711:EE_
x-microsoft-antispam-prvs: <MWHPR11MB17116AAC7036E286BACE47A5FF7E9@MWHPR11MB1711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQrohZpob9G5lMIT9iJrXuuV/YlyTwRJRpD67vfz7JuleTTiMoNVCp5tNH1fUYtKCB2fJS/IPtgQc7sxEViuPRq4pAc7/aK4wDVD6sFaLgPHp7FR3tiBq9ZI1sVjnkhWBqhSxWd0WB9giMvaP3Zu9FhSxIBuMSnZeunUIc+XHgONtkMTizn1kgsUzuFHnZGbd7j+mXCS8v83irqUwp/Sq8g8HfQmOTml+Zohhetf4X1nHO0CGxTvr122JvEXabCwBlrKg57bRUTEoVc2Y+gCEjdPZXCGdHe5ucce86p5eeQHKTxq9oczXrMepaUS2yT6dRBswecIycjxGS26bTSf+6ulQYgqy2RfR8VtMRbYWFr3CAnzDP355ayDxeaIfrs92enLgUshjmiUhKqfxZ03pURkuFochiMxhLilArwUntjPj/Knl0bXnGmTa6CaATB32T68bET9CEJmHt00b6z8m502qy6PSggbWxM8ufQt8M6WG8qhbKTR2APEmtgTOXVTmGFpZt9nSh0ghn4sUqF6ulNR9vsuiDhyvCgCFBKayyte5EyF6wj2Ny3pmC50LiveDDltyD/oies4QHa+Vv0cqslK6ThVBCH+MlTJQvqYdDCzjHDyYXxXtX1FDq7WZmpUV7R3gxiLfSpKtZ18ff4xVlYX9AlrAzJLa31+yjmos8RYic2fCk06D/Meazoqq45PipeDCXFMcJIJmPDEdzSP7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(83380400001)(8936002)(38100700002)(6916009)(26005)(186003)(122000001)(54906003)(36756003)(5660300002)(8676002)(6506007)(66446008)(64756008)(82960400001)(316002)(508600001)(38070700005)(66946007)(4326008)(6512007)(2906002)(4001150100001)(86362001)(76116006)(71200400001)(66476007)(66556008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFQrRFo0TTVuR3JBc0xqczFIcXVwMzIveVZPTFJyQ1o2S2w1dS82Lzc1VXJH?=
 =?utf-8?B?RVZtek9YUUtNWTB4MFB1WXNyZnBMWDFVNU9HdThwNDBlNzZPVlQvbzREMWtl?=
 =?utf-8?B?cUcxT2ZYd0FuZEtEYlZCTE5tVUNQZ0JsamlqMW5mS1ViLzBUR21qZFBOTWZj?=
 =?utf-8?B?VjUva3E1YkYxOHJnY3IxMEVSMmV4RlNhWnFoMXV5NktnUHMvVXYwZlpXQ3Vy?=
 =?utf-8?B?SWtPVmN4WTNKUG9sbHlOemdEaUczdHNWTFIzdU9NQ0pFNXBweEhCeW9VMGJJ?=
 =?utf-8?B?QnlhMk5oRS81UHltdnNNYkNqRGtCNFM3UUJuWDFXbFZVU3RVOW91bG9mSlNk?=
 =?utf-8?B?VzVlcGY5a0c1eVl1MUxsQ0U3SzdNbkVRTHdCcE95cFlpWURncEJQOHBkSmp0?=
 =?utf-8?B?WW5qQVA4dXFCZjhoRFRJVVh6MFZvZXFYUVNjVm5PWXhCc285bGJnclUrSTdW?=
 =?utf-8?B?UWhyRnRCZGpMYUNzTTVCSFJXNEhQUlVJc2g2Z1NmbW1MNmlGN0R6WHd6WEZY?=
 =?utf-8?B?K3crTEhQcVNkcHRDaENBaUx2WGU4a2d1UFdJSjh0ZDdLZWMzRm1ITExwK0hM?=
 =?utf-8?B?RlJxd1dDeCtxWGNOcUVHUzVSRW1tTjhDeFUvWW4yNEIzOHlIVXdlQ1pNY1pO?=
 =?utf-8?B?QkF5OVo1QWdrREROeE5wNHFsZThVT2pSeWJqdm5sOXBWMTNYYW4zS3F4bFpD?=
 =?utf-8?B?ZEJrNS82M2dJN1FndHlHR0ZHSnA0bXU2Sk1SWWEwZzdMVDIvZlk4bE5wNUFn?=
 =?utf-8?B?Z2pSczM0NzVlbHlIQkpjVm5uT1F3cFBUM2xZL2xBZXlEdnpkR3lWNmJsa2du?=
 =?utf-8?B?bzUwUk85ZERib3pkb1FCZUlWYWxldnpYc0NDakV1Tyt6VXBzMWVMbytVeUZJ?=
 =?utf-8?B?UEtqcU41TFVCZ3F3ZFRRZjhMTTZUa2FvMzlvZGtia1VHQ0x2dWRla1IrSE9z?=
 =?utf-8?B?ZFpvbE83bzJJL1VBNERVSkJhb0s4aWhNb3FxR1ZkekwzZWNOT254UXl2aFRl?=
 =?utf-8?B?MlZ0RGFCUjZtT3dkNDZudHdvOG9qOG1mZ1Nnamhxem9PaXBUSnJoc1puOVRZ?=
 =?utf-8?B?MXRZUHJyc0EwRWZSemtHRVhGVGFWcTJjdlAxeVdQcUdNc1ZvM3ZTR0xGamY0?=
 =?utf-8?B?ZlFzVC9kWUt2cWNVRU03SVVRZDNGWC9pNlF1azhBeUxYeGVSdUs0NEJOMXZQ?=
 =?utf-8?B?WE9QQXhnRmdaejlWdWZlWFZDMjFZb0ZjRUNkVnhrVlZvV1RvNnpDM3Q0RVlK?=
 =?utf-8?B?NWlyWnVnTXJJbzZGS0ViZlZzRVpIYkZjSERreHdQL05Ia0p2bnArNXY4Nldm?=
 =?utf-8?B?UWwzdDhWTVZmcklKUVg2V09zMmpJSGkzSm9kdFRrMXZBUFA4OFRPY1BzMGd4?=
 =?utf-8?B?d2M1anp0Y2JERldEOHRPN0JxVVV5VU9XR2V6NHRQRndaUU1nV3h4VDB3ZmtY?=
 =?utf-8?B?K0J6QXJKWm1jRlVSWnlGbVRBWkFnZVBaNGdTUnA1Q285S2FLdlhJT0NFMCs0?=
 =?utf-8?B?dHhMRy9vSjNpL0owOHFaZ3FLS3JjbmFkMEsxa0MxUGtoVzVseFpWM1hiLzZV?=
 =?utf-8?B?cVY4ZEY1OFVrMEpxVDRiMkloTmtJVWRkWkVqSmFSMDNlSmtzdWwyUHppck5L?=
 =?utf-8?B?anVzQTUzb3JjdHZZaFc0WEtPMDJVOEhiWHN1clE5cHhuZmJnbjhZK0psUUti?=
 =?utf-8?B?RkFSQWFXckJESzJUQ2N5NFdncEtPTHl2TmZjQWRHRTlWVWFFRkF1VGg3Nldr?=
 =?utf-8?B?OTZSSWRGL2NuR1owOXhmUW5ZaFQxWHh2Z2M2NGlqYXVoL3R1bU1JUVNlRFVh?=
 =?utf-8?B?cEtvSXVidHUzUXVUMmJlNnBlWmU1aWszMnYwditEMEdUT01EZ05lclI2Z01u?=
 =?utf-8?B?Y3J0aXpWamxQbFptamI1N0R6bVVtMytGWHEyTk16b295cGNzSERHRHpUaVlB?=
 =?utf-8?B?bU52VUIxSFRNOFh1eGI0RHN4TGFnYzl2RDRqakpQQnBYUkZtaFcyaFFyVmE3?=
 =?utf-8?B?WCtNZFBVNk9UVzJ6SlhRd1FaTXp5YTJwTlFLaHVhNHlreXRSa3I2MGlXL0RN?=
 =?utf-8?B?ZDhQSVZUdkNjdlE2VTV3QVA1QXl5TnZFTzVreUdLRW9uV2V0VXkyMVg3SzBy?=
 =?utf-8?B?N3ZSRm54c0MwV1Rpd3JLeDAxRkRKR2UxSmFBd3E2dHBZbmZBK0ZVZURTL0NL?=
 =?utf-8?Q?DGq9TnvHaOsIFABBlmAbOM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C8DF401D80614E80ACF364B5EE916D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef4eac2-d6ca-4544-6154-08d9c5e2531e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 07:03:29.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FtmY+/FjIMisORSlGtqC/CnMhDkbVUk1pgvIcPIEsGFwzNPXGQ93OGCMEujyMj7owH3wvvQeGt2kWKPUnyfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1711
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLAoKT24gVGh1LCAyMDIxLTEyLTIzIGF0IDAwOjA4ICswMTAwLCBNYXJjZWwgSG9s
dG1hbm4gd3JvdGU6Cj4gSGkgVGVkZCwKPiAKPiA+ID4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBi
cm9rZW4gTEVEIHF1aXJrIGZvciBJbnRlbCBsZWdhY3kgUk9NIGRldmljZXMuCj4gPiA+ID4gVG8g
Zml4IHRoZSBMRUQgaXNzdWUgdGhhdCBkb2Vzbid0IHR1cm4gb2ZmIGltbWVkaWF0ZWx5LCB0aGUg
aG9zdCBzZW5kcwo+ID4gPiA+IHRoZSBTVyBSRktJTEwgY29tbWFuZCB3aGlsZSBzaHV0dGluZyBk
b3duIHRoZSBpbnRlcmZhY2UgYW5kIGl0IHB1dHMgdGhlCj4gPiA+ID4gZGV2aWNlcyBpbiBhbiBh
c3NlcnRlZCBzdGF0ZS4KPiA+ID4gPiAKPiA+ID4gPiBPbmNlIHRoZSBkZXZpY2UgaXMgaW4gU1cg
UkZLSUxMIHN0YXRlLCBpdCBjYW4gb25seSBhY2NlcHQgSENJX1Jlc2V0IHRvCj4gPiA+ID4gZXhp
dCBmcm9tIHRoZSBTVyBSRktJTEwgc3RhdGUuIFRoaXMgcGF0Y2ggY2hlY2tzIHRoZSBxdWlyayBh
bmQgc2VuZHMgdGhlCj4gPiA+ID4gSENJX1Jlc2V0IGJlZm9yZSBzZW5kaW5nIHRoZSBIQ0lfSW50
ZWxfUmVhZF9WZXJzaW9uIGNvbW1hbmQuCj4gPiA+ID4gCj4gPiA+ID4gVGhlIGFmZmVjdGVkIGxl
Z2FjeSBST00gZGV2aWNlcyBhcmUKPiA+ID4gPiAtIDgwODc6MGEyYQo+ID4gPiA+IC0gODA4Nzow
YWE3Cj4gPiA+ID4gCj4gPiA+ID4gZml4ZXM6IGZmY2JhODI3YzBhMWQgKCJCbHVldG9vdGg6IGJ0
aW50ZWw6IEZpeCB0aGUgTEVEIGlzIG5vdCB0dXJuaW5nCj4gPiA+ID4gb2ZmCj4gPiA+ID4gaW1t
ZWRpYXRlbHkiKQo+ID4gPiA+IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRlZGQgSG8tSmVvbmcg
QW4gPHRlZGQuYW5AaW50ZWwuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IGRyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWwuYyB8IDEzICsrKysrKy0tLS0tLS0KPiA+ID4gPiBkcml2ZXJzL2JsdWV0b290
aC9idHVzYi5jwqDCoCB8IDEwICsrKysrKysrLS0KPiA+ID4gPiAyIGZpbGVzIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYwo+ID4gPiA+IGluZGV4IGUxZjk2ZGY4NDdiOC4uNzVmOGQ3YWNlYjM1IDEwMDY0NAo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ID4gPiA+IEBAIC0yMzU1LDggKzIzNTUsMTMgQEAgc3Rh
dGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0cnVjdCBoY2lfZGV2Cj4gPiA+ID4gKmhk
ZXYpCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIEFzIGEgd29ya2Fyb3VuZCwgc2VuZCBIQ0kg
UmVzZXQgY29tbWFuZCBmaXJzdCB3aGljaCB3aWxsCj4gPiA+ID4gcmVzZXQgdGhlCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoCAqIG51bWJlciBvZiBjb21wbGV0ZWQgY29tbWFuZHMgYW5kIGFsbG93
IG5vcm1hbCBjb21tYW5kCj4gPiA+ID4gcHJvY2Vzc2luZwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqAgKiBmcm9tIG5vdyBvbi4KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgKgo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoCAqIEZvciBJTlRFTF9CUk9LRU5fTEVELCB0aGVzZSBkZXZpY2VzIGhhdmUgYW4g
aXNzdWUgd2l0aCBMRUQKPiA+ID4gPiB3aGljaAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGRv
ZXNuJ3QgZ28gb2ZmIGltbWVkaWF0ZWx5IGR1cmluZyBzaHV0ZG93bi4gU2V0IHRoZSBmbGFnIGhl
cmUKPiA+ID4gPiB0bwo+ID4gPiA+IHNlbmQKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiB0aGUg
TEVEIE9GRiBjb21tYW5kIGR1cmluZyBzaHV0ZG93bi4KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCBpZiAoYnRpbnRlbF90ZXN0X2ZsYWcoaGRldiwgSU5U
RUxfQlJPS0VOX0lOSVRJQUxfTkNNRCkpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChidGlu
dGVsX3Rlc3RfZmxhZyhoZGV2LCBJTlRFTF9CUk9LRU5fSU5JVElBTF9OQ01EKSB8fAo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnRpbnRlbF90ZXN0X2ZsYWcoaGRldiwKPiA+ID4gPiBJTlRFTF9CUk9LRU5fTEVEKSkg
ewo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBza2IgPSBfX2hjaV9jbWRf
c3luYyhoZGV2LCBIQ0lfT1BfUkVTRVQsIDAsIE5VTEwsCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhDSV9JTklUX1RJTUVPVVQpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoSVNfRVJSKHNrYikpIHsKPiA+ID4gPiBAQCAtMjQyOCwxMiArMjQzMyw2IEBAIHN0YXRp
YyBpbnQgYnRpbnRlbF9zZXR1cF9jb21iaW5lZChzdHJ1Y3QgaGNpX2Rldgo+ID4gPiA+ICpoZGV2
KQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gc2V0X2JpdChIQ0lfUVVJUktfV0lERUJBTkRfU1BFRUNI
X1NVUFBPUlRFRCwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmhkZXYtPnF1aXJrcyk7
Cj4gPiA+ID4gCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIFRoZXNlIGRldmljZXMgaGF2ZSBhbiBpc3N1ZSB3aXRoIExFRCB3aGljaAo+ID4g
PiA+IGRvZXNuJ3QKPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGdvIG9mZiBpbW1lZGlhdGVseSBkdXJpbmcgc2h1dGRvd24uIFNldCB0aGUK
PiA+ID4gPiBmbGFnCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBoZXJlIHRvIHNlbmQgdGhlIExFRCBPRkYgY29tbWFuZCBkdXJpbmcKPiA+
ID4gPiBzaHV0ZG93bi4KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqLwo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBidGludGVsX3NldF9mbGFnKGhkZXYsIElOVEVMX0JST0tFTl9MRUQpOwo+
ID4gPiA+IC0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVyciA9IGJ0aW50ZWxfbGVnYWN5X3JvbV9zZXR1cChoZGV2LCAmdmVyKTsKPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDB4MGI6wqDCoMKgwqDC
oCAvKiBTZlAgKi8KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2Iu
YyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKPiA+ID4gPiBpbmRleCBkMWJkOWVlMGE2YWIu
LmM2YTA3MGQ1Mjg0ZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVz
Yi5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwo+ID4gPiA+IEBAIC02
MCw2ICs2MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2RyaXZlciBidHVzYl9kcml2ZXI7Cj4gPiA+
ID4gI2RlZmluZSBCVFVTQl9XSURFQkFORF9TUEVFQ0jCoMKgIDB4NDAwMDAwCj4gPiA+ID4gI2Rl
ZmluZSBCVFVTQl9WQUxJRF9MRV9TVEFURVPCoMKgIDB4ODAwMDAwCj4gPiA+ID4gI2RlZmluZSBC
VFVTQl9RQ0FfV0NONjg1NcKgwqDCoMKgwqDCoCAweDEwMDAwMDAKPiA+ID4gPiArI2RlZmluZSBC
VFVTQl9JTlRFTF9CUk9LRU5fTEVEIDB4MjAwMDAwMAo+ID4gPiA+ICNkZWZpbmUgQlRVU0JfSU5U
RUxfQlJPS0VOX0lOSVRJQUxfTkNNRCAweDQwMDAwMDAKPiA+ID4gPiAKPiA+ID4gPiBzdGF0aWMg
Y29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgYnR1c2JfdGFibGVbXSA9IHsKPiA+ID4gPiBAQCAt
MzgyLDkgKzM4MywxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgYmxhY2ts
aXN0X3RhYmxlW10KPiA+ID4gPiA9IHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJ
Q0UoMHg4MDg3LCAweDA3ZGEpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9DU1IgfSwKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDA3ZGMpLCAuZHJpdmVyX2luZm8g
PQo+ID4gPiA+IEJUVVNCX0lOVEVMX0NPTUJJTkVEIHwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gPiA+ID4gQlRVU0JfSU5URUxfQlJPS0VO
X0lOSVRJQUxfTkNNRCB9LAo+ID4gPiA+IC3CoMKgwqDCoMKgwqAgeyBVU0JfREVWSUNFKDB4ODA4
NywgMHgwYTJhKSwgLmRyaXZlcl9pbmZvID0KPiA+ID4gPiBCVFVTQl9JTlRFTF9DT01CSU5FRCB9
LAo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgeyBVU0JfREVWSUNFKDB4ODA4NywgMHgwYTJhKSwgLmRy
aXZlcl9pbmZvID0KPiA+ID4gPiBCVFVTQl9JTlRFTF9DT01CSU5FRCB8Cj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+IEJUVVNCX0lO
VEVMX0JST0tFTl9MRUQgfSwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4
MDg3LCAweDBhMmIpLCAuZHJpdmVyX2luZm8gPQo+ID4gPiA+IEJUVVNCX0lOVEVMX0NPTUJJTkVE
IH0sCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhYTcpLCAu
ZHJpdmVyX2luZm8gPQo+ID4gPiA+IEJUVVNCX0lOVEVMX0NPTUJJTkVEIH0sCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhYTcpLCAuZHJpdmVyX2luZm8gPQo+
ID4gPiA+IEJUVVNCX0lOVEVMX0NPTUJJTkVEIHwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gQlRVU0JfSU5URUxfQlJPS0VOX0xF
RCB9LAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHsgVVNCX0RFVklDRSgweDgwODcsIDB4MGFhYSks
IC5kcml2ZXJfaW5mbyA9Cj4gPiA+ID4gQlRVU0JfSU5URUxfQ09NQklORUQgfSwKPiA+ID4gCj4g
PiA+IHRoaXMgaXMgdGhlIHBhcnQgdGhhdCBJIHRyaWVkIHRvIGF2b2lkLgo+ID4gCj4gPiBJIHJl
bWVtYmVyZWQgaXQgYnV0IEkgY291bGRuJ3QgZmluZCBhbnkgb3RoZXIgd2F5LiAKPiA+IAo+ID4g
SSBhbHJlYWR5IHRyaWVkIHRoZSBtZXRob2QgYmVsb3cgYnV0IGl0IGRpZG4ndCB3b3JrIGVzcGVj
aWFsbHkgZm9yIHRoZQo+ID4gcmVib290Cj4gPiAod2FybSBib290KSBjYXNlIGJlY2FzZSB0aGUg
cGxhdGZvcm0ga2VlcHMgdGhlIFVTQiBwb3dlciB3aGlsZSByZWJvb3RpbmcgdGhlCj4gPiBzeXN0
ZW0gYW5kIEJUIGRldmljZSBpcyBzdGlsbCBpbiB0aGUgU1cgUkZLSUxMIHN0YXRlLiAKPiA+IFRo
ZSBmbGFnIHNldHMgaW4gdGhlIGJ0aW50ZWxfc2h1dGRvd25fY29tYmluZWQoKSBkb2Vzbid0IHN0
YXkgYmVjYXVzZSB0aGUKPiA+IEhERVYKPiA+IGFuZCB0aGUgZHJpdmVyIGRhdGEgYXJlIGZyZWVk
IGFuZCBhbGxvY2F0ZWQgYWdhaW4gd2hpbGUgcmVib290aW5nLiBTbyB0aGUKPiA+IGludGVsX2Zs
YWdfdGVzdF9hbmRfY2xlYXIoSU5URUxfU0hVVERPV05fRVhFQ1VURUQpIGlzIG5ldmVyIFRSVUUu
Cj4gCj4gdGhpcyBpcyB0aGUgcGFydCB0aGF0IEkgZG9u4oCZdCBncm9rLiBTbyBob3cgZG8gd2Ug
cmVzZXQgdGhlIFVTQiBwb3dlciB3aGlsZQo+IHN0aWxsIGtlZXBpbmcgaXQuIERvZXMgdGhpcyBt
ZWFuIHdlIHNlZSBhIFVTQiBEaXNjb25uZWN0IGFuZCBVU0IgUmVjb25uZWN0Cj4gaGFwcGVuaW5n
LCBidXQgdGhlIHNlY29uZCB0aW1lIGFyb3VuZCB3ZSBlbnRlciBidHVzYl9wcm9iZSgpIHdlIGNv
bWUgZnJvbSBhCj4gdG90YWwgZGlmZmVyZW50IHN0YXRlPwo+IAo+IEFuZCBob3cgZG9lcyBpdCBt
YWtlIHNlbnNlIHRoYXQgY2FsbGluZyBoZGV2LT5zaHV0ZG93bigpIGVuZHMgdXAgaW4KPiBidHVz
Yl9yZW1vdmUoKSArIGJ0dXNiX3Byb2JlKCkuIEkgYW0gY29uZnVzZWQuCgpJIHRoaW5rIEkgZGlk
bid0IGV4cGxhbiB0aGUgdGVzdCBjYXNlIGVub3VnaC4gVGhlcmUgaXMgbm8gaXNzdWUgaWYgdGhl
IEhDSSBpcyB1cApiZWZvcmUgcmVib290aW5nIHRoZSBzeXN0ZW0uIFRoZSBpc3N1ZSBpcyByZXBy
b2R1Y2libGUgb25seSB3aGVuIHRoZSBIQ0kKaW50ZXJmYWNlIGlzIGRvd24gYW5kIHJlYm9vdC4K
CkZvciBleGFtcGxlLCB0aGUgc3RlcHMgYXJlOgoxLiBCbHVldG9vdGggZGFlbW9uIGlzIG5vdCBy
dW5uaW5nIChhY3R1YWxseSBpdCBkb2Vzbid0IG1hdHRlcikKMi4gUHV0IEhDSSBEb3duIGFuZCBp
dCBjYXVzZXMgaGRldi0+c2h1dGRvd24oKS0+YnRpbnRlbF9zaHV0ZG93bl9jb21iaW5lZCgpCjMu
IE5vdyBTdFAgaXMgaW4gU1cgUkZLSUxMIHN0YXRlCjQuIFJlYm9vdAo1LiBidGludGVsX3NldHVw
X2NvbWJpbmVkKCkgaXMgY2FsbGVkCjYuIEhDSV9JbnRlbF9SZWFkX1ZlcnNpb24gY29tbWFuZCBm
YWlsZWQuCgpTbywgdGhlIGZsYWcgdmFsdWUgc2V0IGJlZm9yZSB0aGUgcmVib290IGlzIG5vIGxv
bmdlciBhdmFpbGFibGUvdmFsaWQgYWZ0ZXIKcmVib290LiBBbHNvLCB3aGlsZSByZWJvb3Rpbmcs
IEkgZG9uJ3Qgc2VlIFVTQiBkaXNjb25uZWN0IGFuZMKgdGhlIGRldmljZSBzdGF0ZQppcyBzYW1l
IGFzIGJlZm9yZSB0aGUgcmVib290LgoKPiAKPiBSZWdhcmRzCj4gCj4gTWFyY2VsCj4gCgo=
