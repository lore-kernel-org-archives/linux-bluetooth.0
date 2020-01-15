Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC32C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F32187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OhE5TaMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAOTxN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:53:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:27296 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbgAOTxN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 14:53:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 11:53:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="243001802"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2020 11:53:12 -0800
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 11:53:11 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 11:53:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jan 2020 11:53:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBxNhHHzYXljyuimDiX2J8noxnEtVuZXvadC9ZO7RBdz4ol0CS8I9eJOFUYCcz2hd+6HUD8HzaU6gIPHGt0n/MAUvwxNnTebFQNXkIUrjyDT4V6FYCtk2UfSLA5041Pm1GlmXiAcTrk9QRkH8795tHQeXYCKJL8R/tu+DJieYbxlx9YwzlsATPTRcDVersGEAOkWmIUccEFqAUt038D9y5GR5BS8q2kollYax6lYJo2kmRVWhNM15yoE30rSJ20hS3on2S4aIMC9ybwvqXDxrsVIBIOafrD8GVPa0xV3UCNWsbB4iBuy+rgQV94qkFapuuePB0Kwj0R9R/fCUOePyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1wrEOqt/4bX4qTcRoPKcAOX/8wacI1WORm5WWsFRuo=;
 b=gKMmICAO4v4EuJvH6zT9V5Ly9nzF1f68LM/OE2xCFXg2ByJoYecdh+ExFckI5CSoI8VzexxUi48QSX1JQ7InyZbOeFtvcdJ8iJa6PsBqtQx+pfZQFuOoNY8pqDO6D5NyboLt2jX9ehMcDN/yXwNIpMgq+5xPu/3t1d2Z1PqWAidSlBk3Yt01RlMZU5o+R/KS894krY5P6BTpoN3iOXw59tLc8ynFR27sQSaKSNRqzjmCrv8kDNFB4wYo700YZN0K1Rp4+MLsr6huAkENPVisYnEU7jwMUA8A34bEvfaz13BUVXDqRXH34bWhnjf5CkayqbKCqF8jHoU4tSYD7hfezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1wrEOqt/4bX4qTcRoPKcAOX/8wacI1WORm5WWsFRuo=;
 b=OhE5TaMdqFpPzuG8aFP/c5XfpU0/ayj/soOmZHohuwTHLiLxVq2a+OP6RI2uqEU3xevokGHlcKCDRP6ZDNLrhEvDC1v7RgbpX+qDUyAaQ9qaLaZlJNggiyeja4ZcecPMz7TC33x+YHcxZXJlbhpVsC4CQEj3VNgcvMoJAqhvwf0=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.55.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 19:53:09 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 19:53:09 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Thread-Topic: [PATCH 0/1] Sequence number out of range fix
Thread-Index: AQHVy8aSDlcsWuHBsESeDxHuzoHNCKfsDXQAgAAJgACAAAxRqg==
Date:   Wed, 15 Jan 2020 19:53:09 +0000
Message-ID: <4C48D122-7887-4A5E-9E3C-0A2FE15D6A1A@intel.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
 <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>,<20200115190904.qcusabsj3ti7sid4@kynes>
