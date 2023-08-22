Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE1EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjHVO3a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjHVO31 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:29:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2096.outbound.protection.outlook.com [40.92.64.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE86DD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOgEzEEjLH4Kkgoj/j7JyPVx3aPabK3KvM7N/ChhwRQAQTYFdR/V4MS/jhMmkJM+WNzx7yuLo40OGXTLhrVeLJIv+yo3BW/x5j2cfqAEoHZzWAatzTTJY1TMOCUeiekGvgNp16csiOe+p7JAOKV3cFhGgQpXzB9TqKBPwTuo+xbRKVgMbG4VSqG3sKYXaKxMiFRmzFONO4bs8Yl0maOxl6KVn43Qi4mBi9xUY8QwrsDllDQt6frt6QJWBgchhBIUZTgHTOLCyPT6TPdsVEzgT/l4s1VrsMsFiofSAIUvWTwPKGNakRirVXmoCRqyx0hHJn3mJezJdNur4sF3upgu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR3kuuoxZocsoFlYX01SVAoPk+IfmEpAsE2vxmtGmT8=;
 b=jty/k1R8er1w9z1OSKSJoVGD4lgtg26R/tO/rgkZboHKw7u7IITf0YQbd512gPrZPR7Cz83cmUP+KI9pUJuOb+lYfiipEPtYsXtT6qLOVS8q/nac3mZp9aT3H3cBr9nOE62K7fxL+rkE0ycSXL+g6CFdubsIkyqDsttG2dWIKyJ+4z0eaQ4kxJf6u542HjRhpwTApOMacQ0UX1s4nJNdjjwhJWpQnfO4Feu0scs7SiT9RQ8cPk6S4dsfPeUXZMV0hTkKOcO1kHwhk+wXsz/omiokNwlYJOuG8ogFbizTIflsa/Sj4B2uAj8o0ZEwVdwReLDcCGmghCFtbcmM5EH8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR3kuuoxZocsoFlYX01SVAoPk+IfmEpAsE2vxmtGmT8=;
 b=o/xY3P2Hm3Z/j/nxKEyJ2KXBa7iI7JuDESVAniFKo/4HubCdr4IbNk2C3rvxoQP3TVqy9HchdTF4bjKf3WjckF5kz3EUJTYo9jwUlHVPEXAW24mwEducp4+G8tZI4d+qnPSOB9D/4V7GtyHpR3/sUKlBdfGSGnvvHSBnYrbwo8/2iWOLfkb+tuSgKB3wL4/4Z0ZmaGWLm87wKjDx6jNsVjiE8MvUtodGyTVfjn8Zx5vdPfojFJjfx+bVtU4bvxmcEcf2JbabxFhbi5rTvhOM5U/wkHz4fTQYYnlpu7RfezR4mDFaaJFG1XY3F/XP8VcZW/58Bgkb9OtksTQsfMewTw==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by DB8P191MB0747.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:29:22 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:29:22 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
Thread-Topic: regression: kernel 6.4.x breaks scanning/pairing (but not use)
 of LE devices
Thread-Index: AQHZxwU/0l6XSi77i0WWX4xR1VKYUK/bT48AgAmttwCAAGKEAIAEPmCAgACtnwCAADbxAIAKxc+AgAEzgYA=
Date:   Tue, 22 Aug 2023 14:29:22 +0000
Message-ID: <11520919.Tf534PAFkr@bruno-beit>
References: <2300626.ElGaqSPkdT@bruno-beit>
 <CABBYNZLo0WT+VovmB3AKPKNNLXPNPBdECNzf6MNu+aL6d91naQ@mail.gmail.com>
 <CABBYNZ+z_=ZfJQQJ=A-HC7Ox+1jueeb_oWwcerC0YKS8z0QMug@mail.gmail.com>
In-Reply-To: <CABBYNZ+z_=ZfJQQJ=A-HC7Ox+1jueeb_oWwcerC0YKS8z0QMug@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [TUYU9V6WBv1YFJi4Kt27ryF216tpzSqU]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|DB8P191MB0747:EE_
x-ms-office365-filtering-correlation-id: 27a47052-244d-40d3-d5c9-08dba31c2de8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMkQ/ptbYwbrytTIdIUgiwSw6WIIYiRBmw64Ggwp88a461ch1NTY+ic+R1GzVS7WxFqZHHtRP+AoWYlprXI+lKSGRcPmqVc/TeI6oSicviI/o9eJwqCRP8Pd8GZ9TNVXKr/RFyxn+OOSqTckjFRpgSresrLB1EyetUd1Uafv8eTTU51IVon3b41SoEGUGonpvk45jXfMMJWsaJqwRA2SVoiB/VU3+mDyDh+FnCi/kk0d7NMQOs+z4hjZ33OccXMdmpgQWxN1hvnklt6SQP9/e14kdCmOuH8TpXixjYHrI7iQ1rIbsZUCI7lzF9/W0PrQupIJ2Joeop8jtw1wbsysoOeN+j+dEWnkX8bYFAoDg7iEeXw+wvfHH9NFoarViRQWybE4uBT0txVDrKfBVj5zjY0QQSDiZTuVcm2c+JGdC2GwpiaRnGq2e36hUkqHm63wc8MdfHBtFSFvgiIZv59cOIYMA0sUYaqjrA8tc+WuTuyGbfrM5SU6RfA0oX+IqJTSKB2HcXXnXinuxC2VuGPKln7SD3JCE7/8GnEgEyGRZRY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJwR0FFSnNVR1NHZXFjRzZZUzMrZVVLd1ZLM01RdEZBdm9GZ1ZwUmJiNVla?=
 =?utf-8?B?ZU5zd0NudU9sRUIySHhnb1grOUdNQlZ6SFpydm5jK3JRQUVrYU9ha0NTNHla?=
 =?utf-8?B?b2huMytPclJocG9NcGoxN2hBNHE4ZkZYSUhiQmw3NEtQMit1Q0ZMVVJrUThq?=
 =?utf-8?B?bHNKWGdqWjVEV0QvV0Q5bHNCYnltajZ1Yytzb20wWkpnQ041bWhYamQzdERx?=
 =?utf-8?B?dlVFWWVPUUNtS2g3dXlYbU9aakwvQ05UeVVNNnRWSkRhdHlOVzZ2OHhiMUha?=
 =?utf-8?B?R1l5a1o4S3ErSFB3S0drdTFlYVVid3lmTWYvN1VNNXdUd1NWTVROQ1ZZdzB0?=
 =?utf-8?B?bnVRZm4xSnU5UmF3aERBM0Vpb0EwdFEwV2VDNncxc3ZhTjZxVVBzQkl3RTNF?=
 =?utf-8?B?dys3ZFdsMTJkUUpTUmdMUDVlTm9QR0dYY0lYNkFRcnBTUnhSem9FVUlwTjEx?=
 =?utf-8?B?cVQyMUxPNzc5bE5uajRaK203YTZvTWJkRi9sNVUwcmJsRHRnMjhtR0p5OVow?=
 =?utf-8?B?MWRhR040b3JEZUpDOG41R3REOGI1dHRJbWtIdjMvcFpZMEdaa2x4UzBaSzZp?=
 =?utf-8?B?MS96cmhaYnFnWUY1MVE5SFRaQmtYL3h0SUY3UDA1U0VxSDBEL1hlVE9Obkx6?=
 =?utf-8?B?UFZuRWhjRVowU004TDladkdPQzdDbUQ5S2JONGNBUmRaRFhLM1FQUmZwVjNN?=
 =?utf-8?B?WE9oMWRWNHNOZFhweThtV1pLSUJrOWpqSzNWR1g5VFQ1RVh3ejBtTytMVUVp?=
 =?utf-8?B?OFBFeVRMeERxMjFHMUhnUHg4U3RhTVNER0NBZ3pIUG1qYXpqOHpFZE5iMTNB?=
 =?utf-8?B?TGIzcUJQcVgzRytFNnl4dS9RRVlsZ1AwclQ0MHBOQXRoNE5naDkrQkpxak1h?=
 =?utf-8?B?WHhNaWVpQ21NTHo5aUlVV3FIbHlnU0JZbGo4ZmpNYUEvWE9vT0s0OU9rN2Vu?=
 =?utf-8?B?QURKM0dRUG1pamJUZzRIZWRDMUQvUEhQekNxWUR5bDVHOVVEN2RsWWFFUlVp?=
 =?utf-8?B?d0VaLzcrVWNpNXVsbUFPWnRFdXlZTldpY1luNHNnYjIwc011dis0eFJPYzlT?=
 =?utf-8?B?d3BmNzM3a1B6OUp4Wkh5QlFiakhtWHZHd29FTU04cWRPV1BkaWgycGZoUW90?=
 =?utf-8?B?YmR5OWFEdkhJbGZ3eTZVV1Z4VkNONVNjeWhwOXc3dFZJT21iZ3ZmOXdscUs1?=
 =?utf-8?B?RkYzd2NNZXp4UWlxOE4vZmcrZUR0VFdBcUtGZGZrZEhBSjBLL3hqK2JLbk15?=
 =?utf-8?B?T0FodW5mWXZTRHA1di9wKzhOYkhQenJNRTd6Y3hQbGozZGl1Zmx1MVFJc0tL?=
 =?utf-8?B?UHVNQm5zcHljZXdDdWdRODRIYko3SVl5K0RVakFIQkRlcFlIdjE4TzgvZ29K?=
 =?utf-8?B?T3ZtMEQzdXNCY0JWUHJ0ak9wMklyV3k3Q0pFdTBydnlCNHU1L0VhdFlNS2V4?=
 =?utf-8?B?ZzlKR0duR0o3am5mVkJWQmtMbkRCVFM3SU0yZ0hZZitVc0IrOUZuSlc2akJl?=
 =?utf-8?B?dS81MzNrcDUwbGpOZDBYM0ZPME42NG9sbDloZ3JzOEdzd3ZqVXYyQkplMEEx?=
 =?utf-8?B?SnZMbXNDMkpPNkNsL3RkQW5wUVc3U0g3bGtTYTNWc0hVVnhUZEdwTUpSd3l2?=
 =?utf-8?Q?zTmIrLE7f1utJwhWYigmmf4oKQQKMfVCzUtuXwIe1qQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3FA21821D55C4D83D94F2180B60336@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a47052-244d-40d3-d5c9-08dba31c2de8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 14:29:22.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P191MB0747
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RG5pYSBwb25pZWR6aWHFgmVrLCAyMSBzaWVycG5pYSAyMDIzIDIyOjA4OjQ1IENFU1QgTHVpeiBB
dWd1c3RvIHZvbiBEZW50eiBwaXN6ZToKPiBIaSBCcnVubywKPiAKPiBPbiBNb24sIEF1ZyAxNCwg
MjAyMyBhdCA0OjM44oCvUE0gTHVpeiBBdWd1c3RvIHZvbiBEZW50ego+IDxsdWl6LmRlbnR6QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgQnJ1bm8sCj4gPgo+ID4gT24gTW9uLCBBdWcgMTQs
IDIwMjMgYXQgMToyMeKAr1BNIEx1aXogQXVndXN0byB2b24gRGVudHoKPiA+IDxsdWl6LmRlbnR6
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhpIEJydW5vLAo+ID4gPgo+ID4gPiBPbiBN
b24sIEF1ZyAxNCwgMjAyMyBhdCAzOjAw4oCvQU0gQnJ1bm8gUGl0cnVzIDxicnVub3BpdHJ1c0Bo
b3RtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBEbmlhIHBpxIV0ZWssIDExIHNpZXJw
bmlhIDIwMjMgMTk6MTE6NTAgQ0VTVCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHBpc3plOgo+ID4g
PiA+ID4gSGkgQnJ1bm8sCj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMg
YXQgNDoyNeKAr0FNIEJydW5vIFBpdHJ1cyA8YnJ1bm9waXRydXNAaG90bWFpbC5jb20+IHdyb3Rl
Ogo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBEbmlhIHNvYm90YSwgNSBzaWVycG5pYSAyMDIzIDA5
OjMxOjA4IENFU1QgUGF1bCBNZW56ZWwgcGlzemU6Cj4gPiA+ID4gPiA+ID4gW0NjOiArcmVncmVz
c2lvbnNAXQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gI3JlZ3pib3QgaW50cm9kdWNlZCB2
Ni4zLjkuLnY2LjQuMgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRGVhciBCcnVubywKPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmsgeW91IGZvciB5b3Vy
IHJlcG9ydC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFtIDA0LjA4LjIzIHVtIDIwOjU1
IHNjaHJpZWIgQnJ1bm8gUGl0cnVzOgo+ID4gPiA+ID4gPiA+ID4gSSBhbSB1c2luZyBvcGVuU1VT
RSBUdW1ibGV3ZWVkIG9uIGEgRGVsbCBQcmVjaXNpb24gMzU1MSB3aGljaCBoYXMgYQo+ID4gPiA+
ID4gPiA+ID4gYmx1ZXRvb3RoIGFkYXB0ZXIgb2YgSUQgODA4NzowMDI2IChJbnRlbCBBWDIwMSku
IEkgYW0gdXNpbmcgYQo+ID4gPiA+ID4gPiA+ID4gTG9naXRlY2ggTTU3NSB0cmFja2JhbGwgbW91
c2Ugd2hpY2ggb25seSBzdXBwb3J0cyBCbHVldG9vdGggTEUuCj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gV2l0aCBrZXJuZWwgNi40LjIgb3IgbmV3ZXIsIHNjYW5uaW5nIGZvciBkZXZp
Y2VzIOKAlCB1c2luZyBlaXRoZXIgdGhlCj4gPiA+ID4gPiA+ID4gPiBLREUgZ3VpIG9yIGJsdWV0
b290aGN0bCDigJQgbW9zdCBvZiB0aGUgdGltZSByZXR1cm5zIG9ubHkg4oCcY2xhc3NpYwo+ID4g
PiA+ID4gPiA+ID4gYmx1ZXRvb3Ro4oCdIGRldmljZXMgbGlrZSBjb21wdXRlcnMgYW5kIHBob25l
cywgYW5kIG5vdCB0aGUgbW91c2UuIElmCj4gPiA+ID4gPiA+ID4gPiB0aGUgbW91c2Ugd2FzIHBh
aXJlZCBiZWZvcmUsIGl0IHdvcmtzIGNvcnJlY3RseSBob3dldmVyLgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IFdpdGggcHJldmlvdXMga2VybmVsIHZlcnNpb25zICg2LjMuOSBhbmQg
YmVmb3JlKSwgcGFpcmluZyB0aGUgbW91c2UKPiA+ID4gPiA+ID4gPiA+IHdvcmtlZCBjb3JyZWN0
bHkuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBBcmUgeW91IGFibGUgdG8gYmlzZWN0IHRo
ZSByZWdyZXNzaW9uPyBQbGVhc2UgYWxzbyBhdHRhY2ggdGhlIExpbnV4Cj4gPiA+ID4gPiA+ID4g
bWVzc2FnZXMuIChZb3UgY2FuIGFsc28gY3JlYXRlIGEgdGlja2V0IGluIHRoZSBMaW51eCBrZXJu
ZWwgQnVnemlsbGEgWzFdCj4gPiA+ID4gPiA+ID4gYW5kIGF0dGFjaCBldmVyeXRoaW5nIHRoZXJl
LikKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gS2luZCByZWdhcmRz
LAo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gUGF1bAo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBbMV06IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy8KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGUgb2ZmZW5kaW5nIGNvbW1pdCBp
cyBodHRwczovL2dpdGh1Yi5jb20vU1VTRS9rZXJuZWwvY29tbWl0LzI4OGM5MDIyNGVlYzU1ZDEz
ZTc4Njg0NGI3OTU0ZWYwNjA3NTIwODkgOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEJsdWV0
b290aDogRW5hYmxlIGFsbCBzdXBwb3J0ZWQgTEUgUEhZIGJ5IGRlZmF1bHQKPiA+ID4gPiA+ID4g
PiBUaGlzIGVuYWJsZXMgMk0gYW5kIENvZGVkIFBIWSBieSBkZWZhdWx0IGlmIHRoZXkgYXJlIG1h
cmtlZCBhcyBzdXBwb3J0ZWQKPiA+ID4gPiA+ID4gPiBpbiB0aGUgTEUgZmVhdHVyZXMgYml0cy4K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2
b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBE
byB5b3UgaGF2ZSB0aGUgYnRtb24vSENJIHRyYWNlcyBzaG93aW5nIHRoaXMsIHdlIGFsc28gbmVl
ZCB0aGUKPiA+ID4gPiA+IGZpcm13YXJlIHZlcnNpb24gYXMgd2VsbCBzaW5jZSBJIHN1c3BlY3Qg
dGhpcyBpcyBkdWUgdG8gdGhlIGNvbnRyb2xsZXIKPiA+ID4gPiA+IHNldHRpbmcgdGhlIFBIWXMg
YXMgc3VwcG9ydGVkIGJ1dCBiZWluZyB1bmFibGUgdG8gdG8gdXNlIHRoZW0KPiA+ID4gPiA+IHBy
b3Blcmx5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gaGNpY29uZmlnIHNheXMgdGhlIGJl
bG93OiAoSSBhc3N1bWUg4oCcUmV2aXNpb27igJ0gaXMgdGhlIGZpcm13YXJlIHZlcnNpb24pCj4g
PiA+Cj4gPiA+IFlvdSBjYW4gZmluZCB0aGUgZmlybXdhcmUgaW5mb3JtYXRpb24gb24gZG1lc2cs
IGUuZzoKPiA+ID4KPiA+ID4gWyAgICA3Ljk4MjU4NV0gQmx1ZXRvb3RoOiBoY2kxOiBGb3VuZCBJ
bnRlbCBEREMgcGFyYW1ldGVyczogaW50ZWwvaWJ0LTIwLTEtMy5kZGMKPiA+ID4gWyAgICA3Ljk4
NDExM10gQmx1ZXRvb3RoOiBoY2kxOiBBcHBseWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21w
bGV0ZWQKPiA+ID4gWyAgICA3Ljk4NTExMV0gQmx1ZXRvb3RoOiBoY2kxOiBGaXJtd2FyZSByZXZp
c2lvbiAwLjMgYnVpbGQgMTQ0IHdlZWsgMTEgMjAyMwo+ID4gPgo+ID4gPiA+IGhjaTA6ICAgVHlw
ZTogUHJpbWFyeSAgQnVzOiBVU0IKPiA+ID4gPiAgICAgICAgIEJEIEFkZHJlc3M6IEYwOjlFOjRB
OkU2OjYyOjE1ICBBQ0wgTVRVOiAxMDIxOjQgIFNDTyBNVFU6IDk2OjYKPiA+ID4gPiAgICAgICAg
IFVQIFJVTk5JTkcKPiA+ID4gPiAgICAgICAgIFJYIGJ5dGVzOjE1MDA1MCBhY2w6ODExNCBzY286
MCBldmVudHM6MjcwIGVycm9yczowCj4gPiA+ID4gICAgICAgICBUWCBieXRlczo1OTcwIGFjbDo2
OSBzY286MCBjb21tYW5kczoxNzMgZXJyb3JzOjAKPiA+ID4gPiAgICAgICAgIEZlYXR1cmVzOiAw
eGJmIDB4ZmUgMHgwZiAweGZlIDB4ZGIgMHhmZiAweDdiIDB4ODcKPiA+ID4gPiAgICAgICAgIFBh
Y2tldCB0eXBlOiBETTEgRE0zIERNNSBESDEgREgzIERINSBIVjEgSFYyIEhWMwo+ID4gPiA+ICAg
ICAgICAgTGluayBwb2xpY3k6IFJTV0lUQ0ggU05JRkYKPiA+ID4gPiAgICAgICAgIExpbmsgbW9k
ZTogUEVSSVBIRVJBTCBBQ0NFUFQKPiA+ID4gPiAgICAgICAgIE5hbWU6ICdbUkVEQUNURURdJwo+
ID4gPiA+ICAgICAgICAgQ2xhc3M6IDB4NmMwMTBjCj4gPiA+ID4gICAgICAgICBTZXJ2aWNlIENs
YXNzZXM6IFJlbmRlcmluZywgQ2FwdHVyaW5nLCBBdWRpbywgVGVsZXBob255Cj4gPiA+ID4gICAg
ICAgICBEZXZpY2UgQ2xhc3M6IENvbXB1dGVyLCBMYXB0b3AKPiA+ID4gPiAgICAgICAgIEhDSSBW
ZXJzaW9uOiA1LjIgKDB4YikgIFJldmlzaW9uOiAweDIwY2UKPiA+ID4gPiAgICAgICAgIExNUCBW
ZXJzaW9uOiA1LjIgKDB4YikgIFN1YnZlcnNpb246IDB4MjBjZQo+ID4gPiA+ICAgICAgICAgTWFu
dWZhY3R1cmVyOiBJbnRlbCBDb3JwLiAoMikKPiA+ID4gPgo+ID4gPiA+IEknbSB1bnN1cmUgaG93
IHRvIGF0dGFjaCB0aGUgYnRtb24gb3V0cHV0IGFzIGl0IGlzIGEgYmluYXJ5IGZpbGUgdGhhdCBj
b250YWlucyBwb3RlbnRpYWxseSBwcml2YXRlIGluZm9ybWF0aW9uIChuYW1lcyBvZiBuZWFyYnkg
ZGV2aWNlcykKPiA+ID4KPiA+ID4gV2VsbCB5b3UgY2FuIGNvbGxlY3QgaXQgbWFudWFsbHkgYW5k
IHJlZGFjdGVkIHRoZSBhZGRyZXNzZXMsIGV0YywgdXAKPiA+ID4gdG8geW91LCBJJ20gdXN1YWxs
eSBub3QgdGhhdCBwYXJhbm9pZCBvZiBzaGFyaW5nIHRoaXMga2luZCBvZgo+ID4gPiBpbmZvcm1h
dGlvbiBpZiB5b3Ugc2NhbiBmb3IgYSBzaG9ydCB0aW1lLCBpbiB0aGUgb3RoZXIgaGFuZCBJIHVz
dWFsbHkKPiA+ID4gdXNlIGdpc3QuZ2l0aHViLmNvbSB0byBkbyB0aGF0IHNvIEkgY2FuIGRlbGV0
ZSBpdCBsYXRlciBpZiBuZWVkZWQuCj4gPgo+ID4gU2VlbXMgdG8gYmUgd29ya2luZyBmaW5lIGhl
cmUgKHdpdGggQVgyMDEgYW5kIEFYMjEwKToKPiA+Cj4gPiBodHRwczovL2dpc3QuZ2l0aHViLmNv
bS9WdWRlbnR6L2Q4MGFiNjNmNGY2MmY5ZjIxNjc5NmVkYjQ4MzhjODU1Cj4gCj4gQ2FuIHlvdSB0
cnkgd2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoOgo+IAo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9ibHVldG9vdGgvcGF0Y2gvMjAyMzA4MjExODE4NDguMzU1Mzg2My0xLWx1
aXouZGVudHpAZ21haWwuY29tLwo+IAo+IExvb2tzIGxpa2Ugd2Ugd2VyZSBub3Qgc3RvcmluZyB0
aGUgd2hvbGUgYWR2ZXJ0aXNlbWVudCBzb21ldGltZXMuCj4gCj4gCgpJIGFwcGxpZWQgeW91ciBw
YXRjaCwgYWxvbmcgd2l0aCBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ibHVl
dG9vdGgvbXNnMTA1NDQzLmh0bWwgc2luY2UgdGhhdCBkZWZpbmVzIHRoZSBuZWVkZWQgbWF4X2Fk
dl9sZW4gbWFjcm8sIG9uIHRvcCBvZiB0aGUgcmVncmVzc2lvbi1pbnRyb2R1Y3RpbmcgY29tbWl0
LiBVbmZvcnR1bmF0ZWx5LCBpdCBkaWQgbm90IGhlbHAg4oCUIExFIGRldmljZXMgYXJlIHN0aWxs
IG5vdCBkZXRlY3RlZCAoZWl0aGVyIGF0IGFsbCBvciBhZnRlciBvbmUtdHdvIHN1Y2Nlc3NmdWwg
cGFpcmluZ3MpLgo=
