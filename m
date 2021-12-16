Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAADC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhLPSi0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:38:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:42314 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhLPSiZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 13:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639679905; x=1671215905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4V28Cg/LGKF98+geU8vBwUT9CAGfdoyVryCqjm+qsIk=;
  b=Cc1bJDahTNdMnq19AuF4gGY+NJJRAWUuO0mbsZ//xCurINxbf4sUbliO
   TB0CUgJYNcxBLmUT0eUOItvug0LWxdHK9SYJm9y8mNppQsRgN1apIArMO
   xEv3TLax90S/X8EEDVfNjmkdl6DwZCbddfMjklgQSS9ywR/X7aIlJir9b
   KvJmZbJKee44UvhIszwOA3tU+JHZdPfoiGHMMzZSCD9pZZPed/rL0LQ8+
   j1fFZCifB5Fj3OfdBZmO4noVnrhK0OvLU+t7RJ2l8tDpUBoyJabdpT4gQ
   T4B9crS8IsDw5n01RVwtiMO5PbRBiaUxl2VHJ6HGNEaXhYhZ1vosplIjF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226852743"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="226852743"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="683052754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 10:38:24 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:38:24 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:38:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 16 Dec 2021 10:38:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 16 Dec 2021 10:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5eqi3/8sFmZMOYmE/YOG1oMzYRmDOg088iCqb1A5nejhSW2E3WRXAMGKGOLnT3dBmQiULe+KcvQfZYuH6qnHirMpgwOWsoY1vji2Yy4DFcM7EH2Y46Je3ZFH0BsW6YBxbm1vaDQ7xdK4YX2q3xp7J+JZfMH+SYXo2Ayk0lucGefBhLtCaO6WdieZ+TZRZyglqJAOc90qgpR2EQwBN/L4tgu4GRaT3xSC5/zeKwNsvvPOrMi4V90PM/xNr0LnncLOHu93dV/QIL1b2xMKe30Cr98wbxfUxST7aKnbqDUMg3NiPeNrggqIVRhRimEPGzVYpovK1vVvHjUpZiqrlJnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V28Cg/LGKF98+geU8vBwUT9CAGfdoyVryCqjm+qsIk=;
 b=R6YD09tElDTIDt/PbWtvBsYADOlwaMvaSX2fZ/YEFLt3bOFDNCcOd/32AvX22mVUaDrNGg5mPJVETbt2BuKWQ6ABZ08Zegt+PtNVAUkRjPi63HlNHB55x46B1w5cInnWxCiRx8UbXtU/WDwZpp2vPTJKijWhKruivAJQId66pSiN2ixeXgIZjJTxnadfMNNyNLfHw3YG1o48QdLj6IuoFSv9eTvGbiqHa83uTydSH3spyl9C94or6AkEUotdf1ccpVVOBEnfuBT3uU8TevjRNwRnfLCTxkF60BH1jYSos87rZQUTBKGTdPe7U32WnINe94Z2e5bQJMXYL9OC2vjVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 18:38:22 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f%5]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 18:38:22 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy
 ROM device
Thread-Topic: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy
 ROM device
Thread-Index: AQHX8i30N/3TP/CR9UK0WhJ4678gKaw0v1EAgAC0hoA=
Date:   Thu, 16 Dec 2021 18:38:22 +0000
Message-ID: <7bca0b8840cc1bab1c7ea7f25d8cca6ee41ecb04.camel@intel.com>
References: <20211216033453.9806-1-hj.tedd.an@gmail.com>
         <904d134a-a672-72a9-dddb-1c48d151e62e@molgen.mpg.de>
