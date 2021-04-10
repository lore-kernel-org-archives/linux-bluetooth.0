Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B75610CB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhDJRdt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:33:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:3227 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234761AbhDJRdt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 13:33:49 -0400
IronPort-SDR: WRX5hKrjBgsatEQV0y8YAfwnDMr8rNpWoJDMnVJZfhL7ksrsacemO/d4WVT4iJED09rQoxcKua
 4L9bMOz1p3Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="279233134"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="279233134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 10:33:32 -0700
IronPort-SDR: H0dwnUWuamsWZ1O3Ekjzke0M/6aj58HfpPVddTh05lUWokqSF9thFWzfMr1kVESuB5f8r6hNeO
 L7V2kysV08+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="520647496"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2021 10:33:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 10 Apr 2021 10:33:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 10 Apr 2021 10:33:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 10 Apr 2021 10:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFLH0tKg5/hRkzcmvocg/dDv13iqk0rg58h4Fk5jHfzb7CuWCijT+54bSF/+acanq3EmDxTTfUEXmqSPNVi+ugJFzkhrItdexAHlKjWvucEUkkA3PIHSu3aoggnh8YUK85ICkBVGGbweCNV2kk5HwBuYabfUExTrMm+4uptv6jnc/ghlE7ujPeBRhaEjOyTfrJqjmdPWdOfK+5Pel7Bf9NldTNrgWG666MNZqfhPXxmTYoBG4gj5qKTOLjK25irIUQltHQnl8E5p0/fxdXTCf11cwrGkTHQySNsEjb2DR1imXgCCoyI+RkEYtEKCVUazLrV16NIojnn67+KBbSuUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO1icRCHZd3VrmQXA78paaYsepIoytNj06uywB1AT1M=;
 b=T6JDAl7aDySI3n+wG+9+dmCB7A0vudLiKkmCJcPRaw2LixJHA8Yow6Yha8HHJED5jqBWS32iKjxcG2PRZ1xVnLZ9xAOS5ExFdmjQkyzBCekycfTcw+Aar+6BpJodkeayAxCTkol7AM+3pg6r95if9YYaYFNZ/mgVv0MEGT7mC3RIMplQFqfZDdvT3t58Wv3/1/g1ol2pXdY2sDnS54wZrLgV1p0yZRDkXnlG05jHTMMnNS6no4MmrP/paQPNaCnw7xViHLnb3Bc7wYarDL6yQyF2jKRDBe2pDvzuyhEp90sT2+dFxak2mokSpO1AVvcMQxqfvNIpDjNQ1nXKYdUyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO1icRCHZd3VrmQXA78paaYsepIoytNj06uywB1AT1M=;
 b=RFY7iY57Kc8cpQYSEvrcx6CJqlRvInBUwFAFLsmQMNh3QG7e2xq6zHYSFMkK7HYBbVmrG5AF7DNkP1I+NFvdGhkrgcI7PqOV0KmZ/O39vejRZqCKJrADnY0gtmlOD6VBaoqAFosYI3hbmdAdK725m9yCshigsYFLukmKoBAFlqg=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1983.namprd11.prod.outlook.com (2603:10b6:300:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sat, 10 Apr
 2021 17:33:31 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::38b0:a2db:ebb4:44d]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::38b0:a2db:ebb4:44d%3]) with mapi id 15.20.4020.022; Sat, 10 Apr 2021
 17:33:31 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v4 0/2] Framework for non-interactive mesh test
