Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43173C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 21:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23CE218D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 21:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCUV0m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:26:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:26987 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfCUV0m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 17:26:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 14:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="136312797"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 21 Mar 2019 14:26:41 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 14:26:41 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Correctly initialize node's vendor models
Thread-Topic: [PATCH BlueZ] mesh: Correctly initialize node's vendor models
Thread-Index: AQHU37hOQmT10NxrTUaH0IV78wJHCqYXD3KA
Date:   Thu, 21 Mar 2019 21:26:40 +0000
Message-ID: <1553203599.4237.0.camel@intel.com>
References: <20190321073240.23203-1-inga.stotland@intel.com>
In-Reply-To: <20190321073240.23203-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.84.223]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC80AF0CB293064D9C28060DB95C44BA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Q3JpdGljYWwgcGF0Y2ggYXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDMtMjEgYXQgMDA6MzIgLTA3
MDAsIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgdmVuZG9yIG1vZGVsIGluaXRp
YWxpemF0aW9uIGJhc2VkIG9uIG5vZGUgcHJvcGVydGllcw0KPiBjb2xsZWN0ZWQgZHVyaW5nIEpv
aW4oKSBtZXRob2QgY2FsbC4NCj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDE1ICsrKysrKysrKy0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDc2
MWE2N2FmNC4uOTk5ZDNiOGMwIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9t
ZXNoL25vZGUuYw0KPiBAQCAtMTE3NywxNyArMTE3NywyMCBAQCBzdGF0aWMgdm9pZCBhZGRfbW9k
ZWxfZnJvbV9wcm9wZXJ0aWVzKHN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZSwNCj4gIHN0YXRpYyB2
b2lkIGFkZF92ZW5kb3JfbW9kZWxfZnJvbV9wcm9wZXJ0aWVzKHN0cnVjdCBub2RlX2VsZW1lbnQg
KmVsZSwNCj4gIAkJCQkJc3RydWN0IGxfZGJ1c19tZXNzYWdlX2l0ZXIgKnByb3BlcnR5KQ0KPiAg
ew0KPiAtCXN0cnVjdCB7DQo+IC0JCXVpbnQxNl90IHY7DQo+IC0JCXVpbnQxNl90IG07DQo+IC0J
fSBpZF9wYWlyOw0KPiArCXN0cnVjdCBsX2RidXNfbWVzc2FnZV9pdGVyIGlkczsNCj4gKwl1aW50
MTZfdCB2Ow0KPiArCXVpbnQxNl90IG07DQo+ICANCj4gIAlpZiAoIWVsZS0+bW9kZWxzKQ0KPiAg
CQllbGUtPm1vZGVscyA9IGxfcXVldWVfbmV3KCk7DQo+ICANCj4gLQl3aGlsZSAobF9kYnVzX21l
c3NhZ2VfaXRlcl9uZXh0X2VudHJ5KHByb3BlcnR5LCAmaWRfcGFpcikpIHsNCj4gKwlpZiAoIWxf
ZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X3ZhcmlhbnQocHJvcGVydHksICJhKHFxKSIsICZpZHMpKQ0K
PiArCQlyZXR1cm47DQo+ICsNCj4gKwl3aGlsZSAobF9kYnVzX21lc3NhZ2VfaXRlcl9uZXh0X2Vu
dHJ5KCZpZHMsICZ2LCAmbSkpIHsNCj4gIAkJc3RydWN0IG1lc2hfbW9kZWwgKm1vZDsNCj4gLQkJ
bW9kID0gbWVzaF9tb2RlbF92ZW5kb3JfbmV3KGVsZS0+aWR4LCBpZF9wYWlyLnYsIGlkX3BhaXIu
bSk7DQo+ICsNCj4gKwkJbW9kID0gbWVzaF9tb2RlbF92ZW5kb3JfbmV3KGVsZS0+aWR4LCB2LCBt
KTsNCj4gIAkJbF9xdWV1ZV9wdXNoX3RhaWwoZWxlLT5tb2RlbHMsIG1vZCk7DQo+ICAJfQ0KPiAg
fQ==
