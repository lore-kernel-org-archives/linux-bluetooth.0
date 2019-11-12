Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1170C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B040E21872
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfKLGoO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:44:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:3500 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfKLGoO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 01:44:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 22:44:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="229240459"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2019 22:44:12 -0800
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 22:44:12 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.179]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.174]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 22:44:11 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "Gix, Brian" <brian.gix@intel.com>,
        "sbrown@ewol.com" <sbrown@ewol.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BlueZ/mesh: RX not working after daemon restart (with
 workaround)
Thread-Topic: BlueZ/mesh: RX not working after daemon restart (with
 workaround)
Thread-Index: AQHVmAKvMshUDcfhnEOohmOeni0E2aeFaaGAgAALO4CAAippgA==
Date:   Tue, 12 Nov 2019 06:44:12 +0000
Message-ID: <d5da92093a6ff6b7532cc688179b8edb66f2f266.camel@intel.com>
References: <20191110200848.GA28864@aurel32.net>
         <a843f597a101bf6e74521d033b7af3ff19455adc.camel@ewol.com>
         <20191110213953.GX30475@aurel32.net>
In-Reply-To: <20191110213953.GX30475@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.99.162]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B02E72423681B4299000B1AB0DC4628@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQXVyZWxpZW4sDQoNCk9uIFN1biwgMjAxOS0xMS0xMCBhdCAyMjozOSArMDEwMCwgQXVyZWxp
ZW4gSmFybm8gd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gMjAxOS0xMS0xMCAxMzo1OSwgU3RldmUg
QnJvd24gd3JvdGU6DQo+ID4gT24gU3VuLCAyMDE5LTExLTEwIGF0IDIxOjA4ICswMTAwLCBBdXJl
bGllbiBKYXJubyB3cm90ZToNCj4gPiA+IEhpIGFsbCwNCj4gPiA+IA0KPiA+ID4gT24gbXkgc3lz
dGVtIChSYXNwYmVycnkgUEkgMyksIHRoZSBSWCBwYXRoIGRvZXNuJ3Qgd29yayBhbnltb3JlDQo+
ID4gPiBmb2xsb3dpbmcgYSByZXN0YXJ0IG9mIHRoZSBibHVldG9vdGgtbWVzaGQgZGFlbW9uLiBJ
IGhhdmUgdHJhY2tlZA0KPiA+ID4gZG93bg0KPiA+ID4gdGhhdCB0byB0aGUgZmFjdCB0aGF0IHRo
ZSByZWNlaXZlIGNhbGxiYWNrcyBhcmUgc2V0dXAgYmVmb3JlIHRoZSBIQ0kNCj4gPiA+IGlzDQo+
ID4gPiBmdWxseSBpbml0aWFsaXplZC4gU2FpZCBvdGhlcndpc2UsIEJUX0hDSV9DTURfTEVfU0VU
X1NDQU5fUEFSQU1FVEVSUw0KPiA+ID4gaXMNCj4gPiA+IGNhbGxlZCBiZWZvcmUgQlRfSENJX0NN
RF9SRVNFVCBhbmQgdGhlIGNhbGxiYWNrIGNhbGxpbmcNCj4gPiA+IEJUX0hDSV9DTURfTEVfU0VU
X1NDQU5fRU5BQkxFIGlzIG5vdCBjYWxsZWQuIFRoaXMgdGltaW5nIGRlcGVuZGVudA0KPiA+ID4g
YW5kDQo+ID4gPiBwcm9iYWJseSBub3QgcmVwcm9kdWNpYmxlIG9uIGFsbCBoYXJkd2FyZS4NCj4g
PiA+IA0KPiA+ID4gSSBoYXZlIHdvcmthcm91bmRlZCB0aGUgaXNzdWUgYnkgYWRkaW5nIGEgc21h
bGwgZGVsYXkgYmV0d2VlbiB0aGUgSENJDQo+ID4gPiBpbml0aWFsaXphdGlvbiBhbmQgdGhlIGNh
bGwgdG8gbm9kZV9hdHRhY2hfaW9fYWxsKCk6DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9t
ZXNoL21lc2guYyBiL21lc2gvbWVzaC5jDQo+ID4gPiBpbmRleCA5YjJiMjA3M2IuLjFjMDYwNjBm
OSAxMDA2NDQNCj4gPiA+IC0tLSBhL21lc2gvbWVzaC5jDQo+ID4gPiArKysgYi9tZXNoL21lc2gu
Yw0KPiA+ID4gQEAgLTE2Nyw2ICsxNjcsMTAgQEAgYm9vbCBtZXNoX2luaXQoY29uc3QgY2hhciAq
Y29uZmlnX2RpciwgZW51bQ0KPiA+ID4gbWVzaF9pb190eXBlIHR5cGUsIHZvaWQgKm9wdHMpDQo+
ID4gPiAgCW1lc2hfaW9fZ2V0X2NhcHMobWVzaC5pbywgJmNhcHMpOw0KPiA+ID4gIAltZXNoLm1h
eF9maWx0ZXJzID0gY2Fwcy5tYXhfbnVtX2ZpbHRlcnM7DQo+ID4gPiAgDQo+ID4gPiArCWZvciAo
aW50IGkgPSAwIDsgaSA8IDEwMCA7IGkrKykgew0KPiA+ID4gKwkJbF9tYWluX2l0ZXJhdGUoMTAp
Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiAgCW5vZGVfYXR0YWNoX2lvX2FsbChtZXNoLmlv
KTsNCj4gPiA+ICANCj4gPiA+ICAJcmV0dXJuIHRydWU7DQo+ID4gPiANCj4gPiA+IEkgZ3Vlc3Mg
dGhlcmUgaXMgYSBiZXR0ZXIgd2F5IHRvIGRvIHRoYXQgYnkgd2FpdGluZyBmb3IgdGhlIEhDSSB0
byBiZQ0KPiA+ID4gZnVsbHkgaW5pdGlhbGl6ZWQgYmVmb3JlIGNhbGxpbmcgbm9kZV9hdHRhY2hf
aW9fYWxsKCkgb3IgYnkgdXNpbmcgYQ0KPiA+ID4gY2FsbGJhY2sgaW5zdGVhZC4gSG93ZXZlciBJ
IGRvIG5vdCBrbm93IHRoZSBjb2RlYmFzZSBnb29kIGVub3VnaCB0bw0KPiA+ID4gZml4DQo+ID4g
PiB0aGF0IHByb3Blcmx5Lg0KPiA+ID4gDQo+ID4gPiBBdXJlbGllbg0KPiA+ID4gDQo+ID4gSSd2
ZSBleHBlcmllbmNlZCBzb21ldGhpbmcgc2ltaWxhciBvbiBteSBycGkzLiBJIGZvdW5kIHRoYXQg
b24gcmVzdGFydCwNCj4gPiBkaXNjb3Zlci11bnByb3Zpc2lvbmVkIHN0b3BwZWQgd29ya2luZy4N
Cj4gDQo+IEluIG15IGNhc2UgSSBhbHNvIG9ic2VydmUgdGhlIHNhbWUuDQo+IA0KPiA+IEluIG15
IGNhc2UsIGl0IGFwcGVhcnMgdGhhdCBtZXNoZCBhc3N1bWVzIHRoYXQgaWYgdGhlcmUgYXJlIGV4
aXN0aW5nDQo+ID4gbm9kZXMsIHNjYW5uaW5nIGhhcyBiZWVuIGVuYWJsZWQuIFRodXMsIGNhbGxz
IGZyb20gbWVzaC1jZmdjbGllbnQgdG8NCj4gPiBkaXNjb3ZlciBhZGRpdGlvbmFsIHVucHJvdmlz
aW9uZWQgbm9kZXMgZG8gbm90IG5lZWQgYW5vdGhlciBoY2kgc2Nhbg0KPiA+IGVuYWJsZSBhdCBt
ZXNoL21lc2gtaW8tZ2VuZXJpYy5jOjczNi4NCj4gPiANCj4gPiBJZiBtZXNoZCBpcyByZXN0YXJ0
ZWQgd2l0aCBwcmVleGlzdGluZyBub2Rlcywgc2Nhbm5pbmcgaXMgc3RpbGwgYXNzdW1lZA0KPiA+
IHRvIGFscmVhZHkgYmUgZW5hYmxlZCwgYnV0IGl0J3Mgbm90LiBUaGlzIGJyZWFrcyBkaXNjb3Zl
ci11bnByb3Zpc2lvbmVkIA0KPiA+IGZvciBtZS4NCj4gDQo+IFllcywgSSB0aGluayB0aGlzIGlz
IGV4YWN0bHkgbXkgcHJvYmxlbS4gSWYgdGhlcmUgYXJlIGV4aXN0aW5nIG5vZGVzLA0KPiByZWN2
X3JlZ2lzdGVyIGlzIGNhbGxlZCBiZWZvcmUgdGhlIEhDSSBpcyBjb25maWd1cmVkIGFuZCBwdnQt
PnJ4X3JlZ3MgaXMNCj4gZmlsbGVkIGF0IG1lc2gvbWVzaC1pby1nZW5lcmljLmM6NzM4LiBUaGlz
IG1lYW5zIHRoYXQgbGF0ZXIgc2Nhbm5pbmcgaXMNCj4gYXNzdW1lZCB0byBiZSBlbmFibGVkLiBI
b3dldmVyIHRoZSBjYWxsIHRvIGJ0X2hjaV9zZW5kIHdpdGgNCj4gQlRfSENJX0NNRF9MRV9TRVRf
U0NBTl9QQVJBTUVURVJTIGZhaWxzIGFzIHRoZSBIQ0kgaXMgbm90IHlldA0KPiBpbml0aWFsaXpl
ZCBhbmQgdGhlIGNhbGxiYWNrIHNldF9yZWN2X3NjYW5fZW5hYmxlKCkgc3VwcG9zZWQgdG8gZW5h
YmxlDQo+IHNjYW5uaW5nIGlzIG5vdCBjYWxsZWQuDQo+IA0KPiBTbyB3aGVuIGxvYWRpbmcgYSBu
b2RlLCBzY2FubmluZyBpcyBhc3N1bWVkIHRvIGJlIGVuYWJsZWQsIGJ1dCBpdCBpcw0KPiBub3Qg
cHJhY3RpY2UuDQo+IA0KPiBJIGJlbGlldmUgbXkgd29ya2Fyb3VuZCBzaG91bGQgd29yayBvbiB5
b3VyIHN5c3RlbSAobWF5YmUgYWZ0ZXINCj4gYWRqdXN0aW5nIHRoZSBudW1iZXIgb2YgaXRlcmF0
aW9ucyBvZiB0aGUgbG9vcCkuDQo+IA0KPiBBdXJlbGllbg0KPiAgDQoNClRoYW5rcyBmb3IgdGhl
IGFuYWx5c2lzLiBJIHRoaW5rIHdlIHNob3VsZCBzd2l0Y2ggdG8gY2FsbGJhY2sgYXBwcm9hY2gs
DQppLmUuIGluaXRpYWxpemUgaW8gZmlyc3QgYW5kIHJlZ2lzdGVyIHRoZSBSWCBvbiB0aGUgc3Vj
Y2Vzc2Z1bCBpbml0DQpjYWxsYmFjay4NCg0KQmVzdCByZWdhcmRzLA0KSW5nYQ0KDQo=
