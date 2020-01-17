Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BBC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263C22082F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zLlQZAJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQOPg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:15:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:53196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQOPg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 09:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="226356612"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2020 06:15:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 06:15:30 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 06:15:29 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 Jan 2020 06:15:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jan 2020 06:15:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVZaz+fUTQMSdUrTSiJts5oRJu9aJprIB9EvxZJYAAX3G3qXbDeIYnSnV9mlO+67HcuEnv8a47gME6IlZzqz+cI9RgwHY/2yfm5CW+alMgPkixwIqF+v8ZjSM7kBlTVF5HWY3EAUJIn3lCpUOr6bsJII8gseSBAdbhAnaH0KiGL0+oNKcAiHdH+fUnITgyQDNGyf3RpfB94JP3Rxftt/0zFxu02LBayeLxO3v8wz9PL7mVUYOE9/D/PsmGBG1VC7BqvkHDSlAEtkFBdBvu5iUmS6pyTg2jH22+IdY4eLHbO5FI4ld1g8E1JucE3uHgXlqVFXZ6l5UlvqxgH9JY5R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz3L7D6007gO0WHl2LK9HjRNVD4j1QbpVUQ/a/hH6Rw=;
 b=NwlsdSv9mqT5GlA/ViTRogMKMcKnJYeL1mZUJ3bOa5eQSDzTtQXqrjBnRhNvv89DAnowihHGHWsJ6UzeUF1/cg7y6Dmm47uSsyI5nLcv/jHhStl9kCUrNpuGnDeFKos3SUD2asV9TJK+h8VMjqQE7ty5GEGXfuCnaXW8w2s2Z/T/9uJaS+jAsOI+mU3pSjcrvIR5P5dgcthmblJ8R740GovZzAVlZgEzVXoa/lAZfL1+BfOlzVlPDRqHdZJqR6js4h5n++oI4vJ/RlcT6wlZrTl8NqSJDbGKQNu6fPPwLvvHk/yktv2TNSw3G0QDHjdDLmuZl34NF8zLiaz2ip1Y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz3L7D6007gO0WHl2LK9HjRNVD4j1QbpVUQ/a/hH6Rw=;
 b=zLlQZAJ47V/AvObWOz8qqrrrlc3bBLUYTjTZEJtb4E5ovS4W7mKpM9+3EaTEB1wEagZFYfyOB+Kxk/Q18BK6a0Ju9HR+mcmDi5yLkojUY1jTsGUt+27Pywezxlzte0pKTrRm1LKhnn5GNxf9qDKKZD1u3S46Hpu+FaVEjG8ji1U=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Fri, 17 Jan 2020 14:15:27 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 14:15:27 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     =?utf-8?B?TWljaGHFgiBMb3dhcy1SemVjaG9uZWs=?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Topic: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Thread-Index: AQHVzQYdUfE8nht/UUeExx2EIxj7Fqfu24MAgAALk+g=
