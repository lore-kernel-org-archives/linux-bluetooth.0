Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB70C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70CD60F14
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhHQDFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 23:05:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:57766 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhHQDFe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 23:05:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="238059036"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="238059036"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="423015915"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2021 20:05:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 20:05:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 20:05:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 20:05:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 20:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSREWTQibGz0AV/nB/NtBMWmExI/YuPD4wyrTkBWsFKtEQLxQo/aU4w+SlamntVzAOeGRShUlkJZ7ru3ZtPj2Z0TEjgHfrn5+ilaS9P2cFx/9R7xjr4LvNPVdtZuz++zKCegxGh8Nm90x8uhFMT4tr12SpJ8ICM2GPrPJJS3GeDO0xi0sYQB8kxndzU1kU2CmFOYo7Acb1MDQrUL1JURHMIEwOboo9B/c/nzw6248B2U/deDl0dV0jVSrn33GNoemG6tM/olHj9oN/V1UJlrVUp9AsuHaOSKLWWkbapPD6dLCHCqzU4cQ2WBNRQVKPBuK3z3GoI/49Jd29/uBXXMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGJ4KLOrM+bnqokYh6qDw3323xIc1aAqT1NyBTQCKKc=;
 b=i2sLUU88v5QGpNKS2faoTg8px8G8glPJ3lXARRyKekiFX29R/PrztldDygu1qK6AsqjOqMG5DZLeTqUEkPC86OSGyEeIclCJwNbOXqH7ZukZ2VwNUsP1wruF9eFYjgzarEkWtkz2dXxdCC2P7N+8NVYw5T4K/CaBCdDtqtpR55flc2fMfrMKoOJFDiES5NrUsbElj4YtIDlhrZtfYi8b+7zxzRJAhGY3Q4OR6P+zX4sjKC1FoN7dLGAWrbYhAfo1ZL/HuUt3YCRcYTn03IRKeGCPfRa9My6Km9JEk8SWS2c+PO97hK9xxeeBQcJMYGe1TLOMjcdDhR/LXuAAaKpQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGJ4KLOrM+bnqokYh6qDw3323xIc1aAqT1NyBTQCKKc=;
 b=QmvYqKcVNJ4nZ6PUtCzD3T02ruavwIow+eU87M5KZVuFqYufnT7UaUaiS6w+kr2XRAUIzDLTeNcBWAwOEI+Bd7nHkxKSKDWH9l3E+MWgZ3m73laJ9Jl8knJLl3rh/L0iMBL6zoghihwVK6kaAPd6mVz4mpwR35CwNpfNyfAjo/U=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5589.namprd11.prod.outlook.com (2603:10b6:8:26::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Tue, 17 Aug 2021 03:04:49 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 03:04:49 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH] mgmt: Set offload codec mgmt feature
Thread-Topic: [PATCH] mgmt: Set offload codec mgmt feature
Thread-Index: AQHXkWokLzUbJqvPi0GTeRammjkmwqt2sTyAgABVDoA=
Date:   Tue, 17 Aug 2021 03:04:49 +0000
Message-ID: <DM8PR11MB5573204D89E245745FDF1053F5FE9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210815001550.24643-1-kiran.k@intel.com>
 <CABBYNZL2pmpJAstAQTNLmrRoZ-sVD92k3h9N+BWHuhCkiwTqzg@mail.gmail.com>
