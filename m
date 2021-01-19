Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF63C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501D230FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbhASGXi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:23:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46193 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbhASFoJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 00:44:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10J5hBLW1027910, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10J5hBLW1027910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 13:43:11 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 13:43:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 19 Jan 2021 13:43:10 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::d4dd:5c6:e3c2:8a2f]) by
 RTEXMBS03.realtek.com.tw ([fe80::d4dd:5c6:e3c2:8a2f%2]) with mapi id
 15.01.2106.006; Tue, 19 Jan 2021 13:43:10 +0800
From:   Max Chou <max.chou@realtek.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Hilda Wu <hildawu@realtek.com>, KidmanLee <kidman@realtek.com>,
        Shyh-In Hwang <josephsih@chromium.org>
Subject: RE: [PATCH] Bluetooth: btrtl: Enable WBS for the specific Realtek devices
Thread-Topic: [PATCH] Bluetooth: btrtl: Enable WBS for the specific Realtek
 devices
Thread-Index: AQHW7Y0N00LzEnEOeEKqwsYoCEgNkqot2VsAgACW49A=
Date:   Tue, 19 Jan 2021 05:43:10 +0000
Message-ID: <f013444cfe874ac99140068f23ca031c@realtek.com>
References: <20210118112827.6192-1-max.chou@realtek.com>
 <CANFp7mVrUCyhs3jaNLC6fbOQGxfG4kgVQ69rKyS6urBM54SWKg@mail.gmail.com>
