Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380BC43613
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51563204EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfFXQrf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:47:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:26055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfFXQrf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 12:47:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 09:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="163370502"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2019 09:47:30 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Jun 2019 09:47:05 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Mon, 24 Jun 2019 09:47:05 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH v3] mesh: Remove error code from Leave() in mesh-api.txt
Thread-Topic: [PATCH v3] mesh: Remove error code from Leave() in mesh-api.txt
Thread-Index: AQHVJoASfZGGhtCnDUmyj4u1ZSFYFaargT8A
Date:   Mon, 24 Jun 2019 16:47:05 +0000
Message-ID: <b9fb22c6ea5b39ad423a4ba1eee5a25cc48c2093.camel@intel.com>
References: <20190619091856.10557-1-jakub.witowski@silvair.com>
In-Reply-To: <20190619091856.10557-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.85.199]
Content-Type: text/plain; charset="utf-8"
Content-ID: <77FBE6F0F8FAFF4DA79257276669A37E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIGNoYW5nZXMNCg0KT24gV2VkLCAyMDE5LTA2LTE5IGF0IDExOjE4
ICswMjAwLCBKYWt1YiBXaXRvd3NraSB3cm90ZToNCj4gVGhpcyByZW1vdmVzIE5vdEZvdW5kIGVy
cm9yIGZyb20gbWVzaC1hcGkudHh0IGZyb20gTGVhdmUoKSBmdW5jdGlvbi4NCj4gLS0tDQo+ICBk
b2MvbWVzaC1hcGkudHh0IHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL21lc2gtYXBpLnR4dCBiL2RvYy9tZXNoLWFwaS50eHQN
Cj4gaW5kZXggMmE4MDA0NjhiLi5jODI3MzJkMmMgMTAwNjQ0DQo+IC0tLSBhL2RvYy9tZXNoLWFw
aS50eHQNCj4gKysrIGIvZG9jL21lc2gtYXBpLnR4dA0KPiBAQCAtMTEyLDggKzExMiw2IEBAIE1l
dGhvZHM6DQo+ICAJCWlkZW50aWZpZWQgYnkgdGhlIDY0LWJpdCB0b2tlbiBwYXJhbWV0ZXIuIFRo
ZSB0b2tlbg0KPiBwYXJhbWV0ZXINCj4gIAkJaGFzIGJlZW4gb2J0YWluZWQgYXMgYSByZXN1bHQg
b2Ygc3VjY2Vzc2Z1bCBKb2luKCkNCj4gbWV0aG9kIGNhbGwuDQo+ICANCj4gLQkJUG9zc2libGVF
cnJvcnM6DQo+IC0JCQlvcmcuYmx1ZXoubWVzaC5FcnJvci5Ob3RGb3VuZA0KPiAgDQo+ICAJdWlu
dDY0IHRva2VuIENyZWF0ZU5ldHdvcmsob2JqZWN0IGFwcF9yb290LCBhcnJheXtieXRlfVsxNl0N
Cj4gdXVpZCkNCj4gIA0K
