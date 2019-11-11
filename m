Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE1C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920A020674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 18:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKS0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:26:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:38255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfKKS0r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 13:26:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 10:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="403968164"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2019 10:26:47 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.179]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 10:26:46 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Topic: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Index: AQHVmCZdXBBAWEQWS0mWNx1nWNJecqeG0PSA
Date:   Mon, 11 Nov 2019 18:26:46 +0000
Message-ID: <5ecf503ae4a6b1afb6f96ce9e09cd53cbf9a4c8f.camel@intel.com>
References: <20191111002407.32575-1-aurelien@aurel32.net>
In-Reply-To: <20191111002407.32575-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.190.74]
Content-Type: text/plain; charset="utf-8"
Content-ID: <14BC397D4680DA4181E7422D59CAB693@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQXVyZWxpZW4sDQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAwMToyNCArMDEwMCwgQXVyZWxp
ZW4gSmFybm8gd3JvdGU6DQo+IFRoaXMgaXMgYmFzaWNhbGx5IGEgY29weSBvZiBjbWRfYmluZCB3
aXRoIE9QX01PREVMX0FQUF9CSU5EIHJlcGxhY2VkIGJ5DQo+IE9QX01PREVMX0FQUF9VTkJJTkQg
YXMgY21kc1tdIGFscmVhZHkgaGFzIGNvZGUgdG8gaGFuZGxlIGl0Lg0KPiAtLS0NCj4gIHRvb2xz
L21lc2gvY2ZnY2xpLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvbWVzaC9jZmdjbGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggMDg2OTk4
OTEwLi5hNGRlNDI5NDMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysr
IGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0KPiBAQCAtODk3LDYgKzg5Nyw0MCBAQCBzdGF0aWMgdm9p
ZCBjbWRfYmluZChpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgCXJldHVybiBidF9zaGVsbF9u
b25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfU1VDQ0VTUyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2
b2lkIGNtZF91bmJpbmQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gK3sNCj4gKwl1aW50MTZf
dCBuOw0KPiArCXVpbnQ4X3QgbXNnWzMyXTsNCj4gKwlpbnQgcGFybV9jbnQ7DQo+ICsNCj4gKwlw
YXJtX2NudCA9IHJlYWRfaW5wdXRfcGFyYW1ldGVycyhhcmdjLCBhcmd2KTsNCj4gKwlpZiAocGFy
bV9jbnQgIT0gMyAmJiBwYXJtX2NudCAhPSA0KSB7DQo+ICsJCWJ0X3NoZWxsX3ByaW50ZigiQmFk
IGFyZ3VtZW50c1xuIik7DQo+ICsJCXJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0
KEVYSVRfRkFJTFVSRSk7DQo+ICsJfQ0KPiArDQo+ICsJbiA9IG1lc2hfb3Bjb2RlX3NldChPUF9N
T0RFTF9BUFBfVU5CSU5ELCBtc2cpOw0KPiArDQo+ICsJcHV0X2xlMTYocGFybXNbMF0sIG1zZyAr
IG4pOw0KPiArCW4gKz0gMjsNCj4gKwlwdXRfbGUxNihwYXJtc1sxXSwgbXNnICsgbik7DQo+ICsJ
biArPSAyOw0KPiArDQo+ICsJaWYgKHBhcm1fY250ID09IDQpIHsNCj4gKwkJcHV0X2xlMTYocGFy
bXNbM10sIG1zZyArIG4pOw0KPiArCQlwdXRfbGUxNihwYXJtc1syXSwgbXNnICsgbiArIDIpOw0K
PiArCQluICs9IDQ7DQo+ICsJfSBlbHNlIHsNCj4gKwkJcHV0X2xlMTYocGFybXNbMl0sIG1zZyAr
IG4pOw0KPiArCQluICs9IDI7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKCFjb25maWdfc2VuZChtc2cs
IG4sIE9QX01PREVMX0FQUF9VTkJJTkQpKQ0KPiArCQlyZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJh
Y3RpdmVfcXVpdChFWElUX0ZBSUxVUkUpOw0KPiArDQo+ICsJcmV0dXJuIGJ0X3NoZWxsX25vbmlu
dGVyYWN0aXZlX3F1aXQoRVhJVF9TVUNDRVNTKTsNCj4gK30NCg0KU2luY2UgY21kX2JpbmQoKSAm
IGFuZCBjbWRfdW5iaW5kKCkNCmFyZSB2aXJ0dWFsbHkgaWRlbnRpY2FsIHdpdGggdGhlIGV4Y2Vw
dGlvbiBvZiB0aGUgb3Bjb2RlLCBsZXQncyBjb21iaW5lDQp0aGVtIHRvIGNhbGwgb25lIHJvdXRp
bmUsIGUuZy4NCmNtZF9hZGRfYmluZGluZygpIGFuZCBjbWQgZGVsZXRlX2JpbmRpbmcoKSB3b3Vs
ZCBjYWxsDQpjbWRfYmluZChpbnQgYXJnYywgY2hhciphcmd2W10sIGludCBvcGNvZGUpDQoNCj4g
Kw0KPiAgc3RhdGljIHZvaWQgY21kX2JlYWNvbl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkN
Cj4gIHsNCj4gIAl1aW50MTZfdCBuOw0KPiBAQCAtMTMzNSw2ICsxMzY5LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBidF9zaGVsbF9tZW51IGNmZ19tZW51ID0gew0KPiAgCQkJCSJEZWxldGUgYXBw
bGljYXRpb24ga2V5In0sDQo+ICAJeyJiaW5kIiwgIjxlbGVfYWRkcj4gPGFwcF9pZHg+IDxtb2Rf
aWQ+IFt2ZW5kb3JfaWRdIiwgY21kX2JpbmQsDQo+ICAJCQkJIkJpbmQgYXBwIGtleSB0byBhIG1v
ZGVsIn0sDQo+ICsJeyJ1bmJpbmQiLCAiPGVsZV9hZGRyPiA8YXBwX2lkeD4gPG1vZF9pZD4gW3Zl
bmRvcl9pZF0iLCBjbWRfdW5iaW5kLA0KPiArCQkJCSJSZW1vdmUgYXBwIGtleSBmcm9tIGEgbW9k
ZWwifSwNCj4gIAl7Im1vZC1hcHBpZHgtZ2V0IiwgIjxlbGVfYWRkcj4gPG1vZGVsIGlkPiIsIGNt
ZF9tb2RfYXBwaWR4X2dldCwNCj4gIAkJCQkiR2V0IG1vZGVsIGFwcF9pZHgifSwNCj4gIAl7InR0
bC1zZXQiLCAiPHR0bD4iLCBjbWRfdHRsX3NldCwNCg0KQmVzdCByZWdhcmRzLA0KSW5nYQ0K
