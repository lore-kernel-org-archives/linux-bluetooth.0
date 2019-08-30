Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0813DC3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4F2342C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH3SiQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:38:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:51858 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfH3SiQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 14:38:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 11:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="382100685"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2019 11:38:15 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 11:38:15 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.159]) with mapi id 14.03.0439.000;
 Fri, 30 Aug 2019 11:38:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: test AEAD at startup to check kernel support
Thread-Topic: [PATCH BlueZ] mesh: test AEAD at startup to check kernel
 support
Thread-Index: AQHVX1nbcH4977aSOkC5p5Ds5SLWIqcUdqAAgAAELgA=
Date:   Fri, 30 Aug 2019 18:38:14 +0000
Message-ID: <2524316a625d8a51cc6a51fe512e4fef94a036c4.camel@intel.com>
References: <20190830173902.19953-1-brian.gix@intel.com>
         <20190830182316.fo3nmzfvzk55rhnj@kynes>
In-Reply-To: <20190830182316.fo3nmzfvzk55rhnj@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2178A0AD2AB6B34AB0591C0BD6289316@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTMwIGF0IDIwOjIzICswMjAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25l
ayB3cm90ZToNCj4gQnJpYW4sDQo+IA0KPiBPbiAwOC8zMCwgQnJpYW4gR2l4IHdyb3RlOg0KPiA+
IE9uZSB0aW1lIHRlc3QgYXQgc3RhcnR1cCB0byBlbnN1cmUgZWl0aGVyIGtlcm5lbCB2ZXJzaW9u
IHY0Ljkgb3IgbGF0ZXIsDQo+ID4gKm9yKiB0aGF0IHJlcXVpcmVkIEFFUy1DQ00gc3VwcG9ydCBo
YXMgYmVlbiBiYWNrLXBvcnRlZC4gSWYgc3VwcG9ydCBub3QNCj4gPiB0aGVyZSwgZGFlbW9uIHdp
bGwgcnVuIHdpdGhvdXQgcHJvdmlkaW5nIEQtQnVzIHNlcnZpY2Ugb3IgYXR0YWNoaW5nIHRvDQo+
ID4gY29udHJvbGxlcnMgKHByZXZlbnRzIHN5c3RlbWQgdGhyYXNoaW5nKS4NCj4gDQo+IEJ5IHRo
ZSB3YXkgLSBJIGhhdmUgYSBwYXRjaCB0aGF0IGltcGxlbWVudHMgYWxsIHJlcXVpcmVkIGNyeXB0
b2dyYXBoaWMNCj4gb3BlcmF0aW9ucyB1c2luZyBsaWJjcnlwdG8sIGVuYWJsZWQgYnkgLi9jb25m
aWd1cmUgLS13aXRoLW9wZW5zc2wNCj4gKGRpc2FibGVkIGJ5IGRlZmF1bHQpLg0KPiANCj4gSSBr
bm93IHRoYXQgbGFzdCB0aW1lIHdlJ3ZlIHRhbGtlZCBhYm91dCB0aGlzLCB0aGUgY29uc2Vuc3Vz
IHdhcyB0aGF0IHRoZQ0KPiB2ZW5kb3Igc2hvdWxkIHBhdGNoIG1lc2hkIHRvIHdvcmsgb24gb2xk
ZXIga2VybmVscywgc28gd2UgZGlkIGV4YWN0bHkNCj4gdGhhdCAtIGJ1dCBtYXliZSBoYXZpbmcg
dGhpcyBhdmFpbGFibGUgaW4gdGhlIG1haW5saW5lIHdvdWxkIGJlDQo+IGludGVyZXN0aW5nPw0K
DQpZZWFoLCB3ZSBoYXZlIHRhbGtlZCBpbnRlcm5hbGx5IGFib3V0IGhvdyBtdWNoICJvbGQga2Vy
bmVsIHN1cHBvcnQiIGNydWZ0IGNhbiBiZSByZW1vdmVkLCB3aGljaCBpcyBvbmUgb2YgdGhlDQp0
aGluZ3MgTWFyY2VsIHdvdWxkIHdhbnQgYmVmb3JlIGRvaW5nIGEgIk1ham9yIFZlcnNpb24gTnVt
YmVyIFJlbGVhc2UiIGxpa2UgIkJsdWVaLTYuMCIsIHdoZXJlIHdlIGNvdWxkIHNheQ0KdGhhdCB2
Ni4wIHJlcXVpcmVzIGEgbWluaW11bSBrZXJuZWwgdmVyc2lvbiBvZiB2NC45IG9yIHNvbWV0aGlu
Zy4uLiAgQXMgb3Bwb3NlZCB0byBhIG1pbm9yIHZlcnNpb24gcmVsZWFzZSBsaWtlDQoiQmx1ZVot
NS41MSIgd2hpY2ggaGFzIHN1cHBvcnQgZm9yIG1vc3QgdjQuWCBrZXJuZWxzLiAgUGVyaGFwcyBz
b21ldGhpbmcgbGlrZSBvcGVuc3NsIGNvdWxkIGJlICpzdWdnZXN0ZWQqIGluIGENClJFQURNRSBh
cyBvbmUgb2YgYSBmZXcgcG9zc2libGUgd29yay1hcm91bmRzIGEgdmVuZG9yIGNvdWxkIHVzZSB0
byBydW4gb24gYW4gb2xkZXIga2VybmVsLCBidXQgdGhlcmUgaXMgbm8NCnN1cHBvcnQgZm9yIGFk
ZGluZyBhbiBvcGVuc3NsIGRlcGVuZGFuY3kgaW50byB0aGUgQmx1ZVogbWFpbmxpbmUgdGlwLg0K
DQoNCg==
