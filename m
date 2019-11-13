Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA3C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5954206E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKMRdP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:33:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:63260 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKMRdP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 12:33:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="404684560"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2019 09:33:14 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 Nov 2019 09:33:13 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.179]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.11]) with mapi id 14.03.0439.000;
 Wed, 13 Nov 2019 09:33:13 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] shared/shell: Add prompt item to bt_shell_menu
 structure
Thread-Topic: [PATCH BlueZ] shared/shell: Add prompt item to bt_shell_menu
 structure
Thread-Index: AQHViWSBZsccn0MUSUSJoZ/ZgrGI2qeKBCsA
Date:   Wed, 13 Nov 2019 17:33:13 +0000
Message-ID: <35ef6466f21e861809ddd89a04019d98ce869918.camel@intel.com>
References: <20191023054119.7712-1-inga.stotland@intel.com>
In-Reply-To: <20191023054119.7712-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.228.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <72193958246A8748A53E47CBEC0854AE@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KT24gVHVlLCAyMDE5LTEwLTIyIGF0IDIyOjQxIC0wNzAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBUaGlzIGFsbG93cyB0byBhc3NvY2lhdGUgc3BlY2lmaWMgcHJvbXB0cyB3
aXRoIG1haW4gbWVudQ0KPiBhbmQgc3VibWVudXMgdGh1cyBwcm92aWRpbmcgZm9yIGJldHRlciBu
YXZpZ2F0aW9uIHdoZW4NCj4gc3VibWVudXMgYXJlIGluIHVzZS4NCj4gLS0tDQo+ICBzcmMvc2hh
cmVkL3NoZWxsLmMgfCAzICsrKw0KPiAgc3JjL3NoYXJlZC9zaGVsbC5oIHwgMSArDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NyYy9zaGFy
ZWQvc2hlbGwuYyBiL3NyYy9zaGFyZWQvc2hlbGwuYw0KPiBpbmRleCBjZmRjYzc2YzQuLmE4MjFj
OGQwYSAxMDA2NDQNCj4gLS0tIGEvc3JjL3NoYXJlZC9zaGVsbC5jDQo+ICsrKyBiL3NyYy9zaGFy
ZWQvc2hlbGwuYw0KPiBAQCAtMTIyNiw2ICsxMjI2LDkgQEAgYm9vbCBidF9zaGVsbF9zZXRfbWVu
dShjb25zdCBzdHJ1Y3QgYnRfc2hlbGxfbWVudSAqbWVudSkNCj4gIAlpZiAoIWRhdGEubWFpbikN
Cj4gIAkJZGF0YS5tYWluID0gbWVudTsNCj4gIA0KPiArCWlmIChtZW51LT5wcm9tcHQpDQo+ICsJ
CWJ0X3NoZWxsX3NldF9wcm9tcHQobWVudS0+cHJvbXB0KTsNCj4gKw0KPiAgCXJldHVybiB0cnVl
Ow0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9zcmMvc2hhcmVkL3NoZWxsLmggYi9zcmMvc2hh
cmVkL3NoZWxsLmgNCj4gaW5kZXggZTE0ZDU4MzgxLi5hOWVlZTUwNmYgMTAwNjQ0DQo+IC0tLSBh
L3NyYy9zaGFyZWQvc2hlbGwuaA0KPiArKysgYi9zcmMvc2hhcmVkL3NoZWxsLmgNCj4gQEAgLTUz
LDYgKzUzLDcgQEAgc3RydWN0IGJ0X3NoZWxsX21lbnVfZW50cnkgew0KPiAgc3RydWN0IGJ0X3No
ZWxsX21lbnUgew0KPiAgCWNvbnN0IGNoYXIgKm5hbWU7DQo+ICAJY29uc3QgY2hhciAqZGVzYzsN
Cj4gKwljb25zdCBjaGFyICpwcm9tcHQ7DQo+ICAJY29uc3Qgc3RydWN0IGJ0X3NoZWxsX21lbnVf
ZW50cnkgZW50cmllc1tdOw0KPiAgfTsNCj4gIA0KDQpEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHMg
Zm9yIHRoaXMgcGF0Y2g/DQoNCkJlc3QgcmVnYXJkcywNCkluZ2ENCg==
