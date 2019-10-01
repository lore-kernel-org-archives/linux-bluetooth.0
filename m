Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D36ECE587
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9220659
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 15:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DK/eCkBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfJAPVS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:21:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:29654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfJAPVS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 11:21:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 08:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="197881326"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 08:21:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 1 Oct 2019 08:21:16 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Oct 2019 08:21:15 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Oct 2019 08:21:15 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 1 Oct 2019 08:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFWBn3+ttnluazwgebUKQyYnRjkqRv0pmXchj+C5t+OiBKaVXd/ggsgCcsmBjUbTstWCz4yvS2jbgSJj1V+sK17PC/c5lkOBucghnUUvUNyiOp4Mhh7Zq0G6mY/3gT+iAMQzyxYHxtgMEOxW3kkTNHHxxxCVjpmK0evvvRDdhnQP+wgZJt+Pt75T8hjcrRiCT50hdvVWvfzXbqVM1tF2Wf5iaxEh/DK/K/zpr8XBIhc+axYWw7zzokx2v+FLlfFEIv5NVm1NXiw+O6sGAKRk3SX97/JzibE+IzUYGz1My4Q0CGvs2ey8yrEwfHg3/SdBXwB23hsAe4Ft7DP011bCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LK4BI+DtvNZFAn7O0pGnz7ge+fPaMgXzO7R0FvcrkI=;
 b=iFBacg48YkcacwiEQhsSuxadUhoFkSQDufbdXK/S7V3qK7UB+QFUKL9LvvkOuLbxZH6/oZ15QScFFZ2VGwzvkQEYYnDZ/3+nO6QUcQuyaN6PjVkRgBSw7fDBRVBTwVD/A5sTL/aaxRi6ljlPijBp8dGIp07te6+Pn9uTrIa65AHsGA/A/Q2apDxJ+D6XLuQRJdh7Q2/cJhpx/VcT/kQiAfBhzlLTPQLOQtWdL1aUc4+NqPVI5TCIMo6a/SN7vDx0O3QnbvmiX9LttE4NaU7Uf+ov4qzIuBToNuCPyyTGIiy8i4nN22eEyHIG1RqffHjKvCs08HPM61JosOUiRqpKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LK4BI+DtvNZFAn7O0pGnz7ge+fPaMgXzO7R0FvcrkI=;
 b=DK/eCkBagWF9ytMQcF/UfvWiT876OSs0L3QfVBwFGMolaJdYhhZgloX1SYyl+qrMwEIn/ZB9idaiDnF52mVYxsEubTjs6c7N5lFbIL4vrIEwDwy+mkGqzxB4yEjOyIrFRucQcjynlpQfvWLGKb/6xf3uVN12dIADD4yKSLaZc74=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3676.namprd11.prod.outlook.com (20.178.231.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 15:21:14 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 15:21:14 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Thread-Topic: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Thread-Index: AQHVZ0RTr1AZqmUhcEiRZxtP9zPpaKdGCS+A
Date:   Tue, 1 Oct 2019 15:21:14 +0000
Message-ID: <547a20d9ff42c6b404bfc646812a243cc2469708.camel@intel.com>
References: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2644b6b8-5523-43b7-8539-08d74682ff99
x-ms-traffictypediagnostic: DM6PR11MB3676:
x-microsoft-antispam-prvs: <DM6PR11MB367654FAE775B29FC68BAAFDE19D0@DM6PR11MB3676.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(15650500001)(81166006)(11346002)(6246003)(110136005)(36756003)(7736002)(305945005)(6486002)(229853002)(316002)(2906002)(446003)(2616005)(6512007)(2501003)(66066001)(486006)(476003)(256004)(14444005)(71190400001)(99286004)(76116006)(66946007)(6436002)(91956017)(64756008)(66556008)(66446008)(81156014)(66476007)(76176011)(71200400001)(102836004)(5660300002)(25786009)(478600001)(26005)(6116002)(8936002)(3846002)(86362001)(118296001)(186003)(8676002)(14454004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3676;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFwAFhU8boewwHsADEnCnBOUsmYFZnnR3M0B0YdbWJAxnBhuFtyYRsMrMEEyvEyWXBKnaYN5bkvJ0NOweOghDeCfwiSmFOKXmIpCBGcfpx8FCG+52GD8Ne2+hHY7ZpCKGnceHB/yv7eTu7Xhg48tiIy78XtGb3n08I8lC8udZ/PC4uAjU6wnwTb/6Mhd8bs3793vMtUazLS+5QWS3LaWr92SIFi9RwMk9ewtIsmWu936zUoqnF072Np+YvE4dLCFKr3mInV4GhotfvxdaxQOtZoxd67k3DezoniohpaGr5jR4x8O1PXyYkrlRMv9b32BifvSJ3nIlTUCRoBazmqm2sbW2cPkMC8LZ68mqr/VvkPqfSu2KZqPj/yvbSqQCoNwM7mZDTe6gvwl1UMeoGs7cXVvnAKhabU+DzdibnIXcE0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF56E00074C2CF47952433F281D7D907@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2644b6b8-5523-43b7-8539-08d74682ff99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 15:21:14.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /P2GzN2g0WpyuaH8s+spKtjqxYIWbjvMpT60h9djrO+kl8kD7UWyGg7kbnoncWKw/sn0oJZeLm0nZdvBK3CTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3676
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gTW9uLCAyMDE5LTA5LTA5IGF0IDIxOjI1ICswMjAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBwYXRjaCBlbnN1cmVzIHRoYXQgU2VxdWVu
Y2UgTnVtYmVyIGlzIHJlc2V0IG9ubHkgd2hlbiBJViBJbmRleCB1c2VkDQo+IGZvciBvdXRnb2lu
ZyBtZXNzYWdlcyBpbmNyZWFzZXMuDQo+IA0KPiBUaGlzIGZpeGVzIGVycm9uZW91c2x5IGNsZWFy
ZWQgc2VxdWVuY2UgbnVtYmVyIHdoZW4gbm9kZSBwZXJmb3JtcyBJVg0KPiBSZWNvdmVyeSBwcm9j
ZWR1cmUgb24gc3RhcnR1cCBpbiBhIGZvbGxvd2luZyBzY2VuYXJpbzoNCj4gIC0gbm9kZSBoYXMg
SVYgSW5kZXggc2V0IHRvIDxOPg0KPiAgLSBub2RlIHN0YXJ0cyBpbiBJVl9VUERfSU5JVCBzdGF0
ZQ0KPiAgLSBub2RlIHJlY2VpdmVzIGEgU2VjdXJlIE5ldHdvcmsgQmVhY29uIHdpdGggSVYgSW5k
ZXggPE4+KzEgYW5kIElWDQo+ICAgIFVwZGF0ZSBmbGFnIHNldA0KPiANCj4gVXBvbiByZWNlcHRp
b24sIHRoZSBub2RlIHNoYWxsOg0KPiAgLSBpbmNyZWFzZSBpdHMgSVYgSW5kZXggdG8gPE4+KzEN
Cj4gIC0gZW50ZXIgSVZfVVBEX1VQREFUSU5HIHN0YXRlDQo+IA0KPiBUaGlzIG1lYW5zIHRoYXQg
dGhlIG5vZGUga2VlcHMgdHJhbnNtaXR0aW5nIG1lc3NhZ2VzIHVzaW5nIElWIEluZGV4DQo+IGVx
dWFsIHRvIDxOPiwgdGhlcmVmb3JlIGl0IHNoYWxsICpub3QqIHJlc2V0IGl0cyBTZXF1ZW5jZSBO
dW1iZXIgYmVmb3JlIElWDQo+IFVwZGF0ZSBwcm9jZWR1cmUgY29tcGxldGVzLg0KPiANCj4gSWYs
IG9uIHRoZSBvdGhlciBoYW5kLCBTTkIgY29udGFpbnMgZWl0aGVyOg0KPiAgLSBJViBJbmRleCA8
Tj4rMiAocmVnYXJkbGVzcyBvZiBJViBVcGRhdGUgZmxhZykNCj4gIC0gSVYgSW5kZXggPE4+KzEg
YW5kIElWIFVwZGF0ZSBmbGFnICpub3QqIHNldA0KPiB0aGUgbm9kZSBzaGFsbCByZXNldCB0aGUg
U2VxdWVuY2UgTnVtYmVyIHJpZ2h0IGF3YXkuDQo+IC0tLQ0KPiAgbWVzaC9uZXQuYyB8IDggKysr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMNCj4gaW5kZXggN2M0
MDQ5ZTBlLi5iYTdiYjMyZmQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMNCj4gKysrIGIvbWVz
aC9uZXQuYw0KPiBAQCAtMjczNSw4ICsyNzM1LDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2l2X2ty
X3N0YXRlKHN0cnVjdCBtZXNoX3N1Ym5ldCAqc3VibmV0LCB1aW50MzJfdCBpdl9pbmRleCwNCj4g
IAl9DQo+ICANCj4gIAlpZiAobmV0LT5pdl91cGRfc3RhdGUgPT0gSVZfVVBEX0lOSVQpIHsNCj4g
LQkJaWYgKGl2X2luZGV4ID4gbmV0LT5pdl9pbmRleCkNCj4gLQkJCW1lc2hfbmV0X3NldF9zZXFf
bnVtKG5ldCwgMCk7DQo+ICAJCW5ldC0+aXZfaW5kZXggPSBpdl9pbmRleDsNCj4gIA0KPiAgCQlp
ZiAoaXZfdXBkYXRlKSB7DQo+IEBAIC0yNzU3LDYgKzI3NTUsMTIgQEAgc3RhdGljIHZvaWQgdXBk
YXRlX2l2X2tyX3N0YXRlKHN0cnVjdCBtZXNoX3N1Ym5ldCAqc3VibmV0LCB1aW50MzJfdCBpdl9p
bmRleCwNCj4gIAkJbWVzaF9jb25maWdfd3JpdGVfaXZfaW5kZXgobm9kZV9jb25maWdfZ2V0KG5l
dC0+bm9kZSksIGl2X2luZGV4LA0KPiAgCQkJCQkJCW5ldC0+aXZfdXBkX3N0YXRlKTsNCj4gIA0K
PiArCQkvKiBSZXNldCBzZXEgbnVtIGlmIGl2IGluZGV4IHVzZWQgZm9yICpvdXRnb2luZyogbWVz
c2FnZXMgaGFzDQo+ICsJCSAqIGp1c3QgYmVlbiBpbmNyZWFzZWQNCj4gKwkJICovDQo+ICsJCWlm
IChtZXNoX25ldF9nZXRfaXZfaW5kZXgobmV0KSA+IGxvY2FsX2l2X2luZGV4KQ0KPiArCQkJbWVz
aF9uZXRfc2V0X3NlcV9udW0obmV0LCAwKTsNCj4gKw0KDQpJIHRoaW5rIHRoZXJlIG1heSBiZSBh
IG1vcmUgc3VidGxlIHByb2JsZW0gYXQgd29yayBoZXJlLi4uICBBcmUgd2UgbG9zaW5nDQp0aGUg
bG9jYWwgc3RhdGUgb2YgSVZVIHdoZW4gd2UgcG93ZXIgb2ZmL3JlYm9vdD8NCg0KSSB0aGluayB0
aGlzIHdpbGwgZmFpbCB0byBzZXQgdGhlIFNlcXVlbmNlIHRvIFplcm8gaW4gdGhlIGZvbGxvd2lu
ZyBjYXNlOg0KDQoxLiBOb2RlIGlzIG9wZXJhdGluZyBpbiB0aGUgZm9sbG93aW5nIHN0YXRlOg0K
ICAgSVZfSW5kZXggPSA1LCAgSVZVID0gMTsgICAoT3V0Z29pbmcgbWVzc2FnZXMgc2VudCB3aXRo
IElWX0luZGV4ID09IDQpDQoNCjIuIE5vZGUgcG93ZXJzIG9mZi4NCg0KMy4gTm9kZSBwb3dlciBv
biAtLT4gIEhlcmUgaXMgdGhlIHByb2JsZW0NCiAgIEludGVybmFsIElWX0luZGV4IHN0aWxsID0g
NSwgDQogICBJVlUgKnNob3VsZCogc3RpbGwgPSAxLCBidXQgaXQgbWF5IGhhdmUgZ290dGVuIGxv
c3QgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgd2Ugc3RhcnQgdXAgaW4gSVZfVVBE
X0lOSVQgDQogICBPdXRnb2luZyBtZXNzYWdlcyAqU2hvdWxkKiBzdGlsbCBzZW50IHdpdGggSVZf
SW5kZXggPT0gNCwNCiAgIGJ1dCBtYXkgYWxyZWFkeSBzdGFydCBzZW5kaW5nIHdpdGggSVZfSW5k
ZXggPT0gNSBpZiBJVl9VUERfSU5JVA0KICAgDQoNCjQuIFNOQiByZWNlaXZlZCB3aXRoIElWX0lu
ZGV4ID0gNSwgSVZVID0gMA0KICAgT3V0Z29pbmcgbWVzc2FnZXMgbm93IHNlbnQgd2l0aCBJVl9J
bmRleCA9IDUsIGJ1dCBTZXEgIyBuZXZlciBzZXQgdG8gWmVyby4NCg0KDQpJIGxpa2UgdGhlIGlk
ZWEgb2YgdXNpbmcgdGhlIGNoYW5nZSBpbiB2YWx1ZSBvZiB0aGUgcmVzdWx0IA0Kb2YgbWVzaF9u
ZXRfZ2V0X2l2X2luZGV4KG5ldCksIGJ1dCBJIGFtIG5vIGxvbmdlciBjZXJ0YWluIGlmDQppdCBp
cyBjb3JyZWN0IGlmIHdlIHBvd2VyZWQgZG93biBpbiB0aGUgSVZfVVBEX1VQREFUSU5HDQpzdGF0
ZS4gIFRoaXMgaXMgYSByZWFsIHByb2JsZW0gaWYgd2Ugc2VuZCBhbnkgbWVzc2FnZXMgYmVmb3Jl
DQp3ZSBnZXQgYSBTTkIuDQoNCldpdGggdGhpcyBjdXJyZW50IHBhdGNoLCB0aGUgZGFuZ2VyIG1h
eSBiZSBsb3cuLi4gIFRoZSBTZXEgd291bGQgbm90IGJlDQpyZXNldCB0byBaZXJvIGlmIHdlIHBv
d2VyZWQgb2ZmIGR1cmluZyBJViBVcGRhdGUgcHJvY2VkdXJlLCBhbmQgcG93ZXJlZA0Kb24gYWZ0
ZXIgaXQgd2FzIG92ZXIsIGJ1dCBpdCB3b3VsZCBoYXZlIGZld2VyIFNlcXVlbmNlIHZhbHVlcyB0
byB1c2Ugb24NCnRoZSBuZXcgSVZfSW5kZXgsIGFuZCBpdCBjb3VsZCBhY2N1bXVsYXRlIG92ZXIg
dGltZSB1bmxlc3MgaXQgaXMgcHJlc2VudA0KYW5kIHBvd2VyZWQgdXAgZm9yIGEgbm9ybWFsLCBj
b21wbGV0ZSBwcm9jZWR1cmUuDQoNClRoZSBwcm9ibGVtLCBJIHRoaW5rLCBpcyB1c2luZyB0aGUg
aXZfdXBkX3N0YXRlICh3aGljaCB3ZSBuZWVkIHRvIGRvIA0KSVYgSW5kZXggcmVjb3ZlcnkpIGFz
IGEgcHJveHkgZm9yIHRoZSBhY3R1YWwgc3RhdGUgb2YgdGhlIElWVSBiaXQuDQoNCg0KDQo+ICAJ
CS8qIEZpZ3VyZSBvdXQgdGhlIGtleSByZWZyZXNoIHBoYXNlICovDQo+ICAJCWlmIChrcl90cmFu
c2l0aW9uKSB7DQo+ICAJCQlsX2RlYnVnKCJCZWFjb24gYmFzZWQgS1IgcGhhc2UgY2hhbmdlIik7
DQo=
