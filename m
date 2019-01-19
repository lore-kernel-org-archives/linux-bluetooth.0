Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F138C0031C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA412086D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfASDyZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:54:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:34090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbfASDyZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 22:54:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 19:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,493,1539673200"; 
   d="scan'208,217";a="135938094"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2019 19:54:24 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 18 Jan 2019 19:54:24 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.192]) with mapi id 14.03.0415.000;
 Fri, 18 Jan 2019 19:54:23 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
Thread-Topic: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
Thread-Index: AQHUruB907mn2RpEQk+Pv0BGzoZ1LKW1MTOAgAFMd4A=
Date:   Sat, 19 Jan 2019 03:54:22 +0000
Message-ID: <66b5160a2cbc0daf32990f4878b6a47f81c25479.camel@intel.com>
References: <20190118034652.4018-1-inga.stotland@intel.com>
         <CACumGOLC+b1WsfSqgXLRBQbeZ0vFOx6bpLAFjrpYBXvrQ5oxig@mail.gmail.com>
In-Reply-To: <CACumGOLC+b1WsfSqgXLRBQbeZ0vFOx6bpLAFjrpYBXvrQ5oxig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.106.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D0F71E4BB03A428BCA8889875FB448@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCk9uIEZyaSwgMjAxOS0wMS0xOCBhdCAwNTowNCAtMDMwMCwgVm9uIERlbnR6LCBM
dWl6IHdyb3RlOg0KPiBIaSBJbmdhLA0KPiANCj4gT24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMTI6
NDcgQU0gSW5nYSBTdG90bGFuZCA8DQo+IGluZ2Euc3RvdGxhbmRAaW50ZWwuY29tPiB3cm90ZToN
Cj4gDQo+IFRoaXMgYWRkcyBuZXcgRC1CdXMgcG9saWN5IGZpbGUgYnRtZXNoLmNvbmYNCj4gLS0t
DQo+ICBNYWtlZmlsZS5tZXNoICAgIHwgIDYgKysrKysrDQo+ICBtZXNoL2J0bWVzaC5jb25mIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2Vy
dGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBtZXNoL2J0bWVzaC5jb25mDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvTWFrZWZpbGUubWVzaCBiL01ha2VmaWxlLm1lc2gNCj4gaW5kZXggZWE2YzVl
OTM5Li5lMTU3MTgxMTYgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxlLm1lc2gNCj4gKysrIGIvTWFr
ZWZpbGUubWVzaA0KPiBAQCAtMSw1ICsxLDkgQEANCj4gIGlmIE1FU0gNCj4gDQo+ICtpZiBEQVRB
RklMRVMNCj4gK2RidXNfREFUQSArPSBtZXNoL2J0bWVzaC5jb25mDQo+ICtlbmRpZg0KPiArDQo+
ICBtZXNoX3NvdXJjZXMgPSBtZXNoL21lc2guaCBtZXNoL21lc2guYyBcDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWVzaC9uZXRfa2V5cy5oIG1lc2gvbmV0X2tleXMuYyBcDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzaC9tZXNoLWlvLmggbWVzaC9tZXNo
LWlvLmMgXA0KPiBAQCAtMjcsNCArMzEsNiBAQCBsaWJleGVjX1BST0dSQU1TICs9IG1lc2gvbWVz
aGQNCj4gIG1lc2hfbWVzaGRfU09VUkNFUyA9ICQobWVzaF9zb3VyY2VzKSBtZXNoL21haW4uYw0K
PiAgbWVzaF9tZXNoZF9MREFERCA9IHNyYy9saWJzaGFyZWQtZWxsLmxhICQoZWxsX2xkYWRkKSAt
bGpzb24tYw0KPiAgbWVzaF9tZXNoZF9ERVBFTkRFTkNJRVMgPSAkKGVsbF9kZXBlbmRlbmNpZXMp
IHNyYy9saWJzaGFyZWQtZWxsLmxhDQo+ICsNCj4gK0VYVFJBX0RJU1QgKz0gbWVzaC9idG1lc2gu
Y29uZg0KPiAgZW5kaWYNCj4gZGlmZiAtLWdpdCBhL21lc2gvYnRtZXNoLmNvbmYgYi9tZXNoL2J0
bWVzaC5jb25mDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMC4uZjA1
NTQ1MDY1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvbWVzaC9idG1lc2guY29uZg0KPiBAQCAt
MCwwICsxLDI0IEBADQo+ICs8IS0tIFRoaXMgY29uZmlndXJhdGlvbiBmaWxlIHNwZWNpZmllcyB0
aGUgcmVxdWlyZWQgc2VjdXJpdHkNCj4gcG9saWNpZXMNCj4gKyAgICAgZm9yIEJsdWV0b290aCBN
ZXNoIGRhZW1vbiB0byB3b3JrLiAtLT4NCj4gKw0KPiArPCFET0NUWVBFIGJ1c2NvbmZpZyBQVUJM
SUMgIi0vL2ZyZWVkZXNrdG9wLy9EVEQgRC1CVVMgQnVzDQo+IENvbmZpZ3VyYXRpb24gMS4wLy9F
TiINCj4gKyAiaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvc3RhbmRhcmRzL2RidXMvMS4wL2J1
c2NvbmZpZy5kdGQiPjsNCj4gKzxidXNjb25maWc+DQo+ICsNCj4gKyAgPCEtLSAuLi9zeXN0ZW0u
Y29uZiBoYXZlIGRlbmllZCBldmVyeXRoaW5nLCBzbyB3ZSBqdXN0IHB1bmNoIHNvbWUNCj4gaG9s
ZXMgLS0+DQo+ICsNCj4gKyAgPHBvbGljeSB1c2VyPSJyb290Ij4NCj4gKyAgICA8YWxsb3cgb3du
PSJvcmcuYmx1ZXoubWVzaCIvPg0KPiArICAgIDxhbGxvdyBzZW5kX2Rlc3RpbmF0aW9uPSJvcmcu
Ymx1ZXoubWVzaCIvPg0KPiArICAgIDxhbGxvdyBzZW5kX2ludGVyZmFjZT0ib3JnLmJsdWV6Lm1l
c2guQXBwbGljYXRpb24xIi8+DQo+ICsgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuYmx1
ZXoubWVzaC5FbGVtZW50MSIvPg0KPiArICAgIDxhbGxvdyBzZW5kX2ludGVyZmFjZT0ib3JnLmJs
dWV6Lm1lc2guUHJvdmlzaW9uQWdlbnQxIi8+DQo+ICsgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNl
PSJvcmcuZnJlZWRlc2t0b3AuREJ1cy5PYmplY3RNYW5hZ2VyIi8+DQo+ICsgICAgPGFsbG93IHNl
bmRfaW50ZXJmYWNlPSJvcmcuZnJlZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzIi8+DQo+ICsgIDwv
cG9saWN5Pg0KPiArDQo+ICsgIDxwb2xpY3kgY29udGV4dD0iZGVmYXVsdCI+DQo+ICsgICAgPGFs
bG93IHNlbmRfZGVzdGluYXRpb249Im9yZy5ibHVlei5tZXNoIi8+DQo+ICsgIDwvcG9saWN5Pg0K
PiArDQo+ICs8L2J1c2NvbmZpZz4NCj4gLS0NCj4gMi4xNy4yDQo+IA0KPiBBbnkgcGxhbnMgdG8g
cHV0IHRvZ2V0aGVyIGEgYnRtZXNoLnNlcnZpY2UgZmlsZSBmb3Igc3lzdGVtZCBhcyB3ZWxsPw0K
PiANCj4gDQoNClllcywgYnV0IGZvciBub3cgSSB3b3VsZCBsaWtlIHRvIGhvbGQgb2ZmIHVudGls
IG1lc2ggZGFlbW9uIGFuZA0KYmx1ZXRvb3RoZCBjYW4gY28tZXhpc3Qgb24gb25lIGNvbnRyb2xs
ZXIuIEN1cnJlbnRseSwgbWVzaCBkYWVtb24NCnJlcXVpcmVzIGEgc29sZSBvd25lcnNoaXAgb2Yg
YW4gaGNpIGRldmljZS4NCg0KUmVnYXJkcywNCkluZ2ENCg==
