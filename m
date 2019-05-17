Return-Path: <SRS0=oIVb=TR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D80C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D052082E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEQUSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 May 2019 16:18:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:40233 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfEQUSI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 May 2019 16:18:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 13:18:08 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2019 13:18:08 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 17 May 2019 13:18:07 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.155]) with mapi id 14.03.0415.000;
 Fri, 17 May 2019 13:18:07 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 0/2] mesh source code housekeeping
Thread-Topic: [PATCH BlueZ 0/2] mesh source code housekeeping
Thread-Index: AQHVC1B+FuF+dnRza0C9IClMBjHRx6ZwOfyA
Date:   Fri, 17 May 2019 20:18:06 +0000
Message-ID: <1558124285.4039.0.camel@intel.com>
References: <20190515190019.19710-1-inga.stotland@intel.com>
In-Reply-To: <20190515190019.19710-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <039FAAD58CB0D144BC62277B3136D3D6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gV2VkLCAyMDE5LTA1LTE1IGF0IDEyOjAwIC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCB1cGRhdGVzIGNvcHlyaWdodCBk
YXRlcyBvbiB0aGUgZmlsZXMgdGhhdCBoYXZlIGJlZW4gbW9kaWZpZWQNCj4gaW4gMjAxOSBhbmQg
Y2xlYW5zIHVwIHRoZSBpbmNsdWRlbGlzdHMgaW4gc291cmNlIGZpbGVzLg0KPiANCj4gSW5nYSBT
dG90bGFuZCAoMik6DQo+ICAgbWVzaDogVXBkYXRlIGNvcHlyaWdodCBkYXRlcw0KPiAgIG1lc2g6
IFJlbW92ZSB1bm5lY2Vzc2FyeSBpbmNsdWRlcyBmcm9tIC5jIGZpbGVzDQo+IA0KPiAgbWVzaC9h
Z2VudC5jICAgICAgICAgICB8ICAzICstLQ0KPiAgbWVzaC9hcHBrZXkuYyAgICAgICAgICB8ICA0
ICstLS0NCj4gIG1lc2gvYXBwa2V5LmggICAgICAgICAgfCAgMiArLQ0KPiAgbWVzaC9jZmdtb2Qt
c2VydmVyLmMgICB8ICA3ICstLS0tLS0NCj4gIG1lc2gvY3J5cHRvLmMgICAgICAgICAgfCAgNCAr
LS0tDQo+ICBtZXNoL2RidXMuYyAgICAgICAgICAgIHwgMTAgLS0tLS0tLS0tLQ0KPiAgbWVzaC9l
cnJvci5oICAgICAgICAgICB8ICAyICstDQo+ICBtZXNoL2ZyaWVuZC5jICAgICAgICAgIHwgIDgg
Ky0tLS0tLS0NCj4gIG1lc2gva2V5cmluZy5jICAgICAgICAgfCAgNyArLS0tLS0tDQo+ICBtZXNo
L21haW4uYyAgICAgICAgICAgIHwgIDcgLS0tLS0tLQ0KPiAgbWVzaC9tZXNoLWRiLmMgICAgICAg
ICB8ICAzICstLQ0KPiAgbWVzaC9tZXNoLWRiLmggICAgICAgICB8ICAyICstDQo+ICBtZXNoL21l
c2gtZGVmcy5oICAgICAgIHwgIDIgKy0NCj4gIG1lc2gvbWVzaC1pby1nZW5lcmljLmMgfCAgNiAr
LS0tLS0NCj4gIG1lc2gvbWVzaC1pby5jICAgICAgICAgfCAgMiAtLQ0KPiAgbWVzaC9tZXNoLmMg
ICAgICAgICAgICB8ICA1ICsrLS0tDQo+ICBtZXNoL21vZGVsLmMgICAgICAgICAgIHwgIDIgKy0N
Cj4gIG1lc2gvbmV0LWtleXMuYyAgICAgICAgfCAgMyArLS0NCj4gIG1lc2gvbmV0LWtleXMuaCAg
ICAgICAgfCAgMiArLQ0KPiAgbWVzaC9uZXQuYyAgICAgICAgICAgICB8IDExICsrLS0tLS0tLS0t
DQo+ICBtZXNoL25ldC5oICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1lc2gvbm9kZS5jICAgICAg
ICAgICAgfCAgNiArKy0tLS0NCj4gIG1lc2gvbm9kZS5oICAgICAgICAgICAgfCAgMiArLQ0KPiAg
bWVzaC9wYi1hZHYuYyAgICAgICAgICB8IDE4ICstLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9w
cm92LWFjY2VwdG9yLmMgICB8IDE4ICsrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9wcm92LWlu
aXRpYXRvci5jICB8IDE4ICsrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9zdG9yYWdlLmMgICAg
ICAgICB8IDEzICsrKy0tLS0tLS0tLS0NCj4gIG1lc2gvc3RvcmFnZS5oICAgICAgICAgfCAgMiAr
LQ0KPiAgbWVzaC91dGlsLmMgICAgICAgICAgICB8ICA2ICstLS0tLQ0KPiAgMjkgZmlsZXMgY2hh
bmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMTQ0IGRlbGV0aW9ucygtKQ0KPiA=
