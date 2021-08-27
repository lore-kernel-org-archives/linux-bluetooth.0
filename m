Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E389C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 06:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A2660F92
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 06:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbhH0GeQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:34:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:52702 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244305AbhH0GeP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 02:34:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="278918286"
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="278918286"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 23:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="495545725"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2021 23:33:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 26 Aug 2021 23:33:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 26 Aug 2021 23:33:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 26 Aug 2021 23:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSxGGaqvQZ8fXluU+a/7Pp7FaFjVV3v30doCCc/WdQjncDmaoM37XAoYH+h6STNteyYivW/5oWQKkcM8QFpYp8DgZ/H515DcjCjJA92ixiZOoGJdhEf4YeEp0L+4Zzx5U8Ub0XI8O3e0+vI9/lNQaOMledfXtJu1ryymv/2D3t1GAkxxWAAuIcHclT74wJixWEgApZyXO5jlHlceaRIp2ioJ8BAYiQ1ySrxt16lfSHW20sxOkbd1bni4ziOqFxFSMz2EitI5H1kRVm8AOL5ktpRW7yXRCssvKuZPnMu0K9xFtOlpGpKU4RZZO22JZuTTh9Iy4u8itEpWz2HXq9aTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaN/YfRyx4/RXG6xe75ddrTgwLX77Tz452+RoX8VOI8=;
 b=W0hs0brJnvoDsXiGP9tb++tXA+xbInX63JEuweOSCN3yoNjflJewzl3lXvsrW2fsfUxA8I1ThEAn8wKio6FTTgu0QpadHN1kn6UG3ExWGXg8aTFRCdRy62kcBD+zFBP9OW2ck5e1Il5ovOiRTqEPm4WxO6Uk5Ag4ktFQqsl+Mx/fJ+LR/Y32rK24pRbByMkKxVpVI+7hQ1AbeiYrut4pL4JozlSucIc6qdOsuGpq6l+tIF2CyVBE/dAmwVBZ/zVzPl6VaiERAymO/3BgaRyc63uy38PxqoUqkDRpQlWuxcLKYdoESswI4lWlbreP86ah+rIa8PcfhODjZDlFzIcIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaN/YfRyx4/RXG6xe75ddrTgwLX77Tz452+RoX8VOI8=;
 b=yPy7UHyjkEwCIYd2MlqCXVYSa/y+UKQbcN15NtGLg4zVk2I4EpqEqOOC4SNb/59N4p9jSo7/grRHDrFEFYlMlr6gLFHl3h3zGew5VEi3S7yDJX3KuTqC95v8HmIB/bkEyh3gTlg6SR49PoDdLhqmhXQqOLCV0KZsxWrSYUfEY2A=
