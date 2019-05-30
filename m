Return-Path: <SRS0=q/Kg=T6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C45C28CC0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44B525D4E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE3QGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 May 2019 12:06:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:18820 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3QGQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 May 2019 12:06:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 09:06:16 -0700
X-ExtLoop1: 1
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2019 09:06:15 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 30 May 2019 09:06:15 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.165]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 09:06:15 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "denkenz@gmail.com" <denkenz@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ 0/1] mesh: Convert all crypto to ELL
Thread-Topic: [PATCH BlueZ 0/1] mesh: Convert all crypto to ELL
Thread-Index: AQHVFkPxZn6H44r5j0SrN+eCfmOIKqaDswGAgAAfRKA=
Date:   Thu, 30 May 2019 16:06:15 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CB64772@ORSMSX103.amr.corp.intel.com>
References: <20190529172818.8844-1-brian.gix@intel.com>
 <20190530065833.acnzga3knthhh3nk@scytale>
In-Reply-To: <20190530065833.acnzga3knthhh3nk@scytale>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWQ4ZTEzZDgtNzVmZi00OTkwLWI3ZDgtMTg3OTljN2E3M2U0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieVVYTTBFQlJoSXpldjk1TlpIU3lZYlhkMDQ5UktRWUJTYjd1OXZsWDZiakU1cCs5RldUTEVFY2w3d2xZYnNaViJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KPiANCj4gSGksDQo+IA0KPiBPbiAwNS8yOSwgQnJpYW4gR2l4IHdyb3Rl
Og0KPiA+IFRoaXMgd2lsbCBoYXZlIG9uZSBtYWpvciBzaWRlIGVmZmVjdCBpbiB0aGF0IGl0IHdp
bGwgbm8gbG9uZ2VyIHN1cHBvcnQNCj4gPiBrZXJuZWxzIG9sZGVyIHRoYW4gdjQuOSAoSSBhbSBw
ZXJzb25hbGx5IHVzaW5nIHY1LjAuMTcpLiAgSSBhbSB0b2xkDQo+ID4gdGhhdCAoc29tZT8pIEZy
ZWVzY2FsZSBwbGF0Zm9ybXMgYWxzbyB3aWxsIGhhdmUgcHJvYmxlbXMgcmVnYXJkbGVzcyBvZg0K
PiA+IGtlcm5lbCB2ZXJzaW9uLg0KPiANCj4gQWxyaWdodCwgc28gSSBhZ3JlZSB0aGF0IGl0IHdv
dWxkIGJlIHVwIHRvIHRoZSB2ZW5kb3IgKGkuZS4gbWUgOykgdG8gcHJvdmlkZSBhDQo+IHBhdGNo
IGZvciBvbGRlciBrZXJuZWxzLg0KPiANCj4gSSB0aGluayB0aGUgbW9zdCBzZW5zaWJsZSBvcHRp
b24gd291bGQgYmUgdG8gcGF0Y2ggRUxMIHRvIHVzZSB1c2Vyc3BhY2UgZmFsbGJhY2ssDQo+IGlu
c3RlYWQgb2YgcGF0Y2hpbmcgYmx1ZXouIFNvIGlmIHlvdSBjb3VsZCBqdXN0IG1ha2Ugc3VyZSB0
aGF0IGFuIGFwcHJvcHJpYXRlDQo+IHVuaXQgdGVzdCBleGlzdHMgd2l0aGluIEVMTCwgSSBoYXZl
IG5vIG9iamVjdGlvbnMuDQoNClRoZSB1bml0IHRlc3QgZm9yIEFFQUQgaW4gLi4uL2VsbC91bml0
L3Rlc3QtY2lwaGVyLmMgYWxyZWFkeSBtYWtlcyB0aGlzIHJlcG9ydCBvbiBlbmNyeXB0aW9uIGZh
aWx1cmVzOg0KDQppZiAoIXN1Y2Nlc3MpIHsNCglwcmludGYoIiogU29tZSBrZXJuZWwgdmVyc2lv
bnMgYmVmb3JlIHY0LjkgaGF2ZSBhIGtub3duIEFFQURcbiINCgkJIiogYnVnLiBJZiB0aGUgc3lz
dGVtIHJ1bm5pbmcgdGhpcyB0ZXN0IGlzIHVzaW5nIGFcbiINCgkJIiogdjQuOCBvciBlYXJsaWVy
IGtlcm5lbCwgYSBmYWlsdXJlIGhlcmUgaXMgbGlrZWx5XG4iDQoJCSIqIGR1ZSB0byB0aGF0IGtl
cm5lbCBidWcuXG4iKTsNCn0NCg0KU28gSSB3aWxsIGxpa2VseSBiZSBhcHBseWluZyB0aGUgcGF0
Y2ggYXMgd3JpdHRlbiBieSB0aGlzIHdlZWtlbmQgdG8gY29udmVydCBhbGwgb2YgbWVzaCBjcnlw
dG8gdG8gRUxMLg0KDQpBbnkgcGF0Y2hpbmcgKHRvIEVMTCBvciBCbHVlWikgd2lsbCBhZ2FpbiBi
ZWNvbWUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSB2ZW5kb3Igb2ZmZXJpbmcgc3VwcG9ydCB0
byB0aGVzZSBvbGRlciBwbGF0Zm9ybXMuICBUbyBlbXBoYXNpemUgdGhpcywgSSB3aWxsIHByb2Jh
Ymx5IGFsc28gYWRkIGEgbm90ZSB0byAuLi4vYmx1ZXovbWVzaC9SRUFETUUgdG8gZW1waGFzaXpl
IGJvdGggdGhlIHByb2JsZW0gd2l0aCB0aGVzZSBvbGRlciBwbGF0Zm9ybXMsIHVzYWdlIG9mIHRo
ZSBFTEwgdW5pdCB0ZXN0IHRvIGlkZW50aWZ5LCBhbmQgdGhlIHJlcXVpcmVkIHdvcmstYXJvdW5k
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpCcmlhbg0K
