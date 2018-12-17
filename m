Return-Path: <SRS0=yw44=O2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3DC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 21:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF8E21783
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 21:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeLQVsi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:48:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:52243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLQVsh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Dec 2018 16:48:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 13:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="130747824"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2018 13:48:36 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.191]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 13:48:35 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Plans for meshd
Thread-Topic: Plans for meshd
Thread-Index: AQHUlkzs4eI9Vs+iikShZ/67E4V4MqWDbuDA
Date:   Mon, 17 Dec 2018 21:48:34 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
References: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
In-Reply-To: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjFlZWNmZWQtMjc2Ni00NDZjLWEyOTYtMjlhMTk2MTI3ODQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWG9VUHdhYXI4aG5EckptdW1EUUtKeDViNW9aOEwxYytCMndxTDY1RmdFdUdtTTNyZUJ5ZUZQSVpiVkNOckJETSJ9
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
aG9uZWsNCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAxNywgMjAxOCAxOjEwIFBNDQo+IFRvOiBs
aW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFBsYW5zIGZvciBtZXNo
ZA0KPiANCj4gSGksDQo+IA0KPiBHaXZlbiByZWNlbnQgcGF0Y2hlcyB0byBtZXNoLCB3aGF0IGFy
ZSB5b3VyIG1pZCB0byBsb25nLXRlcm0gcGxhbnMgdG8NCj4gZW5hYmxlIGNvLWV4aXN0ZW5jZSBv
ZiBibHVldG9vdGhkIGFuZCBtZXNoZCBvbiBhIHNpbmdsZSBzeXN0ZW0/DQoNCllvdSBhcmUgZXNz
ZW50aWFsbHkgY29ycmVjdCwgdGhhdCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhc3N1bWVz
IG1lc2ggb3duZXJzaGlwIG9mIHRoZSBDb250cm9sbGVyLCBhbmQgdGhlcmUgaXMgbm8gY28tZXhp
c3RlbmNlIG9mICJDbGFzc2ljIEJsdWV0b290aCIgYXMgaW1wbGVtZW50ZWQgaW4gdGhlIEJsdWV0
b290aCBEYWVtb24sIG9uIHRoZSBzYW1lIGNvbnRyb2xsZXIuICBTbyBjdXJyZW50bHksIGlmIHlv
dSB3YW50IHRvIHNpbXVsdGFuZW91c2x5IHJ1biBhbiBBQ0wgY29ubmVjdGlvbiBiYXNlZCBhcHBs
aWNhdGlvbiB3aXRoIE1lc2gsIHlvdSB3b3VsZCBkbyBzbyB3aXRoIG1vcmUgdGhhbiBvbmUgY29u
dHJvbGxlci4gIChUaGlzIHNob3VsZCBhbHJlYWR5IHdvcmspDQoNCkkgY29uc2lkZXIgdGhpcyB0
byBiZSBhIHByYWN0aWNhbCBhcHByb2FjaCwgYmVjYXVzZSB0aGUgb3ZlcmhlYWQgY29uc3VtZWQg
YnkgQUNMIGNvbm5lY3Rpb25zIG5lZ2F0aXZlbHkgYWZmZWN0cyBBZHZlcnRpc2luZyBiYXNlZCBj
b21tdW5pY2F0aW9ucywgYW5kIGxpbnV4IGluIHBhcnRpY3VsYXIgaGFuZGxlcyBhIHByYWN0aWNh
bGx5IHVubGltaXRlZCBudW1iZXIgb2YgY29udHJvbGxlcnMuICBTdXBwb3J0IGZvciBkZXZpY2Vz
IHdpdGggY29udHJvbGxlcnMgdGhhdCBoYXZlIGFjdGl2ZSBBQ0wgY29ubmVjdGlvbnMgcmVxdWly
ZXMgb3RoZXIgbWVzaCBkZXZpY2VzIHRvIHNlbmQgbW9yZSByZWR1bmRhbnQgcGFja2V0cyB0byBl
bnN1cmUgZGVsaXZlcnkuDQoNClRoZSBwcmltYXJ5IHVzZSBjYXNlcyB0YXJnZXRlZCBieSB0aGlz
IGltcGxlbWVudGF0aW9uIGFzc3VtZXMgdGhlIGNvbnRyb2xsZXIgaXMgYmVpbmcgdXNlZCBmb3Ig
b25lIG9yIHRoZSBvdGhlci4gIEFuZCB3ZSB3YW50IHRvIGdpdmUgZW1iZWRkZWQgcGxhdGZvcm1z
IHRoZSBvcHRpb24gb2Ygbm90IGluc3RhbGxpbmcgbWVzaGQgaWYgdGhleSBkb24ndCBuZWVkIE1l
c2gsIG9yIG5vdCBpbnN0YWxsaW5nIGJsdWV0b290aGQgaWYgdGhleSBkb24ndCBuZWVkIENsYXNz
aWMgQmx1ZXRvb3RoLiANCg0KVGhhdCBzYWlkIHdlICpkbyogcGxhbiBvbiBzdXBwb3J0aW5nIEdB
VFQgUHJveHkgU2VydmVyLCBidXQgb2ZmZXJpbmcgdGhpcyBzdXBwb3J0IHRocm91Z2ggdGhlIEJs
dWV0b290aCBkYWVtb24gKGJsdWV0b290aGQpIG9uIGEgc2VwYXJhdGUgY29udHJvbGxlci4gIElz
IHRoaXMgeW91ciBvcmlnaW5hbCBxdWVzdGlvbj8gIFNhbWUgc3lzdGVtLCBidXQgbXVsdGlwbGUg
Y29udHJvbGxlcnMsIGFuZCBib3RoIGRhZW1vbnMgcnVubmluZy4gIEFsc28gZm9yd2FyZCBsb29r
aW5nLCBhIHN5c3RlbSBtaWdodCBoYXZlIGFzIG1hbnkgYXMgNSBjb250cm9sbGVyczogIDEgZm9y
IENsYXNzaWMgQmx1ZXRvb3RoLCAxIGZvciBPdXRib3VuZCBNZXNoIHRyYWZmaWMsIGFuZCAzIChv
bmUgb24gZWFjaCBMRSBhZHYgY2hhbm5lbCkgZm9yIGluY29taW5nIE1lc2ggdHJhZmZpYy4NCg0K
QW5kIEkgYW0gbm90IG9wcG9zZWQgdG8gc29tZW9uZSBzdGFydGluZyBhIHByb2plY3QgdGhhdCB3
aWxsIGFsbG93IHRoZSBibHVldG9vdGhkIGFuZCBtZXNoZCBzaGFyZSBhIHNpbmdsZSBjb250cm9s
bGVyIGFuZCB0YWtpbmcgcmVzcG9uc2liaWxpdHkgdGhlIHJlZHVjZWQgcGVyZm9ybWFuY2Ugb2Yg
ZWFjaCwgYnV0IHRoYXQgaXMgbm90IHdvcmsgd2UgaGF2ZSBwbGFubmVkLg0KDQo+IEZyb20gd2hh
dCBJIGdhdGhlciAocGxlYXNlLCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyksIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24NCj4gb2YgbWVzaC1pby1nZW5lcmljIGFzc3VtZXMgdGhhdCBtZXNoZCBpcyB0
aGUgc29sZSBvd25lciBvZiB0aGUgQkxFDQo+IGFkYXB0ZXIsIGJlY2F1c2UgdGhlIEhDSSBzb2Nr
ZXQgaXMgYm91bmQgdXNpbmcgYXMgSENJX0NIQU5ORUxfVVNFUiwgc28gYXQNCj4gdGhlIG1vbWVu
dCB0aGUgZGFlbW9ucyBhcmUgdW5hYmxlIHRvIHNoYXJlIHRoZSBzYW1lIEhDSSBkZXZpY2UuIElz
IG15DQo+IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8NCj4gDQo+IHJlZ2FyZHMNCj4gLS0NCj4gTWlj
aGHFgiBMb3dhcy1SemVjaG9uZWsNCj4gTGFtYmRhIFRlYW0gTGVhZGVyDQo+IA0KPiBTaWx2YWly
DQo+IEphc25vZ8OzcnNrYSA0NA0KPiAzMS0zNTggS3Jha293DQo+IFBPTEFORA0KPiANCj4gaHR0
cDovL3d3dy5zaWx2YWlyLmNvbQ0KDQpSZWdhcmRzLA0KQnJpYW4NCg==
