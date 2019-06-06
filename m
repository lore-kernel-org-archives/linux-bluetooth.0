Return-Path: <SRS0=rXBD=UF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C49C04AB5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0479204EC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFFTcY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:32:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:30548 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFFTcX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jun 2019 15:32:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 12:32:23 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2019 12:32:22 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 12:32:22 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.232]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.242]) with mapi id 14.03.0415.000;
 Thu, 6 Jun 2019 12:32:22 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Minor fixes and clean up
Thread-Topic: [PATCH BlueZ 0/2] Minor fixes and clean up
Thread-Index: AQHVHAXEkGpwoByVnUuBPei1rt9SvqaPemuA
Date:   Thu, 6 Jun 2019 19:32:22 +0000
Message-ID: <8cf1f8c82d27176ab5459b33d65c31a2750033e9.camel@intel.com>
References: <20190606011832.18801-1-inga.stotland@intel.com>
In-Reply-To: <20190606011832.18801-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.92.237]
Content-Type: text/plain; charset="utf-8"
Content-ID: <86B70267948A904FA3BD70E2338876E1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hlcyBBcHBsaWVkDQoNCk9uIFdlZCwgMjAxOS0wNi0wNSBhdCAxODoxOCAtMDcwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gQ2xlYW51cCBjb2Rpbmcgc3R5bGUuIERvbid0IGNoZWNrIHRo
ZSByZXR1cm4gdmFsdWVzIG9mIGxfbmV3KCkgYW5kDQo+IGxfcXVldWVfbmV3KCkuDQo+IEFkZCBj
aGVjayBmb3IgdGhlIHByZXNlbnNlIG9mICJlbGVtZW50cyIgcHJvcGVydHkgaW4gbm9kZQ0KPiBj
b25maWd1cmF0aW9uDQo+IChpdCdzIG1hbmRhdG9yeSkgDQo+IA0KPiBJbmdhIFN0b3RsYW5kICgy
KToNCj4gICBtZXNoOiBNYWtlICJlbGVtZW50cyIgbWFuZGF0b3J5IGluIG5vZGUgY29uZmlndXJh
dGlvbg0KPiAgIG1lc2g6IENsZWFuIHVwIHN0eWxlDQo+IA0KPiAgbWVzaC9tZXNoLWRiLmMgfCAy
MyArKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9tb2RlbC5jICAgfCAyNSArKysrKysr
KysrKysrLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDI2IGRlbGV0aW9ucygtKQ0KPiANCg==
