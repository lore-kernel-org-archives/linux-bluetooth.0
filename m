Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FCC4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20662075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="COPT403p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgJ2H2Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:28:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:31454 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgJ2H2P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 03:28:15 -0400
IronPort-SDR: zxWVk8mu1krerBVeBEvNv3AZnGZzOV5oUtcl4kFfnkaGRsr+sR95/ImHtqXMzmkUTWKIFmqvsv
 zpTkE80me60Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168522230"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168522230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 00:28:14 -0700
IronPort-SDR: 3xvand9KQpRlz4mxVycUehduO0VnXyaVlkDIhFaZoid92P6Yl4MQbW3zIx49jkX3ZXHiBMBH6Z
 LFqtUkHKvknA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="304498903"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2020 00:28:14 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 00:28:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 00:28:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Oct 2020 00:28:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 29 Oct 2020 00:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu2YDZBwnuWYOdQvg7d8sSrJtcw7uMQ544x2ER14Vn2+0l1F/zGuG66+FSdufBCwsB9oXysXqaFM7OWbEoBCxlP7+ZHKTowuAdbOMvp28mGu/8dptY2GEiLKzmodjsWLqCEWmtBLONr1GkXwbB5GoGR6wuaZ4PucfVs+KZG7MO4vlPh2zQbhOGcuJRVTE7mF9V/LJKoYkIGTES4dicppZ1MYSMTCABJPNXXai6kvh1dDuVBZRsRT4yv2U1pAeEGkkHqa6yZV5USIvY2VODfgfrWU2wt5SeAzszw9ShyyL8R65kw4NyPdWV/A6Mv2y/XDO8C8QLesLrUy+6SyENCYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mKB4NhNpAq/GNuK4mhdrpdTfAd7qJmNF0s3/5LC+4w=;
 b=Ae7Ps4zRWQS6e4JJ0oKQlvO6QZvJh9VWpZ7rAhXo0UJGiM5C1eVBdqlgTWgfmoBGHKjEFDXURjja8gPitJUpQWoQWU0M5a/pPePStQ/PBKKNRwBPpqgaziOSVF5u8brMJ7sDVpNV1MQow4j2It7ouqTB/A3Y8tXD9EbXhjUedvdwtaFlsp0bD97vBRljBymtyMZIHt62oIwyETvabVfFeSL8R2vuJhB127vgYbGUB3u/gVjq0AohYlhziUzZPy67JJuVqM2EYtdSVEBSWtDoyzXJX4vSaedprf+b/w+gAD5p3jYeaj+yw26945aKBYnllDKGhuC3IQJr6rjANGe/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mKB4NhNpAq/GNuK4mhdrpdTfAd7qJmNF0s3/5LC+4w=;
 b=COPT403p81zj8UGGJBuRpa0MScS/UZJY3gGEHLpVFMxJJ5dNhpAnIWC5iHCYWEqiE79reOOxJfPbschLkLe48bO58DIrEE2+ltB5O8eOd+LroU8JeVwst1+mNMnCzzBTUj1DFg9+hs1L9ORxNmL4lJYrxhVKDHpUp+RzXusyW+Y=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 07:27:46 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35%6]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 07:27:46 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>
CC:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "Sathish Narasimman" <nsathish41@gmail.com>
Subject: RE: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Thread-Topic: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Thread-Index: AQHWqEvQYfF4M7kJI0GxscsQ23AutKmshmeAgAE8JYCAAHapgA==
Date:   Thu, 29 Oct 2020 07:27:46 +0000
Message-ID: <SN6PR11MB27035A46102000A6DB6C226594140@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201022082304.31757-1-sathish.narasimman@intel.com>
 <CAOVXEJL1qCPmpY-jGW8AsycxGytCzuJQR4hv-bXPPSNyO=5GZQ@mail.gmail.com>
 <CABBYNZJQhuYaaxj-CtAsOuEGQSnbf3oMsT55Gyf_Wb0dRa1mmQ@mail.gmail.com>
