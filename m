Return-Path: <SRS0=UWae=OV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB53C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DD22084E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 09:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DD22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=target-sg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLLJnR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:43:17 -0500
Received: from mail-eopbgr80095.outbound.protection.outlook.com ([40.107.8.95]:23326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbeLLJnR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Dec 2018 04:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector1-targetsg-com01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Tp7Vdadcx1jl3GWMcvPxXTm8iN8xD/pZQP4u8u7+bc=;
 b=hdg1OuJQBtC8tnXMXtXCoY+cn/gAeY+e3f3mYGycskeQ4Fes6+7WwOQuOCekmAAIdGDBPfMWFe5O7itTe/PB/51uYHb8nvv8H50t/8zve+3kojryY7/K6X89tyaEDaypJRBhQdQ65M721DPfhwmSlRem7kxNFKBYLZw+UrsqEf0=
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com (52.134.80.26) by
 AM0PR02MB3972.eurprd02.prod.outlook.com (20.177.43.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 09:42:30 +0000
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::2160:b53d:b508:7bd7]) by AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::2160:b53d:b508:7bd7%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 09:42:30 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: [PATCH] adapter: Fix storing the IRK on first boot.
Thread-Topic: [PATCH] adapter: Fix storing the IRK on first boot.
Thread-Index: AdSOCC4oYRDES2FhRR6682cOjgBPlgD9oTbQ
Date:   Wed, 12 Dec 2018 09:42:30 +0000
Message-ID: <AM0PR02MB3841F981781246B5E2C3BD17C5A70@AM0PR02MB3841.eurprd02.prod.outlook.com>
References: <VI1PR02MB3856F0C3AED16B014F91C0D9C5AA0@VI1PR02MB3856.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB3856F0C3AED16B014F91C0D9C5AA0@VI1PR02MB3856.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kai.ruhnau@target-sg.com; 
x-originating-ip: [2003:c5:1710:b100:24d4:b1ac:b912:2389]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3972;6:+4xga7Bo/aPC9c10AZdQyypbH3ktmtruMMc482C7iMKabB4/R42awFGSB92EOFdSgFw+BuZd20AUj+BNjVMzvzjU7EfIYMs7viiCUfB26kgfYvNufA+1JWV3udcbXXPCguTUg8ol1nZU58eLXMKD1AnWN5UqexdYi+DKgM2Tgx8+I+fx7o2wSZXoDL/Dawh9yZ+/qFKaLQxr9WX9JAhfjvGn8qw63LchDH1LbrQ0qp1I9FzwRIhmCxp0YMcrcuDnDQPun3cc4PYNl5G4P5+Je9NSh2TcWTMlzu0nrYMlINpp0r5FtEnYAcOWw2TRHLMH4DczXp5HvF2psrppEWNeZ/Ze8Bhy+d3BmCOfsjNC49Ymmz++Kdz6OoCQMeaBynlQHJkSkAbdn57upaoaYO7nKrBSYsMeInf+Qu4C2wu9wnQluWWW/YJZBkTRPtHE4Zjlptsil1w2nVY2zGSihI75Tg==;5:OrghzuPbSTQ8fB90Kl1p5wh679chdJeRkhB/NWMIixEm8+xrpgvagdlsjGie/9lq1rbMBs57ay54aS1ML+/ffdciFzRJh2V8nTljwE+pfeeHy5oVGigQPU0iyLFBAGV/f5VNwmV6O3J1dcf50ClK5h4ZOaEeVplkuzh/0KQrGvU=;7:XqTnJBzyBEn1Lnw1W7yN3eYrw3nBjc9GVHRroNLpxodkNEMuJ7ugjMXir8Qa0QHh5M44ik9hGXJF/f3AnyfdO2gv5Obj/zVhyOgscyUE/eeo+ZDORYk2jSkpeAGLVui8lZWBfDkQYsVNEfyUob5F6w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5450ac26-4ee3-4147-09a7-08d660162285
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3972;
x-ms-traffictypediagnostic: AM0PR02MB3972:
x-microsoft-antispam-prvs: <AM0PR02MB39721E6627E686BFC99FA42CC5A70@AM0PR02MB3972.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR02MB3972;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3972;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(396003)(376002)(136003)(20264003)(189003)(199004)(71190400001)(105586002)(46003)(71200400001)(86362001)(6116002)(106356001)(6916009)(102836004)(7696005)(14454004)(186003)(508600001)(6506007)(76176011)(2906002)(97736004)(66574011)(99286004)(25786009)(5660300001)(81156014)(5640700003)(74316002)(305945005)(81166006)(2501003)(44832011)(33656002)(53936002)(486006)(316002)(256004)(446003)(55016002)(7736002)(8936002)(11346002)(9686003)(8676002)(6436002)(68736007)(476003)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3972;H:AM0PR02MB3841.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: target-sg.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cmyXVEAyACit/yvaUvFEGinQDkPVjZJEjCGfqS8mPZfEjznHXh0hXB0GngMjO0bh4Wna0+teNMZXYD7qgemMgMYvZVm9UCCuOavujp+iTbJod+m/sPNW8OCkT/85SVc7D12s3Yy4SsGTs83BgckxHPVr/hIe/McOWmUlxiLTuc1eYb1eHuBuLTCYVjvHTgirvSwShIiat8ewX2OyR1iRRESFluKIACoA68ljHVevzFp0RtIFggMsm96EuQP3piMJ7Bom+rYTxOlb1yPc2RHAcV2Zlhd60D24fYaxxjIyUfBAUYIeDW3mvh8O5xJ0IBgm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5450ac26-4ee3-4147-09a7-08d660162285
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:42:30.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3972
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCldlbGwsIHRoaXMgaXMgYSBiaXQgZW1iYXJyYXNzaW5nLCBidXQgbGV0IG1lIHRyeSBh
Z2FpbiB3aXRob3V0IHRoZSBicmVha2luZyBleGNsYW1hdGlvbiBtYXJrLg0KDQpDaGVlcnMsDQpL
YWkNCg0KRnJvbTogS2FpIFJ1aG5hdSA8a2FpLnJ1aG5hdUB0YXJnZXQtc2cuY29tPg0KDQpnZW5l
cmF0ZV9hbmRfd3JpdGVfaXJrIGRvZXNuJ3QgY3JlYXRlIHRoZSBhZGFwdGVyIGRpcmVjdG9yeSBh
bmQNCmRvZXNuJ3QgY2hlY2sgZm9yIGVycm9ycyB3aGVuIHBlcnNpc3RpbmcgdGhlIElSSyB3aGlj
aCBjdXJyZW50bHkNCmZhaWxzIG9uIGZpcnN0IGJvb3QuIFRoaXMgZml4ZXMgYm90aC4NCg0KU2ln
bmVkLW9mZi1ieTogS2FpIFJ1aG5hdSA8a2FpLnJ1aG5hdUB0YXJnZXQtc2cuY29tPg0KLS0tDQog
c3JjL2FkYXB0ZXIuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc3Jj
L2FkYXB0ZXIuYyBiL3NyYy9hZGFwdGVyLmMNCmluZGV4IGMyNDQzMjEyNS4uZDkzYWUyNjE4IDEw
MDY0NA0KLS0tIGEvc3JjL2FkYXB0ZXIuYw0KKysrIGIvc3JjL2FkYXB0ZXIuYw0KQEAgLTM2MjMs
NiArMzYyMyw3IEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfYW5kX3dyaXRlX2lyayh1aW50OF90ICpp
cmssIEdLZXlGaWxlICprZXlfZmlsZSwNCiAgICAgICAgZ3NpemUgbGVuZ3RoID0gMDsNCiAgICAg
ICAgY2hhciAqc3RyOw0KICAgICAgICBpbnQgaTsNCisgICAgICAgR0Vycm9yICpnZXJyID0gTlVM
TDsNCg0KICAgICAgICBjcnlwdG8gPSBidF9jcnlwdG9fbmV3KCk7DQogICAgICAgIGlmICghY3J5
cHRvKSB7DQpAQCAtMzY0Niw5ICszNjQ3LDI4IEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfYW5kX3dy
aXRlX2lyayh1aW50OF90ICppcmssIEdLZXlGaWxlICprZXlfZmlsZSwNCg0KICAgICAgICBnX2tl
eV9maWxlX3NldF9zdHJpbmcoa2V5X2ZpbGUsICJHZW5lcmFsIiwgIklkZW50aXR5UmVzb2x2aW5n
S2V5IiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJfaXJrX291dCk7DQotICAgICAgIHN0ciA9IGdfa2V5X2ZpbGVfdG9f
ZGF0YShrZXlfZmlsZSwgJmxlbmd0aCwgTlVMTCk7DQotICAgICAgIGdfZmlsZV9zZXRfY29udGVu
dHMoZmlsZW5hbWUsIHN0ciwgbGVuZ3RoLCBOVUxMKTsNCisgICAgICAgc3RyID0gZ19rZXlfZmls
ZV90b19kYXRhKGtleV9maWxlLCAmbGVuZ3RoLCAmZ2Vycik7DQorICAgICAgIGlmIChnZXJyKQ0K
KyAgICAgICB7DQorICAgICAgICAgICAgICAgZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUgSVJLIGZp
bGUgY29udGVudHM6ICVzIiwgZ2Vyci0+bWVzc2FnZSk7DQorICAgICAgICAgICAgICAgZ19lcnJv
cl9mcmVlKGdlcnIpOw0KKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisgICAgICAgfQ0KKyAg
ICAgICBpZiAoY3JlYXRlX2ZpbGUoZmlsZW5hbWUsIFNfSVJVU1IgfCBTX0lXVVNSKSkNCisgICAg
ICAgew0KKyAgICAgICAgICAgICAgIGVycm9yKCJGYWlsZWQgdG8gY3JlYXRlIElSSyBmaWxlIik7
DQorICAgICAgICAgICAgICAgZ19mcmVlKHN0cik7DQorICAgICAgICAgICAgICAgcmV0dXJuIC0x
Ow0KKyAgICAgICB9DQorICAgICAgIGdfZmlsZV9zZXRfY29udGVudHMoZmlsZW5hbWUsIHN0ciwg
bGVuZ3RoLCAmZ2Vycik7DQogICAgICAgIGdfZnJlZShzdHIpOw0KKyAgICAgICBpZiAoZ2VycikN
CisgICAgICAgew0KKyAgICAgICAgICAgICAgIGVycm9yKCJGYWlsZWQgdG8gc3RvcmUgSVJLIGZp
bGUgY29udGVudHM6ICVzIiwgZ2Vyci0+bWVzc2FnZSk7DQorICAgICAgICAgICAgICAgZ19lcnJv
cl9mcmVlKGdlcnIpOw0KKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisgICAgICAgfQ0KKw0K
ICAgICAgICBEQkcoIkdlbmVyYXRlZCBJUksgd3JpdHRlbiB0byBmaWxlIik7DQogICAgICAgIHJl
dHVybiAwOw0KIH0NCi0tDQoyLjE5LjENCi0tDQpLYWkgUnVobmF1DQpTb2Z0d2FyZSBNYW5hZ2Vy
DQpUOis0OSAyMDIgNzY5MzAyIDE5DQoNClRhcmdldCBTeXN0ZW1lbGVrdHJvbmlrIEdtYkggJiBD
by4gS0cNCkhlaW56LUZhbmdtYW4tU3RyYcOfZSA0DQo0MjI4NyBXdXBwZXJ0YWwNCg0KQW10c2dl
cmljaHQgV3VwcGVydGFsIEhSQSAyMzg5OA0KUGVyc8O2bmxpY2ggaGFmdGVuZGUgR2VzZWxsc2No
YWZ0ZXJpbg0KVGFyZ2V0IFN5c3RlbWVsZWt0cm9uaWsgQmV0ZWlsaWd1bmdzIEdtYkgNCkhlaW56
LUZhbmdtYW4tU3RyYcOfZSA0LCA0MjI4NyBXdXBwZXJ0YWwNCkFtdHNnZXJpY2h0IFd1cHBlcnRh
bCBIUkIgMjUzNDYNCkdlc2Now6RmdHNmw7xocmVyOiBKw7xyZ2VuIFN0ZWluDQotLQ0K
