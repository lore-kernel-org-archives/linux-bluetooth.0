Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Dec 2021 01:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhLYBSU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Dec 2021 20:18:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:12566 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhLYBST (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Dec 2021 20:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640395099; x=1671931099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PThE33aNL5q0PsvrEskIci/da0gvuVF3BMLPsdoPhD4=;
  b=e3zidtQNQvrTuGT7XHePW67KJzIuNYspUEUS/FVrAppZvRDffkwGkyYS
   OwBQZ6wAXTelTdDH0u/848JcyEPXAduSvGnSRvAAUevBH+uaP3uGuYX6K
   7zq1AvYZkFGPui5rhJCE5/05ChsOCjmSjto6LpWzWp58TDpmffB3aT3jW
   Un898Xil4mF5nXA8CN+84zoQcM88zCMSdwehFnxIRUonbcoQFhDGzKlUm
   lY4vRi+nxGP1udBRH0XyffM9KAc25A211MvuIGP3MM5MiCdT9B2P4WdJR
   BnESOauKT5AIoCVZ2AqdDTq0gcnE8iVlS2FBYtOwpbFCSynqt6+uOEfuv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="301778028"
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="301778028"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 17:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="552199974"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 24 Dec 2021 17:18:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 17:18:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 17:18:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 24 Dec 2021 17:18:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 24 Dec 2021 17:18:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvwbMkAo6rkLwMjLmbLwXW/n2Q6i/nM0KdxWkPunIADwrDHbsB8zk3Cvuh4S7NbPKoi7DvHWHwLave7M2REkUBx0vprqbJM2jJ8YG50xMHwmIXx0VViwXw5vO8NfYYu04L19jmLEnBPaNSu8FSnJ9xq+z+kgonVfwf8HoxpIVakp2j+aHtFe0Jk39iJvbCnl6++PaUJyR3vB59YtdtLaqR40ABbXR5MELx7vNw0JylgAG39yusCwvc0GPl+LCLyD9Phn64+lea+0wPJcGQzRnnKGVV0cyOCeYucLMm7bvcx0gbR/s0dss6rENUa8nlNqnE5tnpR8LB9M6UhtAPpMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PThE33aNL5q0PsvrEskIci/da0gvuVF3BMLPsdoPhD4=;
 b=KqPCjrvRrRXtMPGxLVxcCRFbMUmDvs0z5tNjb4pw4BuAEvnN7XOOitxixG+5L3lBMPTU/novD8F23UyxwuGzS+zra9QywVIF/6hE+yPpWPbTkRjHV+PHm27ppK/e7UpOUwpUL9wq2l9WNnEgyC+jx8FB2Ar0GjJxGsi3Rj3pdINly9cSM9vuzhBUV74E3K1qRFtJ3QZLUKor4wCByOhRsYLtTIN/HOkGLPWzOs+jIbilBs83VVvLJroIVnV3PRkyegmeL+oAINaGbNjUSA0SQTZaIbCebDmQ2CDVeGxWPHIgoppH46D2IQQtjhJnpVXRNQFSKHsnqFLXxxCgvNWy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB2046.namprd11.prod.outlook.com (2603:10b6:300:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Sat, 25 Dec
 2021 01:18:10 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f%5]) with mapi id 15.20.4823.021; Sat, 25 Dec 2021
 01:18:10 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Topic: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Index: AQHX8sFUOehkja9FU0C9xWapVmNOIKw+MCkAgAD3iQCAAARoAIAAhMIAgAAZ+gCAAMdnAIAADx2AgAHTsYA=
Date:   Sat, 25 Dec 2021 01:18:10 +0000
Message-ID: <20f68eb75538796fb0e69b45543e151b3fd04bae.camel@intel.com>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
         <B5187291-3173-4BFB-8465-25AB75BA328E@holtmann.org>
         <39a9b9c68cdb9fbf32f3c6023c0272b53d37d668.camel@intel.com>
         <768826DA-51CF-4EA2-B582-89BFE843EBAE@holtmann.org>
         <f1ffad7eebc385d43f4f48d138021860f8e582cd.camel@intel.com>
         <F93FE723-881E-45D6-8A43-379B0ABAC363@holtmann.org>
         <5b0ddedd9c6c119d4c3c4b65adaabe5d86bd166f.camel@intel.com>
         <6EBC0BA5-E39D-4C9F-849D-C7972BDD9582@holtmann.org>
