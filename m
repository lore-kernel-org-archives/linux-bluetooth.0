Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EFC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 03:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFD2C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Feb 2023 22:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFD2B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Feb 2023 22:28:01 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC19E072
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 19:27:58 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3163Rk7P2030972, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3163Rk7P2030972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 6 Feb 2023 11:27:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Feb 2023 11:27:53 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Feb 2023 11:27:53 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::ccec:1f8b:2772:9f2]) by
 RTEXMBS03.realtek.com.tw ([fe80::ccec:1f8b:2772:9f2%2]) with mapi id
 15.01.2375.007; Mon, 6 Feb 2023 11:27:53 +0800
From:   Max Chou <max.chou@realtek.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [v2] Bluetooth: btrtl: Firmware format v2 support
Thread-Topic: [v2] Bluetooth: btrtl: Firmware format v2 support
Thread-Index: AQHZNwPE7DyLa1ZUoUuwKk9CmOXStK67sCWAgAWVCaA=
Date:   Mon, 6 Feb 2023 03:27:53 +0000
Message-ID: <12b2ad481f6a4e9ba44fd0619a7b5657@realtek.com>
References: <20230202114614.53907-1-max.chou@realtek.com>
 <63dbaf9b.c80a0220.30d2e.7d9c@mx.google.com>
 <CABBYNZLf6NhA9TGASAh0NH0LMU0DSPGb-UCSU0oBdN3N6=k7LA@mail.gmail.com>
