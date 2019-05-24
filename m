Return-Path: <SRS0=vizm=TY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E7FC072B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D900A2175B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 15:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbfEXPHQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 May 2019 11:07:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:22433 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388995AbfEXPHQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 May 2019 11:07:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:07:15 -0700
X-ExtLoop1: 1
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2019 08:07:15 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 24 May 2019 08:07:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.144]) with mapi id 14.03.0415.000;
 Fri, 24 May 2019 08:07:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/6] mesh: Add App and Net Key Refresh keyring
 back-end
Thread-Topic: [PATCH BlueZ v3 0/6] mesh: Add App and Net Key Refresh keyring
 back-end
Thread-Index: AQHVEYJ6XQUZ/m9kQkqu1WpqtU6AoaZ61w4A
Date:   Fri, 24 May 2019 15:07:14 +0000
Message-ID: <1558710432.332.21.camel@intel.com>
References: <20190523161329.13017-1-brian.gix@intel.com>
In-Reply-To: <20190523161329.13017-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.78.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA0837B0C2BCE448D1135523C7D12F2@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gVGh1LCAyMDE5LTA1LTIzIGF0IDA5OjEzIC0wNzAwLCBC
cmlhbiBHaXggd3JvdGU6DQo+IFRoaXMgaXMgdmVyc2lvbiAzIG9mIHRoZSBwYXRjaCBzZXQgdGhh
dCBub3cgaW1wbGVtZW50cyB0aGUgZm9sbG93aW5nOg0KPiANCj4gT24gaW50ZXJmYWNlIG9yZy5i
bHVlei5tZXNoLk1hbmFnZW1lbnQxOg0KPiAgICAgQ3JlYXRlU3VibmV0KCkNCj4gICAgIEltcG9y
dFN1Ym5ldCgpDQo+ICAgICBVcGRhdGVTdWJuZXQoKQ0KPiAgICAgRGVsZXRlU3VibmV0KCkNCj4g
ICAgIENyZWF0ZUFwcEtleSgpDQo+ICAgICBJbXBvcnRBcHBLZXkoKQ0KPiAgICAgVXBkYXRlQXBw
S2V5KCkNCj4gICAgIERlbGV0ZUFwcEtleSgpDQo+ICAgICBDb21wbGV0ZUFwcEtleVVwZGF0ZSgp
DQo+ICAgICBTZXRLZXlQaGFzZSgpDQo+ICAgICBJbXBvcnRSZW1vdGVOb2RlKCkNCj4gICAgIERl
bGV0ZVJlbW90ZU5vZGUoKQ0KPiANCj4gQnJpYW4gR2l4ICg2KToNCj4gICBtZXNoOiBBZGQgbmV3
IG1ldGhvZCBmb3IgS2V5IFJlZnJlc2ggcHJvY2VkdXJlDQo+ICAgbWVzaDogQ2VudHJhbGl6ZSBk
ZWZpbml0aW9uIG9mIFBSSU1BUllfTkVUX0lEWA0KPiAgIG1lc2g6IEltcGxlbWVudCBOZXQgS2V5
IGtleXJpbmcgc3RvcmFnZSBoYW5kbGluZw0KPiAgIG1lc2g6IEltcGxlbWVudCBBcHAgS2V5IGtl
eXJpbmcgc3RvcmFnZSBoYW5kbGluZw0KPiAgIG1lc2g6IEltcGxlbWVudCBLZXkgUmVmcmVzaCBQ
aGFzaW5nIGluIGtleXJpbmcNCj4gICBtZXNoOiBJbXBsZW1lbnQgcmVtb3RlIGRldiBrZXkgbWV0
aG9kcyBmb3Iga2V5cmluZw0KPiANCj4gIGRvYy9tZXNoLWFwaS50eHQgfCAgNjYgKysrKysrKysr
Ky0tLS0NCj4gIG1lc2gvbWFuYWdlci5jICAgfCAyNjQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgbWVzaC9tZXNoLWRlZnMuaCB8ICAg
MSArDQo+ICBtZXNoL25vZGUuYyAgICAgIHwgIDEyICsrLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
ODUgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRpb25zKC0pDQo+IA==
