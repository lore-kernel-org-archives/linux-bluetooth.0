Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A509C5B578
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC369206A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGAUI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:08:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:41115 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAUI6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 16:08:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 13:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="362376754"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2019 13:08:57 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 13:08:57 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.237]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 13:08:57 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Thread-Topic: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Thread-Index: AQHVLbBTXkZCBJk6F0mOJ2IaxbXQY6axhQEAgAARy4CABRJpAIAAAmAA
Date:   Mon, 1 Jul 2019 20:08:56 +0000
Message-ID: <1562011734.458.14.camel@intel.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
         <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
         <20190628132932.bhcvcx4tzlfkertu@mlowasrzechonek2133>
         <1561732393.7802.50.camel@intel.com>
         <20190701200024.btxrfm2ndanzx7tm@kynes>
In-Reply-To: <20190701200024.btxrfm2ndanzx7tm@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D986203C798CE4A9827D335B8818A5F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gTW9uLCAyMDE5LTA3LTAxIGF0IDIyOjAwICswMjAwLCBtaWNoYWwu
bG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tIHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IE9u
IDA2LzI4LCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+IFVubGlrZSBBcHAgS2V5cywgRGV2aWNlIGtl
eXMgZG8gbm90IGhhdmUgYSBib3VuZCBOZXQgS2V5Li4uICBUaGV5IGNhbg0KPiA+IGJlIHNlbnQg
b24gKmFueSogbmV0d29yayBrZXkuICBTbyB3aGlsZSBzZW5kaW5nIGEgbWVzc2FnZSBvbiBhDQo+
ID4gc3BlY2lmaWMgQXBwIGluZGV4IGltcGxpZXMgdGhlIE5ldCBLZXkgdG8gdXNlLCB0aGUgRGV2
IEtleSBzZW5kIGRvZXMNCj4gPiBub3QsIGFuZCBzbyBuZWVkcyBpdCB0byBiZSBleHBsaWNpdC4N
Cj4gDQo+IEFmdGVyIGRpZ2dpbmcgdGhyb3VnaCB0aGUgY29kZSwgSSd2ZSBub3RpY2VkIHRoYXQg
YXQgdGhlIG1vbWVudA0KPiBibHVldG9vdGgtbWVzaGQgZG9lc24ndCByZWFsbHkgc3VwcG9ydCBz
ZW5kaW5nIG1lc3NhZ2VzIHVzaW5nDQo+IG5vbi1wcmltYXJ5IG5ldHdvcmsga2V5IC0gdGhpcyBp
cyBiZWNhdXNlIG9mIGludGVybmFsIEFQSSBsaW1pdGF0aW9ucw0KPiAoc2VlIHRoZSBUT0RPIG5l
eHQgdG8gc2VuZF9zZWcgZnVuY3Rpb24gaW4gbmV0LmMpLg0KPiANCj4gV291bGQgaXQgYmUgT0sg
Zm9yIG1lIHRvIHN0YXJ0IGltcGxlbWVudGluZyBTZW5kRGV2S2V5IEFQSSBpbiBhIHdheSB0aGF0
DQo+IGFsd2F5cyB1c2VzIHRoZSBwcmltYXJ5IHN1Ym5ldCwgbGlrZSBpdCdzIGN1cnJlbnRseSBk
b25lIHdpdGgNCj4gYXBwbGljYXRpb24ga2V5cz8gVGhlIHNhbWUgYXBwbGllcyB0byBjYWxsaW5n
IERldktleU1lc3NhZ2VSZWNlaXZlZCgpIG9uDQo+IHRoZSBhcHBsaWNhdGlvbiBzaWRlLg0KDQpX
aGVuIHRoaXMgY29kZSB3YXMgb3JpZ2luYWxseSB3cml0dGVuLCBpdCBvbmx5IHN1cHBvcnRlZCBh
IHNpbmdsZSBzdWJuZXQuDQoNCkkgaGF2ZSBubyBwcm9ibGVtIHdpdGggZnVuY3Rpb25hbGl0eSBi
ZWluZyBhZGRlZCBncmFkdWFsbHksIGJ1dCB3ZSBkbyBldmVudHVhbGx5DQpuZWVkIHRvIGJlIGFi
bGUgc2VuZCAqZXZlcnl0aGluZyogaW5jbHVkaW5nIGFsbCBzZWdtZW50cyBvbiB0aGUgcmVxdWVz
dGVkDQpzdWJuZXQgKG5vdCBuZWNjZXNzYXJpbHkgdGhlIHByaW1hcnkgc3VibmV0KS4gIEFuZCB0
aGVyZSB3aWxsIGJlIHRoZSBwcm9ibGVtIHRoYXQNCm5vZGVzIG1heSBleGlzdCB0aGF0IGRvIG5v
dCBldmVuIGhhdmUgdGhlIHByaW1hcnkgc3VibmV0IGtleS4NCg0KPiANCj4gSSBhbSBhd2FyZSB0
aGF0IGEgbm9kZSBpcyBzdXBwb3NlZCB0byByZXNwb25kIHVzaW5nIHRoZSBzYW1lIHN1Ym5ldCB0
aGF0DQo+IGEgcmVxdWVzdCB3YXMgc2VudCB0aHJvdWdoLCBidXQgaXQncyBub3QgdGhhdCBzaW1w
bGUgdG8gaW1wbGVtZW50IGluIG9uZQ0KPiBzaG90Li4uDQo+IA0KPiBJJ2QgdmVyeSBtdWNoIGxp
a2UgdG8gYWRkIHN1Ym5ldCBzdXBwb3J0IGFzIHdlbGwsIGJ1dCBzdWNoIGEgcGF0Y2ggd291bGQN
Cj4gYmUgbXVjaCwgbXVjaCBsYXJnZXIgLSBJIHRoaW5rIEkgd291bGQgbmVlZCB0byBtb2RpZnkg
aW50ZXJuYWwgQVBJcyB0bw0KPiB1c2UgbWVzaF9zdWJuZXQgc3RydWN0IGluc3RlYWQgb2YgbWVz
aF9uZXQsIGFuZCBkbyBpdCBpbiBtYW55LCBtYW55DQo+IHBsYWNlcy4NCg0KDQpGb3J3YXJkIHBy
b2dyZXNzIGlzIGZvcndhcmQgcHJvZ3Jlc3MuIEkgZG9uJ3QgdGhpbmsgYW55IGltcHJvdmVtZW50
cyB3aWxsIGJlDQpyZWplY3RlZCB1bmxlc3MgdGhleSBmdW5kdW1lbnRhbGx5IHJlc3RyaWN0IG91
ciBmdXR1cmUgYWJpbGl0eSB0byBtYWtlIHRoaW5ncw0KMTAwJSBjb3JyZWN0Lg0KDQoNCj4gDQo+
IHJlZ2FyZHM=
