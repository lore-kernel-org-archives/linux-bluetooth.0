Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C1C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1049022419
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeKMB67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:58:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:38274 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeKMB67 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 20:58:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 08:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="249073474"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga004.jf.intel.com with ESMTP; 12 Nov 2018 08:05:07 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.166]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.195]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 08:05:07 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Marcel Holtmann" <marcel@holtmann.org>
Subject: RE: [PATCH BlueZ v2] doc: Initial Bluetooth Mesh API
Thread-Topic: [PATCH BlueZ v2] doc: Initial Bluetooth Mesh API
Thread-Index: AQHUeiezLw8+xn0WNEaLOucalm9UcaVMly0AgAAJVoCAAByegP//jWew
Date:   Mon, 12 Nov 2018 16:05:06 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375C132AB0@ORSMSX103.amr.corp.intel.com>
References: <20181112013317.5714-1-inga.stotland@intel.com>
 <CABBYNZJLLxNC3BQvyDxzTFLppe25ke=VK_9QtvJsNbCFjnUW2A@mail.gmail.com>
 <4C0377DF-430B-4A2C-BA6E-CC4B9C6ED9F6@gmail.com>
 <CABBYNZ+1RqUJm3c_mQjF0DNDy1GWTKRP-v-66VN1ihEpf6Y3iw@mail.gmail.com>
