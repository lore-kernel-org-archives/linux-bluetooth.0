Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADDC282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BED20821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfBDUKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:10:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:58128 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfBDUKT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:10:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="317606168"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2019 12:10:18 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 12:10:18 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.39]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 12:10:18 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ] TODO: Add Bluetooth mesh items
Thread-Topic: [PATCH BlueZ] TODO: Add Bluetooth mesh items
Thread-Index: AQHUvL4Ejs1dRZ6WMkKGzAnebC91qaXQl+iA
Date:   Mon, 4 Feb 2019 20:10:16 +0000
Message-ID: <1549311015.22761.0.camel@intel.com>
References: <20190204191534.5221-1-inga.stotland@intel.com>
In-Reply-To: <20190204191534.5221-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E44B97CEC98AF740B629C340AA0D820F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQoNCkFwcGxpZWQNCg0KDQoNCk9uIE1vbiwgMjAxOS0wMi0wNCBhdCAxMToxNSAtMDgwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gLS0tDQo+ICBUT0RPIHwgNTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTEg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL1RPRE8gYi9UT0RPDQo+IGluZGV4IGQ4
ODM0OWUwNi4uMzc0NjJkNmU4IDEwMDY0NA0KPiAtLS0gYS9UT0RPDQo+ICsrKyBiL1RPRE8NCj4g
QEAgLTE4NiwzICsxODYsNTQgQEAgQVRUL0dBVFQgKG5ldyBzaGFyZWQgc3RhY2spDQo+ICANCj4g
IE1hbmFnZW1lbnQgSW50ZXJmYWNlDQo+ICA9PT09PT09PT09PT09PT09PT09PQ0KPiArDQo+ICtN
ZXNoDQo+ICs9PT09DQo+ICstIFJlYWQgZGVmYXVsdCBjb25maWd1cmF0aW9uIHNldHRpbmdzIChl
LmcuLCBwcm92aXNpb25pbmcgdGltZW91dCwgc3VwcG9ydGVkDQo+ICsgIGZlYXR1cmVzLCBldGMu
KWZyb20gIG1lc2guY29uZiBmaWxlLg0KPiArDQo+ICsgIFByaW9yaXR5OiBNZWRpdW0NCj4gKyAg
Q29tcGxleGl0eTogQzENCj4gKw0KPiArLSBBZGQgZXhhbXBsZXMgYW5kIHVuaXQgdGVzdHMNCj4g
Kw0KPiArICBQcmlvcml0eTogSGlnaA0KPiArICBDb21wbGV4aXR5OiBDMQ0KPiArDQo+ICstIElt
cGxlbWVudCB1bmlmaWVkIGZlYXR1cmUgbWFuYWdlbWVudCBtZWNoYW5pc20gZm9yIG1lc2ggbm9k
ZXMgdGhhdCBhcmUgaG9zdGVkDQo+ICsgIG9uIHRoZSBzYW1lIGRldmljZQ0KPiArDQo+ICsgIFBy
aW9yaXR5OiBNZWRpdW0NCj4gKyAgQ29tcGxleGl0eTogQzINCj4gKw0KPiArLSBJbXBsZW1lbnQg
bWFuZGF0b3J5IEhlYWx0aCBTZXJ2ZXIgbW9kZWwuIE1vc3QgbGlrZWx5LCB0aGlzIHdpbGwgaW52
b2x2ZQ0KPiArICBhZGRpdGlvbnMgdG8gbWVzaCBELUJ1cyBBUEkNCj4gKw0KPiArICBQcmlvcml0
eTogTWVkaXVtDQo+ICsgIENvbXBsZXhpdHk6IEMyDQo+ICsNCj4gKy0gRGVzaWduIGFuZCBpbXBs
ZW1lbnQgTWVzaCBQcm92aXNpb25lci8gQ29uZmlndXJhdGlvbiBDbGllbnQgTW9kZWwuDQo+ICsN
Cj4gKyAgUHJpb3JpdHk6IE1lZGl1bQ0KPiArICBDb21wbGV4aXR5OiBDMw0KPiArDQo+ICstIEFk
ZCBzdXBwb3J0IGZvciBHQVRUIHByb3h5IHNlcnZlcg0KPiArDQo+ICsgIFByaW9yaXR5OiBMb3cN
Cj4gKyAgQ29tcGxleGl0eTogQzMNCj4gKw0KPiArLSBNZXJnZSBjb21tb24gZnVuY3Rpb25hbGl0
eSBmcm9tIHRvb2xzL21lc2guIElkZWFsbHksIHNvdXJjZSBjb2RlIGZyb20gdGhlDQo+ICsgIHRv
b2xzL21lc2ggZGlyZWN0b3J5IHNob3VsZCBjb21wbGV0ZWx5IGRpc3NhcGVhci4NCj4gKw0KPiAr
ICBQcmlvcml0eTogTG93DQo+ICsgIENvbXBsZXhpdHk6IEMyDQo+ICsNCj4gKy0gU3VwcG9ydCBm
b3IgTG93IFBvd2VyIE5vZGUgKExQTikNCj4gKw0KPiArICBQcmlvcml0eTogTG93DQo+ICsgIENv
bXBsZXhpdHk6IEM0DQo+ICsNCj4gKy0gU3VwcG9ydCBmb3IgYWxsIHRoZSBQcm92aXNpb25pbmdz
IE9PQiBzdHlsZXMNCj4gKw0KPiArICBQcmlvcml0eTogTWVkaXVtDQo+ICsgIENvbXBsZXhpdHk6
IEMy
