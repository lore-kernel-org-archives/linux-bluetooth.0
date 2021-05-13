Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBDC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEE9610F8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 18:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEMS4I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 14:56:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:17879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhEMS4H (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 14:56:07 -0400
IronPort-SDR: AZl8ivo2reoPlBOHK6tj4wUIN20FSEjk+rI4qaPpI0/vkrTpYmQDzg4sM1jtiU+YHYeLrfe4WH
 ROkO+GaNI7qw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="196931174"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="196931174"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:54:55 -0700
IronPort-SDR: x5oiUzBQJxBwi+Vn6vYJhqfIKrjSmrpzE7sxI8gGp0z4Pb5kYsI0+ImPfcpwMYNkUhDgNVDoAW
 +FahNghPH8Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="470138479"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2021 11:54:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 11:54:54 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 11:54:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 13 May 2021 11:54:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 13 May 2021 11:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRdd5CLXYQ2jeiT8BA30TpVJlWd327l6DqZ7OQpDndZniD3I6om9ehDM4iSit003Go6ud84g0rsmILuh3+nD1MTg9V9flwuV8smxueuBD3MP1hQyxvKdyJz5iu6SipQRsv/U+VJpxKvVFRGefRk+vI9UhC83qNLwAPTM3Tjc7hhY/WU46n5tY0Zeq1pOFzFTi5/c8sXAsBkEGLfblCL96XM91SON6OAs1/cgn0RL9jhGg8oOAbbydt9oCG6O6WdkeNGMwFBqrNGlHLnqsYEJ8wFg0XWUTzIAXN/oFHAUEY3N6znWAYZLCCStBVComKF/LuaiaD8dofYd9WYJTm8uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X3OIU+H/Dk2KvROqkcV4h7kqlVJ8BI6MbTWLYRjMos=;
 b=g5b8dx11BQGJFIG3Rsn2ZnI3jjFKZAHke5QFs20l1VTpJQrt7BeNYUPNfGT13ZNnEJWOjVamwAf8D2XbqC1LcopgNmMvprPIobv89RPhnih9hsRylzzdq7lK2GVdoZPMSCGnVyX2v7iVKdN9dpgTxbbc92xtnYYcirhLwCyvq4Vq3DE8fBtAk9PHaFvBFBwEMR3/aVCSoXnCqwtfMQ4/TltA1BRR47r5M1L/Z/1/B2x1NKdB3lcF1GRwjlXdBrt4c0ntUoVx6S1U0Gf61vKPq0Yy4IPG4iw6D0S6OXgZfOEDhhOhaxDN24nXO2HGzdb9r8FnfbH+M+u5ngqe7HbW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X3OIU+H/Dk2KvROqkcV4h7kqlVJ8BI6MbTWLYRjMos=;
 b=VdeyYiLMrDDcT++ZnEUER+qDFoVj2vcm8NNyIj3Pyqs7Mn5O9uevWoPtXtui067ypiefNHK6/27LSra6lzKaHm3q2xNKyVMtjKQRmNr6bTVQG6YtpyO1Pz6ZtKnKMMiaoY7bYX81AYSE37Y5/hqDBc1IVaBHSS+6w9UdiIuhVyg=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3536.namprd11.prod.outlook.com (2603:10b6:805:d4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 18:54:52 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15%7]) with mapi id 15.20.4129.028; Thu, 13 May 2021
 18:54:52 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add missing "storage" option to help menu
