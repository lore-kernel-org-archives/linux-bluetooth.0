Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA1C73C66
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692B920820
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGNPrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:47:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:11658 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfGNPrS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 11:47:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 08:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,490,1557212400"; 
   d="scan'208";a="168754536"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 08:47:17 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jul 2019 08:47:16 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.114]) with mapi id 14.03.0439.000;
 Sun, 14 Jul 2019 08:47:16 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/9] mesh: Provisioner Initiator added
Thread-Topic: [PATCH BlueZ v2 0/9] mesh: Provisioner Initiator added
Thread-Index: AQHVODxe9iP+Vg4WTE+fVjT3bsItGabKu7AA
Date:   Sun, 14 Jul 2019 15:47:16 +0000
Message-ID: <1563119234.9043.0.camel@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.80.129]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D88AC202F1CE934D8945B4CD5BB5C6C4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDctMTEgYXQgMTU6NTkgLTA3MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gdjIgYWRkaXRpb25zOg0KPiAqIFN0eWxlIGd1aWRlIGNoYW5nZXMgbm90ZWQgYnkg
TWljaGFsDQo+ICogQWRkaXRpb25hbCBwYXRjaCB0byB1c2UgcGFja2VkIHN0cnVjdHVyZXMgZm9y
IE1lc2ggU3BlYyBzcGVjaWZpZCBPVEEgbWVzc2FnZXMNCj4gDQo+IFRoZSBhZGRlZCBmdW5jdGlv
bmFsaXR5IG9mIHRoaXMgcGF0Y2ggc2V0IGFsbG93cyBhbnkgbm9kZSB3aXRoIGEga2V5cmluZw0K
PiBwcm92aXNpb24gYSBuZXcgbm9kZSBpbnRvIHRoZSBuZXR3b3JrLiBJdCBkb2VzICpub3QqIGlt
cGxlbWVudCBhDQo+IHVzZXIgQXBwIHRoYXQgY2FuIHN0b3JlIGEgQ29uZmlndXJhdGlvbiBEYXRh
YmFzZSwgYnV0IGl0IGRvZXMgcHJvdmlkZQ0KPiBleHRlbnNpb25zIHRvIHRoZSBweXRob24gdGVz
dCBzY3JpcHQgdG8gdGVzdCB0aGUgcHJpbWl0aXZlcy4NCj4gDQo+IEJyaWFuIEdpeCAoOSk6DQo+
ICAgZG9jOiBDbGVhbnVwIEFQSSBQcm92aXNpb25lcjEgaW50ZXJmYWNlDQo+ICAgbWVzaDogRml4
IHN1cHBvcnQgZm9yIFByb3Zpc2lvbmVyIEluaXRpYXRvcg0KPiAgIG1lc2g6IEFkZCBzcGVjaWFs
IEJlYWNvbiBoYW5kbGVyIGZvciBQcm92aXNpb25pbmcNCj4gICBtZXNoOiBFeHBvc2UgbWFwcGlu
ZyBmdW5jdGlvbiBmb3IgRC1CdXMgZXJyb3JzDQo+ICAgbWVzaDogRXhwb3NlIHJlc291cmNlcyBu
ZWVkZWQgYnkgTWFuYWdlbWVudDEgaW50ZXJmYWNlDQo+ICAgbWVzaDogRml4IGltcGxlbWVudGF0
aW9uIG9mIFByb3Zpc2lvbmVyIEluaXRpYXRvcg0KPiAgIG1lc2g6IEltcGxlbWVudCBEQnVzIFBy
b3Zpc2lvbmluZyBtZXRob2RzDQo+ICAgbWVzaDogQ29udmVydCBwcm92aXNpb25pbmcgcGt0cyB0
byBwYWNrZWQgc3RydWN0cw0KPiAgIHRlc3Q6IFRoaXMgZXh0ZW5kcyB0aGUgbWVzaCB0b29sIHRv
IGV4ZXJjaXNlIFByb3Zpc2lvbmluZyBtZXRob2RzDQo+IA0KPiAgZG9jL21lc2gtYXBpLnR4dCAg
ICAgICB8ICAxMyArKy0NCj4gIG1lc2gvY3J5cHRvLmMgICAgICAgICAgfCAgIDggKy0NCj4gIG1l
c2gvY3J5cHRvLmggICAgICAgICAgfCAgIDggKy0NCj4gIG1lc2gvbWFuYWdlci5jICAgICAgICAg
fCAzMDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiAgbWVzaC9tZXNoLWlvLWdlbmVyaWMuYyB8ICAgMiArLQ0KPiAgbWVzaC9tZXNoLWlvLmMgICAg
ICAgICB8ICAgNiArLQ0KPiAgbWVzaC9tZXNoLWlvLmggICAgICAgICB8ICAgNyArLQ0KPiAgbWVz
aC9tZXNoLmMgICAgICAgICAgICB8ICAxMCArLQ0KPiAgbWVzaC9tZXNoLmggICAgICAgICAgICB8
ICAgNCArLQ0KPiAgbWVzaC9ub2RlLmMgICAgICAgICAgICB8ICA0MiArKysrKy0tDQo+ICBtZXNo
L25vZGUuaCAgICAgICAgICAgIHwgICAzICsNCj4gIG1lc2gvcGItYWR2LmMgICAgICAgICAgfCAx
NzcgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgbWVzaC9wYi1hZHYuaCAgICAgICAg
ICB8ICAgMyArLQ0KPiAgbWVzaC9wcm92LWFjY2VwdG9yLmMgICB8IDE1OCArKysrKysrKysrKysr
LS0tLS0tLS0tLS0tDQo+ICBtZXNoL3Byb3YtaW5pdGlhdG9yLmMgIHwgMjgzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9wcm92LmggICAgICAg
ICAgICB8ICA1MSArKysrKysrKy0NCj4gIG1lc2gvcHJvdmlzaW9uLmggICAgICAgfCAgMTAgKy0N
Cj4gIHRlc3QvdGVzdC1tZXNoICAgICAgICAgfCAxMTMgKysrKysrKysrKysrKysrKysrDQo+ICAx
OCBmaWxlcyBjaGFuZ2VkLCA5NDYgaW5zZXJ0aW9ucygrKSwgMjU2IGRlbGV0aW9ucygtKQ0KPiA=
