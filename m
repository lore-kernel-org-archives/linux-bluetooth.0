Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756AC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3D1205F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANWKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:36012 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfANWKx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="267098517"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2019 14:10:53 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 14 Jan 2019 14:10:52 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.53]) with mapi id 14.03.0415.000;
 Mon, 14 Jan 2019 14:10:52 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Fix reading device UUID from Join() call
Thread-Topic: [PATCH BlueZ 1/2] mesh: Fix reading device UUID from Join()
 call
Thread-Index: AQHUqiBFybfqiK4HfUutuf8rxrUpxaWv3d8A
Date:   Mon, 14 Jan 2019 22:10:52 +0000
Message-ID: <1547503850.32139.2.camel@intel.com>
References: <20190112024055.9967-1-inga.stotland@intel.com>
In-Reply-To: <20190112024055.9967-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.233]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A13103D24845F478960E121669EC881@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpQYXRjaCBBcHBsaWVkDQoNCk9uIEZyaSwgMjAxOS0wMS0xMSBhdCAxODo0MCAtMDgwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gU3VwcGx5IGNvcnJlY3QgcGFyYW1ldGVycyB0byBsX2RidXNf
bWVzc2FnZV9pdGVyX2dldF9maXhlZF9hcnJheQ0KPiB0byBnZXQgdGhlIGxvY2F0aW9uIGZyb20g
d2hlcmUgdG8gcmVhZCBVVUlEIHZhbHVlLg0KPiAtLS0NCj4gIG1lc2gvbWVzaC5jIHwgNSArKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbWVzaC5jIGIvbWVzaC9tZXNoLmMNCj4gaW5kZXggMTY5ZTZm
NDJjLi44OTcxZjdjYzQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC5jDQo+ICsrKyBiL21lc2gv
bWVzaC5jDQo+IEBAIC01NjQsNiArNTY0LDcgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2Fn
ZSAqam9pbl9uZXR3b3JrX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIHsNCj4gIAljb25z
dCBjaGFyICphcHBfcGF0aCwgKnNlbmRlcjsNCj4gIAlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRl
ciBpdGVyX3V1aWQ7DQo+ICsJdWludDhfdCAqdXVpZDsNCj4gIAl1aW50MzJfdCBuOw0KPiAgDQo+
ICAJbF9kZWJ1ZygiSm9pbiBuZXR3b3JrIHJlcXVlc3QiKTsNCj4gQEAgLTU3OCw3ICs1NzksNyBA
QCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpqb2luX25ldHdvcmtfY2FsbChzdHJ1Y3Qg
bF9kYnVzICpkYnVzLA0KPiAgDQo+ICAJam9pbl9wZW5kaW5nID0gbF9uZXcoc3RydWN0IGpvaW5f
ZGF0YSwgMSk7DQo+ICANCj4gLQlsX2RidXNfbWVzc2FnZV9pdGVyX2dldF9maXhlZF9hcnJheSgm
aXRlcl91dWlkLCBqb2luX3BlbmRpbmctPnV1aWQsICZuKTsNCj4gKwlsX2RidXNfbWVzc2FnZV9p
dGVyX2dldF9maXhlZF9hcnJheSgmaXRlcl91dWlkLCAmdXVpZCwgJm4pOw0KPiAgDQo+ICAJaWYg
KG4gIT0gMTYpIHsNCj4gIAkJbF9mcmVlKGpvaW5fcGVuZGluZyk7DQo+IEBAIC01ODcsNiArNTg4
LDggQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqam9pbl9uZXR3b3JrX2NhbGwoc3Ry
dWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAkJCQkJCQkiQmFkIGRldmljZSBVVUlEIik7DQo+ICAJfQ0K
PiAgDQo+ICsJbWVtY3B5KGpvaW5fcGVuZGluZy0+dXVpZCwgdXVpZCwgMTYpOw0KPiArDQo+ICAJ
c2VuZGVyID0gbF9kYnVzX21lc3NhZ2VfZ2V0X3NlbmRlcihtc2cpOw0KPiAgDQo+ICAJam9pbl9w
ZW5kaW5nLT5zZW5kZXIgPSBsX3N0cmR1cChzZW5kZXIpOw==
