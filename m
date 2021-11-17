Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1512C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886F463222
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhKQJ35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:29:57 -0500
Received: from mail-ma1ind01olkn0154.outbound.protection.outlook.com ([104.47.100.154]:23168
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235331AbhKQJ3Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 04:29:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCEGtgdvEbhfqsGZnEGg17yRNyrwjeaTa+1jJisa5BI7rng31IEQGtXb+Z7l4d7LZTaldwKofKe4+Pm7ujX9VjKjyBP2VmYsVZgjUQMTN4Zr+Od5TCGUpuAhRnDNBekcce7UntWoUYwzPar5Yme0vA9vvP468Nj4OSxb6AEnt7J8E1sQ5N5MaXjZ1SZxEFYr6u/7bTh2W2umjpOuAd8NLcwVbqAfXY5uCmVr5HIPZu5kKUwwsjeY5c1jM4GMS4RF7OdeCV81GfgPLn7ol9fiho1mP/u6Z0DhZP+5ItttwTljOaIdSJgfFRMOXqh4tWjfPa7J4kGkP4bv73WB2im5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmDzJAVUsVH1fqT/4llVsWdRfXJlBnVFRkL+3ArLQI0=;
 b=cq2bFCEuC+MOxyMwqEZ2FByG+8eC/Kp8UZJr11/fBwj8rHD/fS/5DwE/cgbrbultWchojY12lRGpBNcYh913JA46CJMl2I3YrnLcZROdPZlx79cacStHCHMMFBLf6SWFvKInxRpzgNR1wSuhchyjPMwxa0YPkK6rpOiuDejRRWiDxZHsok4RYTdJcTDMmPAHp8Xv8ATobNxChRmF64p30KM3lOdV/lV+djhwffTAec9g4cmLdUpqmjQfDXG/NQvAB2oc+u2mGVfM0mjhfraH4aow1I9PvJECIm1kZvvMaBox2QwECcW4ntDXYZKAWhLXUe1SDffB1XYwZfmOgitDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmDzJAVUsVH1fqT/4llVsWdRfXJlBnVFRkL+3ArLQI0=;
 b=Q9CdoA/z5ny0ce2l1FzECZnJWupjN3LU+Uazxi7NtLfKMtJKlTXMpqteY+DdGLyjICfUIkOcQk8EPrpP0qEK0mqQzWpS/bgyos9iMCfFE7a7V7vWp85WHX3qeHb01PWi6AT4kuzyqJFCk65unOgATzIw75ktNNRFYmR/jme1sIKUUvMgD3+I4Zxua27NfSKJnNzTebJozoQZLHFizovv8gldi9w0T3Vs+TMzRiUVq9moHXn+s28bxejs2mYcA3e3cThF96HHfqTJ/vlpVej1X2l/RGgOGW08VEXlws7x64E6nrymt1UBXzcUYu8VDI9/WX5YXM8zEF3ubShpvstjWA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4907.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 17 Nov
 2021 09:26:20 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%7]) with mapi id 15.20.4690.026; Wed, 17 Nov 2021
 09:26:19 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwCAAEInAIAAIdSA
