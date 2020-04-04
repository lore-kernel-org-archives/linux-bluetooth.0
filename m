Return-Path: <SRS0=Oq99=5U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0EC43331
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B022072B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bF9h/Neu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDDAcP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:32:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:27814 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgDDAcP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 20:32:15 -0400
IronPort-SDR: eAyNU51p0BSzURPvi7UpK4cmh2bbAslc7kV6yT5aHgIptZjCDOUKfe6Gc0QulEjrkSYIiASUGo
 k2Fg0wHs4djg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 17:32:11 -0700
IronPort-SDR: yFuJSeo5VBz3kT6zWjQK9t/IxLsWU/UOR1r6FvV0PDDvWtkyTpyatYZxF8mGkCEANVWq387JJg
 djlokDaFIMJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,341,1580803200"; 
   d="scan'208";a="423708480"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2020 17:32:10 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 17:32:10 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 17:32:09 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 3 Apr 2020 17:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=namSI7G67TJJs1qbUZZhBiNz4Yebh9D60bMm8QRD9byhcvSHFEi9+5xr3B+MRfxHEWyVE/vkHM8n1SxRpxnpjRK0MbF5eXSo7alC2bJ0tr9GV1nBh6OGJqv9Qet7xsq5uIaqiy1MrEBFfn2/EtNWoJ3zIs1ii6Cx0D393MOxBwULKrg2aGpwmG+4gXLOnZxxeUdZXtO84H9qMREUqhaIqDgGgtqzeZp/buKKdXoykRx3Z4KZDvM6JacLCspHo8yWh1dTO7oZWhmTKmGHYKlTKPMCKqeC9Jo6TQlavNMFuzhIHWtS+3+epd3R4LUeFurNzHTqMcAjnNEnrdEMbtwn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLt75aAlD3z+XbWh98j1MChkZI/eRZ7dZMyFzwEY/HU=;
 b=oAHRFyXCpmLFDvlSzvo4SkLWkvGbHFUgQmRfYBgXNGO+u4LAXwPzME/+m2/davmDSdvgCPbJ98pn3Q81EV7Szjrj0eYhppPI+GNIxk9KkTNhmrM0U4UmzJdviLDLBiUUigqmvryI68ASLm6HGePxLen4HpLQkSe52WxdSa2JZSpVSrGU6qveW5/uMMcEqSfkm2Bz0tcxU7bIgQ5xoNxdQb5ZVKUrDDOOPYMzxp2ZMvAR7L5EYWb1PSBoBC9IRWyn2WXVOrkGFhj2JYAEiFK78805+OoMlaZg4jkQHPqI/0bLb1s68oIYN1lsngUrnjkunPK259fZCJVJ4drk3g9Iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLt75aAlD3z+XbWh98j1MChkZI/eRZ7dZMyFzwEY/HU=;
 b=bF9h/NeuIYHdYpKhHz7vbDbNJXe5VkqTLvDuJmENiD82ui8X+3VFAy9B0wUDYr04dALuMHG834G0LNvY74eU8PG+66zlDAkMWEn/EF5N3pRKgs2xK1ghw15yVZw7+J9wcCI3YHYaFOO2984OxPpIV6p8w108SqEEL/RYbVnzjYk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Sat, 4 Apr
 2020 00:32:08 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2878.018; Sat, 4 Apr 2020
 00:32:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "sbrown@ewol.com" <sbrown@ewol.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: test/test-mesh fails to provision node
Thread-Topic: mesh: test/test-mesh fails to provision node
Thread-Index: AQHWCg3Uj54mfL8s8EW4CzdLZIhhpKhoC6aAgAARLgA=
Date:   Sat, 4 Apr 2020 00:32:07 +0000
Message-ID: <5e26f2eaf94e29e5db4134f7d29ad0f7ba141760.camel@intel.com>
References: <65249ba1d4762186088e6b4496508510e0a06d93.camel@ewol.com>
         <3517aec466a909c09415f60f17debf61b67c78d3.camel@intel.com>
