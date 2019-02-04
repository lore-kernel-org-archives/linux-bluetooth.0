Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21297C282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C420821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfBDULP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:11:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:12297 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfBDULP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:11:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:11:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="115234171"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2019 12:11:14 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 12:11:14 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.39]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 12:11:14 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Hedberg, Johan" <johan.hedberg@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add MGMT bypass when specifying controller
Thread-Topic: [PATCH BlueZ] mesh: Add MGMT bypass when specifying controller
Thread-Index: AQHUuaaaNCWL3riFqkWg18Q3D//RuqXQnlsA
Date:   Mon, 4 Feb 2019 20:11:13 +0000
Message-ID: <1549311072.22761.3.camel@intel.com>
References: <20190131205022.6689-1-brian.gix@intel.com>
In-Reply-To: <20190131205022.6689-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E224F4A1726EA47AADD0DA8A33ED0FB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpBcHBsaWVkDQoNCk9uIFRodSwgMjAxOS0wMS0zMSBhdCAxMjo1MCAtMDgwMCwgQnJpYW4gR2l4
IHdyb3RlOg0KPiBJZiBEYWVtb24gaXMgc3RhcnRlZCB3aXRoIGFuIGV4cGxpY2l0IGNvbnRyb2xs
ZXIgc3BlY2lmaWVkLCB0aGUNCj4gTUdNVCBzZWFyY2ggZm9yIGFuIHVudXNlZCBzaGFyZWQgY29u
dHJvbGxlciBpcyBieXBhc3NlZCwgYW5kDQo+IHRoZSBjb250cm9sbGVyIGlzIG9wZW5lZCBkaXJl
Y3RseS4NCj4gLS0tDQo+ICBtZXNoL21lc2guYyB8IDIwICsrKysrKysrKysrKystLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9tZXNoL21lc2guYyBiL21lc2gvbWVzaC5jDQo+IGluZGV4IDg4MWI2ZWQ3
My4uZTQ5NjUzZWY4IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2guYw0KPiArKysgYi9tZXNoL21l
c2guYw0KPiBAQCAtMzA0LDcgKzMwNCw3IEBAIGJvb2wgbWVzaF9pbml0KHVpbnQxNl90IGluZGV4
LCBjb25zdCBjaGFyICpjb25maWdfZGlyKQ0KPiAgCWlmIChpbml0aWFsaXplZCkNCj4gIAkJcmV0
dXJuIHRydWU7DQo+ICANCj4gLQlpZiAoIWluaXRfbWdtdCgpKSB7DQo+ICsJaWYgKGluZGV4ID09
IE1HTVRfSU5ERVhfTk9ORSAmJiAhaW5pdF9tZ210KCkpIHsNCj4gIAkJbF9lcnJvcigiRmFpbGVk
IHRvIGluaXRpYWxpemUgbWVzaCBtYW5hZ2VtZW50Iik7DQo+ICAJCXJldHVybiBmYWxzZTsNCj4g
IAl9DQo+IEBAIC0zMjYsMTIgKzMyNiwxOCBAQCBib29sIG1lc2hfaW5pdCh1aW50MTZfdCBpbmRl
eCwgY29uc3QgY2hhciAqY29uZmlnX2RpcikNCj4gIAlpZiAoIXN0b3JhZ2VfbG9hZF9ub2Rlcyhj
b25maWdfZGlyKSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IC0JbF9kZWJ1Zygic2VuZCBy
ZWFkIGluZGV4X2xpc3QiKTsNCj4gLQlpZiAobWdtdF9zZW5kKG1nbXRfbWVzaCwgTUdNVF9PUF9S
RUFEX0lOREVYX0xJU1QsDQo+IC0JCQkJTUdNVF9JTkRFWF9OT05FLCAwLCBOVUxMLA0KPiAtCQkJ
CXJlYWRfaW5kZXhfbGlzdF9jYiwgTlVMTCwgTlVMTCkgPD0gMCkNCj4gLQkJcmV0dXJuIGZhbHNl
Ow0KPiAtDQo+ICsJaWYgKGluZGV4ID09IE1HTVRfSU5ERVhfTk9ORSkgew0KPiArCQkvKiBVc2Ug
TUdNVCB0byBmaW5kIGEgY2FuZGlkYXRlIGNvbnRyb2xsZXIgKi8NCj4gKwkJbF9kZWJ1Zygic2Vu
ZCByZWFkIGluZGV4X2xpc3QiKTsNCj4gKwkJaWYgKG1nbXRfc2VuZChtZ210X21lc2gsIE1HTVRf
T1BfUkVBRF9JTkRFWF9MSVNULA0KPiArCQkJCQlNR01UX0lOREVYX05PTkUsIDAsIE5VTEwsDQo+
ICsJCQkJCXJlYWRfaW5kZXhfbGlzdF9jYiwgTlVMTCwgTlVMTCkgPD0gMCkNCj4gKwkJCXJldHVy
biBmYWxzZTsNCj4gKwl9IGVsc2Ugew0KPiArCQkvKiBPcGVuIHNwZWNpZmllZCBjb250cm9sbGVy
IHdpdGhvdXQgc2VhcmNoaW5nICovDQo+ICsJCXN0YXJ0X2lvKG1lc2gucmVxX2luZGV4KTsNCj4g
KwkJcmV0dXJuIG1lc2guaW8gIT0gTlVMTDsNCj4gKwl9DQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9
DQo+ICA=
