Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FDB63215
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhKQDbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:31:35 -0500
Received: from mail-ma1ind01olkn0187.outbound.protection.outlook.com ([104.47.100.187]:6350
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231166AbhKQDbc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3//UvywMZ3maP2CIYtqkZMtmSgo7TRP2ebc2F+c3PdtDH/tT+jmq2/FrlQ0cWkzzaLkJ0JEVyJ3+CHR6nUnZlezoJpbU1LAdHF/QCiBifRL9e6zdHWIYRP8AOTXaUER/T9fWD5rpDor6YnB6dSSWlVGbh5Mit2D2n56sQpUVbr+Gx5J60mYvg0fLSNtEx/lvwBXmlTTSxJ4kNM1MLiWqYHYeKXHLA1r0eiD+cNwZzFa7as265iftjeU19FGIpVN+IiHaGLcpVUZESHSkOZ8bj1g5k6BlAiW5R9hr6IoysgSp9O+GcuLaFw1Zz9qf+UN/j3qUZwNz+I6qLN+gHhGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyOKFaBT95N5nHqzijvXuVEJZJlwUnVxFAr7mV5E3Jo=;
 b=ICnICt3CY1XUKTvfIjN2WCLyyU48itKjRQUPqrOwgJynjHLtnBufoQlvYwnx4WGoFecKG3GKiMCMtIxH48s6sl+i3UJGbVOxJi6Yc/W55AvNJnu8f5gYaZMjCQfyse3bzkUvDH2JhQwrZqAVNtjMnDeIYfz5b+WkZfaOi6XxwuD8Nc+luj7cM8bmtsNwiLqUXj7B8Q4kGbjs14lJsJpHfQ0jXp68yThpbbId8bmwMECkmeuMrI+GhCsHWLqMiuo+sjHBQLmO9BFufxopIyrDB+jEsuB3vrnYy/UX29o0HZTknIGRJBDSWTXBpoCF2WAPYF4DG74D4EDXXTiu25l+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyOKFaBT95N5nHqzijvXuVEJZJlwUnVxFAr7mV5E3Jo=;
 b=sENPT+N99GZdaNeMJzWxxIllFcuE8jyW4FE/1+kCLMpy1Mlqq6KAyNANqRLKGRDAtobgL+d4H6iCJ6gaMJUr2fX6eCGEm0lBsvhqF3H6jB+70SHzRac6BBfrrE2g+Tcw2zJDr1NrPK00TeMDj7BqghCEMtlOjGQG8OpVOngOGK3rl8vPlxPc4Gn/b+x7T6IrTHiBE2Pi8yLjdPFIv+U+SfFEoCKlTO817axLnFvQ4ykk++GGA3kUdd5MC155lvP4x6OEqb+2X1a7fASD4vO1Gwe4nc9s+ZJcb0cHObAxRdRajzcnN8melTLJDrDzfyVe0psRWkA11QxU1uQarGMmJg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4558.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 03:28:29 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%7]) with mapi id 15.20.4690.026; Wed, 17 Nov 2021
 03:28:29 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwA=
