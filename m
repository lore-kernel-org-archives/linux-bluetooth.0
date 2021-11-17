Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2810961AED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhKQKCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:02:37 -0500
Received: from mail-bo1ind01olkn0177.outbound.protection.outlook.com ([104.47.101.177]:10961
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235849AbhKQKCf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 05:02:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPfYYop0MOB/kLtvd29yesdif/cBz2LLHIRIB9PSs6hEDfDVTRndtFgUgzjQRO3y0V83OD99Q1VtIM3U6T6cgJhUQQm2rcFDMHTaUhh0ubsKyXqQHTTGwd2LN13DD+HfS0CRAF7mb+BB/c1Z5vsiblxkwMfBfo8YVGTADqmGd3IYSAmWP7VBse/qT2pnZeTGs401lElS8pngtgdf/EUYwdHw3NKGujG4KyvxCMKqAPsdzr+gobw+ITF5v9AV70zby/WCZLT8XSv9kFGpZx2Mp/0DcHOTOZ9sNOtwEqMfR1vL8EmDD/aShdRz2ucgZezB7zHUK4u7o9a+4uk/SF0H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOcIhiLPBmkrhtuYNAPHqhlu7mjE0u2B8nT02pKl4ME=;
 b=b8teu8QWW7X/PKzuQlD4JDZhHB9wxf/x54znUB1MaIvMNQtZZIhlMNAzVAHujn1j0h17Jp5EDXfcruUtcHMW6i2ivP5nNjgSIkYtI77O51oSaefqtAsJZN/GCd7sbgOgAisrUSV1jJZ7tzVFKIGoxYbSCHEiOfw+TwUi0RfskAbY9IAUGMx8xxt+8vflsG9l95QQ9jx4WmHOkmWAbpp25oD7zxGWsT5OL6LHa+QZkJZHQWTXXZs+j4yHxRgY+FxsX5am6VmJ0TT86H06A+IHak3u2pxyFVpXtJbgmwGi+lDzRH8PuwgVojUM7Tq5CBNE3HYrRViTLRLCeug6488AFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOcIhiLPBmkrhtuYNAPHqhlu7mjE0u2B8nT02pKl4ME=;
 b=FeZoq36l98oXuRG8AVnuD36MI18/XT2NeVpTz/9WmroX8rccicmCXa1yLpPxT40QDCufR7Uj4BdYmZsYAI7PxU/6MOfus28ZTACySQ5msgZSiCpsoqJ5C4pB5gPW0VM13t22wdeXJf88CMvzZS3AHeI/55jraiS659olPBHwMEcfP/aDx4h4+sIlq8OcFFQW8ndMxGxf3BlimTv1xEM9dyBAK9iwrrFet4tFa06idkjJ8oo6NJOfljwqRX+lK1zOs9HztzV2mHKDKaqdcJmwjT1EI/t3FfdowmPKFSbyuunSQrQfRmZcSva0dtY2WiptBo99vhXaKoWxvKQpeNkITg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB6072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:59:31 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%7]) with mapi id 15.20.4690.026; Wed, 17 Nov 2021
 09:59:31 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Greg KH <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwCAAEInAIAAIdSAgAAEmwCAAASpgA==
Date:   Wed, 17 Nov 2021 09:59:31 +0000
Message-ID: <7E546B37-E7DE-454B-8AD2-F54F9C8C690D@live.com>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
 <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
