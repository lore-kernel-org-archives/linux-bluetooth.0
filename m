Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC543C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9272920652
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9272920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeJAQJH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:09:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:11425 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbeJAQJH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 12:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="237514188"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2018 02:29:09 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 1 Oct 2018 02:29:08 -0700
Received: from bgsmsx152.gar.corp.intel.com (10.224.48.50) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 1 Oct 2018 02:29:07 -0700
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.39]) by
 BGSMSX152.gar.corp.intel.com ([169.254.6.47]) with mapi id 14.03.0319.002;
 Mon, 1 Oct 2018 14:59:05 +0530
From:   "Panda, Bharat B" <bharat.b.panda@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] support fast advertising interval
Thread-Topic: [PATCH] support fast advertising interval
Thread-Index: AQHUPeBnaf7ZKVHAOkmTVntblebLsqUDya6AgAAFggCABoZyQA==
Date:   Mon, 1 Oct 2018 09:29:04 +0000
Message-ID: <B42C2A3D4050B547BA40CAE18E023BE6461DBEA7@BGSMSX101.gar.corp.intel.com>
References: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
 <2A9C1D9B-41AA-492C-9144-E8332409BF83@holtmann.org>
 <CABBYNZ+s9a1cKyH7T6J5+=60J7H6aoVt5K1_bx0aR+y0hh5pcw@mail.gmail.com>
In-Reply-To: <CABBYNZ+s9a1cKyH7T6J5+=60J7H6aoVt5K1_bx0aR+y0hh5pcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTkwZGVhNjAtMDkwZi00MTZkLWJmM2YtNWI5OTdiNTU4YzA2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYzNKdjE2N1krTVVySjJoNFhjZmNnRnJWS2d2OFdIRGZ5WDgyQUN1c3h1dUFzbTlMTCs2Q2s3RzU0R1YrTXptTyJ9
x-ctpclassification: CTP_NT
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

