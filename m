Return-Path: <SRS0=R8GA=23=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183DC33C8C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9540720848
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PNibQgvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAFPgW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:36:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:8397 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgAFPgV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 10:36:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 07:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="302907200"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2020 07:36:21 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 07:36:20 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 07:36:20 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jan 2020 07:36:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 07:36:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLAbXAIyvo9GzrPgwlkcpRTanVBXavTeHs4knXKg1fzC9ct4VqHo9oM4aQd7Q+jLTDiM18Dxxc4dYGgESMk8wWy5J6USoyOBL4OSPl2c9fCxw0M+Q/W03C+8L/g5tNtIB7pERMHaavnKcu4qR4Bt9xhOvTq6MwjJdadq0lqL1q9evLO7ApVxJbpwUuUWvTeHJUsbVhFPf2zP1Q3wlFtj6CuYOE6MvtkkOrN4KDJ02Igd15U6wGefeeXHrF1g2WReTCmnu9vxTC/h5MGtoQ79Mc5uC7g6lB5/sk128Xql1K+iQkA6bQOj9HGJfKrfHP0xDuDIwcz0RPvN2D6/1hfj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSIOE+bdUgYsPKhx534gkmItDaXdCo+aQqOhzeqas14=;
 b=jvdL5NwHjNpQ848QU9IEXdNzTg0uUZ0mvL5tx/+BtMeXE5tF/r7AfgUXL5SGJPPJ7LdUPC+G3lzHS6Gye5usoXPfZ6gptfe9mYzViGEoB2zl/qf7uNNWRjyfh9kWuLqZiPEvi65ppYA6V5f2F9J4cMiVDwpJwaA+e931O56kAdipXWKVsuWgBTP/vH53tmZmtlK2JEVKNhLkObf04sdThjip83cMrIiPpe7W/TUH1IHZLHgTDWJHnPry0hmKwsB4d1bs/XfP5O4G1hXjyO/HQ74hDNtfl7kMvt2zaYPNIhV8DePzT8Q1A88kFvZMECbMTg+PBRwR5heYSmQS2SmCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSIOE+bdUgYsPKhx534gkmItDaXdCo+aQqOhzeqas14=;
 b=PNibQgvyrskxYvJi/stMbd8+JZhukvYE8SoWoUUftvZrc2cZ+Au/pnCa5Jr8g1RjB8xydf/2nE8jPZ3eMMrVWAk16bKEc+14OZCQsKN5URgQuFevum+EmAwQL7cgR4K8p7Guloq+fpifPiHyUkMhdlKm658+3f4aF/icryxHpm0=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1240.namprd11.prod.outlook.com (10.169.251.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Mon, 6 Jan 2020 15:36:19 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:36:19 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "biradar.a@samsung.com" <biradar.a@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] meshctl: Fix infinite sock read
Thread-Topic: [PATCH 1/1] meshctl: Fix infinite sock read
Thread-Index: AQHVq+uhO5Dt87cXXkib5fdUAuoSS6fd9jwA
Date:   Mon, 6 Jan 2020 15:36:18 +0000
Message-ID: <202bf1a0b3d1be8a42d2a7b842978b5a20fdb451.camel@intel.com>
References: <CGME20191206041323epcas5p35d6b7b22e50698d10af05d669001fd5a@epcas5p3.samsung.com>
         <1575605584-734-1-git-send-email-biradar.a@samsung.com>
