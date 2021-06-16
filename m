Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DBC48BE8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 11:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3ABB610A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 11:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFPLYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:24:50 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:41440
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229546AbhFPLYu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 07:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3A4I+N/thnoK+SqQHzAWg1aEMnRLi6Ydu92xRWy5QbJ8ANrC4jEIcMnndvBwGfKwzkhx1ndKcvOxNorLjR/2qqOubmsCP1uKFIHJl/1wWVzUINSU3/VvwoHoMjRZxFXqvQeJFdeSfoYnX6mfVW3v+/JnwowP/uRF7VgBaK3o+FgUAiUMMZYegUJD48PouWU7t0dnR/FR+C0b3JN5jyGYAEvDiUCb4gIdijip+3UWi0J8ywdNt/A2AebvFlV2znJI0rL5Yy7Ttg+rT8JVvuUHvcBlXT0+KTIyKOzesN0sDk4UPCNcHOgYnQT2lruRy21XIM6dBX+oJ2+hrDTQ5s7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAKIfsxyv/MSvSHQ0ihc5x5PaEPZzQe9MVi0UDiLolw=;
 b=VPQtXket17+1MPb8cjxvKjR4gn+3dMzo8RHK+MEcVxrp7S0hD2rMqb/8W1KMP3ZVWA9MF/3ZDPDbR4ixBZJJPvRsWkNAsC+oRP04nbBV7XKsi6reba+21cgnSNle9XnnzbWVfNsh9dInYiv9u0kJfK/R7vhNSsHFrxceoiv7xwh6DI/sn1S+Fho59UMeYYMrcF3D2jU8APSVwueD6GWalMffqMay9toCKUs3o0/1uKeU7N+XeuvPHNarbkLy2veYhBYafVvHiCFLK6PLODYv/jWdXouv7lZYkZPJ8BzKp0anlsPinb8S2oiJOwXIiD5f6xY/TGuc4GVY5aJS+pEkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAKIfsxyv/MSvSHQ0ihc5x5PaEPZzQe9MVi0UDiLolw=;
 b=R2WjscJfdC5Ykh0eMNcxSGPwLe25zAgWk9DqUMSO3ao9yTgEsQclOnPtpLKhRjVRpNUvn8vd/sG88slZVsso+kWj6lvCxbIohan913+xlnkV9nSMthwkaWnS9GDxyQTR8LMr3/pBYMxvTc/2q9f4w9efsShN8ZR3Y3yTrxPz5tA=
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM8P189MB1185.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:237::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 11:22:42 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%9]) with mapi id 15.20.4242.018; Wed, 16 Jun 2021
 11:22:42 +0000
From:   Sebastian Urban <surban@surban.net>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [BlueZ] gatt-client: Check length of notify multiple op
Thread-Topic: [BlueZ] gatt-client: Check length of notify multiple op
Thread-Index: AQHXXsDDtvdahQizY0iOmJt0Vv2EA6sWhh+w
Date:   Wed, 16 Jun 2021 11:22:41 +0000
Message-ID: <AM9P189MB17301A7C6ADE3457B06BA26DAB0F9@AM9P189MB1730.EURP189.PROD.OUTLOOK.COM>
References: <20210611123021.21211-1-surban@surban.net>
 <60c35cbf.1c69fb81.4ee39.fc1c@mx.google.com>