In-Reply-To: <20200115190904.qcusabsj3ti7sid4@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [2607:fb90:563e:52b8:2476:344f:9aff:e57f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b42745c-e903-4d76-67a3-08d799f48c31
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB1470DA4059637D947868C56BE1370@MWHPR11MB1470.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(66446008)(64756008)(966005)(2906002)(66476007)(6506007)(8676002)(81166006)(53546011)(33656002)(4326008)(81156014)(86362001)(6486002)(66556008)(6916009)(66946007)(76116006)(478600001)(91956017)(8936002)(5660300002)(2616005)(186003)(6512007)(36756003)(66574012)(316002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T23TKu6BkNLTbx/Kzu0m8WnkZ42MNgqamqZZo1gTKeKBl58bSXjEUaY6DnQg5XPm2O9pp9+zdO8Vf5blWeCEqq20qAUOVs1lIN6e/473nW0wNceVfJ5I5e6JnzZ1QjgN3M60qbaj9degLF5kApQSd6/IE9s9g1Bv+o+KPKSmXWc+TWE7x0XJfZSKt1GP/MgugJQbz00zRi4oSWmSTuuBB6J/Y6SzZ6nVD+v3f1Rj/sVNbFXPitonkccZ2VbqrvUr3W1YE9DQBDrxztWi85KEFp5ksQsgd0rwO7PcoZjK+h1DZjlVwCSym4YnQ94z3SI9OmGAglBR8WniyjKSruwpX6qQf2lHckdHRVFPZxBztXxuJ5iPUqtpkO21ZsujB99em/du7NWismyx6/EpAi/ZEnEQ1LDmHgB7rhSqaOowa4nZeRNKh2/G7epTu9j8fGbgqN79sNZWRmREISWG3h+VJkR3esKHz9EC2WrW40c9x+Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b42745c-e903-4d76-67a3-08d799f48c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 19:53:09.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YSs+rEMbUSRKcxykx8E6MOcdsB+WPJ/5JJ6nOs9//iHwGcky6Szaqt/YAPGUzfTJf/B40RvaWy7a04JIEPylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1470
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiANCg0KPiBPbiBKYW4gMTUsIDIwMjAsIGF0IDExOjA5IEFNLCAibWljaGFsLmxv
d2FzLXJ6ZWNob25la0BzaWx2YWlyLmNvbSIgPG1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFp
ci5jb20+IHdyb3RlOg0KPiANCj4g77u/QnJpYW4sIEpha3ViLA0KPiANCj4+IE9uIDAxLzE1LCBH
aXgsIEJyaWFuIHdyb3RlOg0KPj4gVGhpcyBpcyBhIHZlcnkgZGFuZ2Vyb3VzIGNvdXJzZSBvZiBh
Y3Rpb24uICBUaGUgc3VnZ2VzdGVkIHBhdGNoIG1pZ2h0DQo+PiBwb3RlbnRpYWxseSBjYXVzZSBh
IG5vZGUgdG8gcmUtdXNlIGEgc2VxdWVuY2UgbnVtYmVyIG1vcmUgdGhhbiBvbmNlLA0KPj4gd2hp
Y2ggd291bGQgY2F1c2UgYSAiZGlydHkgbm9uY2UiIGNvbmRpdGlvbiwgYW5kIGFsbG93IHVuYXV0
aG9yaXplZA0KPj4gZW50aXRpZXMgdG8gZGVyaXZlIHRoZSBlbmNyeXB0ZWQgZGF0YSB3aXRob3V0
IHRoZSBrZXlzLg0KPiANCj4gR29vZCBwb2ludC4gTm90ZSB0aGF0IGhpcyBpcyBhbHNvIHBvc3Np
YmxlIGluIHRoZSBjdXJyZW50DQo+IGltcGxlbWVudGF0aW9uOiBzaW5jZSBzZXFfbnVtIGlzIGFw
cGxpZWQgdG8gbm9uY2Ugd2l0aCBhIDI0Yml0IG1hc2ssDQo+IGl0J3MgZ29pbmcgdG8gd3JhcCBh
cm91bmQuDQoNClRoZSBmdWxsIElWIEluZGV4IGlzIGluIHRoZSBub25jZSwgYW5kIGF0IDE5MiBo
b3VycyBwZXIgSVYgaW5kZXgsIHdpbGwgYmUgdW5pcXVlIGZvciBzb21ldGhpbmcgbGlrZSAxLjQg
bWlsbGlvbiB5ZWFycy4NCg0KPiANCj4+IFdoaWxlIHRoaXMgaXMgdGVjaG5pY2FsbHkgcG9zc2li
bGUsIGVzcGVjaWFsbHkgd2l0aCBhIGRhZW1vbiB0aGF0DQo+PiBtaWdodCBiZSBsb29waW5nIGJh
Y2sgbWVzc2FnZXMgaW50ZXJuYWxseSB3aXRob3V0IGV2ZXIgdXNpbmcgdGhlIE9UQQ0KPj4gaW50
ZXJmYWNlLCBpdCBpcyBub3QgcmVhbGx5IHBvc3NpYmxlIGluIGFuIGFjdHVhbCBCVCBkcml2ZW4g
cmVhbCBsaWZlDQo+PiBzeXN0ZW0uDQo+IA0KPiBUaGVyZSBpcyBhbm90aGVyIG9wdGlvbiB0byBl
eGhhdXN0IHRoZSAyNCBiaXQgcmFuZ2U6IHdlIGhhdmUgdGhlDQo+IG92ZXJjb21taXQgbWVjaGFu
aXNtIGluIHRoZSBzdG9yYWdlLiBMZXQncyBzYXkgdGhlIGRhZW1vbiBzdGFydHMsIHNlbmRzDQo+
IGEgZmV3IG1lc3NhZ2VzIChhbmQgb3ZlcmNvbW1pdHMgdGhlIHNlcXVlbmNlIGJ5IGEgY2VydGFp
biB2YWx1ZSksIHRoZW4NCj4gZWl0aGVyIHRoZSBkYWVtb24sIG9yIHRoZSBzeXN0ZW0gY3Jhc2hl
cy4NCj4gDQo+IERvIHRoYXQgYSBmZXcgdGltZXMsIGFuZCB5b3UgZW5kIHVwIHdpdGggc3RvcmFn
ZSBjb250YWluaW5nIHNlcXVlbmNlDQo+IG51bWJlciBleGNlZWRpbmcgMjQgYml0cy4NCg0KDQpU
aGUgb3ZlciBjb21taXQgaXMgY2FsY3VsYXRlZCBiYXNlZCBvbiB0aGUgdXNhZ2UgcmF0ZSwgYW5k
IHRoZSBkYWVtb24gd291bGQgbmVlZCB0byB1bmV4cGVjdGVkbHkgYWJvcnQgKG5vdCBqdXN0IGN0
cmwtYyBvciBleGl0KSBmb3IgdXMgdG8gdXNlIHRoZSBvdmVyLWNvbW1pdCB2YWx1ZSwgYXMgb24g
ZGVsaWJlcmF0ZSBleGl0LCB0aGUgYWN0dWFsIHNlcXVlbmNlIHVzZWQgaXMgc2F2ZWQuIElmIGFu
IHVuZXhwZWN0ZWQgYWJvcnQgb2NjdXJzLCBJIHRoaW5rIHRoZSBkZWZhdWx0IGRhZW1vbiByZXN0
YXJ0IGlzIDUgc2Vjb25kcz8NCj4gDQo+PiBCZWFjdXNlIHdlIHN0b3JlIHNlcXVlbmNlIG51bWJl
cnMgaW50ZXJuYWxseSB3aXRoIGEgdTMyIHNpemVkIGRhdGENCj4+IHR5cGUsIHdlIHNob3VsZCAq
bGV0KiB0aGUgdmFsdWUgZ28gb3ZlciB0aGUgbWF4IGxlZ2FsIHNlcXVlbmNlDQo+PiBudW5tYnZl
ciBvZiAweEZGRkZGRiAocGVyaGFwcyBjYXBwaW5nIGl0IGF0IDB4MDEwMDAwMDAgdG8gcHJldmVu
dA0KPj4gInN1cGVyIG92ZXJmbG93cyIpLiAgVGhlbiB3ZSAqcmVqZWN0KiBhbGwgc2VuZCByZXF1
ZXN0cyB3aXRoIGENCj4+IHNlcXVlbmNlIG51bWJlciA+IDB4RkZGRkZGLg0KPiANCj4gU291bmRz
IGdvb2QuDQo+IA0KPiAtLSANCj4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5sb3dh
cy1yemVjaG9uZWtAc2lsdmFpci5jb20+DQo+IFNpbHZhaXIgaHR0cDovL3NpbHZhaXIuY29tDQo+
IEphc25vZ8OzcnNrYSA0NCwgMzEtMzU4IEtyYWtvdywgUE9MQU5EDQo=
