Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C35C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D190613F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhD1PMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:12:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:1270 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhD1PMd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 11:12:33 -0400
IronPort-SDR: bxVBxnGWkdF8orIf78N4iyeJPMAbM78WLpM6RapQ9xSfVCt8e35uGGs0gdXAlykTMnJwuveP2K
 MciO4sqp3tGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="176242262"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="176242262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:11:44 -0700
IronPort-SDR: Usbcy3c9SHdRVvegZCNQD2nxpoSaGy/GXQBXeLyKPeIQE9huHX1H9QFUVWREJIztBywh3O/ex7
 MHryRG6xLxRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="425636054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2021 08:11:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 08:11:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 28 Apr 2021 08:11:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 28 Apr 2021 08:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nda5X61k+owTw4HF11Jsrpa/hyH/1IX2igdUt6JvLkQdfwxF0Dch1c+HQ6QLH+yoOvPRabp1B+vPE+vv8RFvt+W2Ec1MP+Mr7PweJdQrg3Nuo89+YIvzSEAnJB0RbMsfjJJwFKopQ6Cu7l5G7SAtjXhHtZOpUUQ2QDibtQMZ+nfrvoObuBYpnYXs74G704Knmo9xewDRUwBlNDZ8yc6Mta/vjyBeVlOC6OTmFITbgIBzJ8C+FZyhFBWy+WaMjbx0d7HAcR8WdPcrftyLFsn++V78mllr+1qt588jWKRs6O+i+4F9cK3to9pApaQq9+jdPKyVdbcRnpVxbMy/wzi/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAmGWn9Qnnlvq68Qz0JQH2fo2nJgw/T8xCrqJg20v7o=;
 b=fiEOGpqi9LpETtovHlEk8jgoaa1ZYwYt4+H8Xxhk8nm5s5ieh62Upv6zdM18iglr/cfoWt2R84VQrOVRBUcQ2ZKnwMEWcJNixTvOpFUyVhg6K4QL3c5+r4qoMXElm0NeG6K0szHSToeeu1RzA0p3g8HBhxGARAbcgMQPIETXKE/vDsD9b8DNXHuAW108oXHPxlFlafmdnbrXHyT+I2U/HsS26rFmSNkKnApXW798ImTwhKLcl4MH+fX2+ge6OwminUD8dBNLl90KIDRv8XPndWTPTgZ+orEKV7RGIEyR5ma+jxqBtYvAODACyJ9gc2Q6aEBkqB01zcWDfUJp5WaGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAmGWn9Qnnlvq68Qz0JQH2fo2nJgw/T8xCrqJg20v7o=;
 b=Z/qlNBq7d3ezFKhCEFJwVb9T4atBLfduQmeNqMg+pwlh5Xg/snqRKUzmcZAsqF+p5s4xoEuQTOUgt6PR/L2mI3431KekSwP7zdKolKFnZKokP08P7Izc6ldVNX7mFDowP+/tNcWAGWLNnOYohL/mtYFgPXZ1ThxlwZdR7nFkoso=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Wed, 28 Apr 2021 15:11:41 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:11:41 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
Thread-Topic: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
Thread-Index: AQHXN4FoiNVZDd1d6UizO+ZKZaI9carBv2wAgAg6EXCAABLmgIAABTrQ
Date:   Wed, 28 Apr 2021 15:11:41 +0000
Message-ID: <DM8PR11MB5573B85C02E21F849015762CF5409@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210422141449.25155-1-kiran.k@intel.com>
 <20210422141449.25155-3-kiran.k@intel.com>
 <349C0A6B-5E9C-4171-BFB5-C86AF4E8D698@holtmann.org>
 <DM8PR11MB55739D629FCFD9BD7174C51EF5409@DM8PR11MB5573.namprd11.prod.outlook.com>
 <700CFB19-FE68-4B77-B8AD-97E20433E8A1@holtmann.org>
