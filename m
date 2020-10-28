Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CFC4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BA24724
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="k0JodhX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgJ1WJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:09:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:50353 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgJ1WJS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:18 -0400
IronPort-SDR: DZWBWWFDFUi77JFIXoGE2MW0LR20zGdHENWHpylX61QD5YRVC2e6aKjyIdTTXChYwDRh8MtQCK
 NubxpGk5CmBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="155314912"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="155314912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 15:09:17 -0700
IronPort-SDR: GjwhCcjKaO+zc70UJ/a7VfmDmbIaUwLus07OJCscbQApl/VvcnAkkjtHASlrxnkFv8aM7132Jj
 03kDqVzZ8GrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="424858858"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2020 15:09:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 15:09:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Oct 2020 15:09:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 28 Oct 2020 15:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh9Mk3fJeIGLMK2UlCXOrjtbmKnUO8BZ7QZeBY840BPFu7ogBiDq6Z66WVdt8q1ck7WH0OhYREWXehQf9XQieceN9aWnM0rruHj8jo45XNtButn+dRv5rbZR614RHTp/34VSoMnHgQP/douERrmzbo0UIZ4eSZTT8/kcfYasvHanIyL6WuI1CCVUCGFSY2xbD6yGGGmPClJlRRzmw5xPTqWB04/DneyL67mgiwrOQAu0AovAxi7dGRM0ERWum7GyqRNniEq7ShHETRy/HoRBD710wU6gJ35ark9pNGGvqzG1aRsa7ha2r4oIBp35tPzo6oXgdFm7fANnrm7H4HUfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOk+gvRjiUBRpASXz8Aw8dK7UJUBfLlYDH23c9pNYAs=;
 b=LZgwz8wR9DXVgSdca7WY4rXZDtNZ75yQuZdSu9jL60QB9Ju1Cs0hijlGem3iciqIsBtHHiXAAgrC4l0EJ/FWdX01GyRc1/GJSqdkNI233CHwABb0FJhDIZP06AdikiS5O+yyBJonK+x1rYsb3F1Z36+mRvWx1lxvtrMS27L/gZ3H6p3/qtQdC4vwLL4vzla1VwtLgAofcwOzB6gIbNWjVaaiyGwONb3mnRl2iEFJcHAlucv+u90GVOygMynkLzmRlQWGXLQFXmXZN8BN4h+k8WQnkKjql6QdgsC+08BsWN9R0MTa2IjNftvR+ZcY2IpI4EvS6oefwB7+zjQS45lmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOk+gvRjiUBRpASXz8Aw8dK7UJUBfLlYDH23c9pNYAs=;
 b=k0JodhX1Sw7o9ygpE9N0KRrFzWXGggMCGfBzmIsg+TDQdgfiRm7jvCgTHxXiQF5+UUCXWAd+unZm/olLqTgOTJKOd4bkHUTlxaEv8ennvksiEErSoQOeU181iQm2jccbvGd1NHSdqbZt2bKSppt/t7ZWrKrBuI1JadnLH77okRw=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR1101MB2334.namprd11.prod.outlook.com (2603:10b6:300:72::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 22:09:14 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::60e3:2ee5:c71c:fc57]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::60e3:2ee5:c71c:fc57%8]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 22:09:14 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "max.chou@realtek.com" <max.chou@realtek.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add more IDs to usb_device_id table for
 Realtek RTL8822CE
Thread-Topic: [PATCH] Bluetooth: btusb: Add more IDs to usb_device_id table
 for Realtek RTL8822CE
Thread-Index: AQHWrXXoU3/mS7iPUU2vLiasIzzuJqmtkwOA
Date:   Wed, 28 Oct 2020 22:09:14 +0000
Message-ID: <c1e9645827d4253155700ec716baecea406cb872.camel@intel.com>
References: <20201028023653.2760-1-max.chou@realtek.com>
In-Reply-To: <20201028023653.2760-1-max.chou@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: realtek.com; dkim=none (message not signed)
 header.d=none;realtek.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf13d3d8-57f1-4c97-b0db-08d87b8e1b7d
