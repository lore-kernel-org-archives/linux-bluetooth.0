Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD9AC04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1B120873
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfEMRwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 13:52:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:14223 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbfEMRwS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 13:52:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 10:52:17 -0700
X-ExtLoop1: 1
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2019 10:52:17 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 13 May 2019 10:52:16 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.165]) with mapi id 14.03.0415.000;
 Mon, 13 May 2019 10:52:16 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH] mesh: Fixed log MIC usage in segmented messages
Thread-Topic: [PATCH] mesh: Fixed log MIC usage in segmented messages
Thread-Index: AQHVBKZS2sQpr8zIAkip0y6azOvvyqZpvQQAgAAYOoA=
Date:   Mon, 13 May 2019 17:52:16 +0000
Message-ID: <601bf03c527f7033335c4930b4c3afafb8a154f1.camel@intel.com>
References: <20190507072702.27144-1-michal.lowas-rzechonek@silvair.com>
         <DEBB0CAA2616974FAE35E4B560B9A4376CB4EE08@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CB4EE08@ORSMSX103.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.97.124]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA41B875F5D22439B211C2B8F3BF321@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsICYgSmFrdWIsDQoNCk9uIE1vbiwgMjAxOS0wNS0xMyBhdCAwOToyNSAtMDcwMCwg
R2l4LCBCcmlhbiB3cm90ZToNCj4gSGkgTWljaGFsICYgSmFrdWIsDQo+IA0KPiANCj4gRnJvbTog
TWljaGFsIExvd2FzLVJ6ZWNob25law0KPiANCj4gKyNkZWZpbmUgQ0VJTERJVih2YWwsIGRpdikg
KCgodmFsKSAvIChkaXYpKSArICgodmFsKSAlIChkaXYpICE9IDApKQ0KPiArDQo+IA0KPiANCj4g
DQo+ICAJLyogVXNlIGxhcmdlIE1JQyBpZiBpdCBkb2Vzbid0IGFmZmVjdCBzZWdtZW50YXRpb24g
Ki8NCj4gIAlpZiAobXNnX2xlbiA+IDExICYmIG1zZ19sZW4gPD0gMzc2KSB7DQo+IC0JCWlmICgo
b3V0X2xlbiAvIDEyKSA9PSAoKG91dF9sZW4gKyA0KSAvIDEyKSkgew0KPiArCQlpZiAoQ0VJTERJ
VihvdXRfbGVuLCAxMikgPT0gQ0VJTERJVihvdXRfbGVuICsgNCwgMTIpKSB7DQo+ICAJCQlzem1p
YyA9IHRydWU7DQo+ICAJCQlvdXRfbGVuID0gbXNnX2xlbiArIHNpemVvZih1aW50NjRfdCk7DQo+
ICAJCX0NCj4gDQo+IEkgc2VlIHdoYXQgeW91IGFyZSBkb2luZyBoZXJlLCBhbmQgYWdyZWUgdGhh
dCBpdCB3aWxsIGZpeCBhDQo+IHByb2JsZW0uLi4gZm9yIGluc3RhbmNlIHdpdGggb3V0X2xlbiA9
PSAyMA0KPiANCj4gSSBhbSB1bmNvbWZvcnRhYmxlIHdpdGggdHdvIHRoaW5nczoNCj4gDQo+IDEu
IFRoZSBuYW1lIENFSUxESVYuLi4gICBJIGZvdW5kIGEgZGVmaW5pdGlvbiBmb3IgaXQgKGRpdmlk
ZSBhbmQNCj4gcm91bmQgdXApIGJ1dCBJIHRoaW5rIGl0IHBlcmhhcHMgZWl0aGVyIHRoZSBtYWNy
byBzaG91bGQgYmUgcmVuYW1lZA0KPiBzb21ldGhpbmcgbGlrZSAiU0VHX0NPVU5UIiAgKm9yKiBh
IGNvbW1lbnQgYWRkZWQgZGVmaW5pbmcgd2hhdA0KPiBDRUlMRElWIG1lYW5zIGZvciB0aGUgdW5p
bml0aWF0ZWQgKGxpa2UgbWUpOg0KPiANCj4gLyogQ0VJTERJVigpIGlzIGEgRGl2aWRlIGFuZCBS
b3VuZCBVcCBtYWNybyAqLw0KPiANCj4gDQo+IA0KPiAyLiBVc2luZyBhIEJvb2xlYW4gcmVzdWx0
IGFzIGFuIEludGVnZXIgZm9yIGFkZGl0aW9uIG1ha2VzIHRoZSBtYWNybw0KPiBhIGJpdCBkaWZm
aWN1bHQgdG8gcHV6emxlIG91dCwgaWYgeW91IGRvbid0IGtub3cgd2hhdCBpdCBpcyB0cnlpbmcg
dG8NCj4gZG8uDQo+IA0KPiBXaGF0IGFib3V0Og0KPiAoKCh2YWwpIC8gKGRpdikpICsgKCgodmFs
KSAlIChkaXYpKSA/IDEgOiAwKSkNCj4gDQo+IA0KDQpJIGJlbGlldmUgdGhlIHN0YW5kYXJkIHdh
eSBvZiBpbXBsZW1lbnRpbmcgImRpdmlkZSBhbmQgcm91bmQgdXAgdG8NCmNlaWxpbmciIGlzOg0K
DQooKCh2YWwpICsgKGRpdikgLSAxKSAvIChkaXYpKQ0KDQpTaWRlIG5vdGU6IHNpbmNlIGluIHRo
ZSBwYXJ0aWN1bGFyIGNvbnRleHQgb2Ygd2hlcmUgdGhpcyBtYWNybyBpcyBnb2luZw0KdG8gYmUg
Y2FsbGVkLCB0aGUgdmFsdWVzIG9mIGJvdGggdmFsIGFuZCBkaXYgYXJlIHBvc2l0aXZlIGFuZCBo
YXZlIGJlZW4NCnZldHRlZCBub3QgdG8gZXhjZWVkIHRoZSB1cHBlciBsaW1pdCBvZiBtZXNoIHBh
eWxvYWQgbGVuZ3RoLCB0aGVyZSdzIG5vDQpkYW5nZXIgb2YgYW4gb3ZlcmZsb3cgYW5kIHRoZSBt
YWNybyBkb2VzIG5vdCByZXF1aXJlIGFueSBhZGRpdGlvbmFsDQpjaGVja3MuDQoNCkJlc3QsDQoN
CkluZ2ENCg==
