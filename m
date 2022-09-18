Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16E8C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 07:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIRHOB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIRHOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 03:14:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2014.outbound.protection.outlook.com [40.92.99.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5B205EA
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 00:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKVkvx242JGynRxwwBSdz6AY3/bMQ7+SiYeAD21lnw2sC6wvI4XxGNDEbCLq4w1eFlNmOFi7OfdXdtFGGm0+0IgEvPFFO40Do44ErtynZRS48lSofTbUMpSOcMlsHp+qI77J18u7lyejqyNAkclsclU9w4FRRM0KNyMP5GNllNLoIHId3PyeQC1EiDLnZD+qT1WUTm7J1ynj6kUhhWYrfBzAiC7x8ZjQRqWzRc8/BmeGCZmwAjRjHOI76NxgBxUNhhPhVdKM6f4yoXs4Hs2UbICw/NDUVAJxhhxNejK2SfgQMEnU6OvfaHSzQo8fdjx6SFBhrETkGrrFDSY+j0ig2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKq1nZX4wEFe5gSNXHmnKuxPUIKmStLdlwQlCks++SI=;
 b=g1UU8eLcWL4L/+VkaLmn9vU96/IqF2HZaK3vTP9aOHJjxA173SWvyUuj6HsieWWI/orAfaCBo4HCRvrF/TzzlPNwVpk6v4zJDKPprZc94cze/+v24eM8FkxigJuM+LGEmPuhmuYl138r89Z7arbI0gBqlt5+gNsf0J04jR7O1eRwROnG9hOEhMfS3g2olsWYn81l6fZW2JLZOHF+yCFPpeUixzTpaLMrKcZGq1Sk4cXI0g/wzxjMo4gABdglfZVfO28UdQaAFDH3t8KHsQ+2seZj5JnsOBmg94845eUtTn5YANlPs2NYhGoVWVVkbt90QTNJgAOX4v2iIKCRFkm2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKq1nZX4wEFe5gSNXHmnKuxPUIKmStLdlwQlCks++SI=;
 b=glcAX9/sh/oDvFf1Jnn30T4hYIK6bj5TCZMOmtrCmyqAxma5p0tvR9auViig/DMXqqSa/98iJyEBOseupVAwkKdkcwn8Cy/neB0YhMaUvwbjoPdCbaXN3o/ywazRsDdfIq0CziP1vnkOMY1LXDqea96+0yr+R5BZSgW1IeE2SCHuuniWzYeCySKdNEOaLPN7ZEsb9muOlpRr2193kQqaROqhSQuGDpWjVH3KbtJHdw2XI+d5+EQoEFFnhNGBsW2Ae6AHEO0K2YywV2xXZiM2uPB0mlI6+8R98aQCKdcwr94RwBj8V0VOrRMWayc20CL0jaMtRz/CNi+gFkodkRhtjg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB2424.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Sun, 18 Sep
 2022 07:13:53 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77%4]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 07:13:53 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855
Thread-Topic: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855
Thread-Index: AQHYyymWUjBM/+876U+yMAuoafIyeq3kwDmAgAAFwRI=
Date:   Sun, 18 Sep 2022 07:13:52 +0000
Message-ID: <TY3P286MB2611180EF41ADA1FB154F5EF984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
 <1ace324d-f2ac-f59c-3d21-8d4ebe2fb148@molgen.mpg.de>
