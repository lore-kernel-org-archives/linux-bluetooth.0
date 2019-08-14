Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D96C32753
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F0208C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 16:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHNQlw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:41:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:53981 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfHNQlw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 12:41:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 09:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="176627061"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2019 09:41:51 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 09:41:50 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 09:41:50 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Thread-Topic: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Thread-Index: AQHVUkHFvJ8+Ufu0XkWdTJqFRbJnc6b6uyMAgACUCIA=
Date:   Wed, 14 Aug 2019 16:41:49 +0000
Message-ID: <dbffabec9a869204b4de1aab645fd727949e655e.camel@intel.com>
References: <20190814014357.32453-1-brian.gix@intel.com>
         <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
In-Reply-To: <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.104.160]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0072223D87980B42923DC98412959F60@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwgDQoNCkkgd291bGQgbGlrZSBNYXJjZWwgdG8gd2VpZ2ggaW4gb24gdGhpcyBz
aW5jZSB0aGUgc2VjdXJpdHkgb2YgZXhwb3Npbmcga2V5cyB2aWEgRC1CdXMgd2FzIGluaXRpYWxs
eSBhIGNvbmNlcm4NCnJhaXNlZCBieSBoaW0uDQoNCkFsc28sIHdlIG1heSBiZSBhYmxlIHRvIGxl
YXZlIGl0IGluIHRoZSBoYW5kcyBvZiB0aGUgQXBwbGljYXRpb24gdGhhdCBvd25zIHRoZSBub2Rl
LiAgSXQgY291bGQgYmUgYXMgc2ltcGxlIGFzDQp0aGUgQXBwbGljYXRpb24gZGVjaWRlcyB0byBz
ZWN1cmUgdGhlIEQtQnVzIGNoYW5uZWwgKGZvciBvbmx5IGl0c2VsZikgYnkgcGVyZm9ybWluZyB0
aGUgUHVibGljIEtleSBFeGNoYW5nZS4NCg0KSWYgdGhlIEFwcGxpY2F0aW9uIGRvZXMgKm5vdCog
cmVxdWVzdCBhIFB1YmxpYyBLZXkgZnJvbSB0aGUgRGFlbW9uLCBhbmQvb3IgZG9lcyBub3Qgc3Vw
cGx5IGEgUHVibGljIEtleSBkdXJpbmcNCkF0dGFjaC9Kb2luL0ltcG9ydCwgdGhlbiB0aGUgQVBJ
cyB3b3JrIHRoZSBzYW1lIGFzIHRoZXkgZG8gdG9kYXkgKGFsYmVpdCB3aXRoIGV4dHJhIGlnbm9y
ZWQgcGFyYW1ldGVyKHMpKS4NCg0KQW4gYXBwIHRoYXQga25vd3MgaXQgaXMgb3BwZXJhdGluZyBp
biBhIHNlY3VyZSBlbnZpcm9ubWVudCBjYW4gdGhlbiB0cnVzdCB0aGUgc3lzdGVtIHRvIHByb3Zp
ZGUgYWxsIG5lZWRlZA0Kc2VjdXJpdHksIGJ1dCBpZiBmb3IgaW5zdGFuY2UsIHNvbWUgc29ydCBv
ZiBoeWJyaWQgRC1CdXMgdGhhdCBoYXMgYW4gaW5zZWN1cmUgbGluayBpbiB0aGUgY2hhaW4sIHRo
d2UgQXBwIGNhbg0KYWRkIHRoZSBQdWJsaWMgS2V5IGV4Y2hhbmdlIGFuZCBlbmNyeXB0L2RlY3J5
cHQgYXMgbmVlZGVkLg0KDQotLUJyaWFuDQoNCk9uIFdlZCwgMjAxOS0wOC0xNCBhdCAwOTo1MiAr
MDIwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IEhpIEJyaWFuLA0KPiANCj4g
T24gMDgvMTMsIEJyaWFuIEdpeCB3cm90ZToNCj4gPiBUaGVyZSBhcmUgdmFyaW91cyAic2VjdXJp
dHkgc2Vuc2l0aXZlIiBwaWVjZXMgb2YgZGF0YSB0aGF0IG5lZWQgdG8gYmUNCj4gPiBleGNoYW5n
ZWQgYmV0d2VlbiBBcHBsaWNhdGlvbnMgYW5kIHRoZSBCbHVldG9vdGggTWVzaCBkYWVtb24uDQo+
ID4gDQo+ID4gVGhlIGZvbGxvd2luZyBpdGVtcyB3aWxsIGJlIGVuY3J5cHRlZCBiZWZvcmUgc2Vu
ZGluZyBvdmVyIEQtQnVzOg0KPiA+IA0KPiA+IHRva2VuIC0tICBUaGlzIGlzIHVzZWQgYnkgYWxs
IG5vZGVzLg0KPiA+IA0KPiA+IG5ldF9rZXlzLCBhcHBfa2V5cywgZGV2X2tleXMgLS0gVGhlc2Ug
d2lsbCBvbmx5IHR5cGljYWxseSBiZSBuZWVkZWQgYnkNCj4gPiBQcm92aXNpb25lci9Db25maWcg
Q2xpZW50IG5vZGVzIHRvIGV4dHJhY3QgdGhlIGtleXMgZm9yIHB1cnBvc2VzIG9mDQo+ID4gQ3Bv
bmZpZ3VyYXRpb24gRGF0YWJhc2UgdHJhbnNmZXIuDQo+IFBsZWFzZSBkb24ndC4NCj4gDQo+IEkg
ZG9uJ3Qgc2VlIGFueSBiZW5lZml0IGZyb20gZG9pbmcgc28uIEQtQnVzIHRyYWZmaWMgY2Fubm90
IGJlIHNuaWZmZWQNCj4gYnkgYW4gdW5wcml2aWxlZ2VkIHVzZXIsIGFuZCBwcml2aWxlZ2VkIHVz
ZXIgYWxyZWFkeSBoYXMgYWNjZXNzIHRvIHRoZQ0KPiBzdG9yYWdlIGFuZCBjYW4gZXh0cmFjdCBh
bGwgdGhpcyBpbmZvcm1hdGlvbiBmcm9tIHRoZXJlLg0KPiANCj4gSW4gbXkgb3BpbmlvbiB0aGVy
ZSBpcyBsaXR0bGUgcG9pbnQgaW4gZW5jcnlwdGluZyBELUJ1cyB0cmFmZmljLiBOb29uZQ0KPiBl
bHNlIGRvZXMgdGhhdDoNCj4gDQo+ICAtIENvbm5NYW4gc2VuZHMgbG9naW4vcGFzc3dvcmQgcGFp
cnMgb3ZlciBELUJ1cyBpbg0KPiAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbmV0
d29yay9jb25ubWFuL2Nvbm5tYW4uZ2l0L3RyZWUvZG9jL3Zwbi1hZ2VudC1hcGkudHh0DQo+ICAt
IEJsdWVaIHNlbmRzIHBhaXJpbmcgc2VjcmV0cyBpbg0KPiAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vYmx1ZXRvb3RoL2JsdWV6LmdpdC90cmVlL2RvYy9hZ2VudC1hcGkudHh0DQo+
IA0KPiByZWdhcmRzDQo=