In-Reply-To: <CABBYNZJQhuYaaxj-CtAsOuEGQSnbf3oMsT55Gyf_Wb0dRa1mmQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [27.6.184.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8355df3-d46e-40cd-3ebc-08d87bdc221e
x-ms-traffictypediagnostic: SA2PR11MB4971:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB49718CE597E4584DB456768B94140@SA2PR11MB4971.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:154;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLIxjBcTFQ92OO5GxOFmQoxrR00tJW3quxaF44RHe8Rgf88gU8PPU/I7GTBhI/QFx1evQR/3ECgDZzXjfHqpK8HmWlVduJkhZdNhgZBkHfN92AMmr49HaCraSZqGNe+0sFTA1HX3xA02ofst0y70U4tExBeMKe3Y4EZCh3i/rt0LNOBjzK5Nj+2CnwYV4KIYiL/ml+3mmntN9ErhKF7ziy0XuNoMy+5yDI60j1O2Z8VVxezzPIhbKYb0wkjllkCkXyZRl+GATP4AqjymDY+gYDP+Ze2ZOnDpb0GWSAOzh3ZT5KfgXennVrgnlEp7PZAbn3e/t2SKJl90uE94LIDjtxVZJmehqkmu9hXIr6Grytw+7aYEfCxN1j6h9uQSfOlaUj0W7nbjleEcaElEe/KaxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(2906002)(7696005)(86362001)(76116006)(186003)(966005)(71200400001)(6506007)(66476007)(66556008)(64756008)(83380400001)(66946007)(66446008)(53546011)(4326008)(33656002)(316002)(110136005)(8676002)(5660300002)(9686003)(52536014)(26005)(54906003)(55016002)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j2ZzSjx2Q7CDuLc98lRfPMWx9jI11lYH9ZZS2oYHALrXpFiHjqy7LzucaiaXY0KdjE6SDSeZGjuHctq44ztdWzMvkXReD4KcHizYePKfFf89ueTfCAwJ2yeSDyVNrekJJZ++YGnTinBDwW78YwTO9E1FkbM9hEOhss9UHPjgfktL+0gYfcJfF3If5vC/DV91W1JpA624JaBjWUaGJ8EuMLTkhpSAqTCeZcq7dSxa6aDhHx7Yn+EfSRUUREgebSV6fzVVbSYtQwdpqknGy4J5sMloihp8kOBJQmxdPKjTXF7B0P44eZuLb59+5arUSkWlR9LAHsIHwAWPpqTZRaiCkOgJXdTE2j9ZYIkHXsFnsX8GNom/HzbIC7zA9UEXrCXOJltwuFrmRwCtuAU3VpWhuXG0qg1NLHgHNrd8QAv+5qeejWEDxtHbPoF6OUXxfBG7M7quJEOGk1gH+NM6Ftq8p4KYny9xXCJo/FTpEXkT8YK98t/zY/DudTitYUpv6dOiHC5iQYGXVLT4Fi1yBCJ5RzPGNscbcQkh8zSQYf4EN6tUki7XOma7oClkiGEwsDy0RzFiXspyQYvjVnQprl19TpIHys7OexzhncmlDabhs8W+Du2l5GUb+2SQpz4+2Jqpizdt9T8I2xs02WDp4CV1zw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8355df3-d46e-40cd-3ebc-08d87bdc221e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 07:27:46.7424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j4PhitzAZzSrH4Lwk5SBsp24tdbWB59RPQBOhCihkMhK7D89JFOvO31VesR3J4cn/7rVjHynmUKxF9vQlVdWyw2BypA56xXF7A5C0NyOJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1aXogQXVn
dXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
T2N0b2JlciAyOSwgMjAyMCA1OjUyIEFNDQo+IFRvOiBTYXRoaXNoIE5hcmFzaW1tYW4gPG5zYXRo
aXNoNDFAZ21haWwuY29tPg0KPiBDYzogQmx1ZXogbWFpbGluZyBsaXN0IDxsaW51eC1ibHVldG9v
dGhAdmdlci5rZXJuZWwub3JnPjsgVHVta3VyIE5hcmF5YW4sDQo+IENoZXRoYW4gPGNoZXRoYW4u
dHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+IDxyYXZp
c2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+
Ow0KPiBOYXJhc2ltbWFuLCBTYXRoaXNoIDxzYXRoaXNoLm5hcmFzaW1tYW5AaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBCbHVldG9vdGg6IEZpeDogTEwgUFJpdmFjeSBCTEUgZGV2
aWNlIGZhaWxzIHRvIGNvbm5lY3QNCj4gDQo+IEhpIFNhdGhpc2gsDQo+IA0KPiBPbiBXZWQsIE9j
dCAyOCwgMjAyMCBhdCA0OjQ2IFBNIFNhdGhpc2ggTmFyYXNpbW1hbg0KPiA8bnNhdGhpc2g0MUBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkNCj4gPg0KPiA+IE9uIFRodSwgT2N0IDIyLCAy
MDIwIGF0IDE6NDcgUE0gU2F0aGlzaCBOYXJhc2ltbWFuDQo+IDxuc2F0aGlzaDQxQGdtYWlsLmNv
bT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gV2hlbiBhZGRpbmcgZGV2aWNlIHRvIHdoaXRlIGxpc3Qg
dGhlIGRldmljZSBpcyBhZGRlZCB0byByZXNvbHZpbmcNCj4gPiA+IGxpc3QgYWxzbyBpdCBoYXMg
dG8gYmUgYWRkZWQgb25seSB3aGVuIEhDSV9FTkFCTEVfTExfUFJJVkFDWSBmbGFnIGlzIHNldC4N
Cj4gPiA+IEhDSV9FTkFCTEVfTExfUFJJVkFDWSBmbGFnIGhhcyB0byBiZSB0ZXN0ZWQgYmVmb3Jl
IGFkZGluZy9kZWxldGluZw0KPiA+ID4gZGV2aWNlcyB0byByZXNvbHZpbmcgbGlzdC4gdXNlX2xs
X3ByaXZhY3kgbWFjcm8gaXMgdXNlZCBvbmx5IHRvDQo+ID4gPiBjaGVjayBpZiBjb250cm9sbGVy
IHN1cHBvcnRzIExMX1ByaXZhY3kuDQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDk3NDUNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTYXRoaXNoIE5hcmFzaW1tYW4gPHNhdGhpc2gubmFyYXNpbW1hbkBpbnRlbC5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICBuZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMgfCAxMiArKysrKysrKy0t
LS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMN
Cj4gPiA+IGIvbmV0L2JsdWV0b290aC9oY2lfcmVxdWVzdC5jIGluZGV4IDZmMTJiYWI0ZDJmYS4u
NjEwZWQwODE3YmQ3DQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL25ldC9ibHVldG9vdGgvaGNp
X3JlcXVlc3QuYw0KPiA+ID4gKysrIGIvbmV0L2JsdWV0b290aC9oY2lfcmVxdWVzdC5jDQo+ID4g
PiBAQCAtNjk4LDcgKzY5OCw4IEBAIHN0YXRpYyB2b2lkIGRlbF9mcm9tX3doaXRlX2xpc3Qoc3Ry
dWN0IGhjaV9yZXF1ZXN0DQo+ICpyZXEsIGJkYWRkcl90ICpiZGFkZHIsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgY3AuYmRhZGRyX3R5cGUpOw0KPiA+ID4gICAgICAgICBoY2lfcmVxX2FkZChy
ZXEsIEhDSV9PUF9MRV9ERUxfRlJPTV9XSElURV9MSVNULCBzaXplb2YoY3ApLA0KPiA+ID4gJmNw
KTsNCj4gPiA+DQo+ID4gPiAtICAgICAgIGlmICh1c2VfbGxfcHJpdmFjeShyZXEtPmhkZXYpKSB7
DQo+ID4gPiArICAgICAgIGlmICh1c2VfbGxfcHJpdmFjeShyZXEtPmhkZXYpICYmDQo+ID4gPiAr
ICAgICAgICAgICBoY2lfZGV2X3Rlc3RfZmxhZyhyZXEtPmhkZXYsIEhDSV9FTkFCTEVfTExfUFJJ
VkFDWSkpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc21wX2lyayAqaXJrOw0KPiA+
ID4NCj4gPiA+ICAgICAgICAgICAgICAgICBpcmsgPSBoY2lfZmluZF9pcmtfYnlfYWRkcihyZXEt
PmhkZXYsIGJkYWRkciwNCj4gPiA+IGJkYWRkcl90eXBlKTsgQEAgLTczMiw3ICs3MzMsOCBAQCBz
dGF0aWMgaW50IGFkZF90b193aGl0ZV9saXN0KHN0cnVjdA0KPiBoY2lfcmVxdWVzdCAqcmVxLA0K
PiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIC8q
IFdoaXRlIGxpc3QgY2FuIG5vdCBiZSB1c2VkIHdpdGggUlBBcyAqLw0KPiA+ID4gLSAgICAgICBp
ZiAoIWFsbG93X3JwYSAmJiAhdXNlX2xsX3ByaXZhY3koaGRldikgJiYNCj4gPiA+ICsgICAgICAg
aWYgKCFhbGxvd19ycGEgJiYNCj4gPiA+ICsgICAgICAgICAgICFoY2lfZGV2X3Rlc3RfZmxhZyho
ZGV2LCBIQ0lfRU5BQkxFX0xMX1BSSVZBQ1kpICYmDQo+ID4gPiAgICAgICAgICAgICBoY2lfZmlu
ZF9pcmtfYnlfYWRkcihoZGV2LCAmcGFyYW1zLT5hZGRyLCBwYXJhbXMtPmFkZHJfdHlwZSkpDQo+
IHsNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gPiAgICAgICAgIH0NCj4g
PiA+IEBAIC03NTAsNyArNzUyLDggQEAgc3RhdGljIGludCBhZGRfdG9fd2hpdGVfbGlzdChzdHJ1
Y3QgaGNpX3JlcXVlc3QNCj4gKnJlcSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICBjcC5iZGFk
ZHJfdHlwZSk7DQo+ID4gPiAgICAgICAgIGhjaV9yZXFfYWRkKHJlcSwgSENJX09QX0xFX0FERF9U
T19XSElURV9MSVNULCBzaXplb2YoY3ApLA0KPiA+ID4gJmNwKTsNCj4gPiA+DQo+ID4gPiAtICAg
ICAgIGlmICh1c2VfbGxfcHJpdmFjeShoZGV2KSkgew0KPiA+ID4gKyAgICAgICBpZiAodXNlX2xs
X3ByaXZhY3koaGRldikgJiYNCj4gPiA+ICsgICAgICAgICAgIGhjaV9kZXZfdGVzdF9mbGFnKGhk
ZXYsIEhDSV9FTkFCTEVfTExfUFJJVkFDWSkpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgc21wX2lyayAqaXJrOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgICAgICBpcmsgPSBoY2lf
ZmluZF9pcmtfYnlfYWRkcihoZGV2LCAmcGFyYW1zLT5hZGRyLCBAQA0KPiA+ID4gLTgxMiw3ICs4
MTUsOCBAQCBzdGF0aWMgdTggdXBkYXRlX3doaXRlX2xpc3Qoc3RydWN0IGhjaV9yZXF1ZXN0ICpy
ZXEpDQo+ID4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgICAg
ICAvKiBXaGl0ZSBsaXN0IGNhbiBub3QgYmUgdXNlZCB3aXRoIFJQQXMgKi8NCj4gPiA+IC0gICAg
ICAgICAgICAgICBpZiAoIWFsbG93X3JwYSAmJiAhdXNlX2xsX3ByaXZhY3koaGRldikgJiYNCj4g
PiA+ICsgICAgICAgICAgICAgICBpZiAoIWFsbG93X3JwYSAmJg0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAhaGNpX2Rldl90ZXN0X2ZsYWcoaGRldiwgSENJX0VOQUJMRV9MTF9QUklWQUNZKQ0K
PiA+ID4gKyAmJg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICBoY2lfZmluZF9pcmtfYnlfYWRk
cihoZGV2LCAmYi0+YmRhZGRyLCBiLT5iZGFkZHJfdHlwZSkpIHsNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAweDAwOw0KPiA+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiA+
IC0tDQo+ID4gPiAyLjE3LjENCj4gPiA+DQo+ID4NCj4gPg0KPiA+IEdlbnRsZSByZW1pbmRlci4N
Cj4gPiBTZWVtcyBNYW55IGRldmljZXMgYXJlIGZhaWxpbmcgdG8gcmVjb25uZWN0IGFmdGVyIGV2
ZXJ5IG9uIDUuOSBrZXJuZWwNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggd2lsbCBGSVggdGhlIGlzc3Vl
DQo+IA0KPiBCdHcsIHlvdSBzaG91bGQgcHJvYmFibHkgbWVudGlvbiB0aGUgY29tbWl0IGlkIHRo
YXQgaW50cm9kdWNlZCB0aGlzDQo+IHJlZ3Jlc3Npb24uDQpXaWxsIHVwZGF0ZSB0aGUgc2FtZSBp
biB2MiBvZiB0aGUgcGF0Y2gNCg0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
