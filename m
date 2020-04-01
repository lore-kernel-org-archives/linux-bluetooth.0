Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D63C2D0F2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BF82063A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FJDI1utA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgDAQsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:48:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:60551 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390111AbgDAQsD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 12:48:03 -0400
IronPort-SDR: UVLLke4QHAIO5OtHtwNw1NchbGMxoqs3Y+H0xcNRBLQFzL5tm8CQ0+Gx7i/K29AmH6bbErNs9F
 rIBBIVOomq7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 09:48:03 -0700
IronPort-SDR: 8Nx/sa49Buo9MkIBf/dKej4fhxc1PLVrGi70Sc3jV46rI0s8zRE3FVamoCDwFYx2VTcq+165XI
 oKLO53vNkOZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="284465653"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2020 09:48:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 09:48:02 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 09:48:02 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 09:48:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Apr 2020 09:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi+odcxOFnVO8yQPAdFIxJjh6UJQY5Qso3KFTbyh/y8+y1okjgb35QMSpTpo0mZtL2au6ueF+5jN3Z2nhJfGh1+K/byhl+W1QEpYIbJ9ZNlYskv3VHg4u7sFqYMzndN+ikCLMWBSODW5yHZ1jnJA6TisBf5bBX2GUUiccSyRsGFq8MR2Rb7qmvW3uQZaqzFjFmvimHJuyJsPIOwB/YE1oMP2udIdeGo0LolhDhExFGh6wbUxuIh6ia5429jRXo0Xe0VHoGHkNj1Lz3YUlOwfG9+sqynJT14G66d5SiuiEDeGB8M+Rjfocz7IGSaB3p9JWRXRBKR3xykDbCmnYD5Naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COgzH39J40NqZF7aO7xgd2uubzqVyLD5TQXuBda9L50=;
 b=D8dMlwY3SxJ/7XxtDVA5ypH6rEGJ9GLDVFojMAVAkBwGkBxuJKqKaahtYImyUlSynXF44LNWUyHl34H1d2X9rM5vI4C6S4k7RpJNBl/WfKzWehlKJgpNA9/Y7Bxbp8pkYD/l9tQoN6GGRlsBWTR1lWqCfV0ZQODX/pfZAE+12anBh50rxm5lU4uEDQaAsY+2iviav68dn2qTkcZOrvgAbIuk8P4BX50rfg9RhUUEArY3FsFih8Bf5tZw3RUfti0vNb87zeTmGq9vRKAEh3JLWwI1rvStdjfdKZQJfhWqFHo5oyYbJvvPTl7Qsg3Zixf7VTfbG6b50ry4Xp+yNP/QeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COgzH39J40NqZF7aO7xgd2uubzqVyLD5TQXuBda9L50=;
 b=FJDI1utAXqI/xcRMMR2EKpJ3UWNT6BNo6dtb+WAhP8gz+Kw+vvfq0ZrkpNeX+TCUe6bSIRM1zssNZ4DWxPlSHmfb/lnkUN0Npw+Dyn8jq9t2fopf4mkYeJhvTZ+dN60HArp1b32gyopPR54AUqRtS648325UdC81EozNDgl/yWM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 16:47:49 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 16:47:49 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix SIGSEGV
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix SIGSEGV
Thread-Index: AQHWCBzSvUmXvDx+uU6ymVFBLwpjWahkelMA
Date:   Wed, 1 Apr 2020 16:47:49 +0000
Message-ID: <190a65da7ce902e88a01e93f00f1600d9bb2c556.camel@intel.com>
References: <CGME20200401110619epcas5p12cbae623138736720177166c1f18a403@epcas5p1.samsung.com>
         <1585739175-28700-1-git-send-email-anupam.r@samsung.com>