In-Reply-To: <CABBYNZ+1RqUJm3c_mQjF0DNDy1GWTKRP-v-66VN1ihEpf6Y3iw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWIyMmEwYjgtNDJhYi00YzE5LTgxYWEtODg1Yzg4MGU0ZTVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK0lkOVwvUE1wMDJqclNJZ29LT29aOTMxOWFTbUF4dlZPYTRVZGI3WHFqbFFWUzBxMmJzbVgxNGY0WGpSTXl4QnQifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwgSm9oYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
THVpeiBBdWd1c3RvIHZvbiBEZW50eiBbbWFpbHRvOmx1aXouZGVudHpAZ21haWwuY29tXQ0KPiAN
Cj4gSGkgSm9oYW4sDQo+IA0KPiBPbiBNb24sIE5vdiAxMiwgMjAxOCBhdCAyOjU4IFBNIEpvaGFu
IEhlZGJlcmcNCj4gPGpvaGFuLmhlZGJlcmdAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IEx1aXoNCj4gPg0KPiA+ID4gT24gMTIgTm92IDIwMTgsIGF0IDEzLjI0LCBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6DQo+IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
SXQgc2VlbXMgd3JvbmcgIHRvIG1lIHRvIGhhdmUgdG8gc2VuZCB5b3VyIG93biBvYmplY3QgYXMg
bWV0aG9kDQo+ID4gPiBhcmd1bWVudCwgdXN1YWxseSB0aGlzIHNvcnQgb2YgY29tbXVuaWNhdGlv
biBnb2VzIGFzIGEgU2lnbmFsIGJ1dCBpdA0KPiA+ID4gc2VlbXMgdGhlIEVsZW1lbnQgaW50ZXJm
YWNlIGhhcyBubyBzaWduYWwgdG8gYmUgYWJsZSB0byBkbyBzb21ldGhpbmcNCj4gPiA+IGxpa2Ug
dGhhdC4NCj4gPg0KPiA+IFRoZSBwcm9ibGVtIHdpdGggc2lnbmFscyBpcyB0aGF0IHRoZXkgY2Fu
bm90IHJldHVybiBhbiBlcnJvciwgYW5kIEkgZG8gdGhpbmsNCj4gd2XigJlkIHdhbnQgdG8gaGF2
ZSB0aGUgZGFlbW9uIHJldHVybiBhbiBlcnJvciBpZiBpdCBjYW5ub3Qgc2VuZCB0aGUgZ2l2ZW4N
Cj4gbWVzc2FnZS4gQWxzbywgYnkgZGVmYXVsdCBzaWduYWxzIGFyZSBicm9hZGNhc3QsIGFuZCBp
dCBmZWVscyBhIGJpdCBoYXdraXNoIHRvDQo+IGRvIHVuaWNhc3QgZGVzdGluYXRpb25zIGZvciB0
aGVtLg0KPiANCj4gV2VsbCB1bmljYXN0IHNpZ25hbHMgaXMgbm90IGEgbmV3IHRoaW5nLCB0aG91
Z2ggd2UgbmV2ZXIgdXNlZCBpdCB0aGF0IHdvdWxkIGJlDQo+IHBvc3NpYmxlIHRvIGRvIHNvbWV0
aGluZyBsaWtlIHRoYXQsIGFueXdheSBELUJ1cyBzaWduYWxzIGFyZSBzdWJzY3JpcHRpb24NCj4g
YmFzZWQgd2hpY2ggaXMgdGhlIHJlYXNvbiB3ZSBoYXZlbid0IGNvbnNpZGVyIGl0IHRvIGJlIHBy
b2JsZW0gdG8gZW1pdCBzaWduYWwNCj4gZm9yIFZhbHVlIGNoYW5nZXMgaW4gY2FzZSBvZiBHQVRU
IGF0dHJpYnV0ZXMsIHRoYXQgc2FpZCB0aGUgbGFjayBvZiBlcnJvciByZXN1bHQNCj4gY291bGQg
aW5kZWVkIGJlIGEgcHJvYmxlbSBidXQgc29tZSBvZiB0aGUgZXJyb3JzIGFyZSBhY3R1YWxseSBk
dWUgdG8gdGhlDQo+IGNoZWNraW5nIG9iamVjdF9wYXRoIGlzIHZhbGlkPw0KPiBPdGhlciBlcnJv
cnMgSW0gbm90IHN1cmUsIEl2ZSBhc3N1bWUgaWYgdGhlcmUgaXMgYSByZXNwb25zZSB0aGF0IHdv
dWxkIHRoZW4NCj4gY2FsbCBNZXNzYWdlUmVjZWl2ZWQsIGJ1dCBwZXJoYXBzIHdlIHdhbnQgdG8g
dmFsaWRhdGUgdGhlIHRyYW5zbWlzc2lvbg0KPiBpdHNlbGYsIGJ1dCBJIHRob3VnaCB0aGF0IHdh
c24ndCBwb3NzaWJsZSBpbiBCbHVlWi4NCg0KQWZ0ZXIgYSBudW1iZXIgb2YgbmVnb3RpYXRpb25z
LCB3ZSBkZWNpZGVkIG9uOg0KDQoqIE1ldGhvZHMgb24gRWxlbWVudCBPYmplY3QgUGF0aHMgZm9y
IGluY29taW5nIG1lc3NhZ2VzICAoZnJvbSANCk1lc2gtLT5EYWVtb24tLT5BcHApIGZvciBTZWN1
cml0eSBhbmQgZGlmZmVyZW50aWF0aW9uIGJldHdlZW4gZGVzdGluYXRpb24NCmVsZW1lbnRzIChh
biBBcHAgY2FuIGltcGxlbWVudCBtdWx0aXBsZSBlbGVtZW50cykuIFdoaWxlIHdlIG1heSBoYXZl
DQpiZWVuIGFibGUgdG8gZ2V0IFNpZ25hbHMgdG8gd29yayBTZWN1cmVseSwgdGhlIGRlbGl2ZXJ5
IG9mIGluY29taW5nIG1lc3NhZ2VzIGlzDQoqYWx3YXlzKiB0byBhICpzcGVjaWZpYyogZWxlbWVu
dCwgYW5kIHJlYWxseSBzaG91bGRuJ3QgYmUgdXNpbmcgYSBicm9hZGNhc3QgbWVjaGFuaXNtLg0K
DQoqIFVzaW5nIHRoZSBBcHAncyBlbGVtZW50IE9iamVjdCBwYXRoIGFzIHRoZSBwYXJhbSAoQXBw
IC0tPiBEYWVtb24gLS0+IE1lc2gpDQp0byBzcGVjaWZ5IHRoZSBTb3VyY2UgYWRkcmVzcy4gIFRo
aXMgd2FzIGRvbmUgdG8gbWluaW1pemUgdGhlIHVuaXF1ZSB3YXlzIG9mDQpyZWZlcnJpbmcgdG8g
dGhlIEVsZW1lbnQNCg0KDQoNCj4gDQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg==
