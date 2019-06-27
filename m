Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE53C48BD9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 17:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1DA20659
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 17:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF0RUh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:20:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:59490 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF0RUh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 13:20:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 10:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="170488629"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2019 10:20:36 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 10:20:36 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.81]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 10:20:36 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 1/2] mesh: Fixed handling of IVI flag in app
 layer
Thread-Topic: [PATCH BlueZ v3 1/2] mesh: Fixed handling of IVI flag in app
 layer
Thread-Index: AQHVLLun/UkyRLA3qk+2vV86WCLBk6awNSMA
Date:   Thu, 27 Jun 2019 17:20:36 +0000
Message-ID: <1561656034.7802.7.camel@intel.com>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
         <20190627074043.22891-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190627074043.22891-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E381C635F58964E8285101D4BCADB5B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggYXBwbGllZCwgVGhhbmtzLg0KDQoNCk9uIFRodSwgMjAxOS0wNi0yNyBhdCAwOTo0MCAr
MDIwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IFNpbmNlIElWIEluZGV4IGlz
IHVzZWQgaW4gYXBwbGljYXRpb24gbm9uY2VzLCB3ZSBuZWVkIHRvIGhvbm9yIElWSSBmbGFnDQo+
IG5vdCBvbmx5IGluIG5ldHdvcmsgbGF5ZXIgY3J5cHRvLCBidXQgYWxzbyBpbiBhcHBsaWNhdGlv
biBsYXllci4NCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCBpZiBJVkkgZmllbGQgb2YgaW5jb21pbmcg
cGFja2V0IGlzIGRpZmZlcmVudCB0aGFuIGluDQo+IGN1cnJlbnQgSVYgSW5kZXgsIHRyeSB0byBk
ZWNvZGUgKmJvdGgqIG5ldCBhbmQgYXBwIGxheWVycyB1c2luZyBJViBJbmRleA0KPiBkZWNyZWFz
ZWQgYnkgb25lLg0KPiAtLS0NCj4gIG1lc2gvbmV0LWtleXMuYyB8ICA2IC0tLS0tLQ0KPiAgbWVz
aC9uZXQuYyAgICAgIHwgMTcgKysrKysrKystLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNo
L25ldC1rZXlzLmMgYi9tZXNoL25ldC1rZXlzLmMNCj4gaW5kZXggMjVmNGNhZWI3Li41YmU3ZTBi
NTggMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LWtleXMuYw0KPiArKysgYi9tZXNoL25ldC1rZXlz
LmMNCj4gQEAgLTIwOSwxMiArMjA5LDYgQEAgc3RhdGljIHZvaWQgZGVjcnlwdF9uZXRfcGt0KHZv
aWQgKmEsIHZvaWQgKmIpDQo+ICB1aW50MzJfdCBuZXRfa2V5X2RlY3J5cHQodWludDMyX3QgaXZf
aW5kZXgsIGNvbnN0IHVpbnQ4X3QgKnBrdCwgc2l6ZV90IGxlbiwNCj4gIAkJCQkJdWludDhfdCAq
KnBsYWluLCBzaXplX3QgKnBsYWluX2xlbikNCj4gIHsNCj4gLQlib29sIGl2X2ZsYWcgPSAhIShp
dl9pbmRleCAmIDEpOw0KPiAtCWJvb2wgaXZfcGt0ID0gISEocGt0WzBdICYgMHg4MCk7DQo+IC0N
Cj4gLQlpZiAoaXZfcGt0ICE9IGl2X2ZsYWcpDQo+IC0JCWl2X2luZGV4LS07DQo+IC0NCj4gIAkv
KiBJZiB3ZSBhbHJlYWR5IHN1Y2Nlc3NmdWxseSBkZWNyeXB0ZWQgdGhpcyBwYWNrZXQsIHVzZSBj
YWNoZWQgZGF0YSAqLw0KPiAgCWlmIChjYWNoZV9pZCAmJiBjYWNoZV9sZW4gPT0gbGVuICYmICFt
ZW1jbXAocGt0LCBjYWNoZV9wa3QsIGxlbikpIHsNCj4gIAkJLyogSVYgSW5kZXggbXVzdCBtYXRj
aCB3aGF0IHdhcyB1c2VkIHRvIGRlY3J5cHQgKi8NCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMg
Yi9tZXNoL25ldC5jDQo+IGluZGV4IGE1OTdiODc5NC4uYTU2OTNmMTU0IDEwMDY0NA0KPiAtLS0g
YS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTI0ODksOCArMjQ4OSwxMyBA
QCBzdGF0aWMgdm9pZCBuZXRfcngodm9pZCAqbmV0X3B0ciwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAg
CXNpemVfdCBvdXRfc2l6ZTsNCj4gIAl1aW50MzJfdCBrZXlfaWQ7DQo+ICAJaW50OF90IHJzc2kg
PSAwOw0KPiArCWJvb2wgaXZpX25ldCA9ICEhKG5ldC0+aXZfaW5kZXggJiAxKTsNCj4gKwlib29s
IGl2aV9wa3QgPSAhIShkYXRhLT5kYXRhWzBdICYgMHg4MCk7DQo+ICANCj4gLQlrZXlfaWQgPSBu
ZXRfa2V5X2RlY3J5cHQobmV0LT5pdl9pbmRleCwgZGF0YS0+ZGF0YSwgZGF0YS0+bGVuLA0KPiAr
CS8qIGlmIElWSSBmbGFnIGRpZmZlcnMsIHVzZSBwcmV2aW91cyBJViBJbmRleCAqLw0KPiArCXVp
bnQzMl90IGl2X2luZGV4ID0gbmV0LT5pdl9pbmRleCAtIChpdmlfcGt0IF4gaXZpX25ldCk7DQo+
ICsNCj4gKwlrZXlfaWQgPSBuZXRfa2V5X2RlY3J5cHQoaXZfaW5kZXgsIGRhdGEtPmRhdGEsIGRh
dGEtPmxlbiwNCj4gIAkJCQkJCQkmb3V0LCAmb3V0X3NpemUpOw0KPiAgDQo+ICAJaWYgKCFrZXlf
aWQpDQo+IEBAIC0yNTA0LDE2ICsyNTA5LDEwIEBAIHN0YXRpYyB2b2lkIG5ldF9yeCh2b2lkICpu
ZXRfcHRyLCB2b2lkICp1c2VyX2RhdGEpDQo+ICAJCXJzc2kgPSBkYXRhLT5pbmZvLT5yc3NpOw0K
PiAgCX0NCj4gIA0KPiAtCXJlbGF5X2FkdmljZSA9IHBhY2tldF9yZWNlaXZlZChuZXQsIGtleV9p
ZCwgbmV0LT5pdl9pbmRleCwNCj4gKwlyZWxheV9hZHZpY2UgPSBwYWNrZXRfcmVjZWl2ZWQobmV0
LCBrZXlfaWQsIGl2X2luZGV4LA0KPiAgCQkJCQkJCW91dCwgb3V0X3NpemUsIHJzc2kpOw0KPiAg
CWlmIChyZWxheV9hZHZpY2UgPiBkYXRhLT5yZWxheV9hZHZpY2UpIHsNCj4gLQkJYm9vbCBpdl9m
bGFnID0gISEobmV0LT5pdl9pbmRleCAmIDEpOw0KPiAtCQlib29sIGl2X3BrdCA9ICEhKGRhdGEt
PmRhdGFbMF0gJiAweDgwKTsNCj4gLQ0KPiAtCQlkYXRhLT5pdl9pbmRleCA9IG5ldC0+aXZfaW5k
ZXg7DQo+IC0JCWlmIChpdl9wa3QgIT0gaXZfZmxhZykNCj4gLQkJCWRhdGEtPml2X2luZGV4LS07
DQo+IC0NCj4gKwkJZGF0YS0+aXZfaW5kZXggPSBpdl9pbmRleDsNCj4gIAkJZGF0YS0+cmVsYXlf
YWR2aWNlID0gcmVsYXlfYWR2aWNlOw0KPiAgCQlkYXRhLT5rZXlfaWQgPSBrZXlfaWQ7DQo+ICAJ
CWRhdGEtPm5ldCA9IG5ldDs=