In-Reply-To: <904d134a-a672-72a9-dddb-1c48d151e62e@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad3438b4-0396-4705-8275-08d9c0c33d28
x-ms-traffictypediagnostic: CO1PR11MB5028:EE_
x-microsoft-antispam-prvs: <CO1PR11MB5028EF70D656DC0C35015EFDFF779@CO1PR11MB5028.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HY1alGDAzX+s9zUSE1UctQ/5LnLXjpMrAcfAFR1ZEQl3omlczdaAsvS21PDSX0ueWLfatrUa+YZWDmTcm4yrsqhWoUgbjqau9PQskWhydF01JQopx0IpQ5nYvc9FG9CFTlfKdbeBr3tajSVtIS9atKoqhuTBjQvIgM0uNKtwXM9FOikIcqrSHoR8WELZpDX6UZUl9DxHoYgiZXzBBxZchlcSruPMmUq91fcvWPFZisoUVARUuzfamcwdZLkY3dMZDiiAriIf2DhkXgBzkNW5WiLGxJGiynGWA8JRtTD+QsZNdJwDnCtOr9jVLmP4vecab2Bk0SAhLa88lTUG3WhyIlpdTvUxiNE5wrHWdGzc++KLKHGmmR7IDvYiVC1EN3iVoq79LoKWcXJDwGb37FnC787jqWs2ZLGqxEFbKaOFncmgzO5m6SbgxfY+vxebj5/nbu+Mz8Eo50c2QyF+PbPKAqVOKQgtEJ6vvFq7Xk2WQwcqeaFdqz2GXvgmUukhj36YEGpAOL/hzaQMW9w46ggE6DxNWQUg6pNF8XeTRxNIvzLgMbPJVJI6+KRfG6CuxAx8KcIDDHOFKw5k8z4bDrpBr5eu104NsyhmTfU9fVxTGAmRy11DetcvjlF1wEiyKTI6ECzo6qfAl8WqJ/skf3vwcmb1vcUv8vrNMXex6amt8zuwbKxVYSILhXIkrTB2FpJC4U+NsI7Hp3A34eXJsYb4Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(110136005)(6512007)(8936002)(6506007)(86362001)(8676002)(36756003)(66446008)(38100700002)(316002)(83380400001)(66476007)(66556008)(4326008)(64756008)(82960400001)(66946007)(122000001)(6486002)(2616005)(186003)(5660300002)(2906002)(4001150100001)(38070700005)(508600001)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3hrc2RCZ0ZObFZNY25weUd2T1A1czcxSmM5WnF4R0V5NWFDekl6Q0E3VWxY?=
 =?utf-8?B?TWZxMTc2ZVRCYjRRLytjRVd1U2phVGk1T3lwMG9jQjFrV1V0ck5OQ25SdUxV?=
 =?utf-8?B?bmk4MVF1bS9ISkk5Qzczc0h6YXBjOVJzbE5UWjhHMUNwZlhiVVhJMCtnN0ts?=
 =?utf-8?B?b2ViZmxyUjNqeFUzOVkvVUpGZGF6NUVjNU5BWmRMcWFsb2pLWWNZZlZ1aDBJ?=
 =?utf-8?B?WG82QjlJRld2eVJjQlFWVDVRbXFjaHZoNHRnMW1rL2FvcExxbWc0OVB0aU5U?=
 =?utf-8?B?Q2pYTklGd1lMMkN2QVpLY3VOOVJmTVMrVTQrQ05FczdmcWQ3K2MxWlVpZTdk?=
 =?utf-8?B?TTBGM0xPVlBkSnlaNUk0a1VlRTNNcG5KZFVEbXpZK3VxaCtuVzdlNy9SYzhs?=
 =?utf-8?B?Sks0cWd4OVVDclhHTEpVU2twemRaLzg0K3ljRGtrT2FGTVkxK2tCemJmVStx?=
 =?utf-8?B?bUV0YTIrdlNLUGJMSDNybXdsQklEdjBIYW5EL2xLYUdmSWpKYlN3VEs2c292?=
 =?utf-8?B?R0tlZmMxNEIxREt4NGRxTUZWaFFZSk4wUGZIZVZ1SmZxTTVUWjJkWGFWT1Ix?=
 =?utf-8?B?OU5lZEE3Y0lXZDRXbmVXRkRhYUJUcUxCMHdtRDJHU3dKSFhCQmo4ZXZBWHVn?=
 =?utf-8?B?cHRENExTWm93UmZQaFpKK0wxRTlhUEhOS1Y2U3h1ODM2Q3cvN3c2NnZqMDZn?=
 =?utf-8?B?WEk0OEtIU2xSYTJIZGdZakZuWE9NNlFGOVF4NUtYY2J2UEtpcDhiSm9WRDZH?=
 =?utf-8?B?cnUyMHVqd3Zmd2ErUURsL3NDQmxtZ1VsUmJjQlJRZUdrWXI2SE0xbzFmMERz?=
 =?utf-8?B?SGlMTEQwdWpsYWszUkxFdGZFdlprT05uSE41SFBoc3duTERLTk9GcVgzZU53?=
 =?utf-8?B?UzZ2R2Z6djEvSzBSQnVPVTVtclpBanM0Q3g2THNQNiszRkZhcW5PV25qYzFM?=
 =?utf-8?B?cEd0N3czazFFYzRWZ3lIdkFybkxFMXVoNE1GeXU4TVNiUmZmL01qY3RnWXJM?=
 =?utf-8?B?Lzc2WllQRExEQk1od3dGeXhzZWNlcnlaWWxFWkdoTldYbklBRkVCV0syL3N3?=
 =?utf-8?B?VFk0TDVjMk9oelFMeWwrWjJ5NTBwSFlla1RyU25GNFZvbUg4TDEvK0ppeTU1?=
 =?utf-8?B?MFQ1ZlR6NmpJbkRESzRXRlZIYWgrdzU0Ui9kUko0cklDaTcySUFIcFlEVFBx?=
 =?utf-8?B?MkdHdVFHSWswcnhtWlowbnVjOHhRei9idWN4UFRhOVNrRXJQR1dzNTdveXdP?=
 =?utf-8?B?d3dXOUVPUTU5c0RzbXJEUlgzeXEwN3pvT0xaeGtJT2JsWXJhazhFb0R2elVJ?=
 =?utf-8?B?TUMwY1ptU3FYOVZmRDdpc20zOEtoMGt2ekxXQjhtalo1SHpocS9kbitzTldt?=
 =?utf-8?B?c3J2dUJZZVowa2VlZXVyK096cWtkTGNINFJqcnUwMUx3WU92bnBsTFR6V2o2?=
 =?utf-8?B?UHhGVThQdUUxWDU2dWFJaG9iOElySEhZSHFIM21tLysvU3lpaloyaTQwb2RB?=
 =?utf-8?B?QndkOGtLZnMwR0lXSDA2bXYreVFWLzBtdG9EUjg1c0FFekhEanFFMXQ4THpw?=
 =?utf-8?B?R0xQcGZiR2k4UG91Z3AvTHVjdE9IcVViVUJ6YUZWMnlySzRTSTQxeTBwcHg5?=
 =?utf-8?B?Q2RMOTV0bWYvSnl2bG82bzFwMzg0TTFMYnVkQTJUMkxLZGZhaW82TG42bThD?=
 =?utf-8?B?RWp2bXV1NlNuK2E4Q1pKOHJFL3hPeXludEpva3N3Nzg2T0kya2NubC9ueFNt?=
 =?utf-8?B?bGdHM3RmMENZUFE2YmRGcG5hK0hmVk81NzgyTFRIUWJ6YkhYVWRzRGtGQ0h2?=
 =?utf-8?B?ZkNGMFZEYzBBWHU5QVhIWVg3Uk9QcjUvb3R3NWFlcHpLaGJhUW1SbkRTNWp1?=
 =?utf-8?B?V3dWRkdINXl2QmlhQlQvdXFFZmgwUXJNZ1BabTV4TXVYR2tMa3JSRmgvWnJv?=
 =?utf-8?B?MmFrTEcvQ1gvbnpUbjZqVnY4aGtjRGdhdHFMN29NbUN5ZUJ4d3lpTTJ5RWha?=
 =?utf-8?B?MUJMb0p2MVduZXpOK01pNWJqeDE3R1Z5QVlIaElocHlXdzJQenVrdGtwc0Jo?=
 =?utf-8?B?SzBOWnFVamVJVjlpbktkM0lVajBsNm5zU3EwalByZ2lBL2kwbVVmaVlnd1hs?=
 =?utf-8?B?NWxwa2NOYlNvZE9mMUVoM0cyUHROUjhQS3ZyUVo2ZFFCYjZMa1dTeDdtZWJl?=
 =?utf-8?Q?mK5sGXt2AyxM1t8S66+42NU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B061A42DD1063246B083D86C57E7A67C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3438b4-0396-4705-8275-08d9c0c33d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 18:38:22.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGEAgn2GxcOM6t7Lz+eiXJ/XQusRhq0A2yTtFI/RCd2DH2mfqWVV5S8OGkt1xFbTe+Zq37HBbd88oLse6WemsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bAoKT24gVGh1LCAyMDIxLTEyLTE2IGF0IDA4OjUyICswMTAwLCBQYXVsIE1lbnplbCB3
