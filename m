Return-Path: <SRS0=8P1K=QT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1970FC282CA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392D2084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfBLXmX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:42:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:56281 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbfBLXmW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Feb 2019 18:42:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 15:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="319867600"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2019 15:42:23 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Feb 2019 15:42:22 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.122]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 15:42:21 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 0/5 v2] mesh: Save/restore network keys
Thread-Topic: [PATCH BlueZ 0/5 v2] mesh: Save/restore network keys
Thread-Index: AQHUvpj/HA7b9kQtkUCY0IFeQu23pKXdYhmA
Date:   Tue, 12 Feb 2019 23:42:21 +0000
Message-ID: <1550014939.29883.0.camel@intel.com>
References: <20190207035537.20375-1-inga.stotland@intel.com>
In-Reply-To: <20190207035537.20375-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.73.84]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4187549E5EAE3645861C08267A7370F3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggc2V0IGFwcGxpZWQNCg0KDQpPbiBXZWQsIDIwMTktMDItMDYgYXQgMTk6NTUgLTA4MDAs
IEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+IFJldi4yOiBhZGRyZXNzZWQgQnJpbmEncyBjb21tZW50
cy4NCj4gDQo+IFRoaXMgc2V0IG9mIHBhdGNoZXMgZml4ZXMgdGhlIG5ldHdvcmsga2V5IGFkZC91
cGRhdGUgcHJvY2Vzc2luZy4NCj4gTmV0d29yayBrZXlzIG5lZWQgdG8gYmUgc2F2ZWQgdG8gYSBs
b2NhbCBub2RlIGNvbmZpZ3VyYXRpb24gZmlsZQ0KPiB3aGVuOg0KPiAJLSBhIG5ldyBub2RlIGlz
IHByb3Zpc2lvbmVkDQo+IAktIG5ldyBuZXR3b3JrIGtleSBhcmUgYWRkZWQgYnkgYSBjb25maWd1
cmF0aW9uIGNsaWVudA0KPiAgICAgLSBleGlzdGluZyBuZXR3b3JrIGtleSBpcyB1cGRhdGVkIGJ5
IGEgY29uZmlndXJhdGlvbiBjbGllbnQNCj4gCSAgZHVyaW5nIGtleSByZWZyZXNoIHByb2NlZHVy
ZS4NCj4gDQo+IEFsc28sIGVhY2ggc2F2ZWQgbmV0d29yayBrZXkgaXMgYWNjb21wYW5pZWQgYnkg
YSBwcm9wZXIga2V5DQo+IHJlZnJlc2ggcGhhc2Ugc2V0dGluZy4NCj4gDQo+IEluZ2EgU3RvdGxh
bmQgKDUpOg0KPiAgIG1lc2g6IFNlcGFyYXRlIGZ1bmN0aW9ucyBmb3IgbmV0IGtleSBhZGQgYW5k
IHVwZGF0ZQ0KPiAgIG1lc2g6IEFkZCBmdW5jdGlvbiB0byByZXN0b3JlIG5ldCBrZXkgc3RhdGUg
ZnJvbSBzdG9yYWdlDQo+ICAgbWVzaDogRGVjbGFyZSBpbnRlcm5hbCBmdW5jdGlvbnMgYXMgc3Rh
dGljDQo+ICAgbWVzaDogU2F2ZSBrZXkgcmVmcmVzaCBwaGFzZSBzdGF0ZSB0byBub2RlIGNvbmZp
ZyBmaWxlDQo+ICAgbWVzaDogU2F2ZSBuZXdseSBhZGRlZCBvciB1cGRhdGVkIG5ldCBrZXkgdG8g
Y29uZmlnIGZpbGUNCj4gDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8ICAgOCArLQ0KPiAgbWVz
aC9tZXNoLWRiLmMgICAgICAgfCAxNzggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAg
bWVzaC9tZXNoLWRiLmggICAgICAgfCAgIDYgKy0NCj4gIG1lc2gvbmV0LmMgICAgICAgICAgIHwg
MjY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIG1lc2gv
bmV0LmggICAgICAgICAgIHwgIDEyICstDQo+ICBtZXNoL25vZGUuYyAgICAgICAgICB8ICAxOSAr
Ky0NCj4gIG1lc2gvc3RvcmFnZS5jICAgICAgIHwgIDIyICsrLS0NCj4gIG1lc2gvc3RvcmFnZS5o
ICAgICAgIHwgICA3ICstDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDMyNiBpbnNlcnRpb25zKCspLCAx
OTQgZGVsZXRpb25zKC0pDQo+IA==
