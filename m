Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF62C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 10:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8B961287
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 10:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhGVJsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:48:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40885 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhGVJsM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 05:48:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16MASWggC027040, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16MASWggC027040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Jul 2021 18:28:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Jul 2021 18:28:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Jul 2021 18:28:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Thu, 22 Jul 2021 18:28:31 +0800
From:   Hilda Wu <hildawu@realtek.com>
To:     Pauli Virtanen <pav@iki.fi>, Joseph Hwang <josephsih@google.com>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>
Subject: RE: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT 3 for WBS
Thread-Topic: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT
 3 for WBS
Thread-Index: AQHXemwviFRVpCPru0u/Sm2iHuJJI6tGphyAgAZsZoCAAZgZcA==
Date:   Thu, 22 Jul 2021 10:28:31 +0000
Message-ID: <3b249bde3ccf4fa7b53a53f2033e93b2@realtek.com>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
         <CAHFy41_-EYBNnKyLPof40r6jhtBW=mSHjOX6O=+hzLCbf7_ELQ@mail.gmail.com>
 <f0a3fae602bb54313d078563d971827c88315b43.camel@iki.fi>
In-Reply-To: <f0a3fae602bb54313d078563d971827c88315b43.camel@iki.fi>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.191]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjIg5LiK5Y2IIDA2OjI4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/22/2021 10:14:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165171 [Jul 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/22/2021 10:17:00
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgeW91ciBzdXBwbGVtZW50Lg0KQWRkIHRoZSBzY29fbXR1IGNvbmRp
dGlvbiBpcyBiZXR0ZXIuDQoNCldoZW4gVVNCIEJUIGFkYXB0ZXJzIHN1cHBvcnQgdGhlIGFsdGVy
bmF0ZSAzLCBpdCB3aWxsIGFubm91bmNlIGFsdGVybmF0ZSAzLg0KSG93ZXZlciwgVVNCIEFsdCAz
IHN1cHBvcnRlZCBhbHNvIG5lZWQgSEZQIHN1cHBvcnQgdHJhbnNwYXJlbnQgTVRVIGluIDcyIEJ5
dGVzLg0KQWRkIHRoaXMgc2NvX210dSBjb25kaXRpb24gY291bGQgYXZvaWQgSEZQIHByb2ZpbGUg
dHJhbnNwYXJlbnQgTVRVIG5vdCBtYXRjaCBvciBub3Qgc3VpdGFibGUgQUxUIDMuDQoNClJlZ2Fy
ZHMsDQpIaWxkYQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGF1bGkgVmly
dGFuZW4gPHBhdkBpa2kuZmk+IA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDIxLCAyMDIxIDExOjQw
IFBNDQpUbzogSm9zZXBoIEh3YW5nIDxqb3NlcGhzaWhAZ29vZ2xlLmNvbT4NCkNjOiBsaW51eC1i
bHVldG9vdGggPGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+OyBIaWxkYSBXdSA8aGls
ZGF3dUByZWFsdGVrLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEJsdWV0b290aDogYnR1c2I6
IGNoZWNrIFNDTyBNVFUgYmVmb3JlIGVuYWJsaW5nIFVTQiBBTFQgMyBmb3IgV0JTDQoNCkhpLA0K
DQpsYSwgMjAyMS0wNy0xNyBrZWxsbyAyMTozNCArMDgwMCwgSm9zZXBoIEh3YW5nIGtpcmpvaXR0
aToNCj4gSXQgbG9va3MgcmVhc29uYWJsZSB0byBjaGVjayBzY29fbXR1LiBNeSBzdWdnZXN0aW9u
IGlzIHRvIHVzZSANCj4gaGNpX3BhY2tldF9zaXplX3VzYl9hbHRbM10gaW5zdGVhZCBvZiB0aGUg
bWFnaWMgbnVtYmVyIDcyLg0KDQpUaGFua3MgZm9yIGxvb2tpbmcgYXQgaXQuIElJVUMsIGhjaV9w
YWNrZXRfc2l6ZV91c2JfYWx0IG9ubHkgYXBwZWFycyBpbiBwcmV2aW91cyBkaXNjdXNzaW9ucyBv
biB0aGlzIGxpc3QsIHdoaWNoIGRpZCBub3Qgc2VlbSB0byByZWFjaCBhIGNvbmNsdXNpb24gaWYg
dGhpcyBzaG91bGQgYmUgY29tcHV0ZWQgZnJvbSB3TWF4UGFja2V0U2l6ZS4gSSBjYW4gZG8gbGVz
cyBtYWdpY2FsIHYyIGFuZCBhZGQgdGhlIHRhYmxlLg0KDQpEaWZmZXJlbnQgc29sdXRpb24gd291
bGQgYmUgdG8gbWFrZSB0aGUgYWx0c2V0dGluZyBjaG9pY2UgbWFudWZhY3R1cmVyL2RldmljZSBz
cGVjaWZpYyBmbGFnLCBhcyBJJ20gbm90IHN1cmUgb24gd2hhdCBoYXJkd2FyZSBlODQ4ZGJkMzY0
YWMgd2FzIHRlc3RlZCBvbiwgc28gbWF5YmUgaXQgaXMgaW50ZW5kZWQgUmVhbHRlayBzcGVjaWZp
Yy4NCg0KQmVzdCwNClBhdWxpDQoNCg0KPiBPbiBTYXQsIEp1bCAxNywgMjAyMSBhdCAxOjU4IEFN
IFBhdWxpIFZpcnRhbmVuIDxwYXZAaWtpLmZpPiB3cm90ZToNCj4gPiANCj4gPiBTb21lIFVTQiBC
VCBhZGFwdGVycyBkb24ndCBzYXRpc2Z5IHRoZSBNVFUgcmVxdWlyZW1lbnQgbWVudGlvbmVkIGlu
IA0KPiA+IGNvbW1pdCBlODQ4ZGJkMzY0YWMgKCJCbHVldG9vdGg6IGJ0dXNiOiBBZGQgc3VwcG9y
dCBVU0IgQUxUIDMgZm9yIA0KPiA+IFdCUyIpIGFuZCBoYXZlIEFMVCAzIHNldHRpbmcgdGhhdCBw
cm9kdWNlcyBuby9nYXJibGVkIGF1ZGlvLiBDaGVjayANCj4gPiB0aGF0IHRoZSBNVFUgY29uZGl0
aW9uIGlzIHNhdGlzZmllZCwgYW5kIGZhbGwgYmFjayB0byBBTFQgMSBpZiBub3QuDQo+ID4gDQo+
ID4gVGVzdGVkIHdpdGggVVNCIGFkYXB0ZXJzIChtdHU8NzIsIHByb2R1Y2Ugc291bmQgb25seSB3
aXRoIEFMVDEpDQo+ID4gQkNNMjA3MDJBMSAwYjA1OjE3Y2IsIENTUjg1MTBBMTAgMGExMjowMDAx
LCBhbmQgKG10dT49NzIsIEFMVDMpIA0KPiA+IFJUTDg3NjFCVSAwYmRhOjg3NzEsIEludGVsIEFY
MjAwIDgwODc6MDAyOSAoYWZ0ZXIgZGlzYWJsaW5nIEFMVDYpLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBhdWxpIFZpcnRhbmVuIDxwYXZAaWtpLmZpPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2JsdWV0b290aC9idHVzYi5jIHwgNiArKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgDQo+ID4gaW5k
ZXggYTk4NTVhMmRkNTYxLi4zZWU2NmU0MTVjNGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4g
PiBAQCAtMTc2Myw5ICsxNzYzLDExIEBAIHN0YXRpYyB2b2lkIGJ0dXNiX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIEJlY2F1c2Ug
bVNCQyBmcmFtZXMgZG8gbm90IG5lZWQgdG8gYmUgYWxpZ25lZCB0byB0aGUNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBTQ08gcGFja2V0IGJvdW5kYXJ5LiBJZiBzdXBwb3J0IHRoZSBB
bHQgMywgdXNlIHRoZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAqIEFsdCAzIGZvciBI
Q0kgcGF5bG9hZCA+PSA2MCBCeXRlcyBsZXQgYWlyIHBhY2tldA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAqIGRhdGEgc2F0aXNmeSA2MCBieXRlcy4NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgKiBkYXRhIHNhdGlzZnkgNjAgYnl0ZXMuIFVTQiBBbHQgMyBzdXBwb3J0IGFsc28g
bmVlZHMNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBIRlAgdHJhbnNwYXJlbnQgTVRV
ID49IDcyIEJ5dGVzLg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGlmIChuZXdfYWx0cyA9PSAxICYmIGJ0dXNiX2ZpbmRfYWx0c2V0
dGluZyhkYXRhLCAzKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobmV3X2FsdHMg
PT0gMSAmJiBoZGV2LT5zY29fbXR1ID49IDcyICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ0dXNiX2ZpbmRfYWx0c2V0dGluZyhkYXRhLCAzKSkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5ld19hbHRzID0gMzsNCj4gPiAgICAgICAgICAgICAgICAgfQ0K
PiA+IA0KPiA+IC0tDQo+ID4gMi4zMS4xDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0KDQotLS0tLS1Q
bGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFp
bC4NCg==
