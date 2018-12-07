Return-Path: <SRS0=S+MC=OQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C2C07E85
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B520892
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=targetsg.onmicrosoft.com header.i=@targetsg.onmicrosoft.com header.b="wVd7vOWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0B520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=target-sg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGIkN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:40:13 -0500
Received: from mail-eopbgr60100.outbound.protection.outlook.com ([40.107.6.100]:30306
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeLGIkL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Dec 2018 03:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector1-targetsg-com01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crTbIcVzxyV7WiEOYHELbis2XCd2uQAbeHgXwqfS0jM=;
 b=wVd7vOWpej4di/TibsQEm3VncpWoNkK8203B8atE/FWR6jAwtxGSuDp+RNl5/3ZrRa7icbXpzTIP1Ag3GT13qooWkdpaHxP5O8Jibw20rYUzuSSXXW8HVl0bD5KUBZsExI2SthztSwJ+jgLEOnCW8hgUB1sar+ULMfg4A1JyYY8=
Received: from VI1PR02MB3856.eurprd02.prod.outlook.com (52.134.25.143) by
 VI1PR02MB4864.eurprd02.prod.outlook.com (20.177.202.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 08:40:03 +0000
Received: from VI1PR02MB3856.eurprd02.prod.outlook.com
 ([fe80::887c:440d:f515:379d]) by VI1PR02MB3856.eurprd02.prod.outlook.com
 ([fe80::887c:440d:f515:379d%4]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 08:40:02 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] adapter: Fix storing the IRK on first boot.
Thread-Topic: [PATCH] adapter: Fix storing the IRK on first boot.
Thread-Index: AdSOCC4oYRDES2FhRR6682cOjgBPlg==
Date:   Fri, 7 Dec 2018 08:40:02 +0000
Message-ID: <VI1PR02MB3856F0C3AED16B014F91C0D9C5AA0@VI1PR02MB3856.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kai.ruhnau@target-sg.com; 
x-originating-ip: [2003:c5:1703:7600:dc93:f7e2:a42f:280d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4864;6:p2/CvEfyBn5xTZ6JzKjFiNL16H2CiXFTljzmRuUV7Er7xEbpaoP8f9sW0dpWxZLO7BZsNhfhp73fMb6TKXhhGxNBKJSJQ9AxMfynrG9hepliwtuIP+RYZ+UTmfbnG9Z6Tagk1eJnDfxJDavETWJ21QQFyjrJ0FXQ742QZf6YXB1d0TABNrY4X1FzaaiU0lSdJ4ibuPAiHgWnoAlnWpv2MSequSP8O1nWN8k7QgIdACQ704k7IknaQHYF8ooASMr2aa5UHmIao1LwTUzHg15WeWIJY//F0wXeALHsAWg2PhTZ6QadJXf1W4hR1VKznbEF7aBIKirT+uF0PLwU2mUNI5KtUYfqnTp0thR9YdMW6ZPv/MgHrU8Qz2EEUBrg+QHfDB50fH1EzwuGXT25ZOoNolkULUPQZ+RScmvgG3rlD5+4J/CTzVjpaYi9KDgQxDd5Jxpqb4To3A8IPfKHpdWRtA==;5:BLPWpioE90clCvKzIiFreyvoFf4p9m3bik+Qn/ZKcgShDJPWvLUjZ/Kvm43e85KMvtGE0UrNA8tYVRMpLSpchuA1uJeIklBaRciIZs7kPRFXJ1AFBct+oqs/D1W5Tiq9EkBox0HlVL+h3Th32DNlVYtK6l4sNfALtToWoNYMK9U=;7:l0W9R0QdvMz+dnAHbd7aq584y8zWo8mf96xgHXZqXIceh2e52M9MJSkP+Ginfqutv/+LQySgtCGVa99fwxHAPoMF/wTCqjK3zAxD/k7UcUm25rCW3DpC+5rWTV5LB1zz4bw8IgWfFTk3AhJ9ebLxag==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 107efbf7-d7e6-4752-8204-08d65c1f94ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4864;
x-ms-traffictypediagnostic: VI1PR02MB4864:
x-microsoft-antispam-prvs: <VI1PR02MB4864E1B7143027038CC2E8F6C5AA0@VI1PR02MB4864.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4864;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4864;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(366004)(136003)(346002)(20264003)(199004)(189003)(186003)(256004)(7736002)(99286004)(71200400001)(71190400001)(6116002)(316002)(33656002)(5660300001)(102836004)(6506007)(74316002)(2906002)(97736004)(305945005)(2501003)(7696005)(105586002)(68736007)(86362001)(81166006)(14454004)(486006)(9686003)(81156014)(55016002)(8676002)(5640700003)(8936002)(2351001)(6916009)(106356001)(6436002)(53936002)(46003)(476003)(25786009)(508600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4864;H:VI1PR02MB3856.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: target-sg.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oc5K6Iij5s3LxM0kbcmpy1MtDxf8E0ZZ/K75HLRHl7V5vb5Tya+qK8sd3Zk3lcYIFnw6jo7rUMTJ1H+rV/aXTyH/hfjenUFz2yEMxx1zFPCpbV0Ypv2skAeyI5F+MHDcqYqwPXC5Udr5YUS+Ad0RuYCv62irMfE/X7E544fGJAwiTYMLeU26nIaQ1T2ibHYWvlX4yWj/HbRtDGZdndWIqLiCCCRhl/QHzBWcwMLSlTJfJOArdTPMIuBVzw/nsIScOz3cTEuJwib7QRoMNnbOBheTjKUMIvwAT3TEFYw3tTCRSZvMG0ApblpIBvAJijP9DVB0+MGa57HzUPGMj4JkS+g1xLQ8hwLpZOLfrnuCtTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107efbf7-d7e6-4752-8204-08d65c1f94ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 08:40:02.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4864
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RnJvbTogS2FpIFJ1aG5hdSA8a2FpLnJ1aG5hdUB0YXJnZXQtc2cuY29tPg0KDQpnZW5lcmF0ZV9h
bmRfd3JpdGVfaXJrIGRvZXNuJ3QgY3JlYXRlIHRoZSBhZGFwdGVyIGRpcmVjdG9yeSBhbmQNCmRv
ZXNuJ3QgY2hlY2sgZm9yIGVycm9ycyB3aGVuIHBlcnNpc3RpbmcgdGhlIElSSyB3aGljaCBjdXJy
ZW50bHkNCmZhaWxzIG9uIGZpcnN0IGJvb3QuIFRoaXMgZml4ZXMgYm90aC4NCg0KU2lnbmVkLW9m
Zi1ieTogS2FpIFJ1aG5hdSA8a2FpLnJ1aG5hdUB0YXJnZXQtc2cuY29tPg0KLS0tDQogc3JjL2Fk
YXB0ZXIuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc3JjL2FkYXB0
ZXIuYyBiL3NyYy9hZGFwdGVyLmMNCmluZGV4IGMyNDQzMjEyNS4uZDkzYWUyNjE4IDEwMDY0NA0K
LS0tIGEvc3JjL2FkYXB0ZXIuYw0KKysrIGIvc3JjL2FkYXB0ZXIuYw0KQEAgLTM2MjMsNiArMzYy
Myw3IEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfYW5kX3dyaXRlX2lyayh1aW50OF90ICppcmssIEdL
ZXlGaWxlICprZXlfZmlsZSwNCiAgICAgICAgZ3NpemUgbGVuZ3RoID0gMDsNCiAgICAgICAgY2hh
ciAqc3RyOw0KICAgICAgICBpbnQgaTsNCisgICAgICAgR0Vycm9yICpnZXJyID0gTlVMTDsNCg0K
ICAgICAgICBjcnlwdG8gPSBidF9jcnlwdG9fbmV3KCk7DQogICAgICAgIGlmICghY3J5cHRvKSB7
DQpAQCAtMzY0Niw5ICszNjQ3LDI4IEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfYW5kX3dyaXRlX2ly
ayh1aW50OF90ICppcmssIEdLZXlGaWxlICprZXlfZmlsZSwNCg0KICAgICAgICBnX2tleV9maWxl
X3NldF9zdHJpbmcoa2V5X2ZpbGUsICJHZW5lcmFsIiwgIklkZW50aXR5UmVzb2x2aW5nS2V5IiwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJfaXJrX291dCk7DQotICAgICAgIHN0ciA9IGdfa2V5X2ZpbGVfdG9fZGF0YShr
ZXlfZmlsZSwgJmxlbmd0aCwgTlVMTCk7DQotICAgICAgIGdfZmlsZV9zZXRfY29udGVudHMoZmls
ZW5hbWUsIHN0ciwgbGVuZ3RoLCBOVUxMKTsNCisgICAgICAgc3RyID0gZ19rZXlfZmlsZV90b19k
YXRhKGtleV9maWxlLCAmbGVuZ3RoLCAmZ2Vycik7DQorICAgICAgIGlmIChnZXJyKQ0KKyAgICAg
ICB7DQorICAgICAgICAgICAgICAgZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUgSVJLIGZpbGUgY29u
dGVudHM6ICVzIiwgZ2Vyci0+bWVzc2FnZSk7DQorICAgICAgICAgICAgICAgZ19lcnJvcl9mcmVl
KGdlcnIpOw0KKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisgICAgICAgfQ0KKyAgICAgICBp
ZiAoIWNyZWF0ZV9maWxlKGZpbGVuYW1lLCBTX0lSVVNSIHwgU19JV1VTUikpDQorICAgICAgIHsN
CisgICAgICAgICAgICAgICBlcnJvcigiRmFpbGVkIHRvIGNyZWF0ZSBJUksgZmlsZSIpOw0KKyAg
ICAgICAgICAgICAgIGdfZnJlZShzdHIpOw0KKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisg
ICAgICAgfQ0KKyAgICAgICBnX2ZpbGVfc2V0X2NvbnRlbnRzKGZpbGVuYW1lLCBzdHIsIGxlbmd0
aCwgJmdlcnIpOw0KICAgICAgICBnX2ZyZWUoc3RyKTsNCisgICAgICAgaWYgKGdlcnIpDQorICAg
ICAgIHsNCisgICAgICAgICAgICAgICBlcnJvcigiRmFpbGVkIHRvIHN0b3JlIElSSyBmaWxlIGNv
bnRlbnRzOiAlcyIsIGdlcnItPm1lc3NhZ2UpOw0KKyAgICAgICAgICAgICAgIGdfZXJyb3JfZnJl
ZShnZXJyKTsNCisgICAgICAgICAgICAgICByZXR1cm4gLTE7DQorICAgICAgIH0NCisNCiAgICAg
ICAgREJHKCJHZW5lcmF0ZWQgSVJLIHdyaXR0ZW4gdG8gZmlsZSIpOw0KICAgICAgICByZXR1cm4g
MDsNCiB9DQotLQ0KMi4xOS4xDQotLQ0KS2FpIFJ1aG5hdQ0KU29mdHdhcmUgTWFuYWdlcg0KVDor
NDkgMjAyIDc2OTMwMiAxOQ0KDQpUYXJnZXQgU3lzdGVtZWxla3Ryb25payBHbWJIICYgQ28uIEtH
DQpIZWluei1GYW5nbWFuLVN0cmHDn2UgNA0KNDIyODcgV3VwcGVydGFsDQoNCkFtdHNnZXJpY2h0
IFd1cHBlcnRhbCBIUkEgMjM4OTgNClBlcnPDtm5saWNoIGhhZnRlbmRlIEdlc2VsbHNjaGFmdGVy
aW4NClRhcmdldCBTeXN0ZW1lbGVrdHJvbmlrIEJldGVpbGlndW5ncyBHbWJIDQpIZWluei1GYW5n
bWFuLVN0cmHDn2UgNCwgNDIyODcgV3VwcGVydGFsDQpBbXRzZ2VyaWNodCBXdXBwZXJ0YWwgSFJC
IDI1MzQ2DQpHZXNjaMOkZnRzZsO8aHJlcjogSsO8cmdlbiBTdGVpbg0KLS0NCg==
