Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A1C00449
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A3720645
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A3720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeJCSts (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:49:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:49346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeJCSts (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 14:49:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="95689154"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2018 05:00:03 -0700
Received: from bgsmsx103.gar.corp.intel.com (10.223.4.130) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 3 Oct 2018 05:00:02 -0700
Received: from bgsmsx105.gar.corp.intel.com ([169.254.3.9]) by
 BGSMSX103.gar.corp.intel.com ([169.254.4.80]) with mapi id 14.03.0319.002;
 Wed, 3 Oct 2018 17:30:00 +0530
From:   "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Topic: [PATCH] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Index: AQHUVk4v5YfhXKFLGE2D0LWU1vNTYqUKIuNggAKgp4CAALAcgA==
Date:   Wed, 3 Oct 2018 11:59:59 +0000
Message-ID: <70C091497DE2844DBD9E143B2282ABDA9C2BF5@BGSMSX105.gar.corp.intel.com>
References: <1537780600-4098-1-git-send-email-mallikarjun.phulari@intel.com>
 <6855B2F4-544E-4CE7-A3C9-6324877E25F9@holtmann.org>
 <70C091497DE2844DBD9E143B2282ABDA9C2A9C@BGSMSX105.gar.corp.intel.com>
 <029627CE-BD94-4E2D-AC71-A5EC004F0B03@holtmann.org>
In-Reply-To: <029627CE-BD94-4E2D-AC71-A5EC004F0B03@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzNjMzk2MWUtNmQ1ZS00NjZlLTlhMDctZWFlODVmMTQ3ZDg1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXNBbXNESGJJVXVYa1Y4SjFGWTRhaFU3aFNKXC8wdE02bkNBaUVUckpjOW9KUkVnXC82SitpNlI2NzJBUWlHRWdrIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNl
bCBIb2x0bWFubiBbbWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmddDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgT2N0b2JlciAzLCAyMDE4IDEyOjI2IFBNDQo+IFRvOiBQaHVsYXJpLCBNYWxsaWthcmp1biA8
bWFsbGlrYXJqdW4ucGh1bGFyaUBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEJsdWV0b290aCA6IEVycmF0YSBT
ZXJ2aWNlIFJlbGVhc2UgOCwgRXJyYXR1bSAzMjUzDQo+IA0KPiBIaSBNYWxpa2FyanVuLA0KPiAN
Cj4gPj4+IEwyQ0FQOiBOZXcgcmVzdWx0IHZhbHVlcw0KPiA+Pj4gCTB4MDAwNiAtIENvbm5lY3Rp
b24gcmVmdXNlZCDigJMgSW52YWxpZCBTb3VyY2UgQ0lEDQo+ID4+PiAJMHgwMDA3IC0gQ29ubmVj
dGlvbiByZWZ1c2VkIOKAkyBTb3VyY2UgQ0lEIGFscmVhZHkgYWxsb2NhdGVkDQo+ID4+Pg0KPiA+
Pj4gQXMgcGVyIHRoZSBFU1IwOF9WMS4wLjAsIDEuMTEuMiBFcnJhdHVtIDMyNTMsIFBhZ2UgTm8u
IDU0LCAiUmVtb3RlDQo+ID4+PiBDSUQgaW52YWxpZCBJc3N1ZSIuDQo+ID4+PiBBcHBsaWVzIHRv
IENvcmUgU3BlY2lmaWNhdGlvbiB2ZXJzaW9uczogVjUuMCwgVjQuMiwgdjQuMSwgdjQuMCwgYW5k
DQo+ID4+PiB2My4wICsgSFMgVm9sIDMsIFBhcnQgQSwgU2VjdGlvbiA0LjIsIDQuMywgNC4xNCwg
NC4xNS4NCj4gPj4+DQo+ID4+PiBDb3JlIFNwZWNpZmljYXRpb24gVmVyc2lvbiA1LjAsIFBhZ2Ug
Tm8uMTc1MywgVGFibGUgNC42IGFuZCBQYWdlIE5vLg0KPiA+Pj4gMTc2NywgVGFibGUgNC4xNA0K
PiA+Pj4NCj4gPj4+IE5ldyByZXN1bHQgdmFsdWVzIGFyZSBhZGRlZCB0byBsMmNhcCBjb25uZWN0
L2NyZWF0ZSBjaGFubmVsIHJlc3BvbnNlDQo+ID4+PiBhcw0KPiA+Pj4gMHgwMDA2IC0gQ29ubmVj
dGlvbiByZWZ1c2VkIOKAkyBJbnZhbGlkIFNvdXJjZSBDSUQNCj4gPj4+IDB4MDAwNyAtIENvbm5l
Y3Rpb24gcmVmdXNlZCDigJMgU291cmNlIENJRCBhbHJlYWR5IGFsbG9jYXRlZA0KPiA+Pj4NCj4g
Pj4+IFNpZ25lZC1vZmYtYnk6IE1hbGxpa2FyanVuIFBodWxhcmkgPG1hbGxpa2FyanVuLnBodWxh
cmlAaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBpbmNsdWRlL25ldC9ibHVldG9vdGgvbDJj
YXAuaCB8ICA2ICsrKysrKw0KPiA+Pj4gbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMgICAgfCAx
NyArKysrKysrKysrKysrKysrLQ0KPiA+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0
L2JsdWV0b290aC9sMmNhcC5oDQo+ID4+PiBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5o
IGluZGV4IDA2OTdmZDQuLmM3Zjk3Y2MgMTAwNjQ0DQo+ID4+PiAtLS0gYS9pbmNsdWRlL25ldC9i
bHVldG9vdGgvbDJjYXAuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2Fw
LmgNCj4gPj4+IEBAIC0yODQsNiArMjg0LDEyIEBAIHN0cnVjdCBsMmNhcF9jb25uX3JzcCB7DQo+
ID4+PiAjZGVmaW5lIEwyQ0FQX0NSX0lOVkFMSURfU0NJRAkweDAwMDkNCj4gPj4+ICNkZWZpbmUg
TDJDQVBfQ1JfU0NJRF9JTl9VU0UJMHgwMDBBDQo+ID4+Pg0KPiA+Pj4gKy8qIGNvbm5lY3QvY3Jl
YXRlIGNoYW5uZWwgcmVzdWx0cw0KPiA+Pj4gKyAqIE5ldyByZXN1bHQgY29kZXNBcyBwZXIgRVNS
MDhfVjEuMC4wLCBFcnJhdHVtIDMyNTMgICovDQo+ID4+PiArI2RlZmluZSBMMkNBUF9DUl9CUkVE
Ul9JTlZBTElEX1NDSUQJMHgwMDA2DQo+ID4+PiArI2RlZmluZSBMMkNBUF9DUl9CUkVEUl9TQ0lE
X0lOX1VTRQkweDAwMDcNCj4gPj4+ICsNCj4gPj4NCj4gPj4gSSBhbSBjb25mdXNlZCBoZXJlLiBX
ZSBjdXJyZW50bHkgaGF2ZSB0aGlzIGxpc3Q6DQo+ID4+DQo+ID4+IC8qIGNvbm5lY3QvY3JlYXRl
IGNoYW5uZWwgcmVzdWx0cyAqLw0KPiA+PiAjZGVmaW5lIEwyQ0FQX0NSX1NVQ0NFU1MgICAgICAg
IDB4MDAwMA0KPiA+PiAjZGVmaW5lIEwyQ0FQX0NSX1BFTkQgICAgICAgICAgIDB4MDAwMQ0KPiA+
PiAjZGVmaW5lIEwyQ0FQX0NSX0JBRF9QU00gICAgICAgIDB4MDAwMg0KPiA+PiAjZGVmaW5lIEwy
Q0FQX0NSX1NFQ19CTE9DSyAgICAgIDB4MDAwMw0KPiA+PiAjZGVmaW5lIEwyQ0FQX0NSX05PX01F
TSAgICAgICAgIDB4MDAwNA0KPiA+PiAjZGVmaW5lIEwyQ0FQX0NSX0JBRF9BTVAgICAgICAgIDB4
MDAwNQ0KPiA+PiAjZGVmaW5lIEwyQ0FQX0NSX0FVVEhFTlRJQ0FUSU9OIDB4MDAwNSAjZGVmaW5l
DQo+IEwyQ0FQX0NSX0FVVEhPUklaQVRJT04NCj4gPj4gMHgwMDA2DQo+ID4+ICNkZWZpbmUgTDJD
QVBfQ1JfQkFEX0tFWV9TSVpFICAgMHgwMDA3DQo+ID4+ICNkZWZpbmUgTDJDQVBfQ1JfRU5DUllQ
VElPTiAgICAgMHgwMDA4DQo+ID4+ICNkZWZpbmUgTDJDQVBfQ1JfSU5WQUxJRF9TQ0lEICAgMHgw
MDA5DQo+ID4+ICNkZWZpbmUgTDJDQVBfQ1JfU0NJRF9JTl9VU0UgICAgMHgwMDBBDQo+ID4+DQo+
ID4+IE5vdyBoZXJlIHdlIGhhdmUgMHgwMDA2IGFuZCAweDAwMDcgdGFrZW4uIEhhdmUgdGhlc2Ug
YmVlbiBjaGFuZ2VkIG5vdy4NCj4gPj4gVGhlIEwyQ0FQX0NSX0FVVEhPUklaQVRJT04gd2UgYWN0
dWFsbHkgZG8gdXNlIGluIExFIGFuZCBpZiB0aGlzIHRhYmxlDQo+ID4+IGlzIG5vdCB0cmVhdGVk
IHdpdGggaW5kZXBlbmRlbnQgbmFtZSBzcGFjZXMgZm9yIEJSL0VEUiB2cyBMRSwgdGhlbiB3ZQ0K
PiA+PiBuZWVkIHRvIHNwbGl0IHRoaXMgb25lIGZpcnN0IGFuZCBnZXQgdGhlIExFIG9ubHkgb25l
cyBwcm9wZXIgbmFtZXMgYW5kIGZpeCB0aGVpcg0KPiB1c2FnZS4NCj4gPj4NCj4gPiBUaGUgY3Vy
cmVudCBuYW1lIHNwYWNlcyB0aGF0IHlvdSBoYXZlIG1lbnRpb25lZCBhYm92ZSwgaGF2ZSB0aGUg
Y29tYmluZWQNCj4gcmVzdWx0IHZhbHVlcyBmb3IgTEUgQ3JlZGl0IGJhc2UgQ29ubmVjdGlvbiAo
Vk9MIDMsIFBhcnQgQSwgNC4yMywgVGFibGUgNC4yMCkgYW5kDQo+IGZvciBMMkNBUCBDcmVhdGUv
Q29ubmVjdCAoVk9MMywgUGFydCBBLCA0LjMgLzQuMTUsIFRhYmxlIDQuNi80LjE0KS4NCj4gPiBU
byBjcmVhdGUgc2VwYXJhdGUgbmFtZSBzcGFjZXMgZm9yIGVhY2ggc2V0IG9mIGVycm9yIGNvZGVz
IGZvciBMMkNBUCBjaGFubmVsDQo+IHJlcXVlc3QsIEwyQ0FQIGNyZWF0ZSBDb25uZWN0aW9uIGFu
ZCBMRSBjcmVkaXQgYmFzZWQgY3JlYXRlIGNvbm5lY3Rpb24gd2lsbA0KPiBhZGQgbW9yZSByZXdv
cmsgdG8gcmVwbGFjZSB0aGUgZXJyb3IgY29kZXMgd2hlcmUgdGhlc2UgYXJlIGJlaW5nIHVzZWQu
DQo+ID4NCj4gPiBUaGVyZWZvcmUsIHRvIGF2b2lkIHRoZSByZXdvcmsgLCBJIGhhZCB1c2VkIHRo
ZSByZXN1bHQgdmFsdWVzIGFzOg0KPiA+DQo+ID4gI2RlZmluZSBMMkNBUF9DUl9CUkVEUl9JTlZB
TElEX1NDSUQJMHgwMDA2DQo+ID4gI2RlZmluZSBMMkNBUF9DUl9CUkVEUl9TQ0lEX0lOX1VTRQkw
eDAwMDcNCj4gPg0KPiA+IElmIHlvdSBzdWdnZXN0IHRvIHNlcGFyYXRlIHRoZSBuYW1lIHNwYWNl
cyBmb3IgTEUgYW5kIEJSRURSIHJlc3VsdCB2YWx1ZXMsIEkNCj4gc2hhbGwgcmUtc2VuZCB0aGUg
djMgcGF0Y2ggd2l0aCB0aGUgY2hhbmdlcy4NCj4gDQo+IGlmIHRoZSBjdXJyZW50bHkgMHgwMDA2
LTB4MDAwQSBhcmUgTEUgb25seSwgdGhlbiB3ZSBzaG91bGQgY2hhbmdlIHRoZWlyIG5hbWVzDQo+
IHRvIEwyQ0FQX0NSX0xFXyogYW5kIGNvbnZlcnQgdGhlaXIgdXNhZ2VzLiBBbmQgdGhlbiBhZGQg
dGhlIG5ldyBCUi9FRFIgb25seQ0KPiAweDAwMDYtMHgwMDA3IGludG8gdGhlIGxpc3QgKHdpdGhv
dXQgX0JSRURSIGluIHRoZSBuYW1lKS4NCg0KSSB3aWxsIGNoYW5nZSB0aGUgbmFtZXMgb2YgdGhl
IHJlc3VsdCB2YWx1ZXMgYW5kIHRoZWlyIHVzYWdlcyBhcyB5b3Ugc3VnZ2VzdGVkIGFuZCBJIHdp
bGwgc2VuZCB5b3UgdGhlIG5ldyBwYXRjaC4NCg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2Vs
DQoNClRoYW5rcyAmIFJlZ2FyZHMNCk1hbGxpa2FyanVuIFBodWxhcmkNCg==