Thread-Topic: [PATCH BlueZ v4 0/2] Framework for non-interactive mesh test
Thread-Index: AQHXHP/X2/RcbkOUJk63sRrA9TjEmqquJT4A
Date:   Sat, 10 Apr 2021 17:33:31 +0000
Message-ID: <21ab921ca32252baaf7caf316f45a4585ba342ce.camel@intel.com>
References: <20210319203825.459070-1-inga.stotland@intel.com>
In-Reply-To: <20210319203825.459070-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79c13eaf-ee37-4de8-7e3b-08d8fc46c26f
x-ms-traffictypediagnostic: MWHPR11MB1983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1983CCBE2E954AD8ECF90244E1729@MWHPR11MB1983.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWwfnBcPDyzdsv6Ou5U+hOWxBiw0yySBsJYXnVnR0fF7cSI+PQwXN/vDN23SbId2juRPPOhdOGRfidULe6hs8ppW9jHbhj4By+mLdNcFmDKNvM0Xg6egndvBjK+GVY0hwJm53CmC2FZ0nBvxTXOd9emxcDOuTYAr+WFftbnkTxSWmDK1lk57U9/sZDuU9PlaoZeYybvl1cHW6+z0Ylb6B49w4QMjmxX+nTjJMBYqb2nUZFPPVELOsekkMsbqxK/2QJQOQe6w0ix9dt8UwCPrpYiNSMtWpsZQiX56c9KqCsAGGGW+rXkMjL34iadGVlpZwf3jzq8Nr0myYlbseWL2o1VfYwL9k3iOU0I8nWmaitGSSIC1YrHT4IMYUnfIhkGrI98HHmGGMWOI7cWDft/i3OZHIPC7Ioo8cgmNFfHtqls/lN3p2cZLwUSJKcAAe19SxHW2AwjmZedTstaPUBdMf5UgVzn8x8cizwlKIIugVkO3oCHH3MxAsrHiUeCJhYFKd+oS55ZOaMAgM6nVDuTeo3GTKDpYxDew6zQE+aLMFR9MjaeS7rUdAJDGD0l9WaSdr+LvJHrCZXJ+aNy4CHqJXSxyON1WB5uVaAA1T91xIFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(36756003)(6486002)(316002)(2616005)(26005)(110136005)(6636002)(6506007)(186003)(2906002)(6512007)(71200400001)(66556008)(8936002)(86362001)(83380400001)(478600001)(66446008)(66476007)(76116006)(66946007)(64756008)(5660300002)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDljbVRlclRHcXNJU3JOQmUzdXdENEQwSzgycXZqZUxiNzFET2k0UFpraTZN?=
 =?utf-8?B?U0pSa1hLMFJhOW0vQ1ZnWXA4VllMcUJmVE0yd2RrczJvZEdyZFA4SnQ0SnpS?=
 =?utf-8?B?VTc4M0trNVQ4NUhCbVV6cU01Mm50UzdOblI2SjNYUTk0NnVPT2dLWDVVY28w?=
 =?utf-8?B?RnR5d2VjbndEWUpSWGs3dkZjcXdjV3huVWlaNFJSSVZBd2tmbmZHRDY0QU5M?=
 =?utf-8?B?Z1BWWjVacG5yb1hkdjFFamJmWFRLb0pZSm1QS0hwSzBKU3FXQ3JkQm9ySWFO?=
 =?utf-8?B?OFJyS1J0K1o0bzhPWEhSQmdTWEdHdzNXRnVIOFcwSmNkOVQ1d2NmQlhIOFFQ?=
 =?utf-8?B?ZzQyMFEwZDhNdjVXODJsNVpQdXJtaDNYUmJsTUJjSFNCaVhyWXdhMWE1TzNx?=
 =?utf-8?B?YUIwUTJYTmExNEN2MmVWOTllblkzNEZwTFFKVDhFV2hMdVFIOERtbFlNUExD?=
 =?utf-8?B?QUt6WkdNQmF1K3BMMUplQU1kV3V6SWE4ZUZDeGlQQUZBRWpTM0tnaFc2NWJa?=
 =?utf-8?B?R1haRkQwdVNYSHlFZ3RxQ09EcTlTcG5DV3V4SHlZVEVsMGw5cml0YldmaXY3?=
 =?utf-8?B?UTI0VkY0TmhmZ0NiRGdjbWRJUGkrTGlsRXBpd3dYTjhBTEc1L2Zya2xqRUVu?=
 =?utf-8?B?VEp5SlVsdmlkSTBic0tFV2NwSFFsVUtUa0p1NStIV3BJbTVMbERMR05IT0J3?=
 =?utf-8?B?YlpRTFB1WVI5VGtrRGZsTlhrZ3FTREN4Q0p0UnVQYmJYbkh3V0dINGw4VzVN?=
 =?utf-8?B?akJLWE1xNVZaM1RyRnd3dzlDeGtFVXdtNVRDYVRKRU5pMitKT3k5a2hKbVBl?=
 =?utf-8?B?ayt0eGZxdnNiZTlwdVIvQi9OMm1zdjZPQUh4TXdWa2RhYXdQSHhobjBFYzBx?=
 =?utf-8?B?cEk2elpvNUJvTmFTUmFEWVBTblVjSkthUlFNSitCcVhUaVNVRlNMSHpzK1Ns?=
 =?utf-8?B?d3pNL3lORHFyN1ZXN0U5dXVVdUlCdGNkUWVhMkpRUnJNWGpLWXlqTVpabTN5?=
 =?utf-8?B?V09kdkIxNlZBeVF6MU0wVnhhazRNa0llc1FlYWVkWE5kUzJqdUxZOWFhMHVD?=
 =?utf-8?B?SmY1NDlTeStKR2kwSlNpTHQ1SExneUk2M3l4MUx0UkJxc1NYRG5oQTV1bUZa?=
 =?utf-8?B?WDltT0x0VW9xZHc0RzU3NG1hZWZYYURvSlVZbVRLYkwvZjAwdGR1QXhaOWc0?=
 =?utf-8?B?OS9iSGdBdjZmOU0ycTE2NjYzZ1VlOW13T0dZR3h1bGs1MGRsVWRTM0w4eW5E?=
 =?utf-8?B?MnY2RUdjdVp5dW9NTldaRmcrejc5bXNFMWt0ZmtPM0dTQzhhVFlHU1AvRUxG?=
 =?utf-8?B?aXZlMlVoSnFKVW5leXVnSGMwdjVjekFZWWZ2MUZCenV5ZkVKUkhOOUl5cW82?=
 =?utf-8?B?WEdXQ2d2bHBZSXdQa2NKQ0JyNzVZZW9YYVA2L3ZqUVlrREcyRndZOXlTTEk3?=
 =?utf-8?B?NXZCTDBsaGlDS3dzVzROaEM2SUluMUxrdGd3Nk9UTnpZZjMySmpMZHdTSTU2?=
 =?utf-8?B?ZGxoeitBWkZsdWNla1ZtR2dLYlZmWUFraFp2NVNUYmhuVWptS0xNRllSQzNl?=
 =?utf-8?B?UW52NVRDaWtyVEpqS2Z3Ump1RWVGandKd1AvS0F6TXZ2aWM3bURLUnNBMGdG?=
 =?utf-8?B?OGc4b2t1VkVXQXdiTitoSEpmL1M0NTFPdXhPZ2U1OXR4TW9ISURvTHhmVVNj?=
 =?utf-8?B?YjhXYjgzL096bXFXdmFSQWZIRVcrSkJscEtiWHZ0S0lUSkZvMGhONFplMjBr?=
 =?utf-8?Q?kl//P3q1SawMkGe5dkmwBgaUqfvatghzrsiQNNl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7662C03057708948870536EDFEE97395@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c13eaf-ee37-4de8-7e3b-08d8fc46c26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 17:33:31.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRNxkaiHQqNkv+n7CMDshTulQrIyfwNKWhU2EFP35eS63Hy+JWMQ4j9ya/z0Agp7c+SNmOxhsJhaeVQSaC3jUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1983
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZC4NCg0KT24gRnJpLCAyMDIxLTAzLTE5IGF0IDEzOjM4IC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiB2NDogVXNlIHRlc3RlciBmcmFtZXdvcmtzIGZyb20gRUxM
IGxpYnJhcnkNCj4gDQo+ICoqKioqKioqKioNCj4gdjM6IEZpeGVkIGNvcHlyaWdodCBzdHlsZSBp
biBtZXNoLWlvLXVuaXQuaA0KPiANCj4gKioqKioqKioqKg0KPiB2MjogRml4ZWQgZXJyb3JzIHJl
cG9ydGVkIGJ5IGJsdWV6LWJvdC4NCj4gICAgIFJlZ2FyZGluZyB0aGUgd2FybmluZ3MgZm9yIHRo
ZSAiX19hdHRyaWJ1dGVfXygocGFja2VkKSkiOg0KPiAgICAga2VlcGluZyB0aGlzIHN0eWxlIHRv
IGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiBCTHVlWiBjb2RlYmFzZSANCj4gICAgIA0K
PiAqKioqKioqKioqDQo+IFRoaXMgcGF0Y2ggc2V0IGludHJvZHVjZXMgYSBmcmFtZXdvcmsgZm9y
IG5vbi1pbnRlcmFjdGl2ZSB0ZXN0aW5nIG9mDQo+IG1lc2ggZGFlbW9uIGZ1bmN0aW9uYWxpdHkg
YW5kIGNvbnNpc3RzIG9mIHRoZSB0aHJlZSBjb21wb25lbnRzOg0KPiANCj4gMS4gQSB2ZXJzaW9u
IG9mIHNyYy9zaGFyZWQvdGVzdGVyIHRoYXQgdXNlcyBFTEwgcHJpbWl0aXZlczoNCj4gICAgZXZl
cnl0aGluZyBtZXNoLXJlbGF0ZWQgdXNlcyBFTEwuDQo+IA0KPiAyLiBOZXcgdHlwZSBvZiBtZXNo
IElPIHVzZWQgb25seSBmb3IgdGVzdGluZy4NCj4gDQo+IDMuIFRoZSBtZXNoLWNmZ3Rlc3QgdG9v
bCB0aGF0IGV4Y2VyY2lzZXMgYSBudW1iZXIgb2YgbWVzaCBELUJ1cw0KPiAgICBBUEkgY2FsbHMu
IEN1cnJlbnRseSwgdGhlIHRvb2wgY292ZXJzIGxpbWl0ZWQgbnVtYmVyIG9mIGluaXRpYWwNCj4g
ICAgdGVzdCBjYXNlcy4gVGhlIGV4dGVuZGVkIGNvdmVyYWdlIHdpbGwgYmUgcHJvdmlkZWQgYWZ0
ZXIgdGhpcw0KPiAgICBwYXRjaCBzZXQgaXMgYWNjZXB0ZWQuDQo+IA0KPiBCcmlhbiBHaXggKDEp
Og0KPiAgIG1lc2g6IEFkZCB1bml0IHRlc3QgSU8NCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDEpOg0K
PiAgIHRvb2xzL21lc2gtY2ZndGVzdDogTm9uLWl0ZXJhY3RpdmUgdGVzdCBmb3IgbWVzaA0KPiAN
Cj4gIE1ha2VmaWxlLmFtICAgICAgICAgIHwgICAxNCArLQ0KPiAgTWFrZWZpbGUubWVzaCAgICAg
ICAgfCAgICAyICsNCj4gIE1ha2VmaWxlLnRvb2xzICAgICAgIHwgICAgNiArDQo+ICBtZXNoL21h
aW4uYyAgICAgICAgICB8ICAgNTEgKy0NCj4gIG1lc2gvbWVzaC1pby11bml0LmMgIHwgIDUzMyAr
KysrKysrKysrKysrKysNCj4gIG1lc2gvbWVzaC1pby11bml0LmggIHwgICAxMSArDQo+ICBtZXNo
L21lc2gtaW8uYyAgICAgICB8ICAgIDkgKy0NCj4gIG1lc2gvbWVzaC1pby5oICAgICAgIHwgICAg
MyArLQ0KPiAgdG9vbHMvbWVzaC1jZmd0ZXN0LmMgfCAxNDU4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAyMDY1IGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1lc2gvbWVzaC1p
by11bml0LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBtZXNoL21lc2gtaW8tdW5pdC5oDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC1jZmd0ZXN0LmMNCj4gDQo=
