Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497E12240C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yKBWOsRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKSXyR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:54:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:29099 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKSXyR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 18:54:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 15:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="200530648"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2019 15:54:16 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 15:54:16 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 15:54:15 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.58) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 19 Nov 2019 15:54:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ups0BHt4KkpLENbgLrp1jvTFWihsVfy/MvqVV858VRoeRV1NyiFly+U44tXUgA66NHlh0zeHdQ3ot2pHmOfT9l+iklYEFecNdOG88j5rAZuo3PuRdl0oER0kUk6gzB64fnIkharUjXKXHR7m6QDvqsrp7Oz5/NI1l42JhznVlXlNUNGrNyr9cJashaVxi26D23ZTe2KH7bdFax/vOtEVYs5Hlhf3qErJVpwGIvPTf5DmnOfaXTs7K7I3y7+arWSXrkjvTZQDG+Iyw1OTpH4du5hEcCvGAF6TpPiKuSpU4sfDrtePuydtq0NBcKV7byRg9/dG7cidNwtq/xQIUo1mCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcKrgxg2xFFmQ5IhvK58scp9FVeu/OBwbTVhDRcshvI=;
 b=aOViGnpFZogKbvYiltUlIy6IszzITKB9991b/BezK6uk/C9eAY7BeUq4DMBSUG+90c0KSjjmSCpyVky8Uo3FI/pMDCYwnrsguUrxXXFVU+aj/bb9L4H9N2ibxr0+UXatyiuxN4pAVrrHU4O5yxrTPSJesTWWLq79/5jWQI+b2RdD5XbhhvR1ThWOijix9jykBxgqaCsCkB7QSoMI+vgaG1WOEpfxydEGl+48k+0SvwHAg0GJMC9eJUIkydJOIPbUAK9lH/+V5NjkpOXfOBx6uRXYUAFlAFUxidu2LoYNVAouchh9GLaucXZX90BkKL5ECNvNdRhb4HSz/w+xemez1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcKrgxg2xFFmQ5IhvK58scp9FVeu/OBwbTVhDRcshvI=;
 b=yKBWOsRghHleC9QueAQ6meKlwBPPyaPVNKZffoyQodAVQy0xko87oM2E4+AFqOD8ZojPI94Ot1kTgYJqsjF+SXdcUbzM6OazDBeo7VnFE4qpUzwe1JpUIYjyNyhygKyH53Hs3kv6UxXkffqfYOqpcov/EhHfEGlRDuo5sRAQ97s=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2151.namprd11.prod.outlook.com (10.172.79.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 23:54:13 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 23:54:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: fix node default TTL
Thread-Topic: [PATCH BlueZ] mesh: fix node default TTL
Thread-Index: AQHVmIenzLcEvyQHP0yPjjf8oSyFIqeTODkA
Date:   Tue, 19 Nov 2019 23:54:13 +0000
Message-ID: <2cb0823cd802fb28e75fb5ac83a215616377fc30.camel@intel.com>
References: <20191111120007.3511-1-aurelien@aurel32.net>
In-Reply-To: <20191111120007.3511-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0eb124f-79c2-41f6-c26c-08d76d4bc79e
x-ms-traffictypediagnostic: CY4PR1101MB2151:
x-microsoft-antispam-prvs: <CY4PR1101MB215121A7489D625AC9E4A40CE14C0@CY4PR1101MB2151.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(14454004)(2616005)(256004)(5660300002)(6436002)(229853002)(26005)(8676002)(11346002)(305945005)(36756003)(66476007)(2906002)(66556008)(64756008)(66446008)(6116002)(478600001)(3846002)(316002)(110136005)(99286004)(66946007)(86362001)(76116006)(91956017)(14444005)(446003)(76176011)(7736002)(6486002)(25786009)(66066001)(6512007)(476003)(118296001)(486006)(186003)(8936002)(102836004)(81156014)(4001150100001)(6246003)(81166006)(2501003)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2151;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/TRmHXXGl5J41l4/OV4OkLJ5RUthBixFuv7LstG4e+f5E8bszTxSsN7eeFnqJ+4K8Swpcgze9XS9xtEVtkncOqGi2Yut7BtNNjfVjddN/FAYIdYTP6Vwwwo7YOdOJYU3rE/z3R80EANoWSMPdzTcc3OUrf7c3/NraxGWscfSRS8Acz5+4uS/RJLMKnaLIEZtpFhFF9+B3iGEEvVJq3/laLDA6VUHIaJKyy2aflS8olMbHE2CtdI881VarhTeLtbbxqPcQ8AFx142FbgCWAn++QzLqY/r2viTee25Wxf645CaWjTeSFyogEIY1FliOOC6HSk+Bosk4MyRJPqjJhxYMIsko/1KNNo1Vg4gNnwifgSEQcKQaYS8BR+9wA1h7/1w9iCZ01trDHWaT2lJJMuErnlySq3LTwrukH9rkutVSR/HlskCLdUVzGh9RxPQ8e9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2412A2360728148A258BCA578E1302F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eb124f-79c2-41f6-c26c-08d76d4bc79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 23:54:13.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a4wG9Ozg7/m6YG2hvOcHlMzcCHcL0ABZoW3DpvfGrGtH0arCyNZJ1pXIcrdYaSKSrtwP3jMPDyRr53cAyU0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2151
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAxMzowMCArMDEwMCwgQXVy
ZWxpZW4gSmFybm8gd3JvdGU6DQo+IFRoZXJlIGlzIGEgY29uZnVzaW9uIGJldHdlZW4gdGhlIG5v
ZGUgZGVmYXVsdCBUVEwgKHNlY3Rpb24gNC4yLjcpIGFuZA0KPiB0aGUgcHVibGlzaCBUVEwgKHNl
Y3Rpb24gNC4yLjIuNSk6DQo+IA0KPiAtIFRoZSBub2RlIGRlZmF1bHQgVFRMIGNhbiBvbmx5IHRh
a2UgdmFsdWVzIDB4MDAsIGFuZCAweDAyIHRvIDB4N2YuIFRoZQ0KPiAgIHZhbHVlIDB4ZmYgaXMg
bm90IHByb2hpYml0ZWQuDQo+IC0gVGhlIHB1Ymxpc2ggVFRMIGNhbiB0YWtlIHZhbHVlcyAweDAw
IHRvIDB4N2YsIGFzIHdlbGwgYXMgMHhmZiB3aGljaA0KPiAgIG1lYW5zIHVzZSB0aGUgbm9kZSBk
ZWZhdWx0IFRUTC4NCj4gDQo+IEN1cnJlbnRseSB0aGUgZGVmYXVsdCBub2RlIFRUTCBpcyBzZXQg
dG8gMHhmZiAoREVGQVVMVF9UVEwpLCBhbmQNCj4gcmVhZF9kZWZhdWx0X3R0bCgpIGFsc28gYWxs
b3dzIHN1Y2ggYSB2YWx1ZS4gVGhpcyBwYXRjaCBmaXhlcyB0aGF0IHRvDQo+IHVzZSAweDdmIChU
VExfTUFTSykgYXMgdGhlIGRlZmF1bHQgdmFsdWUgaW5zdGVhZC4NCj4gDQo+IE5vdGUgdGhhdCB0
aGUgY29kZSBoYW5kbGluZyBPUF9DT05GSUdfREVGQVVMVF9UVExfU0VUIGNvcnJlY3RseSB1c2Ug
MHg3Zg0KPiAoVFRMX01BU0spIGZvciB0aGUgdXBwZXIgYWxsb3dlZCBsaW1pdC4NCj4gLS0tDQo+
ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8IDIgKy0NCj4gIG1lc2gvbm9kZS5jICAgICAgICAg
ICAgIHwgNCArKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYyBiL21l
c2gvbWVzaC1jb25maWctanNvbi5jDQo+IGluZGV4IGIyY2ZmNjgyNC4uNWNhMjk2MWIwIDEwMDY0
NA0KPiAtLS0gYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0KPiArKysgYi9tZXNoL21lc2gtY29u
ZmlnLWpzb24uYw0KPiBAQCAtMzU4LDcgKzM1OCw3IEBAIHN0YXRpYyBib29sIHJlYWRfZGVmYXVs
dF90dGwoanNvbl9vYmplY3QgKmpvYmosIHVpbnQ4X3QgKnR0bCkNCj4gIAlpZiAoIXZhbCAmJiBl
cnJubyA9PSBFSU5WQUwpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAtCWlmICh2YWwgPCAw
IHx8IHZhbCA9PSAxIHx8IHZhbCA+IERFRkFVTFRfVFRMKQ0KPiArCWlmICh2YWwgPCAwIHx8IHZh
bCA9PSAxIHx8IHZhbCA+IFRUTF9NQVNLKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gIAkq
dHRsID0gKHVpbnQ4X3QpIHZhbDsNCj4gZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5jIGIvbWVzaC9u
b2RlLmMNCj4gaW5kZXggZTIzZjMyZGQxLi41ZGNmZmU2ZjcgMTAwNjQ0DQo+IC0tLSBhL21lc2gv
bm9kZS5jDQo+ICsrKyBiL21lc2gvbm9kZS5jDQo+IEBAIC02NzIsNyArNjcyLDcgQEAgc3RydWN0
IGxfcXVldWUgKm5vZGVfZ2V0X2VsZW1lbnRfbW9kZWxzKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUs
DQo+ICB1aW50OF90IG5vZGVfZGVmYXVsdF90dGxfZ2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUp
DQo+ICB7DQo+ICAJaWYgKCFub2RlKQ0KPiAtCQlyZXR1cm4gREVGQVVMVF9UVEw7DQo+ICsJCXJl
dHVybiBUVExfTUFTSzsNCj4gIAlyZXR1cm4gbm9kZS0+dHRsOw0KPiAgfQ0KPiAgDQo+IEBAIC0x
MzUyLDcgKzEzNTIsNyBAQCBzdGF0aWMgdm9pZCBzZXRfZGVmYXVsdHMoc3RydWN0IG1lc2hfbm9k
ZSAqbm9kZSkNCj4gIAlub2RlLT5mcmllbmQgPSBNRVNIX01PREVfVU5TVVBQT1JURUQ7DQo+ICAJ
bm9kZS0+YmVhY29uID0gTUVTSF9NT0RFX0RJU0FCTEVEOw0KPiAgCW5vZGUtPnJlbGF5Lm1vZGUg
PSBNRVNIX01PREVfRElTQUJMRUQ7DQo+IC0Jbm9kZS0+dHRsID0gREVGQVVMVF9UVEw7DQo+ICsJ
bm9kZS0+dHRsID0gVFRMX01BU0s7DQo+ICAJbm9kZS0+c2VxX251bWJlciA9IERFRkFVTFRfU0VR
VUVOQ0VfTlVNQkVSOw0KPiAgDQo+ICAJLyogQWRkIGNvbmZpZ3VyYXRpb24gc2VydmVyIG1vZGVs
IG9uIHByaW1hcnkgZWxlbWVudCAqLw0K
