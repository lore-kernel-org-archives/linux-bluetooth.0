Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195BC7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA735208C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfGRRHT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:07:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:58138 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRRHT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 13:07:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 10:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,278,1559545200"; 
   d="scan'208";a="169910462"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2019 10:07:16 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 10:07:15 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.92]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 10:07:15 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/3] mesh: Propagate/Preserve Net Index for Access
 Layer
Thread-Topic: [PATCH BlueZ 0/3] mesh: Propagate/Preserve Net Index for
 Access Layer
Thread-Index: AQHVPCnN7GZVkTB90kKQ7Q5uwGiHh6bRE4GA
Date:   Thu, 18 Jul 2019 17:07:14 +0000
Message-ID: <1563469633.8708.0.camel@intel.com>
References: <20190716225644.11449-1-brian.gix@intel.com>
In-Reply-To: <20190716225644.11449-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.137.82]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2933B6E0D0BD8469D4FAA98F192F855@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gVHVlLCAyMDE5LTA3LTE2IGF0IDE1OjU2IC0wNzAwLCBC
cmlhbiBHaXggd3JvdGU6DQo+IFR3byBtYWpvciBmbGF3cyBhcmUgY29ycmVjdGVkIGJ5IHRoaXMg
cGF0Y2gtc2V0Og0KPiANCj4gMS4gVGhlIFNwZWMgZGVmaW5lZCBBY2Nlc3MgTGF5ZXIgQUlEIHdh
cyBiZWluZyBjb25mdXNlZCB3aXRoIHRoZSBpbnRlcm5hbGx5IHVzZWQNCj4ga2V5X2lkIHdoaWNo
IGlzIHVzZWQgdG8gaWRlbnRpZnkgTmV0d29yayBrZXlzIGZvciBtdWx0aXBsZSBuZXR3b3JrcywN
Cj4gc3ViLW5ldHdvcmtzLCBhbmQgZnJpZW5kc2hpcHMuIFRoaXMgY29uZnVzZWQgSUQgd2FzIHRo
ZW4gYmVpbmcgdXNlZCBpbnN0ZWFkDQo+IG9mIHRoZSBjb3JyZWN0IE5ldHdvcmsgS2V5IElEIGZv
ciBvdXRnb2luZyBtZXNzYWdlcy4NCj4gDQo+IDIuIFRoZSBzcGVjaWZpY2F0aW9uIHJlcXVpcmVz
ICpyZXNwb25zZXMqIHRvIGFsbCBzdGFuZGFyZCBTZXJ2ZXIgbWVzc2FnZXMgdG8NCj4gYmUgc2Vu
dCB3aXRoIHRoZSBzYW1lIGNyZWRlbnRpYWxzIGFzIHRoZSByZWNlaXZlZCBjb21tYW5kIHRoYXQg
dHJpZ2dlcmVkIHRoZW0uDQo+IFRoaXMgcmVxdWlyZXMgbW9yZSBjb21wbGV0ZSBwcm9wYWdhdGlv
biBvZiB0aGUgTmV0IEluZGV4IHZhbHVlIG9uIHJlY2VpdmVkDQo+IG1lc3NhZ2VzLCBzbyB0aGF0
IHRoZSBzYW1lIE5ldHdvcmsga2V5IGlzIHVzZWQgaW4gdGhlIHJldmVyc2UgZGlyZWN0aW9uLg0K
PiANCj4gVGhpcyBhZGRpdGlvbmFsbHkgbm93IHVzZXMgdGhlIHJlcXVlc3RlZCBOZXQgSW5kZXgg
d2hlbiBzZW5kaW5nIERldmljZSBLZXkNCj4gc2VjdXJlZCBtZXNzYWdlcyB0aHJvdWdoIHRoZSBE
LUJ1cyBpbnRlcmZhY2UuDQo+IA0KPiBCcmlhbiBHaXggKDMpOg0KPiAgIG1lc2g6IEFkZCBib3Vu
ZCBOZXQgSW5kZXggbG9va3VwIGZvciBBcHAgS2V5cw0KPiAgIG1lc2g6IE5vcm1hbGl6ZSBBY2Nl
c3MgS2V5IEFJRCBuYW1pbmcgY29udmVudGlvbg0KPiAgIG1lc2g6IFByb3BhZ2F0ZSBOZXQgSW5k
ZXggdXAgUnggbWVzc2FnZSBjaGFpbg0KPiANCj4gIG1lc2gvYXBwa2V5LmMgICAgICAgIHwgIDU5
ICsrKysrKysrKysrKystLS0tLS0tDQo+ICBtZXNoL2FwcGtleS5oICAgICAgICB8ICAgMSArDQo+
ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDE1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIG1lc2gvY3J5cHRvLmMgICAgICAgIHwgIDM3ICsr
KysrKy0tLS0tLS0NCj4gIG1lc2gvY3J5cHRvLmggICAgICAgIHwgICA4ICstLQ0KPiAgbWVzaC9t
b2RlbC5jICAgICAgICAgfCAxMjkgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICBtZXNoL21vZGVsLmggICAgICAgICB8ICAxMCArKy0tDQo+ICBtZXNoL25ldC5j
ICAgICAgICAgICB8ICA5MiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gIG1lc2gv
bmV0LmggICAgICAgICAgIHwgIDEwICsrLS0NCj4gIG1lc2gvbm9kZS5jICAgICAgICAgIHwgIDEw
ICsrLS0NCj4gIDEwIGZpbGVzIGNoYW5nZWQsIDI3NiBpbnNlcnRpb25zKCspLCAyMzQgZGVsZXRp
b25zKC0pDQo+IA==
