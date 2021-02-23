Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 22:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F5764E79
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhBWWv5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:51:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:36247 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbhBWWtg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 17:49:36 -0500
IronPort-SDR: ULJZlgYOeMS/8xt7dO6z2HrzU4kGtkhTShvmNbN/gor9btfkmkLE+xLA3zGiPxL9YsqHVQJjHo
 xUPJCJQP/ghQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246391814"
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="246391814"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 14:48:38 -0800
IronPort-SDR: KLtC2SNcd4hfTMqfK3XF1Bb/khAwBRP65HHYmLTouRfE8+cDvqPuTkNs3syY7xSFptBTfjVjZu
 WxPqIT6d1V4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="366752841"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2021 14:48:38 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 14:48:37 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 14:48:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 14:48:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 14:47:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAHdrkTB+QzX6QK2Ub3tmnDHLNP1v63EI64nE151Byg3lkbN/iGX4M9LESpjpKlKYw/kglbgsncTX3vrKjRf1PsDY7SFwomkFv8YEyj1VrH12Ghnk/2hKefTt1Bx9KuNbP6afchP+cow/Ma9EZHXmtESYIZF5Sh/vAHRWPSfXH8xLhCYZB5G84doAHIzDqzHWXSwXqTv4BfFnhshin5rYtLiPAwG3bj3q7+UzotNiu/saOKkEXrakxTW6tlnlq7Xz18QifAbOqE0+EfBwXt9DLOU4qg8buuRnpJBPA4l2UdwwOq+2if8olfxREBIai6GPvp5wC9TxdOQVrpSSGsFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjWAMj2O83kv+5kWtYh7nKDYQeAq1Cefs1wb/kRMBnk=;
 b=LlekoPmvWIXnP0Q3SAz3PnR/jDxfbRie5i+2urIS7h6jmK0FbTbDAXCWXgXUhzEVSKiyGZ/JZMFPXBqaxxOmkJy0nuoV6p8JUCA5NEJwIt9JykqbekoBVa9c1WkDMC9lbQJLvw3uG8WUJi9ku+WKEMB770qHqbrfnKi+/2j5r3gGEE0KndTr5uNbSBK/sGENPLAyOQraQsMxYePvYKYbJRTSRt0Ji9FiWwgQphUrM8ABCYmQiTpRPl+gM+GfXOz0tZNsRipJ5IPd1l5FFgUFWG9NbTp/nW26HerjEsg65Ss/dP5soU5gMLSgKMg056oF3KUF3dzd5eIWeofQrT3O5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjWAMj2O83kv+5kWtYh7nKDYQeAq1Cefs1wb/kRMBnk=;
 b=UVvg2dDlMcykWzMv7YnYruqeTlC1Jz8nqfwXKfA84qV5nIHHwuWu0yidw3ki7gfIDuI0JT+uGE4TvguBOSk6U6MlDxw1JsQC+k5x7dB/rH/bN+snWIp0RYWeQ4WJt/JahbQ1pTdvyB7o9SM8Qhnoy4/Mu5LQzdf+arByzAMY8v8=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 22:47:54 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::4459:c317:c9b0:e822]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::4459:c317:c9b0:e822%8]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 22:47:53 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: Cleanup: replace symbolic file permissions
Thread-Topic: Cleanup: replace symbolic file permissions
Thread-Index: AQHXChuxQJem3I8kG0S5UXVsndjrGapl0YOA
Date:   Tue, 23 Feb 2021 22:47:53 +0000
Message-ID: <C03CE40E-66BF-4751-A30F-28070F616F9B@intel.com>
References: <20210223190252.483784-2-brian.gix@intel.com>
 <60355975.1c69fb81.5cce9.329d@mx.google.com>