In-Reply-To: <6EBC0BA5-E39D-4C9F-849D-C7972BDD9582@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8abd3791-7735-495d-9c44-08d9c7446a39
x-ms-traffictypediagnostic: MWHPR11MB2046:EE_
x-microsoft-antispam-prvs: <MWHPR11MB20461E50150E1C9AC068FE97FF409@MWHPR11MB2046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYb1SfMfDvhWrBcQ39M6iUp6FMRlrS74Wugx3xHUYtkaL9kui9iYnfCZLdxeVsuMcPSdeCVHJhuy+TAziKpHCAqMQJZVvNuz+OH95Yj1El+38+Axn4+j5/Yyt6hkxrr6f5MCNbzGU/uNmsSgi8yhpJ4D6WBLkJyCStEZOPWy8spE7tLzwPoUv5g4RU9gLwvcS+FFZXrbzH4IMkKiJJQlihfVSrPgUadxMf1SKM8mcs59N3X1cnRzCy72pkEyPi218utYK9CXRK0AJ4s8NlmJQKCKK0lXsTIq2ipxt/8dQnBVuomoz2cLeRyePZ1V9lrCEKbWCWiGsJ6bunbZcRhBrI9wTprQ6Zp9isDMVKjJJpwO64CQqT4/emkn82CT+qbJZvRYp6/fnaWEhYn7+EqYMwbm5Tsc0GDUluiKUOq6v+dDSXJhJ43xsBxMbSEcM8ry2YZyyb79wqqdy01ZBE74K7Ot37ooctpnXdleZlczyy38ieFofsOzIW4d2DQ+aQyY47nqmMg6nwfmxrMZ4I5JrkOa/qW8Xi6H70znRMdz0iUPaBuBnmqvQFeOxwk9SKSZs7T6OfDwkz/R7vAXeJ2lwfpJS5i7cwpyE9Yuey8Bw1/X0ji1L1kw7O/Ts+NwhC/sAArvz9IvXlyO8PU9VUd5QziXSspDLre4Rok3y2uBJ7nN6O8fJR1lUoGxp/7dM07JECN1D/isUVFOwMiAVcssAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(6512007)(54906003)(8936002)(64756008)(66446008)(6486002)(66556008)(76116006)(4326008)(316002)(66946007)(71200400001)(83380400001)(5660300002)(508600001)(186003)(26005)(8676002)(2906002)(36756003)(82960400001)(86362001)(122000001)(38100700002)(6916009)(4001150100001)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlVEbVBHWXpNNVc2OFRFSHRWUnJISG93QTF1SUs1YUtXamNwRlpLUXpiWm5Z?=
 =?utf-8?B?bHBpOGVhZDFWTTdGd3dMYW5QNGJnS0JmV2dBVkVCcDZnNTI5V3AzN2F1djd3?=
 =?utf-8?B?RUFJeGdwdFhzZVVveEp4MzluYnk4K3hYamQxamZDSytuZTlYZGc0bmlsU1dm?=
 =?utf-8?B?Wk1lSnRIVStDekx6YUtIeUllM0VZaElQd09leFJkNkhJRCs2Q3JoYlRFWkNF?=
 =?utf-8?B?RXFWaXpHQlNQZ3J0OTRpM3psd0QzTnMxUDc2N3NqTWVsbFpQRDM3dytodG0z?=
 =?utf-8?B?WEZIL1F3dDU3YnBrMEVxUGZrYjkvZHoyTStIcWtzTHNxUWlPeWlQbGxkdllQ?=
 =?utf-8?B?ZTlob2dWOXMzaWJsKzJUOWpHVndOdmxnYmgva2x2K0pBdVAzMVdIeTB5djFj?=
 =?utf-8?B?VEp3WDJjZk5NRnBLL0d1R3owRVhVM0xZWDE3U0tRMU9KZjNNVXBXeUp5Sk9r?=
 =?utf-8?B?QUl4WjVCZU9weVY3UThEejBqcEE4Y1dmNDVOeE40Q3lUZzNrYzUzMHltbmNw?=
 =?utf-8?B?bTZEbnhIa1I3NDF5aVpIS3ZxekZBeWNYZXZkalJJV3NPeWROaHJaVytUWVg5?=
 =?utf-8?B?SWVBVVd0ditwQytxSlZ2VWNpYVJGUXBna3pBTXFpTFhoczZEUUE0bkFuMG84?=
 =?utf-8?B?aWhuUkQyV2JwVEhoZGlFYnlrdFRMbzdNVVZIZDBvYnQ0VXZFSHp0RjA0UzYv?=
 =?utf-8?B?aHdUeTVSQ25NSTJxN1p0ODZ5VDZEZWpWbFI3MzBDdU93Ni9VL3U1SzV1ZTlI?=
 =?utf-8?B?RGU1T2J1UDBiWVlJYjd2RUY5cXVDMUVKaGtKeFBIRThNSStGR2VvUitRS3ZR?=
 =?utf-8?B?eHpySmEzS3hnek4rb3F4c01LdnlIVW5xeEJIbDd3eTFlYmhNSVJLSXo3Y0Rw?=
 =?utf-8?B?ZWpHcTZCOU9nRzRKbHpOZ1A3VTlIQzVjUDIzcFdIbkxaT0N4RWplbmt4ejYv?=
 =?utf-8?B?bC80OEU5cjZ3TGRaS0VNWThaZUlkTGZTM2hCYzMxRUF6WVNFR2RwT2IxSzFa?=
 =?utf-8?B?dHZZajBpVS9UMkc5cGNLNTcwY0lQMk8vT1BwWnZIYTRwb0F4RTA4dEFaME5C?=
 =?utf-8?B?U2hKRzlxV0gwL2tUUzRYS2lOcTlWRVBMNUNjM3JnZDJLdWQxbTJMU0VjMnJy?=
 =?utf-8?B?UUZIaTNmNjNIR2RHcGdrMHJCS2xkK2FMeHR0S0I5TjUra2lUU0pFM3RWVEFL?=
 =?utf-8?B?dk5NVkpBTzROU3VTUDQvZ3hPYkcrVGJlWUdKSjBUWDlyU2svdkpGcVZPQ1FJ?=
 =?utf-8?B?RVJXUFJ0SHNCQU4yQnRycWF3bXZTSVhYbUR4R1cwUnVvbVlTWUdVY2c3M1ND?=
 =?utf-8?B?RGpKZmM0aWpVajI4c01GcHdLRnNRQi9YWlZSai9zVE1IaGRLS2RGVEw1TDlN?=
 =?utf-8?B?RHdISlY0Zlp4VEdUTm1sWkZ5cU5ySnRtNkhQazBiOEVoSUV5YzJQaXhjdCtI?=
 =?utf-8?B?K0QvaWp6MGExcHJNbEsxSXBuYU4zdDJDV2hkSG5qa2lqV1l2MnVqMUxiVmpQ?=
 =?utf-8?B?YS9rd3N1SHVzeUJNZkVGTk1xWHIzK3IwRk43dmxoWWRPbis1YlRGMjFWZnpP?=
 =?utf-8?B?ZkU0cUN6WHRKdFdyVkhyNklkd0V2M3Q5eU94OWlSbW0yUVV6YXQ4aFA1dkw1?=
 =?utf-8?B?SWhLaHNQTWNuYzcrdW1hNEpBVWpJcCtxL3FTQm9ncml4ZC9URmVnVlp5aW4z?=
 =?utf-8?B?Y3NXcmNpVGtFcTNhcEdYSlprdHBJeVpnSHc5b1hzWjNVZDJDVkhnenNPUTlT?=
 =?utf-8?B?NlVWd2czYytZbGxkU05MZTA0L3ZVSTl2d2I3ZWhRWXViNmhBZWVnUjZLN3pR?=
 =?utf-8?B?Y0dnQVBEWEpmTW1JZ09wR1B2ZEQyYUx2dnVMb2dGZzB3aXdsVWIzb0xUNjI1?=
 =?utf-8?B?UjdaN1hwaVJ4UVdRSks0VldtQ0lZNkdhMWlGcXhVZWs1cWYrZ09SQlVCd2lk?=
 =?utf-8?B?K2RuZ3BnRjloUmFSUjc3Z3c1YmV0QW1EaVRBRkVFcHdFdmpxdEx5YVQyakNT?=
 =?utf-8?B?djQ5dms5RnNhRnVRTERtUkZUWldlUmJhU0lWaDRzRVdTS3NsREdPN1JhVkp5?=
 =?utf-8?B?bFJaNjltOTRyM2t3YTBNUVEvbTFjQkNpTG1pMXhqbUJTMHF0SWpIWjFjbUpG?=
 =?utf-8?B?MTNkOUNMN1FJdnpFcU5qbW5DaUtkYXEvZ3h5em5nQ0dERnRiTlMxd0ZtM005?=
 =?utf-8?Q?VVbbA0ESiNtefLi8Il80NWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1FD658AA7E17946B473D63EDACB128F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abd3791-7735-495d-9c44-08d9c7446a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2021 01:18:10.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sh5cwk2KrWHsop/mrLuDM6AYiEQ2Xv8G+VTtUeraIjHUOmqvtVzQcsjkJ+6CALj5k0zZq+NN6r5AzumQ60b4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2046
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpPbiBUaHUsIDIwMjEtMTItMjMgYXQgMjI6MjQgKzAxMDAsIE1hcmNlbCBI
b2x0bWFubiB3cm90ZToNCj4gDQo+IGJ1dCB3ZSBzdWNjZWVkIHdpdGggSENJX0ludGVsX1JlYWRf
VmVyc2lvbiBvbiBhIGNvbGQgYm9vdC4gU28gdGhhdCBtZWFucyBpdCBpcyBqdXN0IHRoYXQgd2Ug
aGF2ZSB0byBtYWtlIHRoaXMgb25lIGZsYWcgcGVyc2lzdGVudC4gU28gaXQgaXMgdmFsaWQgZXZl
biB3aGVuIG5vIEhDSV9JbnRlbF9SZWFkX1ZlcnNpb24gaXMgcmVhZC4gT3IganVzdA0KPiBtYWtl
IGl0IGEgYm9vbCB2YXJpYWJsZSBpbiB0aGUgYnRpbnRlbCBpbnRlcm5hbCBzdHJ1Y3QuDQo+IA0K
DQpZZXMsIHRoZXJlIGlzIG5vIHByb2JsZW0gd2l0aCBjb2xkIGJvb3QuIFRoZSBwcm9ibGVtIGlz
IHdhcm0gYm9vdC4gSGVyZSBhcmUgdGhlIGxvZyBhZnRlciBtYWtpbmcgdGhlIGNoYW5nZXMgd2l0
aCBzb21lIGRlYnVnIG1lc3NhZ2VzLg0KDQpbQ09MRCBCT09UXQ0KDQpEZWMgMjQgMTY6MTY6Mjcg
aGFuMS1YUFMtMTMtOTM1MCBrZXJuZWw6IG1pY3JvY29kZTogbWljcm9jb2RlIHVwZGF0ZWQgZWFy
bHkgdG8gcmV2aXNpb24gMHhlYSwgZGF0ZSA9IDIwMjEtMDEtMjUNCkRlYyAyNCAxNjoxNjoyNyBo
YW4xLVhQUy0xMy05MzUwIGtlcm5lbDogTGludXggdmVyc2lvbiA1LjE2LjAtcmMxKyAoaGFuMUBo
YW4xLVhQUy0xMy05MzUwKSAoZ2NjIChVYnVudHUgMTEuMi4wLTd1YnVudHUyKSAxMS4yLjAsIEdO
VSBsZCAoR05VIEJpbnV0aWxzIGZvciBVYnVudHUpIDIuMzcpICMxIFNNUCBQUkVFTVBUIFRodSBE
ZWMgMjMNCjIwOjUyOjEyIFBTVCAyMDIxDQoNCkRlYyAyNCAxNjoxNjoyNyBoYW4xLVhQUy0xMy05
MzUwIGtlcm5lbDogdXNiIDEtMzogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1
c2luZyB4aGNpX2hjZA0KRGVjIDI0IDE2OjE2OjI3IGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiB1
c2IgMS0zOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9ODA4NywgaWRQcm9kdWN0PTBh
MmEsIGJjZERldmljZT0gMC4wMQ0KRGVjIDI0IDE2OjE2OjI3IGhhbjEtWFBTLTEzLTkzNTAga2Vy
bmVsOiB1c2IgMS0zOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBT
ZXJpYWxOdW1iZXI9MA0KDQpEZWMgMjQgMTY6MTY6MjggaGFuMS1YUFMtMTMtOTM1MCBrZXJuZWw6
IEJsdWV0b290aDogQ29yZSB2ZXIgMi4yMg0KDQpEZWMgMjQgMTY6MTY6MjggaGFuMS1YUFMtMTMt
OTM1MCBrZXJuZWw6IEJsdWV0b290aDogPj4+Pj4gYnR1c2JfcHJvYmU6IGludGYgMDAwMDAwMDAw
NzQ4ODlmNSBpZCAwMDAwMDAwMGMwOWFkNTc4DQpEZWMgMjQgMTY6MTY6MjggaGFuMS1YUFMtMTMt
OTM1MCBrZXJuZWw6IEJsdWV0b290aDogPj4+Pj4gQWxsb2NhdGUgaGNpX2Rldj0wMDAwMDAwMGE0
NzdlYzQ1DQpEZWMgMjQgMTY6MTY6MjggaGFuMS1YUFMtMTMtOTM1MCBrZXJuZWw6IEJsdWV0b290
aDogPj4+Pj4gU2V0IGhjaV9zZXRfZHJ2ZGF0YShoZGV2PTAwMDAwMDAwYTQ3N2VjNDUsIGRhdGE9
MDAwMDAwMDA3N2VjODhiYykNCkRlYyAyNCAxNjoxNjoyOCBoYW4xLVhQUy0xMy05MzUwIGtlcm5l
bDogdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBidHVzYg0KRGVjIDI0
IDE2OjE2OjI4IGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+IGJ0aW50
ZWxfc2V0dXBfY29tYmluZWQoaGRldj0wMDAwMDAwMGE0NzdlYzQ1KQ0KRGVjIDI0IDE2OjE2OjI4
IGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+IFRlc3QgZmxhZyhoZGV2
PTAwMDAwMDAwYTQ3N2VjNDUsIElOVEVMX1NIVVRET1dOX0VYRUNVVEVEKQ0KRGVjIDI0IDE2OjE2
OjI4IGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+ICAgICAgSU5URUxf
U0hVVERPV05fRVhFQ1VURUQgaXMgTk9UIFNFVA0KRGVjIDI0IDE2OjE2OjI4IGhhbjEtWFBTLTEz
LTkzNTAga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IExlZ2FjeSBST00gMi41IHJldmlzaW9uIDEu
MCBidWlsZCAzIHdlZWsgMTcgMjAxNA0KRGVjIDI0IDE2OjE2OjI4IGhhbjEtWFBTLTEzLTkzNTAg
a2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IEludGVsIEJsdWV0b290aCBmaXJtd2FyZSBmaWxlOiBp
bnRlbC9pYnQtaHctMzcuOC4xMC1mdy0xLjEwLjMuMTEuZS5ic2VxDQpEZWMgMjQgMTY6MTY6Mjgg
aGFuMS1YUFMtMTMtOTM1MCBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogdW5leHBlY3RlZCBldmVu
dCAweGZmIGxlbmd0aDogMiA+IDANCkRlYyAyNCAxNjoxNjoyOCBoYW4xLVhQUy0xMy05MzUwIGtl
cm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBJbnRlbCBCVCBmdyBwYXRjaCAweDMyIGNvbXBsZXRlZCAm
IGFjdGl2YXRlZA0KDQpbSENJIERPV05dDQoNCkRlYyAyNCAxNjoxNzoxOSBoYW4xLVhQUy0xMy05
MzUwIGtlcm5lbDogQmx1ZXRvb3RoOiA+Pj4+PiBidGludGVsX3NodXRkb3duX2NvbWJpbmVkKGhk
ZXY9MDAwMDAwMDBhNDc3ZWM0NSkNCkRlYyAyNCAxNjoxNzoxOSBoYW4xLVhQUy0xMy05MzUwIGtl
cm5lbDogQmx1ZXRvb3RoOiA+Pj4+PiBTZW5kIEhDSV9JbnRlbF9TV1JGS0lMTA0KRGVjIDI0IDE2
OjE3OjE5IGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+IFNldCBJTlRF
TF9TSFVURE9XTl9FWEVDVVRFRA0KDQpEZWMgMjQgMTY6MTc6MzUgaGFuMS1YUFMtMTMtOTM1MCBz
eXN0ZW1kLXNodXRkb3duWzFdOiBTZW5kaW5nIFNJR1RFUk0gdG8gcmVtYWluaW5nIHByb2Nlc3Nl
cy4uLg0KDQpbUkVCT09ULi4uXQ0KDQpEZWMgMjQgMTY6MTg6NDAgaGFuMS1YUFMtMTMtOTM1MCBr
ZXJuZWw6IHVzYiAxLTM6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNpbmcg
eGhjaV9oY2QNCkRlYyAyNCAxNjoxODo0MCBoYW4xLVhQUy0xMy05MzUwIGtlcm5lbDogdXNiIDEt
MzogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTgwODcsIGlkUHJvZHVjdD0wYTJhLCBi
Y2REZXZpY2U9IDAuMDENCkRlYyAyNCAxNjoxODo0MCBoYW4xLVhQUy0xMy05MzUwIGtlcm5lbDog
dXNiIDEtMzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTAsIFByb2R1Y3Q9MCwgU2VyaWFs
TnVtYmVyPTANCg0KRGVjIDI0IDE2OjE4OjQxIGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVl
dG9vdGg6IENvcmUgdmVyIDIuMjINCg0KRGVjIDI0IDE2OjE4OjQxIGhhbjEtWFBTLTEzLTkzNTAg
a2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+IGJ0dXNiX3Byb2JlOiBpbnRmIDAwMDAwMDAwMTZkN2U3
ODkgaWQgMDAwMDAwMDA1ODQxOGI1ZA0KRGVjIDI0IDE2OjE4OjQxIGhhbjEtWFBTLTEzLTkzNTAg
a2VybmVsOiBCbHVldG9vdGg6ID4+Pj4+IEFsbG9jYXRlIGhjaV9kZXY9MDAwMDAwMDA1Mjc1ODgz
MA0KRGVjIDI0IDE2OjE4OjQxIGhhbjEtWFBTLTEzLTkzNTAga2VybmVsOiBCbHVldG9vdGg6ID4+
Pj4+IFNldCBoY2lfc2V0X2RydmRhdGEoaGRldj0wMDAwMDAwMDUyNzU4ODMwLCBkYXRhPTAwMDAw
MDAwNzRlNDM0NDUpDQpEZWMgMjQgMTY6MTg6NDEgaGFuMS1YUFMtMTMtOTM1MCBrZXJuZWw6IHVz
YmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgYnR1c2INCkRlYyAyNCAxNjox
ODo0MSBoYW4xLVhQUy0xMy05MzUwIGtlcm5lbDogQmx1ZXRvb3RoOiA+Pj4+PiBidGludGVsX3Nl
dHVwX2NvbWJpbmVkKGhkZXY9MDAwMDAwMDA1Mjc1ODgzMCkNCkRlYyAyNCAxNjoxODo0MSBoYW4x
LVhQUy0xMy05MzUwIGtlcm5lbDogQmx1ZXRvb3RoOiA+Pj4+PiBUZXN0IGZsYWcoaGRldj0wMDAw
MDAwMDUyNzU4ODMwLCBJTlRFTF9TSFVURE9XTl9FWEVDVVRFRCkNCkRlYyAyNCAxNjoxODo0MSBo
YW4xLVhQUy0xMy05MzUwIGtlcm5lbDogQmx1ZXRvb3RoOiA+Pj4+PiAgICAgIElOVEVMX1NIVVRE
T1dOX0VYRUNVVEVEIGlzIE5PVCBTRVQNCg0KRGVjIDI0IDE2OjE4OjQzIGhhbjEtWFBTLTEzLTkz
NTAga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJlYWRpbmcgSW50ZWwgdmVyc2lvbiBjb21tYW5k
IGZhaWxlZCAoLTExMCkNCkRlYyAyNCAxNjoxODo0MyBoYW4xLVhQUy0xMy05MzUwIGtlcm5lbDog
Qmx1ZXRvb3RoOiBoY2kwOiBjb21tYW5kIHR4IHRpbWVvdXQNCg0KDQpBZnRlciBbUkVCT09UXSwg
dGhlIElOVEVMX1NIVVRET1dOX0VYRUNVVEVEIGZsYWcgdGhhdCB3YXMgc2V0IGJlZm9yZSB0aGUg
cmVib290IGlzIGdvbmUuIA0KU28sIGhvdyBjYW4gSSBtYWtlIHRoZSBmbGFnIHBlcnNpc3RlbiBi
ZXR3ZWVuIHJlYm9vdGluZyB0aGUgc3lzdGVtPw0KDQo+IEkgYW0gZmFpbGluZyB0byBzZWUgd2h5
IHRoaXMgd291bGRu4oCZdCB3b3JrLiBBbmQgSSBmdWxseSByZWFsaXplIHRoYXQgSSBhbSBwZWRh
bnRpYyBoZXJlLCBidXQgSSByZWFsbHkgd2FudCB0byBjb25maW5lIHRoZXNlIHRoaW5ncyB0byBp
bnRlcm5hbCBoYW5kbGluZyBhbmQgbm90IGhhdmUgdGhlbSBibGVlZCBpbnRvIHRoZSBkcml2ZXIu
DQo+IA0KPiBSZWdhcmRzDQo+IA0KPiBNYXJjZWwNCj4gDQoNCg==