In-Reply-To: <60c35cbf.1c69fb81.4ee39.fc1c@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
x-originating-ip: [2a02:8106:216:3a01:45d3:a51f:f94e:2cee]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a527c7-8234-418e-3bee-08d930b90e9d
x-ms-traffictypediagnostic: AM8P189MB1185:
x-microsoft-antispam-prvs: <AM8P189MB1185C292DCE5FC7688FE266FAB0F9@AM8P189MB1185.EURP189.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24F2NGNMwilXTVHK4pxcYlPjUS4zZqcapmIrlNI1HGXLWGNk+IAJmeZcja75U8by288Q/siCySzBENV5awBW9FGP1anr100GVWCIpM95dBZNH8ISA1aq4KfjjQFPxhJ6Mt66crgYaQWVDgaxnVoSfpRxW96zoYEt81Y2//SFiKojz5l+AR+JHy9vWI8q6V+6hfh7bKQC2jZKW1SUFz1KLs4LwGCtPaPlY+Ob5OEGi0jadzoMiSXb+8CTjna0WOBi1rq8bmRgCA/5BRFz/YKx5Uh5GZ8nkTjlVUEdLjL4hmuvpXky+EZEhMjq3DVyCP8EDKTuiqtNeWO6wDYFmwptf078GeMnfPAIGdPKv+OFPmgUfD45Hwa3cE0LxAmzgJ22KCtV0m11lMOn9EHuglHrCBLq82mU8S3/WTr7fxMTOZM6VN1uRXO5cv/obfKKLbudkUKT04jDWgiL/XRZVIk8AzRFx8nVuwVcCarnxfjaO3XsdC5CweN/Ywa67dU3Qn99VdixpFnPCygWrsBTntadGFHh0YAlWnz249J8Wrt+CJfmib8CK8oYjSO7OiudE7pHAVHLQyP/A2TLA9oR9n1mPvfWJy9wzG3v4Hpja3GUaMm2P6XSlI0YXSpbLaOXNDcTHWJzWXpIQGNrVX+SwDsp4EbaQKJJCIz05YL/k0N9ZSubrXCNYZY5oYW5l4NqTQt4f88ciY9RaadPMd6v3hXmLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(39830400003)(376002)(366004)(346002)(122000001)(53546011)(38100700002)(83380400001)(7696005)(8936002)(6506007)(86362001)(52536014)(6916009)(478600001)(5660300002)(55016002)(64756008)(33656002)(66556008)(316002)(66946007)(71200400001)(76116006)(2906002)(186003)(8676002)(66446008)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAqzvGodhH3huvDXLLLQA25+O+wDxcee0yzm+6dIWo4Np9cIryHxsUXjvleC?=
 =?us-ascii?Q?M/vN7wtNEnq0PyxQGVDDCc2OOsJ7EWiSNRcd/uYvoRg/HdCYFeld/DitfyJh?=
 =?us-ascii?Q?wZ5+uqextB9DpZDWOsG4Eor7f5JCNnbcudAuUx3JmSc1eiK783OvBMc69jL7?=
 =?us-ascii?Q?mChx6hKj+MP7bXzYRetGkk20SIsi5yyKV0i9jisoyMK2RQLwUWzEdpMU8yZE?=
 =?us-ascii?Q?X5nZHFm6aAC8bYYrSKt7xFWZwQOL4vXwOKAtVALuMbHLQIreBfolceyvRWRp?=
 =?us-ascii?Q?h8Pbg8G7o7wqqiv5RhOIuTTV+M+o853NFr7pq5p9dNGPS8MIqvCuNvrZpPgi?=
 =?us-ascii?Q?sXO+TuXNotpvBsFC2vaZ6Kqmxg8XwNobvaBHtld0FinaAFPl5ma3UcinAvjG?=
 =?us-ascii?Q?ISTx+LgjGRNFNlmRXeiPypR321JxSPpW1fUuBI6Nj7DkTLJa/b/Vatfn7ory?=
 =?us-ascii?Q?qNPJcJeBQOfxrEORJz9gPs6kmgpDtdjOgkxJWPKFCz83SOsoSn8BwINmGD2W?=
 =?us-ascii?Q?wec3JsfXnVela6oIQWjT7C0pc1TiBMJ/jGLDH+wCI2KIOQp/fqcsKxnqABO8?=
 =?us-ascii?Q?gZcaBE9vEH/MQ1gOxfIvkF1gccKIw4jqrRh55sQeRtjRsSLEgNpr3O6PVLin?=
 =?us-ascii?Q?lpH8t8qXc5toMM3Dj2sqZV/SRinrVllVH+a/sGBKk15uOGuKlRe6TV0FAw0H?=
 =?us-ascii?Q?vVOAeY050Wy+vFsNLOhHjvuEVQ+N/azrQfzJUEWgefXxiHD6pladrXE+dpbj?=
 =?us-ascii?Q?nYI7Fowv8EeQoemDgIkF7vdaSjVV1APNEuUvyLAcyElh3Z10S4RFZBqGhz6Q?=
 =?us-ascii?Q?fdoVvoGht7B0jmr9WjZkEoErDougSQ96GJQqnQtDbcmj2XJ4xHVOwufve2F+?=
 =?us-ascii?Q?LDTH1LXggnShrpq+dKF/f6IcyOqTWHsI8DB99h+cLY3DX8YusJipc79n2Phj?=
 =?us-ascii?Q?1HzEEqPClISKUyrcIHqYDJuaA7Zm/GqDID9tcGLkm7QGYBMVeSCVxfPRqBuz?=
 =?us-ascii?Q?UIB2TsaABb7WcS19Sy/mHj4H7ECLeK4CGdwdBGattMfwAJsdXG1StAQeong0?=
 =?us-ascii?Q?2oTz7GyWTftOwPpYHHubQxn9ndAEiXG6N/I1kJ1mNzcvckQmGjEF1gOq7L44?=
 =?us-ascii?Q?Uj1mthPqssyKb0/GjK9tY+oFpZEKrRaLkbgntQ7fM4LJtqNoMsAV2Z2VZJFS?=
 =?us-ascii?Q?vemLwWGyiJ0gbUtF9EMlNAuK6XXX4h4Mhi/Wl0W03uO8QKi1A30OTkULfl/U?=
 =?us-ascii?Q?1FgA6JNeSt5ikwC7PzRZ/I09cbl0sZc+yCDUkezIHXG5bPATZj+A8Gioydyo?=
 =?us-ascii?Q?WQoWVNatLhclPA726A9uUOIYrKObLxIiaZnAcApZswKAs3dlsmjc08vGbqri?=
 =?us-ascii?Q?SEU6MIc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a527c7-8234-418e-3bee-08d930b90e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 11:22:42.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O225K5Ny3rJqIsFUX++sULIKomSKQRgZiSM/+mcu59E7cva9g22MqzKXiZ7JUC5rVlSj2gbqs1QZoFGLmZ0sFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1185
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

thanks for applying my other two patches.

Has this one been missed or are there still changes required?

Sebastian

> -----Original Message-----
> From: bluez.test.bot@gmail.com <bluez.test.bot@gmail.com>
> Sent: Friday, June 11, 2021 2:53 PM
> To: linux-bluetooth@vger.kernel.org; Sebastian Urban <surban@surban.net>
> Subject: RE: [BlueZ] gatt-client: Check length of notify multiple op
>=20
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D498=
859
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch                    PASS      0.62 seconds
> GitLint                       PASS      0.14 seconds
> Prep - Setup ELL              PASS      47.26 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.36 seconds
> Build - Make                  PASS      207.71 seconds
> Make Check                    PASS      9.15 seconds
> Make Distcheck                PASS      243.46 seconds
> Build w/ext ELL - Configure   PASS      8.38 seconds
> Build w/ext ELL - Make        PASS      195.76 seconds
>=20
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>=20
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>=20
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>=20
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>=20
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>=20
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>=20
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>=20
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>=20
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>=20
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>=20
>=20
>=20
> ---
> Regards,
> Linux Bluetooth

