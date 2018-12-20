Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD9C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A808218E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeLTSJ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:09:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:13177 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbeLTSJ0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 13:09:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 10:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,378,1539673200"; 
   d="scan'208";a="120474401"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2018 10:09:26 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.191]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 10:09:26 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Advertising report address types in mesh-io-generic
Thread-Topic: Advertising report address types in mesh-io-generic
Thread-Index: AQHUmH990Rtnuxk2F02mhgDFxAy+7aWH2PfAgACYuAD//3q28A==
Date:   Thu, 20 Dec 2018 18:09:25 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E351D@ORSMSX101.amr.corp.intel.com>
References: <20181220161707.lxrzzvknqa64pmyc@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E337C@ORSMSX101.amr.corp.intel.com>
 <20181220180318.gwsj6aflihlppbgu@kynes>
In-Reply-To: <20181220180318.gwsj6aflihlppbgu@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWEyZjdhOTItZGI3Mi00YTY5LTg5MjAtM2E2ZGVmZDI0ZTA5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWFuUTlCeVZ1WmpcL29ZUzhPWk5PMWVoeHlNY2lJaEtUdlVMQnJMbm1jMmZDR2xKNnF4ejVWd2poZTNoS24wVm4ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
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
aG9uZWsNCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIwLCAyMDE4IDEwOjAzIEFNDQo+IFRv
OiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBBZHZlcnRp
c2luZyByZXBvcnQgYWRkcmVzcyB0eXBlcyBpbiBtZXNoLWlvLWdlbmVyaWMNCj4gDQo+IEJyaWFu
LA0KPiANCj4gVGhhbmtzIGZvciB0YWtpbmcgdGltZSB0byBsb29rIGludG8gdGhpcy4NCj4gDQo+
IE9uIDEyLzIwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+ID4gCWlmIChldnQtPmFkZHJfdHlwZSAh
PSBCREFERFJfTEVfUFVCTElDICYmDQo+ID4gPiAJCQlldnQtPmFkZHJfdHlwZSAhPSBCREFERFJf
TEVfUkFORE9NKQ0KPiA+ID4gCQlyZXR1cm47DQo+ID4NCj4gPiBBZGRyZXNzIHR5cGVzIGNhbiBi
ZSBCUi9FRFIgKDB4MDApLCBMRSBQdWJsaWMgKDB4MDEpLCBhbmQgTEUgUmFuZG9tDQo+ICgweDAy
KS4NCj4gPg0KPiA+IFRoaXMgZmlsdGVycyBvdXQgQlIvRURSIGFkdmVydGlzZW1lbnRzLCB3aGlj
aCBhcmUgbm90IHN1cHBvcnRlZCBpbiBNZXNoLg0KPiAoc2hvdWxkIGJlIExFIE9ubHkpLg0KPiBI
bW0uIENvcnJlY3QgbWUgaWYgSSdtIHdyb25nLCBidXQgdGhlIEJsdWV0b290aCBDb3JlIDUuMCBz
cGVjLCBWb2x1bWUgMiwNCj4gcGFydCBFLCBjaGFwdGVyIDcuNy42NS4yICJMRSBBZHZlcnRpc2lu
ZyBSZXBvcnQgRXZlbnQiLCB3aGljaCBJIGJlbGlldmUgd2UncmUNCj4gZGVhbGluZyB3aXRoLCBi
ZWNhdXNlIG9mOg0KPiANCj4gc3RhdGljIGJvb2wgZGV2X2luaXQodWludDE2X3QgaW5kZXgsIHN0
cnVjdCBtZXNoX2lvICppbykgew0KPiAgICAgLi4uDQo+IAlidF9oY2lfcmVnaXN0ZXIodG1wLT5o
Y2ksIEJUX0hDSV9FVlRfTEVfTUVUQV9FVkVOVCwNCj4gCQkJCQkJZXZlbnRfY2FsbGJhY2ssIGlv
LCBOVUxMKTsNCj4gDQo+IGFuZA0KPiANCj4gc3RhdGljIHZvaWQgZXZlbnRfY2FsbGJhY2soY29u
c3Qgdm9pZCAqYnVmLCB1aW50OF90IHNpemUsIHZvaWQgKnVzZXJfZGF0YSkgew0KPiAgICAgLi4u
DQo+IAlzd2l0Y2ggKGV2ZW50KSB7DQo+IAljYXNlIEJUX0hDSV9FVlRfTEVfQURWX1JFUE9SVDoN
Cj4gCQlldmVudF9hZHZfcmVwb3J0KGlvLCBidWYgKyAxLCBzaXplIC0gMSk7DQo+IAkJYnJlYWs7
DQo+IA0KPiBzYXlzIHRoYXQgImFkZHJlc3MgdHlwZSIgaW4gdGhhdCBldmVudCBpcyBvbmUgb2Y6
DQo+IA0KPiAweDAwIFB1YmxpYyBEZXZpY2UgQWRkcmVzcw0KPiAweDAxIFJhbmRvbSBEZXZpY2Ug
QWRkcmVzcw0KPiAweDAyIFB1YmxpYyBJZGVudGl0eSBBZGRyZXNzIChDb3JyZXNwb25kcyB0byBS
ZXNvbHZlZCBQcml2YXRlIEFkZHJlc3MpDQo+IDB4MDMgUmFuZG9tIChzdGF0aWMpIElkZW50aXR5
IEFkZHJlc3MgKENvcnJlc3BvbmRzIHRvIFJlc29sdmVkIFByaXZhdGUNCj4gICAgICBBZGRyZXNz
KQ0KPiANCj4gYW5kIG5vd2hlcmUgZG9lcyBpdCBtZW50aW9uIEJSL0VEUi4NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgd2UncmUgc3VwcG9zZWQgdG8gZXZlbiByZWNlaXZlIEJSL0VEUiBhZGRyZXNzZXMg
dmlhIEhDSSBMRQ0KPiBNZXRhIEV2ZW50Lg0KDQpJIHRoaW5rIHlvdSBhcmUgcHJvYmFibHkgY29y
cmVjdC4gIFRoaXMgbWF5IGJlIGEgcmVtbmFudCB0aGF0IHdlIHBpY2tlZCB1cCBmcm9tIGNvZGUg
dGhhdCB3YXMNCmludGVuZGVkIHRvIHNlcnZlIGJvdGggQlIvRURSIGFuZCBMRSBhZHZlcnRpc2Vt
ZW50cy4gIEkgd2lsbCByZW1vdmUgdGhhdCBjaGVjayBmaXJzdCB0aGluZyBhZnRlciANCnRoZSBl
eGlzdGluZyBwYXRjaHNldCBpcyBhcHBsaWVkLg0KDQoNCj4gDQo+IGNoZWVycw0KPiAtLQ0KPiBN
aWNoYcWCIExvd2FzLVJ6ZWNob25layA8bWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNv
bT4NCj4gU2lsdmFpciBodHRwOi8vc2lsdmFpci5jb20NCj4gSmFzbm9nw7Nyc2thIDQ0LCAzMS0z
NTggS3Jha293LCBQT0xBTkQNCg==
