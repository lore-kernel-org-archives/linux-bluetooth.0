Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B72C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8D020B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGAQct (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:32:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:55991 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfGAQct (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 12:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="190307835"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2019 09:32:48 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 09:32:47 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.128]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 09:32:47 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ 0/4 v4] Model publication fixes
Thread-Topic: [PATCH BlueZ 0/4 v4] Model publication fixes
Thread-Index: AQHVLw8xksC8+6kmtkuNOIDyRxhRS6a2bHOA
Date:   Mon, 1 Jul 2019 16:32:47 +0000
Message-ID: <1561998765.458.2.camel@intel.com>
References: <20190630064356.12660-1-inga.stotland@intel.com>
In-Reply-To: <20190630064356.12660-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C74906EE308C74299A1953047E46CB0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggc2V0IGFwcGxpZWQNCg0KT24gU2F0LCAyMDE5LTA2LTI5IGF0IDIzOjQzIC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiArIE1pY2hhbCdzIGNvbW1lbnQ6IGV4cGxpY2l0IHNldHRp
bmcgb2YgcmVmX2NudCA9IDEgaW4gdmlydCBhZGRyZXNzZXMNCj4gICBob3VzZWtlZXBpbmcNCj4g
KyBBIHdvcmthcm91bmQgZm9yIChib2d1cykgY29tcGlsZXIgd2FybmluZywgcGx1cyBjb21taXQg
dGV4dCBmaXhlcw0KPiArIE1pY2hhbCdzIGNvbW1lbnQ6IHZhcmlhYmxlIG5hbWluZw0KPiANCj4g
VGhpcyBzZXQgb2YgcGF0Y2hlcyBjbGVhbnMgdXAgbWlzY2VsbGFuZW91cyBjb2RlIHJlZHVuZGFu
Y2llcyBpbiBtb2RlbC5jDQo+IGFuZCBjb250YWlucyBmaXhlcyBpbiB0aGUgZm9sbG93aW5nIGFy
ZWFzOg0KPiAtIHZpcnR1YWwgYWRkcmVzcyBob3VzZWtlZXBpbmcNCj4gLSBjaGVja3MgZm9yIG1v
ZGVsIHB1YmxpY2F0aW9uIHJlbW92YWwsIGkuZS4sIHdoZW4gY29uZmlnIHB1YiBtZXNzYWdlIGhh
cw0KPiAgICJ1bmFzc2lnbmVkIiB2YWx1ZSBmb3IgcHVibGljYXRpb24gYWRkcmVzcyANCj4gLSBy
ZXR1cm4gdmFsdWVzIGRpc2NyZXBhbmNpZXMgKGZldyBjYXNlcyB3aGVyZSBhbiBpbnRlZ2VyIGVy
cm9yIGNvZGUgaXMNCj4gICB0byBiZSByZXR1cm5lZCwgYnV0IGJvb2xlYW4gZmFsc2Ugd2FzIHJl
dHVybmVkIGluc3RlYWQpDQo+IA0KPiBJbmdhIFN0b3RsYW5kICg0KToNCj4gICBtZXNoOiBDbGVh
biB1cCBtb2RlbC5jIGFuZCBjZmctc2VydmVyLmMNCj4gICBtZXNoOiBGaXggdmlydHVhbCBhZGRy
ZXNzIHByb2Nlc3NpbmcNCj4gICBtZXNoOiBGaXggYW5kIGNsZWFuIHVwIG1vZGVsIHB1YmxpY2F0
aW9uIGNvZGUNCj4gICB0ZXN0OiB0ZXN0LW1lc2ggLSBDb3JyZWN0bHkgc3RvcCBwZXJpb2RpYyBw
dWJsaWNhdGlvbg0KPiANCj4gIG1lc2gvY2ZnbW9kLXNlcnZlci5jIHwgIDQ3ICsrKy0tLQ0KPiAg
bWVzaC9tb2RlbC5jICAgICAgICAgfCAzNjYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9tb2RlbC5oICAgICAgICAgfCAgMzggKystLS0NCj4gIHRl
c3QvdGVzdC1tZXNoICAgICAgIHwgICA4ICstDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDE5MCBpbnNl
cnRpb25zKCspLCAyNjkgZGVsZXRpb25zKC0pDQo+IA==