In-Reply-To: <1ace324d-f2ac-f59c-3d21-8d4ebe2fb148@molgen.mpg.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [IeKJP4EteuXNv1wscTqWuf3jX5CcMk/szNlrpMWHmJc=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3P286MB2611:EE_|OS3P286MB2424:EE_
x-ms-office365-filtering-correlation-id: 220d74bb-5a80-4ac4-47b7-08da994557bf
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHL81qx25kw56Igrfc282oHIePSQgXy4IV1K+NhFGPgkqPifKf/FwBAkVkmWj3zoMcCvD9U+0CSfrRjQy8eofxep48cpm7QFmsIDmv2FePFsnybB9V7edb67aJiup3XXP4kilBpWQdXn1tmk2eN579AohodmQvoYtZU0YqwdlpXXR1qJF5b/gihq/IDGXNc4gzXVRq4Dy4OWVKclT8Zp3v+At9QNd+wHr1XhNiK3thJK3PWrtblXuaOwlaSOySYbGFRFSFuYBoNhggecl4EB+A9P1cgkjwl60EnbuImQjls9CYwXy27WgP9gmDcHR/mPh6pLh9YVX0aDNA2VvYN/7SNJs7ruDijkLjC6fd+V39bVVTAYx+eb/riFmSKYxXUkqIyjqP4o4XPuASpFGDBex5tmRBG0AVsmL61Ha7CSUw2vQGFtNq3ud0Z+zGnsk1WkyYYHLMAXPHHSH21bsDYgs2xaD0hoGvxeofF0krNC2iuuAJtdS5XdontCdQllruP59nb30b10jSmRIIcDHGALclH4ZXiqN5rfcFJPQhzc2sHgtxWPS68l0kBNoIKZse5K6l3p8gNuk+XMcz9YL6qhxzy+1c95luSFXwOhI1Jl2VT2xfNPitMu2v+YSWiDYrIOurB/Tp2eFQu/uEag9Z4oq85pU7PVpbC928/GIDRReDd3H0gPK96HCMgqoiq9Cfxg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?e3f8xPLietNCsali4oXEixJcK4lWwXn1IXnpXPZaFnYrabIrae0B0s/g?=
 =?Windows-1252?Q?/f1TW4myaLPmnL1aNnrhSLwDa0UZQX2OJdM23a8fe1Hqx1MUYvO1mi1Y?=
 =?Windows-1252?Q?Ltfxvw0pbiAEhqrmbzwBY9ePq3fKLC/fjAxu0ohRzsmPs7MBXaAmhcHo?=
 =?Windows-1252?Q?B5ApQIA9TAyjI4kbLL+aeZspRtrDwLDp28NlXfos03e8bNJWN87Kq5b3?=
 =?Windows-1252?Q?hhs62RZ5rbz0Q7dOTD94GiFgfrityRzKHTBJChtu7ABlpxGBJahOiLap?=
 =?Windows-1252?Q?OS3s1a5ZZuI/57CmKCc5mqyo2UdeCUYZeUz4clHYSAJ/26pyXyN6IG5p?=
 =?Windows-1252?Q?7J0W0TPgzeLotjmPgrVuPpA6N8mqAVGHtOv8mSqgyCyy7BZvnJCEieVO?=
 =?Windows-1252?Q?58QUWN7zmhsMgaEMFa3Qd8yuNCUnAVENr8O88yzTeURSDbsfdCLmGY0k?=
 =?Windows-1252?Q?clqN/fHBLUteEPWPMQhewBixvkbAXxjELecWMlXwKqcTLx+de2RdFRdn?=
 =?Windows-1252?Q?QuZcIv0LEjNTub7pt3z+4oyrWhzKIfpq3kzN7i67yy0zRn48fkUFXy42?=
 =?Windows-1252?Q?EI2h5qccwHVRiD0YGDefuwhg8gtRxqfzWsrD/12e8YXsQE0aXM0xobvr?=
 =?Windows-1252?Q?x+NAfE8jS3eGoYvG39w5gcBvThTEnV4HJrua+vtpBeHVsuWBK9PxmSxn?=
 =?Windows-1252?Q?+iYS9IX3OwcDyc679cBZi4eG9mCwrhWJ5h/VvmUtXTZ0583R3FvzZlA2?=
 =?Windows-1252?Q?kwLYvqwr2JcJBtyiLxMu5Z2bywqeTqzlbQBW0i7i1OhUMclaojVaL9zx?=
 =?Windows-1252?Q?Wz10tlX08H+T42QqLHd6M/5XJAVB6qY2X2Le1vKgjNbR1s66HEFjLij5?=
 =?Windows-1252?Q?M+gl+gBAMga8FgaOgChcQDmf52tZzepU1cnutqtQb2baYrUAUDC5Cm4D?=
 =?Windows-1252?Q?Rjul1YSNyo3Dhl0cBB0RckA/J26UbPsp6OQtpt3mUp+6IgiNeP+VmN6y?=
 =?Windows-1252?Q?jGn/+Z+tUHCep22qWzNg8G7YDVdmT1gX4AyNhhpLA1/h75waatubR2S4?=
 =?Windows-1252?Q?yWCkQ6xclnCXNt99eajtCiO1mt7tOX1yULURpdlEFYWkxWZoZV+m2xRv?=
 =?Windows-1252?Q?6kBKZoVzsTjl0zzvGJ8lA2ZaSgn3CICejLzrxz35pL2Tgz0DQPF9HSfr?=
 =?Windows-1252?Q?fiJ6aXgXKhZrpLBCv7Dpdd1g/Zfx8p5wYVDfjMD2+6uUJhDBhRLJPsSP?=
 =?Windows-1252?Q?RXGHYHjI1VdaxNLgUDT1m0YJhthQD9XdJm3pekKcUhnbJykDUDz/MqEW?=
 =?Windows-1252?Q?AgiXfBJKgpV45N6XtO3QD4JVNnNhn3ROoFKjfHVOhzgL4ywBNtWJxSBB?=
 =?Windows-1252?Q?8JJXt2Tmv/I4rg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 220d74bb-5a80-4ac4-47b7-08da994557bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 07:13:52.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2424
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for your advice. Driver version is 1.0.0.1205 (Windows 10 driver).
Should I resend a patch with modified commit message?

________________________________________
From: Paul Menzel <pmenzel@molgen.mpg.de>
Sent: Sunday, September 18, 2022 14:52
To: Shengyu Qu
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855

Dear Shengyu,


Thank you for the patch. Two nits below.

Am 18.09.22 um 08:38 schrieb Shengyu Qu:
> Add IDs to usb_device_id table for WCN6855.
> IDs are extracted from Windows driver of Lenovo
> Thinkpad T14 Gen 2.

Please reflow for 75 characters per line, and maybe don=92t add a line
break, or add a blnak between paragraphs.

Please add the Microsoft Windows driver version, and maybe the location
(Internet Archive URL) for reference.

[=85]


Kind regards,

Paul
