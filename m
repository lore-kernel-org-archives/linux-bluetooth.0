Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D52C0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C772189E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGDSB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:01:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:62241 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfGDSB5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 14:01:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 11:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="187628814"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2019 11:01:57 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 11:01:56 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.139]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 11:01:56 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix segmentation fault when removing a
 node
Thread-Topic: [PATCH BlueZ v2] mesh: Fix segmentation fault when removing a
 node
Thread-Index: AQHVMo74YiGZxIDp9UCN7cBlBGEhY6a7NVyA
Date:   Thu, 4 Jul 2019 18:01:55 +0000
Message-ID: <dc55b9a5a57528eb1eded86b4f053af38802520c.camel@intel.com>
References: <20190704173606.21793-1-inga.stotland@intel.com>
In-Reply-To: <20190704173606.21793-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.106]
Content-Type: text/plain; charset="utf-8"
Content-ID: <89FB6231F32EE246A04F2067990B9219@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpBcHBsaWVkIHdpdGggYWdyZWVkIHVwb24gbWlub3IgYWRqdXN0bWVudHMsIHdoaWNoIGhhdmUg
YmVlbiBidWlsZCBhbmQNCnJ1biB0ZXN0ZWQuDQoNCk9uIFRodSwgMjAxOS0wNy0wNCBhdCAxMDoz
NiAtMDcwMCwgSW5nYSBTdG90bGFuZCB3cm90ZToNCj4gVGhpcyBmaXhlcyBhIHNlZ21lbnRhdGlv
biBmYXVsdCBpbnRyb2R1Y2VkIGJ5IGVhcmxpZXIgY2hhbmdlcy4NCj4gU2VnbWVudGF0aW9uIGZh
dWx0IHdhcyB1c2VkIGJ5IGFjY2Vzc2luZyBhIHF1ZXUgdGhhdCBoYXMgYmVlbg0KPiBkZXN0cm95
ZWQsIGJ1dCB0aGUgY29ycmVzcG9uZGluZyBwb2ludGVyIGhhc24ndCBiZWVuIHNldCB0byBOVUxM
Lg0KPiAtLS0NCj4gIG1lc2gvbm9kZS5jIHwgNiArKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25v
ZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IGFkOTRkODg1Yy4uOGU5ZGE4OTg4IDEwMDY0NA0K
PiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtMjYwLDEyICsy
NjAsMTYgQEAgc3RhdGljIHZvaWQgZnJlZV9ub2RlX3Jlc291cmNlcyh2b2lkICpkYXRhKQ0KPiAg
CS8qIFVucmVnaXN0ZXIgaW8gY2FsbGJhY2tzICovDQo+ICAJaWYgKG5vZGUtPm5ldCkNCj4gIAkJ
bWVzaF9uZXRfZGV0YWNoKG5vZGUtPm5ldCk7DQo+ICsNCj4gIAltZXNoX25ldF9mcmVlKG5vZGUt
Pm5ldCk7DQo+ICsJbm9kZS0+bmV0ID0gTlVMTDsNCj4gIA0KPiAgCWxfcXVldWVfZGVzdHJveShu
b2RlLT5lbGVtZW50cywgZWxlbWVudF9mcmVlKTsNCj4gLQlsX2ZyZWUobm9kZS0+Y29tcCk7DQo+
ICsJbm9kZS0+ZWxlbWVudHMgPSBOVUxMOw0KPiAgDQo+ICAJZnJlZV9ub2RlX2RidXNfcmVzb3Vy
Y2VzKG5vZGUpOw0KPiArDQo+ICsJbF9mcmVlKG5vZGUtPmNvbXApOw0KPiAgCWxfZnJlZShub2Rl
KTsNCj4gIH0NCj4gIA0K
