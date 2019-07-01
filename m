Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D3C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372DD20B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfGAQeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:34:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:58424 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfGAQeF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 12:34:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="362318063"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2019 09:34:04 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.18]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 09:34:03 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Fix D-Bus node path
Thread-Topic: [PATCH BlueZ 1/2] mesh: Fix D-Bus node path
Thread-Index: AQHVLYtd4chBWbc+kkecZMNkYCipbKa2b9QA
Date:   Mon, 1 Jul 2019 16:34:03 +0000
Message-ID: <1561998840.458.3.camel@intel.com>
References: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <19DD32EA0D16B1409B51940F369D1F8E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBGcmksIDIwMTktMDYtMjggYXQgMTA6MjcgKzAyMDAsIE1pY2hh
xYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBBY2NvcmRpbmcgdG8gZG9jL21lc2gtYXBpLnR4
dCwgbm9kZSBvYmplY3Qgc2hvdWxkIGJlIGxvY2F0ZWQgYXQNCj4gL29yZy9ibHVlei9tZXNoL25v
ZGUuDQo+IC0tLQ0KPiAgbWVzaC9ub2RlLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9u
b2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCBjMmZlYWVlNTIuLjQ1MzgzYjdkNSAxMDA2NDQN
Cj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4gQEAgLTQ3LDcgKzQ3
LDYgQEANCj4gICNkZWZpbmUgTUlOX0NPTVBfU0laRSAxNA0KPiAgDQo+ICAjZGVmaW5lIE1FU0hf
Tk9ERV9QQVRIX1BSRUZJWCAiL25vZGUiDQo+IC0jZGVmaW5lIE1FU0hfRUxFTUVOVF9QQVRIX1BS
RUZJWCAiL2VsZSINCj4gIA0KPiAgLyogRGVmYXVsdCB2YWx1ZXMgZm9yIGEgbmV3IGxvY2FsbHkg
Y3JlYXRlZCBub2RlICovDQo+ICAjZGVmaW5lIERFRkFVTFRfTkVXX1VOSUNBU1QgMHgwMDAxDQo+
IEBAIC0xMDIxLDcgKzEwMjAsOCBAQCBzdGF0aWMgYm9vbCByZWdpc3Rlcl9ub2RlX29iamVjdChz
dHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiAgCWlmICghaGV4MnN0cihub2RlLT51dWlkLCBzaXpl
b2Yobm9kZS0+dXVpZCksIHV1aWQsIHNpemVvZih1dWlkKSkpDQo+ICAJCXJldHVybiBmYWxzZTsN
Cj4gIA0KPiAtCW5vZGUtPnBhdGggPSBsX3N0cmR1cF9wcmludGYoTUVTSF9OT0RFX1BBVEhfUFJF
RklYICIlcyIsIHV1aWQpOw0KPiArCW5vZGUtPnBhdGggPSBsX3N0cmR1cF9wcmludGYoQkxVRVpf
TUVTSF9QQVRIIE1FU0hfTk9ERV9QQVRIX1BSRUZJWA0KPiArCQkJCQkJCQkiJXMiLCB1dWlkKTsN
Cj4gIA0KPiAgCWlmICghbF9kYnVzX29iamVjdF9hZGRfaW50ZXJmYWNlKGRidXNfZ2V0X2J1cygp
LCBub2RlLT5wYXRoLA0KPiAgCQkJCQlNRVNIX05PREVfSU5URVJGQUNFLCBub2RlKSk=