In-Reply-To: <1585739175-28700-1-git-send-email-anupam.r@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ca7a379-9c60-4c26-e16e-08d7d65c6984
x-ms-traffictypediagnostic: MW3PR11MB4745:
x-microsoft-antispam-prvs: <MW3PR11MB47458F7EA1A840299D5D6DEDE1C90@MW3PR11MB4745.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:203;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(186003)(66446008)(6506007)(64756008)(5660300002)(66556008)(66476007)(91956017)(478600001)(2906002)(66946007)(2616005)(76116006)(54906003)(86362001)(6512007)(26005)(110136005)(6486002)(8676002)(4326008)(316002)(36756003)(81156014)(8936002)(71200400001)(81166006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: veujNm3Xh9+8ZLZ5WbeZyMvc/a4OLPDDU1P0KcOS7Nvzw1E8crG7+Q8p6r+ei1K08/DtRg8JOn2N5QYlkSkNkvq+mzNXGhRzBhQM7UtBrHxczliDclxshyiWn3BRNDS0z/EUqrKIfAqa5zCgYiUJuPNiHkPFIBHyoCkoeIrscU3GrN96cnQ92fQTccn76rG7U1o2M9E/ncWAvW64dmtY3+aZfELheJL9+gRZszGrUetRlDBywLf+RjcuYDRDNGghmBI6AkSasrh0P/k+oEp7S+mdlscno6tUW6LX/M+AREh1MEMU+tmxs6+wZpbiRcPqAt42DRQs8FRNsGUaIa+Om9+R+W9k/yIfIfnnKiErw8rJIBTWiW+65r/mjxKp3il0C+9J0xBOhMppLru3gRkH4Y9CgmJIuVZGDzb9I/xRFGDP0z+lWxzSBmRMy7UJ173m
x-ms-exchange-antispam-messagedata: Q/3TDIMVlti6QZlAp4C3EyzFi04C0Csxgnim2bjFlmfk1sBHgRD8iKYAEfF9ReHRSc0K+WveVC4sOFzvpCkrx3pIEKjAers6fwXkuWGx7JC8LzutM1arSK6/Psqa+Gv5R0f1kFQtWDMFwqgoiI5y4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D773AAB4D52EC43AFF91CAFB49467D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7a379-9c60-4c26-e16e-08d7d65c6984
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 16:47:49.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHNVAMgIoCRswXPCtZpteK7RTPP02T3Qrax+xItJwsAnmotO2Q7gQkzSZvGKhkleuQpp/c+9/uDEK4kL8NZ5xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTA0LTAxIGF0IDE2OjM2ICswNTMwLCBBbnVwYW0gUm95IHdy
b3RlOg0KPiBUaGlzIHBhdGNoIGFkZHJlc3NlcyB0aGUgZm9sbG93aW5nIGNyYXNoOg0KPiANCj4g
W21lc2gtY2ZnY2xpZW50XSMNCj4gUHJvZ3JhbSByZWNlaXZlZCBzaWduYWwgU0lHU0VHViwgU2Vn
bWVudGF0aW9uIGZhdWx0Lg0KPiBzdHJsZW4gKCkgYXQgLi4vc3lzZGVwcy94ODZfNjQvc3RybGVu
LlM6MTA2DQo+IDEwNiAgICAgLi4vc3lzZGVwcy94ODZfNjQvc3RybGVuLlM6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkuDQo+IChnZGIpIGJ0DQo+IDAgIHN0cmxlbiAoKSBhdCAuLi9zeXNkZXBz
L3g4Nl82NC9zdHJsZW4uUzoxMDYNCj4gMSAgMHgwMDAwMDAwMDAwNDIzNWQ2IGluIGxfZGJ1c19p
bnRlcmZhY2VfbWV0aG9kIChpbnRlcmZhY2U9aW50ZXJmYWNlQGVudHJ5PTB4NjZkOTAwLCBuYW1l
PW5hbWVAZW50cnk9MHg0MmJiYQ0KPiBkICJTY2FuUmVzdWx0IiwgZmxhZ3M9ZmxhZ3NAZW50cnk9
MCwNCj4gICAgIGNiPWNiQGVudHJ5PTB4NDA0OTQwIDxzY2FuX3Jlc3VsdF9jYWxsPiwgcmV0dXJu
X3NpZz1yZXR1cm5fc2lnQGVudHJ5PTB4NDJmN2NhICIiLCANCj4gcGFyYW1fc2lnPXBhcmFtX3Np
Z0BlbnRyeT0weDQyYmJhNCAibmF5YXtzdn0iKSBhdCBlbGwvZGJ1cy1zZXJ2aWNlLmM6MzIwDQo+
IDIgIDB4MDAwMDAwMDAwMDQwNDMzZCBpbiBzZXR1cF9wcm92X2lmYWNlIChpZmFjZT0weDY2ZDkw
MCkgYXQgdG9vbHMvbWVzaC1jZmdjbGllbnQuYzoxNjk1DQo+IDMgIDB4MDAwMDAwMDAwMDQyNDli
MSBpbiBfZGJ1c19vYmplY3RfdHJlZV9yZWdpc3Rlcl9pbnRlcmZhY2UgKHRyZWU9MHg2NWI3NzAs
IGludGVyZmFjZT1pbnRlcmZhY2VAZW50cnk9MHg0MmINCj4gYWE4ICJvcmcuYmx1ZXoubWVzaC5Q
cm92aXNpb25lcjEiLA0KPiAgICAgc2V0dXBfZnVuYz1zZXR1cF9mdW5jQGVudHJ5PTB4NDA0MzEw
IDxzZXR1cF9wcm92X2lmYWNlPiwgZGVzdHJveT1kZXN0cm95QGVudHJ5PTB4MCwgDQo+IG9sZF9z
dHlsZV9wcm9wZXJ0aWVzPW9sZF9zdHlsZV9wcm9wZXJ0aWVzQGVudHJ5PWZhbHNlKQ0KPiAgICAg
YXQgZWxsL2RidXMtc2VydmljZS5jOjEzODUNCj4gNCAgMHgwMDAwMDAwMDAwNDFjZmZhIGluIGxf
ZGJ1c19yZWdpc3Rlcl9pbnRlcmZhY2UgKGRidXM9PG9wdGltaXplZCBvdXQ+LCBpbnRlcmZhY2U9
aW50ZXJmYWNlQGVudHJ5PTB4NDJiYWE4DQo+ICJvcmcuYmx1ZXoubWVzaC5Qcm92aXNpb25lcjEi
LA0KPiAgICAgc2V0dXBfZnVuYz1zZXR1cF9mdW5jQGVudHJ5PTB4NDA0MzEwIDxzZXR1cF9wcm92
X2lmYWNlPiwgZGVzdHJveT1kZXN0cm95QGVudHJ5PTB4MCwgDQo+IGhhbmRsZV9vbGRfc3R5bGVf
cHJvcGVydGllcz1oYW5kbGVfb2xkX3N0eWxlX3Byb3BlcnRpZXNAZW50cnk9ZmFsc2UpDQo+ICAg
ICBhdCBlbGwvZGJ1cy5jOjE0NTUNCj4gNSAgMHgwMDAwMDAwMDAwNDAzZjRlIGluIHJlZ2lzdGVy
X2FwcCAoKSBhdCB0b29scy9tZXNoLWNmZ2NsaWVudC5jOjE3NzANCj4gNiAgY2xpZW50X3JlYWR5
IChjbGllbnQ9PG9wdGltaXplZCBvdXQ+LCB1c2VyX2RhdGE9PG9wdGltaXplZCBvdXQ+KSBhdCB0
b29scy9tZXNoLWNmZ2NsaWVudC5jOjE4MTUNCj4gNyAgMHgwMDAwMDAwMDAwNDI1ZWQyIGluIGdl
dF9tYW5hZ2VkX29iamVjdHNfcmVwbHkgKG1lc3NhZ2U9PG9wdGltaXplZCBvdXQ+LCB1c2VyX2Rh
dGE9MHg2NmFiNTApIGF0IGVsbC9kYnVzLQ0KPiBjbGllbnQuYzo1NzINCj4gOCAgMHgwMDAwMDAw
MDAwNDFiYzI1IGluIGhhbmRsZV9lcnJvciAobWVzc2FnZT0weDY2YzBjMCwgZGJ1cz08b3B0aW1p
emVkIG91dD4pIGF0IGVsbC9kYnVzLmM6MjM2DQo+IDkgIDB4MDAwMDAwMDAwMDQxY2RjYyBpbiBt
ZXNzYWdlX3JlYWRfaGFuZGxlciAoaW89PG9wdGltaXplZCBvdXQ+LCB1c2VyX2RhdGE9MHg2NjUz
ZjApIGF0IGVsbC9kYnVzLmM6Mjc2DQo+IDEwIDB4MDAwMDAwMDAwMDQxODc2MyBpbiBpb19jYWxs
YmFjayAoZmQ9PG9wdGltaXplZCBvdXQ+LCBldmVudHM9MSwgdXNlcl9kYXRhPTB4NjY2NGUwKSBh
dCBlbGwvaW8uYzoxMjYNCj4gMTEgMHgwMDAwMDAwMDAwNDE5NTdhIGluIGxfbWFpbl9pdGVyYXRl
ICh0aW1lb3V0PTxvcHRpbWl6ZWQgb3V0PikgYXQgZWxsL21haW4uYzo0NzMNCj4gMTIgMHgwMDAw
MDAwMDAwNDE5NjRjIGluIGxfbWFpbl9ydW4gKCkgYXQgZWxsL21haW4uYzo1MjANCj4gMTMgMHgw
MDAwMDAwMDAwNDE5ODZiIGluIGxfbWFpbl9ydW5fd2l0aF9zaWduYWwgKGNhbGxiYWNrPWNhbGxi
YWNrQGVudHJ5PTB4NDE1M2EwIDxsX3NpZ19mdW5jPiwgDQo+IHVzZXJfZGF0YT11c2VyX2RhdGFA
ZW50cnk9MHgwKSBhdCBlbGwvbWFpbi5jOjY0Mg0KPiAxNCAweDAwMDAwMDAwMDA0MTU0NzEgaW4g
bWFpbmxvb3BfcnVuX3dpdGhfc2lnbmFsIChmdW5jPWZ1bmNAZW50cnk9MHg0MTM5YTAgPHNpZ25h
bF9jYWxsYmFjaz4sIA0KPiB1c2VyX2RhdGE9dXNlcl9kYXRhQGVudHJ5PTB4MCkgYXQgc3JjL3No
YXJlZC9tYWlubG9vcC1lbGwuYzo4Nw0KPiAxNSAweDAwMDAwMDAwMDA0MTRiNmYgaW4gYnRfc2hl
bGxfcnVuICgpIGF0IHNyYy9zaGFyZWQvc2hlbGwuYzoxMTc3DQo+IDE2IDB4MDAwMDAwMDAwMDQw
MzllZCBpbiBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91dD4p
IGF0IHRvb2xzL21lc2gtY2ZnY2xpZW50LmM6MTk5OQ0KPiAtLS0NCj4gIHRvb2xzL21lc2gtY2Zn
Y2xpZW50LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoLWNmZ2NsaWVudC5jIGIvdG9v
bHMvbWVzaC1jZmdjbGllbnQuYw0KPiBpbmRleCBkMWM2NzMxLi41N2EyNjA3IDEwMDY0NA0KPiAt
LS0gYS90b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+ICsrKyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50
LmMNCj4gQEAgLTE2OTMsNyArMTY5Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2Ug
KmFkZF9ub2RlX2ZhaWxfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgc3RhdGljIHZvaWQg
c2V0dXBfcHJvdl9pZmFjZShzdHJ1Y3QgbF9kYnVzX2ludGVyZmFjZSAqaWZhY2UpDQo+ICB7DQo+
ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJTY2FuUmVzdWx0IiwgMCwgc2Nhbl9y
ZXN1bHRfY2FsbCwgIiIsDQo+IC0JCQkJCQkibmF5YXtzdn0iLCAicnNzaSIsICJkYXRhIik7DQo+
ICsJCQkJCQkibmF5YXtzdn0iLCAicnNzaSIsICJkYXRhIiwgIm9wdGlvbnMiKTsNCj4gIA0KPiAg
CWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiUmVxdWVzdFByb3ZEYXRhIiwgMCwgcmVx
X3Byb3ZfY2FsbCwNCj4gIAkJCQkicXEiLCAieSIsICJuZXRfaW5kZXgiLCAidW5pY2FzdCIsICJj
b3VudCIpOw0K
