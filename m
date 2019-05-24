Return-Path: <SRS0=vizm=TY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25FC072B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0AF20862
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 15:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbfEXPGn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 May 2019 11:06:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:29604 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388995AbfEXPGm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 May 2019 11:06:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:06:42 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2019 08:06:42 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.200]) with mapi id 14.03.0415.000;
 Fri, 24 May 2019 08:06:42 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Topic: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Thread-Index: AQHVEZBzEH3OQE0cFU+dUfs5UeuEwaZ61swA
Date:   Fri, 24 May 2019 15:06:42 +0000
Message-ID: <1558710400.332.20.camel@intel.com>
References: <20190523175321.13094-1-brian.gix@intel.com>
In-Reply-To: <20190523175321.13094-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.78.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCD4884CC8263A4F9E359F204A68ED55@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDUtMjMgYXQgMTA6NTMgLTA3MDAsIEJyaWFu
IEdpeCB3cm90ZToNCj4gRnJvbTogSmFrdWIgV2l0b3dza2kgPGpha3ViLndpdG93c2tpQHNpbHZh
aXIuY29tPg0KPiANCj4gQ29udHJhcnkgdG8gdGhlIGNvbW1lbnQsIGltcGxlbWVudGF0aW9uIHVz
ZWQgYSA4LWJ5dGUgTUlDIGV2ZW4gaWYgdGhpcw0KPiBnZW5lcmF0ZWQgYW4gYWRkaXRpb25hbCBz
ZWdtZW50Lg0KPiAtLS0NCj4gIG1lc2gvbW9kZWwuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9t
ZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXggMDM0ZDU0NDk2Li45MGJiNjJkYjgg
MTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4gQEAg
LTQwLDYgKzQwLDkgQEANCj4gICNpbmNsdWRlICJtZXNoL3V0aWwuaCINCj4gICNpbmNsdWRlICJt
ZXNoL21vZGVsLmgiDQo+ICANCj4gKy8qIERpdmlkZSBhbmQgcm91bmQgdG8gY2VpbGluZyAodXAp
IHRvIGNhbGN1bGF0ZSBzZWdtZW50IGNvdW50ICovDQo+ICsjZGVmaW5lIENFSUxESVYodmFsLCBk
aXYpICgoKHZhbCkgKyAoZGl2KSAtIDEpIC8gKGRpdikpDQo+ICsNCj4gIHN0cnVjdCBtZXNoX21v
ZGVsIHsNCj4gIAljb25zdCBzdHJ1Y3QgbWVzaF9tb2RlbF9vcHMgKmNiczsNCj4gIAl2b2lkICp1
c2VyX2RhdGE7DQo+IEBAIC00NTEsNyArNDU0LDcgQEAgc3RhdGljIGJvb2wgbXNnX3NlbmQoc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSwgYm9vbCBjcmVkZW50aWFsLCB1aW50MTZfdCBzcmMsDQo+ICAN
Cj4gIAkvKiBVc2UgbGFyZ2UgTUlDIGlmIGl0IGRvZXNuJ3QgYWZmZWN0IHNlZ21lbnRhdGlvbiAq
Lw0KPiAgCWlmIChtc2dfbGVuID4gMTEgJiYgbXNnX2xlbiA8PSAzNzYpIHsNCj4gLQkJaWYgKChv
dXRfbGVuIC8gMTIpID09ICgob3V0X2xlbiArIDQpIC8gMTIpKSB7DQo+ICsJCWlmIChDRUlMRElW
KG91dF9sZW4sIDEyKSA9PSBDRUlMRElWKG91dF9sZW4gKyA0LCAxMikpIHsNCj4gIAkJCXN6bWlj
ID0gdHJ1ZTsNCj4gIAkJCW91dF9sZW4gPSBtc2dfbGVuICsgc2l6ZW9mKHVpbnQ2NF90KTsNCj4g
IAkJfQ==
