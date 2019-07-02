Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB87C06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEF021721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 17:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBRuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:50:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:20870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBRuN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 13:50:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,444,1557212400"; 
   d="scan'208";a="362716296"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2019 10:50:12 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 10:50:11 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.250]) with mapi id 14.03.0439.000;
 Tue, 2 Jul 2019 10:50:11 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Allow to set-up the CRPL with application
Thread-Topic: [PATCH BlueZ v2] mesh: Allow to set-up the CRPL with
 application
Thread-Index: AQHVMNIiDyCxeeGHHEC+glSOhhg2EKa4EOEA
Date:   Tue, 2 Jul 2019 17:50:10 +0000
Message-ID: <1562089808.23933.0.camel@intel.com>
References: <20190702123141.19673-1-jakub.witowski@silvair.com>
In-Reply-To: <20190702123141.19673-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.20.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25828178D13F0048891BCF6B1BD5E2AD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMDctMDIgYXQgMTQ6MzEgKzAyMDAsIEpha3Vi
IFdpdG93c2tpIHdyb3RlOg0KPiBUaGlzIGFkZHMgYW4gb3B0aW9uYWwgQ1JQTCBwcm9wZXJ0eSB0
byBvcmcuYmx1ZXoubWVzaC5BcHBsaWNhdGlvbjENCj4gaW50ZXJmYWNlLCBhbGxvd2luZyB0byBp
bmRpY2F0ZSB0aGUgZGVwdGggb2YgcmVwbHkgcHJvdGVjdGlvbiBsaXN0Lg0KPiAtLS0NCj4gIGRv
Yy9tZXNoLWFwaS50eHQgfCAgNCArKysrDQo+ICBtZXNoL25vZGUuYyAgICAgIHwgMTggKysrKysr
KysrKysrKy0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL21lc2gtYXBpLnR4dCBiL2RvYy9tZXNo
LWFwaS50eHQNCj4gaW5kZXggNGUwYThiZmYxLi44OTNhMWE2YzAgMTAwNjQ0DQo+IC0tLSBhL2Rv
Yy9tZXNoLWFwaS50eHQNCj4gKysrIGIvZG9jL21lc2gtYXBpLnR4dA0KPiBAQCAtNzI0LDYgKzcy
NCwxMCBAQCBQcm9wZXJ0aWVzOg0KPiAgDQo+ICAJCUEgMTYtYml0IHZlbmRvci1hc3NpZ25lZCBw
cm9kdWN0IHZlcnNpb24gaWRlbnRpZmllcg0KPiAgDQo+ICsJdWludDE2IENSUEwgW3JlYWQtb25s
eSwgb3B0aW9uYWxdDQo+ICsNCj4gKwkJQSAxNi1iaXQgbWluaW11bSBudW1iZXIgb2YgcmVwbGF5
IHByb3RlY3Rpb24gbGlzdCBlbnRyaWVzDQo+ICsNCj4gIA0KPiAgTWVzaCBFbGVtZW50IEhpZXJh
cmNoeQ0KPiAgPT09PT09PT09PT09PT09PT09PT09PQ0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9ub2Rl
LmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCA3MzgzNzkzZDkuLmFkYzJhYTkzZSAxMDA2NDQNCj4g
LS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4gQEAgLTEzMTIsMTAgKzEz
MTIsNiBAQCBzdGF0aWMgYm9vbCBjcmVhdGVfbm9kZV9jb25maWcoc3RydWN0IG1lc2hfbm9kZSAq
bm9kZSkNCj4gIHN0YXRpYyB2b2lkIHNldF9kZWZhdWx0cyhzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
KQ0KPiAgew0KPiAgCS8qIFRPRE86IHRoZXNlIHZhbHVlcyBzaG91bGQgY29tZSBmcm9tIG1lc2gu
Y29uZiAqLw0KPiAtCWlmICghbm9kZS0+Y29tcCkNCj4gLQkJbm9kZS0+Y29tcCA9IGxfbmV3KHN0
cnVjdCBub2RlX2NvbXBvc2l0aW9uLCAxKTsNCj4gLQ0KPiAtCW5vZGUtPmNvbXAtPmNycGwgPSBE
RUZBVUxUX0NSUEw7DQo+ICAJbm9kZS0+bHBuID0gTUVTSF9NT0RFX1VOU1VQUE9SVEVEOw0KPiAg
CW5vZGUtPnByb3h5ID0gTUVTSF9NT0RFX1VOU1VQUE9SVEVEOw0KPiAgCW5vZGUtPmZyaWVuZCA9
IE1FU0hfTU9ERV9VTlNVUFBPUlRFRDsNCj4gQEAgLTEzMzgsOCArMTMzNCwxMCBAQCBzdGF0aWMg
Ym9vbCBnZXRfYXBwX3Byb3BlcnRpZXMoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgY29uc3QgY2hh
ciAqcGF0aCwNCj4gIA0KPiAgCWxfZGVidWcoInBhdGggJXMiLCBwYXRoKTsNCj4gIA0KPiAtCWlm
IChpc19uZXcpDQo+ICsJaWYgKGlzX25ldykgew0KPiAgCQlub2RlLT5jb21wID0gbF9uZXcoc3Ry
dWN0IG5vZGVfY29tcG9zaXRpb24sIDEpOw0KPiArCQlub2RlLT5jb21wLT5jcnBsID0gREVGQVVM
VF9DUlBMOw0KPiArCX0NCj4gIA0KPiAgCXdoaWxlIChsX2RidXNfbWVzc2FnZV9pdGVyX25leHRf
ZW50cnkocHJvcGVydGllcywgJmtleSwgJnZhcmlhbnQpKSB7DQo+ICANCj4gQEAgLTEzNzIsNiAr
MTM3MCwxNiBAQCBzdGF0aWMgYm9vbCBnZXRfYXBwX3Byb3BlcnRpZXMoc3RydWN0IG1lc2hfbm9k
ZSAqbm9kZSwgY29uc3QgY2hhciAqcGF0aCwNCj4gIAkJCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4g
IAkJCW5vZGUtPmNvbXAtPnZpZCA9IHZhbHVlOw0KPiArDQo+ICsJCX0gZWxzZSBpZiAoIXN0cmNt
cChrZXksICJDUlBMIikpIHsNCj4gKwkJCWlmICghbF9kYnVzX21lc3NhZ2VfaXRlcl9nZXRfdmFy
aWFudCgmdmFyaWFudCwgInEiLA0KPiArCQkJCQkJCQkJJnZhbHVlKSkNCj4gKwkJCQlyZXR1cm4g
ZmFsc2U7DQo+ICsNCj4gKwkJCWlmICghaXNfbmV3ICYmIG5vZGUtPmNvbXAtPmNycGwgIT0gdmFs
dWUpDQo+ICsJCQkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJCQlub2RlLT5jb21wLT5jcnBsID0g
dmFsdWU7DQo+ICAJCX0NCj4gIAl9DQo+ICA=
