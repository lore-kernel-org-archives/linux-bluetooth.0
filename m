Return-Path: <SRS0=h2kO=XN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D152C4CEC9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE020640
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=awoxsysadmin.onmicrosoft.com header.i=@awoxsysadmin.onmicrosoft.com header.b="Sfxs5kZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfIRIWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:22:32 -0400
Received: from mail-eopbgr90075.outbound.protection.outlook.com ([40.107.9.75]:46284
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfIRIWc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Sep 2019 04:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4IWv26giKwsGEBC+/kz3f6Oy2UC4EVnGbSjpghvK2kWrGDAwbWcm7fcJHLIXFKb1iX3qO7vvdojuzsIoYGzc+t7Ge3MPr9MqgTRp8Roqky/HSjEVPO/qkZ+bkP1pevbIRRv+zgkgMKTTgVyFqoi/EPItbN7raPr8VkZ1oZ+Q3k5DyygKjZYUKWV4gTNqppSTt2OPGKuqKqjWH8hiLy8LibMt6I39xHMd5zMQal0XSa7lIRXE/PC67eMrlkTtql6AkEhE3Zs1asHJhzU8IUzTW6WF5pmtb0h8WqO4DEyU5+XncRAo4u8vd+Oq3NnBMTRBa4BOD0RoWDyXsXhlVCjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXLN1F4Wssfr+svrEuelelcdXWWS7wiMjsF53oXw3Wo=;
 b=iYIqOqRgGEx/Usl7v1DKY8/U3HZBiwWqDkAcJclWPUfiiKGjYdGDEQvkblVWCgPD7pyLJNxs7sMWVdsur3BEFHLtvlriyz0SchPhJnHYXdebmt61lIlYQkcOvPwsLFIJzQe0UbFbH8o1E9kHBy1V3oWWgF8XVNzKBDmzcbk6BkQmaWAn3o8mtSBUBS06rQMjHG9sh3Vwct2OPzX4H/02iPIiNynj4LhmdyblULKhM3jYI6CVAjHIp64U8izbtDU+KJZvL0TXCeB9qctLUEa0/qwUsGMBozFoo7e7GqJUArSVOUnGu2TyGZuAOqrs0076pJmglBxgYCAZLrU9r8oNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=awox.com; dmarc=pass action=none header.from=awox.com;
 dkim=pass header.d=awox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=awoxsysadmin.onmicrosoft.com; s=selector2-awoxsysadmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXLN1F4Wssfr+svrEuelelcdXWWS7wiMjsF53oXw3Wo=;
 b=Sfxs5kZiHbgc2Fw1OLE+HdxwFVTaD9gtActJC6XdW6FVGSpX97aC62nkAS5S8eb+eomfC8YHRt2WZyzQOf9GGjlbFsFvoTpmxdRsTFYYM7HbaUDe7SODFTwHKTqEdyuQwv6fWsQ9YLgCjQwR01UAW74It0XKbP5zQ4I4QANqR/g=
Received: from MRXP264MB0871.FRAP264.PROD.OUTLOOK.COM (52.134.45.140) by
 MRXP264MB0245.FRAP264.PROD.OUTLOOK.COM (52.134.47.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Wed, 18 Sep 2019 08:22:29 +0000
Received: from MRXP264MB0871.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1cd:e111:1daa:f06c]) by MRXP264MB0871.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1cd:e111:1daa:f06c%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 08:22:29 +0000
From:   Jean-Pierre Garcia <jpgarcia@awox.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Typo error in bluez mamagement API
Thread-Topic: Typo error in bluez mamagement API
Thread-Index: AQHVbfo1Im3bxMyvu0eMOUPToT32eA==
Date:   Wed, 18 Sep 2019 08:22:29 +0000
Message-ID: <b1e9be5c-a07e-e40f-8a66-1ffef2b88468@awox.com>
References: <20190917212702.35747-1-abhishekpandit@chromium.org>
 <20190917212702.35747-2-abhishekpandit@chromium.org>
In-Reply-To: <20190917212702.35747-2-abhishekpandit@chromium.org>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::16) To MRXP264MB0871.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1b::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jpgarcia@awox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.205.6.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c04aa0da-530c-4a53-05a8-08d73c115846
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MRXP264MB0245;
x-ms-traffictypediagnostic: MRXP264MB0245:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MRXP264MB02459785CE0A0F18F8F079E5B18E0@MRXP264MB0245.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39840400004)(346002)(396003)(189003)(199004)(66446008)(3846002)(5660300002)(2501003)(6116002)(8676002)(86362001)(2351001)(31686004)(8936002)(7736002)(81156014)(81166006)(508600001)(2906002)(186003)(25786009)(486006)(26005)(36756003)(305945005)(2616005)(446003)(256004)(11346002)(476003)(14454004)(52116002)(71190400001)(66946007)(71200400001)(66556008)(99286004)(966005)(386003)(102836004)(76176011)(316002)(6512007)(6436002)(6306002)(64756008)(66476007)(31696002)(6506007)(5640700003)(66066001)(558084003)(6486002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MRXP264MB0245;H:MRXP264MB0871.FRAP264.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: awox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O5i/cmKjbEc0HFCJzmmPFFUzicp6cY1JCQaIJ2OJbpNVJKOrAjhAEO7xLJ3avuszzgmoJbLj4qKJiTZ+J0n8uhipHnifwozW72wjzDLt3x9R5b/nV52CW318AS2Ybwcac4+J03/1J6lVBkHj5c3326izSS/QKiXI5iQnYfuBDGmDtzcf2sCfE9+U4kl1B+YHKGzVMYxVS8mZWe/KoQde0cPOyAxVE12IBU4H/TNtR93dF93ytv6YbQAtmPPTfm359pCaTF+DJl9XsnavES4PMy1Q/RvnQ4GriwqBMDT9iZYP7/GYZkbcOfAT3ZaXmUMch/3z59MJHPeYkpZ2gep/KOix5jxVpYNFRh3CI9aZ95pi38OMhipThHE1oM+G/xnhuJrUakxJjIR96WYb/S32P0MQKFf/DOvNWWApGSBU4kA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <5AE3C2098A9A0B4396B507135E38A06E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: awox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04aa0da-530c-4a53-05a8-08d73c115846
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 08:22:29.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 701a3a00-22d6-432f-9c74-04a817c0160d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V61Kin6t63i/mz31FSjxAWlC6cIvyWYyP3dNmQhl7V7Lmmlluc3nPONqObrw99//tdoWCezvmpPXAE38foQ+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0245
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Found typo error in=20
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt,In=
=20
Set Appearance Command, command code is 0x0042, should be 0x0043.

-
