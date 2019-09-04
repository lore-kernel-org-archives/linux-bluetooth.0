Return-Path: <SRS0=/e8j=W7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131D4C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FEC21726
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 20:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfIDU0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:26:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:54637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDU0D (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Sep 2019 16:26:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 13:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="194850475"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 13:26:02 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.123]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 13:26:02 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "simon@silvair.com" <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6ccY5SAgAAGWACAAAqWgA==
Date:   Wed, 4 Sep 2019 20:26:02 +0000
Message-ID: <d79b733068e30cfa1cef106e44b7f9ee7c31526d.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190904192525.2dqyihabxmigb54m@kynes>
         <20190904194808.nu2cy4vp6uh64m4z@kynes>
In-Reply-To: <20190904194808.nu2cy4vp6uh64m4z@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.229.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5F4B8F8D5ABA44B8ACEBFDF6CCAB966@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTA0IGF0IDIxOjQ4ICswMjAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25l
ayB3cm90ZToNCj4gT24gMDkvMDQsIE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiA+
IFRoZSB0d28gZXhhbXBsZXMgSSBwcm92aWRlZCBhcmUgKm5vdCogdmlvbGF0aW5nIHRoZSBzcGVj
IGluIGFueSB3YXkuDQo+ID4gRm9yIHRoZSByZWNvcmQ6DQo+ID4gIC0gYSBjb21iaW5lZCBzZXJ2
ZXIvY2xpZW50IHNpdHRpbmcgb24gZWxlbWVudCAxIHRoYXQgcmVjZWl2ZXMgb25vZmYNCj4gPiAg
ICBtZXNzYWdlcyBhbmQsIGRlcGVuZGluZyBvbiB0aGUgZGVzdGluYXRpb24gYWRkcmVzcywgc2Vu
ZHMgYSBkaWZmZXJlbnQNCj4gPiAgICBvbm9mZiBtZXNzYWdlcyB0byBhICJyZWd1bGFyIiBvbm9m
ZiBzZXJ2ZXIgc2l0dGluZyBvbiBlbGVtZW50IDAsDQo+ID4gICAgYWxsb3dpbmcgZWZmaWNpZW50
IGNvbnRyb2wgb3ZlciBzd2l0Y2hpbmcgc2NlbmVzIGludm9sdmluZyBsYXJnZQ0KPiA+ICAgIG51
bWJlciBvZiBub2Rlcw0KPiA+ICAtIGEgbW9kZWwgdGhhdCBhY3RzIGFzIGEgSVB2NiBnYXRld2F5
IGFuZCBkaXJlY3RseSBtYXBzIHZpcnR1YWwNCj4gPiAgICBhZGRyZXNzZXMgdG8gSVB2NiBhZGRy
ZXNzZXMgb2Ygbm9kZXMgbGl2aW5nIG9uIHRoZSBvdGhlciBzaWRlIG9mIHRoZQ0KPiA+ICAgIGdh
dGV3YXkNCj4gDQo+IEFub3RoZXIgb25lIGFib3V0IHZpcnR1YWwgYWRkcmVzc2VzOg0KPiANCj4g
SW4gQ0FOT3BlbiwgdGhlcmUgaXMgYSBjb25jZXB0IG9mIGEgIlByb3RvY29sIERhdGEgT2JqZWN0
IiBbMV0uDQo+IEJhc2ljYWxseSwgdGhlIGlkZWEgaXMgdG8gcGFjayBtYW55IHBpZWNlcyBvZiBp
bmZvcm1hdGlvbiBpbnRvIGENCj4gcHJlY29uZmlndXJlZCBmb3JtYXQgKGRvd24gdG8gc2luZ2xl
IGJpdHMsIGJlY2F1c2UgQ0FOIGZyYW1lcyBhcmUgZXZlbg0KPiBzaG9ydGVyIHRoYW4gbWVzaCBv
bmVzKSAtIHRoaXMgaXMga25vd24gYXMgIlBETyBNYXBwaW5nIFBhcmFtZXRlcnMiIC0NCj4gdGhl
biBzZW5kIHN1Y2ggcGF5bG9hZHMgdG8gYSB3ZWxsLWtub3duIGdyb3VwIGFkZHJlc3MuDQo+IA0K
PiBJbiBzdGF0aWMgY29uZmlndXJhdGlvbnMsIHRoaXMgYWxsb3dzIHRvIGRlY3JlYXNlIHRoZSBu
dW1iZXIgKGFuZCBzaXplKQ0KPiBvZiBwYWNrZXRzIHNlbnQgYnkgc2Vuc29yIG5vZGVzLg0KPiAN
Cj4gU2luY2UgUERPIHBheWxvYWRzIGFyZSAqbm90KiBzZWxmLWRlc2NyaWJpbmcgKHVubGlrZSBt
ZXNoIHNlbnNvcg0KPiBtZXNzYWdlcyksIHRoZSByZWNlaXZpbmcgcGFydHkgbXVzdCBiZSBhd2Fy
ZSBvZiB0aGUgbWFwcGluZyBpbiBvcmRlciB0bw0KPiBwYXJzZSB0aGUgZGF0YS4NCj4gDQo+IElu
IENBTk9wZW4sIGZvcm1hdCBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBhZGRyZXNzIC0gaW4gbWVzaCwg
aXQgY291bGQgdmVyeQ0KPiB3ZWxsIGJlIGEgdmlydHVhbCBsYWJlbC4NCj4gDQo+IFsxXSBodHRw
czovL3d3dy5jYW4tY2lhLm9yZy9jYW4ta25vd2xlZGdlL2Nhbm9wZW4vcGRvLXByb3RvY29sLw0K
PiANCg0KSSB0aGluayB0aGF0IHRoaXMgaXMgYW4gaW50ZXJlc3RpbmcgdXNlIG9mIFZpcnR1YWwg
QWRkcmVzc2VzLCBhbmQgaW4gYWRkaXRpb24gdG8gdGhpcywgTWVzaCBWaXJ0dWFsIEFkZHJlc3Nl
cw0KaGF2ZSBiZWVuIHN1Z2dlc3RlZCBhcyBhIHdheSBvZiBhZGRyZXNzaW5nIElQdjYgYWRkcmVz
c2luZyBhcyB3ZWxsLi4uICBIb3dldmVyOg0KDQoxLiBUaGVyZSBpcyBhbHJlYWR5IGEgd2F5IHNv
bWV0aGluZyBsaWtlIHRoaXMgY291bGQgYmUgdXNlZCBhbHJlYWR5OiAgQSBtb2RlbCBjb3VsZCBi
ZSBjcmVhdGVkIHRoYXQgZ2V0cw0Kc3Vic2NyaWJlZCB0byB0aGUgVmlydHVhbCBBZGRyZXNzZXMg
dGhhdCByZXF1aXJlIGhhbmRsaW5nIGJ5IHRoZSBub2RlLg0KDQoyLiBJZiBzdWNoIGEgc3lzdGVt
IHByb3ZlcyB0byBiZSB3aWRlbHkgcmVxdWVzdGVkLCBkYWVtb24gc3VwcG9ydCBjb3VsZCBiZSBh
ZGRlZCAocGVyaGFwcyB1bmRlciBhIGRpZmZlcmVudA0KREJ1cyBpbnRlcmZhY2UpIGZvciBlaXRo
ZXIgb3IgYm90aCBvZiBJUHY2IGFuZCAiQ0FOT3BlbiIuDQoNCkluIGFueSBjYXNlIHRoZSBhYmls
aXR5IHRvIGNyZWF0ZSBzaW1wbGUgbWVzaCBBcHBzIHdpdGggbWluaW1hbCBjb21wbGV4aXR5IHJl
bWFpbnMgaW50YWN0LCBhbmQgYXMgYW4gYWRkZWQNCmJvbnVzLCB0aGUgT3BlbiBTb3VyY2UgY29t
bXVuaXR5IChub3QgdG8gbWVudGlvbiB0aGUgQmx1ZXRvb3RoIE1lc2ggV29ya2luZyBHcm91cCBh
bmQgbGFyZ2VyIFNJRykgY2FuIHdlaWdoIGluDQpvbiB0aGUgcHJlZmVycmVkIG1ldGhvZG9sb2dp
ZXMuDQoNCg0KDQoNCg0K