Date:   Wed, 17 Nov 2021 03:28:29 +0000
Message-ID: <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
In-Reply-To: <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [yixy69B5a7CwT3obaPmWPw3r4nR6u3dwd74rRwgvinV0fdmacyeNnD4KYGPLmIVZ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78485d5a-e85e-4612-3ffb-08d9a97a52ff
x-ms-traffictypediagnostic: PNZPR01MB4558:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9rFu3wRNoLsVK0OPEn+Ubjb3Ed0C5hkBVpHE3P1O6I3FWHE8ZRxCTQQJJcAmL88CrZvUxu31fH49StukNyCRklMQyVduUF4KmKT83lynx23Yf/kOz0kp8yln8cMeedZMP+AScCAfih7nhVMswFKZGTzlycLrlto+A+1c6Nk2Ore5FMndl1UG6DdVKP9KDPAZPo7Yk5Wxcfet/e0cIFEwV+ENmvkEM1Qrd+D4sa90jK8OyC+D5vMSZ9t8I3fycDIIaGbpU9yDgll7jy/g1Qhu2ILg2fpra4nSOQlLwUKlGdFTMTPL5YJRaiEyXnBaAMLCNDCP08DE/vIRpv8lufM7d+UfIey3aqUH8xp5Sv5dLGyiLEyVgBdve0aW2WpIJF66I6UStfzqKqkVp3o569TkAJOwvwAd48GwllqQxwOYcLZNWuupIUHTnHjeyIHxMbq10+WRxWM1P3uogRjcHr6JdYqpqEkoEwC71tHMfWv0dCPlsSvdyblyhpfhMjiYZB9bbaWeRmRcJRohTh7SQT7yF90QxfQO18CyTE/J0bxEEQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: tZPYU4ADxUvmsEWkFQs99N+10LYsEVVLB9AeZri8HFO/qtpjEdPTxT4XrcLorn1rSTfKqGhQYKfBvC3/MbdxYYA+zLZFj1HhrkTn3EGzPI2z2q4h44zozYQSXm45PLvAJoYKkm70jV/ZJGZxn3l4GIOPAsNnyp/p/E27SLDpnRIIS0LVlC4KDzRRxQt9akB/b0/W2wHST/kHK7KV7A9GZEnh9tTvG7H2bnXIBA22IAwBLqQoUBwW51UTYxzsL50T6ipjfMVSGbs+Rj3ZW6zvfWe+cW9I7NvSnKcKz2iZ86k06ayAVIC+BV6iRb2w+uswDniGV7VmFshU8cLB6VkuGdJ06A8LEOipMjQJkuIue1Y5KYCHw1lIaS6h5H12+V64ur1U1/sB1Yj0iOh+tz8ekJCx0k3Rvn9m3aYAYyFllLG2lm64ce9YM93Ro49tdaGYscoQpiGlPgwdhC6eEOWLHHiil6UfIalStQx19XtuARZGXzV7arZhjCxmDqrLDhfbRHtxJhVVgVp1yn6Crlg5Lps7MxaDrZsR9knykgoRqXPFO8hy6iH1LK6QclKi27nod2CYByk83MUeKHZoKEjyC8fnNxbuxXVEwAAjZ7lnxFUdU4PwaEsqyAgTfqIM26A8hm035fPVh1/WADoCt0PmNqDSCSq4Niv3YCYHM4//VRS3sYmG7oB61Zhmv/G8EoYgOumbPxtzXbh2vxvd6TGchmZmuv5cj+KaUaa7+Ouk5DHAx89mkdNOVeCulip2m/wndjnUfFwLeDJn9l2H2A4n+A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F99FB455A590F46B6E1BEE6C6FC7E17@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 78485d5a-e85e-4612-3ffb-08d9a97a52ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 03:28:29.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4558
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 16-Nov-2021, at 2:56 PM, Thorsten Leemhuis <regressions@leemhuis.info>=
 wrote:
>=20
> On 16.11.21 10:02, Orlando Chamberlain wrote:
>>> Bluetooth maintainers, what's the status here? The proposed patch is
>>> fixing a regression. It's not a recent one (it afaics was introduced in
>>> v5.11-rc1). Nevertheless it would be good to get this finally resolved.
>>> But this thread seems inactive for more than a week now. Or was progres=
s
>>> made, but is only visible somewhere else?
>>=20
>> I think the best solution is getting broadcom to update their firmware,
>> I've just sent them a message through a form on their website, I couldn'=
t
>> seem to get it to tell me "Your message has been sent", so it's possible
>> that it didn't submit (more likely I've sent the same message several ti=
mes).
>>=20
>> If I hear back from them I'll send something here.
>=20
> Thx for that. But FWIW: from the point of the regression tracker that's
> not the best solution, as according to your report this is a regression.
> IOW: we deal with something that used to up to a certain kernel version
> and was broken by a change to the kernel. That is something frown upon
> in Linux kernel development, hence changes introducing regression are
> often quickly reverted, if they can't get fixed by follow up change quick=
ly.
>=20
> That sentence has two "quickly", as we want to prevent more people
> running into the issue, resulting in a loss of trust. But that's what
> will happen if we wait for a firmware update to get developed, tested,
> published, and rolled out. And even then we can't expect users to have
> the latest firmware installed when they switch to a new kernel.
>=20
> Hence the best solution *afaics* might be: fix this in the kernel
> somehow now with a workaround; once the firmware update is out, change
> the kernel again to only apply the workaround if the old firmware is in u=
se.
I have an idea. Can we make LE Read Transmit Power as a module parameter an=
d users can turn it off if it is causing trouble. I have a patch for the sa=
me but haven't tested it yet.
>=20
> At least that's how it looks to me from the outside. But as mentioned
> earlier already: as a Linux kernel regression tracker I'm getting a lot
> of reports on my table. I can only look briefly into most of them.
> Therefore I unfortunately will get things wrong or miss something
> important. I hope that's not the case here; if you think it is, don't
> hesitate to tell me about it in a public reply. That's in everyone's
> interest, as what I wrote above might be misleading to everyone reading
> this, which is something I'd like to avoid.
>=20
> Ciao, Thorsten (carrying his Linux kernel regression tracker hat)

