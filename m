Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23DC2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 13:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70198205F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70198205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJ3WgQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:36:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:40034 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbeJ3WgQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 18:36:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 06:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="92386619"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 06:42:41 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 06:42:41 -0700
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 06:42:41 -0700
Received: from bgsmsx102.gar.corp.intel.com ([169.254.2.202]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.245]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 19:12:37 +0530
From:   "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Subject: RE: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
Thread-Topic: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
Thread-Index: AQHUcD6lWd2/N15BdkC4XEtkpGLI/6U3RREAgACGuWA=
Date:   Tue, 30 Oct 2018 13:42:37 +0000
Message-ID: <431554D50C88CC439737EC4A9A8AFB8C82324567@BGSMSX102.gar.corp.intel.com>
References: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <808682A2-B3E5-4269-A3A3-CDF302CB2CF6@holtmann.org>
In-Reply-To: <808682A2-B3E5-4269-A3A3-CDF302CB2CF6@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
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

SGkgTWFyY2VsLA0KDQpUaGFua3MgZm9yIHlvdXIgaW5wdXRzLCBJIHdpbGwgY3JlYXRlIHYxIHBh
dGNoIHdpdGggdGhlIG1vZGlmaWNhdGlvbiBhbmQgc2VudCBpdCBhZ2Fpbi4NCkJlc3QgIFJlZ2Fy
ZHMNCkNoZXRoYW4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFyY2Vs
IEhvbHRtYW5uIFttYWlsdG86bWFyY2VsQGhvbHRtYW5uLm9yZ10gDQpTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDMwLCAyMDE4IDQ6MzggUE0NClRvOiBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbiA8Y2hl
dGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIu
a2VybmVsLm9yZzsgQmFnLCBBbWl0IEsgPGFtaXQuay5iYWdAaW50ZWwuY29tPjsgSGVnZGUsIFJh
Z2h1cmFtIDxyYWdodXJhbS5oZWdkZUBpbnRlbC5jb20+OyBHaG9yYWksIFN1a3VtYXIgPHN1a3Vt
YXIuZ2hvcmFpQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBCbHVldG9vdGg6
IEFkZCBSZmtpbGwgZHJpdmVyIGZvciBJbnRlbCBCbHVldG9vdGggY29udHJvbGxlcg0KDQpIaSBD
aGV0aGFuLA0KDQo+IFJlZ2lzdGVyIEFDUEkgb2JqZWN0IElOVEw2MjA1IGFzIHBsYXRmb3JtIEJs
dWV0b290aCBSZktpbGwgZHJpdmVyIHRvIA0KPiBhdHRhY2gvZGV0YWNoIEludGVsIEJsdWV0b290
aCBjb250cm9sbGVyIGZyb20gcGxhdGZvcm0gVVNCIGJ1cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFJhZ2h1cmFtIEhlZ2RlIDxyYWdodXJhbS5oZWdkZUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IENoZXRoYW4gVCBOIDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogU3VrdW1hciBHaG9yYWkgPHN1a3VtYXIuZ2hvcmFpQGludGVsLmNvbT4NCj4g
LS0tDQo+IGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX2J0X3Jma2lsbC5jIHwgMTMzIA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDEzMyBp
bnNlcnRpb25zKCspDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbF9idF9yZmtpbGwuYw0KDQpJIHdvdWxkIGluY2x1ZGUgdGhlIEtjb25maWcgYW5kIE1ha2Vm
aWxlIGNoYW5nZXMgaGVyZSBzaW5jZSBpdCBpcyBhIHNtYWxsIGRyaXZlci4NCg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfYnRfcmZraWxsLmMgDQo+IGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWxfYnRfcmZraWxsLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi44OWEzZDdmNGIzMmMNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9idF9yZmtpbGwuYw0KPiBAQCAtMCwwICsx
LDEzMyBAQA0KPiArLyoNCj4gKyAqICBJbnRlbCBCbHVldG9vdGggUmZraWxsIERyaXZlcg0KPiAr
ICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9hY3BpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvcmZraWxsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5o
Pg0KPiArDQo+ICtzdHJ1Y3QgYnRpbnRlbF9yZmtpbGxfZGV2IHsNCj4gKwlzdHJ1Y3QgcmZraWxs
ICpyZms7DQoNCk1vc3QgZHJpdmVycyB1c2VkIHJma2lsbCBoZXJlIGluc3RlYWQgb2YgcmZrLiBJ
IG9ubHkgZm91bmQgb25lIHRoYXQgdXNlZCB0aGlzIGFiYnJldmlhdGlvbi4NCg0KPiArCXN0cnVj
dCBncGlvX2Rlc2MgKnJlc2V0X2dwaW9faGFuZGxlcjsgfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBhY3BpX2dwaW9fcGFyYW1zIHJlc2V0X2dwaW9zID0geyAwLCAwLCBmYWxzZSB9OyAN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9ncGlvX21hcHBpbmcgYWNwaV9idGludGVsX2dw
aW9zW10gPSB7DQo+ICsJeyAicmVzZXQtZ3Bpb3MiLCAmcmVzZXRfZ3Bpb3MsIDEgfSwNCj4gKwl7
IH0sDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGJ0
aW50ZWxfYWNwaV9tYXRjaFtdID0gew0KPiArCXsgIklOVEw2MjA1IiwgMCB9LA0KPiArCXsgfSwN
Cj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGksIGJ0aW50ZWxfYWNwaV9tYXRjaCk7
DQoNClBlcnNvbmFsbHkgSSBwdXQgdGhlc2UgYWJvdmUgdGhlIHBsYXRmb3JtX2RyaXZlciBzdHJ1
Y3QgcmlnaHQgYmVmb3JlIGl0IGlzIHVzZWQuDQoNCj4gKw0KPiArc3RhdGljIGludCBidGludGVs
X2Rpc2FibGVfYnQoc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3Bpbykgew0KPiArCWlmICghcmVz
ZXRfZ3BpbykNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwkvKiBUaGlzIHdpbGwgZGV0
YWNoIHRoZSBJbnRlbCBCVCBjb250cm9sbGVyICovDQo+ICsJZ3Bpb2Rfc2V0X3ZhbHVlKHJlc2V0
X2dwaW8sIDApOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGJ0aW50
ZWxfZW5hYmxlX2J0KHN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW8pIHsNCj4gKwlpZiAoIXJl
c2V0X2dwaW8pDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJLyogVGhpcyB3aWxsIHJl
LWF0dGFjaCB0aGUgSW50ZWwgQlQgY29udHJvbGxlciAqLw0KPiArCWdwaW9kX3NldF92YWx1ZShy
ZXNldF9ncGlvLCAxKTsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArLyogUkZLaWxsIGhh
bmRsZXJzICovDQo+ICtzdGF0aWMgaW50IGJ0X3Jma2lsbF9zZXRfYmxvY2sodm9pZCAqZGF0YSwg
Ym9vbCBibG9ja2VkKSB7DQo+ICsJc3RydWN0IGJ0aW50ZWxfcmZraWxsX2RldiAqYnRfZGV2ID0g
ZGF0YTsNCj4gKwlpbnQgcmV0Ow0KDQpUaGlzIGRyaXZlciBuZWVkcyBhIGJpdCBtb3JlIGNvbnNp
c3RlbmN5LiBFaXRoZXIgYnRpbnRlbF9yZmtpbGwgb3IgaW50ZWxfYnRfcmZraWxsLCBidXQgbGV0
cyBub3QgZ2V0IHRoaXMgY29uZnVzZWQgd2l0aCBhY3R1YWwgYnRpbnRlbF8gY29kZSB0aGF0IHdl
IGFscmVhZHkgaGF2ZS4NCg0KPiArDQo+ICsJaWYgKGJsb2NrZWQpDQo+ICsJCXJldCA9IGJ0aW50
ZWxfZGlzYWJsZV9idChidF9kZXYtPnJlc2V0X2dwaW9faGFuZGxlcik7DQo+ICsJZWxzZQ0KPiAr
CQlyZXQgPSBidGludGVsX2VuYWJsZV9idChidF9kZXYtPnJlc2V0X2dwaW9faGFuZGxlcik7DQo+
ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCByZmtpbGxf
b3BzIHJma19vcHMgPSB7DQo+ICsJLnNldF9ibG9jayA9IGJ0X3Jma2lsbF9zZXRfYmxvY2ssDQo+
ICt9Ow0KPiArDQo+ICsvKiBBQ1BJIG9iamVjdCBwcm9iZSAqLw0KPiArc3RhdGljIGludCBidGlu
dGVsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gKwlzdHJ1Y3QgYnRp
bnRlbF9yZmtpbGxfZGV2ICpidF9kZXY7DQo+ICsJaW50IHJlc3VsdDsNCj4gKw0KPiArCWJ0X2Rl
diA9IGt6YWxsb2Moc2l6ZW9mKCpidF9kZXYpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWJ0X2Rl
dikNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQoNCldvdWxk4oCZdCBpdCBiZXR0ZXIgdG8ganVzdCB1
c2UgdGhlIGRldm1fIHZlcnNpb24gaGVyZSBhbmQgbGV0IGl0IGhhbmRsZSB0aGUgbGlmZXRpbWUg
dHJhY2tpbmcgb2YgdGhlIGFzc29jaWF0ZWQgbWVtb3J5Lg0KDQo+ICsNCj4gKwlkZXZfc2V0X2Ry
dmRhdGEoJnBkZXYtPmRldiwgYnRfZGV2KTsNCj4gKw0KPiArCWlmIChhY3BpX2Rldl9hZGRfZHJp
dmVyX2dwaW9zKEFDUElfQ09NUEFOSU9OKCZwZGV2LT5kZXYpLA0KPiArCQkJCSAgICAgYWNwaV9i
dGludGVsX2dwaW9zKSkgew0KPiArCQlrZnJlZShidF9kZXYpOw0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gKwl9DQo+ICsNCj4gKwlidF9kZXYtPnJlc2V0X2dwaW9faGFuZGxlciA9IGRldm1fZ3Bp
b2RfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsDQo+ICsJCQkJCSJyZXNldCIsIEdQSU9EX09VVF9I
SUdIKTsNCj4gKwlpZiAoSVNfRVJSKGJ0X2Rldi0+cmVzZXRfZ3Bpb19oYW5kbGVyKSkgew0KPiAr
CQlrZnJlZShidF9kZXYpOw0KPiArCQlyZXR1cm4gUFRSX0VSUihidF9kZXYtPnJlc2V0X2dwaW9f
aGFuZGxlcik7DQo+ICsJfQ0KPiArDQo+ICsJYnRfZGV2LT5yZmsgPSByZmtpbGxfYWxsb2MoImlu
dGVsX2JsdWV0b290aCIsDQo+ICsJCQkJICAgJnBkZXYtPmRldiwNCj4gKwkJCQkgICBSRktJTExf
VFlQRV9CTFVFVE9PVEgsDQo+ICsJCQkJICAgJnJma19vcHMsDQo+ICsJCQkJICAgYnRfZGV2KTsN
Cj4gKwlpZiAoIWJ0X2Rldi0+cmZrKSB7DQo+ICsJCWtmcmVlKGJ0X2Rldik7DQo+ICsJCXJldHVy
biAtRU5PTUVNOw0KPiArCX0NCj4gKw0KPiArCXJlc3VsdCA9IHJma2lsbF9yZWdpc3RlcihidF9k
ZXYtPnJmayk7DQo+ICsJaWYgKHJlc3VsdCkgew0KPiArCQlyZmtpbGxfZGVzdHJveShidF9kZXYt
PnJmayk7DQo+ICsJCWtmcmVlKGJ0X2Rldik7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHJlc3Vs
dDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBidGludGVsX3JlbW92ZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KSB7DQo+ICsJc3RydWN0IGJ0aW50ZWxfcmZraWxsX2RldiAqYnRfZGV2
ID0gZGV2X2dldF9kcnZkYXRhKCZwZGV2LT5kZXYpOw0KPiArDQo+ICsJaWYgKGJ0X2Rldi0+cmZr
KSB7DQo+ICsJCXJma2lsbF91bnJlZ2lzdGVyKGJ0X2Rldi0+cmZrKTsNCj4gKwkJcmZraWxsX2Rl
c3Ryb3koYnRfZGV2LT5yZmspOw0KPiArCX0NCj4gKw0KPiArCWtmcmVlKGJ0X2Rldik7DQo+ICsN
Cj4gKwlhY3BpX2Rldl9yZW1vdmVfZHJpdmVyX2dwaW9zKEFDUElfQ09NUEFOSU9OKCZwZGV2LT5k
ZXYpKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBidGludGVsX2RyaXZlciA9IHsNCj4gKwkucHJvYmUgPSBidGludGVsX3By
b2JlLA0KPiArCS5yZW1vdmUgPSBidGludGVsX3JlbW92ZSwNCj4gKwkuZHJpdmVyID0gew0KPiAr
CQkubmFtZSA9ICJidGludGVs4oCdLA0KDQpJIGRvbuKAmXQgbGlrZSB0aGlzIG5hbWUgc2luY2Ug
aXQgaXMgdG9vIGdlbmVyaWMuIENhbGwgaXQgYnRpbnRlbF9yZmtpbGwgb3IgaW50ZWxfYnRfcmZr
aWxsLg0KDQo+ICsJCS5hY3BpX21hdGNoX3RhYmxlID0gQUNQSV9QVFIoYnRpbnRlbF9hY3BpX21h
dGNoKSwNCj4gKwl9LA0KPiArfTsNCj4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoYnRpbnRlbF9k
cml2ZXIpOw0KDQpSZWdhcmRzDQoNCk1hcmNlbA0KDQo=
