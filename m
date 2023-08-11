Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB904C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 11:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjHKLTY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHKLTX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 07:19:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2069.outbound.protection.outlook.com [40.92.58.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8698E62
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 04:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noS00chPmxhz1HSaLhY7l06vr+4Ram+fSlQHmvhAx1Tvp2rdNfbyR7LYT+wVjIPQziRuZxTvbWQXKv18uW0zu9+jjrWwLqbf0BzcTa88/w7EXzXZjBZRevibBhTR7TE/8prChNOR42SQKzWsTv7fUU3sphk20dEOKoOFokf4NTz7zQLiWr+Fg7lnMsMUbpQjgKmAlH2W+9C2A1FEWRNTGXYkTVkhUR8ZXI53pMoDrnNSl2Z8uoZDP6g0jKFjPD3o1xG3LmO0CsaCh7RucrZJieiOXa/jEkgTB7kimbZmmJKk/D06qIQNwbek1xb2X2kgeXacEAB06uttxhx1w7/rwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDxvG20ZyAM6PvpUs1a+CHJgK+r3QVKT9iSZyt8gjdA=;
 b=k617jOqQtvhdCc3uMvNbIEuCjA+K0R4CZfJ+pJJRHLPETl2OLiZQTtnVvlBH3pe4urb/TBtg7fqOJBi79P/ROdHnXnsbMt0fw/PuARiQTxL144pSSLNhv16t4kTKwwFS9/tT2JCCtJhRUPI/bRTmYStVQRz41HJZi94J7Ql6YnH83DhEpzEqTOPXsd1jU5j5Gcq+fVCzq5Sp/olgbAZYgr5sOHkNkleaXAxjBV7IV3oeTk+m8Vbx7oqvC83iQVHf6Y5blR5o61c9CKyFMzQpa8djozWqN/evjPfeFQwptDR1KY+jx2Kip6klqmXaJ3t8yhuNkoRQ9GQqrbVoEaeFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDxvG20ZyAM6PvpUs1a+CHJgK+r3QVKT9iSZyt8gjdA=;
 b=iU+R6pbzJLjCQ+Ed1DA9qT0dtVwvXAQ3WUDAQHmvPBSZhaA6eCJRw8F32/XrN4KS4qsZFibb6/4mCPEDndftdD+uZFW+xbJm/Z8xu3I6KpwcLbM0Hn9nZkFnUw4jeUIQkkI+wDmsjtTySRySp/+DULHb0H51cRTFVKnYsTRcAVxA+fA8MII8JjXGWsWLop7KXC444HF+cT3uwNv/87gX6NOH5hA4SnBv9ZygKk1Gy+x5prvuD5k/eO1Ldvdc0gjwpCnChOWCIAx+S6p/O7xx6Yuu77+SDya+G7eix4U5VDfwLLhFu3sEyAS1i7ShnriAPT7h1Gx9Wo0hgfAG1XBgew==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by DB9P191MB2049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 11:19:20 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 11:19:20 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
Thread-Topic: regression: kernel 6.4.x breaks scanning/pairing (but not use)
 of LE devices
Thread-Index: AQHZxwU/0l6XSi77i0WWX4xR1VKYUK/bT48AgAmttwA=
Date:   Fri, 11 Aug 2023 11:19:20 +0000
Message-ID: <5706628.DvuYhMxLoT@bruno-beit>
References: <2300626.ElGaqSPkdT@bruno-beit>
 <47e6ab77-e1dd-4ede-b75d-f484b2593395@molgen.mpg.de>
In-Reply-To: <47e6ab77-e1dd-4ede-b75d-f484b2593395@molgen.mpg.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [4gCFeXDpawjC3u6gDP5Ahh9VC1LgyB1A]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|DB9P191MB2049:EE_
x-ms-office365-filtering-correlation-id: 4564ee1c-5ad3-4caf-0c33-08db9a5ccf44
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znySk/+sdNSlF1BGMHKkbQWu+BwBrhA4br+nM88JCQLLcFdEIUitrwG7ko3Jb0VNGQT1Lk48spU0iO49KrRMKcjOJC84ixQKjiTi1AiRvM6KyfVQSaUNlskuRCZRLZK27u40TNfNXrjt1/sWIkyUeEbmBHju/L9kf1qdMf1Wg4+SYQ8E1vV8aVkNEAPvrt1In4c7oR9pkyz2put7DHyQQJpsoMy688r9Le+7dwf0rt9ofHfW21Qio452eK1mNZPSaTrjqzI6IRx1PufZgpFo+CsJFegzSEw0LxbPMrmYYS8JSrScMJiBbHBIRRzWuU8NvsyXNni22pwQkHHVsnfVe7smXd1vIbE6baclDvYhIGrp+NnCxmf881hCs9cJPL4Lm/vBs3zr5xDQL5xzenq6P0stogOUyCX2CHyJ5aJgYoOOjAKffbNwQzv3iUINw7Lyzico/C0ox2dM3JAJ2Vd2wmv56tiMP+PBPMpcqd/v18qjf4M6ApaXXF/M6Tg0TOE12P7gW6icT9A44iZq5Z+Q03+mVjWe/LGDbOjYc3U3kXw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1250?Q?FMH2Cc6pdnrFR/xFYL4p2nY+1Dz7lrAOvZQzlq8fFXot2lKrPjFXNU6j?=
 =?windows-1250?Q?7+DYebT4bZfJA9zOpEN+8Xn+LcgPXDKKUhWbJbX/53trB0kWO2ZvrqgF?=
 =?windows-1250?Q?LWxYD0BL/b9GZUMOMKzFLfd6BITLLFdhgIi0VBgtT6M9KPJGr9SEJOQp?=
 =?windows-1250?Q?Rj6MsZFGi9Gi6F2wF1vufPyUS4zt5TBL2ptHJZN1tGAnqIGGHXyTCmhw?=
 =?windows-1250?Q?+HZ/FJjmej6NEb9wNQsiCleSR9cdNVnxp8SpJGbmvF7dWMiVAm6qgiFz?=
 =?windows-1250?Q?5yk5fUOamUQzFI/yMXHaY9sgYTAx1m70D58X+KwylRWc1nknxKSZhQQa?=
 =?windows-1250?Q?UUfHT0zYIfnwLheASFVvRdPXx7iJavT2KP7AXNIVoowYz9q27b3neIx8?=
 =?windows-1250?Q?0R/MmgRbBcwsklBIfQ1x3RV3aIlv2wRCoVT4cnpQXCG+5fvDlZsnf4nL?=
 =?windows-1250?Q?r2QLx+kYtnbaW6iHE1mu5XU8bY7mrb+cMjLyDJcdkjk35xFNNwBbuFdH?=
 =?windows-1250?Q?KteMWwK7qPvo4xKqnAKJ0nQCNo6lO2LGXCPhnBdYiOAg7JiVNFbKAs4Z?=
 =?windows-1250?Q?IZEc6OCVquCaf/7J7kmtUdBk1d2jeIHmNZ/xmJTLz8ODXfsYAnBO5WwY?=
 =?windows-1250?Q?PDinV6aDO7h8CCyUCsxS3qi6mAj8KOlQDkfrq5DoY6rdbFvAs1xm8dvT?=
 =?windows-1250?Q?mRQ/RN5CH8mdWX7JYkQlpmhyqBku8xgCy+cuwbB4JUeEfDQHeQ4lWhzX?=
 =?windows-1250?Q?r5tXKliPvdMj0GJLqAvoMuKMxIZcvC0tzyS/e9FFgT6Zz/0fJS7CS1G8?=
 =?windows-1250?Q?sxm175xHfvYI2fxqNhkm3Uhp1z1B7WT+JVuFxq1vVCS73S5Eg9b7VjQU?=
 =?windows-1250?Q?EN1zOe88W/aHVPXM+oVQ6ixJSO7ylUQEkc7JKYNfJnKPIwhzp3sLDaBn?=
 =?windows-1250?Q?3okI2pohG1ekDEji4M8il8BW5Gnn5/X+lVdLktHW9SsWDbs77nzSNFWM?=
 =?windows-1250?Q?4R75bp93qjPfS+AKcpCsrVrGucOuC58Vp3j3SsqGtOBL25NUCfX7njdo?=
 =?windows-1250?Q?tQmv2Sm2zmYPKxaJ7wU7GKyfZ6Tdmv8ns8Q8yMdi6gcIpbd4640K9hB3?=
 =?windows-1250?Q?/jmj70Tb4y2fVWvWFpYKCLEFvJIUdgVtiUadHFMTX/5UZd9DyrE3KQa2?=
 =?windows-1250?Q?CuEcHNclmL/7subqjY6tgJP/EuzqNPqbiy7rcPnW3KAxUFrmqN+yIjYU?=
 =?windows-1250?Q?EkWJGK/xQ4SbVfkcOFPdiZyJf7h30UCvM/HjlkP+w8mARRYhj1wpmky8?=
 =?windows-1250?Q?1VR2ibRY50DuRk4w8dMZmnbpDwI=3D?=
Content-Type: text/plain; charset="windows-1250"
Content-ID: <27C837F65620954D89EBEFDA5D109FF1@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4564ee1c-5ad3-4caf-0c33-08db9a5ccf44
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 11:19:20.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P191MB2049
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dnia sobota, 5 sierpnia 2023 09:31:08 CEST Paul Menzel pisze:=0A=
> [Cc: +regressions@]=0A=
> =0A=
> #regzbot introduced v6.3.9..v6.4.2=0A=
> =0A=
> Dear Bruno,=0A=
> =0A=
> =0A=
> Thank you for your report.=0A=
> =0A=
> Am 04.08.23 um 20:55 schrieb Bruno Pitrus:=0A=
> > I am using openSUSE Tumbleweed on a Dell Precision 3551 which has a=0A=
> > bluetooth adapter of ID 8087:0026 (Intel AX201). I am using a=0A=
> > Logitech M575 trackball mouse which only supports Bluetooth LE.=0A=
> > =0A=
> > With kernel 6.4.2 or newer, scanning for devices =97 using either the=
=0A=
> > KDE gui or bluetoothctl =97 most of the time returns only =93classic=0A=
> > bluetooth=94 devices like computers and phones, and not the mouse. If=
=0A=
> > the mouse was paired before, it works correctly however.=0A=
> > =0A=
> > With previous kernel versions (6.3.9 and before), pairing the mouse=0A=
> > worked correctly.=0A=
> =0A=
> Are you able to bisect the regression? Please also attach the Linux =0A=
> messages. (You can also create a ticket in the Linux kernel Bugzilla [1] =
=0A=
> and attach everything there.)=0A=
> =0A=
> =0A=
> Kind regards,=0A=
> =0A=
> Paul=0A=
> =0A=
> =0A=
> [1]: https://bugzilla.kernel.org/=0A=
> =0A=
=0A=
The offending commit is https://github.com/SUSE/kernel/commit/288c90224eec5=
5d13e786844b7954ef060752089 :=0A=
=0A=
> Bluetooth: Enable all supported LE PHY by default=0A=
> This enables 2M and Coded PHY by default if they are marked as supported=
=0A=
> in the LE features bits.=0A=
> =0A=
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0A=
