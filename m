Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA245C48BCF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EF561073
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFLJbZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:31:25 -0400
Received: from mail-eopbgr80123.outbound.protection.outlook.com ([40.107.8.123]:15142
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229819AbhFLJbW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jun 2021 05:31:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0a1g3Y69ycPJT3b7+mw1r7Kd/k0lGyGrgnpkh12PvpYV79aiRjWWfvQo8aDVoALFFZXI4LrUicL4c67u07McdmXkwhVcp20ECGXH3eFBMcNMZH85zMbfTtlcB7XqZk3t/3VRojjBotBjf/Nt8QQLwWA+SiHZo+U1kledylbLu3pl8c1LiUwdNPdWnSJBXyPxpu1jXahwLI0rVyaeRPX8zters9Ni7kQWtMJk/3uvWx7F6HQnLoC/mkBP7v3ZM5ZoivxgIYS9/mtbiEigbfiKZsLa9rndZbukV1a0JQ7XQxOEaTkipzQhB2KpVkTDUjGTwfCKNtgAe1k22hqUdPSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq0ze7tJLieb9nMY6rTox1Ma22puyl1+0srX+bNOcm0=;
 b=T+dRAklU8fZUQ3zjtFGYjJzPAt4QI9V4DdTe906dMmjS0AoOYmJvrVIUyfEYBqRo/VugxdPl5EUiI+oF8TnbzCzqAgmIwJfe6KolOADSmUDSffolK+6XULMfZ6H0KX7rRRESAp4gVKM4BGspq/27oaE7vz4+HBFsYHhwb/5j1CdIwvTJwFyUgB77cKAbrCIxRmjdQU6j/ouWd/qApqGLBUj86YgiUYCYmSTbwq175Zmz0rtumJi0BwvChPVfStxgo6JfRTZRmnks4GK3XMbk3QbU6OJBrHixCyIQlUPTphZ7zxlblZilG4k31AzJL6dPt8KMsmf3V8PN/ZXiyTdnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq0ze7tJLieb9nMY6rTox1Ma22puyl1+0srX+bNOcm0=;
 b=LsxRivhO5HM2PpzS5FuPwtvhXL/E1CUgZiLqje9xkB2MohsSOmxYsrweRpWsSgWIEkBjFRQzFuWXf3AdJUyGVgs9pB2rvqpvGMYsvgueu/LZKvJWZS36AUB9cS5BNLE86gqihNf4dPFRJSH05U+U44PQUPRsCkpoY0TmRYGKOBk=
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM8P189MB1331.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Sat, 12 Jun
 2021 09:29:21 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 09:29:21 +0000
From:   Sebastian Urban <surban@surban.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full
 and fix overflow
Thread-Topic: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when
 full and fix overflow
Thread-Index: AQHXXr1pQdosRDf4QkisESCAJ/i9wqsPYGyAgAC8LIA=
Date:   Sat, 12 Jun 2021 09:29:20 +0000
Message-ID: <AM9P189MB17301B2D375E4180FCABF610AB339@AM9P189MB1730.EURP189.PROD.OUTLOOK.COM>
References: <20210611122915.21068-1-surban@surban.net>
 <CABBYNZJBbiBvw+r1XLxE5=uXVv3cXe8EpCd3YOF7ZQVmDGxyBg@mail.gmail.com>
In-Reply-To: <CABBYNZJBbiBvw+r1XLxE5=uXVv3cXe8EpCd3YOF7ZQVmDGxyBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=surban.net;
x-originating-ip: [2a02:8106:216:3a01:24d7:cb89:89f8:e532]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da253aee-9db4-4861-bcf7-08d92d848f28
x-ms-traffictypediagnostic: AM8P189MB1331:
x-microsoft-antispam-prvs: <AM8P189MB1331AFA638905F8CF170BB4CAB339@AM8P189MB1331.EURP189.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANTu8zlN3YOHzIa8xsgASBgWf5L23Zho0ygb7zQb4HPoRq8yxshbjGS6z10TnHRvpk0ad0yM9L5f2vUKi8SKT2UubPCo9/dTJ76uvDcu/bBCPababVs8GkAHcAmLjO89j0X9VIezo6GKk7S6klqt9stTHbbvnyoVMMdhg/a+UkllZdvnsgbVuXQfArbTQrlFwt6XmzR/p++mJiJO/vPA10qT4sCm+LrGKvCVtEDMXWGRg2rqCGjcLQ/cdwnD07xBEjC7E+tmRkUXlPBe4AAWiIL6Su5wH6W16JJpcw2IgwjArfdtS4mnbNwfSSnMhftbKatjkkcDm/U4r3iO+s/fDcZCnnxhLRjktOySe/JShDS78dbTHLo2wicxAA3SFF5KVnWKzukr4vPosY+GPrh9wqFtJgKFKNNoGfKSJI5V3R1wIo+IL2Aq39ZCmi57+dyBLwpHG7xu5qT9nJhI86JMG+VImjD24/Varl15mgtq7pwBXQLjQ1spnHVDDI5+wlJuGROn7c56mFFWaDHtDHgtgwM1wKRfKJTGCOL0/0BCTFQsWXgETmX30TpyGIL8JcKBB38giX5sk1L2/mliM1+XTHyTuENdFtBnSgWW3icjbKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(376002)(39830400003)(316002)(52536014)(186003)(86362001)(5660300002)(55016002)(9686003)(71200400001)(2906002)(33656002)(83380400001)(122000001)(66476007)(66556008)(8676002)(64756008)(66446008)(4326008)(66946007)(38100700002)(7696005)(8936002)(478600001)(6916009)(6506007)(53546011)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNBVVVsakoxRXNaOXU1dkx5SXBkS2xlQVRtVUJaQnVvWldoMnJKT3BMYlpv?=
 =?utf-8?B?UFZ1ZlhGWmV0Y1RIelRETENXUUMwcVNvekZ4b3ZuS2tTT0ZwKy9TdGcxVXVM?=
 =?utf-8?B?b282YWR0ZFRmQkV4TUllQ3M5a2RJeGk0YnI3Tm5EQU9jUTM0WnBMK1hDcFhq?=
 =?utf-8?B?eml0MkRMMGpSZUpwWHJhQjdQQW5aUllwSnNiR0RCYjhxS3hCYTVRYXZEQXMr?=
 =?utf-8?B?N2RMZ04xRVBPSk5Lby9iVm1FUGJBZC9QM09wcEIxQUZmY3NZOEVVaHVEbE12?=
 =?utf-8?B?SjhIRUxkUlhXQUZNak0xbTRxcFhvT2xyYlZBbTl3OWhsaWxHOEVyQStIKzI3?=
 =?utf-8?B?NHora2tNNCtJU2ZvekFSd0JtZTBTRHNrNm5xVzNKL1p6V1NSTWpyZTYxZnZk?=
 =?utf-8?B?QTRnaU5MZXJoemRQR3JGa0hqR2FJU01EbzB6bGJxWUV5Z1Z5TkJFYnMxUExr?=
 =?utf-8?B?QUora24xRENZMDg0a21LeVB4TkIwbFBKbjNwcGlJSUVJQllFbkUyK0VkRzAx?=
 =?utf-8?B?T0FYanJoTERpaTdIOTV1OXJFTnB4YUE5THJRbWpkS1YvSmgybFlGM0ZJRXZJ?=
 =?utf-8?B?Z0NiNzFtK2thcjFiTFV1NXJtN0Vibmw0VTR5ZVo2blk3S3FqcnRYQm1aNW43?=
 =?utf-8?B?eUN5UU9KekJZc3ZuMDB4a2x6KzhqY2FLRFBNeEUxZFFXbmpodHJHOFk5bkM5?=
 =?utf-8?B?dVFjdlorYk1oaVNlbjVNMnlxYUk3SXZsUmRkZnVZbmJjSkNGZzM0TTQvQUlC?=
 =?utf-8?B?L21TYWNEZTJWWHZWQys0dHRUYTZ4clpuRnFYOEkxaGtLUTRYN2dHZG9ocmxD?=
 =?utf-8?B?Q092MVZSdGNmZGJuc0xqbGIyczJhZG5WekR4ZGZzRW1WMStJeExhZHdpbE1h?=
 =?utf-8?B?d2hQbHNUVjdNN3N5WldzNnZGUFlRWVZBYXpOYm5MOXVUdThUWk1zYTc4RVM4?=
 =?utf-8?B?dGkvYjVCMkJjWXpJSEZ5SFE1d3NaMHNjMUFpMkZmdXBxNWUwaWNBa1pIdS9s?=
 =?utf-8?B?RlVvREovZ2ZiV1FsWnEyb3VOMFZPdjhZMkU5NzRpQXlNSjI0NVh1bHNDTzJu?=
 =?utf-8?B?Z2lNS2MvNzY0TU5BWU1sNlBFNlNWeFJJODRjd25ydUR2UytkeFJ2TW9zSWxR?=
 =?utf-8?B?aDBKb1plWFdBRUVYYTVOYnd2MG1rR0dCWWsvbFRvZlVMK1ZnYjZNVlpTOUFk?=
 =?utf-8?B?OG4zYzYrb3dNUm5RaU9JUExkakpqVUdJYVdZd3FzOXo3ejM2WGNWdWwydkxs?=
 =?utf-8?B?M1BydC9Ld1gvdVN0RGR5aklNSU5DZHQwRVhLMjNKT2N1NWZHUUxxYTFCUlJk?=
 =?utf-8?B?MFRZZ2dLTndSVmZiMjR0cFdQdTZEbUU2L1dyNzgvSnJrUm4wVTB4UUszVlky?=
 =?utf-8?B?RDRhcjZRZ1pFOTlsL1EyUlN6c0Z6Njc3SUdXUk1IRzlXSHlXWnlxbDdSbmsw?=
 =?utf-8?B?Q0ZMN1lvUzgvM0pMbHEwbEEvUU5peUFoajdra3QrcXNTSk1iNDVyRmJPZU9t?=
 =?utf-8?B?RFBkeGN1T0lkbDdMZ1hOVE9wS2M5dU5kSlVaaGw4UGMxMlgyUWhBYTl0bkw5?=
 =?utf-8?B?UXpGYmVNTHkxY3lsSkh1VjhRREZ0OGtjN3Z2YUZQbkxrdEpTRnEvWGpwSVdi?=
 =?utf-8?B?bUgvQStlNWxLTmVJem55aERrYUlEV3BDQzJRTmZMaEwySUdSU29qa29VQ2Zs?=
 =?utf-8?B?SldsYXRvOUVqemJlMStpb3hwSXJYYmsza210b2NBK0E5Z3Q1d2xkZ3dwKzhp?=
 =?utf-8?B?cldCemNsd1FKd0NLSGNLeEJ6UTMxUzhnMms0ME52TkpuaG5uZjlPUC8yeXhZ?=
 =?utf-8?Q?72YEou5yyD/+MJUigKakvRx5yN2kZf/oDTiLg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da253aee-9db4-4861-bcf7-08d92d848f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 09:29:20.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrGKeupvM4UaDculRvQlXQobDTwWlrx7BSicxOhDrc+3E0z/+uW5ue4vLb6FPLjFo3QW8aQJFmC18QkKdQI0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1331
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXks
IEp1bmUgMTIsIDIwMjEgMTI6MTMgQU0NCj4gVG86IFNlYmFzdGlhbiBVcmJhbiA8c3VyYmFuQHN1
cmJhbi5uZXQ+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggQmx1ZVpdIGdhdHQtc2VydmVyOiBGbHVzaCBub3RpZnkgbXVsdGlwbGUg
YnVmZmVyIHdoZW4NCj4gZnVsbCBhbmQgZml4IG92ZXJmbG93DQo+IA0KPiBIaSBTZWJhc3RpYW4s
DQo+IA0KPiBPbiBGcmksIEp1biAxMSwgMjAyMSBhdCA1OjMxIEFNIFNlYmFzdGlhbiBVcmJhbiA8
c3VyYmFuQHN1cmJhbi5uZXQ+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBmaXhlcyB0aGUgY2FsY3Vs
YXRpb24gb2YgYXZhaWxhYmxlIGJ1ZmZlciBzcGFjZSBpbg0KPiA+IGJ0X2dhdHRfc2VydmVyX3Nl
bmRfbm90aWZpY2F0aW9uIGFuZCBzZW5kcyBwZW5kaW5nIG5vdGlmaWNhdGlvbnMNCj4gPiBpbW1l
ZGlhdGVseSB3aGVuIHRoZXJlIGlzIG5vIG1vcmUgcm9vbSB0byBhZGQgYSBub3RpZmljYXRpb24u
DQo+ID4NCj4gPiBQcmV2aW91c2x5IHRoZXJlIHdhcyBhIGJ1ZmZlciBvdmVyZmxvdyBjYXVzZWQg
YnkgaW5jb3JyZWN0IGNhbGN1bGF0aW9uDQo+ID4gb2YgYXZhaWxhYmxlIGJ1ZmZlciBzcGFjZTog
ZGF0YS0+b2Zmc2V0IGNhbiBlcXVhbCBkYXRhLT5sZW4gZnJvbSBhDQo+ID4gcHJldmlvdXMgY2Fs
bCB0byB0aGlzIGZ1bmN0aW9uLCBsZWFkaW5nIChkYXRhLT5sZW4gLSBkYXRhLT5vZmZzZXQpIHRv
DQo+ID4gdW5kZXJmbG93IGFmdGVyIGRhdGEtPm9mZnNldCArPSAyLg0KPiA+IC0tLQ0KPiA+ICBz
cmMvc2hhcmVkL2dhdHQtc2VydmVyLmMgfCAyMyArKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9zcmMvc2hhcmVkL2dhdHQtc2VydmVyLmMgYi9zcmMvc2hhcmVkL2dh
dHQtc2VydmVyLmMgaW5kZXgNCj4gPiA5NzBjMzVmOTQuLmQ1M2VmZTc4MiAxMDA2NDQNCj4gPiAt
LS0gYS9zcmMvc2hhcmVkL2dhdHQtc2VydmVyLmMNCj4gPiArKysgYi9zcmMvc2hhcmVkL2dhdHQt
c2VydmVyLmMNCj4gPiBAQCAtMTcwMCwyMCArMTcwMCwzNSBAQCBib29sIGJ0X2dhdHRfc2VydmVy
X3NlbmRfbm90aWZpY2F0aW9uKHN0cnVjdA0KPiBidF9nYXR0X3NlcnZlciAqc2VydmVyLA0KPiA+
ICAgICAgICAgaWYgKCFzZXJ2ZXIgfHwgKGxlbmd0aCAmJiAhdmFsdWUpKQ0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAtICAgICAgIGlmIChtdWx0aXBsZSkNCj4g
PiArICAgICAgIGlmIChtdWx0aXBsZSkgew0KPiA+ICAgICAgICAgICAgICAgICBkYXRhID0gc2Vy
dmVyLT5uZnlfbXVsdDsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICAvKiBmbHVzaCBidWZmZXJl
ZCBkYXRhIGlmIHRoaXMgcmVxdWVzdCBoaXRzIGJ1ZmZlciBzaXplDQo+IGxpbWl0ICovDQo+ID4g
KyAgICAgICAgICAgICAgIGlmIChkYXRhICYmIGRhdGEtPm9mZnNldCA+IDAgJiYNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmxlbiAtIGRhdGEtPm9mZnNldCA8IDQg
KyBsZW5ndGgpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoc2VydmVyLT5uZnlf
bXVsdC0+aWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aW1lb3V0X3Jl
bW92ZShzZXJ2ZXItPm5meV9tdWx0LT5pZCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
bm90aWZ5X211bHRpcGxlKHNlcnZlcik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGF0
YSA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgIH0NCj4gPiArDQo+
ID4gICAgICAgICBpZiAoIWRhdGEpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGF0YSA9IG5ldzAo
c3RydWN0IG5meV9tdWx0X2RhdGEsIDEpOw0KPiA+ICAgICAgICAgICAgICAgICBkYXRhLT5sZW4g
PSBidF9hdHRfZ2V0X210dShzZXJ2ZXItPmF0dCkgLSAxOw0KPiA+ICAgICAgICAgICAgICAgICBk
YXRhLT5wZHUgPSBtYWxsb2MoZGF0YS0+bGVuKTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgICAgaWYgKG11bHRpcGxlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChkYXRhLT5sZW4g
LSBkYXRhLT5vZmZzZXQgPCA0ICsgbGVuZ3RoKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAg
IGlmIChkYXRhLT5sZW4gLSBkYXRhLT5vZmZzZXQgPCAyICsgbGVuZ3RoKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgIH0NCj4gDQo+IFdlIGFy
ZSBtaXNzaW5nIGZyZWUoZGF0YSkgd2hlbiB0aGUgY29kZSByZXR1cm5zIGFib3ZlLCBiZXNpZGUg
SSB0aGluayBpdA0KPiBpcyBiZXR0ZXIgdG8gZ3JvdXAgdGhlIGNvZGUgaW4gc29tZXRoaW5nIGxp
a2UgdGhpczoNCg0KVGhlIGZyZWUgaXMgYWxyZWFkeSBwZXJmb3JtZWQgYnkgbm90aWZ5X211bHRp
cGxlLiBJJ3ZlIGFkZGVkIGEgY29tbWVudCB0byBjbGFyaWZ5IHRoaXMuDQoNCj4gDQo+IGJvb2wg
bm90aWZ5X2FwcGVuZF9sZTE2KHN0cnVjdCBuZnlfbXVsdF9kYXRhICpkYXRhLCB1aW4xNl90IHZh
bHVlKSB7DQo+ICAgICBpZiAoZGF0YS0+b2Zmc2V0ICsgc2l6ZW9mKHZhbHVlKSA+IGRhdGEtPnNp
emUpDQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiANCj4gICAgIHB1dF9sZTE2KHZhbHVlLCBk
YXRhLT5wZHUgKyBkYXRhLT5vZmZzZXQpOw0KPiAgICAgZGF0YS0+b2Zmc2V0ICs9IDI7DQo+IA0K
PiAgICAgcmV0dXJuIHRydWU7DQo+IH0NCg0KQ2hhbmdlZC4gDQoNCj4gDQo+IFNvIHRoaXMgY2Fu
IGJlIGNhbGxlZCBmb3IgYm90aCBhZGRpbmcgaGFuZGxlIGFuZCBsZW5ndGgsIGl0IG1heSBhbHNv
IGJlDQo+IGNsZWFuZXIgdG8gYWRkIGEgc2ltaWxhciBmdW5jdGlvbiBidXQgdGFraW5nIGFyYml0
cmFyeSBsZW5ndGggd2hpY2ggd2lsbA0KPiBkZWFsIHdpdGggY2hlY2tpbmcgaWYgdGhlIGRhdGEg
Zml0cyBhbmQgbWVtY3B5Lg0KPiANCj4gPiArDQo+ID4gICAgICAgICBwdXRfbGUxNihoYW5kbGUs
IGRhdGEtPnBkdSArIGRhdGEtPm9mZnNldCk7DQo+ID4gICAgICAgICBkYXRhLT5vZmZzZXQgKz0g
MjsNCj4gPiAtDQo+ID4gLSAgICAgICBsZW5ndGggPSBNSU4oZGF0YS0+bGVuIC0gZGF0YS0+b2Zm
c2V0LCBsZW5ndGgpOw0KPiANCj4gVGhpcyB3YXMgc3VwcG9zZWQgdG8gdHJ1bmNhdGUgdGhlIGRh
dGEgaWYgaXQgd2FzIGJpZ2dlciB0aGFuIE1UVSwgSSdtIG5vdA0KPiBzdXJlIHdlIHNoYWxsIHJl
bW92ZSB0aGlzIGxvZ2ljIG9yIHRoaXMgd2FzIGFjdHVhbGx5IGludGVudGlvbmFsPw0KDQpUbyBi
ZSBvbiB0aGUgc2FmZSBzaWRlLCBJJ3ZlIGFkZGVkIGJhY2sgdGhlIG9yaWdpbmFsIGxvZ2ljLg0K
DQo+IA0KPiA+IC0NCj4gPiAgICAgICAgIGlmIChtdWx0aXBsZSkgew0KPiA+ICAgICAgICAgICAg
ICAgICBwdXRfbGUxNihsZW5ndGgsIGRhdGEtPnBkdSArIGRhdGEtPm9mZnNldCk7DQo+ID4gICAg
ICAgICAgICAgICAgIGRhdGEtPm9mZnNldCArPSAyOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4N
Cj4gDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
