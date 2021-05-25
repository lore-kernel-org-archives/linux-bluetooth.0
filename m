Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA1FC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C116140E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhEYKPn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:15:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:42050 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhEYKPi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:15:38 -0400
IronPort-SDR: x9t90Wy/5giipyxN/uwJXx9rueXgg7/cDm/xwvN2xHTVJjMGhJRvMrcZXO3/92URRE04ENItZ3
 mzkp+cZKOOyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181796503"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181796503"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 03:14:09 -0700
IronPort-SDR: YHoaMLVJkaxy2ckVOeKtKn0cUxN3nR8u2DstyV/wHxM0nzSdQkc4wkmBVC2uy7R5hHmPH2zhNs
 85rV48izJpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479231831"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 03:14:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 25 May 2021 03:14:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 25 May 2021 03:14:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 25 May 2021 03:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guyXrY3z/TIEmCpgQKiw36A+GPifxkbp6ucaPY/qesdaEn5chhIBkbTZTptgqTfPhJICw5IkiMrIVXAgLzDip9oIGdh2lFXw/+HBzRgL8F6bSxeFUXC/8VrTkOIe2kzF7TFq44wysUf+u1079+blyXL/wxg9szI3FAPzfxUZtePK/r5EnpfSoomtpmBW3iSyFRzsOfOZif5Cs2ovpaXRJK5kiUgDxoihjPzoiSDArTrmvIg5avVXHWoLdgJwSzsKbA1pa5hWpLUyrp2c14V7PsCyM0p5NfrR89acR9Cu+xlUMDvihxvDo096rNmtrkWL2XS93jzdHX3vvcbJpB2CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acvCTZKfWTmAtPWZmggUnY9vJMa4dFGrUXglo891mrw=;
 b=Wpi6Ke0cthMCRro+7U+15Pt5xGX3LkMXaRBfG3sZ6tr5ghvPCRHhItyRpZ5b6eomYfuOLb0Hx/QM6sQmGeH9ijN97VUYk834lQEKPQdd+lGExxUfsQDYL8M6KQRgGDn1cOOeP6YYQVXG91BoGWUJRCDTtn4/K5tFDJxpoPLw/CLGtVq6nIqyDWWB2UyNd76BEZqGSfizalnO136XXBmMSYBgiiwmAhrzjloeRkjs1pvx96sZ9Y1IE/sm9KWO/fssN0Zac7HodaeDE6CNz9d/KHg4St6tmmrKOUGb73U6zJdUvOi3h8EWsiI73evCGXz2Hj6NEEsGZO3GzVebPExy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acvCTZKfWTmAtPWZmggUnY9vJMa4dFGrUXglo891mrw=;
 b=v1omJaC6tGNWNtgO69vO7VdpH9VGtYOcqjrf2xtxDFZ4Cm9lBvlWNz/os98PtMcs14w/MoPq4ympnSLgRMLYbDC6yfzycOSrrl/op6+q7FSI/V6CJxVJ4g2NKV7pfbkJQ6LQMFHVxSK1oS59iqToXruPfRxPatuspLh/sESS4EM=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5621.namprd11.prod.outlook.com (2603:10b6:8:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Tue, 25 May 2021 10:14:08 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 10:14:08 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Chris Clayton <chris2553@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: BT Intel: Regression loading firmware in linux-5.13-rc3
Thread-Topic: BT Intel: Regression loading firmware in linux-5.13-rc3
Thread-Index: AQHXUUyEbJf5P+ag+UOtEiqZABIrNarz+lcg
Date:   Tue, 25 May 2021 10:14:07 +0000
Message-ID: <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
In-Reply-To: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: googlemail.com; dkim=none (message not signed)
 header.d=none;googlemail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.171.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f64478ec-ec02-4dc9-9515-08d91f65d55b
x-ms-traffictypediagnostic: DM8PR11MB5621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5621724D293DCA262A7B1637F5259@DM8PR11MB5621.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elCgHZG3Lz2BTdHKEUMvheD4DarDls1LZW263ogq6dCHNz5xq4q3yggcgAFfrdv6TlE16pNijs1oCFn4A16ht0nFwiVFeVMtvfwotS/lLvcOrqj6Po/v2yTsolsT4nGVOj1M6FFQouMBl4UABt4JcxAKygvUL8e0LMe7Yg2RIX6t5ydMZ1wKO8j4xwkQGAcvpJoJPmKrBcgej4TzEKCiEuFbRSFCODpjdowfw81mi3xb1Toz2LgpSt3TUNpbjLmLKaUYJI5CtDnZEcP29uGojkGbT9Zc+Qan19N2ZY+WSjWpiS9fOjWEfyqLNxkFM/uq/kbn0d3+eGmEMTkcEsVhp3TQVe1tWEIWiIcvhDKQxT7/kaJgSjq2GapsGKtDrsqMuibzoXQpctwiJD3L3KrIEccUn54wTsWM2URYVNa+RKFJwu7QkxT08LqThvH5SR4PA4GlePJhgo+VBr1ecfAcsUum/mKGJ3qz2zByOpRKepERa3TceEfZVTjp1GmWub8Fn+YDazB7cPdOUcQUQ156Clp7bSKm/oDfWb1FvkdozH4cgmtciBmhFjTSX+HmBxohZApEknqkXnGwVNK/Xp7OYVlSdPG6zs2Y13CfMCDewBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39850400004)(6506007)(53546011)(71200400001)(7696005)(8936002)(2906002)(107886003)(316002)(9686003)(76116006)(26005)(33656002)(4326008)(55016002)(8676002)(122000001)(66446008)(478600001)(66476007)(66556008)(64756008)(66946007)(83380400001)(86362001)(6636002)(52536014)(186003)(54906003)(38100700002)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SG53elhzV3RlVS9kNHBCQ096cUFxb1dWVnNwa2FiUFFuNVFmUmoveGJGMDl5?=
 =?utf-8?B?OFRwc1cwNGJkNjI4bThvbFlqKzNBUVU5MWZOUkR5TG4walhrdDE1a2tHa1pW?=
 =?utf-8?B?T3VUNlFNWW9ZM05qc3AyVFdXWFhNRnE1TksyMjExc0N3K3Y5NHRxOVBFZTRZ?=
 =?utf-8?B?YkNJWWNCdklxbUNqU3U0SXEyMXZQbTBXRVVZc204UUMvUXZpSC9RSkg3Z0VJ?=
 =?utf-8?B?aUVLZFdLVGxaaWcxUlQvRGg5WkxqOGs4b0Y0Vjd2RFgvRk5WZUlvdkdhUXlP?=
 =?utf-8?B?dUFydDEzTnk1MHJJdXVwZWVWU20yeXRMZmlCRWErSjg2VUJTdC9RaTVES205?=
 =?utf-8?B?eWNxcWxydmZ6Nm8rdFcyM0FERm1NdEluY0JySCtqSmh5aWgyUzBheXZHNXAx?=
 =?utf-8?B?YVA4dzlzK1lWVkxScU53TlZrSFlXSWswaVFQdWhKM2E3OXIvRWlkQkYzT1V4?=
 =?utf-8?B?c3ZrYjJnVWlqaFF2YmMvZzNMYnFOL2pCQkU3M2Ivb1FyOENtdmtRSzE5Q05u?=
 =?utf-8?B?dEF0SGhpUFl6OVU0ZWY5WWx4S1F1NlFmY05TY1c1UlFnUFFvN2NJWFhEYlZJ?=
 =?utf-8?B?NE5zYTJzZkRNaVd4TFFOdEh0ckQvbm5UUytOVXlGVFJnT3JIQUtqN2FDV3Qr?=
 =?utf-8?B?MmN2YnpYVkdkdEltYWpZWVIxODRHVE5LU1E1QXZwbmxYN3BLb1FVZU5lMVFG?=
 =?utf-8?B?aHRNNDdaVHNTLzVTNmduNUV6dm1US2pzbVdNOFBhU0FDWmR0U2x4NFphRnBV?=
 =?utf-8?B?azlwWWVjSmlPOXFZNUFhTWRLOWlLenZrME9IVE1JWnlkL3c0UUZGb1RGVTEw?=
 =?utf-8?B?aklrcVlIVitxaDc4VUJvOFMyOXRGeHB5VWJkSWwzYTdHbCs4ekZUdHNsSkR5?=
 =?utf-8?B?YTNCMWpjdWVQZnhVcC8zZ0tuM1IzdDlFTGdHWUE1VXRQS0lmNGtaL1c1MDJL?=
 =?utf-8?B?YnFObjQveVAzNHBhWjFXZ3VldG45VExaS2JFbWlqZDd2UnFMNVBpUFhFQWxh?=
 =?utf-8?B?NzdiWTFUYXgwRHF4VUFUdUhhSG93VStXdnlCQUhpTytoc3hqUWw3dit4enpx?=
 =?utf-8?B?ZUtsd1hHaVVxaFAxbnU2aFNVaVk4YzFxWlFQTnRsQkU3Q1hUVWI4WHFiSGJz?=
 =?utf-8?B?MUVyL3k2NUVIV2paUmxlZEV2S0R3dUNnNUJxWGd1Vy9FWmVldnpuYm82eW5B?=
 =?utf-8?B?QWZCcFlkQ2trbGJYckxaVzI3dkhRN0o0M2s1dEdqK1ZwaXNST3VIQXlzeTVr?=
 =?utf-8?B?U1pGNTZRM29kMk1UYzBnRFlhSHRHdUV5RWJXQ2c4cnUzYkprVU9pMGlKcERs?=
 =?utf-8?B?RWlPaEk4TGJSUExWNzFaWTU5N1kwMHBHRnZIVXpsclRUcnlaQ1dDSVh1QjZW?=
 =?utf-8?B?SWh0NHBway84OHgxZkRGeGhGSzRpQ3NUK3IzaUl0dUF1YjBOVUx4NnNmM3BO?=
 =?utf-8?B?aTEwRlhLK2NwdjhtWG01cnJCT3dXTFJJUjJ4dE1UK25LcFVBZEp5WjNkMlVu?=
 =?utf-8?B?UlV5K0FCZWh3QXoxS0N0V3ZORWpoZFdIbldzaTh4Y2ptWS9leS9BMm1QQkVW?=
 =?utf-8?B?aGU3QUJnSm52cG1adjdIYTdaTVUyMEF4dEgyVkFQcm1mNldxYm16Umc1NFBG?=
 =?utf-8?B?YU1MUm9pUW5Ja1ltSHB1QXc0dUUySWVuNWlVVGwzNG5uUHVleGN6RTVtWkx2?=
 =?utf-8?B?QXhNbThUU1JwOEVzZWJYSGZqTzdyZjNaaWZ6aGhoSkF3S3czeXUybXl1M1kv?=
 =?utf-8?Q?Xg0docBK4XznPoZuzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64478ec-ec02-4dc9-9515-08d91f65d55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 10:14:07.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLrmAya+tknSX/eMUQNgE2aWbB/KNmiK0UcAmoQK/gezTOJxgKtXDhNbzFVZfOKXVYAK2SBmzXG7Nr3O+a5GnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5621
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQ2hyaXMsDQoNClRoaXMgaXMgYSBrbm93biBpc3N1ZSByZWxhdGVkIHRvIGZpcm13YXJlIGFu
ZCBpcyBleHBlY3RlZCB0byBiZSBmaXhlZCBpbiBuZXh0IHJlbGVhc2UuDQoNClRoYW5rcywNCktp
cmFuDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpcyBDbGF5
dG9uIDxjaHJpczI1NTNAZ29vZ2xlbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNSwg
MjAyMSAzOjI4IFBNDQo+IFRvOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBWb24g
RGVudHosIEx1aXoNCj4gPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4NCj4gU3ViamVjdDogQlQg
SW50ZWw6IFJlZ3Jlc3Npb24gbG9hZGluZyBmaXJtd2FyZSBpbiBsaW51eC01LjEzLXJjMw0KPiAN
Cj4gSGksDQo+IA0KPiBJJ3ZlIGJ1aWx0IGFuZCBpbnN0YWxsZWQgNS4xMy1yYzMrIChmcmVzaGx5
IHB1bGxlZCBmcm9tIExpbnVzJyB0cmVlKS4gT24gYm9vdGluZw0KPiBpdCBJIGZpbmQgdGhhdCBu
b25lIG9mIG15IGJsdWV0b290aCBkZXZpY2VzIGNhbiBjb25uZWN0LiBJbiB0aGUgb3V0cHV0IGZy
b20NCj4gZG1lc2cgSSBmaW5kOg0KPiANCj4gWyAgICA4LjE3MDMzMl0gQmx1ZXRvb3RoOiBoY2kw
OiBGaXJtd2FyZSByZXZpc2lvbiAwLjAgYnVpbGQgMTIxIHdlZWsgNyAyMDIxDQo+IFsgICAgOC4x
NzEzMzldIGJsdWV0b290aCBoY2kwOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgaW50ZWwvaWJ0
LTE5LTE2LTAuc2ZpDQo+IGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+IFsgICAgOC4xNzE4NzFdIEJs
dWV0b290aDogaGNpMDogRmFpbGVkIHRvIGxvYWQgSW50ZWwgZmlybXdhcmUgZmlsZSBpbnRlbC9p
YnQtMTktMTYtDQo+IDAuc2ZpICgtMikNCj4gDQo+IEFzIHlvdSBjYW4gc2VlIGl0IGlzIGxvb2tp
bmcgZm9yIGEgbm9uLWV4aXN0ZW50IGZpcm13YXJlIGZpbGUgaW50ZWwvaWJ0LTE5LTE2LQ0KPiAw
LnNmaS4gaW50ZWwvaWJ0LTE5LTE2LTQue2RkYyxzZml9IGRvIGV4aXN0IGFuZCBib3RoIDUuMTIu
NiBhbmQgNS4xMC4zOQ0KPiBzdWNjZXNzZnVsbHkgbG9hZCB0aG9zZS4NCj4gDQo+IElmIEkgY3Jl
YXRlIHN5bWJvbGljIGxpbmtzIGZyb20gdGhlIGlidC0xOS0xNi00IGZpbGVzIHRvIGlidC0xOS0x
Ni0wIGVxdWl2YWxlbnRzLA0KPiByYzMgbG9hZHMgdGhlbSBhbmQgbXkgYmx1ZXRvb3RoIGRldmlj
ZXMgd29yayBmaW5lLiBJIGNhbid0IGZpbmQgYW55IGlidC0xOS0xNi0NCj4gMCBmaWxlcyBpbiB0
aGUgbGtpbnV4LWZpcm13YXJlIHRyZWUgb24ga2VybmVsLm9yZyAob3IgYW55d2hlcmUgZWxzZSBm
b3IgdGhhdA0KPiBtYXR0ZXIpLg0KPiANCj4gSSBsb29rZWQgYXQgdGhlIGNoYW5nZXMgaW50cm9k
dWNlZCBpbiA1LjEzIGFuZCBmb3VuZCBhIGNvdXBsZSBvZiBzdXNwZWN0cyAtDQo+IGQ2ODkwM2Rh
NGUyMjBkMWU2YjdjNmVjZGI4NTNjMzYxNDRjNmFjYzkNCj4gKEJsdWV0b290aDogYnRpbnRlbDog
Q29uc29saWRhdGUgaW50ZWxfdmVyc2lvbiBwYXJzaW5nKSBhbmQgaXRzIHBhcmVudCBjb21taXQN
Cj4gMGE0NjBkOGZlMmRiNjg4NzE2OWExOWIwNDhlYTBjOTBmOGJkYzNiNw0KPiAoQmx1ZXRvb3Ro
OiBidGludGVsOiBDb25zb2xpZGF0ZSBpbnRlbF92ZXJzaW9uX3RsdiBwYXJzaW5nKS4gQm90aCB3
ZXJlDQo+IGF1dGhvcmVkIGJ5IEx1aXogQXVndXN0byB2b24gRGVudHogYW5kIG1ha2UgY2hhbmdl
cyB0byBjb2RlIHRoYXQNCj4gcHJvY2Vzc2VzIHRoZSBmaXJtd2FyZSB2ZXJzaW9uIGRhdGEuIEkg
YnVpbHQgYSBrZXJuZWwgd2l0aA0KPiAwYTQ2MGQ4ZmUyZGI2ODg3MTY5YTE5YjA0OGVhMGM5MGY4
YmRjM2I3DQo+IGNoZWNrZWQgb3V0IGFuZCB0aGF0IGxvYWRzIHRoZSBpbnN0YWxsZWQgZmlybXdh
cmUgZmluZS4NCj4gZDY4OTAzZGE0ZTIyMGQxZTZiN2M2ZWNkYjg1M2MzNjE0NGM2YWNjOSwgaG93
ZXZlciwgc2VlbXMgdG8gYmUgdGhlDQo+IHRoZSBjaGFuZ2UgdGhhdCBicmVha3MgdGhpbmdzIGJl
Y2F1c2UgaXQgdHJpZXMgKGFuZCBvYnZpb3VzbHkgZmFpbHMpIHRvIGxvYWQgaWJ0LQ0KPiAxOS0x
Ni0wLnNmaS4NCj4gDQo+IEkgY2FuIHByb3ZpZGUgYW55IGFkZGl0aW9uYWwgZGlhZ25vc3RpY3Mg
b3IgdGVzdCBhIGZpeCwgYnV0IHBsZWFzZSBjb3B5IG1lIGluIHRvDQo+IGFueSBlbWFpbCBiZWNh
dXNlIEknbSBub3Qgc3Vic2NyaWJlZCB0byB0aGUgbGlzdC4NCj4gDQo+IEluIHRoZSBtZWFudGlt
ZSwgSSdsbCB1c2UgbXkgc3ltbGlua3Mgd29ya2Fyb3VuZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+
IENocmlzDQoNCg==
