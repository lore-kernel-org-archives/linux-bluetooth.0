Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250DCC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 05:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCOFyv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCOFys (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 01:54:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9262710
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 22:54:46 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32F5aI3M1013431, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32F5aI3M1013431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 13:36:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Mar 2023 13:36:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Mar 2023 13:36:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 15 Mar 2023 13:36:22 +0800
From:   Hilda Wu <hildawu@realtek.com>
To:     Arnaud Rebillout <arnaudr@kali.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "steev@kali.org" <steev@kali.org>, Max Chou <max.chou@realtek.com>
Subject: RE: RTL8761B BT USB has been broken for a while (mismatched firmware?)
Thread-Topic: RTL8761B BT USB has been broken for a while (mismatched
 firmware?)
Thread-Index: AQHZVhvubalhn2hI80mhao7Iwd4w+67512xg
Date:   Wed, 15 Mar 2023 05:36:22 +0000
Message-ID: <1c2ec3d103444a778ddffabaac22206b@realtek.com>
References: <af4f9118-a189-e353-8cf6-65cabceff3e0@kali.org>
In-Reply-To: <af4f9118-a189-e353-8cf6-65cabceff3e0@kali.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.182]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMTUg5LiK5Y2IIDEyOjM4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQXJuYXVkLA0KDQpCZWZvcmUgdGhlIDlmZDJlMjk0IGNvbW1pdCwgdGhlIGJ0cnRsIGRyaXZl
ciBsb2FkcyBydGxfYnQvcnRsODc2MWJfZncuYmluIGZvciBSVEw4NzYxQiBVU0Igb25seS4NCkFm
dGVyIHRoZSA5ZmQyZTI5NCBjb21taXQsIHRoZSBidHJ0bCBkcml2ZXIgbG9hZHMgcnRsX2J0L3J0
bDg3NjFiX2Z3LmJpbiBmb3IgUlRMODc2MUIgVUFSVCwgYW5kIGxvYWRzIHJ0bF9idC9ydGw4NzYx
YnVfZncuYmluIGZvciBSVEw4NzYxQiBVU0IuDQoNCk1heWJlIHJlbmFtaW5nIHRoZSBVU0IgZncg
dG8gcnRsX2J0L3J0bDg3NjFidV9mdy5iaW4sIHRoZSBVQVJUIGZ3IHRvIHJ0bF9idC9ydGw4NzYx
YnRfZncuYmluIGNhbiBhdm9pZCBjb25mdXNpb24uDQoNClRoZSBjb21taXQgIjlmZDJlMjk0OWI0
MyBCbHVldG9vdGg6IGJ0cnRsOiByZW5hbWUgVVNCIGZ3IGZvciBSVEw4NzYxIiBzaG91bGQgYmUg
d29yayB3aXRoIHRoZSBjb21taXQgIjY0ZjAyYTIgcnRsX2J0OiBBZGQgcnRsODc2MWJ1IGZpcm13
YXJlIG9mIGxpbnV4LWZpcm13YXJlLiIgZm9yIFJUTDg3NjFCIEJsdWV0b290aCBVU0IgY29udHJv
bGxlci4NCg0KQ29uc2lkZXJpbmcgdGhlIEZXIHdhcyBzdWJtaXR0ZWQgdHdvIHllYXJzIGFnbywg
UmVhbHRlayBwbGFucyB0byByZWxlYXNlIGEgbmV3IHZlcnNpb24gdG8gVXBzdHJlYW0uDQpXZSB3
aWxsIHZlcmlmeSB0aGUgYmVoYXZpb3Igb24gTGludXggUEMuIEV4cGVjdCBpdCBjYW4gcmVzb2x2
ZSB0aGUgaXNzdWUuDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpIaWxkYQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogQXJuYXVkIFJlYmlsbG91dCA8YXJuYXVkckBrYWxpLm9yZz4g
DQpTZW50OiBUdWVzZGF5LCBNYXJjaCAxNCwgMjAyMyAxMDoyMyBBTQ0KVG86IGxpbnV4LWJsdWV0
b290aEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBIaWxkYSBXdSA8aGlsZGF3dUByZWFsdGVrLmNvbT47
IHN0ZWV2QGthbGkub3JnDQpTdWJqZWN0OiBSVEw4NzYxQiBCVCBVU0IgaGFzIGJlZW4gYnJva2Vu
IGZvciBhIHdoaWxlIChtaXNtYXRjaGVkIGZpcm13YXJlPykNCg0KDQpFeHRlcm5hbCBtYWlsLg0K
DQoNCg0KSGVsbG8sDQoNCmxldCBtZSBmb3J3YXJkIGFuIGlzc3VlIHRoYXQgd2FzIHJlcG9ydGVk
IG9uIHRoZSBLYWxpIExpbnV4IGJ1Z3RyYWNrZXIgYSBzaG9ydCB3aGlsZSBhZ28uIEl0J3MgYWJv
dXQgYSBVU0IgYmx1ZXRvb3RoIDUuMCBkb25nbGUgd2hpY2ggdXNlcyBSZWFsdGVrIFJUTDg3NjFC
IGNoaXAuIFdoZW4gdGhlIGRvbmdsZSBpcyBwbHVnZ2VkIGluLCBldmVyeXRoaW5nIGxvb2tzIGdv
b2QgaW4gdGhlIGtlcm5lbCBsb2dzLCBob3dldmVyIHRoZSBkb25nbGUgaXMgbm90IGZ1bmN0aW9u
YWwgYXQgYWxsLg0KDQpTZXZlcmFsIHVzZXJzIHJlcG9ydGVkIHRoZSBpc3N1ZSBvbiB2YXJpb3Vz
IGJ1ZyB0cmFja2VyczoNCi0gMjAyMS0wOTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMTQyODcNCi0gMjAyMi0wNDoNCmh0dHBzOi8vYnVncy5sYXVuY2hwYWQu
bmV0L3VidW50dS8rc291cmNlL2xpbnV4LWZpcm13YXJlLytidWcvMTk2ODYwNA0KLSAyMDIzLTAz
OiBodHRwczovL2J1Z3Mua2FsaS5vcmcvdmlldy5waHA/aWQ9ODIxNg0KDQpBbGwgb2YgdGhlbSBj
b25maXJtIHRoYXQgdGhlIHdyb25nIGZpcm13YXJlIGlzIGxvYWRlZC4gTGV0IG1lIGV4cGxhaW4u
DQoNClNvIHRoZXJlIGFyZSB0d28gZmlybXdhcmUgZm9yIHRoaXMgY2hpcDogcnRsODc2MWIgYW5k
IHJ0bDg3NjFidS4gVGhleSB3ZXJlIGFkZGVkIHRvIGxpbnV4LWZpcm13YXJlIGJhY2sgaW4gMjAy
MS0wNi0wOSwgYXMgY2FuIGJlIHNlZW4gd2l0aDoNCg0KICAgY2QgbGludXgtZmlybXdhcmUNCiAg
IGdpdGsgLS0gJ3J0bF9idC9ydGw4NzYxYionICYNCg0KSG93ZXZlciBhdCB0aGUgdGltZSwgb25s
eSB0aGUgZmlybXdhcmUgcnRsODc2MWIgd2FzIGluIHVzZS4gQnV0IGl0IHdvcmtlZC4NClRoZW4g
b24gMjAyMS0wNi0yNiwgYSBjaGFuZ2UgbWFkZSBpdCBzbyB0aGF0IHRoZSBmaXJtd2FyZSBydGw4
NzYxYiBpcyB1c2VkIG9ubHkgZm9yIFVBUlQsIGFuZCBydGw4NzYxYnUgaXMgdXNlZCBmb3IgVVNC
LiBDZjoNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9OWZkMmUyOTQNCg0KQW5kIHNpbmNlIHRoZW4s
IHdlIGhhdmUgdGhlIGJ1ZyByZXBvcnRzIGFib3ZlLiBVc2VycyBhbGwgYWdyZWUgdGhhdCBpdCBk
b2Vzbid0IHdvcmssIGJ1dCB0aGVyZSBpcyBhIHdvcmthcm91bmQ6IGlmIHRoZXkgdXNlIHRoZSBm
aXJtd2FyZSBydGw4NzYxYiAoaW5zdGVhZCBvZiBydGw4NzYxYnUpLCBpdCB3b3Jrcy4NCg0KU28g
SSB3b25kZXIgaWYgdGhlIHR3byBmaXJtd2FyZSBhcmUganVzdCByZXZlcnNlZC4gQWZ0ZXIgYWxs
LCB0aGUgc3VmZml4ICd1Jw0Kd2FzIG1heWJlIG1lYW50IGZvciAnVUFSVCcgYW5kIG5vdCAnVVNC
JywgdGhlcmUncyByb29tIGZvciBjb25mdXNpb24uDQoNCkknbSBDQy1pbmcgSGlsZGEgV3UgYXMg
dGhleSBhcmUgdGhlIGxhc3QgcGVyc29uIHdobyB1cGRhdGVkIHRob3NlIGZpcm13YXJlLCBhbmQg
Z2l2ZW4gdGhlaXIgZW1haWwgYWRkcmVzcyAoJ0ByZWFsdGVrLmNvbScpLCB0aGV5IHByb2JhYmx5
IGFyZSBpbiBhIGdvb2QgcG9zaXRpb24gdG8gZ2l2ZSBpdCBhIHF1aWNrIGNoZWNrLg0KDQpGb3Ig
Y29tcGxldGVuZXNzLCBoZXJlIGFyZSB0aGUga2VybmVsIGxvZ3MgdGhhdCBzaG93IHVwIHdoZW4g
dGhlIGRvbmdsZSBpcyBwbHVnZ2VkIGluICh0YWtlbiBmcm9tIHRoZSBLYWxpIExpbnV4IGJ1ZyBy
ZXBvcnQpOg0KDQogICBbODE0MzUuMDE3NjUzXSB1c2IgMi01OiBuZXcgZnVsbC1zcGVlZCBVU0Ig
ZGV2aWNlIG51bWJlciAxNCB1c2luZyBvaGNpLXBjaQ0KICAgWzgxNDM1LjI1NzI0Nl0gdXNiIDIt
NTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD04NzcxLCBi
Y2REZXZpY2U9IDIuMDANCiAgIFs4MTQzNS4yNTcyNjRdIHVzYiAyLTU6IE5ldyBVU0IgZGV2aWNl
IHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsDQpTZXJpYWxOdW1iZXI9Mw0KICAgWzgxNDM1LjI1
NzI3Ml0gdXNiIDItNTogUHJvZHVjdDogQmx1ZXRvb3RoIFJhZGlvDQogICBbODE0MzUuMjU3Mjc4
XSB1c2IgMi01OiBNYW51ZmFjdHVyZXI6IFJlYWx0ZWsNCiAgIFs4MTQzNS4yNTcyODNdIHVzYiAy
LTU6IFNlcmlhbE51bWJlcjogMDBFMDRDMjM5OTg3DQogICBbODE0MzUuMjY3MjYzXSBCbHVldG9v
dGg6IGhjaTA6IFJUTDogZXhhbWluaW5nIGhjaV92ZXI9MGEgaGNpX3Jldj0wMDBiIGxtcF92ZXI9
MGEgbG1wX3N1YnZlcj04NzYxDQogICBbODE0MzUuMjcwMjQxXSBCbHVldG9vdGg6IGhjaTA6IFJU
TDogcm9tX3ZlcnNpb24gc3RhdHVzPTAgdmVyc2lvbj0xDQogICBbODE0MzUuMjcwMjUzXSBCbHVl
dG9vdGg6IGhjaTA6IFJUTDogbG9hZGluZyBydGxfYnQvcnRsODc2MWJ1X2Z3LmJpbg0KICAgWzgx
NDM1LjI3MDM5MV0gYmx1ZXRvb3RoIGhjaTA6IGZpcm13YXJlOiBkaXJlY3QtbG9hZGluZyBmaXJt
d2FyZSBydGxfYnQvcnRsODc2MWJ1X2Z3LmJpbg0KICAgWzgxNDM1LjI3MDQ1OV0gQmx1ZXRvb3Ro
OiBoY2kwOiBSVEw6IGxvYWRpbmcgcnRsX2J0L3J0bDg3NjFidV9jb25maWcuYmluDQogICBbODE0
MzUuMjcwNTA5XSBibHVldG9vdGggaGNpMDogZmlybXdhcmU6IGRpcmVjdC1sb2FkaW5nIGZpcm13
YXJlIHJ0bF9idC9ydGw4NzYxYnVfY29uZmlnLmJpbg0KICAgWzgxNDM1LjI3MDU2N10gQmx1ZXRv
b3RoOiBoY2kwOiBSVEw6IGNmZ19zeiAyNSwgdG90YWwgc3ogMjk5NDkNCiAgIFs4MTQzNS42NTYy
OTVdIEJsdWV0b290aDogaGNpMDogUlRMOiBmdyB2ZXJzaW9uIDB4MGNhOThhNmINCiAgIFs4MTQz
NS43OTU3MTNdIEJsdWV0b290aDogTUdNVCB2ZXIgMS4yMg0KDQpUaGFua3MgZm9yIHlvdXIgYXR0
ZW50aW9uLCBwbGVhc2UgQ0MgbWUgYXMgSSdtIG5vdCBzdWJzY3JpYmVkIHRvIHRoaXMgbGlzdC4N
Cg0KDQotLQ0KQXJuYXVkIFJlYmlsbG91dCAvIE9mZmVuc2l2ZSBTZWN1cml0eSAvIEthbGkgTGlu
dXggRGV2ZWxvcGVyDQoNCi0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVm
b3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
