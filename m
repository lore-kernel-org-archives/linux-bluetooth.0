Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACEC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 11:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B4361249
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 11:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbhDNLPV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 07:15:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:36479 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348858AbhDNLPT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 07:15:19 -0400
IronPort-SDR: l/hK8RrwrWIchefNIQzob7VC+joAzxZ8LyLmh26DyrFf1g3PtrZBC6+KHicgrx5o/XfWKe2c29
 W1HPD/I6Zlcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194183028"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194183028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 04:14:51 -0700
IronPort-SDR: Dmcc6yfoeXtFyBFdL/U5OtrRdBAvjhdlFQWYgzBpIvORDxgfPTPjBz/20gIf1KXHgzqPC4WjfX
 F0XVNrjsnStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="383646564"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2021 04:14:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 04:14:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 14 Apr 2021 04:14:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 14 Apr 2021 04:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDLaGfwcT7F4/pe8CBf8VBVOWMDNlxAcBb+t8MxSGtVMvL3Hj638mP+8t1vo6HlvMl9XxIv9sl2nVMEqEZr2H5k+F44Nmt9gz0OYKToJusxdp7Vf27qz37+U/RZ4knEeVJJO4PYn7HZhXLs0sV3T1jTjH5Yv6NzIz+yNe2hUWb95WhebPL/l9dVye5zWbePHLfaqyP0xbg/3FO0sqP93KvirBRuUn2itl0/XcwiKKtnOJKZ7rfCOz15PmyuDh0HV8GEwp9PVbgODnms30TCtrID8Krp5YS4JEHtfNW8VCxKQo+nEn7PIU/krJAzMsvHDC8FpMu/Kn9t5lUO0Gv15/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LhdQrmFcDw7KKomOt50o35TLG6jeKBEZ6iDmVj916Y=;
 b=F9Q6rhNVO8megXeFht+ylzan1Xm4sWcIGQU6eMJ4ce73yFVmcfN3grgSgsDjTvXLUJ+yCDyTFs3qMokmzyzO+BtNDpCzQlrOQVotKddKLGHvTSAJkRNaT/oHHvoDaVlOaXWwHffqGXkDTIWZTz5pCQoPD6CErGCgjPy4f3KAGA/6OddBz7SqDMqVF5Gbp8kjEuSwkaPc7J3/zM96qFfUvjxR8mIcsMcA7hL4BpkNoqCDDrvH3sfv3xcs4CWNG6vRo1qXCPCsBWRaTJFtirF/1GSjohJ1Wl8E5W9Bt8+tmRGNfm8D4YCnu4y6Bl22cGpYMDIm6MyoVGvuq3kaIvIjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LhdQrmFcDw7KKomOt50o35TLG6jeKBEZ6iDmVj916Y=;
 b=oudPY0dSjWYZ1S+/+dciZNhholtfykk4WzUBqXNvDd1ti2kz18u8CugVpAAo2BNbI6wM2yGkwAAhtDSaAOdm7tuX+QYFKw9pnMQ9qEZN4CZxf3c20PKEwxPR/15l1rAKGy7dpVLmJT52ykwBl74n+I/MfvFFWyxOsZt7vQt98m4=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 11:14:47 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::1b:fbd6:d110:1263]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::1b:fbd6:d110:1263%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 11:14:47 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [Bluez PATCH] btmgmt: Add support to enable LL privacy
Thread-Topic: [Bluez PATCH] btmgmt: Add support to enable LL privacy
Thread-Index: AQHXKiri+KgHBruxm0ivQNMMSE97h6qmz9OAgABRyQCADGPZ4IAAUeuAgAAR7IA=
Date:   Wed, 14 Apr 2021 11:14:47 +0000
Message-ID: <SN6PR11MB270387ED2F4DA34328CFEA8C944E9@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20210405145802.27317-1-sathish.narasimman@intel.com>
 <CABBYNZLTU1t=UEsvxsu8F0kP8f5-Nvi_Xysy8ftg57j9Snu99w@mail.gmail.com>
 <588F99C8-E5B4-47D3-84C3-72F9E6FCC9EC@holtmann.org>
 <SN6PR11MB27038FDA6A26F7A63370859A944E9@SN6PR11MB2703.namprd11.prod.outlook.com>
 <E01306E4-FDD3-4A78-BAED-1C44C3218CEF@holtmann.org>
