Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1BC3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DCC23429
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 19:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfH3TQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:16:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:46532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3TQp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 15:16:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 12:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="382111775"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2019 12:16:44 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 12:16:44 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0439.000;
 Fri, 30 Aug 2019 12:16:44 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: test AEAD at startup to check kernel
 support
Thread-Topic: [PATCH BlueZ v2] mesh: test AEAD at startup to check kernel
 support
Thread-Index: AQHVX2dPD80gpH0rfEOtheH/X9EA2acUhXSA
Date:   Fri, 30 Aug 2019 19:16:43 +0000
Message-ID: <10547c42fa76ca27abad0f9b56e044d2de0ef115.camel@intel.com>
References: <20190830191527.15962-1-brian.gix@intel.com>
In-Reply-To: <20190830191527.15962-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <31414F9F9BA5AC4DB9CFAAD217445618@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhpcyB2ZXJzaW9uIHNob3J0LWNpcmN1aXRzIHRlc3QgaWYgRUxMIHdhcyB1bmFibGUgdG8gYWxs
b2NhdGUgYW5kIGJpbmQgdG8gc29ja2V0Lg0KDQpPbiBGcmksIDIwMTktMDgtMzAgYXQgMTI6MTUg
LTA3MDAsIEJyaWFuIEdpeCB3cm90ZToNCj4gT25lIHRpbWUgdGVzdCBhdCBzdGFydHVwIHRvIGVu
c3VyZSBlaXRoZXIga2VybmVsIHZlcnNpb24gdjQuOSBvciBsYXRlciwNCj4gKm9yKiB0aGF0IHJl
cXVpcmVkIEFFUy1DQ00gc3VwcG9ydCBoYXMgYmVlbiBiYWNrLXBvcnRlZC4gSWYgc3VwcG9ydCBu
b3QNCj4gdGhlcmUsIGRhZW1vbiB3aWxsIHJ1biB3aXRob3V0IHByb3ZpZGluZyBELUJ1cyBzZXJ2
aWNlIG9yIGF0dGFjaGluZyB0bw0KPiBjb250cm9sbGVycyAocHJldmVudHMgc3lzdGVtZCB0aHJh
c2hpbmcpLg0KPiAtLS0NCj4gIG1lc2gvY3J5cHRvLmMgfCA1NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIG1lc2gvY3J5cHRvLmggfCAgMSAr
DQo+ICBtZXNoL21haW4uYyAgIHwgIDcgKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2MiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9jcnlwdG8uYyBiL21lc2gvY3J5
cHRvLmMNCj4gaW5kZXggYTZkYzdmZmUyLi5jZWJkZmZlNDUgMTAwNjQ0DQo+IC0tLSBhL21lc2gv
Y3J5cHRvLmMNCj4gKysrIGIvbWVzaC9jcnlwdG8uYw0KPiBAQCAtMTEzMCwzICsxMTMwLDU3IEBA
IGJvb2wgbWVzaF9jcnlwdG9fY2hlY2tfZmNzKGNvbnN0IHVpbnQ4X3QgKnBhY2tldCwgdWludDhf
dCBwYWNrZXRfbGVuLA0KPiAgDQo+ICAJcmV0dXJuIGZjcyA9PSAweGNmOw0KPiAgfQ0KPiArDQo+
ICsvKiBUaGlzIGZ1bmN0aW9uIHBlcmZvcm1zIGEgcXVpY2stY2hlY2sgb2YgRUxMIGFuZCBLZXJu
ZWwgQUVBRCBlbmNyeXB0aW9uLg0KPiArICogU29tZSBrZXJuZWwgdmVyc2lvbnMgYmVmb3JlIHY0
LjkgaGF2ZSBhIGtub3duIEFFQUQgYnVnLiBJZiB0aGUgc3lzdGVtDQo+ICsgKiBydW5uaW5nIHRo
aXMgdGVzdCBpcyB1c2luZyBhIHY0Ljggb3IgZWFybGllciBrZXJuZWwsIGEgZmFpbHVyZSBoZXJl
IGlzDQo+ICsgKiBsaWtlbHkgdW5sZXNzIEFFQUQgZW5jcnlwdGlvbiBoYXMgYmVlbiBiYWNrcG9y
dGVkLg0KPiArICovDQo+ICtzdGF0aWMgY29uc3QgdWludDhfdCBjcnlwdG9fdGVzdF9yZXN1bHRb
XSA9IHsNCj4gKwkweDc1LCAweDAzLCAweDdlLCAweGUyLCAweDg5LCAweDgxLCAweGJlLCAweDU5
LA0KPiArCTB4YmMsIDB4ZTYsIDB4ZGQsIDB4MjMsIDB4NjMsIDB4NWIsIDB4MTYsIDB4NjEsDQo+
ICsJMHhiNywgMHgyMywgMHg5MiwgMHhkNCwgMHg4NiwgMHhlZSwgMHg4NCwgMHgyOSwNCj4gKwkw
eDlhLCAweDJhLCAweGJmLCAweDk2DQo+ICt9Ow0KPiArDQo+ICtib29sIG1lc2hfY3J5cHRvX2No
ZWNrX2F2YWlsKCkNCj4gK3sNCj4gKwl2b2lkICpjaXBoZXI7DQo+ICsJYm9vbCByZXN1bHQ7DQo+
ICsJdWludDhfdCBpOw0KPiArCXVuaW9uIHsNCj4gKwkJc3RydWN0IHsNCj4gKwkJCXVpbnQ4X3Qg
a2V5WzE2XTsNCj4gKwkJCXVpbnQ4X3QgYWFkWzE2XTsNCj4gKwkJCXVpbnQ4X3Qgbm9uY2VbMTNd
Ow0KPiArCQkJdWludDhfdCBkYXRhWzIwXTsNCj4gKwkJCXVpbnQ4X3QgbWljWzhdOw0KPiArCQl9
IGNyeXB0bzsNCj4gKwkJdWludDhfdCBieXRlc1swXTsNCj4gKwl9IHU7DQo+ICsJdWludDhfdCBv
dXRfbXNnW3NpemVvZih1LmNyeXB0by5kYXRhKSArIHNpemVvZih1LmNyeXB0by5taWMpXTsNCj4g
Kw0KPiArCWxfZGVidWcoIlRlc3RpbmcgQ3J5cHRvIik7DQo+ICsJZm9yIChpID0gMDsgaSA8IHNp
emVvZih1KTsgaSsrKSB7DQo+ICsJCXUuYnl0ZXNbaV0gPSAweDYwICsgaTsNCj4gKwl9DQo+ICsN
Cj4gKwljaXBoZXIgPSBsX2FlYWRfY2lwaGVyX25ldyhMX0FFQURfQ0lQSEVSX0FFU19DQ00sIHUu
Y3J5cHRvLmtleSwNCj4gKwkJCQlzaXplb2YodS5jcnlwdG8ua2V5KSwgc2l6ZW9mKHUuY3J5cHRv
Lm1pYykpOw0KPiArDQo+ICsJaWYgKCFjaXBoZXIpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0K
PiArCXJlc3VsdCA9IGxfYWVhZF9jaXBoZXJfZW5jcnlwdChjaXBoZXIsDQo+ICsJCQkJdS5jcnlw
dG8uZGF0YSwgc2l6ZW9mKHUuY3J5cHRvLmRhdGEpLA0KPiArCQkJCXUuY3J5cHRvLmFhZCwgc2l6
ZW9mKHUuY3J5cHRvLmFhZCksDQo+ICsJCQkJdS5jcnlwdG8ubm9uY2UsIHNpemVvZih1LmNyeXB0
by5ub25jZSksDQo+ICsJCQkJb3V0X21zZywgc2l6ZW9mKG91dF9tc2cpKTsNCj4gKw0KPiArCWlm
IChyZXN1bHQpDQo+ICsJCXJlc3VsdCA9ICFtZW1jbXAob3V0X21zZywgY3J5cHRvX3Rlc3RfcmVz
dWx0LCBzaXplb2Yob3V0X21zZykpOw0KPiArDQo+ICsJbF9hZWFkX2NpcGhlcl9mcmVlKGNpcGhl
cik7DQo+ICsNCj4gKwlyZXR1cm4gcmVzdWx0Ow0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9j
cnlwdG8uaCBiL21lc2gvY3J5cHRvLmgNCj4gaW5kZXggMWE3M2JjYWEzLi5lNWNlODQwYjQgMTAw
NjQ0DQo+IC0tLSBhL21lc2gvY3J5cHRvLmgNCj4gKysrIGIvbWVzaC9jcnlwdG8uaA0KPiBAQCAt
MTYxLDMgKzE2MSw0IEBAIGJvb2wgbWVzaF9jcnlwdG9fY2hlY2tfZmNzKGNvbnN0IHVpbnQ4X3Qg
KnBhY2tldCwgdWludDhfdCBwYWNrZXRfbGVuLA0KPiAgCQkJCQkJCXVpbnQ4X3QgcmVjZWl2ZWRf
ZmNzKTsNCj4gIGJvb2wgbWVzaF9jcnlwdG9fYWVzX2NtYWMoY29uc3QgdWludDhfdCBrZXlbMTZd
LCBjb25zdCB1aW50OF90ICptc2csDQo+ICAJCQkJCXNpemVfdCBtc2dfbGVuLCB1aW50OF90IHJl
c1sxNl0pOw0KPiArYm9vbCBtZXNoX2NyeXB0b19jaGVja19hdmFpbCh2b2lkKTsNCj4gZGlmZiAt
LWdpdCBhL21lc2gvbWFpbi5jIGIvbWVzaC9tYWluLmMNCj4gaW5kZXggMjYyZTNkYTQ4Li4yNzM2
NTFmOTcgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWFpbi5jDQo+ICsrKyBiL21lc2gvbWFpbi5jDQo+
IEBAIC0zNCw2ICszNCw3IEBADQo+ICAjaW5jbHVkZSAibGliL21nbXQuaCINCj4gIA0KPiAgI2lu
Y2x1ZGUgIm1lc2gvbWVzaC5oIg0KPiArI2luY2x1ZGUgIm1lc2gvY3J5cHRvLmgiDQo+ICAjaW5j
bHVkZSAibWVzaC9kYnVzLmgiDQo+ICAjaW5jbHVkZSAibWVzaC9tZXNoLWlvLmgiDQo+ICANCj4g
QEAgLTEyMSw2ICsxMjIsMTIgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4g
IA0KPiAgCWxfbG9nX3NldF9zdGRlcnIoKTsNCj4gIA0KPiArCWlmICghbWVzaF9jcnlwdG9fY2hl
Y2tfYXZhaWwoKSkgew0KPiArCQlsX2Vycm9yKCJNZXNoIENyeXB0byBmdW5jdGlvbnMgdW5hdmFp
bGFibGUiKTsNCj4gKwkJc3RhdHVzID0gbF9tYWluX3J1bl93aXRoX3NpZ25hbChzaWduYWxfaGFu
ZGxlciwgTlVMTCk7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsNCj4gIAlmb3IgKDs7KSB7
DQo+ICAJCWludCBvcHQ7DQo+ICAJCWNvbnN0IGNoYXIgKnN0cjsNCg==