In-Reply-To: <60355975.1c69fb81.5cce9.329d@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.45.21011103
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.164.224.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53d78b0c-17ab-46e8-b14b-08d8d84d0e79
x-ms-traffictypediagnostic: CO1PR11MB4948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB49483E5990737BEC65C180AAFF809@CO1PR11MB4948.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zszTJ1Coxn5/63QE39KkToy00mTozcdmQENDaVWcGpGCbaGFQEP6LWQYuW0Ni0UxtMDO34S9QnSkuCKdkgkBQZjHJSOnCKjlo3pChW9Ro32eCO5jjHUUiQbkMra9bW0DCWcB/y9vAthsD1Hib3CJjFnQj475njjAU1I6OIW+szZ5ZWouz68BcHAXZFoxc+LVpYUorf2P6iLMHYjic758togLn/1USWZMT7yHRQSgAAkz1szG4meHl5cvQ2pQsUoNejUqACAvThVjeUriggwD+QSiJtQ2s1EoHlyGjZZxddqnEZniVMdIXMEvO9p80qSP8AkPzIbrzKuPtvpmEjgAisZE0axFLtDRarFVMwJZvU48hykVa/0OZ1n7joXhhdGF0eAPCL2DFg1Kvnl9SvfDx5kLo9TglcR8BkwX5hgPHhhCMQB/t4yEfNXL+O/CeVutOWA2pHRHzcuidamdY6DiC7EtxFkpGyCNhiXhrPFy2DuLXJykPFpW7+wMRAbzuObi+CNIlLsPSQ0duIkbaYRn1Ry+xJVix1kt2fr/u+cJ3TEPyZtSgh65mO5jQtuf4moXJ2PNZGbt/lmrYf/dWQdGVPGK2+tJq6Ky2jIYie7Weks6gB30Gu5l2v6Zap90oioFe5BEg7x7vTrO79mi3ysQNT52R8O1zMAEdgNEsTNKRk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(66476007)(6506007)(83380400001)(2906002)(66946007)(110136005)(6486002)(478600001)(76116006)(66556008)(186003)(64756008)(8936002)(71200400001)(5660300002)(6636002)(36756003)(66446008)(86362001)(6512007)(33656002)(8676002)(2616005)(316002)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZEs0clNyRUlhendVNTBkWWNpU2RiMHgyTVdhZHhpZkRZdXVaZDlwczlTTE11?=
 =?utf-8?B?RUZlT3NaRjc5bzZQM0NCRkJZaXlqa1RZUVorRTd2V0IzcTB3RTlDVGlSaEtY?=
 =?utf-8?B?UkZ2bGlmOHlRaGNURTNCNjdWQjMwZWJpVm5YekEwdG90cVN3R1BuT2JPTGpa?=
 =?utf-8?B?L29POXEybkYrQlZJTlNBRG5iLzZMakhvZEFXL29XVG9JaUExSjFUbUw2bjR3?=
 =?utf-8?B?b3BtR2VVZ1RCUlJtWnFMRWg2aDZqZVhtSHNhdVJKbUpzeXhydHF1R01oMVR5?=
 =?utf-8?B?di9NV1M5UXQyc1pSUGIxTkxHZGVUZ28ycVFIRFhzaWI5WVlNYUd2bEp3RFNG?=
 =?utf-8?B?aXlmbGxTTjMrZlQzNU41MGhzZmZpSGMrVGZ0VGhrd2JtTDVLeEg1cGhlaStD?=
 =?utf-8?B?a3B1WWJSY0dDVUoxWUYvNzVXSmJSU1N4b3l6WU02TmZEKzkzcXRmWndQeXdi?=
 =?utf-8?B?YkpVL2lpbmh0WFdBOGE0UzhUS25wODRpTzJ2akJwVFcreEZ5VnhUcHFWckRU?=
 =?utf-8?B?TWhGRkN4YUdTUjZUYVZTS1FpWUJodXR3SjV4VnQ1MjNLaXJDRWVKenQ1QTY0?=
 =?utf-8?B?OTJUOWFVTWZCRjZiTTZuejM4eWFveHY0Uk1vYXd2VFhTdWh0QVR2dzQ1S2Qw?=
 =?utf-8?B?Z2t3eWliWEZFZEZVcGtiY2FiZzdrTGd1RU1WTk1lNWR6VHVmdC81TXdqS1JQ?=
 =?utf-8?B?VlFZb2VRdWFiY2wxOTl0OHBzREM3b29lenFDdUp5MFEwWUNJWmhLRTJsNFRu?=
 =?utf-8?B?RDQybFgyNmVObUk3Z2lzZGJRUTdERmg5L1BXTlhMRDNaUWpLT0JkKzFrR2J0?=
 =?utf-8?B?VEFNYk9VL05HOGFrcFBWY2VYdSs0M1hUYmg0V3dYbHNEcjk5SzJldW5wdXFE?=
 =?utf-8?B?WVVmM3M0aHBPRlpSb09TN1FHQ3MwOWNnWk1vWktnTVlWeGZNZFFiTTdGNEdZ?=
 =?utf-8?B?TFpkS0hiZWRETEFMR2VtUlBTdHNTWVhVUmc4aTE5dDRXV2pQYWpOOUFpeUw5?=
 =?utf-8?B?aHRwRlNIR2FGVkw3SlVESVB1MWhjVUtmVXQ5UzFlNGVmMDFiSE9RaTlEdWhU?=
 =?utf-8?B?NXg0UUdOanJ4dnhKNXZ1NkxUQUg1WUxpZERnc0ZTd1dXTGdkcWR5L2pmS3BO?=
 =?utf-8?B?bjgvZzRFeWhPQWd3cWlMSDRXcVV5Z2tZc3FXT2h0UHB6OUh1TjBhOVFqdE9M?=
 =?utf-8?B?OFNHTmhNdkl3TkRWYkY1Nlk3WjBNNU41UzFZRGtBeFQwNVFCVWxtVUl0ZEJC?=
 =?utf-8?B?cktJTitoeFB4WHRSVUMvekQ4dnJWdHdQYlB1MnByWlpFRXBTWkhsczlHRUho?=
 =?utf-8?B?aVNiN1hIRTJNQUdTRDFzcnJwRlVzMWJNbUVJOUgvTWlnandRendDanQ3M2sr?=
 =?utf-8?B?VWVGQnpFR0JoK2xzZDRFaGVkeUNsQis4NSsxQ2ViMW82ek1NTC9XNVlNV2wx?=
 =?utf-8?B?c3k2T2s2Q1BMK3U4Z1EvUUNkK0xnUEZIVitRV3B1RE9jSm9SSklRbXFTZ2ZN?=
 =?utf-8?B?MFF5WWVxVStLTC9udWFpUTFPeGhoTWpFenU2YjArcHp6VTl1aUxHczl3V3Ar?=
 =?utf-8?B?ZFhuSEFVNlZFaTFsSlhXdU40MTZwZGtjTGk1bi96RW1JR2VnbEk4TmRXZGpj?=
 =?utf-8?B?NWExaE42UzRZZXZjYlpmUEtkY2pleXdOZ3lGMXV6a0FwM0lhU0hYYUdGc2Nt?=
 =?utf-8?B?VDM4czd2MHAvaEJwL2VOendUT3RIcUZOWjh4Z21JOUtwZm0zVStPVDBheFNN?=
 =?utf-8?Q?UZZx4O09Gv+tGkEc4h+zbS+EXsyWP/hW1AAbldZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A79E03FE2D13BA4ABFC377A9F5687B89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d78b0c-17ab-46e8-b14b-08d8d84d0e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 22:47:53.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opQR+Wcvm8VA/Uhnsr8sLp7yp8m3AHxrg3F8o2JnKfrQ1o4YVBr1+PzTvHvR8lf5znLk0Gwsu3+HNz7xK6mcGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCu+7v09uIDIvMjMvMjEsIDExOjQwIEFNLCAiYmx1ZXoudGVzdC5ib3RAZ21h
