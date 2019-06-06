Return-Path: <SRS0=rXBD=UF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9AC04AB5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 19:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3502083D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 19:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfFFTDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:03:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:49570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfFFTDj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jun 2019 15:03:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 12:03:38 -0700
X-ExtLoop1: 1
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2019 12:03:38 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 12:03:38 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.232]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.124]) with mapi id 14.03.0415.000;
 Thu, 6 Jun 2019 12:03:38 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "ludwig.nussel@suse.de" <ludwig.nussel@suse.de>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v4 0/3] mesh - Service and Installation
Thread-Topic: [PATCH BlueZ v4 0/3] mesh - Service and Installation
Thread-Index: AQHVGxQoaX9UsapTeUiPL3VxPtnwwqaPdEYA
Date:   Thu, 6 Jun 2019 19:03:38 +0000
Message-ID: <1559847816.7839.0.camel@intel.com>
References: <20190604202852.12656-1-brian.gix@intel.com>
In-Reply-To: <20190604202852.12656-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.84.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB5B2EBBBA86842ABB2E500613D71C9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlc2UgdGhyZWUgcGF0Y2hlcyBhcHBsaWVkLCBUaGFua3MNCg0KT24gVHVlLCAyMDE5LTA2LTA0
IGF0IDEzOjI4IC0wNzAwLCBCcmlhbiBHaXggd3JvdGU6DQo+IFRoaXMgcGF0Y2ggc2V0IG9mIGNo
YW5nZXMgZnJvbSBJbmdhIGFuZCBMdWR3aWcgYXJlIG5lZWRlZCB0byBpbnN0YWxsDQo+IHRoZSBi
bHVldG9vdGgtbWVzaCBkYWVtb24gYXMgYSBzeXN0ZW1kIHNlcnZpY2UsIHdpdGggYWNjZXNzIHRv
IEQtYnVzLg0KPiANCj4gTHVkd2lnJ3MgcGF0Y2ggZnJvbSBBcHJpbCBmaXhlcyBhIHByb2JsZW0g
d2l0aCBpbnN0YWxsYXRpb24gbG9jYXRpb25zDQo+IGZvciAqYWxsKiBvZiBCbHVlWiwgYW5kIElu
Z2EncyBhZGRzIHRoZSBibHVldG9vdGgtbWVzaCBzZXJ2aWNlLg0KPiANCj4gDQo+IEluZ2EgU3Rv
dGxhbmQgKDIpOg0KPiAgIGJ1aWxkOiBBZGQgc3VwcG9ydCBmb3Igc3lzdGVtZCBibHVldG9vdGgt
bWVzaCBzZXJ2aWNlDQo+ICAgbWVzaDogRG8gbm90IGRhZW1vbml6ZSwgcnVuIGluIGZvcmVncm91
bmQgb3IgYXMgc2VydmljZQ0KPiANCj4gTHVkd2lnIE51c3NlbCAoMSk6DQo+ICAgaW5zdGFsbDog
Rml4IGluc3RhbGxhdGlvbnMgdG8gcGtnbGliZXhlY2Rpcg0KPiANCj4gIE1ha2VmaWxlLmFtICAg
ICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gIE1ha2VmaWxlLm1lc2ggICAgICAgICAgICAg
ICAgICB8IDE2ICsrKysrKysrKysrKystLS0NCj4gIE1ha2VmaWxlLm9iZXhkICAgICAgICAgICAg
ICAgICB8ICAyICstDQo+ICBNYWtlZmlsZS50b29scyAgICAgICAgICAgICAgICAgfCAgMiArLQ0K
PiAgbWVzaC9ibHVldG9vdGgtbWVzaC5zZXJ2aWNlLmluIHwgMTcgKysrKysrKysrKysrKysrKysN
Cj4gIG1lc2gvbWFpbi5jICAgICAgICAgICAgICAgICAgICB8IDE3ICsrKysrKy0tLS0tLS0tLS0t
DQo+ICBtZXNoL29yZy5ibHVlei5tZXNoLnNlcnZpY2UgICAgfCAgNSArKysrKw0KPiAgNyBmaWxl
cyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBtZXNoL2JsdWV0b290aC1tZXNoLnNlcnZpY2UuaW4NCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBtZXNoL29yZy5ibHVlei5tZXNoLnNlcnZpY2UNCj4g
