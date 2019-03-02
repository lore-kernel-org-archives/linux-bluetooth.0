Return-Path: <SRS0=Oh6E=RF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7333C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0F20880
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCBJbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:31:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37614 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCBJbT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Mar 2019 04:31:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x229Sm6s011571, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (RSFS1.realsil.com.cn[172.29.17.2](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x229Sm6s011571
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 2 Mar 2019 17:28:49 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS01.realsil.com.cn
 ([::1]) with mapi id 14.03.0415.000; Sat, 2 Mar 2019 17:28:48 +0800
From:   =?gb2312?B?wr3W7M6w?= <alex_lu@realsil.com.cn>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>
CC:     "beagleboard@davidjohnsummers.uk" <beagleboard@davidjohnsummers.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "wens@csie.org" <wens@csie.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDMvOF0gZHQtYmluZGluZ3M6IG5ldDogYmx1ZXRvb3Ro?= =?gb2312?Q?:_Add_rtl8723bs-bluetooth?=
Thread-Topic: [PATCH 3/8] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
Thread-Index: AQHU0GuIclVduIKGj0ir7LldTFw7OaX4EjYv
Date:   Sat, 2 Mar 2019 09:28:46 +0000
Message-ID: <0551C926975A174EA8972327741C7889EE6B1008@RS-MBS01.realsil.com.cn>
References: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>,<20190301201519.21953-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190301201519.21953-1-martin.blumenstingl@googlemail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [42.120.74.114]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFydGluLApUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uClRoZSBjb25maWcgaXMgcmVs
YXRlZCB0byBlRnVzZSBpbiBjaGlwcy4gSSdtIHNvcnJ5IHRoYXQgdGhlIGRldGFpbHMgY2FuJ3Qg
YmUgb3Blbi4KT25seSBzb21lIHNwZWNpYWwgY29uZmlndXJhdGlvbnMgYXJlIHJlbGF0ZWQgdG8g
dGhlIGhvc3QgcGxhdGZvcm1zLCBzdWNoIGFzIFVBUlQgd29ya2luZyBiYXVkcmF0ZSwgaGFyZHdh
cmUgZmxvdyBjb250cm9sLCBQQ00gc2V0dGluZ3MsIGV0Yy4gVGhlc2UgYXJlIHRoZSBzZXR0aW5n
cyBmb3IgSENJIFVBUlQgYW5kIFBDTSBJbnRlcmZhY2UuCk1vc3Qgb2YgY29uZmlndXJhdGlvbnMg
YXJlIG9ubHkgcmVsZXZhbnQgdG8gY2hpcHMuCgpUaGFua3MsCkJScywKQWxleCBMdS4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwq3orz+yMs6IE1hcnRpbiBCbHVtZW5z
dGluZ2wgW21hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb21dCreiy83KsbzkOiAyMDE5
xOoz1MIyyNUgNDoxNQrK1bz+yMs6IGFuYXJzb3VsQGdtYWlsLmNvbTsgwr3W7M6wCrOty806IGJl
YWdsZWJvYXJkQGRhdmlkam9obnN1bW1lcnMudWs7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBqb2hhbi5oZWRiZXJnQGdtYWlsLmNvbTsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwu
b3JnOyBtYXJjZWxAaG9sdG1hbm4ub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbWF4aW1lLnJp
cGFyZEBib290bGluLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3Jn
OyBzdGVmYW4ud2FocmVuQGkyc2UuY29tOyB3ZW5zQGNzaWUub3JnOyBNYXJ0aW4gQmx1bWVuc3Rp
bmdsCtb3zOI6IFJlOiBbUEFUQ0ggMy84XSBkdC1iaW5kaW5nczogbmV0OiBibHVldG9vdGg6IEFk
ZCBydGw4NzIzYnMtYmx1ZXRvb3RoCgpIaSBWYXNpbHksIEhpIEFsZXgsCgpPbiAyMi8wMi8yMDE5
IDExOjIxLCBWYXNpbHkgS2hvcnV6aGljayB3cm90ZToKPiBJIGFncmVlIHdpdGggUm9iIHRoYXQg
d2Ugc2hvdWxkIHByb2JhYmx5IHVzZSBmaXJtd2FyZS1uYW1lIGhlcmUgaW5zdGVhZC4KSGF2ZSB5
b3UgY29uc2lkZXJlZCBza2lwcGluZyB0aGlzIHByb3BlcnR5IGZvciB2MSBvZiB0aGlzIHNlcmll
cz8KV2UgY2FuIHN0aWxsIGFkZCB0aGF0IHByb3BlcnR5IChhcyBvcHRpb25hbCBvbmUpIGxhdGVy
IG9uIGlmIHdlIHJlYWxseQpzZWUgdGhlIG5lZWQgZm9yIGl0LiAoVGhlIGJ0cnRsIGNvZGUgc2hv
dWxkIGFscmVhZHkgc3VwcG9ydCB0aGUgY2FzZQp3aGVyZSBOVUxMIGlzIHBhc3NlZCBhcyAicG9z
dGZpeCIpCgpJIGNoZWNrZWQgdGhlIHB1YmxpYyBydGw4NzIzYnNfYnQgWzBdIGFuZCBydGw4NzIz
ZHNfYnQgWzFdIGdpdCByZXBvcyBhbmQKdGhleSBlYWNoIGNvbnRhaW4gb25seSBvbmUgY29uZmln
IGJsb2IuIFRoZSBibG9iIGZyb20gdGhlIHJ0bDg3MjNic19idApyZXBvIHdvcmtlZCBvbiBteSB0
d28gQW1sb2dpYyBib2FyZHMgKGRhdGEgb25seSwgc291bmQgaW5wdXQvb3V0cHV0IG5vdAp0ZXN0
ZWQpLCBldmVuIHRob3VnaCBBbWxvZ2ljIHNlZW1zIHRvIHNoaXAgZGlmZmVyZW50IGJsb2JzOiBb
Ml0KCj4+IElzIHRoZXJlIGEgbmVlZCB0byBoYXZlIHRoZSBib2FyZCBuYW1lPwo+Cj4gQXMgZmFy
IGFzIEkgdW5kZXJzdGFuZCBmaXJtd2FyZSBjb25maWcgZGVwZW5kcyBvbiBib2FyZCwgc28gSSB0
aGluawo+IGl0J3MgYSBnb29kIGlkZWEgdG8gdXNlIGJvYXJkIG5hbWUgaGVyZS4KSSBhbHNvIGFk
ZGVkIEFsZXggTHUgZnJvbSBSZWFsdGVrIC8gUmVhbHNpbCB0byB0aGlzIGVtYWlsLgpBbGV4LCBJ
IGhvcGUgdGhhdCB5b3UgY2FuIGhlbHAgdXMgd2l0aCB0aGUgIkJsdWV0b290aCBjb25maWciIGZv
cm1hdCBmb3IKdGhlIFJlYWx0ZWsgV2lGaSBhbmQgQmx1ZXRvb3RoIGNvbWJvIGNoaXBzIC0gbWFp
bmx5IHRoZSBvbmVzIHdoaWNoCmNvbm5lY3QgdG8gdGhlIGhvc3QgdXNpbmcgU0RJTy4KClRoaXMg
aXMgaW1wb3J0YW50IGZvciB1cyBiZWNhdXNlIHRoZSBxdWVzdGlvbiBjYW1lIHVwIHdoZXRoZXIg
d2UgY2FuCmRlc2NyaWJlIGV2ZXJ5dGhpbmcgdGhhdCdzIHBhcnQgb2YgdGhlICJjb25maWcgYmxv
YiIgYXMgZGV2aWNlLXRyZWUKcHJvcGVydGllcy4gSWYgd2Uga25ldyB0aGUgZm9ybWF0IHdlIGNv
dWxkIGdlbmVyYXRlIHRoZSAiY29uZmlnIGJsb2IiCm9uLXRoZS1mbHkgKGVpdGhlciBieSBmdWxs
eSBnZW5lcmF0aW5nIGl0LCB0YWtpbmcgYSBibG9iIC0gbWF5YmUgd2l0aApvbmx5IHRoZSBzbWFs
bGVzdCBzZXQgb2YgY29uZmlnIGRhdGEgLSBhcyAidGVtcGxhdGUiIGFuZCB1cGRhdGUgdmFsdWVz
Cm9uLXRoZS1mbHksIGV0Yy4pCgpNYXJjZWwgd3JvdGUgYSB0b29sIFszXSB3aGljaCBoYW5kbGVz
IHRoZSBiYXNpYyBjb25maWcgZm9ybWF0LiBIb3dldmVyLAp3ZSdyZSBzdGlsbCBtaXNzaW5nIGEg
bG90IG9mIGRldGFpbHMgKG9ubHkgMyBvZmZzZXRzIGFyZSBrbm93biwKIlVBUlRfQ09ORklHIiBj
b250YWlucyAxNiBieXRlcyBidXQgd2Ugb25seSBrbm93IHRoZSBwdXJwb3NlIG9mIDQgb2YKdGhl
c2UsIC4uLikuCkkgd291bGQgaGlnaGx5IGFwcHJlY2lhdGUgaWYgeW91IGdpdmUgdXMgZW5vdWdo
IGRldGFpbHMgc28gd2UgY2FuIGV4dGVuZApNYXJjZWwncyB0b29sIHRvIGRpc3BsYXkgdGhlIGh1
bWFuLXJlYWRhYmxlIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBjb25maWcKYmxvYnMgZnJvbSBydGw4
NzIzYnNfYnQgWzBdIGFuZCBydGw4NzIzZHNfYnQgWzFdLgoKVmFzaWx5LCB0aGFuayB5b3UgZm9y
IHlvdXIgZWZmb3J0IG9uIHRoaXMgdG9waWMgc28gZmFyIQpJZiB5b3Uga2VlcCBtZSBDQydlZCBv
biB2MiBvZiB5b3VyIHNlcmllcyB0aGVuIEkgY2FuIHRlc3QgaXQgb24gdHdvIG9mCm15IEFtbG9n
aWMgYm9hcmRzICh3aGljaCBjb21lIHdpdGggYSBSVEw4NzIzQlMpLgoKClswXSBodHRwczovL2dp
dGh1Yi5jb20vbHdmaW5nZXIvcnRsODcyM2JzX2J0L3RyZWUvMDllYjkxZjUyYTYzOWVjNWU0YzVj
NGM5OGRjMmFmZWRlMDQ2Y2YyMApbMV0gaHR0cHM6Ly9naXRodWIuY29tL2F5dWZhbi1waW5lNjQv
cnRsODcyM2RzX2J0L3RyZWUvZmFiMjFiNTIyNTBkNjc4NTdiNjk0Zjk2MWUxZmY4NjE4ZTY3OGQ4
OS84NzIzRApbMl0gaHR0cHM6Ly9naXRodWIuY29tL2toYWRhcy9hbmRyb2lkX2hhcmR3YXJlX3Jl
YWx0ZWsvdHJlZS9iZDNiMTEzMjY2YzM1M2FhZmNiZjUyOGEwMzM0ZDI4MDkwZmYyNDliL3J0a2J0
L3N5c3RlbS9ldGMvZmlybXdhcmUKWzNdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9i
bHVldG9vdGgvYmx1ZXouZ2l0L3RyZWUvdG9vbHMvcnRsZncuYz9pZD0yNjE5NDgwOTBlOTA3MzUx
NGFjNGI1ZjY0Yzg3MTVjZjBhNzFlYWZhCg==
