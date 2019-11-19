Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57BC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 07:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92DC2230E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 07:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKSHbs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:31:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:36714 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKSHbs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 02:31:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 23:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="237231112"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 23:31:46 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 23:31:46 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.179]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.26]) with mapi id 14.03.0439.000;
 Mon, 18 Nov 2019 23:31:46 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "daniele.biagetti@cblelectronics.com" 
        <daniele.biagetti@cblelectronics.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "dbiagio@tiscali.it" <dbiagio@tiscali.it>
Subject: Re: [PATCH 0/6] Add features and fix some undesired behaviour of
 meshctl
Thread-Topic: [PATCH 0/6] Add features and fix some undesired behaviour of
 meshctl
Thread-Index: AQHVnhfCWCjtzbo730mKvbdt/7B3+aeSoLaA
Date:   Tue, 19 Nov 2019 07:31:45 +0000
Message-ID: <542b58513751682d074100e28057d66b102c6c4d.camel@intel.com>
References: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
In-Reply-To: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.151.224]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB545D7B0235AE49B4934426F729B6D5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgRGFuaWVsZSwNCg0KT24gTW9uLCAyMDE5LTExLTE4IGF0IDE0OjQzICswMTAwLCBEYW5pZWxl
IEJpYWdldHRpIHdyb3RlOg0KPiBGcm9tOiBEYW5pZWxlIDwNCj4gZGJpYWdpb0B0aXNjYWxpLml0
DQo+ID4NCj4gDQo+IFRoZSBmb2xsb3dpbmdzIGV4dGVuZCB0aGUgZmVhdHVyZXMgb2YgbWVzaGN0
bCwgYWRkaW5nOg0KPiAgKiBUaGUgU3Vic2NyaXB0aW9uIERlbGV0ZSBtZXNzYWdlIHRvIHRoZSBj
b25maWd1cmF0aW9uIGNsaWVudCANCj4gICAgKGFzIHBlciBNZXNoIFByb2ZpbGUgNC4zLjIuMjEp
DQo+ICAqIFRoZSBHZW5lcmljIE9uT2ZmIFNldCBVbmFja25vd2xlZGdlZCBtZXNzYWdlIHRvIHRo
ZSBvbm9mZg0KPiAgICBjbGllbnQgbW9kZWwNCj4gICogR2VuZXJpYyBMZXZlbCBDbGllbnQgTW9k
ZWwsIGxpbWl0ZWQgdG8gdGhlIGZvbGxvd2luZyBtZXNzYWdlczoNCj4gICAgLSBnZW5lcmljIGxl
dmVsIGdldCBhbmQgc2V0DQo+ICAgIC0gZ2VuZXJpYyBsZXZlbCBzZXQgdW5hY2tub3dsZWRnZWQN
Cj4gICAgLSBnZW5lcmljIGxldmVsIHN0YXR1cw0KPiAgKiBHZW5lcmljIFBvd2VyIE9uT2ZmIENs
aWVudCBleGNlcHQgdGhlIEdlbmVyaWMgT25Qb3dlclVwIFNldA0KPiAgICBVbmFja25vd2xlZGdl
ZCBtZXNzYWdlDQo+IFRoZXkgYWxzbyBjb250YWlucyB0d28gZml4ZXM6DQo+ICAqIFRoZSBmaXJz
dCBvbmUgY2FtZXMgdXAgd2hlbiBtb3JlIHRoYW4gYSBjbGllbnQgbW9kZWwgaXMgYWRkZWQNCj4g
ICAgdG8gdGhlIGxvY2FsIG5vZGUuIFRoZSByZWNlaXZlZCBzdGF0dXMgbWVzc2FnZXMgYXJlIGZv
cndhcmRlZA0KPiAgICB0byBhbGwgY2xpZW50cyBhbmQgdGhleSBuZWVkcyB0byBiZSBmaWx0ZXJl
ZCB3aXRoaW4gZWFjaCBjbGllbnQNCj4gICAgaW4gb3JkZXIgdG8gYXZvaWQgd3JvbmcgcmVwb3J0
cyBvbiB0aGUgYnQgc2hlbGwNCj4gICogVGhlIHNlY29uZCBvbmUgcmVwbGFjZXMgYSByZXR1cm4g
c3RhdG1lbnQgd2l0aGluIHRoZSBvbm9mZiANCj4gICAgY2xpZW50IG1vZGVsIHdpdGggYSB3YXJu
aW5nIG1lc3NhZ2Ugd2hlbiB0aGUgdXNlciBzZWxlY3RzIGFuDQo+ICAgIHVua25vd24gdGFyZ2V0
IGFkZHJlc3MuIEZvciBleGFtcGxlIGl0IGhhcHBlbnMgd2hlbiB0aGUgdXNlciANCj4gICAgdHJp
ZXMgdG8gc2VuZCBtZXNzYWdlcyB0byBhIGdyb3VwIGFkZHJlc3MgZHVlIHRvIHRoZSBmYWN0IHRo
YXQNCj4gICAgc3VjaCBhZGRyZXNzZXMgYXJlIG5vdCBzdG9yZWQgd2hpdG4gdGhlIGpzb24gZGF0
YWJhc2UuDQo+IA0KPiBEYW5pZWxlICg2KToNCj4gICB0b29scy9tZXNoOiBBZGQgb25vZmYgc2V0
IHVuYWNrIG1lc3NhZ2UgdG8gb25vZmYgY2xpZW50IG1vZGVsDQo+ICAgdG9vbHMvbWVzaDogRml4
IHN0YXR1cyBtZXNzYWdlcyBwcm9jZXNzaW5nDQo+ICAgdG9vbHMvbWVzaDogRml4IHVud2FudGVk
IHJldHVybiBpbiBvbm9mZiBjbGllbnQgbW9kZWwNCj4gICB0b29scy9tZXNoOiBBZGQgc3Vic2Ny
aXB0aW9uIGRlbGV0ZSBtZXNzYWdlIHRvIGNvbmZpZyBjbGllbnQgbW9kZWwNCj4gICB0b29scy9t
ZXNoOiBBZGQgZ2VuZXJpYyBsZXZlbCBtb2RlbCBzdXBwb3J0DQo+ICAgdG9vbHMvbWVzaDogQWRk
IGdlbmVyaWMgcG93ZXIgb25vZmYgY2xpZW50IG1vZGVsDQo+IA0KPiAgTWFrZWZpbGUudG9vbHMg
ICAgICAgICAgICAgICB8ICAgNCArLQ0KPiAgdG9vbHMvbWVzaC9jb25maWctY2xpZW50LmMgICB8
ICA0MCArKysrKw0KPiAgdG9vbHMvbWVzaC9sZXZlbC1tb2RlbC5jICAgICB8IDI5OA0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgdG9vbHMvbWVzaC9sZXZlbC1tb2Rl
bC5oICAgICB8ICAzNCArKysrDQo+ICB0b29scy9tZXNoL2xvY2FsX25vZGUuanNvbiAgIHwgIDEw
ICstDQo+ICB0b29scy9tZXNoL25vZGUuYyAgICAgICAgICAgIHwgIDExICsrDQo+ICB0b29scy9t
ZXNoL29ub2ZmLW1vZGVsLmMgICAgIHwgIDUyICsrKystLQ0KPiAgdG9vbHMvbWVzaC9vbnBvd2Vy
dXAtbW9kZWwuYyB8IDI2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHRvb2xz
L21lc2gvb25wb3dlcnVwLW1vZGVsLmggfCAgMzQgKysrKw0KPiAgdG9vbHMvbWVzaGN0bC5jICAg
ICAgICAgICAgICB8ICAgOCArDQo+ICAxMCBmaWxlcyBjaGFuZ2VkLCA3MzQgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9sZXZl
bC1tb2RlbC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9sZXZlbC1tb2RlbC5o
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9vbnBvd2VydXAtbW9kZWwuYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL21lc2gvb25wb3dlcnVwLW1vZGVsLmgNCj4gDQo+IA0K
DQpJdCBsb29rcyBsaWtlIHRoZSBwYXRjaGVzIGFyZSBub3QgZ2VuZXJhdGVkIGFnYWluc3QgdGhl
IHRpcCBvZiB0aGUNCkJsdWVaIHRyZWUuIFRoZSBtZXNoY3RsIHNwZWNpZmljIGZpbGVzIGFyZSBu
b3cgcmVzaWRpbmcgaW4gdG9vbHMvbWVzaC0NCmdhdHQgZGlyZWN0b3J5LiBZb3Ugd291bGQgbmVl
ZCB0byB1cGRhdGUgdGhlIEJsdWVaIHNvdXJjZSBhbmQNCnJlZ2VuZXJhdGUgdGhlIHBhdGNoZXMu
DQoNCkJlc3QgcmVnYXJkcywNCkluZ2EgIA0K
