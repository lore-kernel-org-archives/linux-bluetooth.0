Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A8C0031C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE20C2086D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfASDtp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:49:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:18133 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfASDtp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 22:49:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 19:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,493,1539673200"; 
   d="scan'208,217";a="109429613"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2019 19:49:44 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 18 Jan 2019 19:49:43 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.248]) with mapi id 14.03.0415.000;
 Fri, 18 Jan 2019 19:49:43 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
Thread-Topic: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
Thread-Index: AQHUruB907mn2RpEQk+Pv0BGzoZ1LKW1PjOAgAE+K4A=
Date:   Sat, 19 Jan 2019 03:49:43 +0000
Message-ID: <2700dbe29b92b23991c881dbf46ec55d8f326486.camel@intel.com>
References: <20190118034652.4018-1-inga.stotland@intel.com>
         <437FB2B8-80F7-4DE1-86E8-880AA307B618@holtmann.org>
In-Reply-To: <437FB2B8-80F7-4DE1-86E8-880AA307B618@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.106.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0472B80C3BC19F409A0B2006121C1CAC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpPbiBGcmksIDIwMTktMDEtMTggYXQgMDk6NTAgKzAxMDAsIE1hcmNlbCBI
b2x0bWFubiB3cm90ZToNCj4gSGkgSW5nYSwNCj4gDQo+IFRoaXMgYWRkcyBuZXcgRC1CdXMgcG9s
aWN5IGZpbGUgYnRtZXNoLmNvbmYNCj4gLS0tDQo+IE1ha2VmaWxlLm1lc2ggICAgfCAgNiArKysr
KysNCj4gbWVzaC9idG1lc2guY29uZiB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAy
IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IG1l
c2gvYnRtZXNoLmNvbmYNCj4gDQo+IGRpZmYgLS1naXQgYS9NYWtlZmlsZS5tZXNoIGIvTWFrZWZp
bGUubWVzaA0KPiBpbmRleCBlYTZjNWU5MzkuLmUxNTcxODExNiAxMDA2NDQNCj4gLS0tIGEvTWFr
ZWZpbGUubWVzaA0KPiArKysgYi9NYWtlZmlsZS5tZXNoDQo+IEBAIC0xLDUgKzEsOSBAQA0KPiBp
ZiBNRVNIDQo+IA0KPiAraWYgREFUQUZJTEVTDQo+ICtkYnVzX0RBVEEgKz0gbWVzaC9idG1lc2gu
Y29uZg0KPiArZW5kaWYNCj4gKw0KPiANCj4gSSBwcmVmZXIgdGhpcyBpcyBuYW1lZCBibHVldG9v
dGgtbWVzaC5jb25mLg0KPiANCj4gQW5kIGZvciB0aGUgZGFlbW9uIGJpbmFyeSBuYW1lIHRoaXMg
bWlnaHQgYmUgYmV0dGVyIGFzIGJsdWV0b290aGQtbWVzaCBpbnN0ZWFkIG9mIGp1c3QgbWVzaGQu
DQoNCkFncmVlZDogbWFrZXMgaXQgZWFzaWVyIGZpbmRpbmcgdGhlIHByb2Nlc3MgYnkgbmFtZQ0K
DQo+IA0KPiBtZXNoX3NvdXJjZXMgPSBtZXNoL21lc2guaCBtZXNoL21lc2guYyBcDQo+IAkJCQlt
ZXNoL25ldF9rZXlzLmggbWVzaC9uZXRfa2V5cy5jIFwNCj4gCQkJCW1lc2gvbWVzaC1pby5oIG1l
c2gvbWVzaC1pby5jIFwNCj4gQEAgLTI3LDQgKzMxLDYgQEAgbGliZXhlY19QUk9HUkFNUyArPSBt
ZXNoL21lc2hkDQo+IG1lc2hfbWVzaGRfU09VUkNFUyA9ICQobWVzaF9zb3VyY2VzKSBtZXNoL21h
aW4uYw0KPiBtZXNoX21lc2hkX0xEQUREID0gc3JjL2xpYnNoYXJlZC1lbGwubGEgJChlbGxfbGRh
ZGQpIC1sanNvbi1jDQo+IG1lc2hfbWVzaGRfREVQRU5ERU5DSUVTID0gJChlbGxfZGVwZW5kZW5j
aWVzKSBzcmMvbGlic2hhcmVkLWVsbC5sYQ0KPiArDQo+ICtFWFRSQV9ESVNUICs9IG1lc2gvYnRt
ZXNoLmNvbmYNCj4gZW5kaWYNCj4gZGlmZiAtLWdpdCBhL21lc2gvYnRtZXNoLmNvbmYgYi9tZXNo
L2J0bWVzaC5jb25mDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMC4u
ZjA1NTQ1MDY1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvbWVzaC9idG1lc2guY29uZg0KPiBA
QCAtMCwwICsxLDI0IEBADQo+ICs8IS0tIFRoaXMgY29uZmlndXJhdGlvbiBmaWxlIHNwZWNpZmll
cyB0aGUgcmVxdWlyZWQgc2VjdXJpdHkgcG9saWNpZXMNCj4gKyAgICAgZm9yIEJsdWV0b290aCBN
ZXNoIGRhZW1vbiB0byB3b3JrLiDigJQ+DQo+IA0KPiBMb3dlciBjYXNlIOKAnG1lc2jigJ0gaGVy
ZS4NCj4gDQo+ICsNCj4gKzwhRE9DVFlQRSBidXNjb25maWcgUFVCTElDICItLy9mcmVlZGVza3Rv
cC8vRFREIEQtQlVTIEJ1cyBDb25maWd1cmF0aW9uIDEuMC8vRU4iDQo+ICsgImh0dHA6Ly93d3cu
ZnJlZWRlc2t0b3Aub3JnL3N0YW5kYXJkcy9kYnVzLzEuMC9idXNjb25maWcuZHRkIj4NCj4gKzxi
dXNjb25maWc+DQo+ICsNCj4gKyAgPCEtLSAuLi9zeXN0ZW0uY29uZiBoYXZlIGRlbmllZCBldmVy
eXRoaW5nLCBzbyB3ZSBqdXN0IHB1bmNoIHNvbWUgaG9sZXMgLS0+DQo+ICsNCj4gKyAgPHBvbGlj
eSB1c2VyPSJyb290Ij4NCj4gKyAgICA8YWxsb3cgb3duPSJvcmcuYmx1ZXoubWVzaCIvPg0KPiAr
ICAgIDxhbGxvdyBzZW5kX2Rlc3RpbmF0aW9uPSJvcmcuYmx1ZXoubWVzaCIvPg0KPiArICAgIDxh
bGxvdyBzZW5kX2ludGVyZmFjZT0ib3JnLmJsdWV6Lm1lc2guQXBwbGljYXRpb24xIi8+DQo+ICsg
ICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuYmx1ZXoubWVzaC5FbGVtZW50MSIvPg0KPiAr
ICAgIDxhbGxvdyBzZW5kX2ludGVyZmFjZT0ib3JnLmJsdWV6Lm1lc2guUHJvdmlzaW9uQWdlbnQx
Ii8+DQo+ICsgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuZnJlZWRlc2t0b3AuREJ1cy5P
YmplY3RNYW5hZ2VyIi8+DQo+ICsgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuZnJlZWRl
c2t0b3AuREJ1cy5Qcm9wZXJ0aWVz4oCdLz4NCj4gDQo+IERvIHlvdSBuZWVkIHRoZSBsYXN0IHR3
bz8NCg0KTm90IHJlYWxseS4gV2lsbCByZW1vdmUuDQoNCj4gDQo+ICsgIDwvcG9saWN5Pg0KPiAr
DQo+ICsgIDxwb2xpY3kgY29udGV4dD0iZGVmYXVsdCI+DQo+ICsgICAgPGFsbG93IHNlbmRfZGVz
dGluYXRpb249Im9yZy5ibHVlei5tZXNoIi8+DQo+ICsgIDwvcG9saWN5Pg0KPiArDQo+ICs8L2J1
c2NvbmZpZz4NCj4gDQo+IFJlZ2FyZHMNCj4gDQo+IE1hcmNlbA0KPiANCg0KVGhhbmtzLA0KSW5n
YQ0K
