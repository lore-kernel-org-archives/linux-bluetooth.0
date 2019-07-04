Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5963C5B578
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760DD218A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGDAQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:16:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:17875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfGDAQ0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 20:16:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 17:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="154906754"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2019 17:16:25 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 17:16:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 17:16:24 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Fix checks when restoring internal
 model state
Thread-Topic: [PATCH BlueZ 1/1] mesh: Fix checks when restoring internal
 model state
Thread-Index: AQHVMeFmXXFPZUQemUmDaI9VSaaKpaa6DQEA
Date:   Thu, 4 Jul 2019 00:16:24 +0000
Message-ID: <1562199382.23933.39.camel@intel.com>
References: <20190703205341.11065-1-inga.stotland@intel.com>
In-Reply-To: <20190703205341.11065-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.20.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <558BFE3F62E45949A0635E9AE09F8BC1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDctMDMgYXQgMTM6NTMgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgaW5jb3JyZWN0IGNvbmRpdGlvbmFsIGNoZWNrcyBpbiBy
ZXN0b3JlX21vZGVsX3N0YXRlKCkNCj4gd2hpY2ggY291bGQgbGVhZCB0byBkZXJlZmVyZW5jaW5n
IGEgTlVMTCBwb2ludGVyLg0KPiANCj4gV3Jvbmc6IGlmIChsX3F1ZXVlX2lzZW1wdHkobW9kLT5i
aW5kaW5ncykgfHwgIW1vZC0+Y2JzLT5iaW5kKSAuLi4NCj4gRml4ZWQ6IGlmICghbF9xdWV1ZV9p
c2VtcHR5KG1vZC0+YmluZGluZ3MpICYmIGNicy0+YmluZCkgLi4uDQo+IC0tLQ0KPiAgbWVzaC9t
b2RlbC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5jDQo+
IGluZGV4IGEyYjNlNWMxOC4uZTRhN2JhOTRlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMN
Cj4gKysrIGIvbWVzaC9tb2RlbC5jDQo+IEBAIC0xMDc3LDcgKzEwNzcsNyBAQCBzdGF0aWMgdm9p
ZCByZXN0b3JlX21vZGVsX3N0YXRlKHN0cnVjdCBtZXNoX21vZGVsICptb2QpDQo+ICAJaWYgKCFj
YnMpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCWlmIChsX3F1ZXVlX2lzZW1wdHkobW9kLT5iaW5k
aW5ncykgfHwgIW1vZC0+Y2JzLT5iaW5kKSB7DQo+ICsJaWYgKCFsX3F1ZXVlX2lzZW1wdHkobW9k
LT5iaW5kaW5ncykgJiYgY2JzLT5iaW5kKSB7DQo+ICAJCWZvciAoYiA9IGxfcXVldWVfZ2V0X2Vu
dHJpZXMobW9kLT5iaW5kaW5ncyk7IGI7IGIgPSBiLT5uZXh0KSB7DQo+ICAJCQlpZiAoY2JzLT5i
aW5kKExfUFRSX1RPX1VJTlQoYi0+ZGF0YSksIEFDVElPTl9BREQpICE9DQo+ICAJCQkJCQkJTUVT
SF9TVEFUVVNfU1VDQ0VTUyk=