In-Reply-To: <CANFp7mVrUCyhs3jaNLC6fbOQGxfG4kgVQ69rKyS6urBM54SWKg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.163]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkhIEFiaGlzaGVrLA0KTXkgYmFkISBJIHNob3VsZCBjaGVjayB0aGUgY29kZSBiYXNlIGlzIHRo
ZSBsYXRlc3QgYW5kIGZvbGxvdyBpdC4NCkknbGwgc3VibWl0IHRoZSB2MiBwYXRjaC4gVGhhbmtz
IGZvciB5b3VyIHJldmlldy4NCg0KDQpCUnMsDQpNYXgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEFiaGlzaGVrIFBhbmRpdC1TdWJlZGkgPGFiaGlzaGVrcGFuZGl0QGNocm9t
aXVtLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE5LCAyMDIxIDEyOjQxIFBNDQpUbzog
TWF4IENob3UgPG1heC5jaG91QHJlYWx0ZWsuY29tPg0KQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFy
Y2VsQGhvbHRtYW5uLm9yZz47IEpvaGFuIEhlZGJlcmcgPGpvaGFuLmhlZGJlcmdAZ21haWwuY29t
PjsgTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+OyBCbHVleiBt
YWlsaW5nIGxpc3QgPGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgYWxleF9sdUByZWFsc2lsLmNvbS5jbjsgSGlsZGEg
V3UgPGhpbGRhd3VAcmVhbHRlay5jb20+OyBLaWRtYW5MZWUgPGtpZG1hbkByZWFsdGVrLmNvbT47
IFNoeWgtSW4gSHdhbmcgPGpvc2VwaHNpaEBjaHJvbWl1bS5vcmc+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSBCbHVldG9vdGg6IGJ0cnRsOiBFbmFibGUgV0JTIGZvciB0aGUgc3BlY2lmaWMgUmVhbHRl
ayBkZXZpY2VzDQoNCkhpIE1heCwNCg0KT24gTW9uLCBKYW4gMTgsIDIwMjEgYXQgMzoyOCBBTSA8
bWF4LmNob3VAcmVhbHRlay5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBNYXggQ2hvdSA8bWF4LmNo
b3VAcmVhbHRlay5jb20+DQo+DQo+IEJ5IHRoaXMgY2hhbmdlLCBpdCB3aWxsIGVuYWJsZSBXQlMg
c3VwcG9ydGVkIG9uIHRoZSBzcGVjaWZpYyBSZWFsdGVrIA0KPiBCVCBkZXZpY2VzLCBzdWNoIGFz
IFJUTDg4MjJDIGFuZCBSVEw4ODUyQS4NCj4gSW4gdGhlIGZ1dHVyZSwgaXQncyBhYmxlIHRvIG1h
aW50YWluIHdoYXQgdGhlIFJlYWx0ZWsgZGV2aWNlcyBzdXBwb3J0IA0KPiBXQlMgaGVyZS4NCj4N
Cj4gVGVzdGVkLWJ5OiBIaWxkYSBXdSA8aGlsZGF3dUByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogTWF4IENob3UgPG1heC5jaG91QHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0cnRsLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRy
dGwuYyANCj4gaW5kZXggMjRmMDNhMWY4ZDU3Li44MzU4MTljNDdhZTYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRy
dGwuYw0KPiBAQCAtMzgsNiArMzgsMTkgQEANCj4gICAgICAgICAuaGNpX3ZlciA9IChoY2l2KSwg
XA0KPiAgICAgICAgIC5oY2lfYnVzID0gKGJ1cykNCj4NCj4gK2VudW0gIGJ0cnRsX2NoaXBfaWQg
ew0KPiArICAgICAgIENISVBfSURfODcyM0EsICAgICAgICAgIC8qIGluZGV4ICAwIGZvciBSVEw4
NzIzQSovDQo+ICsgICAgICAgQ0hJUF9JRF84NzIzQiwgICAgICAgICAgLyogaW5kZXggIDEgZm9y
IFJUTDg3MjNCKi8NCj4gKyAgICAgICBDSElQX0lEXzg4MjFBLCAgICAgICAgICAvKiBpbmRleCAg
MiBmb3IgUlRMODgyMUEqLw0KPiArICAgICAgIENISVBfSURfODc2MUEsICAgICAgICAgIC8qIGlu
ZGV4ICAzIGZvciBSVEw4NzYxQSovDQo+ICsgICAgICAgQ0hJUF9JRF84ODIyQiA9IDgsICAgICAg
LyogaW5kZXggIDggZm9yIFJUTDg4MjJCICovDQo+ICsgICAgICAgQ0hJUF9JRF84NzIzRCwgICAg
ICAgICAgLyogaW5kZXggIDkgZm9yIFJUTDg3MjNEICovDQo+ICsgICAgICAgQ0hJUF9JRF84ODIx
QywgICAgICAgICAgLyogaW5kZXggMTAgZm9yIFJUTDg4MjFDICovDQo+ICsgICAgICAgQ0hJUF9J
RF84ODIyQyA9IDEzLCAgICAgLyogaW5kZXggMTMgZm9yIFJUTDg4MjJDICovDQo+ICsgICAgICAg
Q0hJUF9JRF84NzYxQiwgICAgICAgICAgLyogaW5kZXggMTQgZm9yIFJUTDg3NjFCICovDQo+ICsg
ICAgICAgQ0hJUF9JRF84ODUyQSA9IDE4LCAgICAgLyogaW5kZXggMTggZm9yIFJUTDg4NTJBICov
DQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgaWRfdGFibGUgew0KPiAgICAgICAgIF9fdTE2IG1hdGNo
X2ZsYWdzOw0KPiAgICAgICAgIF9fdTE2IGxtcF9zdWJ2ZXI7DQo+IEBAIC01OCw2ICs3MSw3IEBA
IHN0cnVjdCBidHJ0bF9kZXZpY2VfaW5mbyB7DQo+ICAgICAgICAgdTggKmNmZ19kYXRhOw0KPiAg
ICAgICAgIGludCBjZmdfbGVuOw0KPiAgICAgICAgIGJvb2wgZHJvcF9mdzsNCj4gKyAgICAgICBp
bnQgcHJvamVjdF9pZDsNCj4gIH07DQo+DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlkX3RhYmxl
IGljX2lkX3RhYmxlW10gPSB7IEBAIC0zMDcsOCArMzIxLDEwIEBAIA0KPiBzdGF0aWMgaW50IHJ0
bGJ0X3BhcnNlX2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPg0KPiAgICAgICAgIC8q
IEZpbmQgcHJvamVjdF9pZCBpbiB0YWJsZSAqLw0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKHByb2plY3RfaWRfdG9fbG1wX3N1YnZlcik7IGkrKykgew0KPiAtICAgICAgICAg
ICAgICAgaWYgKHByb2plY3RfaWQgPT0gcHJvamVjdF9pZF90b19sbXBfc3VidmVyW2ldLmlkKQ0K
PiArICAgICAgICAgICAgICAgaWYgKHByb2plY3RfaWQgPT0gcHJvamVjdF9pZF90b19sbXBfc3Vi
dmVyW2ldLmlkKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0cnRsX2Rldi0+cHJvamVj
dF9pZCA9IHByb2plY3RfaWQ7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAr
ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBpZiAoaSA+PSBBUlJB
WV9TSVpFKHByb2plY3RfaWRfdG9fbG1wX3N1YnZlcikpIHsgQEAgLTcyNSwxMiANCj4gKzc0MSwx
NiBAQCBpbnQgYnRydGxfc2V0dXBfcmVhbHRlayhzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gICAg
ICAgICAvKiBFbmFibGUgY2VudHJhbC1wZXJpcGhlcmFsIHJvbGUgKGFibGUgdG8gY3JlYXRlIG5l
dyBjb25uZWN0aW9ucyB3aXRoDQo+ICAgICAgICAgICogYW4gZXhpc3RpbmcgY29ubmVjdGlvbiBp
biBzbGF2ZSByb2xlKS4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBzd2l0Y2ggKGJ0cnRsX2Rl
di0+aWNfaW5mby0+bG1wX3N1YnZlcikgew0KPiAtICAgICAgIGNhc2UgUlRMX1JPTV9MTVBfODgy
MkI6DQo+ICsgICAgICAgLyogRW5hYmxlIFdCUyBzdXBwb3J0ZWQgZm9yIHRoZSBzcGVjaWZpYyBS
ZWFsdGVrIGRldmljZXMuICovDQo+ICsgICAgICAgc3dpdGNoIChidHJ0bF9kZXYtPnByb2plY3Rf
aWQpIHsNCj4gKyAgICAgICBjYXNlIENISVBfSURfODgyMkM6DQo+ICsgICAgICAgY2FzZSBDSElQ
X0lEXzg4NTJBOg0KPiAgICAgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfVkFMSURfTEVf
U1RBVEVTLCAmaGRldi0+cXVpcmtzKTsNCj4gKyAgICAgICAgICAgICAgIHNldF9iaXQoSENJX1FV
SVJLX1dJREVCQU5EX1NQRUVDSF9TVVBQT1JURUQsIA0KPiArICZoZGV2LT5xdWlya3MpOw0KPiAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAg
ICAgIHJ0bF9kZXZfZGJnKGhkZXYsICJDZW50cmFsLXBlcmlwaGVyYWwgcm9sZSBub3QgDQo+IGVu
YWJsZWQuIik7DQo+ICsgICAgICAgICAgICAgICBydGxfZGV2X2RiZyhoZGV2LCAiV0JTIHN1cHBv
cnRlZCBub3QgZW5hYmxlZC4iKTsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAg
IH0NCg0KVGhlcmUgaXMgYSBudWxsLWNoZWNrIG9uIGJ0cnRsX2Rldi0+aWNfaW5mbyByaWdodCBh
Ym92ZSB0aGlzIHN3aXRjaCBzdGF0ZW1lbnQgKGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L2JsdWV0b290aC9ibHVldG9vdGgtbmV4dC5naXQvY29tbWl0Lz9p
ZD1iNjQ5ODEzZWFkYmMwNjJkODY4MmY3YTIwYWEwMjUyNzU3MDdkZDFmKS4NCklzIHRoaXMgc3Rp
bGwgbmVjZXNzYXJ5IHdpdGggdGhpcyBjaGFuZ2U/IChTb3JyeSwgSSBtaXNzZWQgdGhpcyBkdXJp
bmcgb3VyIHByZXZpb3VzIHJldmlldykuDQoNCj4NCj4gLS0NCj4gMi4xNy4xDQo+DQoNCkFiaGlz
aGVrDQoNCi0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50
aW5nIHRoaXMgZS1tYWlsLg0K
