Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BDC7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA7208C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfGRQg7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:36:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:55484 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGRQg6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 12:36:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 09:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,278,1559545200"; 
   d="scan'208";a="173231087"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2019 09:36:58 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.142]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 09:36:57 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Thread-Topic: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Thread-Index: AQHVPR16GZYb6Nxn8UK5gNi+3g77/6bQiU2AgAAHs8A=
Date:   Thu, 18 Jul 2019 16:36:57 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBD3EA6@ORSMSX103.amr.corp.intel.com>
References: <20190718040126.5152-1-inga.stotland@intel.com>
 <20190718085923.4ljvk3t3avqdh24d@mlowasrzechonek2133>
In-Reply-To: <20190718085923.4ljvk3t3avqdh24d@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjJjOWFhMzUtYzkzYi00OTY3LWE2ODEtMGY2YmJjNzBiYzZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSEgxZTVuYnZpYzl4V0ZYeE1CTEVGN1lyTTlJRmY1QTJGZXl5T0RFUWVkNFwvbWhwdDdDM0N3WnZaclwvVmlzUGtWIn0=
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwgTWljaGFsLA0KDQo+IE9uIDA3LzE3LCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiA+
VGhpcyBhZGRzIGluaXRpYWxpemF0aW9uIG9mIGtleXJpbmcgc3RvcmFnZSBkaXJlY3Rvcnkgd2hl
biBhIG1lc2ggbm9kZQ0KPiA+aXMgYXR0YWNoZWQgc3VjY2Vzc2Z1bGx5Lg0KPiA+LS0tDQo+ID4g
bWVzaC9ub2RlLmMgfCA4ICsrKysrKysrDQo+ID4NCj4gPisJCS8qDQo+ID4rCQkgKiBUT0RPOiBG
b3Igbm93IGFsd2F5cyBpbml0aWFsaXplIGRpcmVjdG9yeSBmb3Igc3RvcmluZw0KPiA+KwkJICog
a2V5cmluZyBpbmZvLiBOZWVkIHRvIGZpZ3VyZSBvdXQgd2hhdCBjaGVja3MgbmVlZA0KPiA+KwkJ
ICogdG8gYmUgcGVyZm9ybWVkIHRvIGRvIHRoaXMgY29uZGl0aW9uYWxseSwgaS5lLiwgcHJlc2Vu
Y2Ugb2YNCj4gPisJCSAqIFByb3Zpc2lvbmVyIGludGVyZmFjZSwgZXRjLg0KPiA+KwkJICovDQo+
ID4rCQlpbml0X3N0b3JhZ2VfZGlyKG5vZGUpOw0KPiANCj4gSSB0aGluayB0aGUga2V5cmluZyBz
aG91bGQgYmUgaW5pdGlhbGl6ZWQgYXMgc29vbiBhZCB0aGUgbm9kZSBpcyBjcmVhdGVkLiBUaGUN
Cj4ga2V5cmluZyBzaG91bGQgYWx3YXlzIGV4aXN0LCBhbmQgc2hvdWxkIGNvbnRhaW4gYXQgbGVh
c3QgdGhlIGxvY2FsIGRldmljZSBrZXkgLQ0KPiBvdGhlcndpc2UgRGV2S2V5U2VuZCBjYW4ndCBi
ZSB1c2VkIHRvIHRhbGsgdG8gbG9jYWwgQ29uZmlnIFNlcnZlci4NCg0KSSBhZ3JlZSB0aGF0IHRo
ZSBrZXlyaW5nIHNob3VsZCBwcm9iYWJseSBhbHdheXMgZXhpc3QsIGJ1dCBub3QgcmVhbGx5IGZv
ciB0aGUgcmVhc29uIE1pY2hhbCBzdGF0ZXMuLi4gICBUaGVyZSBhcmUgbm8gdXNlIGNhc2UgYWxs
b3dlZCBpbiB0aGUgc3BlY2lmaWNhdGlvbiB0aGF0IGFsbG93cyBhbnkgQ29uZmlnIENsaWVudCBl
eGNlcHQgYW4gYXV0aG9yaXplZCBQcm92aXNpb25lciB0byBjb21tdW5pY2F0ZSB3aXRoIGEgQ29u
ZmlnIFNlcnZlciAoZXZlbiB0aGUgbG9jYWwgQ29uZmlnIFNlcnZlcikuLi4gICBBbnkgY2hhbmdl
cyB0byBhIG5vZGVzIGNvbmZpZ3VyYXRpb24gc3RhdGVzIHNob3VsZCBiZSB0cmFja2VkIGJ5IHBy
b3Zpc2lvbmVycyBpbiBhIG1hc3RlciBkYXRhYmFzZSwgYW5kIHRoaXMgaXMgbm90IHJlYWxseSBw
b3NzaWJsZSBpZiBhbnkgbm9kZSBpcyBhbGxvd2VkIHRvIGNoYW5nZSBpdCdzIG93biBDRkcgU2Vy
dmVyIHN0YXRlcy4NCg0KVGhhdCBzYWlkLCBBIG5vZGUgY2FuIGhhdmUgY29uZmlndXJhdGlvbiBw
cml2aWxlZ2VzICp0cmFuc2ZlcnJlZCogdG8gaXQsIGFuZCBpdCBpcyBub3QgdGhlIHJlc3BvbnNp
YmlsaXR5IG9mIHRoZSBkYWVtb24gdG8gZGV0ZXJtaW5lIHdoZW4gdGhpcyBpcy4gIEkgYW0gZmlu
ZSB3aXRoIGNyZWF0aW5nIGFuIChlbXB0eSkga2V5IHJpbmcgZm9yIGFsbCBub2Rlcy4uLi4gIHdo
aWNoIGluIHRoZSBjdXJyZW50IGFyY2hpdGVjdHVyZSBqdXN0IG1lYW5zIGEgZmV3IGVtcHR5IGZv
bGRlcnMuDQoNCg0KPiANCj4gLS0NCj4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5s
b3dhcy1yemVjaG9uZWtAc2lsdmFpci5jb20+DQo+IFNpbHZhaXIgaHR0cDovL3NpbHZhaXIuY29t
DQo+IEphc25vZ8OzcnNrYSA0NCwgMzEtMzU4IEtyYWtvdywgUE9MQU5EDQo=