In-Reply-To: <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [SiGeCAhLGl/HKpfcDlGkZ+7zUB5WN7CEbol7Rl4jAoNGSOqtH9AfS7KoLDqO2v0n]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79bc1699-9edb-41d9-221a-08d9a9b0f388
x-ms-traffictypediagnostic: PN3PR01MB6072:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkg80UaUO1f98ZO7bxb2NB9hxnqJ1IVms8MLngHueHquokqkkTBnL9LHckhhQ6R5na1BXm7US3Z4XGHNQy+MpeBDiSicRhpAKdPks2BY39s9ExNJ3LTRRmnuvcKy5QEFuIqmf9CA5Egw4dWRfzl3m+yP+7yz78O73HHJbD9Hu4aH9bZhp03A/RNdLDCa0PBnfezwv7xrhksqFTEXnJaAKN9RoJyI77A6TgDqbaqBE3ruEQYayI+A77iDTBa6zciAZndDRPLkFffwPzN24MDko0Myvt4Maafws2aHkLx2wpUkNnEkoZzx4hCOl1geyyJx9yu24aY7JFBxM2bYCn65xBzqgsBM21G1Gbj5p1ThTqwqhb+frd+Z++IWPydOyDXQfVTGefmNN0WF7XMUjff2a7Qma3xlmykWMkp8AMI7bRVlKSlAlmLSM5RrXeraYm2y13abK5oX+rGDb8AYw0VNJbm4gKd5bC79AtKs3X/gLHS3+lk5TadKE24UoA4jAdfCdWRgWt4q0CVu/UTBC6HZwOYK3M1TwboEh/eI9w0G0Ak=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: PzzXgghB5WiqDTr1y9E650wa2uFF11NGlXn/KpxEuW/LNz0x1xcCz/yG3Xtyt+oZr+1KTkPjfWtgbiDNOucpjoOTmufV9Mu9lyF85c56rWFkLGWL9V+4GRhRh0Q4NZ7/TVw3+27X0dE+qykd9+BX98XxFSQR6faxXpL5k+7eLNDH2YfMLX2UQNgBTD/8glhDJ9EkU/7qZq0u/pMiMxHbkHWcGGIq0fshHeGQ3ccwMAL53jJ/m6EYRag9l1QAkYc8mVPU9eMHgt72RTV2YeggJh5Djl1SH5I6A+dCERycGN/KxW84PaaqHD5Ao29uNFj8tztkp8Yb+bjYw75F1NLHGgCgI3GDin1UDhov5xi+vIR+K/kgfIdsVCkZZDS42Y+EMzYYUnPowOfSjpQYS4W75lSYHZ6LbEFNuMPOLvpv9MyGJ1IgqasNRulnyyAyzNRVrTF+vUkJqmkeb7El9IkxNrXw6CEGz+NgyIIEpIMDd22vY1L8HQEc35U1MgRuqpZH+G/LTWCYM+DyKDON5YRmWEG8buuU0+4HyXSEv8I/yav8EMGZgw+XzPALHutzCs530ocBkc+Lop+UBE+JqT6ZobIniqaYltA0TQL0QdPqkc2DcudckLFn5sc9RJ1IhcJRzpYaqKJIe8SHVGNYp8zvQSAPHFZ4W/48pc7ink+zGVKuqfoETFtm2Qtutk+q8ql8+H6eBzqBfvKXJzVqaKG8VV11wwNUYdby7EOAddEYxc/o5RBUv+hI5plPCpul39rWGX3iuZQuSAfjXAfzaOREPA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CF54B4536923045AE94DF5F3ADD2FF2@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc1699-9edb-41d9-221a-08d9a9b0f388
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 09:59:31.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6072
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 17-Nov-2021, at 3:12 PM, Thorsten Leemhuis <regressions@leemhuis.info>=
 wrote:
