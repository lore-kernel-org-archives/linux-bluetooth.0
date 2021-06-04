Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937CC4743E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F45F6140F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFDTbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:31:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:50645 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhFDTbt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 15:31:49 -0400
IronPort-SDR: D0i0v2TilhxAK1HpX1JPYfOUE2monTU5QKUs1o0W3Q5GGjsOEePhbt2dsOaGlWzyu+pd7wrHE0
 kr0KvtjPbn+g==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="204169617"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="204169617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:30:00 -0700
IronPort-SDR: PMQH4VObKvW9tpScWSswO+lGkU70nRbriRDYdDxZtEZEYnCac161JV3T1IHSHtwLPgVRI0SwHB
 jtg1FJHZuVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="417853762"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2021 12:30:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 12:30:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 12:29:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 12:29:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 12:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3EHdx0mcDGUHjPr39Yc+frRQ/Z1z/wu1aW42n/uF4FtL0+wsNyN6AWaYWJcV9cuvUFygVxe0XFXAbiM4NfHOehJjuXDdW12kRQo9N1yC9tMwfBQwNEmqHywVh2bYC+GgnTjoFRlS+udOUSaN+c4hdujSVasLQuDa0Ov0Ep1vbzDc4nPP1HFO1dVeOtnJuyttxIeljVDCps/hRq3suEOE1Ye+R+oxTOMmz35TceK1hZe4AmwQQMKFHn67hZmLMGLg0wJXeHBU8HS5yjxwjwZfq6kKZ2S/U6bbwWiiQE1kiXDMH6YPhNg+jZJtrHu4d3AVBfQBzy7eZFOXHboe8NEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnjXS763bGx9YMd06wvvJ96+zARWp++6ef0//iUyj34=;
 b=W+5P9UR/7bPDhz5H7E8I7q/KmO7egnUy53cgdrCc8LtOkc7nOiMtDeJY4oT7xUpPrtVWuoaIAOVliqp3H8bl8E0qKMVHbwYKgsTmmt/6Zi+wNqHhwbvb8lb+3k8HiwO2kInWwe+lc7BRlJ6bYzMtg16S9UoFyuoSmJKqG9PhLZULBwRbliY/CxfQNG8piLU+U+NNvsOrON87ffPAVE641qZBMcrR2N4lJQa0ycyjTngFn4uHbfl/1d8IdzueAwq5fbowMOZ2PMUwT6VPHNSE9YCSUMhCE/FmTrd1iTLYbP32enl5DxMTvuY4jsHk4k7CqJCiRL2rdGtJv5OJEJWyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnjXS763bGx9YMd06wvvJ96+zARWp++6ef0//iUyj34=;
 b=ezweskxp3hNC3nVmPZ3oGyA9f8hGOevJYvRH87zpAc3azhhIVLRKC2MqbPA/av4yoT+n/rXwitfEdKQ+JwtkHDelxYiIZ/bPfnDI4ZweZk8Sb3qlliwNMZjQNFEuWlqKy1KobC8kDvIPljOt4U48+38JCI6zkipZnJU/3bkCi9w=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 19:29:58 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::f00d:44c5:4e9b:e4a5]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::f00d:44c5:4e9b:e4a5%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 19:29:58 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ v2] tools/mgmt-tester: Fix expected HCI command
 accounting
Thread-Topic: [PATCH BlueZ v2] tools/mgmt-tester: Fix expected HCI command
 accounting