x-ms-traffictypediagnostic: MWHPR1101MB2334:
x-microsoft-antispam-prvs: <MWHPR1101MB23344621C9E1BCFE4C15107AFF170@MWHPR1101MB2334.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vmp2InVqFEnWEBzSJ6SRelrZ/94yqRfH6Ot6ElTbyCM5KCgfIY8VlApPHTP342CP9JlYDMpWU50ZO3QKh1fsao72lx5rlFLCdjN7/firnvpjzaOaulvjmPhiD9LTSCkkaQtb8V0apA+Oo4vKWvkf+eKj3kJssMWzrKRymC0ASkNN4H4DqrivWeR9aauNCZf9sHr8+ozIAwXKa9oa39zlwpol7Yw3R0htrp71C83spiyJVYXyt1nV4cZEdIhL6VMfZ9N0te5o2DR3kMvLddlcvJ9gMY/Haac7mtJmNd3ejXmnY9qIpKmfAfyYK9UNjXhCY2/tP11rkenBgaPn9F8JYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(4001150100001)(86362001)(66556008)(66446008)(36756003)(66946007)(186003)(26005)(6916009)(8936002)(8676002)(76116006)(2906002)(64756008)(91956017)(6506007)(316002)(83380400001)(6486002)(4326008)(2616005)(478600001)(5660300002)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2kJ3zwRKFl1veIr2CORicCuWOV7IRQyx9yQfPwZEEQuIb56Po3lufPWb3Cbj2VZbmpcOgRzmWiIjmXc5n+3J83+4brkgaOCZPCr3a1wSyG88LBTFHC67twkFvOAwCIXqrjagQXWg/aY0YO6vKHIJaCYjwgHjo0u7bTQVToXEXT+CwXIbygy+VATbvj3w4YVBYLl0J8ButC1G4+d06UeNlcLILp9u/YUDO+GNcF5BsFU5UhDzLElLjp6h6gAmVSavVHVK5hgl131l15bEu2SSKdwDrFXUlawcKJ84k41y/ORTFhCH/J81iWmxAAhlni+kfiNDezxwzXyww1+zPf/qOGREUJ8wGPm/vfr5+apK7qbTyoFMVbr0en9nM/8JOEfP6ABAikh4tGv/L1qlhT3Cfaji9J1aKwfjJoH9mQ6tvDx850ZMqYtGFmqJ6qnK7t3GGCiRYXnMxyXaA8KR7NwhtvS0mptGliwwpLrL7aFUmvPrIMrVzN6o6WK0EqvuKBrd5fZkm65EhMcdjKmyIrP41m9G25UdhE8pWv8JddZ7EpbFryN6/gBe5yBpjU/kJGtO4rsN861jbkFU3LvSFB1RqdF8Q04DW1rw5ZWXt0JKtV/ZFyIpyWLHIj5bF6hd7GeIOt25yl8zRlCTY+X32XE0DQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71CFDECCFEA6740BAF574D10542B642@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf13d3d8-57f1-4c97-b0db-08d87b8e1b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 22:09:14.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giNKJmGrB0GcMXMMrGibcjZR0qCm+wc9velJKFCckrO62sOMkgQZbVi5nRCKFS6342rPTiZlk6CVqpzb5cPPTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2334
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWF4DQoNCk9uIFdlZCwgMjAyMC0xMC0yOCBhdCAxMDozNiArMDgwMCwgbWF4LmNob3VAcmVh
bHRlay5jb20gd3JvdGU6DQo+IEZyb206IE1heCBDaG91IDxtYXguY2hvdUByZWFsdGVrLmNvbT4N
Cj4gDQo+IEFkZCBtb3JlIElEcyB0byB1c2JfZGV2aWNlX2lkIHRhYmxlIGZvciBSZWFsdGVrDQo+
IFJUTDg4MjJDRSBhbmQgYWxzbyBzdXBwb3J0IHRoZSB3aWRlYmFuZCBzcGVlY2ggY2FwYWJpbGl0
eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBDaG91IDxtYXguY2hvdUByZWFsdGVrLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIHwgMTggKysrKysrKysrKysrKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYw0KPiBpbmRleCAxMDA1YjZlOGZmNzQuLjRhMWY4Nzc2MTZkNiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiArKysgYi9kcml2ZXJzL2Js
dWV0b290aC9idHVzYi5jDQo+IEBAIC00MjUsOCArNDI1LDIyIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdXNiX2RldmljZV9pZCBibGFja2xpc3RfdGFibGVbXSA9IHsNCj4gIAl7IFVTQl9ERVZJQ0Uo
MHgwYjA1LCAweDE4NWMpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9SRUFMVEVLIH0sDQo+ICANCj4g
IAkvKiBBZGRpdGlvbmFsIFJlYWx0ZWsgODgyMkNFIEJsdWV0b290aCBkZXZpY2VzICovDQo+IC0J
eyBVU0JfREVWSUNFKDB4MDRjYSwgMHg0MDA1KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfUkVBTFRF
SyB9LA0KPiAtCXsgVVNCX0RFVklDRSgweDEzZDMsIDB4MzU0OCksIC5kcml2ZXJfaW5mbyA9IEJU
VVNCX1JFQUxURUsgfSwNCj4gKwl7IFVTQl9ERVZJQ0UoMHgwNGNhLCAweDQwMDUpLCAuZHJpdmVy
X2luZm8gPSBCVFVTQl9SRUFMVEVLIHwNCj4gKwkJCQkJCSAgICAgQlRVU0JfV0lERUJBTkRfU1BF
RUNIIH0sDQo+ICsJeyBVU0JfREVWSUNFKDB4MDRjNSwgMHgxNjFmKSwgLmRyaXZlcl9pbmZvID0g
QlRVU0JfUkVBTFRFSyB8DQo+ICsJCQkJCQkgICAgIEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9LA0K
PiArCXsgVVNCX0RFVklDRSgweDBiMDUsIDB4MThlZiksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX1JF
QUxURUsgfA0KPiArCQkJCQkJICAgICBCVFVTQl9XSURFQkFORF9TUEVFQ0ggfSwNCj4gKwl7IFVT
Ql9ERVZJQ0UoMHgxM2QzLCAweDM1NDgpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9SRUFMVEVLIHwN
Cj4gKwkJCQkJCSAgICAgQlRVU0JfV0lERUJBTkRfU1BFRUNIIH0sDQo+ICsJeyBVU0JfREVWSUNF
KDB4MTNkMywgMHgzNTQ5KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfUkVBTFRFSyB8DQo+ICsJCQkJ
CQkgICAgIEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9LA0KPiArCXsgVVNCX0RFVklDRSgweDEzZDMs
IDB4MzU1MyksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX1JFQUxURUsgfA0KPiArCQkJCQkJICAgICBC
VFVTQl9XSURFQkFORF9TUEVFQ0ggfSwNCj4gKwl7IFVTQl9ERVZJQ0UoMHgxM2QzLCAweDM1NTUp
LCAuZHJpdmVyX2luZm8gPSBCVFVTQl9SRUFMVEVLIHwNCj4gKwkJCQkJCSAgICAgQlRVU0JfV0lE
RUJBTkRfU1BFRUNIIH0sDQo+ICsJeyBVU0JfREVWSUNFKDB4MmZmOCwgMHgzMDUxKSwgLmRyaXZl
cl9pbmZvID0gQlRVU0JfUkVBTFRFSyB8DQo+ICsJCQkJCQkgICAgIEJUVVNCX1dJREVCQU5EX1NQ
RUVDSCB9LA0KDQpQbGVhc2UgaW5jbHVkZSB0aGUgY29udGVudCBvZiAvc3lzL2tlcm5lbC9kZWJ1
Zy91c2IvZGV2aWNlcyBmb3IgdGhlIGRldmljZXMgaW4NCnRoZSBjb21taXQgbWVzc2FnZS4NCg0K
PiAgDQo+ICAJLyogU2lsaWNvbiBXYXZlIGJhc2VkIGRldmljZXMgKi8NCj4gIAl7IFVTQl9ERVZJ
Q0UoMHgwYzEwLCAweDAwMDApLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9TV0FWRSB9LA0K