In-Reply-To: <E01306E4-FDD3-4A78-BAED-1C44C3218CEF@holtmann.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.0.76
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [27.6.184.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 868c4010-adab-4fb6-e6c4-08d8ff3683b8
x-ms-traffictypediagnostic: SA2PR11MB4972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4972CBCDA4A0F716F717C9A7944E9@SA2PR11MB4972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R57SlxR71tvWOPuK/z2sk9oTZazHTL5HyosOrgB+fd38XAltSVHjj9ecEyol8/wnqz8YUchT8W0A8fd4pRZdbG/z+jy7RvvQrNDsyDShsN7nVYnoWZhQbgEC/KkuovNsaQ+8HbY0uTEaxy5R+fvGmDdz87sga7aCr0oU0L0UmDsMopbMz2VLPX0soQ3SQoritZE3OzM1LX3UJ1Fv9nWNxCzExlQNyXaphSz03p2eJvviz2rl1p6hcWddIwVUjKVR0BvcKRFqSwVTOMTOgmRbFnkqcUswqAEkU1a0qRgSR9oUU/PEO6vi0OKb8jngcyudAZpxBqUs+ds+H23dYxRsQxBvhOIkRiTd7QMog6xfjzJ8o1+3wOF1fBIkrEzBniI8SKgTuoDwB8p8Y6ImMg0lP6agljWnTWVauhJzXvhfrpKMSFpL/YJYKdq/6sEnOb+eBxdo74Ubu8uzVGaq4z6DA43Mm5TmNjRao96mbxaTydaYBNQHMczcgBW8SjCFy/GkexY+NBVaybvVG2zbyskRInAUPDB+9Lfe19GVuinLXmWIRy/u/ICjKZC/3ME3bFgmBuYXLfRzM12Cc4rVR2z1zm0gZAT/+QR+iMja6hy1PDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(316002)(9686003)(38100700002)(54906003)(71200400001)(2906002)(5660300002)(66946007)(52536014)(53546011)(6506007)(66556008)(122000001)(6916009)(478600001)(26005)(66446008)(33656002)(7696005)(64756008)(55016002)(66476007)(76116006)(107886003)(8936002)(186003)(4326008)(83380400001)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MENtejVxYXVkYmlhRmVNT0V3enByQlFaYWFuRnhHY3N4YktBM0Zlbm5MbVk3?=
 =?utf-8?B?RndBUDVoUFp6OEloSk5xbkpLWGN0eTdnaU9TMVhjeG5RNEhTMnZNdkpJK0ZZ?=
 =?utf-8?B?SDBWeTBTdWJjbUl1aHpybWF2MzNIWUE2czFObGFXWXU5QTBMcDRhTG9MZ3FU?=
 =?utf-8?B?VnhJVm1IY0FxcUhoM1dGV3lzeEgyMzVsY25qNEZKQUxWWVcxaCt5K0Zlekt0?=
 =?utf-8?B?YnR4TG1nTktLNzVFejJ0RWgwb1lEYmJpNytxdlZXMHh6RFB0aU1scXZHcnRv?=
 =?utf-8?B?aVlRd0hRVUFnTnEzeEtVTmxnMnI1RlhuWm5oWDkrS3pteEYxQmhkNjFweTZP?=
 =?utf-8?B?WktxN1I0R0xRdjY5b1RHMXFZNm5JRGx2cmVJSWZRQWNXRmhWdm1OTkV2eXc0?=
 =?utf-8?B?ZXh0OUhYUDBrcVFnaWIzc2lNdU1hYnZ0bERRZ2hzdUhOcnN0anl5clc5QkVH?=
 =?utf-8?B?a2tKSjBRZDNPTDhXQlpDTFdteFlnTmZnVy9zSEgvM2w5UkFzTzhEREJweXdN?=
 =?utf-8?B?QWtsaTNZZU9KdUN2NUNhK1pWVlY0Z0FXeXhTbXNGZi93K0dycVRnZk1RelNv?=
 =?utf-8?B?K0hVWmVVeUNlekFPVHRDR2MrVHZ0TG5RT2dpQVVWS0NZamZUb1RMSjZ4WXND?=
 =?utf-8?B?SUlIK0lCMjlNKzg4RmwrL3NkNGVteW1kb3puQ2t3NnZpVkFTb09VcFRKYS92?=
 =?utf-8?B?OWpSZVpPQ0Qrd2grV0VzaFdVYjI4SmtTUVFBb1Y0Skg1ZGxkZkRibDA1TU5O?=
 =?utf-8?B?MmpHUnhqUEV0N25tQnAwZXY4ZlpNS3Z0Tm9vMTRmWG1XbzdSTEtOK2R2Tktw?=
 =?utf-8?B?c3hYOTdTSUpiZUo2djhMYVRjWmErLzY2dWRQQUhUNjNuR1VpS1ZXTjdVY2lN?=
 =?utf-8?B?MytqNmdaV1diNVhIMTRPWUxKQ2dkbjQwcmxuajBRd05yL3hmZ2kvbW82RWVW?=
 =?utf-8?B?ditXaVNXc0txTTNBN1BXbElSTXo4NkhSbWg2cmNndUdtRXZrdmtLVERlMTRu?=
 =?utf-8?B?Qmk3VVFlTHJ4TEI1WTZTd1hkV1p3ZlZ2amF3ZWZDUStPelV2N0xiaExkaFEr?=
 =?utf-8?B?V2ErSm9SbEN0MDZVMkMwcDRWY3pNbS82MUdYdi9Lb3M0VzBkYnBhQVRPYVJK?=
 =?utf-8?B?L0VCbTlmejlST1BoeStMaGhjalYrUU1aYUQ1WWtYM0lCdHY0K1pxd0pYbml4?=
 =?utf-8?B?Mlpvamk4STB6ZTk0M1JydnNpMVZ5R0s2Y2s0Mk03S0YxdzhoYkZsbXRYYzFw?=
 =?utf-8?B?L1hpSnU4c2RjK1pFUGdTN1loQTkvQzNNOEJKcmNKbU95RW9McDI2bjFvcUJQ?=
 =?utf-8?B?K1FQMk93NnBUSkY1YWd3OUtQTWVCUjN0MnhGZlpXRG92VE05cXNZZTlFV0tR?=
 =?utf-8?B?cGQ5aDFzcDdyVno5ZzdEcjdmYWFYcEFyNXhTWEpZbWZSaUVIdGRid3JvbTVI?=
 =?utf-8?B?ZFkya29qTGZTekxqeFFsNVBwRThWVldac0pBRmR1RWp6R0s2YWtIM1dqVU5u?=
 =?utf-8?B?UjJkd1dQVjVjYjFkK0lmQjFVVzdGK3I0bDJPWGszQ1kzSmZkZXdJeDFabGg2?=
 =?utf-8?B?aFJnR0tsdjZRTVNHU0tpejdDeWx3blRUWVBIb2g5SStPMEg0T0htVlNhSzFj?=
 =?utf-8?B?SUtTRWxoUnZxQkxUczFGYUhPR1NCQXpNdTRLcWg5RW5RdEozSEsyUnhPU0Qv?=
 =?utf-8?B?aDd6d0ZHOUJtMXlKZXNyNm9WYlBXaTlnMTMzNW5xRTF2UDhobWhicktiUmtG?=
 =?utf-8?Q?IBavs70Fhsg1GLx7xs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c4010-adab-4fb6-e6c4-08d8ff3683b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 11:14:47.4785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXbkpFNHDTR39B5KdM2EwI5R8KYAJpWF1SAGxIHQZBD3ipxjfLoEGuzwaUlXqOb4k+RBtXQxMsmGD1VfLPf6PfYmtNKpZVvxzsyMBia8NEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY2Vs
IEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmls
IDE0LCAyMDIxIDM6MzcgUE0NCj4gVG86IE5hcmFzaW1tYW4sIFNhdGhpc2ggPHNhdGhpc2gubmFy
YXNpbW1hbkBpbnRlbC5jb20+DQo+IENjOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRl
bnR6QGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBUdW1r
dXIgTmFyYXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+
OyBTcml2YXRzYSwgUmF2aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtCbHVleiBQQVRDSF0gYnRtZ210OiBBZGQgc3VwcG9ydCB0byBl
bmFibGUgTEwgcHJpdmFjeQ0KPiANCj4gSGkgU2F0aGlzaCwNCj4gDQo+ID4+Pj4gSWYgdGhlIEJs
dWV0b290aCBjb250cm9sbGVyIHN1cHBvcnRzIExMIHByaXZhY3kgdGhpcyBjb21tYW5kIHdpbGwN
Cj4gPj4+PiBiZSB1c2VkIHRvIHRlc3QgdGhlIHNhbWUuDQo+ID4+Pj4gInN1ZG8gYnRtZ210IHBv
d2VyIG9mZiINCj4gPj4+PiAic3VkbyBidG1nbXQgbGxwcml2YWN5IG9uIg0KPiA+Pj4+ICJzdWRv
IGJ0bWdtdCBwb3dlciBvbiINCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNhdGhpc2gg
TmFyYXNpbW1hbiA8c2F0aGlzaC5uYXJhc2ltbWFuQGludGVsLmNvbT4NCj4gPj4+PiAtLS0NCj4g
Pj4+PiB0b29scy9idG1nbXQuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4+Pj4gMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4gPj4+Pg0K
PiA+Pj4+IGRpZmYgLS1naXQgYS90b29scy9idG1nbXQuYyBiL3Rvb2xzL2J0bWdtdC5jIGluZGV4
DQo+ID4+Pj4gOTNkMjQ0ZmY4ZWM4Li40YTUzYzM3NjhmZTkgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEv
dG9vbHMvYnRtZ210LmMNCj4gPj4+PiArKysgYi90b29scy9idG1nbXQuYw0KPiA+Pj4+IEBAIC0y
MjYxLDYgKzIyNjEsNDIgQEAgc3RhdGljIHZvaWQgY21kX2JyZWRyKGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4gPj4+PiAgICAgICBjbWRfc2V0dGluZyhNR01UX09QX1NFVF9CUkVEUiwgYXJnYywg
YXJndik7IH0NCj4gPj4+Pg0KPiA+Pj4+ICtzdGF0aWMgdm9pZCBsbF9ycGFfcmVzb2xuX3JzcCh1
aW50OF90IHN0YXR1cywgdWludDE2X3QgbGVuLCBjb25zdCB2b2lkDQo+ICpwYXJhbSwNCj4gPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICp1c2VyX2RhdGEpIHsNCj4gPj4+
PiArICAgICAgIGlmIChzdGF0dXMgIT0gMCkNCj4gPj4+PiArICAgICAgICAgICAgICAgZXJyb3Io
IkNvdWxkIG5vdCBzZXQgTEwgUlBBIHJlc29sdXRpb24gd2l0aCBzdGF0dXMgMHglMDJ4ICglcyki
LA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMsIG1nbXRfZXJyc3RyKHN0YXR1
cykpOw0KPiA+Pj4+ICsgICAgICAgZWxzZQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICBwcmludCgi
TEwgUlBBIFJlc29sdXRpb24gc3VjY2Vzc2Z1bGx5IHNldCIpOw0KPiA+Pj4+ICsNCj4gPj4+PiAr
ICAgICAgIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9TVUNDRVNTKTsNCj4gPj4+
PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiArc3RhdGljIHZvaWQgY21kX3NldF9sbF9ycGFfcmVzb2xu
KGludCBhcmdjLCBjaGFyICoqYXJndikgew0KPiA+Pj4+ICsgICAgICAgLyogMTVjMGExNDgtYzI3
My0xMWVhLWIzZGUtMDI0MmFjMTMwMDA0ICovDQo+ID4+Pj4gKyAgICAgICBzdGF0aWMgY29uc3Qg
dWludDhfdCBycGFfcmVzb2x1dGlvbl91dWlkWzE2XSA9IHsNCj4gPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4MDQsIDB4MDAsIDB4MTMsIDB4YWMsIDB4NDIsIDB4MDIsIDB4
ZGUsIDB4YjMsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGVhLCAw
eDExLCAweDczLCAweGMyLCAweDQ4LCAweGExLCAweGMwLCAweDE1LA0KPiA+Pj4+ICsgICAgICAg
fTsNCj4gPj4+PiArICAgICAgIHN0cnVjdCBtZ210X2NwX3NldF9leHBfZmVhdHVyZSBjcDsNCj4g
Pj4+PiArICAgICAgIHVpbnQxNl90IGluZGV4Ow0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICAgIG1l
bXNldCgmY3AsIDAsIHNpemVvZihjcCkpOw0KPiA+Pj4+ICsgICAgICAgbWVtY3B5KGNwLnV1aWQs
IHJwYV9yZXNvbHV0aW9uX3V1aWQsIDE2KTsNCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAgICBpbmRl
eCA9IG1nbXRfaW5kZXg7DQo+ID4+Pj4gKyAgICAgICBpZiAoaW5kZXggPT0gTUdNVF9JTkRFWF9O
T05FKQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICBpbmRleCA9IDA7DQo+ID4+Pj4gKw0KPiA+Pj4+
ICsgICAgICAgaWYgKHBhcnNlX3NldHRpbmcoYXJnYywgYXJndiwgJmNwLmFjdGlvbikgPT0gZmFs
c2UpDQo+ID4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2
ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgICAgbWdtdF9zZW5k
KG1nbXQsIE1HTVRfT1BfU0VUX0VYUF9GRUFUVVJFLCBpbmRleCwNCj4gPj4+PiArICAgICAgICAg
ICAgICAgICBzaXplb2YoY3ApLCAmY3AsIGxsX3JwYV9yZXNvbG5fcnNwLCBOVUxMLCBOVUxMKTsN
Cj4gPj4+PiArIH0NCj4gPj4+PiArDQo+ID4+Pj4gc3RhdGljIHZvaWQgY21kX3ByaXZhY3koaW50
IGFyZ2MsIGNoYXIgKiphcmd2KSB7DQo+ID4+Pj4gICAgICAgc3RydWN0IG1nbXRfY3Bfc2V0X3By
aXZhY3kgY3A7IEBAIC01MjQzLDYgKzUyNzksOCBAQCBzdGF0aWMNCj4gPj4+PiBjb25zdCBzdHJ1
Y3QgYnRfc2hlbGxfbWVudSBtYWluX21lbnUgPSB7DQo+ID4+Pj4gICAgICAgICAgICAgICBjbWRf
YnJlZHIsICAgICAgICAgICAgICAiVG9nZ2xlIEJSL0VEUiBzdXBwb3J0IiwgICAgICAgIH0sDQo+
ID4+Pj4gICAgICAgeyAicHJpdmFjeSIsICAgICAgICAgICAgIjxvbi9vZmY+IiwNCj4gPj4+PiAg
ICAgICAgICAgICAgIGNtZF9wcml2YWN5LCAgICAgICAgICAgICJUb2dnbGUgcHJpdmFjeSBzdXBw
b3J0IiAgICAgICAgfSwNCj4gPj4+PiArICAgICAgIHsgImxscHJpdmFjeSIsICAgICAgICAgICI8
b24vb2ZmPiIsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgIGNtZF9zZXRfbGxfcnBhX3Jlc29sbiwg
ICJUb2dnbGUgTEwgcHJpdmFjeSBzdXBwb3J0IiAgICAgfSwNCj4gPj4+DQo+ID4+PiBMZXQncyBo
YXZlIGl0IGFzIGEgcGFyYW1ldGVyIG9mIHByaXZhY3kgY29tbWFuZCA8b24vb2ZmL2xsPiBzbyB3
aGVuDQo+ID4+PiBhIHVzZXIgZW50ZXJzIGxsIGl0IGVuYWJsZXMgbGluay1sYXllciBwcml2YWN5
Lg0KPiA+Pg0KPiA+PiBwbGVhc2UgZG9u4oCZdC4gVGhlIHByaXZhY3kgc2V0dGluZyBtZWFucyB0
aGF0IHdlIHN0YXJ0IHVzaW5nIFJQQXMuDQo+ID4+DQo+ID4+IEFsc28gd2hhdCBpcyB3cm9uZyB3
aXRoIGV4cC1wcml2YWN5IGNvbW1hbmQgdGhhdCBJIGFscmVhZHkgYWRkZWQuDQo+ID4NCj4gPiBH
ZW50bGUgUmVtaW5kZXIuDQo+IA0KPiBnZW50bGUgcmVtaW5kZXIgb2Ygd2hhdD8gUGxlYXNlIHJl
LXJlYWQgbXkgcmVzcG9uc2UuDQo+IA0KDQpNeSBtaXN0YWtlLiBXYXMgbWlzdW5kZXJzdG9vZCB0
aGF0IHRoZSBjb21tZW50IHdhcyByZWdhcmRpbmcgd2hhdCBMdWl6IGFza2VkIHRvIENoYW5nZS4N
Cg0KQWxzbywgSSBkaWRu4oCZdCByZWJhc2VkIHRoZSBsYXRlc3QgY29kZS4gRm91bmQgeW91ciBs
YXRlc3QgY29kZS4NCg0KDQo+IFJlZ2FyZHMNCj4gDQo+IE1hcmNlbA0KDQoNClJlZ2FyZHMNClNh
dGhpc2ggTg0K
