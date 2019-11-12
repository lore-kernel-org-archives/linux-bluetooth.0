Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167F4C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14A2084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tPDqq1WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKLRzC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:55:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:61010 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLRzC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 12:55:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 09:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="214132492"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2019 09:55:01 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:55:00 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX155.amr.corp.intel.com (10.22.240.21) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:55:00 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 12 Nov 2019 09:55:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPebUaIRf88vgl6ZG/2MY+n6+RtV/Vcw7d1lkddh3u7qi11aBc8fqYRjJG7PfaZZpdSSS+2Qux4wFzJ8AcnDrmy1bkZAnCZ37t71u8ZyKDlBejgEFNEcFsI5vpMrbuWhJSXTt4n1hJ7SxRzfYrPh33qMq7Pp9Ynp7uYZ7rTGO3y/tJCaT7t/D7fJSKuR7KI0xX0X/HEgn9QTW9/pYCiX2obnfg31FsBb5gxgat2ecGshI6GZxjrh2lmmbT1dbv5Rl7gDvZthiRqRVFt0SjT5tIEzi6rrZGt1oOgggt5Tqw408GoaAu/sMU99dtthZa3YnNP/r3ubum2suk5GdXQYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgZB2HRCOhdLgm8Z2Q27Kp+ymwHv8L00ZYQnCvlSh8=;
 b=b3Ecw6in3xIi0bsSpGMBl8V3R6CTeCFpqBsOi8J/9qfWTaThRQXoXdo4K4SZ4Kw1WwLHIgbqkAf4JBXH5BZ+mbOTjhnYV5UxkEueA0yZQZp4BdnpaCwpnrs8+es0409TUJnd9ARZFqYQ/3mSS8d0vT4AlpZ2vdi+HkPEm1su9KgM6jrXJZtcIb0CjRYfgOLaNg9dt51XZflA5RzFgj7eqZPi6pzVKY1RxyEIlya7RNM/7Jvp7VMH5I0SJQ8E0EgGVrnhUNmHLD9y/+CsvGcmhSmTPPgQsAitcO7Sq0jZm+qS+tlFWX2vCaMLHUGC1Jb/d4WFUhgmclxkl3WrMqhkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgZB2HRCOhdLgm8Z2Q27Kp+ymwHv8L00ZYQnCvlSh8=;
 b=tPDqq1WPtt6vuw4FxxZC8dUwEwd0iVZfs9Q+rTLmZ5AYU6OAaTuGwASyG2Ws4DDbjBDjJO1WA5ePxmNwac7NBzGUqxpC+ZMugfJkFVqTdN2cRGrc95uysPnVweOJ6THI9cfwMO+EjPD7qrfdi3A6fWgTmFETknA1aHw7nWMu7KA=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2215.namprd11.prod.outlook.com (10.174.52.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 17:54:58 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 17:54:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: fix sending messages to group addresses
Thread-Topic: [PATCH BlueZ] mesh: fix sending messages to group addresses
Thread-Index: AQHVmJnyBxC6R4DG0EeckrmLh2DlTKeH02IA
Date:   Tue, 12 Nov 2019 17:54:57 +0000
Message-ID: <fe2e66a6d2601d2577a0712ab1ced2c2a2fdd6ec.camel@intel.com>
References: <20191111141046.7972-1-aurelien@aurel32.net>
In-Reply-To: <20191111141046.7972-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c36d5ab5-2617-4712-6d05-08d767996e88
x-ms-traffictypediagnostic: CY4PR1101MB2215:
x-microsoft-antispam-prvs: <CY4PR1101MB2215FAE080585E3BA4E49F02E1770@CY4PR1101MB2215.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(186003)(99286004)(6436002)(71190400001)(118296001)(25786009)(305945005)(486006)(6506007)(102836004)(76176011)(446003)(11346002)(26005)(7736002)(66066001)(476003)(2616005)(6512007)(6486002)(15650500001)(229853002)(256004)(71200400001)(6246003)(66556008)(66476007)(64756008)(81166006)(81156014)(66946007)(66446008)(8676002)(76116006)(2906002)(6116002)(478600001)(3846002)(91956017)(2501003)(316002)(4001150100001)(36756003)(14454004)(4744005)(8936002)(5660300002)(110136005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2215;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Li77Z94mKLyqTTB4X0/7xwR9okJJdG0FE4YPE8twdDO7RapTMb16M8CTPuJqyWc3cDgbMkKFR64isEXCB3Gu3muM2u8Y4PBsoO5DWCc7gHRJPH3a9DPKoGV5RjnMvh6Dznu4N+JiHxyB0i2OIklUl607e6EXv+0t5FY5erNzn4jj3mJ+jtm2zsT7GFpG6r6t0N9su8Tt/cZBJDuOWRc65MDNZ4SA2Jv4nIM0g7xANb07cS38/jOA8xwejgGghsRityUPNmLkZczZCORoMHRcaoaAVs5IpzLgoaJR296jfF4kiKW/CO3xj5OtApaIa+lQeA9AekPhnJzKUIm+ie3IvnvUPaaTgdRp6UQU9HsOd1r0IDyrqm/NUU20vW+5x8OACh2Xk4H3112H39VSoYQJwcO4Y7bFsJXGtoRNBrpebdZ02NjNDmb2/kS4PVrOmIMr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <993661901061C948A3397A0274C8A0E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d5ab5-2617-4712-6d05-08d767996e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:54:57.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pC4kyq1f59GtPCD8XI16bXq0R4PnJD21J/GufST/EIYMUyMGYx43ftAOwekZl9E+2yPmwLNaU9fGq/u9AZ37UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2215
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAxNToxMCArMDEwMCwgQXVy
ZWxpZW4gSmFybm8gd3JvdGU6DQo+IFdoZW4gc2VuZGluZyBhIG1lc3NhZ2UgdG8gYSBncm91cCBh
ZGRyZXNzIChlaXRoZXIgdmlydHVhbCBvciBmaXhlZCksIGl0DQo+IGhhcyB0byBiZSBzZW50IE9U
QSBldmVuIGlmIHN1Y2Nlc3NmdWxseSBlbnF1ZXVlZCB0byBhbiBpbnRlcm5hbCBtb2RlbC4NCj4g
LS0tDQo+ICBtZXNoL25ldC5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBi
L21lc2gvbmV0LmMNCj4gaW5kZXggZjA3ZGU0ZDhhLi4zM2I0OTgxMzUgMTAwNjQ0DQo+IC0tLSBh
L21lc2gvbmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAtMzMzOSwxMCArMzMzOSwxMCBA
QCBib29sIG1lc2hfbmV0X2FwcF9zZW5kKHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIGZybmRf
Y3JlZCwgdWludDE2X3Qgc3JjLA0KPiAgCQkJCXN6bWljLCBzZXEgJiBTRVFfWkVST19NQVNLLA0K
PiAgCQkJCW1zZywgbXNnX2xlbik7DQo+ICANCj4gLQkvKiBJZiBzdWNjZXNzZnVsbHkgZW5xdWVk
IG9yIGRlbGl2ZXJlZA0KPiAtCSAqIHRvIFVuaWNhc3QgYWRkcmVzcywgd2UgYXJlIGRvbmUNCj4g
KwkvKiBJZiBhZGRyZXNzZWQgdG8gYSB1bmljYXN0IGFkZHJlc3MgYW5kIHN1Y2Nlc3NmdWxseSBl
bnF1ZXVlZCwNCj4gKwkgKiBvciBkZWxpdmVyZWQgdG8gb25lIG9mIG91ciBVbmljYXN0IGFkZHJl
c3NlcyB3ZSBhcmUgZG9uZQ0KPiAgCSAqLw0KPiAtCWlmIChyZXN1bHQgfHwgc3JjID09IGRzdCB8
fA0KPiArCWlmICgocmVzdWx0ICYmIElTX1VOSUNBU1QoZHN0KSkgfHwgc3JjID09IGRzdCB8fA0K
PiAgCQkJKGRzdCA+PSBuZXQtPnNyY19hZGRyICYmIGRzdCA8PSBuZXQtPmxhc3RfYWRkcikpIHsN
Cj4gIAkJLyogQWRqdXN0IG91ciBzZXFfbnVtIGZvciAidmlydHVhbCIgZGVsaXZlcnkgKi8NCj4g
IAkJbmV0LT5zZXFfbnVtICs9IHNlZ19tYXg7DQo=