In-Reply-To: <1575605584-734-1-git-send-email-biradar.a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 997ed5e5-d11b-41b6-7f1c-08d792be2ceb
x-ms-traffictypediagnostic: CY4PR11MB1240:
x-microsoft-antispam-prvs: <CY4PR11MB12403A94F887FCA882785217E13C0@CY4PR11MB1240.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(5660300002)(110136005)(66476007)(64756008)(66446008)(4744005)(26005)(71200400001)(36756003)(6512007)(8936002)(66556008)(86362001)(316002)(478600001)(81156014)(76116006)(8676002)(6506007)(91956017)(81166006)(2616005)(6486002)(66946007)(186003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1240;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wR3Hvd6A6T6+Vy9Y9qZaM41osnCtqfbxIqNgXf42Vs/PVATMpXQSbpqM503JfezlY92s5ulEHwHtRpXYIjhX40kny5tg4BiCObHYFFz2/JSWne0mfSkzeZbMAQId62gU5m3Pd5kshZPGe23mcy0YCbCkfbZCYH4ZLfBRXULH+DnWarM9mzdeNN+43jOvVqbzph+ZYzcjuTH9xtQ7myXhSdmlSD0I6qYIj/Knml2xxS39jy1y+qtQN9Z+wCyKTiTA8m5f2dWD189J4v7Zw+J6BWyOlNuxctC6WY6NTAEruKnQ8Qv/GJD3AcehqSxyAGDHKh9dU97go2CImsuLiQfap+1RzUkPl715v+HRv5BnTc5pvtAE6k/dCgm8gvauIPKWLYbCxZ/SygIagoZ5NEVEy7O3AHBLJ1iNSdLGyWzuiwoRixj0E+muPYjHLQvnKHF3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D41CE1201D9E3F4E99B0569043C4A992@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ed5e5-d11b-41b6-7f1c-08d792be2ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:36:18.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zb/xXxPmJWhU6vt9j8p9bNqKrKk2I3pFKJVp3v59MPZms46OuMi8pVU6ei4S9O31dgpgzDLWA1W0u76G4vK75A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1240
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDE5LTEyLTA2IGF0IDA5OjQzICswNTMwLCBBbnVyYWcgQmlyYWRh
ciB3cm90ZToNCj4gV2hlbiBhIHN0cmVhbSBzb2NrZXQgcGVlciBoYXMgcGVyZm9ybWVkIGFuIG9y
ZGVybHkgc2h1dGRvd24sDQo+IHRoZW4gcmV0dXJuIHZhbHVlIHdpbGwgYmUgMC4NCj4gLS0tDQo+
ICB0b29scy9tZXNoLWdhdHQvZ2F0dC5jIHwgNyArKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
bWVzaC1nYXR0L2dhdHQuYyBiL3Rvb2xzL21lc2gtZ2F0dC9nYXR0LmMNCj4gaW5kZXggYmZmNTk0
Ny4uMWJkOTg2OCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC1nYXR0L2dhdHQuYw0KPiArKysg
Yi90b29scy9tZXNoLWdhdHQvZ2F0dC5jDQo+IEBAIC00MTYsNyArNDE2LDcgQEAgc3RhdGljIGJv
b2wgc29ja19yZWFkKHN0cnVjdCBpbyAqaW8sIGJvb2wgcHJvdiwgdm9pZCAqdXNlcl9kYXRhKQ0K
PiAgCW1zZy5tc2dfaW92bGVuID0gMTsNCj4gIA0KPiAgCXdoaWxlICgobGVuID0gcmVjdm1zZyhm
ZCwgJm1zZywgTVNHX0RPTlRXQUlUKSkpIHsNCj4gLQkJaWYgKGxlbiA8PSAwKSB7DQo+ICsJCWlm
IChsZW4gPCAwKSB7DQo+ICAJCQlpZiAoZXJybm8gPT0gRUFHQUlOKQ0KPiAgCQkJCWJyZWFrOw0K
PiAgCQkJcmV0dXJuIGZhbHNlOw0KPiBAQCAtNDMxLDYgKzQzMSwxMSBAQCBzdGF0aWMgYm9vbCBz
b2NrX3JlYWQoc3RydWN0IGlvICppbywgYm9vbCBwcm92LCB2b2lkICp1c2VyX2RhdGEpDQo+ICAJ
CQkJbmV0X2RhdGFfcmVhZHkocmVzLCBsZW5fc2FyKTsNCj4gIAkJfQ0KPiAgCX0NCj4gKw0KPiAr
CS8qIFdoZW4gc29ja2V0IGlzIG9yZGVybHkgY2xvc2VkLCB0aGVuIHJlY3Ztc2cgcmV0dXJucyAw
ICovDQo+ICsJaWYgKGxlbiA9PSAwKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gIAlyZXR1
cm4gdHJ1ZTsNCj4gIH0NCj4gIA0K