In-Reply-To: <CABBYNZLf6NhA9TGASAh0NH0LMU0DSPGb-UCSU0oBdN3N6=k7LA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.197]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjQg5LiK5Y2IIDA2OjE0OjAw?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkhIEx1aXosDQpUaGFua3MgZm9yIHlvdXIgaW5mbyB0aGF0IHRoZSBuZXcgQVBJIHRvIGltcGxl
bWVudCBmaXJtd2FyZSB1cGxvYWRlZC4NCldlIHdpbGwgc3R1ZHkgaXQgYW5kIHRyeSB0byBpbXBs
ZW1lbnQgaXQgaW4gdGhlIGZ1dHVyZS4NCkluIHRoaXMgcGF0Y2gsIGl0J3MgaW1wbGVtZW50ZWQg
Zm9yIHRoZSBmaXJtd2FyZSBkYXRhIHBhcnNpbmcgZHVlIHRvIFJlYWx0ZWsgZmlybXdhcmUgZm9y
bWF0IGNoYW5nZWQgYXMgVjIuDQpDb3VsZCB5b3UgaGF2ZSB0aGUgYWR2aWNlIHdoaWNoIGNhbiBz
dXBwb3J0cyB0aGlzIHBhdGNoIGJlIGFwcHJvdmVkPyBUaGFua3MuDQoNCg0KQlJzLA0KTWF4DQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXogQXVndXN0byB2b24gRGVu
dHogPGx1aXouZGVudHpAZ21haWwuY29tPiANClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMywgMjAy
MyA2OjAzIEFNDQpUbzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KQ2M6IE1heCBD
aG91IDxtYXguY2hvdUByZWFsdGVrLmNvbT4NClN1YmplY3Q6IFJlOiBbdjJdIEJsdWV0b290aDog
YnRydGw6IEZpcm13YXJlIGZvcm1hdCB2MiBzdXBwb3J0DQoNCkhpIE1heCwNCg0KT24gVGh1LCBG
ZWIgMiwgMjAyMyBhdCA0OjQ0IEFNIDxibHVlei50ZXN0LmJvdEBnbWFpbC5jb20+IHdyb3RlOg0K
Pg0KPiBUaGlzIGlzIGF1dG9tYXRlZCBlbWFpbCBhbmQgcGxlYXNlIGRvIG5vdCByZXBseSB0byB0
aGlzIGVtYWlsIQ0KPg0KPiBEZWFyIHN1Ym1pdHRlciwNCj4NCj4gVGhhbmsgeW91IGZvciBzdWJt
aXR0aW5nIHRoZSBwYXRjaGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0Lg0K
PiBUaGlzIGlzIGEgQ0kgdGVzdCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6DQo+IFBX
IA0KPiBMaW5rOmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9ibHVldG9vdGgv
bGlzdC8/c2VyaWVzPTcxODExDQo+IDcNCj4NCj4gLS0tVGVzdCByZXN1bHQtLS0NCj4NCj4gVGVz
dCBTdW1tYXJ5Og0KPiBDaGVja1BhdGNoICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMS40
NyBzZWNvbmRzDQo+IEdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjU5
IHNlY29uZHMNCj4gU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDAuMTIg
c2Vjb25kcw0KPiBCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzIuNDEg
c2Vjb25kcw0KPiBDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMzQuNDIg
c2Vjb25kcw0KPiBDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzkuMjgg
c2Vjb25kcw0KPiBDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTA3LjAw
IHNlY29uZHMNCj4gQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMwLjUx
IHNlY29uZHMNCj4gVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQzOC45
MyBzZWNvbmRzDQo+IFRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAxNi42
OCBzZWNvbmRzDQo+IFRlc3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAxNy41
MSBzZWNvbmRzDQo+IFRlc3RSdW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA1Ljgz
IHNlY29uZHMNCj4gVGVzdFJ1bm5lcl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDExMy4x
NCBzZWNvbmRzDQo+IFRlc3RSdW5uZXJfcmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA5LjI0
IHNlY29uZHMNCj4gVGVzdFJ1bm5lcl9zY28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDguNDUg
c2Vjb25kcw0KPiBUZXN0UnVubmVyX2lvY3RsLXRlc3RlciAgICAgICBQQVNTICAgICAgOS45MCBz
ZWNvbmRzDQo+IFRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA3LjM0IHNl
Y29uZHMNCj4gVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDguMzAgc2Vj
b25kcw0KPiBUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAgICBQQVNTICAgICAgNi4xMSBzZWNv
bmRzDQo+IEluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1MgICAgICAyOC41MCBzZWNv
bmRzDQo+DQo+IERldGFpbHMNCj4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+IFRl
c3Q6IEdpdExpbnQgLSBGQUlMDQo+IERlc2M6IFJ1biBnaXRsaW50DQo+IE91dHB1dDoNCj4gW3Yy
XSBCbHVldG9vdGg6IGJ0cnRsOiBGaXJtd2FyZSBmb3JtYXQgdjIgc3VwcG9ydA0KPg0KPiBXQVJO
SU5HOiBJMyAtIGlnbm9yZS1ib2R5LWxpbmVzOiBnaXRsaW50IHdpbGwgYmUgc3dpdGNoaW5nIGZy
b20gdXNpbmcgDQo+IFB5dGhvbiByZWdleCAnbWF0Y2gnIChtYXRjaCBiZWdpbm5pbmcpIHRvICdz
ZWFyY2gnIChtYXRjaCBhbnl3aGVyZSkgDQo+IHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3Vy
IGlnbm9yZS1ib2R5LWxpbmVzLnJlZ2V4IG9wdGlvbiANCj4gYWNjb3JkaW5nbHkuIFRvIHJlbW92
ZSB0aGlzIHdhcm5pbmcsIHNldCANCj4gZ2VuZXJhbC5yZWdleC1zdHlsZS1zZWFyY2g9VHJ1ZS4g
TW9yZSBkZXRhaWxzOiANCj4gaHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxpbnQv
Y29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2Vhcg0KPiBjaA0KPiAyNDogQjEgTGluZSBleGNl
ZWRzIG1heCBsZW5ndGggKDgzPjgwKTogIj4gSSByYXRoZXIgdXNlIGFuIHNrYiBmb3IgcGFyc2lu
ZyB0aGUgZGF0YSBpbnN0ZWFkIG9mIHBhcnNpbmcgdmlhIHBvaW50ZXIgZGlyZWN0bHksIg0KPiAj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCj4gVGVzdDogQ2hlY2tTcGFyc2UgLSBXQVJO
SU5HDQo+IERlc2M6IFJ1biBzcGFyc2UgdG9vbCB3aXRoIGxpbnV4IGtlcm5lbA0KPiBPdXRwdXQ6
DQo+IGRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmM6ODgyOjIyOiB3YXJuaW5nOiBjYXN0IHRvIHJl
c3RyaWN0ZWQgDQo+IF9fbGUxNmRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmM6ODg4OjI3OiB3YXJu
aW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQgDQo+IF9fbGUxNmRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRs
LmM6IG5vdGU6IGluIGluY2x1ZGVkIA0KPiBmaWxlOmRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmg6
NDc6NDU6IHdhcm5pbmc6IGFycmF5IG9mIGZsZXhpYmxlIA0KPiBzdHJ1Y3R1cmVzICMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KPiBUZXN0OiBDaGVja1NtYXRjaCAtIFdBUk5JTkcNCj4g
RGVzYzogUnVuIHNtYXRjaCB0b29sIHdpdGggc291cmNlDQo+IE91dHB1dDoNCj4gZHJpdmVycy9i
bHVldG9vdGgvYnRydGwuYzogbm90ZTogaW4gaW5jbHVkZWQgDQo+IGZpbGU6ZHJpdmVycy9ibHVl
dG9vdGgvYnRydGwuaDo0Nzo0NTogd2FybmluZzogYXJyYXkgb2YgZmxleGlibGUgDQo+IHN0cnVj
dHVyZXMNCj4NCj4NCj4gLS0tDQo+IFJlZ2FyZHMsDQo+IExpbnV4IEJsdWV0b290aA0KDQpJZCBn
aXZlIGEgbG9vayBhdDoNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvYmx1ZXRvb3RoL2JsdWV0b290aC1uZXh0LmdpdC90cmVlL0RvY3VtZW50YXRpb24v
ZHJpdmVyLWFwaS9maXJtd2FyZS9md191cGxvYWQucnN0DQoNClRoZXJlIGFyZSBub3Qgc28gbWFu
eSBkcml2ZXJzIHNpbmNlIGl0IHdhcyBpbnRyb2R1Y2VkIGxhc3QgeWVhciBidXQgZnJvbSB0aGUg
bG9va3Mgb2YgaXQgaXQgaGFzIGEgbmljZSBhYnN0cmFjdGlvbiBmb3IgaGFuZGxpbmcgZmlybXdh
cmUgdXBsb2Fkcy4NCg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQotLS0tLS1QbGVh
c2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4N
Cg==
