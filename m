Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81092C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656646103A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhKFRaP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Nov 2021 13:30:15 -0400
Received: from mail-bo1ind01olkn0143.outbound.protection.outlook.com ([104.47.101.143]:53483
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhKFRaP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Nov 2021 13:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMfgyXeR+ehm8Ss4E7dPj07j3nhm9Yexihf0liQTPny3BFlIRGAxW2YxHMpopvlH3fCYLMO3xEnnbiARYlvT4QyiukBh71REpseiRjrPwpJcd4x/1s3Fau62AR5x6HDWJmSm+fAxnjO7ZKD8LIrEshI5wWBfxhy0julNJfQ24GFIq8T22P4ZA6ZNwsBhYW9hdipibTjSDEYxngBqK5cgDHY3s1g/RRdMUPjeDoEY+lMKd0/QxuPX0CMB8NZpiOtg0bdpieMnur91K6uaEjVna2BIs81fWzLSu6D6AWob2bbyagZnz1e3sA9PrumAIws1teuPS0GM3pOo8r8t19j2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbpRDRvba6MzOpM2VzJUGh28VpQpUOC4AfQta3JR95U=;
 b=Pqr9rdtIqI6l02EXaIyBcxJZp8a5tQusC07Im3NSvt02ylT5wUm6rzT/wVD6nYnFCIvOOXkn/Bszo8muA+xyIYd5tZOm+i/jpfMYm95ICT3Bw6Z4JGHSNg5DBGyuGzU82nznqovSjVzVSpNUJzDqHo1KkV7wRf3pEXLDazQdMO0PTR1z+lyBrFKd1ZOMtYXpsUZ/YdFiS5H3zofTJ98ndHL72uDICCmn5+bFqGMxY6BqZrDsHy0pqda9t/KfSVJgPIQ8x5opo/Iao9r5On2Prt2WB2z8vb+F49lc+dOYK1CQsBurHlahKTPYvcYRk9MaKzQyuy41YChLUFZzhCPqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbpRDRvba6MzOpM2VzJUGh28VpQpUOC4AfQta3JR95U=;
 b=gvA37fKYfR5KU0k+lIxB8Jn5jUAlo6WjiOpGrBVzaIMhFF8LrU1BcUsqA8/GfSSY57mCzePD2JY4FmG90gL/YGxy6xhY5N8V6eEKDbZMfgFlR2E+JqYJSPm6HD0jGXa3VfwjXY0KL4+co/7gQAq7yjOeWt2x7+XYXq1JvX1qUdSAuNGkqzvhs5BYZXBmTj/oBz+RMbCNc/fwaOO1E+AE5hQSyVAPwlc+bKhQ8a7MCB1m6quue9d1wVBwTE6YxlRFAayDAdIRTtcpFE1ysE4MYKu6/I8XkH37ceB/DhfKmgGoTkD82IJB3jMkpUdjlhjlQ75/FSfDYXhrKSw64n6Z9g==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB6430.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Sat, 6 Nov
 2021 17:27:28 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%8]) with mapi id 15.20.4669.011; Sat, 6 Nov 2021
 17:27:28 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hA==
