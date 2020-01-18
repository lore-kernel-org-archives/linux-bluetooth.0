Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680CC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 07:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A15E2468A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 07:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ETA9OoDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgARHO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 02:14:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:57703 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgARHO4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 02:14:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 23:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="scan'208";a="219144266"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2020 23:14:54 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 23:14:53 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 23:14:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jan 2020 23:14:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNIgiQd4aypxSSCLmBfcnHYbgMTSwQrk3aqL4Tjd92D/7QaIPblQOJZC2n4uHrUG1lNTmDHqmhLUuCvbvOiXsYnj8GpkdP1N/ah16gMC0eWzDX4zcGsFyLzCSB+Ut94vcsC53oVFSdi2E04HiYj9PLO8fCdZ0TSTZX+VGGkri8/IMt5E4HGZ0sdAzlF1+awXNUMorx6Mhw2NZ8xB53Zh6ISJPzw1rImk3E8Wzhsm8agZiO9KSYXF4D4JYJl85m82BF38rLzN+bJ1BypdIRJsmdGXyfLz/GB1D2vnWmTsImbovXXrajPexrblCSJEnNLykXqjJ9hMh5Vo8QRkJ+YdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhBcNrl0G+HMd0hYjs5tdREg9UjbZHWdnqJGkQ8SonM=;
 b=k3pKrgfnUO/9632M7O1mK6LInJw590SyMK0iuGKDLmfPdbVZjygjqRAyGQOlXtGyBhGgemT04W880qfFvans71zEjI/0iP3htk3H+7GKeZmqsdQWWnZsmfU/x0Xr805IDa/9yWmpbAQTL3F1T4075rufdUjUQs1KULowpYts9iNVc5YcbYuerRp/bDkoHnU/KIxxeas093eVXVK6ghyWEgvXfLT9ztYrHp9HI/LDxFBB0LgnJYnPxQkKLquvZpY57OMHtoTVOGRcKhNnvgU6apwv2hkbzLUeAP9jO4a3RbSCwwlONjhaEMXsYZyN25tW5odH3Q7joQQV8cp8fXE9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhBcNrl0G+HMd0hYjs5tdREg9UjbZHWdnqJGkQ8SonM=;
 b=ETA9OoDNvy5lxvVavt6XsGFhnIHMrDpQi61ZYZUCZoKCpL/ax0n+UuViD5OqvhfijfcDo9froehZWA9OxTQzytND72p5Sz89gFby2dtmvRcZhIFHOKcOSwJtDAhsD5KewTk8OV5KBeb/q9jjeox5Zn6XYYz4cm9qhWWvhMJvmL8=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1630.namprd11.prod.outlook.com (10.172.55.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Sat, 18 Jan 2020 07:14:52 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Sat, 18 Jan 2020
 07:14:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Topic: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Index: AQHVzQYdUfE8nht/UUeExx2EIxj7FqfwA+UA
Date:   Sat, 18 Jan 2020 07:14:51 +0000
Message-ID: <cebf36ec9b407070f76d2c37306ef9732c4495e7.camel@intel.com>
References: <20200117071604.20675-1-brian.gix@intel.com>
In-Reply-To: <20200117071604.20675-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00152e08-5970-488b-19d0-08d79be61c84
x-ms-traffictypediagnostic: MWHPR11MB1630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1630F0945858A4229C1538B3E1300@MWHPR11MB1630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0286D7B531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(76116006)(26005)(36756003)(186003)(2616005)(71200400001)(5660300002)(86362001)(6506007)(6916009)(66556008)(66446008)(64756008)(4326008)(66946007)(66476007)(2906002)(6486002)(8936002)(8676002)(81156014)(81166006)(6512007)(478600001)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1630;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVsiTKmYPWsFY+wmiTCxV7qAnbbVXfhvcZkrgOf2m2mn+E5btcuLS0ggbWh5RFoDBhnz9hoPkhoVsPNfvvR6mfTKk5J2Qgw1UtOYIAUFXzf/jV2XZFO4wroO9o3CUZqrTa89/u7nomP/Kk3wsLHbU36aM+g3BZYRNv0luEFgeCDkgorcfHKAF72abKjHZzwZP7bExUkE50+YD6nnwuik1Kpkdm05gPi0PwDpLmQtRka2RoqEwFTBqFLOReDhYWyo/wSmpAFMlhFTfVkeF3ny/luMfs8HlKdmKU1FsXfXCJxcLLzYNIU+knsq15A4NOf5DzMtzp1HBV8yfwJrP8h0Pf0udwE+2jrYo3pQmYirEleRPtNQd6H3T32K7MsBpWyTvbZ1FR57itSm/qxA/BgLJkFIS9jvf28ncIyKzUNuk8oHtjDUN+WB/xOVXZgt4W9j
Content-Type: text/plain; charset="utf-8"
Content-ID: <215AF55A21F4D94480BB5C8E263C0487@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00152e08-5970-488b-19d0-08d79be61c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 07:14:51.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmVQnY1EEvFfn1mk0NNqCcqx8mO8iAVsg5PmhBO7tQw7NTnAI3ZoNDaebBlccQpdvRT0OcGtEWvS6PLVZGjhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1630
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTE2IGF0IDIzOjE2IC0wODAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IEFueSBwYWNrZXQgdGhhdCBtYXkgYmUgaGFuZGxlZCBpbnRlcm5hbGx5IGJ5IHRoZSBk
YWVtb24gbXVzdCBiZSBzZW50IGluDQo+IGl0J3Mgb3duIGlkbGVfb25lc2hvdCBjb250ZXh0LCB0
byBwcmV2ZW50IG11bHRpcGxlIG5vZGVzIGZyb20gaGFuZGxpbmcNCj4gYW5kIHJlc3BvbmRpbmcg
aW4gdGhlIHNhbWUgY29udGV4dCwgZXZlbnR1YWxseSBjb3JydXB0aW5nIG1lbW9yeS4NCj4gDQo+
IFRoaXMgYWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcgY3Jhc2g6DQo+IFByb2dyYW0gdGVybWluYXRl
ZCB3aXRoIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50YXRpb24gZmF1bHQuDQo+ICAwICB0Y2FjaGVf
Z2V0ICh0Y19pZHg9MCkgYXQgbWFsbG9jLmM6Mjk1MQ0KPiAgICAgIDI5NTEgICB0Y2FjaGUtPmVu
dHJpZXNbdGNfaWR4XSA9IGUtPm5leHQ7DQo+IChnZGIpIGJ0DQo+ICAwICB0Y2FjaGVfZ2V0ICh0
Y19pZHg9MCkgYXQgbWFsbG9jLmM6Mjk1MQ0KPiAgMSAgX19HSV9fX2xpYmNfbWFsbG9jIChieXRl
cz1ieXRlc0BlbnRyeT0xNikgYXQgbWFsbG9jLmM6MzA1OA0KPiAgMiAgMHgwMDAwNTY0Y2ZmOWJj
MWRlIGluIGxfbWFsbG9jIChzaXplPXNpemVAZW50cnk9MTYpIGF0IGVsbC91dGlsLmM6NjINCj4g
IDMgIDB4MDAwMDU2NGNmZjliZDQ2YiBpbiBsX3F1ZXVlX3B1c2hfdGFpbCAocXVldWU9MHg1NjRk
MDAwYzk3MTAsIGRhdGE9ZGF0YUBlbnRyeT0weDU2NGQwMDBkMGQ2MCkgYXQNCj4gZWxsL3F1ZXVl
LmM6MTM2DQo+ICA0ICAweDAwMDA1NjRjZmY5YmVhYmQgaW4gaWRsZV9hZGQgKGNhbGxiYWNrPWNh
bGxiYWNrQGVudHJ5PTB4NTY0Y2ZmOWJlNGUwIDxvbmVzaG90X2NhbGxiYWNrPiwgDQo+IHVzZXJf
ZGF0YT11c2VyX2RhdGFAZW50cnk9MHg1NjRkMDAwZDQ3MDAsDQo+ICAgICBmbGFncz1mbGFnc0Bl
bnRyeT0yNjg0MzU0NTYsIGRlc3Ryb3k9ZGVzdHJveUBlbnRyeT0weDU2NGNmZjliZTRjMCA8aWRs
ZV9kZXN0cm95PikgYXQgZWxsL21haW4uYzoyOTINCj4gIDUgIDB4MDAwMDU2NGNmZjliZTVmNyBp
biBsX2lkbGVfb25lc2hvdCAoY2FsbGJhY2s9Y2FsbGJhY2tAZW50cnk9MHg1NjRjZmY5OThiYzAg
PHR4X3dvcmtlcj4sIA0KPiB1c2VyX2RhdGE9dXNlcl9kYXRhQGVudHJ5PTB4NTY0ZDAwMGQ4M2Yw
LA0KPiAgICAgZGVzdHJveT1kZXN0cm95QGVudHJ5PTB4MCkgYXQgZWxsL2lkbGUuYzoxNDQNCj4g
IDYgIDB4MDAwMDU2NGNmZjk5ODMyNiBpbiBzZW5kX3R4IChpbz08b3B0aW1pemVkIG91dD4sIGlu
Zm89MHg3ZmZkMDM1NTAzZjQsIGRhdGE9PG9wdGltaXplZCBvdXQ+LA0KPiBsZW49PG9wdGltaXpl
ZCBvdXQ+KQ0KPiAgICAgYXQgbWVzaC9tZXNoLWlvLWdlbmVyaWMuYzo2MzcNCj4gIDcgIDB4MDAw
MDU2NGNmZjk5Njc1YSBpbiBzZW5kX25ldHdvcmtfYmVhY29uIChrZXk9MHg1NjRkMDAwY2ZlZTAp
IGF0IG1lc2gvbmV0LWtleXMuYzozNTUNCj4gIDggIHNuYl90aW1lb3V0ICh0aW1lb3V0PTB4NTY0
ZDAwMGRkNzMwLCB1c2VyX2RhdGE9MHg1NjRkMDAwY2ZlZTApIGF0IG1lc2gvbmV0LWtleXMuYzoz
NjQNCj4gIDkgIDB4MDAwMDU2NGNmZjliZGNhMiBpbiB0aW1lb3V0X2NhbGxiYWNrIChmZD08b3B0
aW1pemVkIG91dD4sIGV2ZW50cz08b3B0aW1pemVkIG91dD4sDQo+IHVzZXJfZGF0YT0weDU2NGQw
MDBkZDczMCkgYXQgZWxsL3RpbWVvdXQuYzo4MQ0KPiAgMTAgdGltZW91dF9jYWxsYmFjayAoZmQ9
PG9wdGltaXplZCBvdXQ+LCBldmVudHM9PG9wdGltaXplZCBvdXQ+LCB1c2VyX2RhdGE9MHg1NjRk
MDAwZGQ3MzApIGF0DQo+IGVsbC90aW1lb3V0LmM6NzANCj4gIDExIDB4MDAwMDU2NGNmZjliZWRj
ZCBpbiBsX21haW5faXRlcmF0ZSAodGltZW91dD08b3B0aW1pemVkIG91dD4pIGF0IGVsbC9tYWlu
LmM6NDczDQo+ICAxMiAweDAwMDA1NjRjZmY5YmVlN2MgaW4gbF9tYWluX3J1biAoKSBhdCBlbGwv
bWFpbi5jOjUyMA0KPiAgMTMgbF9tYWluX3J1biAoKSBhdCBlbGwvbWFpbi5jOjUwMg0KPiAgMTQg
MHgwMDAwNTY0Y2ZmOWJmMDhjIGluIGxfbWFpbl9ydW5fd2l0aF9zaWduYWwgKGNhbGxiYWNrPTxv
cHRpbWl6ZWQgb3V0PiwgdXNlcl9kYXRhPTB4MCkgYXQgZWxsL21haW4uYzo2NDINCj4gIDE1IDB4
MDAwMDU2NGNmZjk5NGI2NCBpbiBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj0weDdm
ZmQwMzU1MDY2OCkgYXQgbWVzaC9tYWluLmM6MjY4DQo+IC0tLQ0KPiAgbWVzaC9uZXQuYyB8IDUw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMNCj4gaW5kZXggMzUzODhiZWVjLi4y
MTkyMTc3OTMgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0K
PiBAQCAtMjQxLDYgKzI0MSwxMiBAQCBzdHJ1Y3QgbmV0X3F1ZXVlX2RhdGEgew0KPiAgCWJvb2wg
c2VlbjsNCj4gIH07DQo+ICANCj4gK3N0cnVjdCBvbmVzaG90X3R4IHsNCj4gKwlzdHJ1Y3QgbWVz
aF9uZXQgKm5ldDsNCj4gKwl1aW50OF90IHNpemU7DQo+ICsJdWludDhfdCBwYWNrZXRbMzBdOw0K
PiArfTsNCj4gKw0KPiAgc3RydWN0IG5ldF9iZWFjb25fZGF0YSB7DQo+ICAJdWludDMyX3Qga2V5
X2lkOw0KPiAgCXVpbnQzMl90IGl2aTsNCj4gQEAgLTIyNDcsMjQgKzIyNTMsMzUgQEAgc3RhdGlj
IHZvaWQgc2VuZF9yZWxheV9wa3Qoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQ4X3QgKmRhdGEs
IHVpbnQ4X3Qgc2l6ZSkNCj4gIAltZXNoX2lvX3NlbmQoaW8sICZpbmZvLCBwYWNrZXQsIHNpemUg
KyAxKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgc2VuZF9tc2dfcGt0KHN0cnVjdCBtZXNo
X25ldCAqbmV0LCB1aW50OF90ICpwYWNrZXQsIHVpbnQ4X3Qgc2l6ZSkNCj4gK3N0YXRpYyBib29s
IHNpbXBsZV9tYXRjaChjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiAgew0KPiAtCXN0
cnVjdCBtZXNoX2lvICppbyA9IG5ldC0+aW87DQo+ICsJcmV0dXJuIGEgPT0gYjsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIHZvaWQgc2VuZF9tc2dfcGt0X29uZXNob3Qodm9pZCAqdXNlcl9kYXRhKQ0K
PiArew0KPiArCXN0cnVjdCBvbmVzaG90X3R4ICp0eCA9IHVzZXJfZGF0YTsNCj4gKwlzdHJ1Y3Qg
bWVzaF9uZXQgKm5ldDsNCj4gIAlzdHJ1Y3QgbWVzaF9pb19zZW5kX2luZm8gaW5mbzsNCj4gIAlz
dHJ1Y3QgbmV0X3F1ZXVlX2RhdGEgbmV0X2RhdGEgPSB7DQo+ICAJCS5pbmZvID0gTlVMTCwNCj4g
LQkJLmRhdGEgPSBwYWNrZXQgKyAxLA0KPiAtCQkubGVuID0gc2l6ZSAtIDEsDQo+ICsJCS5kYXRh
ID0gdHgtPnBhY2tldCArIDEsDQo+ICsJCS5sZW4gPSB0eC0+c2l6ZSAtIDEsDQo+ICAJCS5yZWxh
eV9hZHZpY2UgPSBSRUxBWV9OT05FLA0KPiAgCX07DQo+ICANCj4gIAkvKiBTZW5kIHRvIGxvY2Fs
IG5vZGVzIGZpcnN0ICovDQo+ICAJbF9xdWV1ZV9mb3JlYWNoKG5ldHMsIG5ldF9yeCwgJm5ldF9k
YXRhKTsNCj4gIA0KPiAtCWlmIChuZXRfZGF0YS5yZWxheV9hZHZpY2UgPT0gUkVMQVlfRElTQUxM
T1dFRCkNCj4gKwkvKiBNYWtlIHN1cmUgc3BlY2lmaWMgbmV0d29yayBzdGlsbCB2YWxpZCAqLw0K
PiArCW5ldCA9IGxfcXVldWVfZmluZChuZXRzLCBzaW1wbGVfbWF0Y2gsIHR4LT5uZXQpOw0KPiAr
DQo+ICsJaWYgKCFuZXQgfHwgbmV0X2RhdGEucmVsYXlfYWR2aWNlID09IFJFTEFZX0RJU0FMTE9X
RUQpIHsNCj4gKwkJbF9mcmVlKHR4KTsNCj4gIAkJcmV0dXJuOw0KPiArCX0NCj4gIA0KPiAtCXBh
Y2tldFswXSA9IE1FU0hfQURfVFlQRV9ORVRXT1JLOw0KPiArCXR4LT5wYWNrZXRbMF0gPSBNRVNI
X0FEX1RZUEVfTkVUV09SSzsNCj4gIAlpbmZvLnR5cGUgPSBNRVNIX0lPX1RJTUlOR19UWVBFX0dF
TkVSQUw7DQo+ICAJaW5mby51Lmdlbi5pbnRlcnZhbCA9IG5ldC0+dHhfaW50ZXJ2YWw7DQo+ICAJ
aW5mby51Lmdlbi5jbnQgPSBuZXQtPnR4X2NudDsNCj4gQEAgLTIyNzIsNyArMjI4OSwxOSBAQCBz
dGF0aWMgdm9pZCBzZW5kX21zZ19wa3Qoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQ4X3QgKnBh
Y2tldCwgdWludDhfdCBzaXplKQ0KPiAgCS8qIE5vIGV4dHJhIHJhbmRvbWl6YXRpb24gd2hlbiBz
ZW5kaW5nIHJlZ3VsYXIgbWVzaCBtZXNzYWdlcyAqLw0KPiAgCWluZm8udS5nZW4ubWF4X2RlbGF5
ID0gREVGQVVMVF9NSU5fREVMQVk7DQo+ICANCj4gLQltZXNoX2lvX3NlbmQoaW8sICZpbmZvLCBw
YWNrZXQsIHNpemUpOw0KPiArCW1lc2hfaW9fc2VuZChuZXQtPmlvLCAmaW5mbywgdHgtPnBhY2tl
dCwgdHgtPnNpemUpOw0KPiArCWxfZnJlZSh0eCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lk
IHNlbmRfbXNnX3BrdChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDhfdCAqcGFja2V0LCB1aW50
OF90IHNpemUpDQo+ICt7DQo+ICsJc3RydWN0IG9uZXNob3RfdHggKnR4ID0gbF9uZXcoc3RydWN0
IG9uZXNob3RfdHgsIDEpOw0KPiArDQo+ICsJdHgtPm5ldCA9IG5ldDsNCj4gKwl0eC0+c2l6ZSA9
IHNpemU7DQo+ICsJbWVtY3B5KHR4LT5wYWNrZXQsIHBhY2tldCwgc2l6ZSk7DQo+ICsNCj4gKwls
X2lkbGVfb25lc2hvdChzZW5kX21zZ19wa3Rfb25lc2hvdCwgdHgsIE5VTEwpOw0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgZW51bSBfcmVsYXlfYWR2aWNlIHBhY2tldF9yZWNlaXZlZCh2b2lkICp1c2Vy
X2RhdGEsDQo+IEBAIC0yODQ3LDExICsyODc2LDYgQEAgYm9vbCBtZXNoX25ldF9zZXRfa2V5KHN0
cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgsIGNvbnN0IHVpbnQ4X3QgKmtleSwNCj4g
IAlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGJvb2wgaXNfdGhpc19uZXQoY29u
c3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gLXsNCj4gLQlyZXR1cm4gYSA9PSBiOw0KPiAt
fQ0KPiAtDQo+ICBib29sIG1lc2hfbmV0X2F0dGFjaChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgc3Ry
dWN0IG1lc2hfaW8gKmlvKQ0KPiAgew0KPiAgCWJvb2wgZmlyc3Q7DQo+IEBAIC0yODc0LDcgKzI4
OTgsNyBAQCBib29sIG1lc2hfbmV0X2F0dGFjaChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgc3RydWN0
IG1lc2hfaW8gKmlvKQ0KPiAgCQkJCQkJCW5ldF9tc2dfcmVjdiwgTlVMTCk7DQo+ICAJfQ0KPiAg
DQo+IC0JaWYgKGxfcXVldWVfZmluZChuZXRzLCBpc190aGlzX25ldCwgbmV0KSkNCj4gKwlpZiAo
bF9xdWV1ZV9maW5kKG5ldHMsIHNpbXBsZV9tYXRjaCwgbmV0KSkNCj4gIAkJcmV0dXJuIGZhbHNl
Ow0KPiAgDQo+ICAJbF9xdWV1ZV9wdXNoX2hlYWQobmV0cywgbmV0KTsNCg==
