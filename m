Return-Path: <SRS0=yF4w=T3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA2C04AB3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50A2147A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 18:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfE0SO0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 May 2019 14:14:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:21278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfE0SO0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 May 2019 14:14:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 11:14:25 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2019 11:14:25 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 27 May 2019 11:14:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.64]) with mapi id 14.03.0415.000;
 Mon, 27 May 2019 11:14:25 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Topic: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Index: AQHVEZBzEH3OQE0cFU+dUfs5UeuEwaZ5c+KA
Date:   Mon, 27 May 2019 18:14:24 +0000
Message-ID: <1558634183.332.19.camel@intel.com>
References: <20190523175321.13094-1-brian.gix@intel.com>
In-Reply-To: <20190523175321.13094-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.14.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF5209E9427E244A621851657462257@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIgYW5kIE1pY2hhbCwNCg0KSWYgeW91IGd1eXMgYXJlIE9LIHdpdGggdGhpcywgdGhp
cyBpcyB0aGUgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggb24gbG9uZyBNSUNzIGFuZCBzZWdtZW50IGNv
dW50IEkgd2lsbCBiZQ0KYXBwbHlpbmcuDQoNCk9uIFRodSwgMjAxOS0wNS0yMyBhdCAxMDo1MyAt
MDcwMCwgQnJpYW4gR2l4IHdyb3RlOg0KPiBGcm9tOiBKYWt1YiBXaXRvd3NraSA8amFrdWIud2l0
b3dza2lAc2lsdmFpci5jb20+DQo+IA0KPiBDb250cmFyeSB0byB0aGUgY29tbWVudCwgaW1wbGVt
ZW50YXRpb24gdXNlZCBhIDgtYnl0ZSBNSUMgZXZlbiBpZiB0aGlzDQo+IGdlbmVyYXRlZCBhbiBh
ZGRpdGlvbmFsIHNlZ21lbnQuDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwgNSArKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL21lc2gvbW9kZWwuYyBiL21lc2gvbW9kZWwuYw0KPiBpbmRleCAwMzRkNTQ0OTYu
LjkwYmI2MmRiOCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tb2RlbC5jDQo+ICsrKyBiL21lc2gvbW9k
ZWwuYw0KPiBAQCAtNDAsNiArNDAsOSBAQA0KPiAgI2luY2x1ZGUgIm1lc2gvdXRpbC5oIg0KPiAg
I2luY2x1ZGUgIm1lc2gvbW9kZWwuaCINCj4gIA0KPiArLyogRGl2aWRlIGFuZCByb3VuZCB0byBj
ZWlsaW5nICh1cCkgdG8gY2FsY3VsYXRlIHNlZ21lbnQgY291bnQgKi8NCj4gKyNkZWZpbmUgQ0VJ
TERJVih2YWwsIGRpdikgKCgodmFsKSArIChkaXYpIC0gMSkgLyAoZGl2KSkNCj4gKw0KPiAgc3Ry
dWN0IG1lc2hfbW9kZWwgew0KPiAgCWNvbnN0IHN0cnVjdCBtZXNoX21vZGVsX29wcyAqY2JzOw0K
PiAgCXZvaWQgKnVzZXJfZGF0YTsNCj4gQEAgLTQ1MSw3ICs0NTQsNyBAQCBzdGF0aWMgYm9vbCBt
c2dfc2VuZChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBib29sIGNyZWRlbnRpYWwsIHVpbnQxNl90
IHNyYywNCj4gIA0KPiAgCS8qIFVzZSBsYXJnZSBNSUMgaWYgaXQgZG9lc24ndCBhZmZlY3Qgc2Vn
bWVudGF0aW9uICovDQo+ICAJaWYgKG1zZ19sZW4gPiAxMSAmJiBtc2dfbGVuIDw9IDM3Nikgew0K
PiAtCQlpZiAoKG91dF9sZW4gLyAxMikgPT0gKChvdXRfbGVuICsgNCkgLyAxMikpIHsNCj4gKwkJ
aWYgKENFSUxESVYob3V0X2xlbiwgMTIpID09IENFSUxESVYob3V0X2xlbiArIDQsIDEyKSkgew0K
PiAgCQkJc3ptaWMgPSB0cnVlOw0KPiAgCQkJb3V0X2xlbiA9IG1zZ19sZW4gKyBzaXplb2YodWlu
dDY0X3QpOw0KPiAgCQl9