Date:   Fri, 17 Jan 2020 14:15:27 +0000
Message-ID: <E1B6E49B-2246-4C1E-9C3C-D15CA1B6DF9C@intel.com>
References: <20200117071604.20675-1-brian.gix@intel.com>,<20200117133402.jvnrhoect6olamtk@mlowasrzechonek2133>
In-Reply-To: <20200117133402.jvnrhoect6olamtk@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [69.75.61.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19ca8dc6-3012-46d6-a7f4-08d79b57b3cd
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1806156B5F8D9CD51F01A00FE1310@MWHPR11MB1806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(36756003)(6512007)(81166006)(81156014)(8676002)(186003)(26005)(2906002)(86362001)(8936002)(33656002)(6486002)(71200400001)(6506007)(53546011)(54906003)(4326008)(2616005)(478600001)(66946007)(66446008)(66556008)(66476007)(316002)(5660300002)(91956017)(76116006)(107886003)(64756008)(6916009)(31214005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LhN8bhAH/Gl8HBfmVsAT+k8su9eZVgukrApgW0LquY9QJVtIjB5OB2RKnj+61DAEIi2q6Crz+oEzEsPdNP6IBBIG1YyDqE9+Pyb6NHzIP8GJ1ayGXVfB39xJy4AnNo1lAb4yPpF1vRNNEt7E1DWkTjBIT7VFeYe7+wIhaqNIV0hXYKjTd3AQbKC9hTpIWwmRQNIEjrvrVP0IqTihNeCu7zZqhrFFd3Fi4HjiLYSoP1XAEoCCcF/Y+LN1kJKzZYIh51PXwx2gEwIb7acrLXOAuLWG3smuHvApIwCE2NWkQM9B6N4p2r99pkmmSRMe2RaK2bS5MYSAlO/btnDqAGoFyaEu4slwVlh4lyiZ5FF0JLA9+em84V+QfWOZopsq9pj7n9HJS1e9vZLPrMK+C8nIS9hPzI8yELiVU3VOfNoTJT2kI28O4BD/xfkO24Nl6ai/mTEhZKGBYkskyG1HWOUbkiAEDmWpSTbHMKSy0OrDDpsr/Ag8pnDwB8Elve69qrbp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca8dc6-3012-46d6-a7f4-08d79b57b3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 14:15:27.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2shsenb4hfEE3eyXCRz18gPhtTZ/VUxpreqgW0qEffJBlLlL2KR5MeCsHpPhJOfHsS4GDDDgZhjn8c+lCVUxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiAsDQoNCj4gT24gSmFuIDE3LCAyMDIwLCBhdCA1OjM0IEFNLCBNaWNoYcWCIExv
d2FzLVJ6ZWNob25layA8bWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNvbT4gd3JvdGU6
DQo+IA0KPiDvu79IaSBCcmlhbiwNCj4gDQo+PiBPbiAwMS8xNiwgQnJpYW4gR2l4IHdyb3RlOg0K
Pj4gQW55IHBhY2tldCB0aGF0IG1heSBiZSBoYW5kbGVkIGludGVybmFsbHkgYnkgdGhlIGRhZW1v
biBtdXN0IGJlIHNlbnQgaW4NCj4+IGl0J3Mgb3duIGlkbGVfb25lc2hvdCBjb250ZXh0LCB0byBw
cmV2ZW50IG11bHRpcGxlIG5vZGVzIGZyb20gaGFuZGxpbmcNCj4+IGFuZCByZXNwb25kaW5nIGlu
IHRoZSBzYW1lIGNvbnRleHQsIGV2ZW50dWFsbHkgY29ycnVwdGluZyBtZW1vcnkuDQo+PiANCj4+
IFRoaXMgYWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcgY3Jhc2g6DQo+PiBQcm9ncmFtIHRlcm1pbmF0
ZWQgd2l0aCBzaWduYWwgU0lHU0VHViwgU2VnbWVudGF0aW9uIGZhdWx0Lg0KPj4gMCAgdGNhY2hl
X2dldCAodGNfaWR4PTApIGF0IG1hbGxvYy5jOjI5NTENCj4+ICAgICAyOTUxICAgdGNhY2hlLT5l
bnRyaWVzW3RjX2lkeF0gPSBlLT5uZXh0Ow0KPj4gKGdkYikgYnQNCj4+IDAgIHRjYWNoZV9nZXQg
KHRjX2lkeD0wKSBhdCBtYWxsb2MuYzoyOTUxDQo+PiAxICBfX0dJX19fbGliY19tYWxsb2MgKGJ5
dGVzPWJ5dGVzQGVudHJ5PTE2KSBhdCBtYWxsb2MuYzozMDU4DQo+PiAyICAweDAwMDA1NjRjZmY5
YmMxZGUgaW4gbF9tYWxsb2MgKHNpemU9c2l6ZUBlbnRyeT0xNikgYXQgZWxsL3V0aWwuYzo2Mg0K
Pj4gMyAgMHgwMDAwNTY0Y2ZmOWJkNDZiIGluIGxfcXVldWVfcHVzaF90YWlsIChxdWV1ZT0weDU2
NGQwMDBjOTcxMCwgZGF0YT1kYXRhQGVudHJ5PTB4NTY0ZDAwMGQwZDYwKSBhdCBlbGwvcXVldWUu
YzoxMzYNCj4+IDQgIDB4MDAwMDU2NGNmZjliZWFiZCBpbiBpZGxlX2FkZCAoY2FsbGJhY2s9Y2Fs
bGJhY2tAZW50cnk9MHg1NjRjZmY5YmU0ZTAgPG9uZXNob3RfY2FsbGJhY2s+LCB1c2VyX2RhdGE9
dXNlcl9kYXRhQGVudHJ5PTB4NTY0ZDAwMGQ0NzAwLA0KPj4gICAgZmxhZ3M9ZmxhZ3NAZW50cnk9
MjY4NDM1NDU2LCBkZXN0cm95PWRlc3Ryb3lAZW50cnk9MHg1NjRjZmY5YmU0YzAgPGlkbGVfZGVz
dHJveT4pIGF0IGVsbC9tYWluLmM6MjkyDQo+PiA1ICAweDAwMDA1NjRjZmY5YmU1ZjcgaW4gbF9p
ZGxlX29uZXNob3QgKGNhbGxiYWNrPWNhbGxiYWNrQGVudHJ5PTB4NTY0Y2ZmOTk4YmMwIDx0eF93
b3JrZXI+LCB1c2VyX2RhdGE9dXNlcl9kYXRhQGVudHJ5PTB4NTY0ZDAwMGQ4M2YwLA0KPj4gICAg
ZGVzdHJveT1kZXN0cm95QGVudHJ5PTB4MCkgYXQgZWxsL2lkbGUuYzoxNDQNCj4+IDYgIDB4MDAw
MDU2NGNmZjk5ODMyNiBpbiBzZW5kX3R4IChpbz08b3B0aW1pemVkIG91dD4sIGluZm89MHg3ZmZk
MDM1NTAzZjQsIGRhdGE9PG9wdGltaXplZCBvdXQ+LCBsZW49PG9wdGltaXplZCBvdXQ+KQ0KPj4g
ICAgYXQgbWVzaC9tZXNoLWlvLWdlbmVyaWMuYzo2MzcNCj4+IDcgIDB4MDAwMDU2NGNmZjk5Njc1
YSBpbiBzZW5kX25ldHdvcmtfYmVhY29uIChrZXk9MHg1NjRkMDAwY2ZlZTApIGF0IG1lc2gvbmV0
LWtleXMuYzozNTUNCj4+IDggIHNuYl90aW1lb3V0ICh0aW1lb3V0PTB4NTY0ZDAwMGRkNzMwLCB1
c2VyX2RhdGE9MHg1NjRkMDAwY2ZlZTApIGF0IG1lc2gvbmV0LWtleXMuYzozNjQNCj4+IDkgIDB4
MDAwMDU2NGNmZjliZGNhMiBpbiB0aW1lb3V0X2NhbGxiYWNrIChmZD08b3B0aW1pemVkIG91dD4s
IGV2ZW50cz08b3B0aW1pemVkIG91dD4sIHVzZXJfZGF0YT0weDU2NGQwMDBkZDczMCkgYXQgZWxs
L3RpbWVvdXQuYzo4MQ0KPj4gMTAgdGltZW91dF9jYWxsYmFjayAoZmQ9PG9wdGltaXplZCBvdXQ+
LCBldmVudHM9PG9wdGltaXplZCBvdXQ+LCB1c2VyX2RhdGE9MHg1NjRkMDAwZGQ3MzApIGF0IGVs
bC90aW1lb3V0LmM6NzANCj4+IDExIDB4MDAwMDU2NGNmZjliZWRjZCBpbiBsX21haW5faXRlcmF0
ZSAodGltZW91dD08b3B0aW1pemVkIG91dD4pIGF0IGVsbC9tYWluLmM6NDczDQo+PiAxMiAweDAw
MDA1NjRjZmY5YmVlN2MgaW4gbF9tYWluX3J1biAoKSBhdCBlbGwvbWFpbi5jOjUyMA0KPj4gMTMg
bF9tYWluX3J1biAoKSBhdCBlbGwvbWFpbi5jOjUwMg0KPj4gMTQgMHgwMDAwNTY0Y2ZmOWJmMDhj
IGluIGxfbWFpbl9ydW5fd2l0aF9zaWduYWwgKGNhbGxiYWNrPTxvcHRpbWl6ZWQgb3V0PiwgdXNl
cl9kYXRhPTB4MCkgYXQgZWxsL21haW4uYzo2NDINCj4+IDE1IDB4MDAwMDU2NGNmZjk5NGI2NCBp
biBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj0weDdmZmQwMzU1MDY2OCkgYXQgbWVz
aC9tYWluLmM6MjY4DQo+IA0KPiBIbS4gSSBjYW4ndCBzZWVtIHRvIHdyYXAgbXkgaGVhZCBhcm91
bmQgdGhpcyBiYWNrdHJhY2UuIERvIHlvdSBtYXliZQ0KPiBoYXZlIGEgcmVwcm9kdWN0aW9uIHBh
dGg/DQoNClRoZSBiYWNrdHJhY2UgZG9lc27igJl0IHJlYWxseSBzaG93IHdoYXQgaGFzIGdvbmUg
d3JvbmcgdmVyeSB3ZWxsLCBiZWNhdXNlIHdoYXQgaGFzIGhhcHBlbmVkIGlzIGEgaGVhcCBjb3Jy
dXB0aW9uLiBUaGUgc2VnIGZhdWx0IG9jY3VycyBkdXJpbmcgYSBtZW1vcnkgYWxsb2Mgc29tZXRp
bWUgbGF0ZXIuDQoNClRoZSBwaHlzaWNzIG9mIHRoZSBwcm9ibGVtLCBpcyBiZXN0IHNob3duIGJ5
IGxvY2FsIGNvbmZpZyBjbGllbnQgcmVxdWVzdGluZyBzZWdtZW50ZWQgY29tcG9zaXRpb24gZGF0
YSBmcm9tIGEgbG9jYWwgY29uZmlnIHNlcnZlci4gIFRoZSBvbmUgcmVxdWVzdCwgYWxsIHJlc3Bv
bnNlIHNlZ21lbnRzLCB0aGUgcmV0dXJuIHNlZyBBQ0tzIGFsbCBoYXBwZW4gb24gdGhlIHNhbWUg
QyBjYWxsaW5nIHN0YWNrIHdoaWNoIGdldHMgKnZlcnkqIGRlZXAsIGFuZCBzdGVwcyBvZmYgdGhl
IGVuZCwgc2luY2Ugbm90aGluZyBnb2VzIE9UQS4gSXQgZG9lcyAqbm90KiBoYXBwZW4gZHVyaW5n
IE9UQSBvcGVyYXRpb25zIGJlY2F1c2UgZWFjaCBkaXNjcmV0ZSBwYWNrZXQgc3RhcnRzIGZyb20g
YSBmcmVzaCBDIGNhbGxpbmcgc3RhY2sgZnJvbSBtYWluKCkuDQoNCk9mZmxvYWRpbmcgdGhlIFNl
bmQgUGFja2V0IFJlcXVlc3RzIHRvIGxfaWRsZV9vbmVzaG90IGVuc3VyZXMgdGhhdCBlYWNoIGRp
c2NyZXRlIGxvb3BiYWNrZWQgcGFja2V0IGFsc28gc3RhcnRzIGZyb20gYSBrbm93biBsb3cgcG9p
bnQgb24gdGhlIEMgY2FsbGluZyBzdGFjay4gDQoNCkRvZXMgdGhhdCBtYWtlIHNlbnNlPw==
