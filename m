Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F2C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9811A20684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epesi.onmicrosoft.com header.i=@epesi.onmicrosoft.com header.b="CKgeCsY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCFNuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:50:17 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:32476
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbfCFNuQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 08:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epesi.onmicrosoft.com;
 s=selector1-epesi-nl;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJDbslZbLvyuOYKs+Vq6QwwbbX++h34Pi8PuTOUanOc=;
 b=CKgeCsY/qnFqlZSGTf0HBK7iPmeyzgKmuRm+pFtLAuu/uDsnhdbIjXTpNnhT1tNWIIAnK05zCz5yGPrsLI0M8IHuenCTlnu1YY71CzZbCc/tqXhe2RkcOGDVNStOHhcAGP2GanEWu1xzTvlIJ4jBGo5E5ycbyyMj9dbkpvv4GKI=
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com (20.178.22.145) by
 AM0PR03MB4065.eurprd03.prod.outlook.com (52.135.149.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 6 Mar 2019 13:50:13 +0000
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::b52d:89da:34f3:4c7e]) by AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::b52d:89da:34f3:4c7e%3]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 13:50:13 +0000
From:   Marco Okker <marco@epesi.nl>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: iBeacon with the dbus advertising-api
Thread-Topic: iBeacon with the dbus advertising-api
Thread-Index: AQHU1CHSqxY9Xp3vEUqJ4XS3ZqXHOA==
Date:   Wed, 6 Mar 2019 13:50:13 +0000
Message-ID: <AM0PR03MB5076E7A27AB448DE6E97B248CE730@AM0PR03MB5076.eurprd03.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=marco@epesi.nl; 
x-originating-ip: [82.176.84.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf57e324-e74b-4140-1901-08d6a23aa80d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM0PR03MB4065;
x-ms-traffictypediagnostic: AM0PR03MB4065:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR03MB4065C06113641C00FFD28A2ACE730@AM0PR03MB4065.eurprd03.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39830400003)(346002)(366004)(376002)(396003)(16614003)(199004)(189003)(5640700003)(106356001)(2351001)(6306002)(105586002)(52536013)(6916009)(55016002)(186003)(71200400001)(71190400001)(8676002)(74316002)(486006)(476003)(9686003)(305945005)(97736004)(26005)(53936002)(7736002)(86362001)(316002)(5660300002)(966005)(508600001)(14454004)(68736007)(7696005)(74482002)(102836004)(81156014)(6506007)(99286004)(2906002)(81166006)(6116002)(3846002)(25786009)(14444005)(8936002)(2501003)(33656002)(6436002)(66066001)(256004)(185383002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR03MB4065;H:AM0PR03MB5076.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epesi.nl does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR03MB4065;23:MTmIVPzq33DhIbvWfulJDvh/e+jboNHSHBmknkM?=
 =?iso-8859-1?Q?ZxQl6452Ou0yWFrORmxgwo4vs3oij/13vOrWaIGat0h0XXhQ3R/p0TJLNB?=
 =?iso-8859-1?Q?1Hh9oxczM5RsVO097h3iGu/OS4I4JqCVjIbLwZhQnjrWx8rY7nAtHKxOA1?=
 =?iso-8859-1?Q?1Xzf2fevhLJ4iGKzuzCn98uqOGVkYoieayzQTTUB2UjNs2sOUIpdy1SQUg?=
 =?iso-8859-1?Q?Ge6cs9sXpQ/aKAEmQ4VKMh3h8g7qJBBu9P3Katgp+zWZYmBHNzT8XjgkUh?=
 =?iso-8859-1?Q?h13H3sPjtoKcWXLz0RyLOtZGlbSf+jfWQk5oqn8+0/9zREBhMGLzpuTpai?=
 =?iso-8859-1?Q?mgTAGsAqxLa9avMHoWWncCXEUkPwb4tfXGuArIePAv/hyTzZ7XOpK03tS7?=
 =?iso-8859-1?Q?GSCN7HhC/pJpkgioBcIVY8+kYu785Rmj5e1LwpegYy87UK/joBgFvMoazt?=
 =?iso-8859-1?Q?EpKrVM5qOe2Tu8Agcrm7Q/habARP7wJdAR0yf7zm4u8EIJyUSWa8TCwdNI?=
 =?iso-8859-1?Q?raPalqwPPZYm+v1/FbOxoipfAkqShjb0gB8eGOdEGVJ1yphtILTQ7zu6Lz?=
 =?iso-8859-1?Q?/lp9XpBAxane61GIoezn5t+VFs+yVxhvZ92D6a7R4OwMQmOPNBniT7Nx9l?=
 =?iso-8859-1?Q?fi3PfiQJn81lEMpEJBpVAXAzTX5DSvs9heQnmCRgoZTwrASkq+biunITA9?=
 =?iso-8859-1?Q?LA0+J0PQUSmJFOzpfqHLjJtFo7mXS+g0vkiTT8oPphlmuz1YDs3M6KvFgp?=
 =?iso-8859-1?Q?VbQpykbaMMsT3GhLWejxPlcL7OoyAZfEuxUS41NvGJmBvyR3iGgrzcBF9+?=
 =?iso-8859-1?Q?ahp2kN5CBFiD2FTkmdQrh0hgTvZFTrlnrjPTT6x93SGnJQ/Oaw/Xzb4aqE?=
 =?iso-8859-1?Q?IiS+12g8fsooToponF/XtCl/fvfsMrmzmQaNEAO47m0V8sWsH3mR9Su0fs?=
 =?iso-8859-1?Q?HMUsL+b83HPeS54Er17DXaSCbP5SCMfbUlzesmeaOyp/3O7lXmqmz1zU1d?=
 =?iso-8859-1?Q?fpUGBIFn3wsv1zYeFYc3a69fJBRgXmhl5Bvs2gaXqsDrBP4jYPymUOofSD?=
 =?iso-8859-1?Q?OxBYM3XAm4XieK5Cu1omMooizhuDCd+Pcan1SKcawprP0wmoh3gP0Z4ByM?=
 =?iso-8859-1?Q?xckCsa5gKSE0QMruJJ4YTa0q980dHEZsZTKCmYI1hFZ6rE2THmJOh91MA8?=
 =?iso-8859-1?Q?Zhi6TL311xPlPNfRMCxQTG/AL0dQE3am4MobCiFR9dBMvwlbf2I3nNguNE?=
 =?iso-8859-1?Q?Hu/0GCrJAo/Ql6YRyKj7kJI6feV50zuRxzL2EoeeqgrdT8O3LPw7QpTO+A?=
 =?iso-8859-1?Q?ME=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3G0QLGh9Yr8ppWac4kQQ8pEng0qY15n9/HzdNWREJMbF0LiUlm2FcTIrv18YaoA+1xrU0rm4nO02ctoPQIraGoVuKCcuUqDD1mV8S/2xhW96YlYNc5V2nUYj/8A0XgLL/9snaGd3l5c36uDSSVchDplyAOQ9FwawohqB4J+bfdhPr0oBzdoHiBbCE+SESzvGTbHEOkIfVT9zqVcpBk9V0C6kY/sY/IbayTIFqf6vt/Ax3X5QxnUdsvciaGRWagZD5ycGFhl4sVPJgx7Hlc8Fna793om1/nTvuK+aBH9z90IZ7ahS/uA/DKJVPqWMPTUdoe+4grtgP3PUfph+GxibrjvLdtw/TVbjU4aZcYsOIwzEjvCzfeSqxHQZBOL7X6kkL5EHAHfyp/yiJQlGO5n8qyYIkRRCQybcFY9XESGdqRI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epesi.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57e324-e74b-4140-1901-08d6a23aa80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 13:50:13.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccd82b35-1f74-41b4-b97a-fe64afc988f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4065
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Bluez advertising-api developers,

I got a problem with the advertising-api. It seems to be impossible to make=
 an iBeacon advertisement with the api.
I know it can be done with my bluetooth module because it is possible with =
the hcitool*.

An iBeacon sends the following at the start of an advertisement: 0x0201061a=
ff4c000215.

With the advertising-api I am able to advertise a big part of the iBeacon(w=
ith the manufacturer data property):
0x1AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC

If I modify the bluetooth config(/etc/bluetooth/main.conf) setting "Control=
lerMode =3D le"  it will add  0x020104 to the packet(this is the closest I =
got to an iBeacon):
0x0201041AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC

However I can't make the api advertise the following(the most important par=
t at the start of the advertisement(0x020106) can't be done):
0x0201061AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC

I have tried all properties of the advertising-api, none of them seem to be=
 able to add "0x020106" at the start of the advertisement.

To summarize, my question is:
Can you modify the dbus advertising-api of Bluez so that it is possible to =
advertise an iBeacon?=20

Greetings,
Marco

* hcitool example:
############################ 02 01 06 1A FF 4C 00 02 15 # Apple's fixed iBe=
acon advertising prefix
hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 FB 0B 57 A2 8=
2 28 44 CD 91 3A 94 A1 22 BA 12
(Source: https://en.wikipedia.org/wiki/IBeacon) =