cm90ZToKPiBEZWFyIFRlZGQsCj4gCj4gCj4gQW0gMTYuMTIuMjEgdW0gMDQ6MzQgc2NocmllYiBU
ZWRkIEhvLUplb25nIEFuOgo+ID4gRnJvbTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRl
bC5jb20+Cj4gPiAKPiA+IFRoaXMgcGF0Y2ggZml4IHRoZSBicm9rZW4gTEVEIHF1aXJrIGZvciBJ
bnRlbCBsZWdhY3kgUk9NIGRldmljZXMuCj4gCj4gZml4KmVzKgo+IAo+IEV4Y3VzZSBteSBpZ25v
cmFuY2UsIGJ1dCB3aGF0IGFyZSBJbnRlbCBsZWdhY3kgUk9NIGRldmljZXM/IE1heWJlIGFsc28g
Cj4gbWVudGlvbiB0aGUgSURzIDB4MGEyYSBhbmQgMHgwYWE3IGluIHRoZSBjb21taXQgbWVzc2Fn
ZT8KPiAKPiA+IExlZ2FjeSBkZXZpY2Ugc2VuZHMgdGhlIFNXIFJGS0lMTCB3aGlsZSBzaHV0dGlu
ZyBkb3duIHRoZSBkZXZpY2UgKGxpa2UKPiA+IEhDSSBpbnRlcmZhY2UgZG93bikgdG8gdHVybiBv
ZmYgdGhlIExFRCBieSBwdXR0aW5nIHRoZSBkZXZpY2UgaW4gYXNzZXJ0Lgo+ID4gCj4gPiBPbmNl
IHRoZSBTVyBSRktJTEwgaXMgb24sIGl0IG5lZWRzIHRoZSBIQ0lfUmVzZXQgdG8gZXhpdCBmcm9t
IHRoZSBTVwo+ID4gUkZLSUxMIHN0YXRlLiBUaGlzIHBhdGNoIGNoZWNrcyB0aGUgcXVpcmsgYW5k
IHNlbmQgdGhlIEhDSV9SZXNldCBiZWZvcmUKPiAKPiBzZW5kKnMqCj4gCj4gPiBzZW5kaW5nIHRo
ZSBIQ0lfSW50ZWxfUmVhZF9WZXJzaW9uIGNvbW1hbmQuCj4gCj4gSXMgdGhhdCBkb2N1bWVudCBp
biBzb21lIGRhdGFzaGVldC9zcGVjaWZpY2F0aW9uPyBJZiBzbywgcGxlYXNlIG1lbnRpb24gaXQu
Cj4gCj4gQWxzbywgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHN1bW1hcnkgeW91IHdyaXRlIOKAnEZp
eOKAnS4gSWYgaXQgZml4ZXMgYW4gb2xkIAo+IGNvbW1pdCwgcGxlYXNlIGFkZCBhIEZpeGVzOiB0
YWcuCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWRkIEhvLUplb25nIEFuIDx0ZWRkLmFuQGludGVs
LmNvbT4KPiA+IC0tLQo+ID4gwqAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIHwgMTMgKysr
KysrLS0tLS0tLQo+ID4gwqAgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuY8KgwqAgfCAxMCArKysr
KysrKy0tCj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pCj4gCj4gSSBoYXZlIGEgRGVsbCBMYXRpdHVkZSBFNzI1MCB3aXRoIHRoZSA4MDg3OjBh
MmEuIEhvdyBjYW4gSSB0ZXN0IHRoaXM/CgpBcHBseSB0aGlzIHBhdGNoIG9uIHRvcCBvZiB0aGUg
Ymx1ZXRvb3RoLW5leHQgKG9yIGN1cnJlbnQgbWFpbmxpbmUpClRoZSBCVCBpbnRlcmZhY2Ugc2hv
dWxkIGJlIGF2YWlsYWJsZSBhZnRlciByZWJvb3QuCgo+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ID4g
aW5kZXggOGY5MTA5YjQwOTYxLi4wYTVhYTYzN2JmNmYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2JsdWV0b290aC9idGludGVsLmMKPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwu
Ywo+ID4gQEAgLTIzNTUsOCArMjM1NSwxMyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29t
YmluZWQoc3RydWN0IGhjaV9kZXYgKmhkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogQXMgYSB3
b3JrYXJvdW5kLCBzZW5kIEhDSSBSZXNldCBjb21tYW5kIGZpcnN0IHdoaWNoIHdpbGwgcmVzZXQg
dGhlCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogbnVtYmVyIG9mIGNvbXBsZXRlZCBjb21tYW5kcyBh
bmQgYWxsb3cgbm9ybWFsIGNvbW1hbmQgcHJvY2Vzc2luZwo+ID4gwqDCoMKgwqDCoMKgwqDCoCAq
IGZyb20gbm93IG9uLgo+ID4gK8KgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IEZvciBJTlRFTF9CUk9LRU5fTEVELCB0aGVzZSBkZXZpY2VzIGhhdmUgYW4gaXNzdWUgd2l0aCBM
RUQgd2hpY2gKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGRvZXNuJ3QgZ28gb2ZmIGltbWVkaWF0ZWx5
IGR1cmluZyBzaHV0ZG93bi4gU2V0IHRoZSBmbGFnCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBoZXJl
IHRvIHNlbmQgdGhlIExFRCBPRkYgY29tbWFuZCBkdXJpbmcgc2h1dGRvd24uCj4gCj4gUGxlYXNl
IHJlZmxvdyBhbGwgbGluZXMgZm9yIHRoZSBhbGxvd2VkIGxpbmUgbGVuZ3RoIGxpbWl0IChkb2Vz
buKAmXQgZml0cyAKPiBvbiB0aGUgbGluZSBhYm92ZSkuCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoYnRpbnRlbF90ZXN0X2ZsYWcoaGRldiwgSU5URUxf
QlJPS0VOX0lOSVRJQUxfTkNNRCkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChidGludGVsX3Rl
c3RfZmxhZyhoZGV2LCBJTlRFTF9CUk9LRU5fSU5JVElBTF9OQ01EKSB8fAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnRp
bnRlbF90ZXN0X2ZsYWcoaGRldiwgSU5URUxfQlJPS0VOX0xFRCkpIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwgSENJX09QX1JF
U0VULCAwLCBOVUxMLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhDSV9JTklUX1RJTUVPVVQpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHNrYikpIHsKPiA+IEBA
IC0yNDI4LDEyICsyNDMzLDYgQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0
cnVjdCBoY2lfZGV2ICpoZGV2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldF9iaXQoSENJX1FVSVJLX1dJREVCQU5E
X1NQRUVDSF9TVVBQT1JURUQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZoZGV2LT5xdWly
a3MpOwo+ID4gwqAgCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC8qIFRoZXNlIGRldmljZXMgaGF2ZSBhbiBpc3N1ZSB3aXRoIExFRCB3aGljaCBkb2Vz
bid0Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGdvIG9mZiBpbW1lZGlhdGVseSBkdXJpbmcgc2h1dGRvd24uIFNldCB0aGUgZmxhZwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBoZXJlIHRvIHNl
bmQgdGhlIExFRCBPRkYgY29tbWFuZCBkdXJpbmcgc2h1dGRvd24uCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidGludGVsX3NldF9mbGFnKGhkZXYsIElO
VEVMX0JST0tFTl9MRUQpOwo+ID4gLQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gYnRpbnRlbF9sZWdhY3lfcm9tX3NldHVwKGhkZXYsICZ2
ZXIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgMHgwYjrCoMKg
wqDCoMKgIC8qIFNmUCAqLwo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNi
LmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCj4gPiBpbmRleCBkMWJkOWVlMGE2YWIuLmM2
YTA3MGQ1Mjg0ZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKPiA+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKPiA+IEBAIC02MCw2ICs2MCw3IEBAIHN0
YXRpYyBzdHJ1Y3QgdXNiX2RyaXZlciBidHVzYl9kcml2ZXI7Cj4gPiDCoCAjZGVmaW5lIEJUVVNC
X1dJREVCQU5EX1NQRUVDSMKgMHg0MDAwMDAKPiA+IMKgICNkZWZpbmUgQlRVU0JfVkFMSURfTEVf
U1RBVEVTwqDCoCAweDgwMDAwMAo+ID4gwqAgI2RlZmluZSBCVFVTQl9RQ0FfV0NONjg1NcKgwqDC
oMKgwqAweDEwMDAwMDAKPiA+ICsjZGVmaW5lIEJUVVNCX0lOVEVMX0JST0tFTl9MRUTCoDB4MjAw
MDAwMAo+ID4gwqAgI2RlZmluZSBCVFVTQl9JTlRFTF9CUk9LRU5fSU5JVElBTF9OQ01EIDB4NDAw
MDAwMAo+ID4gwqAgCj4gPiDCoCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgYnR1
c2JfdGFibGVbXSA9IHsKPiA+IEBAIC0zODIsOSArMzgzLDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdXNiX2RldmljZV9pZCBibGFja2xpc3RfdGFibGVbXSA9IHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDA3ZGEpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9DU1Ig
fSwKPiA+IMKgwqDCoMKgwqDCoMKgwqB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDA3ZGMpLCAuZHJp
dmVyX2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB8Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFVTQl9JTlRFTF9CUk9LRU5fSU5JVElBTF9O
Q01EIH0sCj4gPiAtwqDCoMKgwqDCoMKgwqB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhMmEpLCAu
ZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB9LAo+ID4gK8KgwqDCoMKgwqDCoMKg
eyBVU0JfREVWSUNFKDB4ODA4NywgMHgwYTJhKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfSU5URUxf
Q09NQklORUQgfAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBCVFVTQl9JTlRFTF9CUk9LRU5fTEVEIH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyBVU0Jf
REVWSUNFKDB4ODA4NywgMHgwYTJiKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfSU5URUxfQ09NQklO
RUQgfSwKPiA+IC3CoMKgwqDCoMKgwqDCoHsgVVNCX0RFVklDRSgweDgwODcsIDB4MGFhNyksIC5k
cml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVMX0NPTUJJTkVEIH0sCj4gPiArwqDCoMKgwqDCoMKgwqB7
IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhYTcpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRFTF9D
T01CSU5FRCB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEJUVVNCX0lOVEVMX0JST0tFTl9MRUQgfSwKPiA+IMKgwqDCoMKgwqDCoMKgwqB7IFVTQl9E
RVZJQ0UoMHg4MDg3LCAweDBhYWEpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5F
RCB9LAo+ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgLyogT3RoZXIgSW50ZWwgQmx1ZXRvb3Ro
IGRldmljZXMgKi8KPiA+IEBAIC0zNzI0LDYgKzM3MjcsOSBAQCBzdGF0aWMgaW50IGJ0dXNiX3By
b2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAo+ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChpZC0+ZHJpdmVyX2luZm8gJiBCVFVTQl9JTlRFTF9CUk9L
RU5fSU5JVElBTF9OQ01EKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgYnRpbnRlbF9zZXRfZmxhZyhoZGV2LCBJTlRFTF9CUk9LRU5fSU5JVElBTF9O
Q01EKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaWQtPmRy
aXZlcl9pbmZvICYgQlRVU0JfSU5URUxfQlJPS0VOX0xFRCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnRpbnRlbF9zZXRfZmxhZyhoZGV2LCBJTlRF
TF9CUk9LRU5fTEVEKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoCAKPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoaWQtPmRyaXZlcl9pbmZvICYgQlRVU0JfTUFSVkVMTCkKClJlZ2FyZHMsClRl
ZGQK