Received: from MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9)
 by MN2PR11MB4509.namprd11.prod.outlook.com (2603:10b6:208:192::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Fri, 27 Aug
 2021 06:33:18 +0000
Received: from MN2PR11MB4551.namprd11.prod.outlook.com
 ([fe80::e906:1b7f:589c:59e3]) by MN2PR11MB4551.namprd11.prod.outlook.com
 ([fe80::e906:1b7f:589c:59e3%5]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 06:33:18 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "raulpblooper@gmail.com" <raulpblooper@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Which tool to use for Mesh Testing
Thread-Topic: Which tool to use for Mesh Testing
Thread-Index: AQHXmRN2MBnhu+DJzECAJY2hshr6YauG6K+A
Date:   Fri, 27 Aug 2021 06:33:18 +0000
Message-ID: <105cf340892caf0014eb154335784d8c46b8eb6e.camel@intel.com>
References: <CAEwN+MAuLad-9jh0fb7-ZDN6kSGORf7Rd1HffGV4VpThkP=Rng@mail.gmail.com>
In-Reply-To: <CAEwN+MAuLad-9jh0fb7-ZDN6kSGORf7Rd1HffGV4VpThkP=Rng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be277ac9-0a63-46fc-e3c2-08d969248f0e
x-ms-traffictypediagnostic: MN2PR11MB4509:
x-microsoft-antispam-prvs: <MN2PR11MB4509A84D32300BE0C6A96A21FBC89@MN2PR11MB4509.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hfvq9uiKwiJzozgkeOv3NtMcjDxiPlwab0rlz/UZQrI/xz9U4QUdxKOnNCY1v0zC3rw06PsqnSEWyaHe6RaQ2LuF8bcvmgl58luqs/egltlE3n1jZzsoWib0gkOY1d0xIkIdQF3nLFLww6+qIR/EC3s5fzh12Tzgs+Mupi0K+zVN3lUR5QzGT8M4C6SzV0RxFPJ4pGgt4w0dDt+NJcYQo6Qmp/Qe9940Gg0gDy4W010GUvtVAD9YndzjzO+uuV37YMHarNHak8RQc7G+wGhMxyzIZmbxTuKNjNqOjF3K9aZz7GRulfP9GoW18WF3xMiQ6J96hE7tvAKGik3FAh2FARAtmkDNIkOrhAHw5KPkXKHx240/yLMFns8X/pGsctrR59XxhVepfJw9uIWTf6nY7ik0WAc5pc1RXq1PTNXAoOaoy2FTwU2bQSJoPsmslVr4meYGnyLdIGV5XwEK7KwLdfEfYtQ25uCLLfK1h8o3i6ekC+DbWH/O6Fa7RpPzIXaINV4tk5EYkuDfBSUXJpXLR8bgoyKaZVWFaegUJTOghQtPqTmmdW7gSfCvLS0ekFjsFzMcwfd4yTx2FER2FF5ELZu02EzPUkFciu5uwiOcmv1H8QNYt1LIPpCCm8aWEBw2lEBcON4oJiM5hb8Kz+5lolh9G7rLHCnkFYcXN3gg9mm5UObJnqGZwvLawvxboc4u997VgGcp0/GLzj1QeDE3bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4551.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(36756003)(64756008)(6916009)(186003)(4744005)(38070700005)(6506007)(26005)(71200400001)(66556008)(38100700002)(66476007)(5660300002)(86362001)(122000001)(4326008)(6512007)(66446008)(91956017)(2616005)(6486002)(76116006)(8676002)(2906002)(83380400001)(8936002)(478600001)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUx2WDZIZGdENjdVNE9BcjRzOTNyTHlSclBueEtKWk9jS1BhRUtWS2s0djJi?=
 =?utf-8?B?eUdVbkhSQkhDaWtHTWxURTV1UXA5aUpnWFpyaytyQTVwc2w3TkVGTEJaSGhX?=
 =?utf-8?B?VDVKaG14eWw4Y1EwT2RxNFpWYWpYRkFFbU1PcWJpODYxSUYwbUlBSmViYjlq?=
 =?utf-8?B?ckI1RkVYVDFWaVYra1R5Z0ZYenJiRmRwbGVBaDJobC9vMS9oak4xYVZxdGow?=
 =?utf-8?B?bDFhRVl4TS9EcENVa1RZdUhPaVd4eEFaQlo1MEEzQndjd2tpTFJtUmpydW1S?=
 =?utf-8?B?ZUtDbkRKdDlBaDBOWFRHL3lIUktVMDZQMkt4eEJicTBNL2NiakVsVzlOWkZX?=
 =?utf-8?B?T0FLMmxKaDRCQkk4K0dNWFhkQ0hpV0I0S2N6ekw4NEZYb0RsajhMVkllaTQ2?=
 =?utf-8?B?bXp4OEdVWWtsaHFTNnIycWlQVmwzMFh6VFcyTWN5eXZlTE9VRGVsOS9yejYr?=
 =?utf-8?B?TUZGQmxESXFWN0pwSW1NODVYU1dwaUlEbUFrdnVXR25BREV6bnVhTWRmSS9S?=
 =?utf-8?B?bmJTbE5ETzI0RkR3V3Rob0MxSTE2c3lMd1FmeHpBTXE1bVg4MGlGV0NaVEJX?=
 =?utf-8?B?ZWhWVlhXQXkxQVd6MlNYUGVGNGh6b3VOTGNpa1J4N0o3SUV3TURQZVNuMURW?=
 =?utf-8?B?TzdMMEF4bGdkNWlEb1BjbWNLT2dLdXgycXdNbS9HV1lPdWNPZDRPVXBUMHYw?=
 =?utf-8?B?SjZlYXFZeGVXemVBajdIczdVbXUxNmRaM3dadWplRjdsSWtlbWM2c1hWNHV5?=
 =?utf-8?B?anZCREJYNlBHaS90UjVjeWwzZEdhUkNCazlMSnJwVTNTeE0wUU1vZnlDbVNK?=
 =?utf-8?B?bnMxVlBPTDBISW11Q0NqcHczWXpHQjhXb280dDJTNlQ1eUdIWTVvWnJTRXhp?=
 =?utf-8?B?Zm9HWk1KSmJ6bmQzblhwcHdIVlZWajhLTGxMcDZ3N2ozaWIvM3VBUTVvcXBU?=
 =?utf-8?B?NzlCRDVqRERmajV4SUY2YmpUU0ZWQnlwcjdRbG51NEd6Q2tKOU9naUxtS1pk?=
 =?utf-8?B?UnNuT3JEUUFTZ1Y0VExGRjBMTm5lUHUrQ2FVL1QwZ3VVZGdsL0FwdndqRzQ1?=
 =?utf-8?B?djZrVU9uTFg1NVRXQnV6RThJTzVkNXZMMzVJM1k0UldnQXp1MGdQWWUyMWdV?=
 =?utf-8?B?K1dqOVVTeW9DTUsydXR3cXlYZ2syV1BqWTNQSU9EZ3BFclZ4bmxMKzRBajhT?=
 =?utf-8?B?a0t3cGJveW55TzM1b0treXB1Q1ZjVTl5ODFoYmtlMlZLNkV4UDRlNkJTamps?=
 =?utf-8?B?VEduYnJaTHRXc2ltSTRBNjhQZ2JoNk5kd1FaRVppaEJtbmQ1OWF1NzZGdHow?=
 =?utf-8?B?WWFQVHdBM1MxcEF5OTlpdEtDUzdGVGNwY1BtV0xNK2ppeEJnQ3cxSC82TU4x?=
 =?utf-8?B?czBibDZWWTNreW5hMXErYzFlOVplbzh1aWozMnVtOEhPRzdKUEpyTmx3VEhi?=
 =?utf-8?B?R0JDbStoNHI2UGtUcXhuNXhQbzd0b3l6TTBRWU44ZGJZQkYyRW1WMkNLbitZ?=
 =?utf-8?B?RUVYUExRdFZJZDRneU5uZ1VtOUYxTHIrTENVNzIycDNQaEtIb2RMV3E4UFRX?=
 =?utf-8?B?UGxYMUdpaDhtdGpYQUVLT0FtTVhaY25INXRIM295ZXhLejlUYzhVN3E0dS92?=
 =?utf-8?B?VG9sd2dFT2lVbnFRUXgvVUJOU2QvZzIxaHdkWnFMZnNuYnBtUmFwUjQzb21m?=
 =?utf-8?B?THlhZ0pKZ2IrcHZ6aHhRakRBLzhNRmZkenRHM2pGYlJhVU5wVUpTa01acVR1?=
 =?utf-8?Q?NKVLPXAzQYgd12pNaBglCcleglsr623LcSBsV81?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAADEE6433DED448B54271981BDB63A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4551.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be277ac9-0a63-46fc-e3c2-08d969248f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 06:33:18.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eVSKI06qcN5IV3jgeOuwAGSo6Yi+Xqzw6rAaUGoL8WRiB3gUClUwQmLD8n3dHbVldol24CutWAClWEzBo10tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4509
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUmF1bCwNCg0KT24gVHVlLCAyMDIxLTA4LTI0IGF0IDIzOjQwICswNTMwLCBSYXVsIFBpcGVy
IHdyb3RlOg0KPiBIZWxsbyAsDQo+IFdoaWNoIHRvb2wgSSBjYW4gdXNlIGZvciBCbGUgTWVzaCB0
ZXN0aW5nLCBtZXNoY3RsIG9yIGdhdHQtbWVzaCBvcg0KPiBhbnkNCj4gb3RoZXIgPyBJIGZvbGxv
d2VkIGZldyBtYWlscyBhbmQgY2FtZSB0byBrbm93IG1lc2hjdGwgaXMgbm90IGZpdCBmb3INCj4g
dXNlLiBQbGVhc2UgYWR2aWNlLg0KPiBJIHdhbnQgdG8gdGVzdCBib3RoIFBCLUFEViBhbmQgUEIt
R0FUVC4NCj4gVGhhbmtzIGluIGFkdmFuY2UgIQ0KPiBSZWdhcmRzLA0KPiBScA0KDQpQbGVhc2Ug
dXNlIHRvb2xzL21lc2gtY2ZnY2xpZW50IHRvIHRlc3Qgd2l0aCBQQi1BRFYuIFlvdSBjYW4gdXNl
IGl0IHRvDQpwcm92aXNpb24gYW5kIGNvbmZpZ3VyZSBtZXNoIG5vZGVzLg0KVGhlcmUgaXMgYWxz
byBhIHB5dGhvbi1iYXNlZCB0b29sOiB0ZXN0L3Rlc3QtbWVzaCB0aGF0IGltcGxlbWVudHMNCm9u
L29mZiBtb2RlbCBhbmQgY291bGQgYmUgcHJvdmlzaW9uZWQgYXMgYSBtZXNoIG5vZGUgdXNpbmcg
bWVzaC0NCmNmZ2NsaWVudC4NCg0KQXMgZm9yIFBCLUdBVFQsIG1lc2hjdGwgd291bGQgYmUgdGhl
IHRvb2wgZm9yIHRoYXQsIEJVVCBpdCBoYXNuJ3QgYmVlbg0KdXBkYXRlZCBpbiBhIGxvbmcgd2hp
bGUsIGFuZCBJIGRvbid0IGV4cGVjdCBpdCB0byBiZSBmdW5jdGlvbmFsLg0KDQpSZWdhcmRzLA0K
SW5nYQ0K