Date:   Sat, 6 Nov 2021 17:27:27 +0000
Message-ID: <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
In-Reply-To: <YYZr14zwHnd52rQ7@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [yjwwtRJ9lQJMKHTxB0iZM8PYCG/f/hMnMLbu2icCOWFUWZovUoi4XI1tySvn2+hJ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5e470a-7f1f-4049-7b85-08d9a14ab4ac
x-ms-traffictypediagnostic: PN3PR01MB6430:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6LnOdNecpEUh6ejkVWYlMqI81A9WAFSWixZ2Br93ETElXYiNjK+xIO1dgZCwSSAZnYT+I9CW/8881mLWWsNBkRw402g9LcPu17/iYkxjQTd+UkSwoNjj9s4RL1QXtP4f31m4qvWr1bJSTeTSzgPwxUXdx3crl0RdYDsDFovKI1R3R5TIAXEG3OK/ZWYWnXrnp+v47yemrkF2+o1vV7jAYBrKCVAeVmsyJQuV/LFR1pPyrAnUl6FD3CNlqScSdri+V9mthlr6Wqbh4iNCMDwYjEMBEfNykSE+EKGr7q5LZ6b2ZSSii7IhaFz14iovDqOCVmGYoO6icF186mhqeFIsn6L/CyE9xkZKl/Q5/LU226RO54rUiQCValEFUsOpuKx4BJZYB+O640/L+Uk9S5S1el9R25CgRtAuhBOmqrBMJmZpzyCTNmpbDp/CovY1ifSm9AUgfs5GwWbz743QMftRcYjSzvw6GqRsGNpNttHDNdSEOQghApYHaYYaL3lv67emyjn1tyJ2JS/SgmUdnj0rfMXY8xiJV1JZSa3znpVzS9q3EIkai+vEzIDPxBEoxxyzRsVFOxJTcHvuOU55nBg4Og==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: MgBDONGH4XFHSKOTjuTvgl5jIL5s7c5h4rPpEkBvsXZjG71VRroXpQb/SU7sslLW9nq1bKSLgd1aCNMn0A/xRMQQ9o0hNBdsg4BgGkFisVFqXjqNEz9XTNSUTpnLfyL8xlaKRVvNjA2ZoUPH434oYzCWS9ocxHboKXpyzatfxtuW+Lyij3GEGlEFZkkIQ1Nssrs14v7z70lyAFMCQnytJjLVuzUc8EdpS5MUCV4VUgK8YWO2cqyVbsV5d3quptJlZsBY6ocBjRXVzRpI/mo/4rfTDFL1GXC199SznE5qiAcuV4YF9xNavUDh0MfjVJnLH3/z+G2uoWhf/H7b0XUgSuYt1jFvXcYuk6SdyQoJwE8FddAmw6gBXW77LJ7CSQtXLaR0kDIchqbd/ZGqizd51VW6lEJFR8ONHix/HFeybi4mPd3i14GyIY376rUV+btdhsZuTsHNs9XzqA3YaA2jjJ6711vw6146tlprwOYEwColpH8y/93M+msAVx1gHmB/p/PMfWiydaDGpprdZ3JxIiRAAlCxlbrXxK3ZjlU75BcZnE62av+3ajjsBrQ1SBfm+d1wADWafEQChd+60xdh2g8zRaOOTwKw7KvJOq4iImWGqVOnc/uprB2LwNugew/lcPSwYqXn3xLsRkbqkya5Zb2g5rmxdO/q9jjiesY8Ybrc30p7Sfo6Fbvr0LNQfGM3z7D/zXiaND5StTmxFS/iS+GANYTNi7HzJPk/QXh6ewoTJ+gHs740bMTNQzt2h5oigQPGYjgjmELmu3tKLYyvmA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCBBE8F27BFEA46A0D31AF6F74AC3C9@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5e470a-7f1f-4049-7b85-08d9a14ab4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2021 17:27:27.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6430
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQoNCj4gT24gMDYtTm92LTIwMjEsIGF0IDU6MTkgUE0sIEdyZWcgS0ggPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgTm92IDA2LCAyMDIxIGF0IDA5OjQx
OjI4QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiAwNi1Ob3Yt
MjAyMSwgYXQgMzoxNyBBTSwgTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFp
bC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEhpIE9ybGFuZG8sDQo+Pj4gDQo+Pj4gT24gRnJpLCBP
Y3QgMSwgMjAyMSBhdCAxOjU2IEFNIE9ybGFuZG8gQ2hhbWJlcmxhaW4NCj4+PiA8cmVkZWNvcmF0
aW5nQHByb3Rvbm1haWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFRoZSBMRSBSZWFkIFRyYW5z
bWl0IFBvd2VyIGNvbW1hbmQgaXMgQWR2ZXJ0aXNlZCBvbiBzb21lIEJyb2FkY29tDQo+Pj4+IGNv
bnRyb2xlcnMsIGJ1dCBub3Qgc3VwcG9ydGVkLiBVc2luZyB0aGlzIGNvbW1hbmQgYnJlYWtzIEJs
dWV0b290aA0KPj4+PiBvbiB0aGUgTWFjQm9va1BybzE2LDEgYW5kIGlNYWMyMCwxLiBBZGRlZCBh
IHF1aXJrIGRpc2FibGluZyBMRSBSZWFkDQo+Pj4+IFRyYW5zbWl0IFBvd2VyIGZvciB0aGVzZSBk
ZXZpY2VzLCBiYXNlZCBvZmYgdGhlaXIgY29tbW9uIGNoaXAgaWQgMTUwLg0KPj4+PiANCj4+Pj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci80OTcwYTk0MC0yMTFiLTI1ZDYtZWRhYi0y
MWE4MTUzMTM5NTRAcHJvdG9ubWFpbC5jb20NCj4+Pj4gU2lnbmVkLW9mZi1ieTogT3JsYW5kbyBD
aGFtYmVybGFpbiA8cmVkZWNvcmF0aW5nQHByb3Rvbm1haWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4g
djEtPnYyOiBDbGFyaWZpZWQgcXVpcmsgZGVzY3JpcHRpb24NCj4+Pj4gDQo+Pj4+IGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0YmNtLmMgICB8ICA0ICsrKysNCj4+Pj4gaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2hjaS5oIHwgMTEgKysrKysrKysrKysNCj4+Pj4gbmV0L2JsdWV0b290aC9oY2lfY29yZS5jICAg
IHwgIDMgKystDQo+Pj4+IDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0YmNt
LmMgYi9kcml2ZXJzL2JsdWV0b290aC9idGJjbS5jDQo+Pj4+IGluZGV4IGU0MTgyYWNlZTQ4OC4u
NGVjYzUwZDkzMTA3IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGJjbS5j
DQo+Pj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0YmNtLmMNCj4+Pj4gQEAgLTM1Myw2ICsz
NTMsMTAgQEAgc3RhdGljIGludCBidGJjbV9yZWFkX2luZm8oc3RydWN0IGhjaV9kZXYgKmhkZXYp
DQo+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc2tiKTsNCj4+Pj4gDQo+Pj4+ICAg
ICAgIGJ0X2Rldl9pbmZvKGhkZXYsICJCQ006IGNoaXAgaWQgJXUiLCBza2ItPmRhdGFbMV0pOw0K
Pj4+PiArDQo+Pj4+ICsgICAgICAgaWYgKHNrYi0+ZGF0YVsxXSA9PSAxNTApDQo+Pj4+ICsgICAg
ICAgICAgICAgICBzZXRfYml0KEhDSV9RVUlSS19CUk9LRU5fUkVBRF9UUkFOU01JVF9QT1dFUiwg
JmhkZXYtPnF1aXJrcyk7DQo+Pj4+ICsNCj4+Pj4gICAgICAga2ZyZWVfc2tiKHNrYik7DQo+Pj4+
IA0KPj4+PiAgICAgICAvKiBSZWFkIENvbnRyb2xsZXIgRmVhdHVyZXMgKi8NCj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2kuaCBiL2luY2x1ZGUvbmV0L2JsdWV0b290
aC9oY2kuaA0KPj4+PiBpbmRleCBiODA0MTUwMTFkY2QuLjZkYTliZDZiNzI1OSAxMDA2NDQNCj4+
Pj4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUv
bmV0L2JsdWV0b290aC9oY2kuaA0KPj4+PiBAQCAtMjQ2LDYgKzI0NiwxNyBAQCBlbnVtIHsNCj4+
Pj4gICAgICAgICogSENJIGFmdGVyIHJlc3VtZS4NCj4+Pj4gICAgICAgICovDQo+Pj4+ICAgICAg
IEhDSV9RVUlSS19OT19TVVNQRU5EX05PVElGSUVSLA0KPj4+PiArDQo+Pj4+ICsgICAgICAgLyog
V2hlbiB0aGlzIHF1aXJrIGlzIHNldCwgTEUgUmVhZCBUcmFuc21pdCBQb3dlciBpcyBkaXNhYmxl
ZC4NCj4+Pj4gKyAgICAgICAgKiBUaGlzIGlzIG1haW5seSBkdWUgdG8gdGhlIGZhY3QgdGhhdCB0
aGUgSENJIExFIFJlYWQgVHJhbnNtaXQNCj4+Pj4gKyAgICAgICAgKiBQb3dlciBjb21tYW5kIGlz
IGFkdmVydGlzZWQsIGJ1dCBub3Qgc3VwcG9ydGVkOyB0aGVzZQ0KPj4+PiArICAgICAgICAqIGNv
bnRyb2xsZXJzIG9mdGVuIHJlcGx5IHdpdGggdW5rbm93biBjb21tYW5kIGFuZCBuZWVkIGEgaGFy
ZA0KPj4+PiArICAgICAgICAqIHJlc2V0Lg0KPj4+PiArICAgICAgICAqDQo+Pj4+ICsgICAgICAg
ICogVGhpcyBxdWlyayBjYW4gYmUgc2V0IGJlZm9yZSBoY2lfcmVnaXN0ZXJfZGV2IGlzIGNhbGxl
ZCBvcg0KPj4+PiArICAgICAgICAqIGR1cmluZyB0aGUgaGRldi0+c2V0dXAgdmVuZG9yIGNhbGxi
YWNrLg0KPj4+PiArICAgICAgICAqLw0KPj4+PiArICAgICAgIEhDSV9RVUlSS19CUk9LRU5fUkVB
RF9UUkFOU01JVF9QT1dFUiwNCj4+Pj4gfTsNCj4+Pj4gDQo+Pj4+IC8qIEhDSSBkZXZpY2UgZmxh
Z3MgKi8NCj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuYyBiL25ldC9i
bHVldG9vdGgvaGNpX2NvcmUuYw0KPj4+PiBpbmRleCA4YTQ3YTMwMTdkNjEuLjlhMjNmZTdjOGQ2
NyAxMDA2NDQNCj4+Pj4gLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jDQo+Pj4+ICsrKyBi
L25ldC9ibHVldG9vdGgvaGNpX2NvcmUuYw0KPj4+PiBAQCAtNzQyLDcgKzc0Miw4IEBAIHN0YXRp
YyBpbnQgaGNpX2luaXQzX3JlcShzdHJ1Y3QgaGNpX3JlcXVlc3QgKnJlcSwgdW5zaWduZWQgbG9u
ZyBvcHQpDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBoY2lfcmVxX2FkZChyZXEsIEhDSV9P
UF9MRV9SRUFEX0FEVl9UWF9QT1dFUiwgMCwgTlVMTCk7DQo+Pj4+ICAgICAgICAgICAgICAgfQ0K
Pj4+PiANCj4+Pj4gLSAgICAgICAgICAgICAgIGlmIChoZGV2LT5jb21tYW5kc1szOF0gJiAweDgw
KSB7DQo+Pj4+ICsgICAgICAgICAgICAgICBpZiAoaGRldi0+Y29tbWFuZHNbMzhdICYgMHg4MCAm
Jg0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAhdGVzdF9iaXQoSENJX1FVSVJLX0JST0tF
Tl9SRUFEX1RSQU5TTUlUX1BPV0VSLCAmaGRldi0+cXVpcmtzKSkgew0KPj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgLyogUmVhZCBMRSBNaW4vTWF4IFR4IFBvd2VyKi8NCj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgIGhjaV9yZXFfYWRkKHJlcSwgSENJX09QX0xFX1JFQURfVFJBTlNNSVRfUE9X
RVIsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBOVUxMKTsNCj4+
Pj4gLS0NCj4+Pj4gMi4zMy4wDQo+Pj4gDQo+Pj4gTm93YWRheXMgaXQgaXMgcG9zc2libGUgdG8g
dHJlYXQgZXJyb3JzIHN1Y2ggbGlrZSB0aGlzIG9uIGEgcGVyDQo+Pj4gY29tbWFuZCBiYXNpcyAo
YXNzdW1pbmcgaXQgaXMgbm90IGVzc2VudGlhbCBmb3IgdGhlIGluaXQgc2VxdWVuY2UpOg0KPj4+
IA0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpLmggYi9pbmNsdWRl
L25ldC9ibHVldG9vdGgvaGNpLmgNCj4+PiBpbmRleCA5NzlkYTUxNzlmZjQuLmYyNDRmNDJjYzYw
OSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpLmgNCj4+PiArKysg
Yi9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpLmgNCj4+PiBAQCAtNTUxLDYgKzU1MSw3IEBAIGVu
dW0gew0KPj4+ICNkZWZpbmUgSENJX0xLX0FVVEhfQ09NQklOQVRJT05fUDI1NiAgIDB4MDgNCj4+
PiANCj4+PiAvKiAtLS0tIEhDSSBFcnJvciBDb2RlcyAtLS0tICovDQo+Pj4gKyNkZWZpbmUgSENJ
X0VSUk9SX1VOS05PV05fQ01EICAgICAgICAgIDB4MDENCj4+PiAjZGVmaW5lIEhDSV9FUlJPUl9V
TktOT1dOX0NPTk5fSUQgICAgICAweDAyDQo+Pj4gI2RlZmluZSBIQ0lfRVJST1JfQVVUSF9GQUlM
VVJFICAgICAgICAgMHgwNQ0KPj4+ICNkZWZpbmUgSENJX0VSUk9SX1BJTl9PUl9LRVlfTUlTU0lO
RyAgIDB4MDYNCj4+PiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jIGIvbmV0
L2JsdWV0b290aC9oY2lfc3luYy5jDQo+PiBUaGlzIGRpZmYgY2Fubm90IGJlIGFwcGxpZWQgdG8g
c3RhYmxlIDUuMTUuIENvdWxkIHlvdSBwcm92aWRlIGEgcGF0Y2ggY2FwYWJsZSBvZiBiZWluZyBh
cHBsaWVkIHRvIHN0YWJsZS4NCj4gDQo+IFRoYXQgaXMgbm90IG5lZWRlZCB1bnRpbCBhIHBhdGNo
IGlzIGluIExpbnVzJ3MgdHJlZS4gIFdoeSBkbyB5b3UgbmVlZCBpdA0KPiBlYXJsaWVyPw0KPiAN
CldlbGwgbm90IGFuIGVtZXJnZW5jeSwgYnV0IHRoZSBpc3N1ZSBvZiBCbHVldG9vdGggbm90IHdv
cmtpbmcgb24gc29tZSBBcHBsZSBNYWNzIGhhcyBiZWVuIHRoZXJlIGZvciBhIGxvbmcgdGltZS4g
QlRXLCB3aWxsIHRoaXMgcGF0Y2ggYmUgdGhlcmUgaW4gTGludXPigJlzIHRyZWUgaW4gdGhlIGNv
bWluZyBkYXlzPw0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=
