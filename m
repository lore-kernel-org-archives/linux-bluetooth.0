Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07216C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68DA23130
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgLYIgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Dec 2020 03:36:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36539 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbgLYIgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Dec 2020 03:36:39 -0500
X-UUID: 35e7706932574e8eb813f59c06fee49e-20201225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c9JlnzUfi//evuzovP/hRxuHg/iJMxnwAlJYAOL08F4=;
        b=LMUaueQ1ZOFi7bp/nThegxp0pQQfHAQCnkZwilyk4XTEIWXF1uUqNhEfYcfkHMry9ek4a1zKxx41MHuHidJCXhRLHd9ndSWmWIex0k2c2iksWTXqXqoi1qcJWS2xuBwCudVOAj1vSyNZBJ9RvzVwzkwMQG2EYzJRsB7fraA/zRw=;
X-UUID: 35e7706932574e8eb813f59c06fee49e-20201225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2146465485; Fri, 25 Dec 2020 16:35:52 +0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Dec 2020 16:35:49 +0800
Received: from mtkmbs08n1.mediatek.inc ([fe80::158c:e14b:5c60:8675]) by
 mtkmbs08n1.mediatek.inc ([fe80::158c:e14b:5c60:8675%12]) with mapi id
 15.00.1497.000; Fri, 25 Dec 2020 16:35:49 +0800
From:   =?utf-8?B?TWFyay1ZVyBDaGVuICjpmbPmj5rmlocp?= 
        <Mark-YW.Chen@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= 
        <Peter.Tsao@mediatek.com>
Subject: RE: [PATCH 1/1] [Add support Mediatek mt7921U]
Thread-Topic: [PATCH 1/1] [Add support Mediatek mt7921U]
Thread-Index: AQHW2HPmDNuA3BvmpkmoYgXnFcNJUKoDHheAgALsLsA=
Date:   Fri, 25 Dec 2020 08:35:49 +0000
Message-ID: <292c69c1038242d5b0d03fb7b4675555@mtkmbs08n1.mediatek.inc>
References: <20201222150527.22904-1-Mark-YW.Chen@mediatek.com>
 <06C876AD-8232-418E-B3CB-96B88579BAF7@holtmann.org>