>=20
> On 17.11.21 10:26, Aditya Garg wrote:
>>> On 17-Nov-2021, at 12:55 PM, Greg KH <gregkh@linuxfoundation.org> wrote=
:
>>> On Wed, Nov 17, 2021 at 03:28:29AM +0000, Aditya Garg wrote:
>>>>> On 16-Nov-2021, at 2:56 PM, Thorsten Leemhuis <regressions@leemhuis.i=
nfo> wrote:
>>>>> On 16.11.21 10:02, Orlando Chamberlain wrote:
>>>>>>> Bluetooth maintainers, what's the status here? The proposed patch i=
s
>>>>>>> fixing a regression. It's not a recent one (it afaics was introduce=
d in
>>>>>>> v5.11-rc1). Nevertheless it would be good to get this finally resol=
ved.
>>>>>>> But this thread seems inactive for more than a week now. Or was pro=
gress
>>>>>>> made, but is only visible somewhere else?
>>>>>>=20
>>>>>> I think the best solution is getting broadcom to update their firmwa=
re,
>>>>>> I've just sent them a message through a form on their website, I cou=
ldn't
>>>>>> seem to get it to tell me "Your message has been sent", so it's poss=
ible
>>>>>> that it didn't submit (more likely I've sent the same message severa=
l times).
>>>>>>=20
>>>>>> If I hear back from them I'll send something here.
>>>>>=20
>>>>> Thx for that. But FWIW: from the point of the regression tracker that=
's
>>>>> not the best solution, as according to your report this is a regressi=
on.
>>>>> IOW: we deal with something that used to up to a certain kernel versi=
on
>>>>> and was broken by a change to the kernel. That is something frown upo=
n
>>>>> in Linux kernel development, hence changes introducing regression are
>>>>> often quickly reverted, if they can't get fixed by follow up change q=
uickly.
>>>>>=20
>>>>> That sentence has two "quickly", as we want to prevent more people
>>>>> running into the issue, resulting in a loss of trust. But that's what
>>>>> will happen if we wait for a firmware update to get developed, tested=
,
>>>>> published, and rolled out. And even then we can't expect users to hav=
e
>>>>> the latest firmware installed when they switch to a new kernel.
>>>>>=20
>>>>> Hence the best solution *afaics* might be: fix this in the kernel
>>>>> somehow now with a workaround; once the firmware update is out, chang=
e
>>>>> the kernel again to only apply the workaround if the old firmware is =
in use.
>>>> I have an idea. Can we make LE Read Transmit Power as a module paramet=
er and users can turn it off if it is causing trouble. I have a patch for t=
he same but haven't tested it yet.
>>>=20
>>> Module parameters are for the 1990's, please never add new ones as they
>>> modify code, not data, and you want to do something like this on a
>>> per-device basis, not on "all devices in the system", right?
>>=20
>> Exactly. Since the issue affects only a few Macs and not all devices.
>> In fact I have spotted just 2 Macs yet affected with this issue.
> When Greg said "per-device basis", he afaics meant: per-device in a
> system, as a module parameter would also affect a second bluetooth
> controller if there was one (say one connected via USB) -- and that
> shouldn't happen.
>=20
> And FWIW: it's still a regression if something that used to work
> suddenly requires a module parameter to get working.
>=20
> So if this just affects two macs, why can't the fix be realized as a
> quirk that is only enabled on those two systems? Or are they impossible
> to detect clearly via DMI data or something like that?

<RESENDING AS PLAIN TEXT>

A part of the output of dmidecode is below :-

Handle 0x0005, DMI type 1, 27 bytes
System Information
	Manufacturer: Apple Inc.
	Product Name: MacBookPro16,1
	Version: 1.0
	Serial Number: <Removed for Privacy>
	UUID: <Removed for Privacy>
	Wake-up Type: Power Switch
	SKU Number: =20
	Family: MacBook Pro

Handle 0x0006, DMI type 2, 17 bytes
Base Board Information
	Manufacturer: Apple Inc.
	Product Name: Mac-E1008331FDC96864
	Version: MacBookPro16,1
	Serial Number: <Removed for Privacy>
	Asset Tag: =20
	Features:
		Board is a hosting board
	Location In Chassis: =20
	Chassis Handle: 0x0007
	Type: Motherboard
	Contained Object Handles: 0

The product name, MacBookPro16,1 in my case, is unique for each model. If p=
ossible a quirk to disable LE Read Transmit Power can be made on this basis=
.

>=20
> Ciao, Thorsten

