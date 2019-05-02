Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52844C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 21:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A752081C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 21:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfEBVdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 17:33:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:1923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBVdz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 17:33:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 14:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,423,1549958400"; 
   d="scan'208";a="139414343"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2019 14:33:54 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.52]) with mapi id 14.03.0415.000;
 Thu, 2 May 2019 14:33:54 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH] mesh: Use node uuids as storage directory names
Thread-Topic: [PATCH] mesh: Use node uuids as storage directory names
Thread-Index: AQHVAOfn6Uj6E2dJ502n6ceKparuCKZYmPSAgAAnugCAABBSgA==
Date:   Thu, 2 May 2019 21:33:54 +0000
Message-ID: <89be788e4efdd963e39370b0311d8f2a53c2e13c.camel@intel.com>
References: <20190502130630.13890-1-michal.lowas-rzechonek@silvair.com>
         <a716514ec5be59e7e177c9a256238e314b4599d9.camel@intel.com>
         <20190502203526.mfglyyzsoudp6mtw@kynes>
In-Reply-To: <20190502203526.mfglyyzsoudp6mtw@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.151.94]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C9773B2CFF056499E5A562FA134D91A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTAyIGF0IDIyOjM1ICswMjAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tDQp3cm90ZToNCj4gSGkgSW5nYSwNCj4gDQo+IE9uIDA1LzAyLCBTdG90bGFu
ZCwgSW5nYSB3cm90ZToNCj4gRGV2aWNlIFVVSUQgaXMgYXNzb2NpYXRlZCB3aXRoIGEgbWVzaC1i
YXNlZCBhcHBsaWNhdGlvbiBhbmQsIGFzIHN1Y2gsDQo+IGlzIGltbXV0YWJsZS4NCj4gDQo+IEhv
d2V2ZXIsIHRoZSBzYW1lIGFwcGxpY2F0aW9uIChvciB3ZSBjYW4gY2FsbCBpdCBkZXZpY2UpIGNh
biBiZQ0KPiBzaW11bHRhbmVvdXNseSBwcm92aXNpb25lZCBvbiBkaWZmZXJlbnQgbWVzaCBuZXR3
b3JrcyAoZS5nLiwgaG9tZSBhbmQNCj4gb2ZmaWNlIG5ldHdvcmtzKSwgd2hpY2ggbWVhbnMgdGhh
dCBpdCBuZWVkcyB0byBiZSByZXByZXNlbnRlZCBhcyBhDQo+IHVuaXF1ZSBtZXNoIG5vZGUgYW5k
IGl0cyBjb25maWd1cmF0aW9uIGhhcyB0byBiZSBzdG9yZWQgaW4gdW5pcXVlDQo+IGRpc3RpbmN0
IGxvY2F0aW9uLiAgSGVuY2UgdGhlIG5lZWQgZm9yIGEgdW5pcXVlIG5vZGUgSUQgdGhhdCBpcyBu
b3QNCj4gYmFzZWQgb24gZGV2aWNlIFVVSUQuDQo+IDMuMTAuMyBzYXlzIHRoYXQ6DQo+IA0KPiAi
KC4uLikgZWFjaCBub2RlIHNoYWxsIGJlIGFzc2lnbmVkIGEgMTI4LWJpdCBVVUlEIGtub3duIGFz
IHRoZSBEZXZpY2UNCj4gVVVJRC4gRGV2aWNlIG1hbnVmYWN0dXJlcnMgc2hhbGwgZm9sbG93IHRo
ZSBzdGFuZGFyZCBVVUlEIGZvcm1hdCBhcw0KPiBkZWZpbmVkIGluIFtSRkM0MTIyXSBhbmQgZ2Vu
ZXJhdGlvbiBwcm9jZWR1cmUgdG8gZW5zdXJlIHRoZQ0KPiB1bmlxdWVuZXNzDQo+IG9mIGVhY2gg
RGV2aWNlIFVVSUQiDQo+IA0KPiBTbyBJIHRoaW5rIHRoZSBVVUlEIGlzIGFzc2lnbmVkIHRvICpu
b2RlcyosIG5vdCAqYXBwbGljYXRpb25zKg0KPiBjb250cm9sbGluZyB0aGVtPyBJIGRvbid0IHRo
aW5rIGl0J3MgbGVnYWwgdG8gY3JlYXRlIHR3byBkaWZmZXJlbnQNCj4gbm9kZXMgd2l0aCB0aGUg
c2FtZSBVVUlELg0KPiANCg0KWW91IGFyZSBjb3JyZWN0LCBhIGRldmljZSBVVUlEIGlzIGEgbm9k
ZSBhdHRyaWJ1dGUsIG5vdCBhcHBsaWNhdGlvbidzLg0KDQpJIGFtIG5vdCBzdXJlIHdoZXRoZXIg
aXQncyB0cnVseSAiaWxsZWdhbCIgdG8gaGF2ZSBub2RlcyB3aXRoIHRoZSBzYW1lDQpVVUlEcyBm
cm9tIGEgcmVtb3RlIFByb3Zpc2lvbmVyIHBlcnNwZWN0aXZlIChzaW5jZSBpdCBoYXMgbm8gY29u
dHJvbA0Kb3Zlcg0KdGhlIFVVSUQgdmFsdWUgaW4gdGhlIHVucG92aXNpb25lZCBkZXZpY2UgYmVh
Y29uIGFuZCBJIGFtIG5vdCBhd2FyZSBvZg0KYW55DQplcnJvciBjb2RlIHRoYXQgYSBQcm92aXNp
b25lciBjYW4gc2VuZCBpbmRpY2F0aW5nIGEgbmFtZSBjb2xsaXNpb24pLg0KDQpIb3dldmVyLCBm
cm9tIGEgbG9jYWwgbm9kZSBub2RlIHBlcnNwZWN0aXZlLCB5b3UgYXJlIGFic29sdXRlbHkNCmNv
cnJlY3Q6DQpVVUlEcyBzaG91bGQgYmUgdW5pcXVlLg0KDQpTbywgSm9pbigpIG1ldGhvZCB3aWxs
IGhhdmUgdG8gY2hlY2sgaWYgYSBkaXJlY3RvcnkgbmFtZSB3aXRoIHRoZQ0Kc3VwcGxpZWQNClVV
SUQgdmFsdWUgYWxyZWFkeSBleGlzdHMgYW5kLCBpZiBzbywgZmFpbCB3aXRoICJBbHJlYWR5RXhp
c3RzIiBlcnJvci4NClRoZSBtZXNoLWFwaS50eHQgZG9jIHNob3VsZCBiZSB1cGRhdGVkIGFjY29y
ZGluZ2x5Lg0KDQpBbHNvLCBpZiB0aGUgZGlyZWN0b3J5IG5hbWUgY29udGFpbnMgdGhlIHV1aWQg
dmFsdWUsIHRoZW4gd2UgcHJvYmFibHkNCmRvbid0DQpuZWVkIHRoZSBkdXBsaWNhdGUgdmFsdWUg
aW4gdGhlIEpTT04gZmlsZSBzaW5jZSBpdCBjYW4gYmUgZGVyaXZlZCBmcm9tDQp0aGUNCmRpcmVj
dG9yeSBuYW1lLg0KDQo+IFRvIGNvdmVyIHRoZSB1c2UgY2FzZSB5b3UgbWVudGlvbmVkLCBJIHRo
aW5rIHRoZSBhcHBsaWNhdGlvbiB3b3VsZA0KPiBuZWVkDQo+IHRvIGtlZXAgdHJhY2sgb2YgdHdv
IFVVSURzLCBhbmQgQXR0YWNoKCkgaXRzZWxmIHRvIGJvdGggLSB3aGljaCBpcw0KPiBjZXJ0YWlu
bHkgcG9zc2libGUuDQo+IA0KPiByZWdhcmRzDQo+IA0K
