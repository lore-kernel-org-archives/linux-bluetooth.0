Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5806C4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFCC205C9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF1O3r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:29:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:43091 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1O3r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 10:29:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 07:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="189454918"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2019 07:29:46 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Jun 2019 07:29:45 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.187]) with mapi id 14.03.0439.000;
 Fri, 28 Jun 2019 07:29:45 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: Was: mesh: Added ImportLocalNode call with its API --> Multiple
 Methods?
Thread-Topic: Was: mesh: Added ImportLocalNode call with its API -->
 Multiple Methods?
Thread-Index: AQHVLRZ9fRBaO09IV0ao9IDcG1DkoqawXpWAgAE4cAA=
Date:   Fri, 28 Jun 2019 14:29:44 +0000
Message-ID: <1561732182.7802.47.camel@intel.com>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
         <1561568468.22940.16.camel@intel.com>
         <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
         <CAMCw4t3pXTbtt05RD694jzF_MNT_J9dcFMtA7iuD4ujZT9FDbg@mail.gmail.com>
         <1561660267.7802.29.camel@intel.com>
         <20190627195127.payxcdeexiamsi24@kynes>
In-Reply-To: <20190627195127.payxcdeexiamsi24@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <04CCE36B5052AD41BF7703CF091D235D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQWxsLA0KDQpPbiBUaHUsIDIwMTktMDYtMjcgYXQgMjE6NTEgKzAyMDAsIG1pY2hhbC5sb3dh
cy1yemVjaG9uZWtAc2lsdmFpci5jb20gd3JvdGU6DQo+IEhpIGV2ZXJ5b25lLA0KPiANCj4gT24g
MDYvMjcsIEdpeCwgQnJpYW4gd3JvdGU6DQo+ID4gSSBhbSBzdGFydGluZyB0byB0aGluayB3ZSBt
YXkgbmVlZCBtdWx0aXBsZSBtZXRob2RzIGhlcmUgdG8gZGVhbCB3aXRoDQo+ID4gdGhlIGRlc2ly
ZWQgdXNlIGNhc2VzOg0KPiANCj4gSSBkb24ndCBsaWtlIHRoaXMuIEJhY2sgaW4gdGhlIGRheSB3
ZSBkaXNjdXNzZWQgdGhhdCB3ZSdkIGxpa2UgdG8gYXZvaWQNCj4gRC1CdXMgQVBJIGJsb2F0Li4u
DQo+IA0KPiA+ICogSW1wb3J0Tm9kZVByb3ZEYXRhKCkNCj4gPiAoLi4uKQ0KPiA+IFRoZSBkYWVt
b24gbWV0aG9kIHdvdWxkIHBlcmZvcm0gYSBHZXRNYW5hZ2VkT2JqZWN0IG9mIHRoZSBjYWxsaW5n
DQo+ID4gYXBwbGljYXRpb24sIHRvIGNyZWF0ZSBhIG5vZGUuanNvbiB3aXRoIGFsbCBvZiB0aGUg
Q29tcG9zaXRpb24gZGF0YSwNCj4gPiBlbGVtZW50cywgbW9kZWxzLCBmZWF0dXJlcywgZXRjLg0K
PiANCj4gV2hpbGUgdGhlIGluaXRpYWwgaWRlYSB3YXMgaW5kZWVkIGFib3V0IGltcG9ydGluZyB0
aGUgd2hvbGUgbm9kZSwNCj4gaW5jbHVkaW5nIGNvbmZpZ3VyYXRpb24sIG1vZGVscyBldGMuLCBk
dXJpbmcgaW1wbGVtZW50YXRpb24gd2UgZmlndXJlZA0KPiB0aGF0IHRoZSByZWFzb24gdG8gZG8g
aXQgaXMgdG8gZXZlbnR1YWxseSBBdHRhY2goKSB0byBzdWNoIGEgbm9kZSAtIGl0DQo+IGRvZXNu
J3QgbWFrZSBzZW5zZSB0byBpbXBvcnQgc29tZXRoaW5nIHlvdSB3b3VsZG4ndCB1c2UuDQo+IA0K
PiBJZiBzbywgdGhlbiB5b3UgbmVlZCB0byBoYXZlIGFuIGFwcHJvcHJpYXRlIGFwcGxpY2F0aW9u
IGFueXdheSwgd2hpY2gNCj4gdGhlIGRhZW1vbiBjYW4gc2ltcGx5IHF1ZXJ5IGZvciBhbGwgdGhl
IG5lZWRlZCBpbmZvLCBhcyBpdCBkb2VzIGF0IHRoZQ0KPiBtb21lbnQgZHVyaW5nIEpvaW4oKSBh
bmQgQ3JlYXRlTmV0d29yaygpIGNhbGxzLiBUaGlzIG5pY2VseSBmaXRzIGludG8NCj4gUkVRVUVT
VF9UWVBFIHByb2Nlc3NpbmcgaW4gZ2V0X21hbmFnZWRfb2JqZWN0c19jYigpLg0KPiANCj4gVGhp
cyByZXN1bHRzIGluIHNtYWxsZXIgQVBJIGFuZCAqc2lnbmlmaWNhbnRseSogc2ltcGxlciBjb2Rl
LiBBcyB5b3UNCj4gbWVudGlvbmVkLCBkb2luZyBhIGZ1bGwgbWlncmF0aW9uIGlzIGNvbXBsaWNh
dGVkLg0KPiANCj4gPiAqIE1pZ3JhdGVOb2RlKCkNCj4gPiBUaGlzIG1ldGhvZCB3b3VsZCBiZSB3
aGF0IEluZ2EgYW5kIEkgaGFkIG9yaWdpbmFsbHkgZW52aXNpb25lZCBmb3IgdGhlDQo+ID4gSW1w
b3J0TG9jYWxOb2RlKCkgY2FsbC4uLiBJdCB3b3VsZCBjb250YWluICphbGwqIHRoZSBpbmZvcm1h
dGlvbiB0aGF0DQo+ID4gYSBwcmUtZXhpc3Rpbmcgbm9kZSBoYWQuLi4gaW5jbHVkaW5nIHByZWNv
bmZpZ3VyZWQgcHViL3N1YiwgZmVhdHVyZXMsDQo+ID4gU2VxdWVuY2UgdmFsdWUgdGhhdCByZWZs
ZWN0ZWQgdGhhdCB0aGlzIG5vZGUgYWxyZWFkeSBleGlzdGVkIGVsc2V3aGVyZQ0KPiA+IG9uIHRo
ZSBtZXNoLCBidXQgd2FzIHNpbXBseSBiZWluZyBtaWdyYXRlZCB0byB0aGlzIGRldmljZSwgZXRj
Lg0KPiANCj4gVGhlIGFwcGxpY2F0aW9uIGNhbiBkbyBhbGwgdGhlIGNvbmZpZ3VyYXRpb24gdXNp
bmcgbG9vcGJhY2sgQ29uZmlnDQo+IFNlcnZlciBtZXNzYWdlcywgc28gSSBkb24ndCB0aGluayB3
ZSBuZWVkIGEgTWlncmF0ZSgpIGNhbGwgYXQgYWxsLiBUaGUNCj4gYXBwbGljYXRpb24gYWxyZWFk
eSByZWNlaXZlcyBjdXJyZW50IG5vZGUgY29uZmlndXJhdGlvbiB3aGVuDQo+IEF0dGFjaCgpaW5n
LCBzbyBpdCBjYW4gZGV0ZXJtaW5lIGlmIHNvbWV0aGluZyBuZWVkcyB0byBiZSByZWNvbmZpZ3Vy
ZWQuDQoNCg0KSSBkb24ndCBzZWUgdGhpcyBhY3R1YWxseSB3b3JraW5nIHZlcnkgd2VsbC4gIEZp
cnN0bHksIHRoZXNlICJMb29wLWJhY2siIENvbmZpZyBTZXJ2ZXIgbWVzc2FnZXMgZG8gbm90IGFs
bA0KYWN0dWFsbHkgd29yayB1bmxlc3MgdGhlIG5vZGUgaXMgYSBQcm92aXNpb25lciwgd2hpY2gg
d2lsbCAqbm90KiBiZSByZXF1aXJlZCBvZiBtb3N0IG5vZGVzLg0KDQpBbmQgSG93ZXZlciwgZXZl
biBpZiB0aGUgQXBwIHdlbnQgdGhyb3VnaCBhbGwgb2YgdGhlIHJlc3RvcmF0aW9uIG9mIGFsbCB0
aGUgc2V0dGluZ3MgdW5kZXIgdGhlIGNvbnRyb2wgb2YgdGhlDQpQcm92aXNpb25lciB2aWEgdGhp
cyBDb25maWcgU2VydmVyIGxvb3AtYmFjayBtZXRob2QsIHRoZXJlIGlzIHN0aWxsIHRoZSBjcml0
aWNhbCBpc3N1ZSBvZiBTZXF1ZW5jZSBudW1iZXJzLg0KDQpBIG5vZGUgdGhhdCBpcyBiZWluZyBt
aWdyYXRlZCBuZWVkcyB0byBwaWNrIHVwIHdoZXJlIGl0IHdhcyBwcmlvciB0byB0aGUgbWlncmF0
aW9uLCBhc3N1bWluZyB0aGF0IGl0IGhhcw0KYWxyZWFkeSBoYWQgY29udmVyc2F0aW9ucyB3aXRo
IG90aGVyIG5vZGVzLCBhbmQgaGFzIGVudHJpZXMgaW4gdGhlaXIgUmVwbGF5IFByb3RlY3Rpb24g
TGlzdC4NCg0KDQpJZiB3ZSB3YW50IGEgc2luZ2xlIG1ldGhvZCAoYXZvaWQgQVBJIGJsb2F0KSBJ
IGRvbid0IHRoaW5rIHdlIGhhdmUgYW55IGNob2ljZSBidXQgdG8gdXNlIGEgd2VsbCBkZXZlbG9w
ZWQNCnN0cnVjdHVyZSAobGlrZSBKU09OIG9yIFhNTCkgdGhhdCBmYWl0aGZ1bGx5IHNldHMgdXAg
dGhlIG5vZGUgaW4gdGhlIHN0YXRlIGl0IHdhcyBpbiBwcmlvciB0byBNaWdyYXRpb24uICBXZQ0K
Y2FuIHBlcmhhcHMgIk92ZXJsb2FkIiB0aGlzIGZ1bmN0aW9uYWxpdHkgYnkgYWxsb3dpbmcgYSBt
aW5pbWFsIEpTT04gd2l0aCBvbmx5IFByb3YgRGF0YSBwYXJ0cywgaWYgd2UgYXJlDQpsb29raW5n
IGZvciBhIFByb3Zpc2lvbmluZyBzaG9ydGN1dCwgYW5kIGFsd2F5cyByZXF1aXJpbmcgdGhlIE9i
amVjdE1hbmFnZXIgY2FsbHMgZmV0Y2ggdGhlIENvbXBvc2l0aW9uIChpZiB0aGUNCkpTT04gd2Fz
IG1pbmltYWwpIGFuZCB0byBTYW5pdHkgY2hlY2sgdGhlIENvbXBvc2l0aW9uIChpZiB0aGUgSlNP
TiBjb250YWlucyBhIGZ1bGx5IGRldmVsb3BlZC9jb25maWd1cmVkDQpNaWdyYXRlZCBub2RlKS4N
Cg0KPiANCj4gQW5kIGFnYWluLCB5b3Ugd291bGQgbmVlZCBhbiBBdHRhY2goKWFibGUgYXBwbGlj
YXRpb24gYW55d2F5LCBzbyBhbGwgdGhlDQo+IGluZm9ybWF0aW9uIHdvdWxkIG5lZWQgdG8gYmUg
ZHVwbGljYXRlZCBpbiBhcHBsaWNhdGlvbidzIEQtQnVzDQo+IGludGVyZmFjZXMgYW5kIGluIHRo
ZSBKU09OIHBhc3NlZCB0byBNaWdyYXRlKCkgY2FsbC4gVGhpcyBzZWVtcyBsaWtlIGENCj4gdmlv
bGF0aW9uIG9mIERSWSBwcmluY2lwbGUuDQo+IA0KPiByZWdhcmRz
