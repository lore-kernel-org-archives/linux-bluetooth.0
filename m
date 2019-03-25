Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFBC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 07:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CAB2085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 07:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfCYHCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:02:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:47329 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbfCYHCG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 03:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 00:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="143558173"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 00:02:05 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 25 Mar 2019 00:02:05 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.9]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 00:02:05 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
Thread-Topic: [PATCH BlueZ] test: Enable test-mesh to send raw vendor
 commands
Thread-Index: AQHU4GJHdc8JorEkm0eGpwejn4sur6YXrqwAgAB1LgCAAVGLgIABf1YAgAFxJAA=
Date:   Mon, 25 Mar 2019 07:02:04 +0000
Message-ID: <4d74506df8b7ddaf16fb9ab1c98719c47a2dfbe2.camel@intel.com>
References: <20190322034927.6247-1-inga.stotland@intel.com>
         <82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com>
         <2815DD46-4BB1-46DC-881D-1C30200DAED9@intel.com>
         <E232C390-8571-40A5-9E72-2499E9973959@gmail.com>
         <CABBYNZLAau4paWF9yoLXzUzmJnVawDiZWaVZUnwZfGqhRsQnMw@mail.gmail.com>
In-Reply-To: <CABBYNZLAau4paWF9yoLXzUzmJnVawDiZWaVZUnwZfGqhRsQnMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.199.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B579E33336EB2947939A07A54F5D6F23@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwgSm9oYW4sDQoNCk9uIFN1biwgMjAxOS0wMy0yNCBhdCAxMTowMCArMDIwMCwgTHVp
eiBBdWd1c3RvIHZvbiBEZW50eiB3cm90ZToNCj4gSGkgSm9oYW4sIEJyaWFuLA0KPiANCj4gT24g
U2F0LCBNYXIgMjMsIDIwMTkgYXQgMTI6MDggUE0gSm9oYW4gSGVkYmVyZyA8DQo+IGpvaGFuLmhl
ZGJlcmdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIEJyaWFuDQo+IA0KPiBPbiAyMiBNYXIg
MjAxOSwgYXQgMTYuMDAsIEdpeCwgQnJpYW4gPGJyaWFuLmdpeEBpbnRlbC5jb20+IHdyb3RlOg0K
PiANCj4gT24gMjIgTWFyIDIwMTksIGF0IDUuNDksIEluZ2EgU3RvdGxhbmQgPGluZ2Euc3RvdGxh
bmRAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gKyMgICAgICAgNSAtIG9uL29mZiBtb2RlbCBjbGll
bnQgbWVudQ0KPiArIyAgICAgICA2IC0gc2VuZCByYXcgbWVzc2FnZQ0KPiArIyAgICAgICA3IC0g
ZXhpdA0KPiANCj4gUGxlYXNlIGRvbuKAmXQgdXNlIG51bWVyaWMgaWRlbnRpZmllcnMgZm9yIGNv
bW1hbmRzIGluIGludGVyYWN0aXZlDQo+IHRvb2xzLiBVc2UgaW50dWl0aXZlLCBodW1hbiByZWFk
YWJsZSBzdHJpbmdzIGxpa2Ugd2UgZG8gaW4gdGhlIG90aGVyDQo+IGludGVyYWN0aXZlIHRvb2xz
IGluIHRoZSB0cmVlLiBOdW1iZXJzIG1pZ2h0IGJlIGNvbnZlbmllbnQgZm9yDQo+IGNvbXB1dGVy
cywgYnV0IHRoZXnigJlyZSBub3QgcGFydGljdWxhcmx5IGh1bWFuIGZyaWVuZGx5IDopDQo+IA0K
PiBXZSBkbyBwbGFuIG9uIG1ha2luZyBiZXR0ZXIgdG9vbHMsIGJ1dCB0aGlzIGlzIG1vc3RseSBp
bnRlbmRlZCBhcyBhDQo+IHRlc3RlciBzY3JpcHQgdG8gcXVpY2tseSBhbGxvdyB1cyB0byB0ZXN0
IHN0dWZmLCBwYXJ0aWN1bGFybHkgdGhlIGQtDQo+IGJ1cyBBUElzLCBhbmQgZGVtb25zdHJhdGUg
dGhlIHdheSB0aGUgbWV0aG9kcyBhcmUgY2FsbGVkIGZyb20gcHl0aG9uLg0KPiANCj4gVW5kZXJz
dG9vZCwgaG93ZXZlciB3aGF0IEkgcHJvcG9zZWQNCj4gDQo+ICAtIERvZXNu4oCZdCB0YWtlIHJl
YWxseSBhbnkgZXh0cmEgZWZmb3J0DQo+ICAtIElzIGZyaWVuZGxpZXIgdG8gdGhlIHVzZXINCj4g
IC0gSXMgZnJpZW5kbGllciB0byB0aGUgcmVhZGVyIG9mIHRoZSBjb2RlIChubyBuZWVkIHRvIGRv
IG51bWJlcg0KPiBsb29rdXBzIHRvIHVuZGVyc3RhbmQgdGhlIHB1cnBvc2Ugb2YgYSBicmFuY2gp
DQo+ICAtIElzIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgY29kZSBiYXNlDQo+IA0K
PiDigKYgc28gSSBkb27igJl0IHVuZGVyc3RhbmQgd2h5IHlvdSB3b3VsZG7igJl0IHdhbnQgdGhh
dCwgZXZlbiBpZiBpdOKAmXMgYQ0KPiBxdWljayB0ZXN0IHRvb2wgOikNCj4gDQo+ICsxDQo+IA0K
PiANCj4gSSBzdXBwb3NlIHRoZSBsb25nLXRlcm0gaWRlYSBpcyB0byBwcm92aWRlIHRoZSBzYW1l
IGtpbmQgb2YNCj4gaW50ZXJhY3RpdmUgY29tbWFuZC1saW5lIGludGVyZmFjZSBhcyBtZXNoY3Rs
IGhhcyBwcm92aWRlZCBmb3INCj4gcHJvdmlzaW9uZXIgYW5kIGNvbmZpZ3VyYXRpb24gY2xpZW50
IHJvbGU/IEluIGZhY3QsIHdvdWxkIGl0IG1ha2UNCj4gc2Vuc2UgdG8ga2VlcCB1c2luZyBtZXNo
Y3RsIGZvciB0aGF0IGFuZCBoaWRlIHRoZSBkZXRhaWwgd2hldGhlcg0KPiBzdHVmZiBpcyBnb2lu
ZyB2aWEgbWVzaGQgb3Igbm90Pw0KPiANCj4gVGhlcmUgaXMgYWN0dWFsbHkgYSBsb3QgaW4gY29t
bW9uIHRvIG1lc2hjdGwgc28gSSB3b25kZXIgd2h5IG5vdA0KPiBleHRlbmQgaXQgdG8gd29yayB3
aXRoIG1lc2hkIGluc3RlYWQsIG9yIHdlIGRvIGludGVuZCB0byBhYmFuZG9uIGl0Pw0KPiBJDQo+
IHRob3VnaHQgaXRzIGNvZGUgd291bGQgYmUgYXNzaW1pbGF0ZWQgYnkgbWVzaGQgYW5kIHRoZW4g
cmV3b3JrZWQuLi4NCg0KbWVzaGN0bCBpcyBhIHB1cmUgR0FUVC1iYXNlZCBwcm92aXNpb25lciB0
b29sLiBUaGUgcGxhbiBpcyB0byByZS13b3JrDQppdCBvbmNlIHRoZXJlIGlzIGFuIGludGVncmF0
ZWQgc3VwcG9ydCBmb3IgR0FUVC1iYXNlZCBhbiBQQi1BZHYgbWVzaC4NCg0KDQo+IEFueXdheSBv
dXIgcHl0aG9uIHNjcmlwdHMgYXJlIGp1c3Qgc21hbGwgc2FtcGxlcyBjdXJyZW50bHkgYW5kIElk
IHNheQ0KPiB3ZSBzaG91bGQga2VlcCBpdCBsaWtlIHRoYXQgYW5kIG5vdCBoYXZlIGZ1bGwgYmxv
dyBjbGllbnRzIHNpbmNlDQo+IHRoZXJlDQo+IGFyZSBiZXR0ZXIgdG9vbHMgZm9yIGl0LCBmb3Ig
aW5zdGFuY2UgdGhlcmUgZXhpc3RzIHB5dGhvbiBiaW5kaW5ncw0KPiBmb3INCj4gQmx1ZVogd2hp
Y2ggbWlnaHQgYmUgZXh0ZW5kZWQgdG8gd29yayB3aXRoIG1lc2hkOg0KPiANCj4gaHR0cHM6Ly9w
eXBpLm9yZy9wcm9qZWN0L2JsdWV6ZXJvLw0KPiANCj4gDQoNCg0KVGhpcyBwYXJ0aWN1bGFyIHB5
dGhvbiBzY3JpcHQgaXMgbm90IGdvaW5nIHRvIGdyb3cgaW50byBhIGZ1bGwtYmxvd24NCmNsaWVu
dC4gSXQncyBub3QgYSB0b29sLCBpdCdzIGFuIGV4YW1wbGUuIE1heWJlIGl0J3MgYSBtaXNub21l
ciB0byBjYWxsDQppdCBhIHRlc3QgYW5kIGhhdmUgaXQgdGhlIHRlc3QgZGlyZWN0b3J5Lg0KV2ls
bCBpdCBiZSBhY2NlcHRhYmxlIGlmIGl0IGxpdmVzIHVuZGVyIG1lc2gvc2FtcGxlcyBkaXJlY3Rv
cnkgYW5kLA0KdGh1cywgZG9lcyBub3QgIGNyZWF0ZSBpbmNvbnNpc3RlbmN5IHdpdGggdGhlIHJl
c3Qgb2YgdGhlIHRyZWU/DQoNCiANCj4gDQo+IEpvaGFuDQo+IA0K
