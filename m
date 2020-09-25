Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E55C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07712087D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 08:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIYIXl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:23:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58193 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYIXl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 04:23:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P8NRU00031147, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P8NRU00031147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 16:23:27 +0800
Received: from RSEXMBS01.realsil.com.cn (172.29.17.195) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 16:23:26 +0800
Received: from RSEXMBS01.realsil.com.cn ([fe80::e186:b533:fb3:8b37]) by
 RSEXMBS01.realsil.com.cn ([fe80::e186:b533:fb3:8b37%7]) with mapi id
 15.01.2044.004; Fri, 25 Sep 2020 16:23:26 +0800
From:   =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system resume
Thread-Topic: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
Thread-Index: AdaTFDyzjigV3dr0CE6uDdt266LELw==
Date:   Fri, 25 Sep 2020 08:23:26 +0000
Message-ID: <30ce4ee1eede47c09c3e7f277c26918a@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.36.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgS2FpLUhlbmcsDQoNCj4gT24gU2VwdGVtYmVyIDI1LCAyMDIwIGF0IDE1OjU2LCBLYWktSGVu
ZyBGZW5nIHdyb3RlOg0KPiANCj4gSGkgQWxleCwNCj4gDQo+ID4gT24gU2VwIDI1LCAyMDIwLCBh
dCAxNTo0Miwg6ZmG5pyx5LyfIDxhbGV4X2x1QHJlYWxzaWwuY29tLmNuPiB3cm90ZToNCj4gPg0K
PiA+IEhpIEthaS1IZW5nLA0KPiA+DQo+ID4+IE9uIDI1IFNlcHRlbWJlciAyMDIwIGF0IDE1OjE0
LCBLYWktSGVuZyBGZW5nIHdyb3RlOg0KPiA+Pg0KPiA+PiBIaSBBbGV4LA0KPiANCj4gW3NuaXBw
ZWRdDQo+IA0KPiA+PiBBcHBhcmVudGx5IGZvciBteSBjYXNlLCBSVEw4ODIxQ0UsIGZpcm13YXJl
IHdhcyBrZXB0IHdpdGhvdXQgc2V0dGluZw0KPiA+PiByZW1vdGUgd2FrZXVwLg0KPiA+DQo+ID4g
U28geW91IGdvdCB0aGUgYnR1c2IgZGlzY29ubmVjdCBhbmQgcmVwcm9iZSBzZXF1ZW5jZSBhZnRl
ciByZXN1bWUsIGFuZCAiDQo+IEJsdWV0b290aDogaGNpMDogY29tbWFuZCAweDEwMDEgdHggdGlt
ZW91dCAiIGJlZm9yZSBmaXJtd2FyZSBkb3dubG9hZGluZyA/DQo+IA0KPiBVU0IgcG93ZXIgd2Fz
bid0IGxvc3QsIGJ1dCBpdCBnb3QgVVNCIHdhcm0gcmVzZXQgYmVjYXVzZSBidHVzYiBkcml2ZXIN
Cj4gZXhwbGljaXRseSBmbGFnZ2VkICJyZXNldF9yZXN1bWUgPSAxIi4NCj4gVGhlbiB0aGUgaXNz
dWUgYXBwZWFyZWQgYXMgIkJsdWV0b290aDogaGNpMDogY29tbWFuZCAweDEwMDEgdHggdGltZW91
dCIsDQo+IGJlZm9yZSBkb3dubG9hZGluZyBmaXJtd2FyZS4NCj4gDQo+ID4NCj4gPj4gSXMgaXQg
b2theSB0byBhbHNvIHNldCByZW1vdGUgd2FrZXVwIGZvciBnbG9iYWwgc3VzcGVuZCB0byByZXRh
aW4gdGhlDQo+ID4+IGZpcm13YXJlPw0KPiA+DQo+ID4gWWVzLCBpdCdzIG9rLg0KPiANCj4gQWJo
aXNoZWssIGRvZXMgc2V0dGluZyByZW1vdGUgd2FrZXVwIGR1cmluZyBnbG9iYWwgc3VzcGVuZCB3
b3JrcyBmb3IgeW91Pw0KIA0KSXQgZGVwZW5kcyBvbiB5b3VyIGRlc2lyZSBvbiBwb3dlciBjb25z
dW1wdGlvbiBkdXJpbmcgZ2xvYmFsIHN1c3BlbmQuDQpUaGUgQlQgY29udHJvbGxlciB0YWtlcyBs
ZXNzIHBvd2VyIGlmIGZpcm13YXJlIHdhcyBsb3N0IGR1cmluZyBnbG9iYWwgc3VzcGVuZC4NCg0K
PiANCj4gPg0KPiA+PiBJZiBmaXJtd2FyZSB3YXMgcmV0YWluZWQsIGRvZXMgVVNCIHdhcm0gcmVz
ZXQgYWZmZWN0IEJUIGNvbnRyb2xsZXIgaW4NCj4gPj4gYW55d2F5Pw0KPiA+DQo+ID4gVVNCIHdh
cm0gcmVzZXQgc2hvdWxkbid0IGFmZmVjdCBCVCBjb250cm9sbGVyLg0KPiA+IEJ1dCBoY2kgZGV2
aWNlIHdpbGwgbm90IHdvcmsgYWZ0ZXIgcmVzdW1lLCBiZWNhdXNlIGJ0cnRsIHdpbGwgZmluZCAi
dW5rbm93bg0KPiBJQyBpbmZvLCBsbXAgc3VidmVydCAuLi4iIGFuZCByZXR1cm4gZXJyb3Igd2hl
biBoY2kgZGV2aWNlIHNldHVwIGlzIGNhbGxlZC4NCj4gPiBUaXBzOiBUaGUgbG1wIHN1YnZlciBp
biBjb250cm9sbGVyIGNoYW5nZXMgYWZ0ZXIgZmlybXdhcmUgZG93bmxvYWRpbmcuDQo+IEFuZCBk
cml2ZXIgd2lsbCBmaW5kICIgdW5rbm93biBJQyBpbmZvLCBsbXAgc3VidmVyICAuLi4iIHdoZW4g
c2V0dXAgaXMgY2FsbGVkDQo+IHdpdGggZmlybXdhcmUgcmV0YWluZWQuDQo+IA0KPiBUaGlzIHNo
b3VsZCBhbHJlYWR5IGJlIGZpeGVkIGJ5ICJCbHVldG9vdGg6IGJ0cnRsOiBSZXN0b3JlIG9sZCBs
b2dpYyB0byBhc3N1bWUNCj4gZmlybXdhcmUgaXMgYWxyZWFkeSBsb2FkZWQiLg0KPiANCj4gS2Fp
LUhlbmcNCj4gDQo+ID4NCj4gPj4NCj4gPj4gS2FpLUhlbmcNCj4gPj4NCj4gPj4+DQo+ID4+Pj4N
Cj4gPj4+PiBLYWktSGVuZw0KPiA+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+IEBBbGV4IC0tIFdoYXQg
aXMgdGhlIGNvbW1vbiBiZWhhdmlvciBmb3IgUmVhbHRlayBjb250cm9sbGVycz8NCj4gU2hvdWxk
DQo+ID4+Pj4+IHdlIHNldCBCVFVTQl9XQUtFVVBfRElTQUJMRSBvbmx5IG9uIFJUTDg4MjJDRSBv
ciBzaG91bGQgd2UNCj4gdW5zZXQNCj4gPj4gaXQNCj4gPj4+Pj4gb25seSBvbiBSVEw4ODIxQ0U/
DQo+ID4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBJIHdvdWxkIHByZWZlciB0aGlzIGRvZXNu
J3QgZ2V0IGFjY2VwdGVkIGluIGl0cyBjdXJyZW50IHN0YXRlLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IE9mIGNvdXJzZS4NCj4gPj4+Pj4+IEkgdGhpbmsgd2UgbmVlZCB0byBmaW5kIHRoZSByb290IGNh
dXNlIGZvciB5b3VyIGNhc2UgYmVmb3JlIGFwcGx5aW5nDQo+IHRoaXMNCj4gPj4+PiBvbmUuDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gS2FpLUhlbmcNCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
PiBBYmhpc2hlaw0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gT24gV2VkLCBTZXAgMjMsIDIwMjAgYXQg
MTA6NTYgQU0gS2FpLUhlbmcgRmVuZw0KPiA+Pj4+Pj4+IDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNh
bC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBSZWFsdGVrIGJsdWV0b290aCBj
b250cm9sbGVyIG1heSBmYWlsIHRvIHdvcmsgYWZ0ZXIgc3lzdGVtIHNsZWVwOg0KPiA+Pj4+Pj4+
PiBbIDEyNzIuNzA3NjcwXSBCbHVldG9vdGg6IGhjaTA6IGNvbW1hbmQgMHgxMDAxIHR4IHRpbWVv
dXQNCj4gPj4+Pj4+Pj4gWyAxMjgwLjgzNTcxMl0gQmx1ZXRvb3RoOiBoY2kwOiBSVEw6DQo+IEhD
SV9PUF9SRUFEX0xPQ0FMX1ZFUlNJT04NCj4gPj4+PiBmYWlsZWQgKC0xMTApDQo+ID4+Pj4+Pj4+
DQo+ID4+Pj4+Pj4+IElmIHBsYXRmb3JtIGZpcm13YXJlIGRvZXNuJ3QgY3V0IHBvd2VyIG9mZiBk
dXJpbmcgc3VzcGVuZCwgdGhlDQo+ID4+Pj4gZmlybXdhcmUNCj4gPj4+Pj4+Pj4gaXMgY29uc2lk
ZXJlZCByZXRhaW5lZCBpbiBjb250cm9sbGVyIGJ1dCB0aGUgZHJpdmVyIGlzIHN0aWxsIGFza2lu
ZyBVU0INCj4gPj4+Pj4+Pj4gY29yZSB0byBwZXJmb3JtIGEgcmVzZXQtcmVzdW1lLiBUaGlzIGNh
biBtYWtlIGJsdWV0b290aA0KPiBjb250cm9sbGVyDQo+ID4+Pj4+Pj4+IHVudXNhYmxlLg0KPiA+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBTbyBhdm9pZCB1bm5lY2Vzc2FyeSByZXNldCB0byByZXNvbHZl
IHRoZSBpc3N1ZS4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRm9yIGRldmljZXMgdGhhdCByZWFs
bHkgbG9zZSBwb3dlciBkdXJpbmcgc3VzcGVuZCwgVVNCIGNvcmUgd2lsbA0KPiA+PiBkZXRlY3QN
Cj4gPj4+Pj4+Pj4gYW5kIGhhbmRsZSByZXNldC1yZXN1bWUgY29ycmVjdGx5Lg0KPiA+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5n
QGNhbm9uaWNhbC5jb20+DQo+ID4+Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+PiBkcml2ZXJzL2JsdWV0
b290aC9idHVzYi5jIHwgOCArKystLS0tLQ0KPiA+Pj4+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
dXNiLmMNCj4gPj4+Pj4+Pj4gaW5kZXggOGQyNjA4ZGRmZDA4Li5kZTg2ZWY0Mzg4ZjkgMTAwNjQ0
DQo+ID4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPj4+Pj4+Pj4g
KysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+Pj4+Pj4+PiBAQCAtNDI1NSwxNyAr
NDI1NSwxNSBAQCBzdGF0aWMgaW50IGJ0dXNiX3N1c3BlbmQoc3RydWN0DQo+ID4+Pj4gdXNiX2lu
dGVyZmFjZSAqaW50ZiwgcG1fbWVzc2FnZV90IG1lc3NhZ2UpDQo+ID4+Pj4+Pj4+ICAgICAgICAg
ICAgIGVuYWJsZV9pcnEoZGF0YS0+b29iX3dha2VfaXJxKTsNCj4gPj4+Pj4+Pj4gICAgIH0NCj4g
Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gLSAgICAgICAvKiBGb3IgZ2xvYmFsIHN1c3BlbmQsIFJlYWx0
ZWsgZGV2aWNlcyBsb3NlIHRoZSBsb2FkZWQgZncNCj4gPj4+Pj4+Pj4gLSAgICAgICAgKiBpbiB0
aGVtLiBCdXQgZm9yIGF1dG9zdXNwZW5kLCBmaXJtd2FyZSBzaG91bGQgcmVtYWluLg0KPiA+Pj4+
Pj4+PiAtICAgICAgICAqIEFjdHVhbGx5LCBpdCBkZXBlbmRzIG9uIHdoZXRoZXIgdGhlIHVzYiBo
b3N0IHNlbmRzDQo+ID4+Pj4+Pj4+ICsgICAgICAgLyogRm9yIGdsb2JhbCBzdXNwZW5kLCBSZWFs
dGVrIGRldmljZXMgbG9zZSB0aGUgbG9hZGVkIGZ3IGluDQo+ID4+IHRoZW0NCj4gPj4+PiBpZg0K
PiA+Pj4+Pj4+PiArICAgICAgICAqIHBsYXRmb3JtIGZpcm13YXJlIGN1dCBwb3dlciBvZmYuIEJ1
dCBmb3IgYXV0b3N1c3BlbmQsDQo+ID4+Pj4gZmlybXdhcmUNCj4gPj4+Pj4+Pj4gKyAgICAgICAg
KiBzaG91bGQgcmVtYWluLiAgQWN0dWFsbHksIGl0IGRlcGVuZHMgb24gd2hldGhlciB0aGUgdXNi
DQo+IGhvc3QNCj4gPj4+PiBzZW5kcw0KPiA+Pj4+Pj4+PiAgICAgICogc2V0IGZlYXR1cmUgKGVu
YWJsZSB3YWtldXApIG9yIG5vdC4NCj4gPj4+Pj4+Pj4gICAgICAqLw0KPiA+Pj4+Pj4+PiAgICAg
aWYgKHRlc3RfYml0KEJUVVNCX1dBS0VVUF9ESVNBQkxFLCAmZGF0YS0+ZmxhZ3MpKSB7DQo+ID4+
Pj4+Pj4+ICAgICAgICAgICAgIGlmIChQTVNHX0lTX0FVVE8obWVzc2FnZSkgJiYNCj4gPj4+Pj4+
Pj4gICAgICAgICAgICAgICAgIGRldmljZV9jYW5fd2FrZXVwKCZkYXRhLT51ZGV2LT5kZXYpKQ0K
PiA+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgIGRhdGEtPnVkZXYtPmRvX3JlbW90ZV93YWtl
dXAgPSAxOw0KPiA+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgZWxzZSBpZiAoIVBNU0dfSVNfQVVU
TyhtZXNzYWdlKSkNCj4gPj4+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+dWRl
di0+cmVzZXRfcmVzdW1lID0gMTsNCj4gPj4+Pj4+Pj4gICAgIH0NCj4gPj4+Pj4+Pj4NCj4gPj4+
Pj4+Pj4gICAgIHJldHVybiAwOw0KPiA+Pj4+Pj4+PiAtLQ0KPiA+Pj4+Pj4+PiAyLjE3LjENCj4g
Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVu
dCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQoNCg==