In-Reply-To: <3517aec466a909c09415f60f17debf61b67c78d3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59d7657a-afac-4265-f526-08d7d82f9bba
x-ms-traffictypediagnostic: MW3PR11MB4540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4540AE59A9374D196890B651E1C40@MW3PR11MB4540.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03630A6A4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(478600001)(71200400001)(36756003)(76116006)(81166006)(110136005)(66556008)(66476007)(8676002)(6512007)(6486002)(8936002)(64756008)(86362001)(316002)(66446008)(19627235002)(2906002)(6506007)(4326008)(54906003)(5660300002)(2616005)(26005)(186003)(81156014)(107886003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdPwC/H2vXVUx+7A0pGX4WKAqD+08GLfz8VmON9xLgAF9e+w6woQGvuyfEU8fPoxnniRbYgmFKnZwQ2n+QtsAs+i1Llnoyb4BsZru0MTEef8gzPT2rjC2YNqTq6EXyBquQ1CQpjkTyNmqBG3sju94hi4gHy9a3Y6Ul/G3g5OFuZcMCMv4PZSO/lehZcJa+p2Fue26Eiqnmu1M+/MUOaMM0Ld4I3J3sOKgwZn/ahpekw4hgE5wBwrLdIghSvTL4XdZvuJhFOF3UM00qCO1IuqS5z5/rSQuMgCizTqtlwNeMxuKwqkd64vd8bSEs90xLxPjaJnnRhK/3zGHFrfsFJ9/Z+RvMkMCu/aAMGCPh5J7lemnyfn0aHt1yCaGDic8ToLmxG0pUeU1YIxFO4LLZc3xmvuF1scUms+MwM7DfyI5VGehKmvohX/COTURBhLTvNX
x-ms-exchange-antispam-messagedata: +Kr2o67KzQ9dXTxGo6nPboFBGodLWuZ7kAsRRu0BEmVpvLazgKkbTqdU43La1mJnAW8KtbQ4ztHh75+FXwbdw4dah4BVTqKTZPX34h9INVYXkrfvfk65vbkCymSXOQlyreaW4u0QYuYK4Ev5Kk6oYg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <20537C21E19AF2458C38221A96216D47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d7657a-afac-4265-f526-08d7d82f9bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2020 00:32:07.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlgR0gIx07LiCrJJH7mTwD82BLUtxFt9mo31xDECq8GDS0hVu63GpsorAcmr6qCsrhlXB74to1dVvqMqQWkI4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTAzIGF0IDIzOjMwICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiBU
aGFua3MgU3RldmUsDQo+IA0KPiBPbiBGcmksIDIwMjAtMDQtMDMgYXQgMTk6MDUgLTA0MDAsIFN0
ZXZlIEJyb3duIHdyb3RlOg0KPiA+IHRlc3QvdGVzdC1tZXNoIGNhbiBubyBsb25nZXIgcHJvdmlz
aW9uIGEgbm9kZS4NCj4gPiANCj4gPiBtZXNoLWNmZ2NsaWVudCBjb3JyZWN0bHkgcHJvdmlzaW9u
cyB0aGUgc2FtZSBub2RlLg0KPiA+IA0KPiA+IEluIHBva2luZyBhcm91bmQgd2l0aCBkLWZlZXQs
IHRoZSBpbnRlcmZhY2UNCj4gPiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzIGlzbid0
IGNyZWF0ZWQgYnkgdGVzdC90ZXN0LW1lc2gsIGJ1dCBpcw0KPiA+IGJ5IG1lc2gtY2ZnY2xpZW50
Lg0KPiA+IA0KPiANCj4gWWVhaCwgd2Ugbm93IHJlcXVpcmUgYW55b25lIGRvaW5nIEFkZE5vZGUo
KSB0byBwcm92aWRlIFByb3Zpc2lvbmluZyBJbml0aWF0b3IgYWdlbnQNCj4gIkNhcGFiaWxpdGll
cyIgUHJvcGVydHkuIEkgbmVlZCB0byBlbmxpc3Qgc29tZW9uZSBhIGJpdCBtb3JlIFB5dGhvbiBh
ZGVwdCB0byBhZGQNCj4gdGhhdCBwcm9wZXJ0eSB0byB0aGUgdGVzdC1tZXNoIG9yZy5ibHVlei5t
ZXNoLlByb3Zpc2lvbkFnZW50MSBpbnRlcmZhY2UuDQoNCnRlc3QtbWVzaCB3YXMgbmV2ZXIgaW50
ZW5kZWQgdG8gYmUgbW9yZSB0aGFuIGEgc2ltcGxlIGV4YW1wbGUgZGVtb25zdHJhdGluZyBkYnVz
IEFQSSB1c2FnZSBvZiB0aGUgZGFlbW9uIHdpdGgNClB5dGhvbi4gSXQgd2FzIG91ciBmaXJzdCBk
YWVtb24gIkNsaWVudCBBcHAiLCBtb3N0IG9mIHdob3NlIHVzZWZ1bG5lc3MgaXMgc3VwZXJjZWRl
ZCBieSB0b29scy9tZXNoLWNmZ2NsaWVudC4NCg0KSXQgaXMgc3RpbGwgdXNlZnVsIGFzIGEgIlNp
bXBsZSBOb2RlIiBhcHAgdGhhdCBpbXBsZW1lbnRzIE9uL09mZiBDbGllbnQgYW5kIHNlcnZlciwg
YnV0IGl0IGhhcyBuZXZlciBoYWQgdGhlDQphYmlsaXR5IHRvIGJlIGEgZnVsbCBmbGVkZ2VkIENv
bmZpZ3VyYXRpb24gQ2xpZW50LCB3aXRob3V0IHdoaWNoIFByb3Zpc2lvbiBJbml0aWF0b3Igcm9s
ZSBkb2Vzbid0IG1ha2UgYW55DQpzZW5zZS4NCg0KU28gd2UgYXJlIGluY2xpbmVkIHRvIHJlbW92
ZSB0aGUgImFkZCIgYW5kICJjcmVhdGUiIGNvbW1hbmRzIGFsdG9nZXRoZXIsIHdoaWxlIHBvaW50
aW5nIHBlb3BsZSB0byBtZXNoLQ0KY2ZnY2xpZW50IGZvciB0aGF0IGZ1bmN0aW9uYWxpdHkuDQoN
CkJlY2F1c2UgZXZlbiB3aGVuICJhZGQiIGFuZCAiY3JlYXRlIiAqZGlkKiB3b3JrLCB0aGV5IG9u
bHkgKnNvcnRhKiB3b3JrZWQuLi4uIGFuZCBsZWZ0IGJlaGluZCB1bnVzYWJsZQ0KdW5jb25maWd1
cmVkIG5vZGVzLg0KDQoNCj4gDQo+IA0KPiA+IFN0ZXZlDQo+ID4gDQo+ID4gPT09PT09PT09PT09
PT09PQ0KPiA+IA0KPiA+IHRlc3QvdGVzdC1tZXNoIGZhaWxzIHdpdGg6DQo+ID4gDQo+ID4gY3Jl
YXRlDQo+ID4gQ3JlYXRpbmcgd2l0aCBVVUlEIDBlMDQwNTBhMGIwOTBkMGMwMTA4MDYwZjBhMDIw
MzA3DQo+ID4gQ3JlYXRlZCBtZXNoIG5ldHdvcmsgd2l0aCB0b2tlbiBiYjBmMThmODkwMWYzNTg3
DQo+ID4gQXR0YWNoIG1lc2ggbm9kZSB0byBibHVldG9vdGgtbWVzaGQgZGFlbW9uDQo+ID4gTWVz
aCBhcHAgcmVnaXN0ZXJlZDogL29yZy9ibHVlei9tZXNoL25vZGUwZTA0MDUwYTBiMDkwZDBjMDEw
ODA2MGYwYTAyMDMwNw0KPiA+IHNjYW4NCj4gPiBTY2FubmluZy4uLg0KPiA+IFNjYW4gcHJvY2Vk
dXJlIHN0YXJ0ZWQNCj4gPiBTY2FuUmVzdWx0ID4+IFJTU0k6IC0zNCBVVUlEOiBhY2RhNDUxZmVj
YTM5MDNlNDU2MGY2YTNhMjVhNDM3YSBPT0IgRGF0YTogMDAwMA0KPiA+IHV1aWQNCj4gPiBFbnRl
ciAzMi1kaWdpdCBoZXggcmVtb3RlIFVVSUQ6DQo+ID4gYWNkYTQ1MWZlY2EzOTAzZTQ1NjBmNmEz
YTI1YTQzN2ENCj4gPiBhZGQNCj4gPiBBZGRpbmcgZGV2IFVVSUQgYWNkYTQ1MWZlY2EzOTAzZTQ1
NjBmNmEzYTI1YTQzN2ENCj4gPiBBZGROb2RlIHByb2NlZHVyZSBmYWlsZWQgIG9yZy5ibHVlei5t
ZXNoLkVycm9yLkZhaWxlZDogRmFpbGVkIHRvIHN0YXJ0IHByb3Zpc2lvbmluZyBpbml0aWF0b3IN
Cj4gPiANCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gDQo+
ID4gc3lzbG9nOg0KPiA+IA0KPiA+IEFwciAgMyAxODo0MToxMCBtZXNoMCBibHVldG9vdGgtbWVz
aGRbNjY0OF06IG1lc2gvbWFuYWdlci5jOmFkZF9ub2RlX2NhbGwoKSBBZGROb2RlIHJlcXVlc3QN
Cj4gPiBBcHIgIDMgMTg6NDE6MTAgbWVzaDAgYmx1ZXRvb3RoLW1lc2hkWzY2NDhdOiBtZXNoL21h
bmFnZXIuYzpzY2FuX2NhbmNlbCgpIHNjYW5fY2FuY2VsDQo+ID4gQXByICAzIDE4OjQxOjEwIG1l
c2gwIGJsdWV0b290aC1tZXNoZFs2NjQ4XTogQWdlbnQgZmFpbGVkIChvcmcuZnJlZWRlc2t0b3Au
REJ1cy5FcnJvci5Vbmtub3duTWV0aG9kKSwNCj4gPiBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6DQo+ID4gQXByICAzIDE4OjQxOjEwIG1lc2gwIGJsdWV0b290aC1tZXNoZFs2NjQ4
XTogICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvZGJ1cy9zZXJ2aWNlLnB5
IiwgbGluZQ0KPiA+IDY1OCwgaW4gX21lc3NhZ2VfY2INCj4gPiBBcHIgIDMgMTg6NDE6MTAgbWVz
aDAgYmx1ZXRvb3RoLW1lc2hkWzY2NDhdOiAgICAgKGNhbmRpZGF0ZV9tZXRob2QsIHBhcmVudF9t
ZXRob2QpID0gX21ldGhvZF9sb29rdXAoc2VsZiwNCj4gPiBtZXRob2RfbmFtZSwgaW50ZXJmYWNl
X25hbWUpDQo+ID4gQXByICAzIDE4OjQxOjEwIG1lc2gwIGJsdWV0b290aC1tZXNoZFs2NjQ4XTog
ICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvZGJ1cy9zZXJ2aWNlLnB5Iiwg
bGluZQ0KPiA+IDI0OCwgaW4gX21ldGhvZF9sb29rdXANCj4gPiBBcHIgIDMgMTg6NDE6MTAgbWVz
aDAgYmx1ZXRvb3RoLW1lc2hkWzY2NDhdOiAgICAgcmFpc2UgVW5rbm93bk1ldGhvZEV4Y2VwdGlv
bignJXMgaXMgbm90IGEgdmFsaWQgbWV0aG9kIG9mDQo+ID4gaW50ZXJmYWNlICVzJyAlIChtZXRo
b2RfbmFtZSwgZGJ1c19pbnRlcmZhY2UpKQ0KPiA+IEFwciAgMyAxODo0MToxMCBtZXNoMCBibHVl
dG9vdGgtbWVzaGRbNjY0OF06IGRidXMuZXhjZXB0aW9ucy5Vbmtub3duTWV0aG9kRXhjZXB0aW9u
Og0KPiA+IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlVua25vd25NZXRob2Q6IFVua25vd24g
bWV0aG9kOiBHZXRBbGwgaXMgbm90IGEgdmFsaWQgbWV0aG9kIG9mIGludGVyZmFjZSBvcmcuDQo+
ID4gDQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
ID4gDQo+ID4gZGJ1cy1tb25pdG9yIGxvZzoNCj4gPiANCj4gPiBtZXRob2QgY2FsbCB0aW1lPTE1
ODU5MTgwMDQuMTAyMzg4IHNlbmRlcj06MS40MDkgLT4gZGVzdGluYXRpb249OjEuMzAxIHNlcmlh
bD0xNA0KPiA+IHBhdGg9L29yZy9ibHVlei9tZXNoL25vZGUwYTA2MGQwODAyMGYwMzA1MGIwOTBj
MGEwNzAxMGUwNDsgaW50ZXJmYWNlPW9yZy5ibHVlei5tZXNoLk1hbmFnZW1lbnQxOw0KPiA+IG1l
bWJlcj1BZGROb2RlDQo+ID4gICAgYXJyYXkgb2YgYnl0ZXMgWw0KPiA+ICAgICAgIGFjIGRhIDQ1
IDFmIGVjIGEzIDkwIDNlIDQ1IDYwIGY2IGEzIGEyIDVhIDQzIDdhDQo+ID4gICAgXQ0KPiA+ICAg
IGFycmF5IFsNCj4gPiAgICBdDQo+ID4gbWV0aG9kIGNhbGwgdGltZT0xNTg1OTE4MDA0LjEwNDcy
NiBzZW5kZXI9OjEuMzAxIC0+IGRlc3RpbmF0aW9uPToxLjQwOSBzZXJpYWw9MzA3IHBhdGg9L21l
c2gvdGVzdC9hZ2VudDsNCj4gPiBpbnRlcmZhY2U9b3JnLmZyZWVkZXNrdG9wLkRCdXMuUHJvcGVy
dGllczsgbWVtYmVyPUdldEFsbA0KPiA+ICAgIHN0cmluZyAib3JnLmJsdWV6Lm1lc2guUHJvdmlz
aW9uQWdlbnQxIg0KPiA+IGVycm9yIHRpbWU9MTU4NTkxODAwNC4xMTAzNTMgc2VuZGVyPToxLjQw
OSAtPiBkZXN0aW5hdGlvbj06MS4zMDENCj4gPiBlcnJvcl9uYW1lPW9yZy5mcmVlZGVza3RvcC5E
QnVzLkVycm9yLlVua25vd25NZXRob2QgcmVwbHlfc2VyaWFsPTMwNw0KPiA+ICAgIHN0cmluZyAi
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiA+ICAgRmlsZSAiL3Vzci9saWIv
cHl0aG9uMy9kaXN0LXBhY2thZ2VzL2RidXMvc2VydmljZS5weSIsIGxpbmUgNjU4LCBpbiBfbWVz
c2FnZV9jYg0KPiA+ICAgICAoY2FuZGlkYXRlX21ldGhvZCwgcGFyZW50X21ldGhvZCkgPSBfbWV0
aG9kX2xvb2t1cChzZWxmLCBtZXRob2RfbmFtZSwgaW50ZXJmYWNlX25hbWUpDQo+ID4gICBGaWxl
ICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvZGJ1cy9zZXJ2aWNlLnB5IiwgbGluZSAy
NDgsIGluIF9tZXRob2RfbG9va3VwDQo+ID4gICAgIHJhaXNlIFVua25vd25NZXRob2RFeGNlcHRp
b24oJyVzIGlzIG5vdCBhIHZhbGlkIG1ldGhvZCBvZiBpbnRlcmZhY2UgJXMnICUgKG1ldGhvZF9u
YW1lLA0KPiA+IGRidXNfaW50ZXJmYWNlKSkNCj4gPiBkYnVzLmV4Y2VwdGlvbnMuVW5rbm93bk1l
dGhvZEV4Y2VwdGlvbjogb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuVW5rbm93bk1ldGhvZDog
VW5rbm93biBtZXRob2Q6IEdldEFsbCBpcw0KPiA+IG5vdCBhIHZhbGlkIG1ldGhvZCBvZiBpbnRl
cmZhY2Ugb3JnLmZyZWVkZXNrdG9wLkRCdXMuUHJvcGVydGllcw0KPiA+ICINCj4gPiBlcnJvciB0
aW1lPTE1ODU5MTgwMDQuMTEyMDExIHNlbmRlcj06MS4zMDEgLT4gZGVzdGluYXRpb249OjEuNDA5
IGVycm9yX25hbWU9b3JnLmJsdWV6Lm1lc2guRXJyb3IuRmFpbGVkDQo+ID4gcmVwbHlfc2VyaWFs
PTE0DQo+ID4gICAgc3RyaW5nICJGYWlsZWQgdG8gc3RhcnQgcHJvdmlzaW9uaW5nIGluaXRpYXRv
ciINCj4gPiANCj4gPiANCj4gPiBzaWduYWwgdGltZT0xNTg1OTE4NDQxLjMwNTg2MyBzZW5kZXI9
OjEuMiAtPiBkZXN0aW5hdGlvbj0obnVsbCBkZXN0aW5hdGlvbikgc2VyaWFsPTE3Ng0KPiA+IHBh
dGg9L29yZy9mcmVlZGVza3RvcC90aW1lc3luYzE7IGludGVyZmFjZT1vcmcuZnJlZWRlc2t0b3Au
REJ1cy5Qcm9wZXJ0aWVzOyBtZW1iZXI9UHJvcGVydGllc0NoYW5nZWQNCj4gPiAgICBzdHJpbmcg
Im9yZy5mcmVlZGVza3RvcC50aW1lc3luYzEuTWFuYWdlciINCj4gPiAgICBhcnJheSBbDQo+ID4g
ICAgICAgZGljdCBlbnRyeSgNCj4gPiANCj4gPiANCg==
