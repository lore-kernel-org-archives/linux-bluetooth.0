Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1989C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36B21852
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLRQ1g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:27:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:48496 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeLRQ1g (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 11:27:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 08:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="102478378"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2018 08:27:30 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.59]) with mapi id 14.03.0415.000;
 Tue, 18 Dec 2018 08:27:07 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Plans for meshd
Thread-Topic: Plans for meshd
Thread-Index: AQHUlkzs4eI9Vs+iikShZ/67E4V4MqWDbuDAgAFurwD//8yAMA==
Date:   Tue, 18 Dec 2018 16:27:06 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E0B35@ORSMSX101.amr.corp.intel.com>
References: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
 <20181218110838.ollsqils5ci7cq4v@scytale>
In-Reply-To: <20181218110838.ollsqils5ci7cq4v@scytale>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDVjMjA3M2UtOWQyZS00Y2NkLWFkNGUtZDdhZDllMjYyMjE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaXpyS2xncVRDUnJSSndBeklcLytxVnNIRU9DUCtvV0sxNU9zand6Y2loK1pqbEl6R1JiNGZjaDdcL0NKUWQ0M3crIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1ibHVldG9vdGgt
DQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hhbCBMb3dhcy1SemVj
aG9uZWsNCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTgsIDIwMTggMzowOSBBTQ0KPiBUbzog
bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogUGxhbnMgZm9y
IG1lc2hkDQo+IA0KWy4uLl0NCj4gV2hhdCBJJ20gdGhpbmtpbmcgYWJvdXQgaXMgaGF2aW5nIGJv
dGggbW9kZXMgb2YgY29tbXVuaWNhdGlvbiBhdmFpbGFibGUsDQo+IGV2ZW4gaWYgdGhlIGVtYmVk
ZGVkIGRldmljZSBoYXMganVzdCBvbmUgQ29udHJvbGxlciwgYXMgaXMgdGhlIGNhc2Ugd2l0aCB0
aGUNCj4gbWFqb3JpdHkgb2Ygb2ZmLXRoZS1zaGVsZiBwbGF0Zm9ybXMuDQo+IA0KPiBUaGUgcmVh
c29uIHdlIHdhbnQvbmVlZCBib3RoIEJMRS9HQVRUIGFuZCBNZXNoIG9uIHRoZSBzYW1lIG5vZGUg
aGFzIGENCj4gbG90IHRvIGRvIHdpdGggcHJvdmlzaW9uaW5nIC0gYXQgdGhlIG1vbWVudCB3ZSBj
b25maWd1cmUgb3VyIG5ldHdvcmtzIHVzaW5nDQo+IGEgbW9iaWxlIGFwcCwgbWVhbmluZyB3ZSBu
ZWVkIGRldmljZXMgdG8gc3VwcG9ydCBQQi1HQVRULiBUaGlzIGlzIGJlY2F1c2UNCj4gQ29udHJv
bGxlcnMgcHJlc2VudCBpbiBtb2JpbGUgZGV2aWNlcyBkbyBub3Qgc3VwcG9ydCBNZXNoIG5hdGl2
ZWx5LCBhbmQgd2UNCj4gY2FuJ3QgYXNzdW1lIHRoZXJlIGlzIGEgR0FUVCBQcm94eSBuZWFyYnks
IGVzcGVjaWFsbHkgd2hlbiBjb25maWd1cmluZyBhDQo+IG5ldyBuZXR3b3JrLg0KPiANCj4gPiBB
bmQgSSBhbSBub3Qgb3Bwb3NlZCB0byBzb21lb25lIHN0YXJ0aW5nIGEgcHJvamVjdCB0aGF0IHdp
bGwgYWxsb3cgdGhlDQo+ID4gYmx1ZXRvb3RoZCBhbmQgbWVzaGQgc2hhcmUgYSBzaW5nbGUgY29u
dHJvbGxlciBhbmQgdGFraW5nDQo+ID4gcmVzcG9uc2liaWxpdHkgdGhlIHJlZHVjZWQgcGVyZm9y
bWFuY2Ugb2YgZWFjaCwgYnV0IHRoYXQgaXMgbm90IHdvcmsNCj4gPiB3ZSBoYXZlIHBsYW5uZWQu
DQo+IEFjay4NCj4gDQo+IEZZSSwgaXQgc2VlbXMgd2UgbWlnaHQgYmUgaW50ZXJlc3RlZCBpbiBt
YWtpbmcgdGhhdCBoYXBwZW4uDQoNCk1heWJlIHdlIHNob3VsZCBzdGFydCB3aXRoIHdoYXQgeW91
IGFjdHVhbGx5IG5lZWQuDQoqIERvIHlvdSBuZWVkIEdBVFQgc3VwcG9ydCBvbmx5IGZvciB0aGUg
UHJvdmlzaW9uaW5nIHByb2NlZHVyZT8NCiogb3IgYWxzbyBhcyBhIEdBVFQgcHJveHkgU2VydmVy
Pw0KDQpUaGVyZSBpcyBhIHBvc3NpYmlsaXR5Li4uICAgV2UgaGFkIGFuIGludGVybmFsIHByb2pl
Y3Qgd2hlcmUgd2Ugc3VwcG9ydGVkIGEgR0FUVCBQcm94eSBzZXJ2ZXIgd2l0aG91dCB1c2luZyB0
aGUgYmx1ZXRvb290aGQgc2VydmljZXMgYXQgYWxsLiAgRm9yIGJsdWV0b290aGQsIHRoZSByZXN1
bHQgaXMgdGhlIHNhbWU6ICBUaGUgY29udHJvbGxlciB3YXMgZW50aXJlbHkgdW5kZXIgdGhlIGNv
bnRyb2wgb2YgdGhlIG1lc2ggZXhlY3V0YWJsZSAoaXQgd2FzIG5vdCBhIGRhZW1vbiwgYnV0IGEg
cHJvb2Ytb2YtY29uY2VwdCBjb21tYW5kIGxpbmUgdG9vbCkuICBCdXQgdGhlcmUgYXJlIHByb2Js
ZW1zIHdpdGggdGhhdCBwYXJ0aWN1bGFyIGlkZWEgZ2l2ZW4gdGhlIGFyY2hpdGVjdHVyZSBvZiB0
aGUgbWVzaGQgZGFlbW9uOg0KDQoqIEkgZG8gbm90IHRoaW5rIHdlIHNob3VsZCB0cnkgdG8gc3Vw
cG9ydCBQcm94eSBDbGllbnQgKmF0IGFsbCouIFRoZSBQcm94eSBDbGllbnQgYXNzdW1lcyBhIHNp
bmdsZSBOb2RlLCB3aGljaCBkZWZlYXRzIHRoZSBwdXJwb3NlIG9mIGhhdmluZyBhIGRhZW1vbiBh
dCBhbGwuICANCg0KKiBPbmx5IGEgc2luZ2xlIG5vZGUgKG9yIHVucHJvdmlzaW9uZWQgR0FUVCBz
ZXJ2ZXIpIGNhbiB1c2UgR0FUVCBhdCBhIHRpbWUuICBUaGUgcHJvdG9jb2wgZG9lcyBub3QgYWxs
b3cgZm9yIHRoZSBtdWx0aS1ub2RlIGFyY2hpdGVjdHVyZSBvZiB0aGUgZGFlbW9uLg0KDQoqICBJ
ZiB3ZSBkbyB0cnkgdG8gcHV0IGEgR0FUVCBQcm94eSBTZXJ2ZXIgb24gYSBzaW5nbGUgY29udHJv
bGxlciBpbXBsZW1lbnRhdGlvbiwgd2UgbWF5IG5lZWQgYSBzcGVjaWFsIG5vZGUgdGhhdCBsb29w
cyBiYWNrIGRhdGEgcmVjZWl2ZWQgZnJvbSB0aGUgTWVzaCB0byB0aGUgR2F0dCBDbGllbnQuDQoN
CiogV2Ugd2lsbCBwcm9iYWJseSBuZWVkIHRvIGxpbWl0IHRoaXMgc3BlY2lhbCBHQVRUIHN1cHBv
cnRpbmcgbm9kZSB0byBhIHNpbmdsZSBub2RlIG9uIHRoZSBkYWVtb24uDQoNCiogV2UgbWF5IHdh
bnQgdG8gbWFrZSB0aGlzIGEgYnVpbGQtdGltZSBvcHRpb24sIGJlY2F1c2UgQURWIGhhbmRsaW5n
IHdpbGwgcHJvYmFibHkgYmUgYWZmZWN0ZWQgd2hldGhlciBhbiBleGlzdGluZyBHQVRUIGNvbm5l
Y3Rpb24gaXMgZXN0YWJsaXNoZWQgb3Igbm90LCBpZiBpdCBpcyBwb3NzaWJsZSB0aGF0IGEgR0FU
VCBjb25uZWN0aW9uIGNvdWxkIGJlIHJlcXVlc3RlZC4NCg0KKiBUaGlzIGFmZmVjdHMgdGhlIHRp
bWVzIHdoZW4gd2UgY2FuIHVzZSBSYW5kb21pemVkLCBldmVyIGNoYW5naW5nIEJEIEFERFJzLCBh
bmQgcmVxdWlyZXMgdXMgdG8gaW50ZXJsZWF2ZSBjb25uZWN0YWJsZSBhZHZlcnRpc2VtZW50cyBh
bmQgImJlIGNvbm5lY3RhYmxlIiwgd2hpY2ggaXMgbm90IHRlY2huaWNhbGx5IGFsbG93ZWQgd2l0
aCBtZXNoIG5ldHdvcmsgQURWIHBhY2tldHMuDQoNCg0KDQoNCj4gDQo+IHJlZ2FyZHMNCj4gLS0N
Cj4gTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFp
ci5jb20+DQo+IFNpbHZhaXIgaHR0cDovL3NpbHZhaXIuY29tDQo+IEphc25vZ8OzcnNrYSA0NCwg
MzEtMzU4IEtyYWtvdywgUE9MQU5EDQo=
