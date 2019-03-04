Return-Path: <SRS0=2QA5=RH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9862C4360F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 05:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EE621019
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 05:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfCDFTa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:19:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52918 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDFTa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Mar 2019 00:19:30 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x245HkoV011929, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (RSFS1.realsil.com.cn[172.29.17.2](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x245HkoV011929
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 4 Mar 2019 13:17:47 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS01.realsil.com.cn
 ([::1]) with mapi id 14.03.0415.000; Mon, 4 Mar 2019 13:17:46 +0800
From:   =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "anarsoul@gmail.com" <anarsoul@gmail.com>,
        "beagleboard@davidjohnsummers.uk" <beagleboard@davidjohnsummers.uk>,
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMy84XSBkdC1iaW5kaW5nczogbmV0OiBibHVldG9v?= =?utf-8?Q?th:_Add_rtl8723bs-bluetooth?=
Thread-Topic: [PATCH 3/8] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
Thread-Index: AQHU0GuIclVduIKGj0ir7LldTFw7OaX4EjYv///1GgCAAuo4EA==
Date:   Mon, 4 Mar 2019 05:17:45 +0000
Message-ID: <0551C926975A174EA8972327741C7889EE6B1490@RS-MBS01.realsil.com.cn>
References: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>
 <20190301201519.21953-1-martin.blumenstingl@googlemail.com>
 <0551C926975A174EA8972327741C7889EE6B1008@RS-MBS01.realsil.com.cn>
 <CAFBinCDFY+fZs2unV1T5Mhh_VVSUfxK75zZXKdanLKG+arRX5g@mail.gmail.com>
In-Reply-To: <CAFBinCDFY+fZs2unV1T5Mhh_VVSUfxK75zZXKdanLKG+arRX5g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.36.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFydGluLA0KWW91J3JlIHJpZ2h0IGFib3V0IHRoZSBjb25maWcgYmxvYi4NClRoYW5rcyBm
b3IgeW91ciBpbnZpdGF0aW9uIHRvIHRoZSBkaXNjdXNzaW9uLg0KSW4gbXkgb3B0aW9uLCBzcGVj
aWZ5aW5nIHRoZSBwcm9wZXJ0aWVzIG9mIHRoZSBjb25uZWN0aW9uIHRvIHRoZSBjaGlwIHdvdWxk
IGJlIGJldHRlci4NCg0KVGhhbmtzLA0KQlJzLA0KQWxleCBMdS4NCg0KLS0tLS3pgq7ku7bljp/k
u7YtLS0tLQ0K5Y+R5Lu25Lq6OiBNYXJ0aW4gQmx1bWVuc3RpbmdsIFttYWlsdG86bWFydGluLmJs
dW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMTnlubQz5pyIM+aX
pSAwOjQ0DQrmlLbku7bkuro6IOmZhuacseS8nw0K5oqE6YCBOiBhbmFyc291bEBnbWFpbC5jb207
IGJlYWdsZWJvYXJkQGRhdmlkam9obnN1bW1lcnMudWs7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBqb2hhbi5oZWRiZXJnQGdtYWlsLmNvbTsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJu
ZWwub3JnOyBtYXJjZWxAaG9sdG1hbm4ub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbWF4aW1l
LnJpcGFyZEBib290bGluLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgcm9iaEBrZXJuZWwu
b3JnOyBzdGVmYW4ud2FocmVuQGkyc2UuY29tOyB3ZW5zQGNzaWUub3JnDQrkuLvpopg6IFJlOiBb
UEFUQ0ggMy84XSBkdC1iaW5kaW5nczogbmV0OiBibHVldG9vdGg6IEFkZCBydGw4NzIzYnMtYmx1
ZXRvb3RoDQoNCkhpIEFsZXgsDQoNCk9uIFNhdCwgTWFyIDIsIDIwMTkgYXQgMTA6MzAgQU0g6ZmG
5pyx5LyfIDxhbGV4X2x1QHJlYWxzaWwuY29tLmNuPiB3cm90ZToNCj4NCj4gSGkgTWFydGluLA0K
PiBUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uDQp0aGFuayB5b3UgZm9yIHRoZSBxdWljayBy
ZXBseSENCg0KPiBUaGUgY29uZmlnIGlzIHJlbGF0ZWQgdG8gZUZ1c2UgaW4gY2hpcHMuIEknbSBz
b3JyeSB0aGF0IHRoZSBkZXRhaWxzIGNhbid0IGJlIG9wZW4uDQo+IE9ubHkgc29tZSBzcGVjaWFs
IGNvbmZpZ3VyYXRpb25zIGFyZSByZWxhdGVkIHRvIHRoZSBob3N0IHBsYXRmb3Jtcywgc3VjaCBh
cyBVQVJUIHdvcmtpbmcgYmF1ZHJhdGUsIGhhcmR3YXJlIGZsb3cgY29udHJvbCwgUENNIHNldHRp
bmdzLCBldGMuIFRoZXNlIGFyZSB0aGUgc2V0dGluZ3MgZm9yIEhDSSBVQVJUIGFuZCBQQ00gSW50
ZXJmYWNlLg0KPiBNb3N0IG9mIGNvbmZpZ3VyYXRpb25zIGFyZSBvbmx5IHJlbGV2YW50IHRvIGNo
aXBzLg0KcGxlYXNlIGxldCBtZSByZXBlYXQgdGhpcyB3aXRoIG15IG93biB3b3JkcyB0byBzZWUg
aWYgSSB1bmRlcnN0YW5kIHRoZQ0KImNvbmZpZyBibG9iIiBjb3JyZWN0bHkuIEZlZWwgZnJlZSB0
byBjb3JyZWN0IG1lIGlmIGFueXRoaW5nIGlzIHdyb25nOg0KLSB0aGUgZGF0YSBpbiB0aGUgY29u
ZmlnIGJsb2IgInBhdGNoZXMiIGVGdXNlIHZhbHVlcyBhdCBydW50aW1lIChub24tcGVyc2lzdGVu
dCkNCi0gd2Uga25vdyB0aGUgb2Zmc2V0cyBvZiB0aGUgVUFSVF9DT05GSUcsIFBDTV9TRVRUSU5H
IGFuZCBCRF9BRERSIC0NCnRoZXNlIGNhbiBiZSAiYm9hcmQgc3BlY2lmaWMiIChsaWtlIGJhdWQg
cmF0ZSwgZmxvdyBjb250cm9sLCAuLi4pDQotIG1vc3Qgb3RoZXIgdmFsdWVzIGZyb20gdGhlICJj
b25maWcgYmxvYiIgYXJlICJjaGlwIHNwZWNpZmljIiAtDQptZWFuaW5nIHRoZXkgYXJlIGlkZW50
aWNhbCBmb3IgZWFjaCBib2FyZCBhbmQgdGhleSBvbmx5IGRlcGVuZCBvbiB0aGUNCmNoaXANCg0K
ZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGhvdyB3ZSBjYW4gc3VwcG9ydCBtdWx0aXBsZSBi
b2FyZHMgKHRoZQ0KbWFpbiBnb2FsIG9mIHRoaXMgd2hvbGUgZGlzY3Vzc2lvbiBpczogaG93IHRv
IGRvIHRoaXMgImNvcnJlY3QiKT8NCnNvIGZhciBkaWZmZXJlbnQgYXBwcm9hY2hlcyB3ZXJlIGRp
c2N1c3NlZCAobm90IG9ubHkgaW4gdGhpcyB0aHJlYWQsDQpidXQgYWxzbyBpbiB0aGUgcGFzdCk6
DQotIHVzZSBhIHNlcGFyYXRlIGNvbmZpZyBibG9iIGZvciBlYWNoIGJvYXJkLiB0aGlzIG1lYW5z
IHRoYXQgd2hlbmV2ZXINCmEgbmV3IGJvYXJkIGlzIHN1cHBvcnRlZCAoZm9yIGV4YW1wbGUgYnkg
YWRkaW5nIGEgLmR0cyBmb3IgaXQgdG8gdGhlDQptYWlubGluZSBrZXJuZWwpIHRoZW4gQmx1ZXRv
b3RoIHdvbid0IHdvcmsgb3V0LW9mLXRoZS1ib3ggdW5sZXNzIGENCmNvbmZpZyBpcyBwcm92aWRl
ZC4NCi0gc3BlY2lmeSB0aGUgcHJvcGVydGllcyBvZiB0aGUgY29ubmVjdGlvbiB0byB0aGUgY2hp
cCAoZm9yIGV4YW1wbGUgYnkNCmFkZGluZyBhIGRldmljZS10cmVlIHByb3BlcnR5IGZvciB0aGUg
c3BlZWQsIGZsb3cgY29udHJvbCwgLi4uKSBhbmQNCmdlbmVyYXRlIHRoZSBjb25maWcgYmFzZWQg
b24gdGhlIGRldmljZS10cmVlIHByb3BlcnRpZXMuDQotIChJIGFtIG9wZW4gZm9yIG90aGVyIHN1
Z2dlc3Rpb25zLCBwbGVhc2UgbGV0IHVzIGtub3cgaWYgeW91IGhhdmUgYW55KQ0KDQpJIHdvdWxk
IGxpa2UgdG8gaGVhciB5b3VyIG9waW5pb24gb24gdGhpcyB0b3BpYyBhbmQgZXNwZWNpYWxseSB0
aGUNCnJlYXNvbnMgYmVoaW5kIHlvdXIgc3VnZ2VzdGlvbnMuDQoNCg0KQmVzdCByZWdhcmRzDQpN
YXJ0aW4NCg0KLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJp
bnRpbmcgdGhpcyBlLW1haWwuDQo=
