Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B80C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1481420702
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 08:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgA2Ixo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:53:44 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2Ixo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 03:53:44 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjjSt-1jPlbZ2TcJ-00lFmh; Wed, 29 Jan 2020 09:53:42 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Wed, 29
 Jan 2020 09:53:36 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Wed, 29 Jan 2020 09:53:36 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetooth: If unknown option in L2CAP Configuration Request is a
 hint, Bluetooth stack responds with "Command Reject" instead of
 "Configuration Response"
Thread-Topic: bluetooth: If unknown option in L2CAP Configuration Request is a
 hint, Bluetooth stack responds with "Command Reject" instead of
 "Configuration Response"
Thread-Index: AQHV1d6ryqOWvNk7skOPLPyaAiH6AagA85sAgABTEwA=
Date:   Wed, 29 Jan 2020 08:53:36 +0000
Message-ID: <308de3c58372c552ec9e170e3020f05bbe7f4908.camel@peiker-cee.de>
References: <3020b8d0c7d39428aec573153b3c3414213be7ce.camel@peiker-cee.de>
         <89F234DA-089E-4F45-9D32-7A09CC52E8CD@holtmann.org>
In-Reply-To: <89F234DA-089E-4F45-9D32-7A09CC52E8CD@holtmann.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <13A5F1E2208F2D4F8740539A68EABFF4@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:bHlyOsEq4iDRInCpnepIUs29a11vGjZ96CfNpilPx8iOBJUNKZW
 ww+oFQ1aNYtIwiWfA8XUR3zYYvn2NaLlwcgUvi2Bsn6SC+5G7+KaljnYgz/v4AVSKGbKmXa
 Eb/2ruzJr9mN3AtDDyF0Gw9nkpQBi/TGoeEm4UoPEVy1mkTBQOZUouKHlGXmIViVbGtXqIg
 urwHKdHdkOKmzGOSDOhHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oNrO+xC5Kp0=:vi8wY8I8rsHSUPRR5vMLox
 TzXWRuW1uXHhFOHHUyl24hc+RpZQzNwgHLlD0qeB4pcfYO59czJsURkdmqmyFV6qCBcXz4JwV
 vG+9v6I0DjAV1TtW7saHLqbtsaZrhw+Sb/cbXwbztYrUIaERN9cIh65FHeDWe3c+IAiVifElk
 4skpcyE2OIuq1fePcqINW+JNBE23mC2YgckP8A/eKGN4/Am3e9IlmmYU5jowWQJBS4Uyr4gXa
 o9Gs7ISAGWCRWFGqEBWmHr6Pm2BJ0Lkb1j6cmqVKaxnq2ha0aGDekREQ0blRLgaQ8B1rHmSg0
 Ey9BppA0xYUQIkf+yZHTwKs8kpB6JAez14Go9Tu/Nym9fBlZpogUC0g9eJgV0sOVOveIn8UCG
 BVYxSMSdpD3iy0AWSBVhJVhrKjjXFMp7oN9Yi0lk6WoeWCizaCX0kapsHAAUpAixULZBJer5w
 o7qiMzO/ZCCsJXxmZHm+cFz8ZhSc2qkzWWdtvj4a/LTvHJoSx6LNMMSU+lnDawWfYcEHocNFZ
 uaVghyp30NFzGqw1lHlVtOTwoKMBM3Z+Ru742d2G1t7ETJDjfniDRfvJuyjEFnCSN2FhqHpPS
 2cq9MBlnFnkr0nOL866AmR2d0zEJ8Nc9fR77djSuBbxgJizZmmkDEZF1v5qpk63jCfe1+cw8v
 iL5tLvTQizJcYcHP4vo55Syp9Qs/OkYaldPKPHX9Fa0zttas0TSbFRefZlGe9MW0o274U6LyF
 R5qLiDZMdlBF8guEZHl/m6NAuNWUVJxTg/uuOzgqCpNPYSGRlYoTuDk8LadKc9kCg+1MH0kdU
 FaWj/i5SdV0nzrzyXJwduEw4YCKDDHC5RKgnuVpXMXHArpzxc40sSzvWr+48ZopHkOOI98LE0
 YZ0bGil3K3A72bka1xvQ==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpVbmZvcnR1bmF0ZWx5LCBJIGRvbid0IGhhdmUgYSBwb3NzaWJpbGl0eSB0
