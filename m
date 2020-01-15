Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D20C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2B62081E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NpeRpY6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAOVVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:21:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:55874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgAOVVv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:21:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 13:21:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="257003698"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 13:21:51 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 13:21:50 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 13:21:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jan 2020 13:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egz10lFHVvg1F62HC8eDsUDwcPPUFlAMLqvJwFBtGPmqba7jrLvKnuCJ7KVGyUYW8Ro1jr+RqfnmAf61ya4/SW9h/Pa1s2/ISJSCQgw4905ig0zpAqzln94304ndpCZXRVuow2Ah1lf5nYvJkLNgyy7yg8qvSF4EteveguR0RJxgtjsab/bEDYVPjRBBKzG9eA9/+IZrTaN6hx5cloXT8ASTVhfhqHh5UsvkxAxXS72os0gHaSDg3qq0Cok9jG5o2FradiI/89GoBZta//ktyR/g1vcampBa3xP0hSUXU5V/gkTWvyXF0P9tB5EgXdxS/TFIGz3ziryGWXlDcdSHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5RNCSv03jPwxuUTgi9CJv9qpRH6Y5i6D4sDMtmpJXs=;
 b=b/wrIqrWpWZV+yZMZzyGFbaB6Uy9vw+2vbL8YxdZGr5+x78WHxiHNt/uzYPP00QGqpWO81ZMVi2oEKVNV5RuDFTCdciUCTqRSNKv1fweSyA82vbBgCANDgsMX2IgM5EVtxLzcTKWBxiiVEgUpDCnWuJ111YGO9Bc8i2JniHjjkVRe8RChvPoqGSRu89b5bgV1gZGT88gVhjlvLEhHjDFA2tRKFHdSGTO8QaX2fut/6Jibx+8/MfNx3MiU5uBd1ZaiaTaSE9K5JilsHIgGWK+kCSuTw5+ajgA1mZiysUwuN86kbRGsqlLx20fOa50RoOxKNdh63LQpWFd9YovcQyoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5RNCSv03jPwxuUTgi9CJv9qpRH6Y5i6D4sDMtmpJXs=;
 b=NpeRpY6ZKKM4biggtoQ2FhEoZeqYE2Ew405Mhh+n6Vz5Thzse+y653rai10nncOUyK1U6WNVgvQkfkT1MMC5vJJwQleJzvaLnKChMJNgDJIPU8iwto/0KTzAJ4REFStNxrTHi1WN5JKhxSZCxSR6ad1Uc2ri7Oi+dmz8KU/ui7s=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB2061.namprd11.prod.outlook.com (10.169.236.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 21:21:49 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 21:21:49 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Thread-Topic: [PATCH 0/1] Sequence number out of range fix
Thread-Index: AQHVy8aSDlcsWuHBsESeDxHuzoHNCKfsDXQAgAAJgACAAAxRqoAAE9wAgAAE6AA=
Date:   Wed, 15 Jan 2020 21:21:49 +0000
Message-ID: <456a42fe1d521b9c61bb54bacbddf7b99573df5f.camel@intel.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
         <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
         <20200115190904.qcusabsj3ti7sid4@kynes>
         <4C48D122-7887-4A5E-9E3C-0A2FE15D6A1A@intel.com>
         <20200115210414.fvywao5evmbx5725@kynes>
In-Reply-To: <20200115210414.fvywao5evmbx5725@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea8366d1-e840-43e2-0085-08d79a00eeae
x-ms-traffictypediagnostic: MWHPR11MB2061:
x-microsoft-antispam-prvs: <MWHPR11MB20617A993790CC8202742555E1370@MWHPR11MB2061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(2616005)(86362001)(26005)(91956017)(71200400001)(316002)(186003)(76116006)(6512007)(66556008)(64756008)(66476007)(6506007)(36756003)(5660300002)(6916009)(4326008)(81156014)(478600001)(6486002)(66946007)(2906002)(54906003)(66446008)(8936002)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB2061;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8azp+uOjrdZttwyinfVvVKsxbX8E8SVwI7KgQVfNOY83hjwVG2SimiJyYDscuyRAHZAy0x+P5YryqcLKGM0TB5qoq/T97EMZlcKgcy+KqmBD0b1Qw6cE2/9T3qdUjCgdblOrg8wJhOgtmi82Brmb9UjlL4fFCbqb1OfjLZXlPPnkluY9sFWIerkFgvs9m48n2wFoJW6a/fFVy/gQ/i/xNT3RVX40tfcrf5dX29I3Waspl9HCeBDTw3Z2wu+g/yl/7w/k12JxCvGiNfGgtX0ttYiEbBKZTeTbJNJurQDT1leXwY7jnXp5XokF2Ro4KXrUKkYAHWkJF0pC3H3I8PjpAB6t739ldrWsyY/FuUre2bF1ls4L9gD85fvEov3Q3m3hSLUSGtj7I1wm8ryAzkn4E3qyuFle/8KjPL/BsTkpkedRsea/1dxPGU7uILZ359h2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDF54D9F73914B4CAF7EE0DB1668475E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8366d1-e840-43e2-0085-08d79a00eeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 21:21:49.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYeQuCERMu3WC0ql1zDQT50dPNSMbQotGO7622Sv1941EGqVIRR6NG0cskuJD3souH4Fb+lF9zOzU13IuRmF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2061
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTE1IGF0IDIyOjA0ICswMTAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tIHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IE9uIDAxLzE1LCBHaXgsIEJy
aWFuIHdyb3RlOg0KPiA+ID4gR29vZCBwb2ludC4gTm90ZSB0aGF0IGhpcyBpcyBhbHNvIHBvc3Np
YmxlIGluIHRoZSBjdXJyZW50DQo+ID4gPiBpbXBsZW1lbnRhdGlvbjogc2luY2Ugc2VxX251bSBp
cyBhcHBsaWVkIHRvIG5vbmNlIHdpdGggYSAyNGJpdCBtYXNrLA0KPiA+ID4gaXQncyBnb2luZyB0
byB3cmFwIGFyb3VuZC4NCj4gPiANCj4gPiBUaGUgZnVsbCBJViBJbmRleCBpcyBpbiB0aGUgbm9u
Y2UsIGFuZCBhdCAxOTIgaG91cnMgcGVyIElWIGluZGV4LCB3aWxsDQo+ID4gYmUgdW5pcXVlIGZv
ciBzb21ldGhpbmcgbGlrZSAxLjQgbWlsbGlvbiB5ZWFycy4NCj4gDQo+IFllcyBpdCBpcywgYnV0
IHRoYXQncyBub3QgdGhlIHBvaW50Lg0KPiANCj4gQXQgdGhlIG1vbWVudCwgbmV0LT5zZXFfbnVt
IGlzIGEgMzIgYml0IHZhbHVlIHRoYXQgKmNhbiogZXhjZWVkIDI0Yml0DQo+IHJhbmdlLCBiZWNh
dXNlIG1lc2hfbmV0X25leHRfc2VxX251bSgpIGRvZXNuJ3QgY2hlY2sgcmFuZ2VzLiBTbyB0aGUN
Cj4gcmF3IHZhbHVlIGNhbiByZWFjaCAweDEwMDAwMDAgYW5kIGFib3ZlLg0KPiANCj4gTm93LCB0
aGlzIHJhdyB2YWx1ZSBpcyB1c2VkIGluIHNlbmRfc2VnLCBwYXNzZWQgdG8NCj4gbWVzaF9jcnlw
dG9fcGFja2V0X2J1aWxkLCB3aGljaCBlZmZlY3RpdmVseSBhcHBsaWVzIGEgMjRiaXQgbWFzayBp
biBsaW5lDQo+IDY0MDoNCg0KWWVzLCB3ZSBzaG91bGQgZGVmaW5pdGVseSBiZSBzYW5pdHkgY2hl
Y2tpbmcgdGhpcywgYW5kIG5vdCBzZW5kaW5nIGlmIFNlcU51bSBvdXQgb2YgcmFuZ2UuDQoNCj4g
DQo+IAlsX3B1dF9iZTMyKHNlcSwgcGFja2V0ICsgMSk7DQo+IAlwYWNrZXRbMV0gPSAoY3RsID8g
Q1RMIDogMCkgfCAodHRsICYgVFRMX01BU0spOw0KPiANCj4gU28gdGhpcyBtZWFucyB0aGF0IHdo
ZW46DQo+IA0KPiAgLSB0aGUgbmV0d29yayBpcyBhbHJlYWR5IGluIGl2IHVwZGF0ZSAoc28gdGhh
dCB5b3UgY2FuJ3QgaW5jcmVhc2UgdGhlDQo+ICAgIGl2X2luZGV4LCBtYXliZSB5b3UgZXZlbiBz
dGFydGVkIHRoZSBwcm9jZWR1cmUgeW91cnNlbGYgYmVjYXVzZSB5b3VyDQo+ICAgIHNlcV9udW0g
aXMgYWJvdmUgdGhlIHRocmVzaG9sZCkNCj4gDQo+ICAtIHlvdXIgc2VxdWVuY2UgbnVtYmVyIGlz
IHN1ZmZpY2llbnRseSBsYXJnZSAoYmVjYXVzZSBvZiB0aGUgInJlcGVhdGVkDQo+ICAgIGNyYXNo
IiBzY2VuYXJpbyBkZXNjcmliZWQgYmVsb3cpDQoNCkkgdGhpbmsgaWYgd2UgYXJlIHJlcGVhdGVk
bHkgY3Jhc2hpbmcsIGFuZCBpdCBpcyBjYXVzaW5nIGEgcnVuYXdheSBzZXF1ZW5jZSBudW1iZXIg
aW5jcmVhc2UsIHRoYXQgYmVpbmcNCmZvcmJpZGRlbiB0byBzZW5kIG1vcmUgcGFja2V0cyBpcyBh
IG5hdHVyYWwgY29uc2VxdWVuY2UsIGFuZCBwZW9wbGUgc2hvdWxkIGZpeCB0aGUgY29kZSB0aGF0
IHdhcyBjYXVzaW5nIHRoZQ0KY3Jhc2ggaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQo+IA0KPiBUaGVu
IHRoZSBhY3R1YWwgdmFsdWUgdXNlZCBpbiB0aGUgbm9uY2Ugd2lsbCBiZSBuZXQtPnNlcV9udW0g
JiAweGZmZmZmZiwNCj4gd2hpY2ggaXMgc29tZXRoaW5nIHlvdSBoYXZlICphbHJlYWR5KiB1c2Vk
IGJlZm9yZS4gQWxsIG9mIHRoYXQgaGFwcGVucw0KPiB3aXRoIHRoZSBzYW1lIElWIGluZGV4Lg0K
PiANCj4gPiBUaGUgb3ZlciBjb21taXQgaXMgY2FsY3VsYXRlZCBiYXNlZCBvbiB0aGUgdXNhZ2Ug
cmF0ZSwgYW5kIHRoZSBkYWVtb24NCj4gPiB3b3VsZCBuZWVkIHRvIHVuZXhwZWN0ZWRseSBhYm9y
dCAobm90IGp1c3QgY3RybC1jIG9yIGV4aXQpIGZvciB1cyB0bw0KPiA+IHVzZSB0aGUgb3Zlci1j
b21taXQgdmFsdWUNCj4gDQo+IEluZGVlZCwgdGhhdCdzIHByZWNpc2VseSB3aGF0IEknbSB0YWxr
aW5nIGFib3V0IC0gcmVwZWF0ZWQsIHVuaGFuZGxlZA0KPiBwcm9jZXNzIHRlcm1pbmF0aW9ucy4g
V2UncmUgdHJ5aW5nIHRvIGNvbWUgdXAgd2l0aCB0aGUgcGF0Y2ggc2ltcGx5DQo+IGJlY2F1c2Ug
dGhpcyBzaXR1YXRpb24gaGFzICphbHJlYWR5IGhhcHBlbmVkKiBvbiBvbmUgb2Ygb3VyIGluc3Rh
bmNlcy4NCj4gDQo=
