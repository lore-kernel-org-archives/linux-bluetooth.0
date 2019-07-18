Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C6C7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6632082F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGRRIR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:08:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:27929 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRRIR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 13:08:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 10:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,278,1559545200"; 
   d="scan'208";a="168323661"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2019 10:08:15 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.225]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 10:08:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Thread-Topic: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Thread-Index: AQHVPR16GZYb6Nxn8UK5gNi+3g77/6bREeAA
Date:   Thu, 18 Jul 2019 17:08:14 +0000
Message-ID: <1563469692.8708.2.camel@intel.com>
References: <20190718040126.5152-1-inga.stotland@intel.com>
In-Reply-To: <20190718040126.5152-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.137.82]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A78F40ECE47F8348AED2E4CC7F3AAD06@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDctMTcgYXQgMjE6MDEgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgYWRkcyBpbml0aWFsaXphdGlvbiBvZiBrZXlyaW5nIHN0b3JhZ2Ug
ZGlyZWN0b3J5IHdoZW4NCj4gYSBtZXNoIG5vZGUgaXMgYXR0YWNoZWQgc3VjY2Vzc2Z1bGx5Lg0K
PiAtLS0NCj4gIG1lc2gvbm9kZS5jIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbm9kZS5jIGIvbWVzaC9ub2Rl
LmMNCj4gaW5kZXggNjUyNTUxNzU2Li42Yjc4NGJmOGQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbm9k
ZS5jDQo+ICsrKyBiL21lc2gvbm9kZS5jDQo+IEBAIC0xNjU2LDYgKzE2NTYsMTQgQEAgc3RhdGlj
IHZvaWQgZ2V0X21hbmFnZWRfb2JqZWN0c19jYihzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZywg
dm9pZCAqdXNlcl9kYXRhKQ0KPiAgCQl9IGVsc2UNCj4gIAkJCWdvdG8gZmFpbDsNCj4gIA0KPiAr
CQkvKg0KPiArCQkgKiBUT0RPOiBGb3Igbm93IGFsd2F5cyBpbml0aWFsaXplIGRpcmVjdG9yeSBm
b3Igc3RvcmluZw0KPiArCQkgKiBrZXlyaW5nIGluZm8uIE5lZWQgdG8gZmlndXJlIG91dCB3aGF0
IGNoZWNrcyBuZWVkDQo+ICsJCSAqIHRvIGJlIHBlcmZvcm1lZCB0byBkbyB0aGlzIGNvbmRpdGlv
bmFsbHksIGkuZS4sIHByZXNlbmNlIG9mDQo+ICsJCSAqIFByb3Zpc2lvbmVyIGludGVyZmFjZSwg
ZXRjLg0KPiArCQkgKi8NCj4gKwkJaW5pdF9zdG9yYWdlX2Rpcihub2RlKTsNCj4gKw0KPiAgCX0g
ZWxzZSBpZiAocmVxLT50eXBlID09IFJFUVVFU1RfVFlQRV9KT0lOKSB7DQo+ICAJCW5vZGVfam9p
bl9yZWFkeV9mdW5jX3QgY2IgPSByZXEtPmNiOw0KPiAg
