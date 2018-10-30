Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378EDC2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 06:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52C82082D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 06:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52C82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3PRU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:17:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:25099 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeJ3PRU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 11:17:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 23:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,443,1534834800"; 
   d="scan'208";a="85558776"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2018 23:25:09 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 29 Oct 2018 23:25:08 -0700
Received: from BGSMSX107.gar.corp.intel.com (10.223.4.191) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 29 Oct 2018 23:25:07 -0700
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.234]) by
 BGSMSX107.gar.corp.intel.com ([169.254.9.47]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 11:55:04 +0530
From:   "Panda, Bharat B" <bharat.b.panda@intel.com>
To:     'Marcel Holtmann' <marcel@holtmann.org>,
        'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
CC:     "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] support fast advertising interval
Thread-Topic: [PATCH] support fast advertising interval
Thread-Index: AQHUPeBnaf7ZKVHAOkmTVntblebLsqUDya6AgAAFggCABoZyQIAtYHLQ
Date:   Tue, 30 Oct 2018 06:25:03 +0000
Message-ID: <B42C2A3D4050B547BA40CAE18E023BE64CCA1F51@BGSMSX101.gar.corp.intel.com>
References: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
 <2A9C1D9B-41AA-492C-9144-E8332409BF83@holtmann.org>
 <CABBYNZ+s9a1cKyH7T6J5+=60J7H6aoVt5K1_bx0aR+y0hh5pcw@mail.gmail.com>
 <B42C2A3D4050B547BA40CAE18E023BE6461DBEA7@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <B42C2A3D4050B547BA40CAE18E023BE6461DBEA7@BGSMSX101.gar.corp.intel.com>
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

SGkgTWFyY2VsLA0KDQpJIGhhdmUgc3VibWl0dGVkIHRoZSBwYXRjaCB3aXRoIHJldmlldyBjb21t
ZW50cyBpbmNvcnBvcmF0ZWQgYWxvbmcgd2l0aCB0aGUgd3JpdGUtdXAgaW4gbWdtdC4tYXBpIGZv
ciBmYXN0IGFkdiBpbnRlcnZhbC4NClBsZWFzZSByZXZpZXcgdGhlIHNhbWUuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFuZGEsIEJoYXJhdCBCDQo+IFNlbnQ6IE1v
bmRheSwgT2N0b2JlciAxLCAyMDE4IDI6NTkgUE0NCj4gVG86IEx1aXogQXVndXN0byB2b24gRGVu
dHogPGx1aXouZGVudHpAZ21haWwuY29tPjsgTWFyY2VsIEhvbHRtYW5uDQo+IDxtYXJjZWxAaG9s
dG1hbm4ub3JnPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIXSBzdXBwb3J0IGZhc3QgYWR2ZXJ0aXNpbmcgaW50ZXJ2YWwNCj4gDQo+
IEhpIE1hcmNlbCwgTHVpeiwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IFttYWlsdG86bHVpei5kZW50ekBnbWFpbC5j
b21dDQo+ID4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNywgMjAxOCA0OjQ3IFBNDQo+ID4g
VG86IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gPiBDYzogUGFuZGEs
IEJoYXJhdCBCIDxiaGFyYXQuYi5wYW5kYUBpbnRlbC5jb20+OyBsaW51eC0NCj4gPiBibHVldG9v
dGhAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3VwcG9ydCBmYXN0
IGFkdmVydGlzaW5nIGludGVydmFsDQo+ID4NCj4gPiBIaSBNYXJjZWwsIEJoYXJhdCwNCj4gPg0K
PiA+IE9uIFRodSwgU2VwIDI3LCAyMDE4IGF0IDE6NTcgUE0sIE1hcmNlbCBIb2x0bWFubiA8bWFy
Y2VsQGhvbHRtYW5uLm9yZz4NCj4gPiB3cm90ZToNCj4gPiA+IEhpIEJoYXJhdCwNCj4gPiA+DQo+
ID4gPj4gQ2hhbmdlcyBtYWRlIHRvIGFkZCBzdXBwb3J0IGZvciBmYXN0IGFkdmVydGlzaW5nIGlu
dGVydmFsIGFzIHBlcg0KPiA+ID4+IGNvcmUNCj4gPiA+PiA0LjEgc3BlY2lmaWNhdGlvbiwgc2Vj
dGlvbiA5LjMuMTEuMi4NCj4gPiA+Pg0KPiA+ID4+IEEgcGVyaXBoZXJhbCBkZXZpY2UgZW5ldGVy
aW5nIGFueSBvZiB0aGUgZm9sbG93aW5nIEdBUCBtb2RlcyBhbmQNCj4gPiA+PiBzZW5kaW5nIGVp
dGhlciBub24tY29ubmVjdGFibGUgYWR2ZXJ0aXNpbmcgZXZlbnRzIG9yIHNjYW5uYWJsZQ0KPiA+
ID4+IHVuZGlyZWN0ZWQgYWR2ZXJ0aXNpbmcgZXZlbnRzIHNob3VsZCB1c2UgYWR2X2Zhc3RfaW50
ZXJ2YWwyKDEwMG1zIC0NCj4gPiA+PiAxNTBtcykgZm9yIGFkdl9mYXN0X3BlcmlvZCgzMHMpLg0K
PiA+ID4+ICAgICAgICAgLSBOb24tRGlzY292ZXJhYmxlIE1vZGUNCj4gPiA+PiAgICAgICAgIC0g
Tm9uLUNvbm5lY3RhYmxlIE1vZGUNCj4gPiA+PiAgICAgICAgIC0gTGltaXRlZCBEaXNjb3ZlcmFi
bGUgTW9kZQ0KPiA+ID4+ICAgICAgICAgLSBHZW5lcmFsIERpc2NvdmVyYWJsZSBNb2RlDQo+ID4g
Pg0KPiA+ID4gY2FuIHdlIGFsc28gZ2V0IGEgcGF0Y2ggZG9jdW1lbnRpbmcgdGhpcyBpbiBtZ210
LWFwaS50eHQgaW4gYmx1ZXouZ2l0Lg0KPiBJIHdpbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNoIGZv
ciBzYW1lIGZvbGxvd2luZyB2MiBmb3IgY3VycmVudCBwYXRjaC4NCj4gPiA+DQo+ID4gPj4NCj4g
PiA+PiBTaWduZWQtb2ZmLWJ5OiBCaGFyYXQgQmh1c2FuIFBhbmRhIDxiaGFyYXQuYi5wYW5kYUBp
bnRlbC5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4gaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9j
b3JlLmggfCAgMiArKw0KPiA+ID4+IG5ldC9ibHVldG9vdGgvaGNpX3JlcXVlc3QuYyAgICAgIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4+IDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0
b290aC9oY2lfY29yZS5oDQo+ID4gPj4gYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUu
aA0KPiA+ID4+IGluZGV4IGI2MTlhMTkuLjJmZTkwOGMgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvaW5j
bHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgNCj4gPiA+PiArKysgYi9pbmNsdWRlL25ldC9i
bHVldG9vdGgvaGNpX2NvcmUuaA0KPiA+ID4+IEBAIC0xNDU2LDYgKzE0NTYsOCBAQCBzdHJ1Y3Qg
aGNpX21nbXRfY2hhbiB7DQo+ID4gPj4gI2RlZmluZSBESVNDT1ZfSU5URVJMRUFWRURfSU5RVUlS
WV9MRU4gICAgICAgIDB4MDQNCj4gPiA+PiAjZGVmaW5lIERJU0NPVl9CUkVEUl9JTlFVSVJZX0xF
TiAgICAgIDB4MDgNCj4gPiA+PiAjZGVmaW5lIERJU0NPVl9MRV9SRVNUQVJUX0RFTEFZICAgICAg
ICAgICAgICAgbXNlY3NfdG9famlmZmllcygyMDApICAgLyoNCj4gbXNlYw0KPiA+ICovDQo+ID4g
Pj4gKyNkZWZpbmUgRElTQ09WX0xFX0ZBU1RfQURWX0lOVF9NSU4gICAxMDAgICAgIC8qIG1zZWMg
Ki8NCj4gPiA+PiArI2RlZmluZSBESVNDT1ZfTEVfRkFTVF9BRFZfSU5UX01BWCAgIDE1MCAgICAg
LyogbXNlYyAqLw0KPiA+ID4+DQo+ID4gPj4gdm9pZCBtZ210X2ZpbGxfdmVyc2lvbl9pbmZvKHZv
aWQgKnZlcik7IGludA0KPiA+ID4+IG1nbXRfbmV3X3NldHRpbmdzKHN0cnVjdCBoY2lfZGV2ICpo
ZGV2KTsgZGlmZiAtLWdpdA0KPiA+ID4+IGEvbmV0L2JsdWV0b290aC9oY2lfcmVxdWVzdC5jIGIv
bmV0L2JsdWV0b290aC9oY2lfcmVxdWVzdC5jIGluZGV4DQo+ID4gPj4gNjZjMDc4MS4uNWNmM2Vm
OSAxMDA2NDQNCj4gPiA+PiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMNCj4gPiA+
PiArKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMNCj4gPiA+PiBAQCAtMTAwNSw2ICsx
MDA1LDI4IEBAIHZvaWQgX19oY2lfcmVxX2VuYWJsZV9hZHZlcnRpc2luZyhzdHJ1Y3QNCj4gPiBo
Y2lfcmVxdWVzdCAqcmVxKQ0KPiA+ID4+ICAgICAgIGVsc2UNCj4gPiA+PiAgICAgICAgICAgICAg
IGNwLnR5cGUgPSBMRV9BRFZfTk9OQ09OTl9JTkQ7DQo+ID4gPj4NCj4gPiA+PiArICAgICAvKiBB
cyBwZXIgY29yZSA0LjEgc3BlYywgc2VjdGlvbiA5LjMuMTEuMjogQSBwZXJpcGhlcmFsIGRldmlj
ZQ0KPiA+ID4+ICsgICAgICAqIGVuZXRlcmluZyBhbnkgb2YgdGhlIGZvbGxvd2luZyBHQVAgbW9k
ZXMgYW5kIHNlbmRpbmcNCj4gPiA+PiArIGVpdGhlcg0KPiA+ID4NCj4gPiA+IEZpeCB0aGUgdHlw
byBwbGVhc2UuDQo+ID4gPg0KPiA+ID4+ICsgICAgICAqIG5vbi1jb25uZWN0YWJsZSBhZHZlcnRp
c2luZyBldmVudHMgb3Igc2Nhbm5hYmxlIHVuZGlyZWN0ZWQNCj4gPiA+PiArICAgICAgKiBhZHZl
cnRpc2luZyBldmVudHMgc2hvdWxkIHVzZSBhZHZfZmFzdF9pbnRlcnZhbDIoMTAwbXMgLSAxNTBt
cykNCj4gPiA+PiArICAgICAgKiBmb3IgYWR2X2Zhc3RfcGVyaW9kKDMwcykuDQo+ID4gPj4gKyAg
ICAgICoNCj4gPiA+PiArICAgICAgKiAgICAgIC0gTm9uLURpc2NvdmVyYWJsZSBNb2RlDQo+ID4g
Pj4gKyAgICAgICogICAgICAtIE5vbi1Db25uZWN0YWJsZSBNb2RlDQo+ID4gPj4gKyAgICAgICog
ICAgICAtIExpbWl0ZWQgRGlzY292ZXJhYmxlIE1vZGUNCj4gPiA+PiArICAgICAgKiAgICAgIC0g
R2VuZXJhbCBEaXNjb3ZlcmFibGUgTW9kZQ0KPiA+ID4+ICsgICAgICAqLw0KPiA+ID4+ICsgICAg
IGlmICgoY3AudHlwZSA9PSBMRV9BRFZfTk9OQ09OTl9JTkQpIHx8IChjcC50eXBlID0NCj4gPiA+
PiArIExFX0FEVl9TQ0FOX0lORCkpIHsNCj4gPiA+DQo+ID4gPiBUaGlzIGV4dHJhICh4ID09IHkp
IHBhcmVudGhlc2VzIGFyZSBub3QgbmVlZGVkLg0KPiA+DQo+ID4gQnR3IHRoZSBzZWNvbmQgcGFy
dCBvZiB0aGUgZXhwcmVzc2lvbiBzZWVtIHdyb25nLCBpdCBpcyBhc3NpZ25pbmcgbm90DQo+ID4g
Y29tcGFyaW5nLg0KPiBZZXMsIHRoZSBhc3NpZ25tZW50IHdhcyBhbHdheXMgbWFraW5nIHRoZSBj
b25kaXRpb24gdHJ1ZS4gSSBoYXZlIGZpeGVkIHRoZSB0eXBvDQo+IGFuZCByZXRlc3RlZCB0aGUg
cGF0Y2ggd29ya2luZy4NCj4gUGF0Y2ggdjIgd2lsbCBiZSBmb2xsb3dlZCB3aXRoIHRoZSBmaXgu
DQo+ID4NCj4gPiA+DQo+ID4gPj4gKyAgICAgICAgICAgICBpZiAoKGhjaV9kZXZfdGVzdF9mbGFn
KGhkZXYsIEhDSV9ESVNDT1ZFUkFCTEUpKSB8fA0KPiA+ID4+ICsgICAgICAgICAgICAgKGhjaV9k
ZXZfdGVzdF9mbGFnKGhkZXYsIEhDSV9MSU1JVEVEX0RJU0NPVkVSQUJMRSkpIHx8DQo+ID4gPj4g
KyAgICAgICAgICAgICAoaGRldi0+ZGlzY292ZXJ5LmxpbWl0ZWQgPT0gdHJ1ZSkpIHsNCj4gPiA+
DQo+ID4gPiBBbmQgdGhpcyBpcyB3cm9uZ2x5IGFsaWduZWQuIEluIGFkZGl0aW9uLCB5b3UgbmVl
ZCBhIGJpdCBtb3JlDQo+ID4gPiBjb21tZW50IHRleHQNCj4gPiBhYm92ZSBleHBsYWlucyBvbiB3
aGF0IGFyZSB0aGUgY29uZGl0aW9ucy4NCj4gPiA+DQo+ID4gPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGNwLm1pbl9pbnRlcnZhbCA9DQo+ID4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X3RvX2xlMTYoRElTQ09WX0xFX0ZBU1RfQURWX0lOVF9NSU4pOw0KPiA+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICBjcC5tYXhfaW50ZXJ2YWwgPQ0KPiA+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNwdV90b19sZTE2KERJU0NPVl9MRV9GQVNUX0FEVl9JTlRfTUFYKTsN
Cj4gPiA+PiArICAgICAgICAgICAgIH0NCj4gPiA+PiArICAgICB9DQo+ID4gPj4gKw0KPiA+ID4+
ICAgICAgIGNwLm93bl9hZGRyZXNzX3R5cGUgPSBvd25fYWRkcl90eXBlOw0KPiA+ID4+ICAgICAg
IGNwLmNoYW5uZWxfbWFwID0gaGRldi0+bGVfYWR2X2NoYW5uZWxfbWFwOw0KPiA+ID4NCj4gPiA+
IFJlZ2FyZHMNCj4gPiA+DQo+ID4gPiBNYXJjZWwNCj4gPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4g
LS0NCj4gPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+IFJlZ2FyZHMsDQo+IEJoYXJhdA0KDQpS
ZWdhcmRzLA0KQmhhcmF0DQo=