aWwuY29tIiA8Ymx1ZXoudGVzdC5ib3RAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIFRoaXMgaXMg
YXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMgZW1haWwhDQoN
CiAgICBEZWFyIHN1Ym1pdHRlciwNCg0KICAgIFRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUg
cGF0Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4NCiAgICBUaGlzIGlz
IGEgQ0kgdGVzdCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6DQogICAgUFcgTGluazpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3RoL2xpc3QvP3Nlcmll
cz00MzczMjkNCg0KICAgIC0tLVRlc3QgcmVzdWx0LS0tDQoNCiAgICAjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMNCiAgICBUZXN0OiBDaGVja1BhdGNoIC0gUEFTUw0KDQogICAgIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogICAgVGVzdDogQ2hlY2tHaXRMaW50IC0gRkFJTA0K
ICAgIE91dHB1dDoNCiAgICBtZXNoOiBDbGVhbnVwIGRlcHJlY2F0ZWQgc3ltYm9saWMgZmlsZSBw
ZXJtaXNzaW9ucw0KICAgIDM6IEI2IEJvZHkgbWVzc2FnZSBpcyBtaXNzaW5nDQoNCiAgICBvYmV4
ZDogQ2xlYW51cCBkZXByZWNhdGVkIHN5bWJvbGljIGZpbGUgcGVybWlzc2lvbnMNCiAgICAzOiBC
NiBCb2R5IG1lc3NhZ2UgaXMgbWlzc2luZw0KDQogICAgcGVyaXBoZXJhbDogQ2xlYW51cCBkZXBy
ZWNhdGVkIHN5bWJvbGljIGZpbGUgcGVybWlzc2lvbnMNCiAgICAzOiBCNiBCb2R5IG1lc3NhZ2Ug
aXMgbWlzc2luZw0KDQogICAgcHJvZmlsZXM6IENsZWFudXAgZGVwcmVjYXRlZCBzeW1ib2xpYyBm
aWxlIHBlcm1pc3Npb25zDQogICAgMzogQjYgQm9keSBtZXNzYWdlIGlzIG1pc3NpbmcNCg0KICAg
IHNyYzogQ2xlYW51cCBkZXByZWNhdGVkIHN5bWJvbGljIGZpbGUgcGVybWlzc2lvbnMNCiAgICAz
OiBCNiBCb2R5IG1lc3NhZ2UgaXMgbWlzc2luZw0KDQogICAgdG9vbHM6IENsZWFudXAgZGVwcmVj
YXRlZCBzeW1ib2xpYyBmaWxlIHBlcm1pc3Npb25zDQogICAgMzogQjYgQm9keSBtZXNzYWdlIGlz
IG1pc3NpbmcNCg0KDQogICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogICAgVGVz
dDogQ2hlY2tCdWlsZCAtIEZBSUwNCiAgICBPdXRwdXQ6DQogICAgY29uZmlndXJlLmFjOjIxOiBp
bnN0YWxsaW5nICcuL2NvbXBpbGUnDQogICAgY29uZmlndXJlLmFjOjMzOiBpbnN0YWxsaW5nICcu
L2NvbmZpZy5ndWVzcycNCiAgICBjb25maWd1cmUuYWM6MzM6IGluc3RhbGxpbmcgJy4vY29uZmln
LnN1YicNCiAgICBjb25maWd1cmUuYWM6NTogaW5zdGFsbGluZyAnLi9pbnN0YWxsLXNoJw0KICAg
IGNvbmZpZ3VyZS5hYzo1OiBpbnN0YWxsaW5nICcuL21pc3NpbmcnDQogICAgTWFrZWZpbGUuYW06
IGluc3RhbGxpbmcgJy4vZGVwY29tcCcNCiAgICBwYXJhbGxlbC10ZXN0czogaW5zdGFsbGluZyAn
Li90ZXN0LWRyaXZlcicNCiAgICBjb25maWd1cmU6IGVycm9yOiBFbWJlZGRlZCBMaW51eCBsaWJy
YXJ5ID49IDAuMzcgaXMgcmVxdWlyZWQNCg0KVGhlcmUgd2FzIGFuIGlzc3VlIHdpdGggRG9ja2Vy
IGltYWdlIGFuZCBpdCBpcyByZXNvbHZlZCBieSBub3cuDQpQbGVhc2Ugd2FpdCBmb3IgdGhlIG5l
eHQgdGVzdCByZXN1bHQuDQoNCiAgICAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAg
ICBUZXN0OiBNYWtlQ2hlY2sgLSBTS0lQUEVEDQogICAgT3V0cHV0Og0KICAgIGNoZWNrYnVpbGQg
bm90IHN1Y2Nlc3MNCg0KDQoNCiAgICAtLS0NCiAgICBSZWdhcmRzLA0KICAgIExpbnV4IEJsdWV0
b290aA0KDQoNCg==