In-Reply-To: <06C876AD-8232-418E-B3CB-96B88579BAF7@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsIEkgd2lsbCByZW1vdmUg
dGhlIGR1cGxpY2F0ZSBkZWZpbml0aW9ucyBhbmQgZnVuY3Rpb25zLg0KDQpGaXJzdGx5LCB3ZSB3
aWxsIGFkZCB0aGUgc3VwcG9ydCBvZiBlbmFibGluZyBNVDc5MjFVIGluIGJ0dXNiLmMNClNlY29u
ZGFyeSwgd2Ugd2lsbCBkaXNjdXNzIHRoZSBkcml2ZXIgYXJjaGl0ZWN0dXJlIHdpdGggeW91Lg0K
RmluYWxseSwgd2UgdXBkYXRlIHRoZSBjb21tb24gcGFydCBhbmQgaGlmIHBhcnQgZm9yIE1UNzky
MS4NCg0KSSBoYXZlIGEgY291cGxlIHF1ZXN0aW9ucyBmb3IgZHJpdmVyIGFyY2hpdGVjdHVyZS4N
CjEuIEdsb2JhbCBkZXYuDQoyLiBVbmlmeSBjb21tb24gcGFydC4NCjMuIEhJRiBwYXJ0ICh1c2Iv
c2Rpby9wY2llL3VhcnQpDQoNCj4gSGkgTWFyaywNCj4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRo
ZSBzdXBwb3J0IG9mIGVuYWJsaW5nIE1UNzkyMVUsIGl0J3MgVVNCLWJhc2VkDQo+ID4gQmx1ZXRv
b3RoIGZ1bmN0aW9uLg0KPiA+DQo+ID4gVGhlcmUgYXJlIHNvbWUgY29tcG9uZW50IGluIHRoZSBN
ZWRpYXRlayBkcml2ZXIuDQo+ID4gMS4gQnRtdGtfbWFpbjogaXQncyBjb21tb24gY29kZSBmb3Ig
TWVkaWF0ZWsgZGV2aWNlcywNCj4gPiAgIHN1Y2ggYXMgZmlybXdhcmUgZG93bmxvYWQsIGNoaXAg
aW5pdGlhbGl6YXRpb24sDQo+ID4gICBzdGF0ZSBtYWNoaW5lIGhhbmRsaW5nIGFuZCBldGMuDQo+
ID4gMi4gQnRtdGt1c2I6IGl0J3MgZm9yIHVzYiBpbnRlcmZhY2UsDQo+ID4gICBzdWNoIGFzIHVz
YiBlbmRwb2ludCBlbnVtZXJhdGlvbiwgdXJiIGhhbmRsaW5nIGFuZCBldGMuDQo+ID4NCj4gPiBG
aXJzdGx5LCB3ZSB1cGRhdGUgdGhlIGNvbW1vbiBwYXJ0IGFuZCB1c2IgcGFydCBmb3IgTVQ3OTIx
VS4NCj4gPiBTZWNvbmRseSwgd2Ugd2lsbCBhZGQgdGhlIHN1cHBvcnQgTVQ3OTIxUywgaXQncyBT
RElPLWJhc2VkIGRldmljZS4NCj4gPiBGaW5hbGx5LCB3ZSB3aWxsIGFkZCB0aGUgcHJvY2VkdXJl
IHRvIHN1cHBvcnQgdWFydC9wY2llIGludGVyZmFjZXMuDQo+IA0KPiBjcmVhdGUgYSBidG10ay5b
Y2hdIG1vZHVsZSBsaWtlIHRoZSBvdGhlciB2ZW5kb3JzIGRpZCBpZiBpdCBtYWtlcyBzZW5zZS4N
Cj4gT3RoZXJ3aXNlIGp1c3Qgc2tpcCB0aGF0IHBhcnQgZm9yIG5vdyBhbmQgZ2V0IGJ0bXRrdXNi
LmMgZHJpdmVyIHdvcmtpbmcuIFlvdQ0KPiBjYW4gbGF0ZXIgdW5pZnkgYmV0d2VlbiBhbGwgMyB0
cmFuc3BvcnRzLg0KPiANCj4gSSB3b3VsZCBkbyB0aGUgbGF0dGVyIHNpbmNlIGl0IHdvdWxkIGZp
cnN0IG1ha2Ugc2Vuc2UgdG8gcmVhbGx5IHNlZSB3aGVyZSB0aGUNCj4gY29tbW9uIHBhcnRzIGFy
ZS4gQW5kIEkgaGF2ZSB0byBiZSBmcmFuaywgdGhpcyBkcml2ZXIgbmVlZHMgbWFzc2l2ZSBjbGVh
bnVwLiBJDQo+IGFtIG5vdCBnb2luZyB0byBhY2NlcHQgdGhpcyB0b25zIG9mIGNvcHktYW5kLXBh
c3RlIGxlZnQgYW5kIHJpZ2h0Lg0KPiANCj4gUGxlYXNlIHByb3ZpZGUgdGhlIGNvbnRlbnQgb2Yg
L3N5cy9rZXJuZWwvZGVidWcvdXNiL2RldmljZXMgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlLg0K
PiANCj4gPiArLyogVG8gc3VwcG9ydCBkeW5hbWljIG1vdW50IG9mIGludGVyZmFjZSBjYW4gYmUg
cHJvYmVkICovDQo+ID4gK3N0YXRpYyBpbnQgYnRtdGtfaW50Zl9udW0gPSBCVF9NQ1VfTUlOSU1V
TV9JTlRFUkZBQ0VfTlVNOw0KPiA+ICsvKiBUbyBhbGxvdyBnX2JkZXYgYmVpbmcgc2l6ZWQgZnJv
bSBidG10a19pbnRmX251bSBzZXR0aW5nICovDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgYnRtdGtfZGV2
ICoqZ19iZGV2Ow0KPiANCj4gTk8uIFBlcmlvZC4gTm8gZ2xvYmFsIGRldiBpbnN0YW5jZXMuDQoN
CltHbG9iYWwgZGV2Ll0NClRoZSBnbG9iYWwgZGV2IGlzIGZvciBvdXIgc3RhdGUgbWFjaGluZSB0
aGF0IGRlc2lnbiBmb3IgZXJyb3IgcmVjb3ZlcnksIHN1Y2ggYXMgY2hpcCByZXNldCwgbWVtb3J5
IGR1bXAgYW5kIGV0Yy4NCldlIG11c3QgdG8gbWFrZSBzdXJlIHN0YXRlIG1hY2hpbmUgdHJhbnNp
dGlvbiB0aGF0IGlzIHRoZSBzYW1lIGZsb3cgZm9yIGVhY2ggaW50ZXJmYWNlcyAodXNiL3NkaW8v
cGNpZS91YXJ0KS4NCltNZWRpYXRlayBkcml2ZXJdDQotPiBDcmVhdGUgYSBkZXYgYmVmb3JlIGlu
dGVyZmFjZSBwcm9iZS4NCltMaW51eCBrZXJuZWwgQmx1ZXRvb3RoIGRyaXZlcl0NCi0+IENyZWF0
ZSBhIGRldiBpbiBpbnRlcmZhY2UgcHJvYmUgKGJ0dXNiX3Byb2JlKS4NCg0KTWF5IHdlIGNyZWF0
ZSBhIGdsb2JhbCBkZXYgYmVmb3JlIGludGVyZmFjZSBwcm9iZT8NCg0KPiA+ICsNCj4gPiArLyoq
DQo+ID4gKyAqIEtlcm5lbCBNb2R1bGUgaW5pdC9leGl0IEZ1bmN0aW9ucw0KPiA+ICsgKi8NCj4g
PiArc3RhdGljIGludCBfX2luaXQgbWFpbl9kcml2ZXJfaW5pdCh2b2lkKQ0KPiA+ICt7DQo+ID4g
KwlpbnQgcmV0ID0gMDsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiArCS8qIE1lZGlhdGVrIERy
aXZlciBWZXJzaW9uICovDQo+ID4gKwlCVE1US19JTkZPKCIlczogTVRLIEJUIERyaXZlciBWZXJz
aW9uIDogJXMiLCBfX2Z1bmNfXywgVkVSU0lPTik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbWFpbl9p
bml0KCk7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4g
PiArCWZvciAoaSA9IDA7IGkgPCBidG10a19pbnRmX251bTsgaSsrKQ0KPiA+ICsJCWJ0bXRrX3Nl
dF9jaGlwX3N0YXRlKGdfYmRldltpXSwgQlRNVEtfU1RBVEVfRElTQ09OTkVDVCk7DQo+ID4gKw0K
PiA+ICsJcmV0ID0gYnRtdGtfY2lmX3JlZ2lzdGVyKCk7DQo+ID4gKwlpZiAocmV0IDwgMCkgew0K
PiA+ICsJCUJUTVRLX0VSUigiKioqIFVTQiByZWdpc3RyYXRpb24gZmFpbGVkKCVkKSEgKioqIiwg
cmV0KTsNCj4gPiArCQltYWluX2V4aXQoKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCUJUTVRLX0lORk8oIiVzOiBEb25lIiwgX19mdW5jX18pOw0KPiA+ICsJcmV0
dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gTk8uIFBlcmlvZC4gVXNlIG1vZHVsZV91c2JfZHJpdmVy
KCkgYW5kIGlmIHlvdSBuZWVkIGFueXRoaW5nIG1vcmUsIHlvdSBhcmUNCj4gZG9pbmcgc29tZXRo
aW5nIHdyb25nLg0KDQpXZSB3b3VsZCBsaWtlIHRvIHVuaWZ5IHN0YXRlIG1hY2hpbmUsIGRldiBh
bGxvY2F0ZSwgaGlmX2hvb2sgYW5kIGhpZl9yZWdpc3Rlci4NCltVbmlmeSBDb21tb24gUGFydF06
IGJ0bXRrX21haW4NClN0YXRlIG1hY2hpbmU6IE1lZGlhdGVrIGNoaXAgZXJyb3IgcmVjb3ZlcnkN
CkRldiBhbGxvY2F0ZTogQmx1ZXRvb3RoIGRldi4NCk1lZGlhdGVrIGNoaXAtcmVsYXRlZCBiZWhh
dmlvcjogRmlybXdhcmUgZG93bmxvYWQuDQpIQ0kgZGV2aWNlLXJlbGF0ZWQ6IGhjaSByZWdpc3Rl
ciwgb3BlbiwgY2xvc2UgYW5kIHNlbmRfZnJhbWUuDQoNCltISUYgUGFydF0gOiBidG10a3VzYi9i
dG10a3NkaW8vYnRtdGt1YXJ0DQpoaWZfaG9vayAoY2lmIGludGVyZmFjZSk6IHJlYWQvd3JpdGUg
cmVnaXN0ZXIsIG9wZW4vY2xvc2UsIGNoaXAgcmVzZXQgYW5kIGV0Yy4NCmhpZl9yZWdpc3RlciAo
Y2lmIHJlZ2lzdGVyKTogaGlmIHJlZ2lzdHJhdGlvbi1yZWxhdGVkLCBzdWNoIGFzIHVzYl9yZWdp
c3Rlci9zZGlvX3JlZ2lzdGVyX2RyaXZlci4NCg0KTWF5IHdlIHVzZSB0aGUgZHJpdmVyIGFyY2hp
dGVjdHVyZT8NCg0KV2l0aCBiZXN0IHJlZ2FyZHMsDQpNYXJrDQo=