byB0ZXN0IDUuNSBrZXJuZWwuIEFzIGZhciBhcw0KSSBjYW4gc2VlLCB0aGUgbW9zdCByZWNlbnQg
dmVyc2lvbiBhdmFpbGFibGUgdG8gdGhlIHB1YmxpYyB2aWENCmdpdC5rZXJuZWwub3JnIGlzIDUu
My1yYzMgYW5kIHRoZSBwcm9ibGVtYXRpYyBwYXJ0IGluDQovbmV0L2JsdWV0b290aC9sMmNhcF9j
b3JlLmMgZmlsZSBpcyB0aGUgc2FtZSBmb3IgNC4yMCBhbmQgNS4zLXJjMy4NCkhlbmNlIEkgc3Vw
cG9zZSBpdCB3aWxsIGJlaGF2ZSB0aGUgc2FtZSB3YXkgYXMgNC4yMC4NCg0KQmVzdCByZWdhcmRz
LA0KS29uc3RhbnRpbg0KDQoNCk9uIFdlZCwgMjAyMC0wMS0yOSBhdCAwNDo1NiArMDEwMCwgTWFy
Y2VsIEhvbHRtYW5uIHdyb3RlOg0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gPiBJdCBzZWVtcyB0
aGF0IHRoZXJlJ3MgYSBidWcgaW4gQmx1ZXRvb3RoIHN0YWNrIG9mIDQuMjAga2VybmVsLiBJDQo+
ID4gZGlzY292ZXJlZCBpdCBkdXJpbmcgQmx1ZXRvb3RoIHF1YWxpZmljYXRpb24gdGVzdHMuDQo+
ID4gTDJDQVAvQ09TL0NGRC9CVi0NCj4gPiAxMi1DIFtVbmtub3duIE9wdGlvbiBSZXNwb25zZV0g
dGVzdCBmYWlscyBiZWNhdXNlIGluc3RlYWQgb2YNCj4gPiAiQ29uZmlndXJhdGlvbiBSZXNwb25z
ZSIgd2l0aCBlcnJvciBjb2RlIDB4MDAwMyAidW5rbm93biBvcHRpb24iDQo+ID4gdGhlDQo+ID4g
Qmx1ZXRvb3RoIHN0YWNrIGdlbmVyYXRlcyAiQ29tbWFuZCBSZWplY3QiLg0KPiA+IA0KPiA+IEkg
dGhpbmssIHRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSB0ZXN0ZXIgKEJsdWV0b290aCBTSUcgUFRT
KSB1c2VzDQo+ID4gaGludHMNCj4gPiBhcyB1bmtub3duIG9wdGlvbnMsIGFuZCB0aGUgQmx1ZXRv
b3RoIHN0YWNrIGhhcyBzcGVjaWFsIGhhbmRsaW5nDQo+ID4gZm9yDQo+ID4gaGludHMuIA0KPiA+
IA0KPiA+IEkgbWFkZSBhIHNtYWxsIHBhdGNoIGluIG9yZGVyIHRvIG92ZXJjb21lIHRoaXMgcHJv
YmxlbS4gUGxlYXNlDQo+ID4gY29uZmlybSwNCj4gPiB0aGF0IHRoZSBwYXRjaCBpcyBmZWFzaWJs
ZS4gSWYgbm90LCBwbGVhc2Ugc3VnZ2VzdCBob3cgdG8gZml4IHRoZQ0KPiA+ICJDb21tYW5kIFJl
amVjdCIgcHJvYmxlbS4NCj4gDQo+IGlzIHRoZSBsaW1pdGVkIHRvIDQuMjAga2VybmVsIG9yIGRv
ZXMgaXQgYWxzbyBoYXBwZW4gd2l0aCB0aGUgbGF0ZXN0DQo+IDUuNSBrZXJuZWw/DQo+IA0KPiBS
ZWdhcmRzDQo+IA0KPiBNYXJjZWwNCj4gDQo+IA0KPiANCj4gDQo+IA0KDQo=
