Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D74C10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530E1217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 21:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfDRVo1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:44:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:65452 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDRVo0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 17:44:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 14:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="137001369"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga006.jf.intel.com with ESMTP; 18 Apr 2019 14:44:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.183]) with mapi id 14.03.0415.000;
 Thu, 18 Apr 2019 14:44:25 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
Thread-Topic: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
Thread-Index: AQHU88R1+Q+URVzudUSwAtCzCAe+DKZAUQcAgABN2rCAAYDcAIAAzdiA
Date:   Thu, 18 Apr 2019 21:44:24 +0000
Message-ID: <1555623863.31619.4.camel@intel.com>
References: <20190415194946.13121-1-brian.gix@intel.com>
         <20190415194946.13121-2-brian.gix@intel.com>
         <20190417055132.scxvzhusx2suasdv@kynes>
         <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
         <20190418092738.wdohlkvcej5ffw5x@scytale>
In-Reply-To: <20190418092738.wdohlkvcej5ffw5x@scytale>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.112.76]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E4B66446A1E5E498D733BF7E340D337@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBUaHUsIDIwMTktMDQtMTggYXQgMTE6MjcgKzAyMDAsIE1pY2hhbCBM
b3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IEhpIEJyaWFuLA0KPiANCj4gT24gMDQvMTcsIEdpeCwg
QnJpYW4gd3JvdGU6DQo+ID4gVGhlIG1lc3NhZ2VzIHdoZXJlIGtleXMgYXJlIGV4cGxpY2l0bHkg
c2VudCBvdmVyLXRoZS1haXIgYXJlIHRoZSBvbmx5DQo+ID4gbWVzc2FnZXMgd2UgYW50aWNpcGF0
ZSBwcm92aWRpbmcgc3BlY2lmaWMgRC1CdXMgbWV0aG9kcyBmb3IgdG8NCj4gPiBtaW5pbWl6ZSBE
LUJ1cyBBUEkgYmxvYXQuDQo+ID4gKC4uLikNCj4gPiBUaGUgZXh0ZXJuYWwgQ29uZmlnIENsaWVu
dCBBcHAgaXMgcmVzcG9uc2libGUgZm9yOg0KPiA+ICogZGVjaWRpbmcgKndoZW4qIHRvIHNlbmQg
QXBwIGFuZCBOZXQga2V5IGFkZHMgYW5kIHVwZGF0ZXMNCj4gPiAqIHNlbmRpbmcgYWxsIHB1Yi9z
dWIvYmluZGluZy9mZWF0dXJlIHNldHRpbmdzDQo+ID4gDQo+ID4gc28gaW4gdGhpcyBjYXNlLCB0
aGUgY29udHJvbGxpbmcgQ29uZmlnIENsaWVudCBBcHAgd2lsbCBiZSBjb21wb3NpbmcNCj4gPiBh
bGwgQ29uZmlnIENsaWVudCBtZXNzYWdlcyAoZXhjZXB0IGZvciBPVEEga2V5IG1lc3NhZ2VzKQ0K
PiANCj4gU28gaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdG8gYWRkIGEgbmV3IGFwcGxpY2F0
aW9uIGtleSBvbmUgd291bGQNCj4gbmVlZCB0byBlaXRoZXI6DQo+ICAtIGNhbGwgQ3JlYXRlQXBw
S2V5IHRvIGhhdmUgdGhlIGRhZW1vbiBnZW5lcmF0ZSBhIG5ldyBhcHBsaWNhdGlvbiBrZXkNCj4g
ICAgaW50ZXJuYWxseS4NCj4gIC0gbWFudWFsbHkgY3JlYXRlIGFjY2VzcyBsYXllciBwYXlsb2Fk
IGZvciBDb25maWcgQ2xpZW50IEFwcCBLZXkgQWRkDQo+ICAgIG1lc3NhZ2UsIHRoZW4gc2VuZCBp
dCB0byB0aGUgbG9jYWwgbm9kZSB2aWEgbG9vcGFjaw0KDQoNCkFjdHVhbGx5IG5vLiBUaGUgQ29u
ZmlnIENsaWVudCBsb29wYmFjayB0byB0aGUgbG9jYWwgbm9kZSBpcyBpbnRlbmRlZCB0byBqdXN0
IGFkZCBrZXlzIHRvIHRoZSBsb2NhbCBub2RlIENvbmZpZw0KU2VydmVyLiAgU2luY2UgaXQgc2Vl
bXMgcmVhc29uYWJsZSB0byBhZGQgZXh0ZXJuYWxseSBnZW5lcmF0ZWQgQXBwIGFuZCBOZXQga2V5
cyB0byB0aGUgbG9jYWwgbmFkZXMga2V5IHJpbmcsIEkNCndpbGwgYWxzbyBhZGQgaW1wb3J0cyBm
b3IgdGhvc2UgdHdvIGtleSB0eXBlcy4NCg0KPiANCj4gQWZ0ZXIgb25lIG9mIHRoZXNlIG9wZXJh
dGlvbnMsIHRoZSBrZXkgY2FuIGJlIHNlbnQgdG8gcmVtb3RlIG5vZGVzIHVzaW5nDQo+IEFkZEFw
cEtleSBBUEkuDQo+IA0KPiBUaGlzIHNlZW1zIGEgYml0IGFzc3ltZXRyaWM6IHRoZSBhcHBsaWNh
dGlvbiB0aGF0IHdvdWxkIGxpa2UgdG8gYWN0IGFzIGENCj4gQ29uZmlnIENsaWVudCB3b3VsZCBu
ZWVkIHRvIHVzZSBhIG1peHR1cmUgb2YgbWFudWFsbHkgY29uc3RydWN0ZWQNCj4gYWNjZXNzIHBh
eWxvYWRzIChlLmcuIHRvIGNvbmZpZ3VyZSBiaW5kcyBhbmQgc3Vic2NyaXB0aW9ucykgYW5kIGEN
Cj4gaGlnaGVyLWxldmVsIEFQSXMgdXNlZCB0byBhZGQga2V5cy4NCj4gDQo+IEkgdGhpbmsgaXQg
d291bGQgYmUgY2xlYW5lciB0byBoYXZlIHRoZSBhcHBsaWNhdGlvbiB1c2UganVzdCB0aGUgQVBJ
LA0KPiBhbmQgcmVsaWV2ZSBpdCBvZiByZXF1aXJlbWVudCB0byBpbXBsZW1lbnQgQ29uZmlnIENs
aWVudCBtZXNzYWdlcywNCj4gZXNwZWNpYWxseSBnaXZlbiB0aGUgZmFjdCB0aGUgZGFlbW9uIGlt
cGxlbWVudHMgQ29uZmlnIFNlcnZlciBpbnRlcm5hbGx5Lg0KPiANCj4gVGhpcyB3b3VsZCBpbmRl
ZWQgbWFrZSB0aGUgQVBJIHN1cmZhY2UgbGFyZ2VyLCB3aGljaCBjZXJ0YWlubHkgaXMgYQ0KPiBk
cmF3YmFjaywgYnV0IEkgdGhpbmsgaXQgd291bGQgbWFrZSBpdCBlYXNpZXIgdG8gaW1wbGVtZW50
IGFjdHVhbA0KPiBhcHBsaWNhdGlvbnMsIGJlY2F1c2UgZm91bmRhdGlvbiAoYW5kICpvbmx5KiBm
b3VuZGF0aW9uKSBtb2RlbHMgKGJvdGgNCj4gc2VydmVycyBhbmQgY2xpZW50cykgd291bGQgYmUg
cHJvdmlkZWQgYnkgdGhlIGRhZW1vbi4NCj4gDQo+IA0KPiBBbm90aGVyIHBvaW50IHdvdWxkIGJl
IGFkZGluZyBleHBsaWNpdCBJbXBvcnROZXRLZXkgYW5kIEltcG9ydEFwcEtleQ0KPiBvcGVyYXRp
b25zLCBzbyB0aGF0IGFuIGFwcGxpY2F0aW9uIHVzaW5nIGV4dGVybmFsIHByb3Zpc2lvbmluZyBk
YXRhYmFzZQ0KPiB3b3VsZCBiZSBhYmxlIHRvIGluamVjdCBrZXlzIGludG8gdGhlIGRhZW1vbidz
IGRhdGFiYXNlIHdpdGhvdXQgc2VuZGluZw0KPiByYXcgQ29uZmlnIENsaWVudCBtZXNzYWdlcy4g
VGhpcyBpcyBzaW1pbGFyIHRvIEltcG9ydCpOb2RlIG9wZXJhdGlvbnMgd2UNCj4gZGlzY3Vzc2Vk
IGJlZm9yZS4NCj4gDQoNClllcywgVGhpcyBeXl5eDQoNCnJlZ2FyZHMsDQpCcmlhbg==
