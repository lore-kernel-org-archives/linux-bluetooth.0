Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C6BC71150
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 13:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377296AbjHRNvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377452AbjHRNvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 09:51:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2061.outbound.protection.outlook.com [40.92.89.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632535AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 06:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnhgKNeXcAQ+3Zs3u94Bu016jqD37FnE/A+Fy7EWFkUhipjDkpTbHb/G5mocmioQFpnSFoj4vzDccAhZkwqktpjCzMwzuyPTW1wZeJuXXhdePSkeM0Jul4YVw15ectu51wNyAg9AnDeo1V+S2meKmVWdG06VagYUjoe1rSY8ObmUT2xh0sxCcxDx6S19qRTC4Kt5hrd7SZTI1v3PXBWq4+7y7bx3YluYcjTdO/K6lnCPdsqNOdQJKL9Vxwq3Mtiqm+ElyIvEAboA/e/Ov2zTUExZT0UGozAHThd8OXuB/dHm2EDw+v5mep87VUpM1YvE+SGtLs+fqol+CQevDr/weA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOh9IHe0AKMVkT1uD4usX6WetsN1G/uJprLQXGzMFhg=;
 b=NzKxAZyDqqTPLYRWc7ajLPZYiafnYzMKAD2Uek1Duj8JVGGH5OQvE5j08aBmJgzZUBxJ/Whste44oNdAhjBMjC256NxZ64dZoA0TggPj6Hc91IDmp+6q/0Irsullh16I+EA6zpiDWe6JWREA/tO/eixLmCTxwXj6bPBU3h6UrtIHNh08TIw5wIJJh4UYWj11eQL7qeuVgobdkWmGL3VBJzGQchq085mZTXB6Qq+mRyMWcQsYJUftApxwsQyeuL3Q7M0Bh7y9AQYAAFVcbdGEdDAu+FP77XEfwHtEBQghvnrqHLbgcn127JAutdBmHrCSZd7mptFmHoTXOI95dZ3hwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOh9IHe0AKMVkT1uD4usX6WetsN1G/uJprLQXGzMFhg=;
 b=r0SMbX+dXV6mk42/yIaW6uR44ZKDEN/vWzAAwjbttKlYuGnPxMae/9ccNBIw/kt56wVIjThBuyBGKLYXafMZQ7oUdDpxFh2skGME5Fvli/PhaGF23Hf5dDQHt+kOVStCQ8r3QpUncGxGm9SFct1iHr0TS4WJ3OUxMtTZqpvaCVfqSjmTZHNwUiVkU1jVGm4josmvISfuJzLuvD/pM2itJgtYfFhEZnBxwtfpQUxACTg9yMmbMq9JkA/BIWnd9tDHM777rzB+7lcsRJlHw7GGy/WeHmvcRMtkNumSt/XP57yqtwxp92ZQPr23U+8XufefjsZTJ20uTixvZjHBtznDYw==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by GV1P191MB2194.EURP191.PROD.OUTLOOK.COM (2603:10a6:150:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 13:51:21 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 13:51:21 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
Thread-Topic: regression: kernel 6.4.x breaks scanning/pairing (but not use)
 of LE devices
Thread-Index: AQHZxwU/0l6XSi77i0WWX4xR1VKYUK/bT48AgAmttwCAAGKEAIAEPmCAgACtnwCAADbxAIAFpV0A
Date:   Fri, 18 Aug 2023 13:51:21 +0000
Message-ID: <6564663.ygkLAPyYMk@bruno-beit>
References: <2300626.ElGaqSPkdT@bruno-beit>
 <CABBYNZLpHxGHKsB_JPh1Drg=V_gXMGTp=nqXB=W1MM2_6BNHQw@mail.gmail.com>
 <CABBYNZLo0WT+VovmB3AKPKNNLXPNPBdECNzf6MNu+aL6d91naQ@mail.gmail.com>
In-Reply-To: <CABBYNZLo0WT+VovmB3AKPKNNLXPNPBdECNzf6MNu+aL6d91naQ@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [TFpmv9vZ4JkAKKDEYEJTUb3Iw69LEtjY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|GV1P191MB2194:EE_
x-ms-office365-filtering-correlation-id: 7434fb1d-03d6-4b00-bbd0-08db9ff2344c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1MZ5tgEvE/uReJyaL0uuzMtK0mHhMGPMrdJ4ZP+ZNt1wJc0gwS161kkgDL5lovsootnslSs5pgV21o3lyLIJMXMbqwrcXWo8aq7UVTRohKhTEyKyTlf3bxkjdG/pJHTtc5wYKeyNX1LkIUhOci/adqFtlAo1ExICyP4sroO/ifVdHZzxyTcpS/PAaN0p0EcS9aDE1Bi+2jYt1ObOrdAdqQkZc4+p81eJf7cWaiQTI+ChcgqnuZ1abbbFcwtb4PK405bKOuq8xnSVW8URFSB7BnS4Bb6rThR8/VKq965wJoF8o1tXQoeFCVOIB6cBytAhBHpoOZ6wEtC5ky0ZS/zOFcSUTfSmDus1COg2Q0EW2EWVcYc6ZpSp1O2TObNjszhw8xOgYQQjJxrCcaP3BGUq6dcUwQ9R03Bkt+OUsjP96kjOdnatq44PU6L5V3eH9qPpko6hSYfmEp+wHVYnuigAXNExFImDsYrFDr6Phyw1IYgUysFw3irG219bGefbscvmDj9DQZA9UBPffYKxx63JEnkRteWUeYs0urTTJBYMNb0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NllZRmVZeTdqZW90YVBKZU53WWhMc09UTjdMNUJ4dFFPMzZBRzhPMHFFeDdz?=
 =?utf-8?B?bEdFeHoyc2FpVDNNZXpnREdEUWJOcWMwTzNJMmQ1WGw1eDg4bURsTThnK1JJ?=
 =?utf-8?B?dDhPY0RlSDVGMnNLdkpUcFpMeFg2WUJMZFo2dVQvYWl4L1NyalNlSWpzRVcx?=
 =?utf-8?B?clFSWmZQVHRLTi82dWl2Y0NMK1RHQVk2SmFwRjVVTnMvUzNZRURVWGpBRlJ5?=
 =?utf-8?B?OElpS01wR250ZlRvN0lielowWWROTi9FbVV0M0F1TEF0SkdBaExRbjNiVWk0?=
 =?utf-8?B?TDExWXZoS1lhbWwzeXdXdGxRNWhWajVpbkcrSnVScEtvKzRQV0dGUC9sVjM1?=
 =?utf-8?B?Rk9xRVV6OVh4c2xMSVc0YXF2VkFHcXlOWEJTNXZMS1REVFhOK2Y3NGs4S3cz?=
 =?utf-8?B?Ri9Vc1VSNVFqY1Z1bHpMWkFlaVIwdExwRzd5RGlDVTZSbUQ2U0Z5MlVBejBL?=
 =?utf-8?B?MzhWUmpsNEFTMEp1UmtGU01la1NvU240NkVxdjc5VG5xVXArajJoUGhuaDNl?=
 =?utf-8?B?THNCemsxYUM0NlBqT1dzc0NwNmhSMWQvdDJSL3o2M2xJaGdyODg4UmZLZzlp?=
 =?utf-8?B?anZBRXg0S3hPbDNRQ2ozZXVRQTNITEhlNklESTZRUGxDMUFSdWxLVm9VdGZ4?=
 =?utf-8?B?NFF4cnA4NlV3cmdkbWpXaWNUckREbWhUZmVZc0NKT0lnaWVmZS9idlVheThl?=
 =?utf-8?B?TzVkVkZmU1FjOTA5ejJvU21sbXNLcVJ0VHV5YmRQZ3RnenllVDZ2ZndMcXZi?=
 =?utf-8?B?VWFldDJTZ1lRSFF6dE1rcElpQTM2OVR1K0dJclJVYmhlT1g3VGdaaWJDNlp4?=
 =?utf-8?B?dlNvSVFBTGpqcHFDMFl5a0JPL2d1eXkxOUhERlZNeEowOVBIdWhDbmFYNUhT?=
 =?utf-8?B?clhGMVFnSXpIcUQwUU01YlFtQUk5QUZIelpiN2N3UElvSGQ4TlF4RHc1dWJ5?=
 =?utf-8?B?QWZtQVV0QjhBRHV2NU9ua2puMDNyYVk4T1FYMStZdDdlYjRlUkhEMXAwU3p1?=
 =?utf-8?B?d1RXTTBoakg3WlpXbElXY3R4ZTZQMFk2ODJreHR0WWxOTkh6NTIwd1h6MkdV?=
 =?utf-8?B?aHEvSmMxdzhRZHl4ak1ON0syTGRUbVAwbmRyT3VxaC9KMis0UzVFK1NkLzVa?=
 =?utf-8?B?UWk4N0ZaaThhUml5eDNEM3RPMTlzQUtxdW92V2lLSVhhdGI5LzExamRLdHBx?=
 =?utf-8?B?dk9Tdml2L0hCRCtWRmhvWENuU0FxN1IwZVl6WmRiRThaajFUaXU4V1pYTVF0?=
 =?utf-8?B?NWFUQjZLSDRyTGxUTFM4TmFxUFByUE93djFST3JlNmVXaG0rS3B5MTZQeEo2?=
 =?utf-8?B?NUE2Q05sMldNODV5SXJ5WDJWS1hIUGU5eXFTQ05MSmdjQTVCZHZQRVNsRllZ?=
 =?utf-8?B?ejhOakhFMDhEWjM1elZINlNWYU1xN01RT0tWQWRleWRRZkRPRTZwTlFlOFZs?=
 =?utf-8?B?eklZN3dTSEhRVnE1YWpVVk5GM1JzMWJ3R0pVd2VkTllOVDFISi9vQmR1TnR0?=
 =?utf-8?B?UkkzYWt1dEJ5dzZ5b3FFejd3TnF3Z285VGpqYnlkRDZOaVVMampSaExmMTl3?=
 =?utf-8?B?WnQ4VGdiSFVucXdISzBkY0wwMTA4bFNCdlRTKzA4Um41NjhLeGoxanRyVEpQ?=
 =?utf-8?Q?IYJUYyz1OF/EH/XFYiUj2AgxVm8qTbtEYIJRk/nCYJJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92BAD50424DEE04DAEE14C8266B78613@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7434fb1d-03d6-4b00-bbd0-08db9ff2344c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:51:21.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P191MB2194
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

W1Jlc2VuZGluZyB0aGlzIGZvciBwb3N0ZXJpdHkgc28gdGhhdCBpdCBlbmRzIHVwIGluIHRoZSBt
YWlsaW5nIGxpc3QgYXJjaGl2ZXNdCkRuaWEgd3RvcmVrLCAxNSBzaWVycG5pYSAyMDIzIDAxOjM4
OjEwIENFU1QgcGlzemVzejoKPiBIaSBCcnVubywKPiAKPiBPbiBNb24sIEF1ZyAxNCwgMjAyMyBh
dCAxOjIx4oCvUE0gTHVpeiBBdWd1c3RvIHZvbiBEZW50ego+IDxsdWl6LmRlbnR6QGdtYWlsLmNv
bT4gd3JvdGU6Cj4gPgo+ID4gSGkgQnJ1bm8sCj4gPgo+ID4gT24gTW9uLCBBdWcgMTQsIDIwMjMg
YXQgMzowMOKAr0FNIEJydW5vIFBpdHJ1cyA8YnJ1bm9waXRydXNAaG90bWFpbC5jb20+IHdyb3Rl
Ogo+ID4gPgo+ID4gPiBEbmlhIHBpxIV0ZWssIDExIHNpZXJwbmlhIDIwMjMgMTk6MTE6NTAgQ0VT
VCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHBpc3plOgo+ID4gPiA+IEhpIEJydW5vLAo+ID4gPiA+
Cj4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgNDoyNeKAr0FNIEJydW5vIFBpdHJ1cyA8
YnJ1bm9waXRydXNAaG90bWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IERuaWEg
c29ib3RhLCA1IHNpZXJwbmlhIDIwMjMgMDk6MzE6MDggQ0VTVCBQYXVsIE1lbnplbCBwaXN6ZToK
PiA+ID4gPiA+ID4gW0NjOiArcmVncmVzc2lvbnNAXQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAj
cmVnemJvdCBpbnRyb2R1Y2VkIHY2LjMuOS4udjYuNC4yCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IERlYXIgQnJ1bm8sCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rIHlv
dSBmb3IgeW91ciByZXBvcnQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEFtIDA0LjA4LjIzIHVt
IDIwOjU1IHNjaHJpZWIgQnJ1bm8gUGl0cnVzOgo+ID4gPiA+ID4gPiA+IEkgYW0gdXNpbmcgb3Bl
blNVU0UgVHVtYmxld2VlZCBvbiBhIERlbGwgUHJlY2lzaW9uIDM1NTEgd2hpY2ggaGFzIGEKPiA+
ID4gPiA+ID4gPiBibHVldG9vdGggYWRhcHRlciBvZiBJRCA4MDg3OjAwMjYgKEludGVsIEFYMjAx
KS4gSSBhbSB1c2luZyBhCj4gPiA+ID4gPiA+ID4gTG9naXRlY2ggTTU3NSB0cmFja2JhbGwgbW91
c2Ugd2hpY2ggb25seSBzdXBwb3J0cyBCbHVldG9vdGggTEUuCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBXaXRoIGtlcm5lbCA2LjQuMiBvciBuZXdlciwgc2Nhbm5pbmcgZm9yIGRldmljZXMg
4oCUIHVzaW5nIGVpdGhlciB0aGUKPiA+ID4gPiA+ID4gPiBLREUgZ3VpIG9yIGJsdWV0b290aGN0
bCDigJQgbW9zdCBvZiB0aGUgdGltZSByZXR1cm5zIG9ubHkg4oCcY2xhc3NpYwo+ID4gPiA+ID4g
PiA+IGJsdWV0b290aOKAnSBkZXZpY2VzIGxpa2UgY29tcHV0ZXJzIGFuZCBwaG9uZXMsIGFuZCBu
b3QgdGhlIG1vdXNlLiBJZgo+ID4gPiA+ID4gPiA+IHRoZSBtb3VzZSB3YXMgcGFpcmVkIGJlZm9y
ZSwgaXQgd29ya3MgY29ycmVjdGx5IGhvd2V2ZXIuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiBXaXRoIHByZXZpb3VzIGtlcm5lbCB2ZXJzaW9ucyAoNi4zLjkgYW5kIGJlZm9yZSksIHBhaXJp
bmcgdGhlIG1vdXNlCj4gPiA+ID4gPiA+ID4gd29ya2VkIGNvcnJlY3RseS4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gQXJlIHlvdSBhYmxlIHRvIGJpc2VjdCB0aGUgcmVncmVzc2lvbj8gUGxlYXNl
IGFsc28gYXR0YWNoIHRoZSBMaW51eAo+ID4gPiA+ID4gPiBtZXNzYWdlcy4gKFlvdSBjYW4gYWxz
byBjcmVhdGUgYSB0aWNrZXQgaW4gdGhlIExpbnV4IGtlcm5lbCBCdWd6aWxsYSBbMV0KPiA+ID4g
PiA+ID4gYW5kIGF0dGFjaCBldmVyeXRoaW5nIHRoZXJlLikKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gS2luZCByZWdhcmRzLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBQYXVs
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFsxXTogaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnLwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBvZmZlbmRp
bmcgY29tbWl0IGlzIGh0dHBzOi8vZ2l0aHViLmNvbS9TVVNFL2tlcm5lbC9jb21taXQvMjg4Yzkw
MjI0ZWVjNTVkMTNlNzg2ODQ0Yjc5NTRlZjA2MDc1MjA4OSA6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBCbHVldG9vdGg6IEVuYWJsZSBhbGwgc3VwcG9ydGVkIExFIFBIWSBieSBkZWZhdWx0Cj4gPiA+
ID4gPiA+IFRoaXMgZW5hYmxlcyAyTSBhbmQgQ29kZWQgUEhZIGJ5IGRlZmF1bHQgaWYgdGhleSBh
cmUgbWFya2VkIGFzIHN1cHBvcnRlZAo+ID4gPiA+ID4gPiBpbiB0aGUgTEUgZmVhdHVyZXMgYml0
cy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZv
biBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgo+ID4gPiA+Cj4gPiA+ID4gRG8geW91
IGhhdmUgdGhlIGJ0bW9uL0hDSSB0cmFjZXMgc2hvd2luZyB0aGlzLCB3ZSBhbHNvIG5lZWQgdGhl
Cj4gPiA+ID4gZmlybXdhcmUgdmVyc2lvbiBhcyB3ZWxsIHNpbmNlIEkgc3VzcGVjdCB0aGlzIGlz
IGR1ZSB0byB0aGUgY29udHJvbGxlcgo+ID4gPiA+IHNldHRpbmcgdGhlIFBIWXMgYXMgc3VwcG9y
dGVkIGJ1dCBiZWluZyB1bmFibGUgdG8gdG8gdXNlIHRoZW0KPiA+ID4gPiBwcm9wZXJseS4KPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+IGhjaWNvbmZpZyBzYXlzIHRoZSBiZWxvdzogKEkgYXNzdW1lIOKA
nFJldmlzaW9u4oCdIGlzIHRoZSBmaXJtd2FyZSB2ZXJzaW9uKQo+ID4KPiA+IFlvdSBjYW4gZmlu
ZCB0aGUgZmlybXdhcmUgaW5mb3JtYXRpb24gb24gZG1lc2csIGUuZzoKPiA+Cj4gPiBbICAgIDcu
OTgyNTg1XSBCbHVldG9vdGg6IGhjaTE6IEZvdW5kIEludGVsIEREQyBwYXJhbWV0ZXJzOiBpbnRl
bC9pYnQtMjAtMS0zLmRkYwo+ID4gWyAgICA3Ljk4NDExM10gQmx1ZXRvb3RoOiBoY2kxOiBBcHBs
eWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21wbGV0ZWQKPiA+IFsgICAgNy45ODUxMTFdIEJs
dWV0b290aDogaGNpMTogRmlybXdhcmUgcmV2aXNpb24gMC4zIGJ1aWxkIDE0NCB3ZWVrIDExIDIw
MjMKPiA+Cj4gPiA+IGhjaTA6ICAgVHlwZTogUHJpbWFyeSAgQnVzOiBVU0IKPiA+ID4gICAgICAg
ICBCRCBBZGRyZXNzOiBGMDo5RTo0QTpFNjo2MjoxNSAgQUNMIE1UVTogMTAyMTo0ICBTQ08gTVRV
OiA5Njo2Cj4gPiA+ICAgICAgICAgVVAgUlVOTklORwo+ID4gPiAgICAgICAgIFJYIGJ5dGVzOjE1
MDA1MCBhY2w6ODExNCBzY286MCBldmVudHM6MjcwIGVycm9yczowCj4gPiA+ICAgICAgICAgVFgg
Ynl0ZXM6NTk3MCBhY2w6Njkgc2NvOjAgY29tbWFuZHM6MTczIGVycm9yczowCj4gPiA+ICAgICAg
ICAgRmVhdHVyZXM6IDB4YmYgMHhmZSAweDBmIDB4ZmUgMHhkYiAweGZmIDB4N2IgMHg4Nwo+ID4g
PiAgICAgICAgIFBhY2tldCB0eXBlOiBETTEgRE0zIERNNSBESDEgREgzIERINSBIVjEgSFYyIEhW
Mwo+ID4gPiAgICAgICAgIExpbmsgcG9saWN5OiBSU1dJVENIIFNOSUZGCj4gPiA+ICAgICAgICAg
TGluayBtb2RlOiBQRVJJUEhFUkFMIEFDQ0VQVAo+ID4gPiAgICAgICAgIE5hbWU6ICdbUkVEQUNU
RURdJwo+ID4gPiAgICAgICAgIENsYXNzOiAweDZjMDEwYwo+ID4gPiAgICAgICAgIFNlcnZpY2Ug
Q2xhc3NlczogUmVuZGVyaW5nLCBDYXB0dXJpbmcsIEF1ZGlvLCBUZWxlcGhvbnkKPiA+ID4gICAg
ICAgICBEZXZpY2UgQ2xhc3M6IENvbXB1dGVyLCBMYXB0b3AKPiA+ID4gICAgICAgICBIQ0kgVmVy
c2lvbjogNS4yICgweGIpICBSZXZpc2lvbjogMHgyMGNlCj4gPiA+ICAgICAgICAgTE1QIFZlcnNp
b246IDUuMiAoMHhiKSAgU3VidmVyc2lvbjogMHgyMGNlCj4gPiA+ICAgICAgICAgTWFudWZhY3R1
cmVyOiBJbnRlbCBDb3JwLiAoMikKClRoZSByZWxldmFudCBkbWVzZyBsaW5lcyBhcmU6CgpbICAg
MTAuMzU1OTE2XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIGRldmljZSBmaXJtd2FyZTogaW50ZWwv
aWJ0LTE5LTAtNC5zZmkKWyAgIDEwLjM1NjA2N10gQmx1ZXRvb3RoOiBoY2kwOiBCb290IEFkZHJl
c3M6IDB4MjQ4MDAKWyAgIDEwLjM1NjA3MF0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBWZXJz
aW9uOiAyMDYtMjIuMjMKWyAgIDEwLjM1NjA3M10gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBh
bHJlYWR5IGxvYWRlZAoKCj4gPiA+Cj4gPiA+IEknbSB1bnN1cmUgaG93IHRvIGF0dGFjaCB0aGUg
YnRtb24gb3V0cHV0IGFzIGl0IGlzIGEgYmluYXJ5IGZpbGUgdGhhdCBjb250YWlucyBwb3RlbnRp
YWxseSBwcml2YXRlIGluZm9ybWF0aW9uIChuYW1lcyBvZiBuZWFyYnkgZGV2aWNlcykKPiA+Cj4g
PiBXZWxsIHlvdSBjYW4gY29sbGVjdCBpdCBtYW51YWxseSBhbmQgcmVkYWN0ZWQgdGhlIGFkZHJl
c3NlcywgZXRjLCB1cAo+ID4gdG8geW91LCBJJ20gdXN1YWxseSBub3QgdGhhdCBwYXJhbm9pZCBv
ZiBzaGFyaW5nIHRoaXMga2luZCBvZgo+ID4gaW5mb3JtYXRpb24gaWYgeW91IHNjYW4gZm9yIGEg
c2hvcnQgdGltZSwgaW4gdGhlIG90aGVyIGhhbmQgSSB1c3VhbGx5Cj4gPiB1c2UgZ2lzdC5naXRo
dWIuY29tIHRvIGRvIHRoYXQgc28gSSBjYW4gZGVsZXRlIGl0IGxhdGVyIGlmIG5lZWRlZC4KPiAK
PiBTZWVtcyB0byBiZSB3b3JraW5nIGZpbmUgaGVyZSAod2l0aCBBWDIwMSBhbmQgQVgyMTApOgo+
IAo+IGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL1Z1ZGVudHovZDgwYWI2M2Y0ZjYyZjlmMjE2Nzk2
ZWRiNDgzOGM4NTUKPiAKPiA+ID4KPiA+Cj4gPgo+ID4gLS0KPiA+IEx1aXogQXVndXN0byB2b24g
RGVudHoKPiAKPiAKPiAKPiAKCkhlcmUgaXMgYSBidG1vbiBsb2cgb2YgbWUgdHJ5aW5nIHRvIHNl
YXJjaCBmb3IgZGV2aWNlcyBpbiBhIHF1aWV0IGxvY2F0aW9uICh0aGUgb25seSBkZXZpY2Ugc2Vl
biBpcyB0aGUgbW91c2Ug4oCUIGl0IHNob3dzIHVwIGluIHRoZSBidG1vbiBsb2dzIGJ1dCBOT1Qg
aW4gdGhlIEtERSBwYWlyaW5nIHdpbmRvdyk6Cmh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2JyanNw
L2Y2ODk3YWQxNDMxYTA2ODIwZWNkZDM3NzNkZDRhODU3Cg==