Thread-Index: AQHXWWtbL/+bFccxnUiQCGjST/O2VasEPSqA
Date:   Fri, 4 Jun 2021 19:29:58 +0000
Message-ID: <5d31aebb39bc10584a71df894908e16104980985.camel@intel.com>
References: <20210604175913.256979-1-inga.stotland@intel.com>
In-Reply-To: <20210604175913.256979-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7def17ae-1ce8-4ecc-2e86-08d9278f23ed
x-ms-traffictypediagnostic: CO1PR11MB5185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5185F950A5D6F078F3E38DFFFF3B9@CO1PR11MB5185.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFjLeebF8iabY9AlxOeNW926hS42KBl81tk6Y1TIRuqkbin2QRcSflFVNhdNVaS7kVPl/p7Nkm+HDC2ItgUmpYkpWmq3xz+jxfid239N3znZRsUcjdwRTcglXWYLautJDzeoDtyyUayAi2FEqFKFyvMfcPvpGHgHo7MfjSN/XqwYJTuQ7FeydpONMDeXoyo6EB9bMXiSm1t9pP3KbvzxwCNkW05bku5fds7+rBoMntoC3BbrMAHKlw/6d/pKmyl8uRz3AZplePOnoeR6JKJt5wAqnGvA0qE5DgCZcMby1mrKVJl36BibqF2z1PLpzOzDp0JxOp2Iew5JBP2oN4sdXKl5uINr10rR6tK1U/NzBIk9+EYnaAYwSpZzRmfqk7pPsGSkyirLmPq6mR/ftCdRb+Ds6iaA+aooDYOrSks3xPx4HKxZ8oBEwPlY+x329FWW2Vk7pYJ/jMKnCVGc6YAOy/3byRhY9CesXZt1xAQPnhyIxxdY+RwMfYmNcz3fTaoC3lRY/9CwNPD5newT1WhCCcGWsGkpVUK26cJ8/HqEKpbQfgM0+D6xolO7vpMPSRpvvowbAprIX2o/kaqC3q6edgtpaEiOuU57hKqOn8THqV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39840400004)(136003)(376002)(64756008)(66446008)(8676002)(83380400001)(6506007)(8936002)(2616005)(2906002)(66946007)(36756003)(186003)(76116006)(38100700002)(66556008)(6636002)(316002)(26005)(110136005)(4326008)(66476007)(122000001)(6512007)(5660300002)(86362001)(71200400001)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V1BacVA0MnVyOEh1RlJDRDcrWjhaQisxUk0wU2Fuazd0aEp6bVV0RjJVMTFv?=
 =?utf-8?B?dVRMZDVzYXdOUDNtbExMYVhBU1hkRjhSTXB2dTl2R1ZlSDhoMVVJMDBBNjh0?=
 =?utf-8?B?WEwzUDVPMnl1L25idHczSy9HdEhETTFQMUhKc0JoU1Z2aEtvenJ2NGxiRnho?=
 =?utf-8?B?aWFwWVlMc1JJYjYrQWlDd3kvbC9ZMHQyaG9uaE44dEJnZ3FHeUpBOFl3MGpD?=
 =?utf-8?B?NEw3OVlPTWVoOEN0cCtzSStUS3BBTk1KaDdKZTJGOURqVUVIS1lUVUxKNlZS?=
 =?utf-8?B?UnVLSmZTelNuOVNKQ3VTb0lQSTg0VEVKYXdSek5nbFJlcFlMdE1sT3NhTkt3?=
 =?utf-8?B?OERGOWkrYWRvL1VMY2xBcWxReGtqSDZOMnd2TCs4NUphb1NnYlk3K1NtSWdP?=
 =?utf-8?B?K1JqV25DS3RpWmdTT1VZTVZrOFNmME1lMUNIYVNpYXFUWWpRbm9vWmkwd2NT?=
 =?utf-8?B?Q3IvSmljMktLb3RUMk9xMmhNbFd2UjFCcjI2VEk1MHRCajgxSVI1a1hQeXFu?=
 =?utf-8?B?SmVXVGtpL0VZYmNDLzlUbEdmNk9RRnBLRDI3T2hsOUNIcWs3ZWdvVWxOYUo2?=
 =?utf-8?B?QnJuV1FqK3RuVFk3Ty9nRWd2Ry9zMHd1OElvU0hxZ0JlZ1ZvWGlTUG4xbXAw?=
 =?utf-8?B?MitVaWUzRTJLMTQ2cThCWFhFWk10RityM0t5eWl5WndRK3VvY3RvTTIyMm9P?=
 =?utf-8?B?aFhCYWJHUC9yRko4cnpwZC9pYnFqb3N0WUJCVjVOVG01dXpETjZkbm5ucTUw?=
 =?utf-8?B?bGZaS3poTWJWYnEvQ0lIRnJTejFLVWNNN0c2cDQxZ2dybEYrUmgvWjF1SjJa?=
 =?utf-8?B?NEJwcCtIbDRoeEZTenFscGJOVGwycURyK0lCL3JUUm5WVmJQNHROUEthd3J0?=
 =?utf-8?B?bTUzeHAySUg5UGVHd0grZE04aVByclFvcFk3RytCSmV6bTlZbTAwNEtWOE0w?=
 =?utf-8?B?MWJlbGpDa1RyZkttN0lvR2hlaGFibmY0KytjNnJNcDNNYUh4RXZ6VzVMWXFU?=
 =?utf-8?B?TnhYdWEvdzRKN054ZFdUSHgyak9TbGJOd1BBSHZZK1czS2VkYkFxc3VCVjJ2?=
 =?utf-8?B?Um12Y25EeVF6MDVPSHduRHRrckg2QUx3WjgxeTNoSzkySjhaNjZJakRNRmc5?=
 =?utf-8?B?WnpQYkJYUUVld3BIVDJpMkN5LzYrZVpBWFl6dFNka05EZHhmK1lrZW9tNXBL?=
 =?utf-8?B?Wk42NnNwUkRsYVoyVWhtbld6SHpRN0taZGdUK1RFUG9yTXNzVGpDaElhR0Vt?=
 =?utf-8?B?cVMwbitEaWNqc0wvNHRDWmlRTjRJQzFEUjQ3Z28razd0SG5JMEpCSzNtOG1I?=
 =?utf-8?B?RHdrY3VPUmpoU2pMNkRIeHBqeC9DSUgyVXhiUWIwd2J4eXdDOFR6RHNuUXV2?=
 =?utf-8?B?cnRBQ3VpeTlsdkJwNm1IOHlhc1BtMkNzQlpiYzVrb2NEWDEwOGFxVkxEeXFC?=
 =?utf-8?B?N3ZGcmlMYUY5bVVacko0bHZKT0l3MDcvTlpuUXhvemNBd3lCaFllcmc0dG1C?=
 =?utf-8?B?b3gyanM5ZktnM1hORVd6ME4zSkU4b3VBaFdLMVJCYXVGd3BmdEt1ZDRUTDVx?=
 =?utf-8?B?NlZpWmwrSjY4akpyRmNaREtYK2J6OFVIQ3hDZDBhbmozMG16RTNGeGtUTS83?=
 =?utf-8?B?ZzlsK0RiQzE2REdMSUN0OVFtdXh2d1pEalI0cmZNVXRMZTY5eUwvVUw2R2RC?=
 =?utf-8?B?MHppRUFTcHU4VDRycjJLbDJVVEhLVS9hckN1SzJZaVpvV3JBSmk1QmtKOEJR?=
 =?utf-8?Q?TSMXFwX93wzprcKUlopE8ioBLewO7Gbu1V73+Xl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C429262335A4D4B84FFCEBF483A129E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7def17ae-1ce8-4ecc-2e86-08d9278f23ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 19:29:58.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNEOxPvzf6DfeM+cylmvAujHMlESvafXcgxN4SgJj+sOy1Gd61MlV/qKt7iPjgVDHj+bmSEtoSiYB4VLTB+0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCg0KT24gRnJpLCAyMDIxLTA2LTA0IGF0IDEwOjU5IC0wNzAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIGZpeGVzIHRlc3QgY29uZGl0aW9uIGNvdW50IGluIHRoZSBleHBl