Thread-Topic: [PATCH BlueZ] mesh: Add missing "storage" option to help menu
Thread-Index: AQHXR79hpeFpj2Gh8EOdlIs7m0asLKrhw2eA
Date:   Thu, 13 May 2021 18:54:52 +0000
Message-ID: <e0826dfc4fa173ce3f3037e42ad659c72045f03d.camel@intel.com>
References: <20210513061516.114889-1-inga.stotland@intel.com>
In-Reply-To: <20210513061516.114889-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5dfb17f-2c2f-40b6-df7b-08d9164097b2
x-ms-traffictypediagnostic: SN6PR11MB3536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3536D614E70936C5A5A53F82E1519@SN6PR11MB3536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: et+tTdd/skT8NkHRfi57hHrbhh3yCfiES+paO3U+gkPJpr2sBWbhSv/jZgrAAPjhCud4z34Gwn0WR/Q1tsfNjOE1uN2G6Bni3YQujHAoGVbAc2lF1DIa0QUsQ6MYGnMFBsfQElnORYn2oUSyP4m66L3r4YAstEsBqarvN467r6woTrk6M81w0JYKq+1bZxOJl7ebx7QbZ/JuyZeldihFB5A7M6VR9/bzQoplm3+/t1Ll40n6QyrVgh4XLjI3oP0L+fIOgYJUtnlkOMCeBZ6WJKQt25bEYhxlcViyDVIU1dNgoL4B6mLzkMHNRm2flXwDG3070NzTZNd2DhY9c8d1j/caDpL64Gg67YVWWjK6M7F2FqjK5ICPvCNVfNtXYKFQg/IagL/71phBU+0ytYr29BNeJ5eJadWOk7pg3HHVZvNEPB3dz5TRkisS1nRgXRUBjXb/IUzVSxwr2/Oz3OAcJofF1ZjxNUYOTsB2erH2HIqkvo9HZ04ks5bG4oy0lGnwNASZRKIN7UzKLX3M5KJFENXIiaY4ovqSiXbSEBRWQhcF13Eg5AUfBoYPP1JWzkgVewUwfoZmnZUAfHcQT9qDM6oXQ93z9/4rUHPvE5hAbe8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(136003)(346002)(2616005)(66556008)(36756003)(91956017)(26005)(71200400001)(4744005)(5660300002)(110136005)(86362001)(66446008)(76116006)(66946007)(316002)(8676002)(122000001)(38100700002)(2906002)(6512007)(6636002)(83380400001)(478600001)(8936002)(6486002)(6506007)(64756008)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZHFTS3JXNHU3NitQUVljT2p1bVdUL1BlM1FKM3owbmdOdnlHNnIxUzlZZzdi?=
 =?utf-8?B?S3lQSUJtU053MUpRUDZmMko5V2x2ZTc5RWM0NnVsUkkxdGlXN0F0K1BRancv?=
 =?utf-8?B?T1hhZTBKNlgvU2t5TWV3emhpMFdvOWtaWTRyZDM4c1kxYnkybDJ0UmJ2QXVQ?=
 =?utf-8?B?NG9NakZEU2JYcEdRTkpMaFYzSWV4OXBwdHJ1WVllcTlkZkV6QnU2SUxLUlBk?=
 =?utf-8?B?L2liOVRnaTlGamhBM1FmeWQ0b2RLbXRuVjJUVXdzekMxNGJZVEI5ZnhYSTBj?=
 =?utf-8?B?Tjd3R282Y2s5eFpYZWo5MFBNaW5qS0tFZGprZEZOQXdnOG5uMWtWdkJxWWJn?=
 =?utf-8?B?ZHBSRGdEWHh3UjRJZ01SRTU1aGFLYTk1OXd0bjZZSFVCWkdvTzFqeGtvQ09O?=
 =?utf-8?B?a2o2WVZXajkwT3BkZmhoY0g0YzBiMStTRFcwQVl3ckJlQmZUTE9jRzFWS1dF?=
 =?utf-8?B?OUtja1krYVFGSEo0TW10alcycjEzN2hIYm1KVGVBcXhEWkQveE8xa1E2V3lC?=
 =?utf-8?B?b3NOVXRncmRkVWlBTkNxRjhLblFoTndZa3hlbEVxTXZ1WUZOWlltRHJLa0lD?=
 =?utf-8?B?Z0xjVDZnYW01SythTVlCSURFR3dBV0UwWlYyMndkMStSRUcrQUoyUXdSTXpo?=
 =?utf-8?B?bWpxanBCRzBqbzVzQ2ZQZXpyTXRVcjFCK2p1UGlBVEJsRUpidVUzaHA0Ympo?=
 =?utf-8?B?REpHTUxTNlYzMytUeXh3ZlA0Sy9Pc0ZVT2ZkYlNhSG45QURCVXdqeW5sRWFz?=
 =?utf-8?B?Nkd0VGh2bHNpeGpPM0RSbURxb3l0NGUwb2cvSUFOMmVvSEhkMDM3aVVaOVVm?=
 =?utf-8?B?Z09GeTVrcGVWYmhMZVJaNC8zYXZJKzY3N3BQbURMbDlVM2NNcVZDZHVYRUdV?=
 =?utf-8?B?bmlKeWVJdzhZVEJoYTkvK2ZzVVNaNnA1ZUpNUFdjRk02NmZpVDZ1d2xRVDNT?=
 =?utf-8?B?c205ZzMwaHZjMGpIMUsybUVxT1JtQXZaSnN0Yk03TDZqQ1hoZklHNFZlOFZN?=
 =?utf-8?B?WklnWGpkWFI3dEE2SUp6K1o3SmdpRVpCdTBQVHprWWpRZU9hcmVNTEh2M3Rq?=
 =?utf-8?B?TElzNDNHSXE0RzNkVmhYTzZGQURWUU5sbUNiWTkweHdpU25MeldjK2tIdndC?=
 =?utf-8?B?TmlqRDJUbS9ud1ZNZkEwSms4eUV6eDFmcXIwS1FiZkp4emFTK1BTZTk2SEJt?=
 =?utf-8?B?bnVmV0MvQmoyNXJ6MW5PejhLSnVjZTlURVpsa3lZUUtaNHEzODJBSUM0NXRJ?=
 =?utf-8?B?NXNYQUUzMUdOM3N1alBIQVJEMjlmd3JCL2ZIV2VQN1BiaXBOM0ErOGs4ajZZ?=
 =?utf-8?B?TDg2NG1OUXBGWXI5U3VpYUFxWTN5dC9aYVp3K2Rqb2NwNjhKYjQxN2ppSndI?=
 =?utf-8?B?MmJFM2RRdjF6OFZOYWxCeXBmYWJ6RElKZDVoMEZNbnFuOS9xSVVKODhZa0pp?=
 =?utf-8?B?M0JlcGNBczB6c2tMbVd2UVpPa09GWFR6R0cybzc2dmwyVEZzK0loYyt1d0hQ?=
 =?utf-8?B?MnpKWmFVeUJYYUxLTU5YWDl5RVR3Wk9XMWJxQ3FoK0lIZGdHeVpkd3gvYU1w?=
 =?utf-8?B?YnRocjg4VWZreFRVa1lvQWRqRlZwUFBmYmQ4RXB5M29kbTl2cWp4bUN5MWM5?=
 =?utf-8?B?aHVPaU56OFBOKzZBT25UZmV3RmoyTHAvR1A3and4cU9rcW9ocGc4amVnTjRq?=
 =?utf-8?B?SnUrZ3hKSERYRFRLeFlvblA0MTFrdzZ3TlJMM0lYbnRyM1FMaXlDVVE4TXQy?=
 =?utf-8?Q?Ms3eFeEZPYWNv6r/bIaWk/ke0jWL9UBUNB68Kz5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9205F3B5681ACF468514578A0959353D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dfb17f-2c2f-40b6-df7b-08d9164097b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 18:54:52.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHhFh9KwED+OTHIZaoF0DH5Q/0ixiIg4hV2xhL3nm4xbPbucA1NxSgl4q5Bwd/UhPAIi2iDNHFp0Mm598HPLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3536
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMjEtMDUtMTIgYXQgMjM6MTUgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgYWRkcyBhIHByZXZpb3VzbHkgbWlzc2luZyBlbnRyeSBmb3IgInN0
b3JhZ2UiIG9wdGlvbg0KPiB3aGVuIHByaW50aW5nIHRoZSBkYWVtb24gdXNhZ2UgaW5mby4NCj4g
LS0tDQo+ICBtZXNoL21haW4uYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tYWluLmMgYi9t
ZXNoL21haW4uYw0KPiBpbmRleCBhMTM4NjZkN2UuLmRkOTljMzA4NSAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9tYWluLmMNCj4gKysrIGIvbWVzaC9tYWluLmMNCj4gQEAgLTU2LDcgKzU2LDggQEAgc3Rh
dGljIHZvaWQgdXNhZ2Uodm9pZCkNCj4gIAlmcHJpbnRmKHN0ZGVyciwNCj4gIAkJIk9wdGlvbnM6
XG4iDQo+ICAJICAgICAgICJcdC0taW8gPGlvPiAgICAgICAgIFVzZSBzcGVjaWZpZWQgaW8gKGRl
ZmF1bHQ6IGdlbmVyaWMpXG4iDQo+IC0JICAgICAgICJcdC0tY29uZmlnICAgICAgICAgIENvbmZp
Z3VyYXRpb24gZGlyZWN0b3J5XG4iDQo+ICsJICAgICAgICJcdC0tY29uZmlnICAgICAgICAgIERh
ZW1vbiBjb25maWd1cmF0aW9uIGRpcmVjdG9yeVxuIg0KPiArCSAgICAgICAiXHQtLXN0b3JhZ2Ug
ICAgICAgICBNZXNoIG5vZGUocykgY29uZmlndXJhdGlvbiBkaXJlY3RvcnlcbiINCj4gIAkgICAg
ICAgIlx0LS1ub2RldGFjaCAgICAgICAgUnVuIGluIGZvcmVncm91bmRcbiINCj4gIAkgICAgICAg
Ilx0LS1kZWJ1ZyAgICAgICAgICAgRW5hYmxlIGRlYnVnIG91dHB1dFxuIg0KPiAgCSAgICAgICAi
XHQtLWRidXMtZGVidWcgICAgICBFbmFibGUgRC1CdXMgZGVidWdnaW5nXG4iDQo=
