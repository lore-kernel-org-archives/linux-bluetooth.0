Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A86C7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FE5218EA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfGZQTd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:19:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:57548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfGZQTc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 12:19:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="194314989"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2019 09:19:32 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 09:19:31 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.237]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 09:19:31 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] doc/mesh-api: Restore properties in mesh node
 hierarchy
Thread-Topic: [PATCH BlueZ] doc/mesh-api: Restore properties in mesh node
 hierarchy
Thread-Index: AQHVQ1ZMSNs4DtLoG0KITVo+Mi0OzKbdinoA
Date:   Fri, 26 Jul 2019 16:19:31 +0000
Message-ID: <1564157970.16999.1.camel@intel.com>
References: <20190726020310.27266-1-inga.stotland@intel.com>
In-Reply-To: <20190726020310.27266-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B60114F84883343A5EB1133E5948281@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

YXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDctMjUgYXQgMTk6MDMgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgcmVzdG9yZXMgRmVhdHVyZXMsIEJlYWNvbiwgQmVhY29uRmxhZ3Ms
IEl2SW5kZXggYW5kDQo+IFNlY29uZHNTaW5jZUxBc3QgaGVhcmQgcHJvcGVydGllcyB1bmRlciB0
aGUNCj4gb3JnLmJsdWV6Lm1lc2guTm9kZTEgaW50ZXJmYWNlLg0KPiAtLS0NCj4gIGRvYy9tZXNo
LWFwaS50eHQgfCA5OCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2MvbWVzaC1hcGkudHh0IGIvZG9jL21lc2gtYXBpLnR4
dA0KPiBpbmRleCBmZjZiMzMzNDYuLjdiNjJjMGFmNCAxMDA2NDQNCj4gLS0tIGEvZG9jL21lc2gt
YXBpLnR4dA0KPiArKysgYi9kb2MvbWVzaC1hcGkudHh0DQo+IEBAIC0zNDMsNiArMzQzLDU1IEBA
IE1ldGhvZHM6DQo+ICAJCQlvcmcuYmx1ZXoubWVzaC5FcnJvci5Eb2VzTm90RXhpc3QNCj4gIAkJ
CW9yZy5ibHVlei5tZXNoLkVycm9yLkludmFsaWRBcmd1bWVudHMNCj4gIA0KPiArUHJvcGVydGll
czoNCj4gKwlkaWN0IEZlYXR1cmVzIFtyZWFkLW9ubHldDQo+ICsNCj4gKwkJVGhlIGRpY3Rpb25h
cnkgdGhhdCBjb250YWlucyBpbmZvcm1hdGlvbiBhYm91dCBmZWF0dXJlIHN1cHBvcnQuDQo+ICsJ
CVRoZSBmb2xsb3dpbmcga2V5cyBhcmUgZGVmaW5lZDoNCj4gKw0KPiArCQlib29sZWFuIEZyaWVu
ZA0KPiArDQo+ICsJCQlJbmRpY2F0ZXMgdGhlIGFiaWxpdHkgdG8gZXN0YWJsaXNoIGEgZnJpZW5k
c2hpcCB3aXRoIGENCj4gKwkJCUxvdyBQb3dlciBub2RlDQo+ICsNCj4gKwkJYm9vbGVhbiBMb3dQ
b3dlcg0KPiArDQo+ICsJCQlJbmRpY2F0ZXMgc3VwcG9ydCBmb3Igb3BlcmF0aW5nIGluIExvdyBQ
b3dlciBub2RlIG1vZGUNCj4gKw0KPiArCQlib29sZWFuIFByb3h5DQo+ICsNCj4gKwkJCUluZGlj
YXRlcyBzdXBwb3J0IGZvciBHQVRUIHByb3h5DQo+ICsNCj4gKwkJYm9vbGVhbiBSZWxheQ0KPiAr
CQkJSW5kaWNhdGVzIHN1cHBvcnQgZm9yIHJlbGF5aW5nIG1lc3NhZ2VzDQo+ICsNCj4gKwlJZiBh
IGtleSBpcyBhYnNlbnQgZnJvbSB0aGUgZGljdGlvbmFyeSwgdGhlIGZlYXR1cmUgaXMgbm90IHN1
cHBvcnRlZC4NCj4gKwlPdGhlcndpc2UsIHRydWUgbWVhbnMgdGhhdCB0aGUgZmVhdHVyZSBpcyBl
bmFibGVkIGFuZCBmYWxzZSBtZWFucyB0aGF0DQo+ICsJdGhlIGZlYXR1cmUgaXMgZGlzYWJsZWQu
DQo+ICsNCj4gKwlib29sZWFuIEJlYWNvbiBbcmVhZC1vbmx5XQ0KPiArDQo+ICsJCVRoaXMgcHJv
cGVydHkgaW5kaWNhdGVzIHdoZXRoZXIgdGhlIHBlcmlvZGljIGJlYWNvbmluZyBpcw0KPiArCQll
bmFibGVkICh0cnVlKSBvciBkaXNhYmxlZCAoZmFsc2UpLg0KPiArDQo+ICsJdWludDggQmVhY29u
RmxhZ3MgW3JlYWQtb25seV0NCj4gKw0KPiArCQlUaGlzIHByb3BlcnR5IG1heSBiZSByZWFkIGF0
IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUgZmxhZw0KPiArCQlmaWVsZCBzZXR0aW5nIG9uIHNl
bnQgYW5kIHJlY2VpdmVkIGJlYWNvbnMgb2YgdGhlIHByaW1hcnkNCj4gKwkJbmV0d29yayBrZXku
DQo+ICsNCj4gKwl1aW50MzIgSXZJbmRleCBbcmVhZC1vbmx5XQ0KPiArDQo+ICsJCVRoaXMgcHJv
cGVydHkgbWF5IGJlIHJlYWQgYXQgYW55IHRpbWUgdG8gZGV0ZXJtaW5lIHRoZSBJVl9JbmRleA0K
PiArCQl0aGF0IHRoZSBjdXJyZW50IG5ldHdvcmsgaXMgb24uIFRoaXMgaW5mb3JtYXRpb24gaXMg
b25seSB1c2VmdWwNCj4gKwkJZm9yIHByb3Zpc2lvbmluZy4NCj4gKw0KPiArCXVpbnQzMiBTZWNv
bmRzU2luY2VMYXN0SGVhcmQgW3JlYWQtb25seV0NCj4gKw0KPiArCQlUaGlzIHByb3BlcnR5IG1h
eSBiZSByZWFkIGF0IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUgbnVtYmVyIG9mDQo+ICsJCXNl
Y29uZHMgc2luY2UgbWVzaCBuZXR3b3JrIGxheWVyIHRyYWZmaWMgd2FzIGxhc3QgZGV0ZWN0ZWQg
b24NCj4gKwkJdGhpcyBub2RlJ3MgbmV0d29yay4NCj4gKw0KPiAgTWVzaCBQcm92aXNpb25pbmcg
SGllcmFyY2h5DQo+ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICBTZXJ2aWNlCQlv
cmcuYmx1ZXoubWVzaA0KPiBAQCAtNjE4LDU1ICs2NjcsNiBAQCBNZXRob2RzOg0KPiAgCQlQb3Nz
aWJsZUVycm9yczoNCj4gIAkJCW9yZy5ibHVlei5tZXNoLkVycm9yLkludmFsaWRBcmd1bWVudHMN
Cj4gIA0KPiAtUHJvcGVydGllczoNCj4gLQlkaWN0IEZlYXR1cmVzIFtyZWFkLW9ubHldDQo+IC0N
Cj4gLQkJVGhlIGRpY3Rpb25hcnkgdGhhdCBjb250YWlucyBpbmZvcm1hdGlvbiBhYm91dCBmZWF0
dXJlIHN1cHBvcnQuDQo+IC0JCVRoZSBmb2xsb3dpbmcga2V5cyBhcmUgZGVmaW5lZDoNCj4gLQ0K
PiAtCQlib29sZWFuIEZyaWVuZA0KPiAtDQo+IC0JCQlJbmRpY2F0ZXMgdGhlIGFiaWxpdHkgdG8g
ZXN0YWJsaXNoIGEgZnJpZW5kc2hpcCB3aXRoIGENCj4gLQkJCUxvdyBQb3dlciBub2RlDQo+IC0N
Cj4gLQkJYm9vbGVhbiBMb3dQb3dlcg0KPiAtDQo+IC0JCQlJbmRpY2F0ZXMgc3VwcG9ydCBmb3Ig
b3BlcmF0aW5nIGluIExvdyBQb3dlciBub2RlIG1vZGUNCj4gLQ0KPiAtCQlib29sZWFuIFByb3h5
DQo+IC0NCj4gLQkJCUluZGljYXRlcyBzdXBwb3J0IGZvciBHQVRUIHByb3h5DQo+IC0NCj4gLQkJ
Ym9vbGVhbiBSZWxheQ0KPiAtCQkJSW5kaWNhdGVzIHN1cHBvcnQgZm9yIHJlbGF5aW5nIG1lc3Nh
Z2VzDQo+IC0NCj4gLQlJZiBhIGtleSBpcyBhYnNlbnQgZnJvbSB0aGUgZGljdGlvbmFyeSwgdGhl
IGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZC4NCj4gLQlPdGhlcndpc2UsIHRydWUgbWVhbnMgdGhh
dCB0aGUgZmVhdHVyZSBpcyBlbmFibGVkIGFuZCBmYWxzZSBtZWFucyB0aGF0DQo+IC0JdGhlIGZl
YXR1cmUgaXMgZGlzYWJsZWQuDQo+IC0NCj4gLQlib29sZWFuIEJlYWNvbiBbcmVhZC1vbmx5XQ0K
PiAtDQo+IC0JCVRoaXMgcHJvcGVydHkgaW5kaWNhdGVzIHdoZXRoZXIgdGhlIHBlcmlvZGljIGJl
YWNvbmluZyBpcw0KPiAtCQllbmFibGVkICh0cnVlKSBvciBkaXNhYmxlZCAoZmFsc2UpLg0KPiAt
DQo+IC0JdWludDggQmVhY29uRmxhZ3MgW3JlYWQtb25seV0NCj4gLQ0KPiAtCQlUaGlzIHByb3Bl
cnR5IG1heSBiZSByZWFkIGF0IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUgZmxhZw0KPiAtCQlm
aWVsZCBzZXR0aW5nIG9uIHNlbnQgYW5kIHJlY2VpdmVkIGJlYWNvbnMgb2YgdGhlIHByaW1hcnkN
Cj4gLQkJbmV0d29yayBrZXkuDQo+IC0NCj4gLQl1aW50MzIgSXZJbmRleCBbcmVhZC1vbmx5XQ0K
PiAtDQo+IC0JCVRoaXMgcHJvcGVydHkgbWF5IGJlIHJlYWQgYXQgYW55IHRpbWUgdG8gZGV0ZXJt
aW5lIHRoZSBJVl9JbmRleA0KPiAtCQl0aGF0IHRoZSBjdXJyZW50IG5ldHdvcmsgaXMgb24uIFRo
aXMgaW5mb3JtYXRpb24gaXMgb25seSB1c2VmdWwNCj4gLQkJZm9yIHByb3Zpc2lvbmluZy4NCj4g
LQ0KPiAtCXVpbnQzMiBTZWNvbmRzU2luY2VMYXN0SGVhcmQgW3JlYWQtb25seV0NCj4gLQ0KPiAt
CQlUaGlzIHByb3BlcnR5IG1heSBiZSByZWFkIGF0IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUg
bnVtYmVyIG9mDQo+IC0JCXNlY29uZHMgc2luY2UgbWVzaCBuZXR3b3JrIGxheWVyIHRyYWZmaWMg
d2FzIGxhc3QgZGV0ZWN0ZWQgb24NCj4gLQkJdGhpcyBub2RlJ3MgbmV0d29yay4NCj4gLQ0KPiAg
TWVzaCBBcHBsaWNhdGlvbiBIaWVyYXJjaHkNCj4gID09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+ICBTZXJ2aWNlCQl1bmlxdWUgbmFtZQ==
