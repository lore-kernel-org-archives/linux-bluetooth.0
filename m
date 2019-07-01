Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02210C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACA82184B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfGAQHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:07:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:10500 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfGAQHK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 12:07:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="314929208"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2019 09:07:09 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 09:07:09 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.41]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 09:07:09 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH] mesh: Clear nodes queue on get_managed_objects_cb()
 fails
Thread-Topic: [PATCH] mesh: Clear nodes queue on get_managed_objects_cb()
 fails
Thread-Index: AQHVLZcNV787m5LxKUSe0mem916Kfqa2aDqA
Date:   Mon, 1 Jul 2019 16:07:08 +0000
Message-ID: <1561997227.458.1.camel@intel.com>
References: <20190628095049.10595-1-jakub.witowski@silvair.com>
In-Reply-To: <20190628095049.10595-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AB285C4BF208046829E8BAA5C651515@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQoNCkkgYW0gYXBwbHlpbmcgdGhpcywgYnV0IHBsZWFzZSBpbiB0aGUgZnV0dXJl
IHN1YmplY3QgdGFnIHlvdXIgQmx1ZVogbWVzaCBwYXRjaGVzIGFzIFtQQVRDSCBCbHVlWiA8Li4u
Pl0gc28gdGhhdA0KdGhleSBhcmUgZWFzaWVyIHRvIHNwb3QuDQoNCk9uIEZyaSwgMjAxOS0wNi0y
OCBhdCAxMTo1MCArMDIwMCwgSmFrdWIgV2l0b3dza2kgd3JvdGU6DQo+IEN1cnJlbnRseSB3aGVu
IHRoZSBnZXRfbWFuYWdlZF9vYmplY3RzX2NiKCkgZmFpbHMgaXQgZnJlZXMNCj4gdGhlIG5vZGUg
cmVzb3VyY2VzIGJ1dCB0aGUgbm9kZSBzdGlsbCByZW1haW5zIG9uIHRoZSAibm9kZXMiIHF1ZXVl
Lg0KPiANCj4gVGhpcyBpbXBsZW1lbnRhdGlvbiBjYWxscyBub2RlX3JlbW92ZSgpIGluc3RlYWQg
b2YNCj4gZnJlZV9ub2RlX3Jlc291cmNlcygpLiINCj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5jIGIvbWVzaC9ub2RlLmMNCj4gaW5kZXggNGUzNWJi
M2ZmLi4yMjI5YWE3MTEgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbm9kZS5jDQo+ICsrKyBiL21lc2gv
bm9kZS5jDQo+IEBAIC0xNjAxLDcgKzE2MDEsNyBAQCBmYWlsOg0KPiAgCX0gZWxzZSB7DQo+ICAJ
CS8qIEhhbmRsZSBmYWlsZWQgSm9pbiBhbmQgQ3JlYXRlIHJlcXVlc3RzICovDQo+ICAJCWlmIChu
b2RlKQ0KPiAtCQkJZnJlZV9ub2RlX3Jlc291cmNlcyhub2RlKTsNCj4gKwkJCW5vZGVfcmVtb3Zl
KG5vZGUpOw0KPiAgDQo+ICAJCWlmIChyZXEtPnR5cGUgPT0gUkVRVUVTVF9UWVBFX0pPSU4pIHsN
Cj4gIAkJCW5vZGVfam9pbl9yZWFkeV9mdW5jX3QgY2IgPSByZXEtPmNiOw==
