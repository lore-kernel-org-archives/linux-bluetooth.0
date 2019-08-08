Return-Path: <SRS0=RGGC=WE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2200C433FF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E872173C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 18:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfHHS5y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:57:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:5508 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfHHS5x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Aug 2019 14:57:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 11:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="182683105"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 11:57:53 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 11:57:49 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Thu, 8 Aug 2019 11:57:49 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix double free of a pointer in
 mesh-io-generic
Thread-Topic: [PATCH BlueZ] mesh: Fix double free of a pointer in
 mesh-io-generic
Thread-Index: AQHVTVuoQgddiXFM+kuOEhx5dyyMU6byEPgA
Date:   Thu, 8 Aug 2019 18:57:48 +0000
Message-ID: <da2be8478867a386cab75fec400896bb9c006828.camel@intel.com>
References: <20190807200636.19614-1-inga.stotland@intel.com>
In-Reply-To: <20190807200636.19614-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.24.187]
Content-Type: text/plain; charset="utf-8"
Content-ID: <74A9D384D2CA1640B93BD4CB8A413629@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDgtMDcgYXQgMTM6MDYgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSBjcmFzaCBpbiBibHVldG9vdGgtbWVzaGQgZHVlIHRv
IGZyZWVpbmcgdGhlIHNhbWUgcG9pbnRlcg0KPiB0d2ljZS4gVGhlIGZpeCBpcyB0byBpbml0aWFs
aXplIHRoZSBhZGRyZXNzIG9mIGZyZWVkIFRYIGJ1ZmZlciB0byBOVUxMLg0KPiAtLS0NCj4gIG1l
c2gvbWVzaC1pby1nZW5lcmljLmMgfCAxMCArKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9t
ZXNoLWlvLWdlbmVyaWMuYyBiL21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4gaW5kZXggNTc2YzVk
ZjFiLi5jYzkxZjQ5NGUgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4g
KysrIGIvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0KPiBAQCAtNjU0LDggKzY1NCwxMiBAQCBzdGF0
aWMgYm9vbCB0eF9jYW5jZWwoc3RydWN0IG1lc2hfaW8gKmlvLCBjb25zdCB1aW50OF90ICpkYXRh
LCB1aW50OF90IGxlbikNCj4gIAkJCXR4ID0gbF9xdWV1ZV9yZW1vdmVfaWYocHZ0LT50eF9wa3Rz
LCBmaW5kX2J5X2FkX3R5cGUsDQo+ICAJCQkJCQkJTF9VSU5UX1RPX1BUUihkYXRhWzBdKSk7DQo+
ICAJCQlsX2ZyZWUodHgpOw0KPiArDQo+ICsJCQlpZiAodHggPT0gcHZ0LT50eCkNCj4gKwkJCQlw
dnQtPnR4ID0gTlVMTDsNCj4gKw0KPiAgCQl9IHdoaWxlICh0eCk7DQo+IC0JfSAgZWxzZSB7DQo+
ICsJfSBlbHNlIHsNCj4gIAkJc3RydWN0IHR4X3BhdHRlcm4gcGF0dGVybiA9IHsNCj4gIAkJCS5k
YXRhID0gZGF0YSwNCj4gIAkJCS5sZW4gPSBsZW4NCj4gQEAgLTY2NSw2ICs2NjksMTAgQEAgc3Rh
dGljIGJvb2wgdHhfY2FuY2VsKHN0cnVjdCBtZXNoX2lvICppbywgY29uc3QgdWludDhfdCAqZGF0
YSwgdWludDhfdCBsZW4pDQo+ICAJCQl0eCA9IGxfcXVldWVfcmVtb3ZlX2lmKHB2dC0+dHhfcGt0
cywgZmluZF9ieV9wYXR0ZXJuLA0KPiAgCQkJCQkJCQkmcGF0dGVybik7DQo+ICAJCQlsX2ZyZWUo
dHgpOw0KPiArDQo+ICsJCQlpZiAodHggPT0gcHZ0LT50eCkNCj4gKwkJCQlwdnQtPnR4ID0gTlVM
TDsNCj4gKw0KPiAgCQl9IHdoaWxlICh0eCk7DQo+ICAJfQ0KPiAgDQo=
