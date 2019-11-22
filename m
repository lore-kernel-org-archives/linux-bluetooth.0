Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE2C432C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 18:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1A2067D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 18:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKVSvf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:51:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:13055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfKVSvf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 13:51:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 10:51:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="290729125"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2019 10:51:34 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 10:51:34 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.179]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.101]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 10:51:33 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "sbrown@ewol.com" <sbrown@ewol.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix signatures in agent
 methods
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix signatures in agent
 methods
Thread-Index: AQHVoVEz43y0nYsobkG4B1pHOf/jBaeYCSUAgAAGCwA=
Date:   Fri, 22 Nov 2019 18:51:33 +0000
Message-ID: <449b9dd28ae865706ef60a011e3ecbf9f26c4fdc.camel@intel.com>
References: <20191122162331.10096-1-inga.stotland@intel.com>
         <66904b9fe3f94ab7bf7fbe173b6d46486a2da6af.camel@ewol.com>
In-Reply-To: <66904b9fe3f94ab7bf7fbe173b6d46486a2da6af.camel@ewol.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.140.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <512D5452753477479F57613055CA968E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgU3RldmUsDQoNCk9uIEZyaSwgMjAxOS0xMS0yMiBhdCAxMToyOSAtMDcwMCwgU3RldmUgQnJv
d24gd3JvdGU6DQo+IEhpIEluZ2EsDQo+IA0KPiBPbiBGcmksIDIwMTktMTEtMjIgYXQgMDg6MjMg
LTA4MDAsIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+ID4gVGhpcyByZW1vdmVzIGFuIGV4dHJhIHJl
dHVybiBwYXJhbWV0ZXIgZnJvbSBQcm9tcHROdW1lcmljIGFuZA0KPiA+IFByb21wdFN0YXRpYw0K
PiA+IG1ldGhvZCBzaWduYXR1cmVzLiBBbHNvLCBzdHlsZSBmaXhlcy4NCj4gPiAtLS0NCj4gPiAg
dG9vbHMvbWVzaC1jZmdjbGllbnQuYyB8IDkgKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMgYi90b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+ID4gaW5k
ZXggMWM2MTdhMzdiLi4yMDBlYjViODQgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvbWVzaC1jZmdj
bGllbnQuYw0KPiA+ICsrKyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4gPiANCj4gDQo+IFNJ
R1NFR1Ygc3RpbGwgZ29uZS4NCj4gDQo+IEkgdGVzdGVkIGJvdGggdGhlIHByb21wdF9udW1lcmlj
X2NhbGwgYW5kIHByb21wdF9zdGF0aWNfY2FsbCBwYXRocyBhbmQNCj4gdGhleSB3b3JrIGFzIGV4
cGVjdGVkLiBJIHVzZWQgdGhlIFplcGh5ciBvbm9mZi1hcHAgZm9yIHRlc3RpbmcuDQo+IA0KPiBJ
IHRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSByZWZlcnMgdG8gdGhlIFYxIHBhdGNoLg0KPiANCj4g
U3RldmUNCj4gDQoNClRoYW5rIHlvdSBmb3IgY29uZmlybWluZy4gWWVzLCB3aWxsIGZpeCB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQoNCkJlc3QgcmVnYXJkcywNCkluZ2ENCg==