Y3RlZCBIQ0kgY29tbWFuZA0KPiBjYWxsYmFjay4NCj4gDQo+IFdoZW4gdGhlIGV4cGVjdGVkIEhD
SSBvcGNvZGUgaXMgZGV0ZWN0ZWQsIG1hcmsgdGhlIGNvbmRpdGlvbg0KPiBhcyBkb25lLiBBbnkg
c3Vic2VxdWVudCBIQ0kgY29tbWFuZHMgYXJlIGlnbm9yZWQuDQo+IA0KPiBXaXRob3V0IHRoaXMg
Zml4LCBpbiBjb3VwbGUgb2YgdGVzdCBjYXNlcyB3aGVyZSB0aGUgZXhwZWN0ZWQgSENJDQo+IGNv
bW1hbmQgaXMgZGV0ZWN0ZWQgbW9yZSB0aGFuIG9uY2UsIHRoZSB0ZXN0IG1heSBiZSBlcnJvbmVv
dXNseQ0KPiByZXBvcnRlZCBhcyBhIGZhaWx1cmUgb3IgcHJlbWF0dXJlbHkgZGVjbGFyZWQgYXMg
YSBzdWNjZXNzIGJlZm9yZQ0KPiB3YWl0aW5nIG9uIGFuIGV4cGVjdGVkIE1HTVQgZXZlbnQgY29u
ZGl0aW9uLg0KPiANCj4gVGhlIHRlc3QgY2FzZXMgd2hlcmUgdGhpcyBiZWhhdmlvciBpcyBmaXhl
ZDoNCj4gUmVtb3ZlIEV4dCBBZHZlcnRpc2luZyAtIFN1Y2Nlc3MgMQ0KPiBSZW1vdmUgRXh0IEFk
dmVydGlzaW5nIC0gU3VjY2VzcyAyDQoNClJldmlld2VkLWJ5OiBUZWRkIEhvLUplb25nIEFuIDx0
ZWRkLmFuQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIHRvb2xzL21nbXQtdGVzdGVyLmMgfCA1ICsr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWdtdC10ZXN0ZXIuYyBiL3Rvb2xzL21nbXQtdGVzdGVy
LmMNCj4gaW5kZXggYzUwNzNmZTJiLi42MTA5ODgzYWQgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21n
bXQtdGVzdGVyLmMNCj4gKysrIGIvdG9vbHMvbWdtdC10ZXN0ZXIuYw0KPiBAQCAtNTIsNiArNTIs
NyBAQCBzdHJ1Y3QgdGVzdF9kYXRhIHsNCj4gIAl1aW50MTZfdCBtZ210X2luZGV4Ow0KPiAgCXN0
cnVjdCBoY2llbXUgKmhjaWVtdTsNCj4gIAllbnVtIGhjaWVtdV90eXBlIGhjaWVtdV90eXBlOw0K
PiArCWJvb2wgZXhwZWN0X2hjaV9jb21tYW5kX2RvbmU7DQo+ICAJaW50IHVubWV0X2NvbmRpdGlv
bnM7DQo+ICAJaW50IHVubWV0X3NldHVwX2NvbmRpdGlvbnM7DQo+ICAJaW50IHNrOw0KPiBAQCAt
NzAyMSw5ICs3MDIyLDExIEBAIHN0YXRpYyB2b2lkIGNvbW1hbmRfaGNpX2NhbGxiYWNrKHVpbnQx
Nl90IG9wY29kZSwgY29uc3Qgdm9pZCAqcGFyYW0sDQo+ICANCj4gIAl0ZXN0ZXJfcHJpbnQoIkhD
SSBDb21tYW5kIDB4JTA0eCBsZW5ndGggJXUiLCBvcGNvZGUsIGxlbmd0aCk7DQo+ICANCj4gLQlp
ZiAob3Bjb2RlICE9IHRlc3QtPmV4cGVjdF9oY2lfY29tbWFuZCB8fCBkYXRhLT51bm1ldF9jb25k
aXRpb25zIDw9IDApDQo+ICsJaWYgKG9wY29kZSAhPSB0ZXN0LT5leHBlY3RfaGNpX2NvbW1hbmQg
fHwgZGF0YS0+ZXhwZWN0X2hjaV9jb21tYW5kX2RvbmUpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAr
CWRhdGEtPmV4cGVjdF9oY2lfY29tbWFuZF9kb25lID0gdHJ1ZTsNCj4gKw0KPiAgCWlmICh0ZXN0
LT5leHBlY3RfaGNpX2Z1bmMpDQo+ICAJCWV4cGVjdF9oY2lfcGFyYW0gPSB0ZXN0LT5leHBlY3Rf
aGNpX2Z1bmMoJmV4cGVjdF9oY2lfbGVuKTsNCj4gIA0KDQpSZWdhcmRzLA0KVGVkZA0K
