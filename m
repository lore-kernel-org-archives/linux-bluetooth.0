Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D24C3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A892184D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfH0TK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:10:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:23911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbfH0TK6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 15:10:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 12:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="181791154"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 12:10:56 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.123]) with mapi id 14.03.0439.000;
 Tue, 27 Aug 2019 12:10:55 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/2] mesh: Implement org.bluez.mesh.Node1
 properties
Thread-Topic: [PATCH BlueZ 0/2] mesh: Implement org.bluez.mesh.Node1
 properties
Thread-Index: AQHVXLcYnQf8+mIppUGCN+mFnpcK/KcPuSWAgAAL8gCAAA0fAA==
Date:   Tue, 27 Aug 2019 19:10:54 +0000
Message-ID: <a1642e6a33df45cbc41c1bcd42878dabbc7576b3.camel@intel.com>
References: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
         <4f4cc80d57738604b3b38049a1aecb6b75e57be2.camel@intel.com>
         <20190827182356.2pbseooolxfazg3g@kynes>
In-Reply-To: <20190827182356.2pbseooolxfazg3g@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED3AA41533BD3F4889C57B1B3195F184@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDIwOjIzICswMjAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIDA4LzI3LCBTdG90bGFuZCwgSW5n
YSB3cm90ZToNCj4gPiA+IGFkZHMgdHdvIGFkZGl0aW9uYWwgcHJvcGVydGllczogbGlzdCBvZiB1
bmljYXN0IGFkZHJlc3Nlcw0KPiA+ID4gY2xhaW1lZCBieSB0aGUgbm9kZSBhbmQgdGhlIGN1cnJl
bnQgc2VxdWVuY2UgbnVtYmVyIHZhbHVlLg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB0
aGUganVzdGlmaWNhdGlvbiBmb3IgYWRkaW5nIHRoZXNlIHR3byBuZXcNCj4gPiBwcm9wZXJ0aWVz
Pw0KPiANCj4gU3VyZSB0aGluZy4NCj4gDQo+IFRoZSBhZGRyZXNzIHBhcnQgaXMgdXNlZnVsIHdo
ZW4gYXBwbGljYXRpb24gd291bGQgbGlrZSB0byB0YWxrIHRvIGl0cw0KPiBvd24gbm9kZSdzIENv
bmZpZyBvciBIZWFsdGggU2VydmVyLiBBdCB0aGUgbW9tZW50IHRoZSBhZGRyZXNzIGlzIGtub3du
DQo+IHdoZW4gY2FsbGluZyBJbXBvcnQgb3IgQ3JlYXRlTmV0d29yayAoZXZlbiB0aG91Z2ggdGhl
IGFwcGxpY2F0aW9uIHdvdWxkDQo+IHRoZW4gbmVlZCB0byBzdG9yZSBpdCBzb21ld2hlcmUsIHNv
IHdlIGVuZCB1cCB3aXRoIHR3byBzb3VyY2VzIG9mDQo+IHRydXRoKSwgYnV0IGFmdGVyIEpvaW4o
KSB0aGUgYXBwbGljYXRpb24gd29uJ3Qga25vdyB0aGUgYWRkcmVzcyBhc3NpZ25lZA0KPiB0byBp
dC4NCg0KSSB0aGluayBJIGFtIE9LIHdpdGggdGhpcy4uLiAgIEl0IGlzIGhhcmQgdG8gbWFrZSB0
aGUgYXJndW1lbnQgdGhhdCB0aGlzIHdvdWxkIGJlIGFuIGluZm9ybWF0aW9uIGxlYWsgd2hlbiB0
aGUNCmluZm9ybWF0aW9uIGhhcyBiZWVuIHJldmVhbGVkIGJlZm9yZS4gQW5kIGNlcnRhaW4gbm9k
ZXMgKGlmIHRoZXkgYXJlIGF1dGhvcml6ZWQpIG5lZWQgdG8gYmUgYWJsZSB0byB0YWxrIHRvDQp0
aGVpciBvd24gY29uZmlnIHNlcnZlcnMuDQoNCj4gDQo+IEFzIGZvciBzZXF1ZW5jZSBudW1iZXIg
cGFydCwgcmVhZGluZyBpcyBtb3N0bHkgZm9yIGRlYnVnZ2luZyBhbmQNCj4gdmVyaWZpY2F0aW9u
LiBBIGZldyBvdXIgdXNlcnMgaGFkIHRyb3VibGUgaWRlbnRpZnlpbmcgYSBwcm9ibGVtIGluIHRo
ZWlyDQo+IHNldHVwIHdoZW4gdGhlaXIgbm9kZSB3YXMgbGlzdGVkIGluIG90aGVyIG5vZGVzJyBS
UEwuDQoNCkkgYW0ga2luZCBvZiBzeW1wYXRoZXRpYyB0byB0aGlzIGZvciBkZWJ1Z2dpbmcgcHVy
cG9zZXMsIGJ1dCBJIHdvdWxkIHBvaW50IG91dCB0aGF0IGR1cmluZyB0aGUgZGVidWdnaW5nDQpw
cm9jZXNzLCBtYW55IHRvb2xzIGFyZSBhdmFpbGFibGUsIGluY2x1ZGluZyBhZGRpbmcgZGVidWcg
bG9nZ2luZyB0byB0aGUgZGFlbW9uIGFzIG5lZWRlZC4gU28gYWRkaW5nIHRoaXMgaW5mbw0KdG8g
dGhlIGRtc2cgbG9nIGZvciBleGFtcGxlLCB3b3VsZCBiZSBhY2NlcHRhYmxlLi4uICBFc3BlY2lh
bGx5IHNvIHRoYXQgaXQgY291bGQgYmUgZWFzaWx5IHR1cm5lZCBvZmYgYXQgbm9uLQ0KZGVidWcg
dGltZXMuDQoNCkhvd2V2ZXIsIEkgZG9uJ3Qgc2VlIGEgcmVhc29uIGZvciBhbnkgKmRlcGxveWVk
KiBhcHBsaWNhdGlvbiBuZWVkaW5nIHRoaXMgaW5mb3JtYXRpb24uDQoNCj4gSW4gdGhlIGVuZCBJ
IHdvdWxkIGxpa2UgdG8gbWFrZSBpdCB3cml0YWJsZSAoaW5jcmVtZW50LW9ubHkpIHRvIGVuYWJs
ZQ0KPiBhZGRyZXNzIHJldXNlLCBidXQgYXMgdGhpcyBzdGFnZSBJJ20gc3RpbGwgbG9va2luZyBm
b3IgYSB3YXkgdG8NCj4gaW1wbGVtZW50IHRoaXMgd2l0aG91dCBjYXVzaW5nIGEgcmFjZSBjb25k
aXRpb24sIHNvIEkgbGVmdCBpdCByZWFkb25seQ0KPiBmb3Igbm93Lg0KDQpUaGlzIGlzIHdoZXJl
IEkgc3RhcnQgdG8gc2VlIGFjdHVhbCBkYW5nZXIsIGFuZCBkaWZmaWN1bHR5IHdoZW4gY29uc2lk
ZXJpbmcgdGhlIE5WTSBzeXN0ZW0gaXMgInByZS1yZXNlcnZpbmciDQpzZXF1ZW5jZSBudW1iZXJz
IHRvIHByZXZlbnQgTlZNIHRocmFzaGluZyBkdXJpbmcgaGVhdnkgdXNlLiBJbiB0aGUgc3Bpcml0
IG9mIGtlZXBpbmcgYW4gQVBJIGFzIHNtYWxsIGFzDQpwb3NzaWJsZSwgZ2l2aW5nIGFwcGxpY2F0
aW9ucyB0aGUgYWJpbGl0eSB0byBhZGp1c3QgdGhlIFNlcU51bSAoZXZlbiBpbiB0aGUgbGVnYWwg
ZGlyZWN0aW9uKSBzaG91bGQgaGF2ZSBhIHJvY2sNCnNvbGlkIGp1c3RpZmljYXRpb24uDQoNCj4g
cmVnYXJkcw0K