Date:   Wed, 17 Nov 2021 09:26:19 +0000
Message-ID: <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
In-Reply-To: <YZSuWHB6YCtGclLs@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [WqG5evZUJa/CDmRv4S+bxWaRHRUlhEppyoWgiRcVVQZ1OGKJhGTyzVL1r8+Ixp3c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8933110e-79e1-4251-7bb8-08d9a9ac503d
x-ms-traffictypediagnostic: PN2PR01MB4907:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpWk3dKR5QY/GFfegvI/Gw/XgJYgDidk9nKimd9HZG0i9YIwmYW5FcURqfKNdy0Ojd51SwLMLU76blohrNLrUNj8vuUwmT0qSWlR638rf21IYDaKNmmZ+pexWK8KgAI00hrcWYS7rCIPe7IJBuuSvnY9HS5HHJpE1LBUFo3davCVyRUAcOVh5tNwPSxRfE0CsN1WLOLDjk73ZfmJDpQeapnh5xrwFaW403sMVEkWc9dAK2UT9nEG7Ih3Y+sKTWwvl4j1ledX0V/f6ayopLUloMViTMmeA73fxIVB1wlKeQ88HW9ZuKlfqPtEtR8M1W4Dy3PxdHye2LOSLJi0KZJwjSP/BTjadxwp8Lre2Hsa3IOuQd5h6gKqdpHZ6ZI/1kneMLWFClq8AUJLIoaIQCKMMrbhwkY5BILM1m6bVw3XyGXtGcdsj4BBfeRYdpstB0PsUukOV3lj3oIk0P886PIvvvqV+5Hfxh/JJfN1BZY98P9ENpu9Uyb2pIU7rDEcfefGVjMcqsMbndyUahnE5ey2gkUvDAz34PW1mIeIkKCuEJY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: nsXyhWKssRmAG9LB3iYPyasoBZCAgtzn+T0L6aGRW96E+2BKhmqoIa7cdG1A5qT97OE4vXS4zPEJMkYXLMsGNb71cV7BUu8q5h03Nw2vKXgEdeOCLXkNHitUABeZB3rmQwekSbmhNArV1yecKHubedPaW5ZsYnhYaoQpmaqt0hIXjqzCkt7nYhDdAJ2+NUvMZwZbw+1m68tp3tyMAjuzU5wBLLP5ogCQ9ES4reWQjmSGJfmXuYSI1vva5tldiuxMm1lqeEsiDYvF0n4TSkOzAGwjhRa3CodWOnYYAkDofLWBOumVzCy5z3yx/iFgrgdDZlCxIfeiyWwY3BCuxGcc8iuubEefq1wCJtFxigy7JSRuiCV+KL9W13vzBc1oQGmy0768+6/MUJaT/WS1ihGBVQt00//iZRe6JHgSrB0L5A0edWOulb8ZxDU9CBcsP+YIiZn0lv5vhJKgyFAntdcshSvZN4moN4zIwt5oUvGQSnjPSFg/QTwUER8M9UJMEJp73FYn5lSGHi7FTL/2V4HGS4NHAyP3WO3Kl0oWUNosnOvvT7n+LzzjmLjR/XRyxa4O8S5ZfaPRqrnFt1yGhsgsMeqMNK2sLC1Ge9Nmy62hWB5+now0Rs7420dUH6IU4QY2mEG6nNhqFBnVWtVe4rLLBipF30fgjlw0+npv3oZC7RU653xAQ+kZbGHIlMNpUkQL9lnvx4Ve3ettnNTkhg5ZmDNkdk1+2Yng70IKouFMT0hhCWnZmAhhYUxGEiIqYiaIPu+7PgdDor0c8arkjbr08g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05903473223C6B4CA98C271074E41F58@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8933110e-79e1-4251-7bb8-08d9a9ac503d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 09:26:19.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4907
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 17-Nov-2021, at 12:55 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Wed, Nov 17, 2021 at 03:28:29AM +0000, Aditya Garg wrote:
>>=20
>>=20
>>> On 16-Nov-2021, at 2:56 PM, Thorsten Leemhuis <regressions@leemhuis.inf=
o> wrote:
>>>=20
>>> On 16.11.21 10:02, Orlando Chamberlain wrote:
>>>>> Bluetooth maintainers, what's the status here? The proposed patch is
>>>>> fixing a regression. It's not a recent one (it afaics was introduced =
in
>>>>> v5.11-rc1). Nevertheless it would be good to get this finally resolve=
d.
>>>>> But this thread seems inactive for more than a week now. Or was progr=
ess
>>>>> made, but is only visible somewhere else?
>>>>=20
>>>> I think the best solution is getting broadcom to update their firmware=
,
>>>> I've just sent them a message through a form on their website, I could=
n't
>>>> seem to get it to tell me "Your message has been sent", so it's possib=
le
>>>> that it didn't submit (more likely I've sent the same message several =
times).
>>>>=20
>>>> If I hear back from them I'll send something here.
>>>=20
>>> Thx for that. But FWIW: from the point of the regression tracker that's
>>> not the best solution, as according to your report this is a regression=
.
>>> IOW: we deal with something that used to up to a certain kernel version
>>> and was broken by a change to the kernel. That is something frown upon
>>> in Linux kernel development, hence changes introducing regression are
>>> often quickly reverted, if they can't get fixed by follow up change qui=
ckly.
>>>=20
>>> That sentence has two "quickly", as we want to prevent more people
>>> running into the issue, resulting in a loss of trust. But that's what
>>> will happen if we wait for a firmware update to get developed, tested,
>>> published, and rolled out. And even then we can't expect users to have
>>> the latest firmware installed when they switch to a new kernel.
>>>=20
>>> Hence the best solution *afaics* might be: fix this in the kernel
>>> somehow now with a workaround; once the firmware update is out, change
>>> the kernel again to only apply the workaround if the old firmware is in=
 use.
>> I have an idea. Can we make LE Read Transmit Power as a module parameter=
 and users can turn it off if it is causing trouble. I have a patch for the=
 same but haven't tested it yet.
>=20
> Module parameters are for the 1990's, please never add new ones as they
> modify code, not data, and you want to do something like this on a
> per-device basis, not on "all devices in the system", right?
Exactly. Since the issue affects only a few Macs and not all devices. In fa=
ct I have spotted just 2 Macs yet affected with this issue.
>=20
> thanks,
>=20
> greg k-h