In-Reply-To: <CABBYNZL2pmpJAstAQTNLmrRoZ-sVD92k3h9N+BWHuhCkiwTqzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9599542c-0b3f-4682-a052-08d9612bc6e5
x-ms-traffictypediagnostic: DM8PR11MB5589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB55897805ED0FC7F4EA8271B7F5FE9@DM8PR11MB5589.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6qXNZV3LQWi00Cbv2mJfc/LdUB5PiAYBbWrI3Wwkj5WO0A7iXHugdvjYkKh3nFxevyhRiYrTe+KVjVGxtxXY9K41YWPEqZCAO8YXLn9rJjE/Tnp07skHcW8Je3cS/j4myLEjgBMe4y985NsqS4JlzwuXTzOFK4/LtRC9B+tkl27hz7M41yx+ntsGhayvU3ave5wWYWa2D5OCEZQKpsxtqNCL9KxGZ+aBKFPOD6BYI46D4fVg4FMoJuYpt1QjqsYzP1HZJnsNOfS9Oh56p2zbUS83PlWetdBDvyvwepukrK4O+Foqep9Z+CFtuWse1YJvubUuhhbu97fMgX9NakFzpH3ddzTdkYELRu00KeMp4heAwzRT/pu+3Z+zz1vBGC7HpQG/vN3RTNBCEMI1CxTVh14Zu7RCAvOTV2GiTBXdT2MGAjJOL+u8gspVLOrkaIuA0VXqfOOkPEPhV8BJnw0NHnW850Updd8b9w1zFYgP9pgfw+4ubogl91YmGTIy5Kyg9dAW1jFZgQ7ASRnXOJ0k9WS8Lfc2K2Nzn6lmo663V5bmdbUqyNWE3ZPJM7iaJbuyPQahiUpnbnKyOb3RuPpF/uckjWaT0mbMGbgHhMHJO5k9zVpoALQ/+vVIqtdtrIjmt1qCdSJo2EfP1zzkvZYRhtA/dRs2jGJQIzoUntZWovvMtycAk8f1HC09eokZRBhthOb/CNgL8fwu7G3zGT3qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(316002)(38070700005)(33656002)(5660300002)(66946007)(122000001)(52536014)(508600001)(38100700002)(186003)(7696005)(86362001)(54906003)(8936002)(71200400001)(83380400001)(76116006)(8676002)(4326008)(107886003)(64756008)(66556008)(66476007)(66446008)(6916009)(2906002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0JZT0RlajdUd3hIY3dwMklVZ01sdkFPVFhxbG5IRlRHcVhPVVJEcjZFMTds?=
 =?utf-8?B?aVNFUG96UjNkcFkyRXNTQXlacFFxdXZvOGRLWUVsWlkzbVREMmh0TXF4Ri9w?=
 =?utf-8?B?YUplSU9Oemo3V29VcnpEaVhSb3NWL0VhWmRrT2oxcUl5Z2ZYMWExVXUvNVZQ?=
 =?utf-8?B?UlE5VVhpQngwa3hyWkE0aE54Z2lCSHRDNEpkS1hNUjFoa1RBVkNxVE9Ed21Z?=
 =?utf-8?B?dTlCYzM5SExWTnBDSVZqS1JBY1cvYStSQUMvUTFqc3d3UytYZXoya0wwMFd1?=
 =?utf-8?B?cnFhMktVSmIyOW5TaDJKYmxiTXIrbkJkOUNUMGNoWEhRcFNCN200cWI3QVly?=
 =?utf-8?B?WmRhUlVxamVONzdSekQrdmJ6US8rTDFoMmtqMG5UeVZLclBVL2pDVlZ4T1Az?=
 =?utf-8?B?V0MyM3BMdm9jWmlhV3NCZ2owWkJ4UE83dXlpcHhNRytWODBOMmU5ZzFSMVNE?=
 =?utf-8?B?Y0ZoRzFhcnRKWWljM3loM2c2QU80a1FLT2QxR3pNcDNEUjdrNzduMDJOaS9F?=
 =?utf-8?B?T1V5Z0dvUGc4N3VRWDlKRVF0TVpuU1pKalIwS1poUXZsRW1UL0Z5YlBPZkhX?=
 =?utf-8?B?dkJFVmx0dlpYVTh6WDVTbGQ2QmVXWGhnNjlwcnByWHVUcWQ1ZHFMWnZDOWpy?=
 =?utf-8?B?V2puTjdJWmtYbU9vc3dYN0Z2alNGU0dkNWpqZWFhRkJPUVlJKzhIdGU5anps?=
 =?utf-8?B?UE1tVXByamV5MUhnZVpLTEFza0dhL21LQnFPVUEvWHJtR0JwWW5oblgvdGVz?=
 =?utf-8?B?Z29LSk1vWlJpRFJmRUhZZ1FJaUY2M2NzOFlYUmcxTUs2U3lYRUp5QVNXZzJV?=
 =?utf-8?B?cllyZUdPUlFwcXZqaVhwZzhTU01idnBmMkF1L0VwZ21CeUlkWFRoM2lKeXY1?=
 =?utf-8?B?VnlDVnFreXk4RXJMZUt3eFRiZzZLYVdXazBCd0FaTjFTUVhxNkFwM25yS1h6?=
 =?utf-8?B?RElGRmxmT1pIVTJrcmcxajFJNEVXZ25kdnFJTmNCWTdEZVFvM00wWnR0QW1X?=
 =?utf-8?B?TDBydGNGV2lzQTF0SmpSaHRyZlllam81bG5NNW9hNml3Z0Q5Qjc4TE5VaWVF?=
 =?utf-8?B?Wml5SUYvQmFQWWsrN2lCR2g3TkYzYStXem5PY0FGTVhLVjg2QWNQVjhpWUZs?=
 =?utf-8?B?clhNZWs3dkpCdVJPeGZNdjZnd0FwOCtqek1hem9CZitEZ1FxU090ZlNuYWRu?=
 =?utf-8?B?L0l2U3VOaXlQTmNFcjJJY2ZaS09ZVk5WMjVwZFF2ZUs5SGR3RHlpY041Q25W?=
 =?utf-8?B?dGdEc1NLY1A1ZWJwSTM2bG5XWThpcDNmU3hDVFhtdWZVMWhCdTBNZk9LWmxh?=
 =?utf-8?B?djVhRlJTenB4TEdtMUVRNHBVUzdFQWp1VnpkM1V2d2VONHViVXFLZUUxY2pk?=
 =?utf-8?B?Mi9lOHV1ejdtZ3UvUVlEQnRYVGNrZkRWdHc2VFF4M0NvMGxZUFNkZ2tyWnkv?=
 =?utf-8?B?a2xRQUljQlE0eEQrZnZKcUdZK2c1bGhxZkVUL29MUFRnK1EzTDl5Rk9qS2lR?=
 =?utf-8?B?a01SRmRJR1N0VXVXaE1ZdVlXMU1hMC9kZVVMdC9kaHV0R3NCbXBiZmlPVjlZ?=
 =?utf-8?B?K3N1RnYzZDRBQW9CTmZUazBsUEExTFltQ1hHd1FEL0g1YlNsc1VTQUdFbGxx?=
 =?utf-8?B?aTg1aGpVdHQ1U1RVdXFRQVdXckUyQW5LRVI1WHQ1MUtzZ1JyOWFYY0c5VExj?=
 =?utf-8?B?c3BOQVd1Qi9pa2prVVAxUFppTUZFRXBobnRnVlJPamZvMnpwcGxYZEJ0Rm9p?=
 =?utf-8?B?RHpHaGNrNStWSHd4Y1NJWVBUdFoxSmtBS1g4WDNrMThYd2p1VzcxR3E4MmZl?=
 =?utf-8?B?clNEZHhSRUF0eG1zOVZRRVNPM3cyU0JsU3BZcUxUWkh1TElOVlI2QnJUS3hs?=
 =?utf-8?Q?Sd4A0sYqTfud/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9599542c-0b3f-4682-a052-08d9612bc6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 03:04:49.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb1qwFMM6KK8qqmB0+q5xpP5DaDogP+H/lDwqsn4v+OWJzEv3FzN+U7CVG6HtCiBtBV2JIvdSaHPmiCoI+KkRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KSSB3aWxsIHNlbmQgYW4gdXBkYXRlZCBwYXRjaCBhZGRyZXNzaW5nIHlvdXIg
Y29tbWVudHMuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpeiBB
dWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IEF1Z3VzdCAxNywgMjAyMSAzOjMwIEFNDQo+IFRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBWb24gRGVudHosIEx1
aXoNCj4gPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
bWdtdDogU2V0IG9mZmxvYWQgY29kZWMgbWdtdCBmZWF0dXJlDQo+IA0KPiBIaSBLaXJhbiwNCj4g
DQo+IE9uIFNhdCwgQXVnIDE0LCAyMDIxIGF0IDU6MTMgUE0gS2lyYW4gSyA8a2lyYW4ua0BpbnRl
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0Bp
bnRlbC5jb20+DQo+IA0KPiBXZSBkb24ndCB1c2UgU2lnbmVkLW9mZi1ieSBvbiB1c2Vyc3BhY2Ug
cGF0Y2hlcy4NCj4gDQo+ID4gLS0tDQo+ID4gIHRvb2xzL2J0bWdtdC5jIHwgNDQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9idG1nbXQuYyBi
L3Rvb2xzL2J0bWdtdC5jIGluZGV4DQo+ID4gN2Q5MDgyMzgxNTZkLi5jNWY1NWFlMTI5MGMgMTAw
NjQ0DQo+ID4gLS0tIGEvdG9vbHMvYnRtZ210LmMNCj4gPiArKysgYi90b29scy9idG1nbXQuYw0K
PiA+IEBAIC0yNTU0LDYgKzI1NTQsNDggQEAgc3RhdGljIHZvaWQgY21kX3ByaXZhY3koaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQ0KPiA+ICAgICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGlj
IHZvaWQgZXhwX29mZmxvYWRfcnNwKHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW4sIGNvbnN0
IHZvaWQNCj4gKnBhcmFtLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdm9pZA0KPiA+ICsqdXNlcl9kYXRhKSB7DQo+ID4gKyAgICAg
ICBpZiAoc3RhdHVzICE9IDApDQo+ID4gKyAgICAgICAgICAgICAgIGVycm9yKCJTZXQgb2ZmbG9h
ZCBjb2RlYyBmZWF0dXJlIGZhaWxlZCB3aXRoIHN0YXR1cyAweCUwMnggKCVzKSIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzLCBtZ210
X2VycnN0cihzdGF0dXMpKTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAg
cHJpbnQoIk9mZmxvYWQgY29kZWMgZmVhdHVyZSBzdWNjZXNzZnVsbHkgc2V0Iik7DQo+ID4gKw0K
PiA+ICsgICAgICAgYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX1NVQ0NFU1MpOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBjbWRfZXhwX29mZmxvYWRfY29kZWNzKGlu
dCBhcmdjLCBjaGFyICoqYXJndikgew0KPiA+ICsgICAgICAgLyogYTY2OTVhY2UtZWU3Zi00ZmI5
LTg4MWEtNWZhYzY2YzYyOWFmICovDQo+ID4gKyAgICAgICBzdGF0aWMgY29uc3QgdWludDhfdCB1
dWlkWzE2XSA9IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4YWYsIDB4
MjksIDB4YzYsIDB4NjYsIDB4YWMsIDB4NWYsIDB4MWEsIDB4ODgsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAweGI5LCAweDRmLCAweDdmLCAweGVlLCAweGNlLCAweDVhLCAw
eDY5LCAweGE2LA0KPiA+ICsgICAgICAgfTsNCj4gDQo+IFRoaXMgYWxzbyBzaG91bGQgYmUgYWRk
ZWQgdG8gc3JjL3NoYXJlZC91dGlsLmM6dXVpZDEyOF90YWJsZSBzbyB3ZSBhcmUgYWJsZQ0KPiB0
byBkZWNvZGUgaXQgd2hlbiB1c2luZyB0aGUgbGlrZXMgb2YgYnRtb24gYW5kIGJsdWV0b290aGN0
bC4NCj4gDQo+ID4gKyAgICAgICBzdHJ1Y3QgbWdtdF9jcF9zZXRfZXhwX2ZlYXR1cmUgY3A7DQo+
ID4gKyAgICAgICB1aW50OF90IHZhbDsNCj4gPiArICAgICAgIHVpbnQxNl90IGluZGV4Ow0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChwYXJzZV9zZXR0aW5nKGFyZ2MsIGFyZ3YsICZ2YWwpID09IGZh
bHNlKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVf
cXVpdChFWElUX0ZBSUxVUkUpOw0KPiA+ICsNCj4gPiArICAgICAgIGluZGV4ID0gbWdtdF9pbmRl
eDsNCj4gPiArICAgICAgIGlmIChpbmRleCA9PSBNR01UX0lOREVYX05PTkUpDQo+ID4gKyAgICAg
ICAgICAgICAgIGluZGV4ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgICBtZW1zZXQoJmNwLCAwLCBz
aXplb2YoY3ApKTsNCj4gPiArICAgICAgIG1lbWNweShjcC51dWlkLCB1dWlkLCAxNik7DQo+ID4g
KyAgICAgICBjcC5hY3Rpb24gPSB2YWw7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKG1nbXRfc2Vu
ZChtZ210LCBNR01UX09QX1NFVF9FWFBfRkVBVFVSRSwgaW5kZXgsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKGNwKSwgJmNwLCBleHBfb2ZmbG9hZF9yc3AsIE5VTEwsIE5VTEwp
ID09IDApIHsNCj4gPiArICAgICAgICAgICAgICAgZXJyb3IoIlVuYWJsZSB0byBzZW5kIG9mZmxv
YWQgY29kZWNzIGZlYXR1cmUgY21kIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBidF9z
aGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ID4gKyAgICAgICB9DQo+
ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIGNsYXNzX3JzcCh1aW50MTZfdCBvcCwgdWlu
dDE2X3QgaWQsIHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW4sDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkDQo+
ID4gKnBhcmFtKSAgeyBAQCAtNTU5NSw2ICs1NjM3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBi
dF9zaGVsbF9tZW51DQo+ID4gbWFpbl9tZW51ID0gew0KPiA+ICAgICAgICAgICAgICAgICBjbWRf
ZXhwX3ByaXZhY3ksICAgICAgICAiU2V0IExMIHByaXZhY3kgZmVhdHVyZSIgICAgICAgIH0sDQo+
ID4gICAgICAgICB7ICJleHAtcXVhbGl0eSIsICAgICAgICAiPG9uL29mZj4iLCBjbWRfZXhwX3F1
YWxpdHksDQo+ID4gICAgICAgICAgICAgICAgICJTZXQgYmx1ZXRvb3RoIHF1YWxpdHkgcmVwb3J0
IGZlYXR1cmUiICAgICAgICAgICAgICAgICAgfSwNCj4gPiArICAgICAgIHsgImV4cC1vZmZsb2Fk
IiwgICAgICAgICAgICAgICAgIjxvbi9vZmY+IiwNCj4gPiArICAgICAgICAgICAgICAgY21kX2V4
cF9vZmZsb2FkX2NvZGVjcywgIlRvZ2dsZSBjb2RlYyBzdXBwb3J0IHN1cHBvcnQiDQo+ID4gKyB9
LA0KPiA+ICAgICAgICAgeyAicmVhZC1zeXNjb25maWciLCAgICAgTlVMTCwNCj4gPiAgICAgICAg
ICAgICAgICAgY21kX3JlYWRfc3lzY29uZmlnLCAgICAgIlJlYWQgU3lzdGVtIENvbmZpZ3VyYXRp
b24iICAgICB9LA0KPiA+ICAgICAgICAgeyAic2V0LXN5c2NvbmZpZyIsICAgICAgIjwtdnwtaD4g
W29wdGlvbnMuLi5dIiwNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4g
THVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
