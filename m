Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D2C7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 17:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCCRs7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCCRs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 12:48:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48817179
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Mar 2023 09:48:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s22so4596477lfi.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Mar 2023 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga0uvzUjyzENNCzafwgjs8llVD5gHUlJqijEaBJ04uA=;
        b=dOFpjmKOUhuj4OVORuYO4KexgzdJ8+1GYRQH4TUQvUpb0xvDQSc6+BpDc73LfZt7c8
         4dmdgn+z5OCJ51WflY+lH6nmE977OkBMnC4J8k+Fk42On/BVSty7NU0wmUopJDtNSo/P
         r4IYrlbmmweX9hk0E6TtAQbdqlS2sf4QQ0Z69F+RBnSAJfeMi5cshYm3I9tU8UFuxiWZ
         YsyRB20EnaFGClc7n7Iml2XrZTc9rPbGVebodn+8CuslPLldTdruA2crGTzj+Usq+eNJ
         Ml+9Wsjkmu+t0UcEWmaQOMFNn0Wof8OIp0vyMd3w03E0OIarOqA8JydD3pqgM+fT7QIs
         Pidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga0uvzUjyzENNCzafwgjs8llVD5gHUlJqijEaBJ04uA=;
        b=cwrdVAy+wrEUv82rUGt9lYPc1gf2Bu1A9uR1xlWftw9o+XpL1wGGSaH6hZVr5LdDfQ
         VpmG+O0Edisky0VW7ew46fLauAfXBfpyey3OMRXzU+Qke5C5pNxt1WbLz8vf0Op7vsu7
         u+30hZ3WESCJM6dS2klEURZWIZFrDW/pjIzQVZQ9YqSP0cU2H57NQLIIgqvrOV3iYrP4
         RR9TyGUORAXXJJR1V8Wl3PAGQi+EaEPqb2OQURPzGtsuHJbRjzzG6hNBgsRshcDFsWcD
         nvLDddYxoamM7WusjQf1bG5tAA55g5LpPZAduqqsGGEMyTLy6cRU6y+WNB3guIviw9wr
         vtQQ==
X-Gm-Message-State: AO0yUKUHEKotTzr/2Uy8gXTmFnO9WklvmZHzWg1qn+UUM4P+zpuUPza4
        C98BSbtYkjm85IljLuoe0vE74VO+82rqx212t7w=
X-Google-Smtp-Source: AK7set+EpxW/Mqrgrspl8v1tNoxmXWYlCb5ozAMhP7Mig7R6hRxF9v0//opYKjThiRm4y6iQ5V40S88eomd14c/MdUc=
X-Received: by 2002:ac2:5fe6:0:b0:4d8:5037:6da0 with SMTP id
 s6-20020ac25fe6000000b004d850376da0mr871868lfg.8.1677865735289; Fri, 03 Mar
 2023 09:48:55 -0800 (PST)
MIME-Version: 1.0
References: <AS8PR04MB8898256F1388824FC19F67BFECB39@AS8PR04MB8898.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8898256F1388824FC19F67BFECB39@AS8PR04MB8898.eurprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Mar 2023 09:48:43 -0800
Message-ID: <CABBYNZJpzvDWf89DYGBfErc=Y6-euzUCdjUydJqSq+5NDExOvA@mail.gmail.com>
Subject: Re: ISO socket bugs/lack of support
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Mar 3, 2023 at 7:02=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> Hello,
>
> Earlier this week I submitted a BlueZ patch ([1]) containing an initial i=
mplementation of the Broadcast Audio Scan Service.
>
> In order to perform some of the BASS procedures, the BASS Server is requi=
red to send specific HCI commands and to handle HCI events accordingly - fo=
r example, the "Set Broadcast_Code" operation of the Broadcast Audio Scan C=
ontrol Point characteristic requires the BASS Server to issue the LE BIG Cr=
eate Sync command with the Broadcast_Code parameter set to the characterist=
ic value written by the BASS Client.
>
> My approach was to open an HCI socket and to send the command directly fr=
om the BASS handler function. After my proposed implementation was reviewed=
, I was told I should use an ISO socket instead and let the Bluetooth kerne=
l perform the BIG synchronization procedure. I investigated this solution a=
nd the problem that I encountered was that the kernel sends HCI commands wi=
th fixed parameters - calling the "listen" API on an ISO socket will always=
 attempt to send the LE BIG Create Sync command with the Broadcast_Code par=
ameter set to 0. I couldn't find a way to provide my desired parameters to =
the HCI command.
>
> I also discovered 2 kernel issues when calling "listen" on an ISO socket:
>
> The first issue is that the "hci_pa_create_sync" function attempts to sen=
d the LE Periodic Advertising Create Sync command with the Sync_Timeout par=
ameter set to 0 - according to the Bluetooth Core specification version 5.3=
, this parameter should be in the 0x000A - 0x4000 range. This is why the Co=
ntroller will reject this command, as shown in the following btmon capture:
>
>
> < HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
>         Options: 0x0000
>         Use advertising SID, Advertiser Address Type and address
>         Reporting initially enabled
>         SID: 0x01
>         Adv address type: Public (0x00)
>         Adv address: C0:07:E8:8B:69:F2 (OUI C0-07-E8)
>         Skip: 0x0000
>         Sync timeout: 0 msec (0x0000)
>         Sync CTE type: 0x0000
>
> > HCI Event: Command Status (0x0f) plen 4
>       LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
>
> Updating the "hci_pa_create_sync" function and setting the "sync_timeout"=
 field of the command parameters to a value in the required range solves th=
e problem.

Broadcast support is in its very early stages of development, and yes
the sync_timeout probably need fixing as it using invalid range right
now, we should probably a way to configure it via use of BT_ISO_QOS,
currently both unicast and broadcast are using the same structure but
perhaps it would be a good idea to differentiate them with more
dedicated options.

> The same issue appears when the kernel attempts to send the LE BIG Create=
 Sync command with the BIG_Sync_Timeout parameter set to 0:
>
>
> < HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b) p=
len 25
>         BIG Handle: 0x00
>         BIG Sync Handle: 0x0000
>         Encryption: Encrypted (0x00)
>         Broadcast Code: 00000000000000000000000000000000
>         Maximum Number Subevents: 0x00
>         Timeout: 0 ms (0x0000)
>         Number of BIS: 1
>         BIS ID: 0x01
>
> > HCI Event: Command Status (0x0f) plen 4
>       LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
>         Status: Parameter Out Of Manadatory Range (0x30)
>
> Updating the "hci_le_big_create_sync" function and setting the "timeout" =
field of the command parameters to a valid value solves the issue.

Patches are welcome to fix this as well.

> Hopefully someone can confirm the kernel issues I described and the fixes=
 can be committed. I would also like to ask for some guidance regarding the=
 ISO socket usage when it comes to personalizing HCI command parameters - i=
s there a way to set the parameters from BlueZ? Or should this support be i=
mplemented in the Bluetooth kernel?

The setup of Qos is done via BT_ISO_QOS:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/include/net/bluetooth/bluetooth.h#n174

As you can see currently the structure is targeting unicast
parameters, we should probably split this and have a dedicated one for
broadcast.

> Thank you in advance
>
> Iulia
>
> [1]     [BlueZ,0/2] Add initial BASS support - Patchwork (kernel.org)
>


--=20
Luiz Augusto von Dentz