SGkgTWFyY2VsLCBMdWl6LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEx1aXogQXVndXN0byB2b24gRGVudHogW21haWx0bzpsdWl6LmRlbnR6QGdtYWlsLmNvbV0NCj4g
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNywgMjAxOCA0OjQ3IFBNDQo+IFRvOiBNYXJjZWwg
SG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IENjOiBQYW5kYSwgQmhhcmF0IEIgPGJo
YXJhdC5iLnBhbmRhQGludGVsLmNvbT47IGxpbnV4LQ0KPiBibHVldG9vdGhAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHN1cHBvcnQgZmFzdCBhZHZlcnRpc2luZyBpbnRl
cnZhbA0KPiANCj4gSGkgTWFyY2VsLCBCaGFyYXQsDQo+IA0KPiBPbiBUaHUsIFNlcCAyNywgMjAx
OCBhdCAxOjU3IFBNLCBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IHdy
b3RlOg0KPiA+IEhpIEJoYXJhdCwNCj4gPg0KPiA+PiBDaGFuZ2VzIG1hZGUgdG8gYWRkIHN1cHBv
cnQgZm9yIGZhc3QgYWR2ZXJ0aXNpbmcgaW50ZXJ2YWwgYXMgcGVyIGNvcmUNCj4gPj4gNC4xIHNw
ZWNpZmljYXRpb24sIHNlY3Rpb24gOS4zLjExLjIuDQo+ID4+DQo+ID4+IEEgcGVyaXBoZXJhbCBk
ZXZpY2UgZW5ldGVyaW5nIGFueSBvZiB0aGUgZm9sbG93aW5nIEdBUCBtb2RlcyBhbmQNCj4gPj4g
c2VuZGluZyBlaXRoZXIgbm9uLWNvbm5lY3RhYmxlIGFkdmVydGlzaW5nIGV2ZW50cyBvciBzY2Fu
bmFibGUNCj4gPj4gdW5kaXJlY3RlZCBhZHZlcnRpc2luZyBldmVudHMgc2hvdWxkIHVzZSBhZHZf
ZmFzdF9pbnRlcnZhbDIoMTAwbXMgLQ0KPiA+PiAxNTBtcykgZm9yIGFkdl9mYXN0X3BlcmlvZCgz
MHMpLg0KPiA+PiAgICAgICAgIC0gTm9uLURpc2NvdmVyYWJsZSBNb2RlDQo+ID4+ICAgICAgICAg
LSBOb24tQ29ubmVjdGFibGUgTW9kZQ0KPiA+PiAgICAgICAgIC0gTGltaXRlZCBEaXNjb3ZlcmFi
bGUgTW9kZQ0KPiA+PiAgICAgICAgIC0gR2VuZXJhbCBEaXNjb3ZlcmFibGUgTW9kZQ0KPiA+DQo+
ID4gY2FuIHdlIGFsc28gZ2V0IGEgcGF0Y2ggZG9jdW1lbnRpbmcgdGhpcyBpbiBtZ210LWFwaS50
eHQgaW4gYmx1ZXouZ2l0Lg0KSSB3aWxsIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBmb3Igc2FtZSBm
b2xsb3dpbmcgdjIgZm9yIGN1cnJlbnQgcGF0Y2guDQo+ID4NCj4gPj4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogQmhhcmF0IEJodXNhbiBQYW5kYSA8YmhhcmF0LmIucGFuZGFAaW50ZWwuY29tPg0KPiA+
PiAtLS0NCj4gPj4gaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmggfCAgMiArKw0KPiA+
PiBuZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMgICAgICB8IDIyICsrKysrKysrKysrKysrKysr
KysrKysNCj4gPj4gMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaA0KPiA+PiBiL2lu
Y2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oDQo+ID4+IGluZGV4IGI2MTlhMTkuLjJmZTkw
OGMgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oDQo+
ID4+ICsrKyBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oDQo+ID4+IEBAIC0xNDU2
LDYgKzE0NTYsOCBAQCBzdHJ1Y3QgaGNpX21nbXRfY2hhbiB7DQo+ID4+ICNkZWZpbmUgRElTQ09W
X0lOVEVSTEVBVkVEX0lOUVVJUllfTEVOICAgICAgICAweDA0DQo+ID4+ICNkZWZpbmUgRElTQ09W
X0JSRURSX0lOUVVJUllfTEVOICAgICAgMHgwOA0KPiA+PiAjZGVmaW5lIERJU0NPVl9MRV9SRVNU
QVJUX0RFTEFZICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygyMDApICAgLyogbXNlYw0K
PiAqLw0KPiA+PiArI2RlZmluZSBESVNDT1ZfTEVfRkFTVF9BRFZfSU5UX01JTiAgIDEwMCAgICAg
LyogbXNlYyAqLw0KPiA+PiArI2RlZmluZSBESVNDT1ZfTEVfRkFTVF9BRFZfSU5UX01BWCAgIDE1
MCAgICAgLyogbXNlYyAqLw0KPiA+Pg0KPiA+PiB2b2lkIG1nbXRfZmlsbF92ZXJzaW9uX2luZm8o
dm9pZCAqdmVyKTsgaW50IG1nbXRfbmV3X3NldHRpbmdzKHN0cnVjdA0KPiA+PiBoY2lfZGV2ICpo
ZGV2KTsgZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX3JlcXVlc3QuYw0KPiA+PiBiL25l
dC9ibHVldG9vdGgvaGNpX3JlcXVlc3QuYyBpbmRleCA2NmMwNzgxLi41Y2YzZWY5IDEwMDY0NA0K
PiA+PiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMNCj4gPj4gKysrIGIvbmV0L2Js
dWV0b290aC9oY2lfcmVxdWVzdC5jDQo+ID4+IEBAIC0xMDA1LDYgKzEwMDUsMjggQEAgdm9pZCBf
X2hjaV9yZXFfZW5hYmxlX2FkdmVydGlzaW5nKHN0cnVjdA0KPiBoY2lfcmVxdWVzdCAqcmVxKQ0K
PiA+PiAgICAgICBlbHNlDQo+ID4+ICAgICAgICAgICAgICAgY3AudHlwZSA9IExFX0FEVl9OT05D
T05OX0lORDsNCj4gPj4NCj4gPj4gKyAgICAgLyogQXMgcGVyIGNvcmUgNC4xIHNwZWMsIHNlY3Rp
b24gOS4zLjExLjI6IEEgcGVyaXBoZXJhbCBkZXZpY2UNCj4gPj4gKyAgICAgICogZW5ldGVyaW5n
IGFueSBvZiB0aGUgZm9sbG93aW5nIEdBUCBtb2RlcyBhbmQgc2VuZGluZyBlaXRoZXINCj4gPg0K
PiA+IEZpeCB0aGUgdHlwbyBwbGVhc2UuDQo+ID4NCj4gPj4gKyAgICAgICogbm9uLWNvbm5lY3Rh
YmxlIGFkdmVydGlzaW5nIGV2ZW50cyBvciBzY2FubmFibGUgdW5kaXJlY3RlZA0KPiA+PiArICAg
ICAgKiBhZHZlcnRpc2luZyBldmVudHMgc2hvdWxkIHVzZSBhZHZfZmFzdF9pbnRlcnZhbDIoMTAw
bXMgLSAxNTBtcykNCj4gPj4gKyAgICAgICogZm9yIGFkdl9mYXN0X3BlcmlvZCgzMHMpLg0KPiA+
PiArICAgICAgKg0KPiA+PiArICAgICAgKiAgICAgIC0gTm9uLURpc2NvdmVyYWJsZSBNb2RlDQo+
ID4+ICsgICAgICAqICAgICAgLSBOb24tQ29ubmVjdGFibGUgTW9kZQ0KPiA+PiArICAgICAgKiAg
ICAgIC0gTGltaXRlZCBEaXNjb3ZlcmFibGUgTW9kZQ0KPiA+PiArICAgICAgKiAgICAgIC0gR2Vu
ZXJhbCBEaXNjb3ZlcmFibGUgTW9kZQ0KPiA+PiArICAgICAgKi8NCj4gPj4gKyAgICAgaWYgKChj
cC50eXBlID09IExFX0FEVl9OT05DT05OX0lORCkgfHwgKGNwLnR5cGUgPQ0KPiA+PiArIExFX0FE
Vl9TQ0FOX0lORCkpIHsNCj4gPg0KPiA+IFRoaXMgZXh0cmEgKHggPT0geSkgcGFyZW50aGVzZXMg
YXJlIG5vdCBuZWVkZWQuDQo+IA0KPiBCdHcgdGhlIHNlY29uZCBwYXJ0IG9mIHRoZSBleHByZXNz
aW9uIHNlZW0gd3JvbmcsIGl0IGlzIGFzc2lnbmluZyBub3QNCj4gY29tcGFyaW5nLg0KWWVzLCB0
aGUgYXNzaWdubWVudCB3YXMgYWx3YXlzIG1ha2luZyB0aGUgY29uZGl0aW9uIHRydWUuIEkgaGF2
ZSBmaXhlZCB0aGUgdHlwbyBhbmQgcmV0ZXN0ZWQgdGhlIHBhdGNoIHdvcmtpbmcuDQpQYXRjaCB2
MiB3aWxsIGJlIGZvbGxvd2VkIHdpdGggdGhlIGZpeC4NCj4gDQo+ID4NCj4gPj4gKyAgICAgICAg
ICAgICBpZiAoKGhjaV9kZXZfdGVzdF9mbGFnKGhkZXYsIEhDSV9ESVNDT1ZFUkFCTEUpKSB8fA0K
PiA+PiArICAgICAgICAgICAgIChoY2lfZGV2X3Rlc3RfZmxhZyhoZGV2LCBIQ0lfTElNSVRFRF9E
SVNDT1ZFUkFCTEUpKSB8fA0KPiA+PiArICAgICAgICAgICAgIChoZGV2LT5kaXNjb3ZlcnkubGlt
aXRlZCA9PSB0cnVlKSkgew0KPiA+DQo+ID4gQW5kIHRoaXMgaXMgd3JvbmdseSBhbGlnbmVkLiBJ
biBhZGRpdGlvbiwgeW91IG5lZWQgYSBiaXQgbW9yZSBjb21tZW50IHRleHQNCj4gYWJvdmUgZXhw
bGFpbnMgb24gd2hhdCBhcmUgdGhlIGNvbmRpdGlvbnMuDQo+ID4NCj4gPj4gKyAgICAgICAgICAg
ICAgICAgICAgIGNwLm1pbl9pbnRlcnZhbCA9DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNwdV90b19sZTE2KERJU0NPVl9MRV9GQVNUX0FEVl9JTlRfTUlOKTsNCj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGNwLm1heF9pbnRlcnZhbCA9DQo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNwdV90b19sZTE2KERJU0NPVl9MRV9GQVNUX0FEVl9JTlRfTUFYKTsN
Cj4gPj4gKyAgICAgICAgICAgICB9DQo+ID4+ICsgICAgIH0NCj4gPj4gKw0KPiA+PiAgICAgICBj
cC5vd25fYWRkcmVzc190eXBlID0gb3duX2FkZHJfdHlwZTsNCj4gPj4gICAgICAgY3AuY2hhbm5l
bF9tYXAgPSBoZGV2LT5sZV9hZHZfY2hhbm5lbF9tYXA7DQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4N
Cj4gPiBNYXJjZWwNCj4gPg0KPiANCj4gDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERl
bnR6DQpSZWdhcmRzLA0KQmhhcmF0DQo=