In-Reply-To: <700CFB19-FE68-4B77-B8AD-97E20433E8A1@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2405:201:d012:c839:adc4:2510:1d3c:4d99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a011e614-37db-4eb7-5062-08d90a57edaf
x-ms-traffictypediagnostic: DM8PR11MB5573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5573D441B610850294EE9BD4F5409@DM8PR11MB5573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cc13pkt6jZBGI2qOKyEHQIV92qEf2D8ZAqrCBiF7FyRtYyL7TWmjx9+P2dXrV0pJo4QkcN3XBfR7XhLmt4ItdU6GFEAC6Rzn35GCH0abHsr1wY14dND4jKoqgx1jAjjud5oaocUrQ1yTGeydTEzrNIA+AzzWllMNUfpv7zBtP83fU7NLazQfNGB2ZwLuiFLRFSoctOJC96/1ys+IPwxkfZq4Lbt43OqEDkYpgUjjNxEMcWELVjvAq694hcP5y1dTPJqRAK3KtCn9MVd1um72flf0oQKmLKYyyWUGroxQNrCGEedTyBsp0BcpUBlKHzjYCplQDBu5S3iOb0DW/EQNYN5Lggx6e/VlW3uu/W4lPe+Tp6Sj2CPir4vYyXt7wuidZPq9P7FjsSRe6OSEr6flobMbp+vQwR88NXcxiPVsIg6zTpca0hQIyrdRqP/g1YPtOlx9WH9J+wbAUfeokcpW4e7EbwGwYfvfxyjhz2cgDlj++AWREvnpCIbR5ybPBL1ozsm2EVuWJHDsSTh631h/2AfC8xvNTxLPFZKxtQjxc9DZEV71W9BdtSpSE/yqqkSSR1ce2YW2P4dEDTn0j3g4PveZjaceMr/RWnevWladRxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(9686003)(6506007)(54906003)(66446008)(55016002)(66556008)(7696005)(71200400001)(5660300002)(8936002)(86362001)(2906002)(6916009)(64756008)(66946007)(66476007)(8676002)(122000001)(33656002)(186003)(4326008)(76116006)(83380400001)(107886003)(498600001)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eDFhdkJvNjNEb3R5YjdwOTltRTQ2YmczM0hEK2pwb1FIcDlxeDBOZEduWG84?=
 =?utf-8?B?QkZZOHZkOGZncGRjR1QzWFlEV3lpNndVK0U5bWlIbUhLWkNLV3p1c1oxYjdt?=
 =?utf-8?B?bnFuaFQ4UDJSSmtLRlJMcm4yMlhJQlh6OUVFdGtUQ3BiS3NXZHJiektsTXBa?=
 =?utf-8?B?THMzdlNveGJzMVlzSVo5dC9MQnhHL3Y1MFdlb3hKY0ZUam5WSjYvNkRDU0N6?=
 =?utf-8?B?TWFBc0lub1RhT0tneXAxN0VaQzFSeHd6VnozSVFMWUJISDVLeGNOZ2VYZFlp?=
 =?utf-8?B?dFl6ODRlTVQza0taNU1mcHMrNnB2MTRLQ01uREpaeGxXdlA2eG9xdy82WW4y?=
 =?utf-8?B?dzBXYjVvQXVpdWlzcGkwVmV6bTdZQzI4NTFtMjg0NUMzTlJRUkloTmRQdFA3?=
 =?utf-8?B?SExDZGkyRStKOFBwRTJXQjY4UHJNR0FnSjYyWkI1R282VTJoQjk1Yk51K05Q?=
 =?utf-8?B?TUtuMldVS3MzckFYbDhLN3BVMmJqa1gzbytad3BWYUw4VFV0TG80TExLcjJp?=
 =?utf-8?B?S2dTNldKcFgyenI1dGpIeWlyNlk4K3pURm4xMGw0RG41VUpqMndORzdEcE50?=
 =?utf-8?B?VlJjd1Zrc3p5RUFyLzJRaEM0ZTJSM256SUl1YTYzOGZGcVphN0NIUENDenhp?=
 =?utf-8?B?T0o3T1ZQTCtmZHEraCtJTFdjTWJSOWxkMUJscjVQaUEyTnNndGdEUFQvZzBO?=
 =?utf-8?B?bC9KSEJObW5ZbnpSOW5oTGtFbHA1TFh4am9QT25OU01NYmdVRzJia0U2WWFu?=
 =?utf-8?B?aTFrQSthRmM0M1orZVc0VWdIZGtFRFhXREVpTkJ2dHlHU3hSUXhqajhaZDVs?=
 =?utf-8?B?cGl1VGZEU1k3cCt4QVloYzdkVkpiR2NObzBuVENPeEhDeVFIc3VHWjQ1bktp?=
 =?utf-8?B?bE1WMEtHVWlmK2RTbjBjT1NSZ0N6SDBTaG9jR2w3UWxqK1ZjOXE4NC9XQlZp?=
 =?utf-8?B?OTlRRXNlWGNlaU4xditzU29wczdyV0dpSlNlTUg4SlB5UGtVWnI2TW1xV1J4?=
 =?utf-8?B?NldIR1dlK2tmNnBxT1VYMkd2S3NPc2NZa2tYV3FjbVZUZG9vSEI1eFNoNGZF?=
 =?utf-8?B?M0YvT2xrKzVMRlB0WmlFMHovTTJ4NWk2a29GN0NQOHE2OS9UVSs5RVljSGNK?=
 =?utf-8?B?cTUvZDFOU3RCUEJscWJ2RW1RZXA2bnFEbTdlVjVyd1BqTFd4Y0lBTXAzTTNE?=
 =?utf-8?B?bEMreklyZVErSVRWRkZSWDRrNFM3a1VadDBxSGhScy9aNzdBdzc0QnNEa2lq?=
 =?utf-8?B?L2xwOG1Ib1M3bGo4ZWVGcUhuU3czZkJSSHJ4N01oUkNaVEUxbWozK0I3TmtX?=
 =?utf-8?B?czdEVnQwOVRLblc0VFQzc1lkRW1HQW9xc1BHWW5mMm12UUhKRDI2VVg5bTVy?=
 =?utf-8?B?b1RPSDY3dTkrQU9aT0xidm5pTEw1Vitya2s3ZzVVd29rYmpCV3Y5K25FMEYv?=
 =?utf-8?B?OHpNU21idzl0djhHd0JPazM3MzduejMyVG9DNUxUVWJhY0R1NFFUVTljRkZy?=
 =?utf-8?B?RUxFVTVBajN6V2d3M0l6Qnh0ZXFGN2pQTHJFbFV0NlFqUmg5Yzc5TjVRKzlV?=
 =?utf-8?B?UVZscUQwaGpZU1NZa0loczM0WlZPaVhkVkFudUMyVDRLR0k4aEEwY1B4T0dY?=
 =?utf-8?B?OUFxblAxU2xWMG9zb0ZZTmlFc3p6RzNTdjBNWkpyWWp3dGh2NnMrWUtLM0h6?=
 =?utf-8?B?ME0zL3VWQS83Ny9zWFJJc2xrTWUrZElrdnF4aGp5clFDMU5Cd0VoNFJhaU1O?=
 =?utf-8?B?S2ZxN2JXcjlObnhoSllSeUdkQ0pRY3JNUXBVY3lScVExWHVDb3lyWUxjZEpF?=
 =?utf-8?B?MVdERUNCYmFFQU1GenRrbUpPSDBYQzBhR081c0ZCbHpJSmdSamVNTkxkQUE0?=
 =?utf-8?Q?cfUsYfUUgcxxr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a011e614-37db-4eb7-5062-08d90a57edaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:11:41.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCP5vjqxdtFM+hR/ASjfR5JIsHu8Ls5LLylDDL+YkRzFlsmdG1DrxnXJ0UaJZhv1Nw9WDGO6gT+UFAPVNq8IZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNl
bCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJp
bCAyOCwgMjAyMSA4OjIwIFBNDQo+IFRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+
IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBUdW1rdXIgTmFyYXlhbiwgQ2hl
dGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBTcml2YXRzYSwgUmF2
aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAzLzNdIEJsdWV0b290aDogY2FjaGUgbG9jYWwgc3VwcG9ydGVkIGNvZGVj
DQo+IGNhcGFiaWxpdGllcw0KPiANCj4gSGkgS2lyYW4sDQo+IA0KPiA+Pj4gK2ludCBoY2lfY29k
ZWNfbGlzdF9hZGQoc3RydWN0IGxpc3RfaGVhZCAqbGlzdCwgc3RydWN0DQo+ID4+IGhjaV9ycF9y
ZWFkX2xvY2FsX2NvZGVjX2NhcHMgKnJwLA0KPiA+Pj4gKwkJICAgICAgIF9fdTMyIGxlbiwNCj4g
Pj4+ICsJCSAgICAgICBzdHJ1Y3QgaGNpX29wX3JlYWRfbG9jYWxfY29kZWNfY2FwcyAqc2VudCk7
DQo+ID4+DQo+ID4+IEkgdGhpbmsgeW91IG5lZWQgdG8gcmVkbyB0aGUgd2hvbGUgcGF0Y2ggc2Vy
aWVzLCBzaW5jZSAxLzMgc2hvdWxkDQo+ID4+IGhhdmUgaGNpX2NvZGVjX2xpc3RfYWRkIGluIHRo
YXQgaXQgYWRkcyB0aGUgY29kZWMgaWQgZnJvbSByZWFkaW5nIHRoZQ0KPiBjb2RlYyBsaXN0Lg0K
PiA+Pg0KPiA+IEFjaw0KPiA+DQo+ID4+IEFuZCB0aGVuIHJlYWRpbmcgdGhlIGNhcGFiaWxpdGll
cyBqdXN0IHVwZGF0ZXMgdGhlIGNvZGVjLg0KPiA+Pg0KPiA+IFdpdGggYXN5bmMgY2FsbHMgY29u
dmVydGVkIHRvIHN5bmMsICBjYW4gd2UgYWRkIGNvZGVjIGRldGFpbHMgdG8gdGhlIGxpc3Qgb24N
Cj4gcmVhZGluZyBjb2RlYyBjYXBzIGFzIHNhbWUgY29kZWMgY2FuIGJlIHN1cHBvcnRlZCBvbiBt
dWx0aXBsZSB0cmFuc3BvcnQNCj4gdHlwZXMgPw0KPiA+DQo+ID4+IE91ciBwcm9ibGVtIGlzIHRo
YXQgdGhlIHdob2xlIGluaXQgcGhhc2UgaXMgcmF0aGVyIGFzeW5jIHRoYW4gc3luYyBpbg0KPiA+
PiBpdCBwcm9jZWR1cmUuIEFuZCB0aGUgcmVhc29uIGZvciB0aGF0IGlzIHB1cmVseSBoaXN0b3Jp
YyBmcm9tIHRoZQ0KPiA+PiB0aW1lcyB3aGVuIExpbnVzIGhhZCBubyB3b3JrIHF1ZXVlcyBhbmQg
d2UgaGFkIHRvIHByb2Nlc3MgZXZlcnl0aGluZw0KPiA+PiBpbiB0YXNrbGV0cyBvciBzcGF3biBr
dGhyZWFkcy4NCj4gPj4NCj4gPj4gRnJhbmtseSBpZiB3ZSBtb3ZlZCB0aGUgd2hvbGUgaW5pdCBw
cm9jZWR1cmUgdG8gdXNlIF9faGNpX2NtZF9zeW5jIHdlDQo+ID4+IGNvdWxkIGZvbGQgdGhlIGNv
bXBsZXRlIGluaXR7MS00fSBwaGFzZXMgaW50byBvbmUuIEFuZCB0aGVyZSBpcyBubw0KPiA+PiBy
ZWFzb24gd2UgZG9u4oCZdCBkbyB0aGF0LiBIb3dldmVyIG9uZSBwcm9ibGVtIGF0IGEgdGltZS4N
Cj4gPj4NCj4gPiBBY2suIEkgd2lsbCBkZWZpbmUgaW5pdDUgZm9yIHJlYWRpbmcgY29kZWNzIGFu
ZCBjb2RlYyBjYXBzICB1c2luZw0KPiBfX2hjaV9jbWRfc3luYyAgY2FsbHMuDQo+IA0KPiBJIHRo
aW5rIHRoaXMgaXMgdG9vIGVhcmx5LiBJIG9ubHkgbG9va2VkIGF0IHRoZSBpbnRlcm1pbmdsaW5n
IG9mDQo+IGhjaV91cGRhdGVfYmFja2dyb3VuZF9zY2FuLiBJIGhhdmUgbm90IGdvdHRlbiB0aGUg
d2hvbGUgaW5pdCBoYW5kbGluZy4gSQ0KPiBzdXNwZWN0IHNvbWUgbG9va2luZyBpc3N1ZXMgdGhh
dCB3b3VsZCBoYXZlIHRvIGJlIGNsZWFuZWQgdXAgZmlyc3QuDQoNCkluIG15IHRlc3QsIEkgZGlk
bid0IHNlZSBhbnkgaXNzdWUuIEluIHRoYXQgY2FzZSwgbGV0IG1lIGtub3cgaG93IHRvIHByb2Nl
ZWQgZnVydGhlci4gSSBhbSBoYXBweSB0byBhbWVuZCBhcyBwZXIgeW91ciBjb21tZW50cy4NCg0K
VGhhbmtzLA0KS2lyYW4NCg0K
