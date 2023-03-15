Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA787C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCOTmx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOTmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 15:42:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174964B3E
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 12:42:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j11so25648960lfg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678909366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSh7+Fi0KX65SCceebWcA5/phdaeQWVh/S1ocUZuaNY=;
        b=i4kiA9VUjaQnAw1VRzEXKECKm3swLgbk+iOP/WayrNhXT28bZ7/CH6x7dJPB+OBC5j
         KgElqmBms+yy2NnnTVnSvqicsaMc6nemduD60wNQDbnR/UtK2wCrKQ54zWXh4GtGzEGh
         hlECnUDS1ZWfOQKQjeWAUL3T7w1Th1li4M4ArCmYXYYWK5gE5LJJoaU66mapRbVo84mF
         E80aYjDm2ikBPca4v5REstT6bH4z6Ezml0NMq0AwYMJNfJSR4u2iFqyqiGhsEMzTRxvl
         bBntaey6ShCY/8HiWsp+nU+js/dYSNOCuSnPZmANgDX9BDdozdWDglisejIhmObWUp3S
         GjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSh7+Fi0KX65SCceebWcA5/phdaeQWVh/S1ocUZuaNY=;
        b=tqVk+rnLynXeigqDV64BsMOgNiU1mu64ptjng0ufH2Ze1DyjG3oqiu3FB68av15dZv
         So/CRZqm8wGGI2VAi4L5Vh2erlBEMxTtvAbb4AqzvXEnvpA/bh3EJ9l7ATIzfFgBMlkA
         4HEX68Ov1kG3Lh+uxR9F+FmSZs9Yc0921+nv3aWtIdGycgTitNdmKVhIRzDQPOnp4IMC
         q2Y9BSUVEHZRlKsoy/PqNvqReQAWi0GJcYi1LGF7kKWAu9Qk3D5sLCD+XmMKkAoRq2mC
         EJvBb5Hf5WOLpzu/fPUPTKKZ8K2yQ7Wpz3nxWkCWA79cy6Kj75/rkJA9yCVNlyH49DQR
         dyrw==
X-Gm-Message-State: AO0yUKXEhuflqVelqfI/aLZOb0zjclh3JyJGh0Ft9d5VuhximYj97iWN
        KvaqCfselPjRwMZbvi1sO24io162Xw9eUXdErIc=
X-Google-Smtp-Source: AK7set/w8y3dZbSM+6RXsQlMeF9a0QcqpUhVnambX0GpJVhFN/8fgbk07Tbd1/R7u535P04eEb7cP4L83kzGlitIvcs=
X-Received: by 2002:ac2:592e:0:b0:4db:1989:8d92 with SMTP id
 v14-20020ac2592e000000b004db19898d92mr2399082lfi.10.1678909366222; Wed, 15
 Mar 2023 12:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR04MB8898256F1388824FC19F67BFECB39@AS8PR04MB8898.eurprd04.prod.outlook.com>
 <CABBYNZJpzvDWf89DYGBfErc=Y6-euzUCdjUydJqSq+5NDExOvA@mail.gmail.com>
In-Reply-To: <CABBYNZJpzvDWf89DYGBfErc=Y6-euzUCdjUydJqSq+5NDExOvA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Mar 2023 12:42:34 -0700
Message-ID: <CABBYNZLeJdmTj-Si02==O3pQ+2JS9g4Z+ptUm5904QVBQ9skCw@mail.gmail.com>
Subject: Re: ISO socket bugs/lack of support
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Mar 3, 2023 at 9:48=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Iulia,
>
> On Fri, Mar 3, 2023 at 7:02=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@n=
xp.com> wrote:
> >
> > Hello,
> >
> > Earlier this week I submitted a BlueZ patch ([1]) containing an initial=
 implementation of the Broadcast Audio Scan Service.
> >
> > In order to perform some of the BASS procedures, the BASS Server is req=
uired to send specific HCI commands and to handle HCI events accordingly - =
for example, the "Set Broadcast_Code" operation of the Broadcast Audio Scan=
 Control Point characteristic requires the BASS Server to issue the LE BIG =
Create Sync command with the Broadcast_Code parameter set to the characteri=
stic value written by the BASS Client.
> >
> > My approach was to open an HCI socket and to send the command directly =
from the BASS handler function. After my proposed implementation was review=
ed, I was told I should use an ISO socket instead and let the Bluetooth ker=
nel perform the BIG synchronization procedure. I investigated this solution=
 and the problem that I encountered was that the kernel sends HCI commands =
with fixed parameters - calling the "listen" API on an ISO socket will alwa=
ys attempt to send the LE BIG Create Sync command with the Broadcast_Code p=
arameter set to 0. I couldn't find a way to provide my desired parameters t=
o the HCI command.
> >
> > I also discovered 2 kernel issues when calling "listen" on an ISO socke=
t:
> >
> > The first issue is that the "hci_pa_create_sync" function attempts to s=
end the LE Periodic Advertising Create Sync command with the Sync_Timeout p=
arameter set to 0 - according to the Bluetooth Core specification version 5=
.3, this parameter should be in the 0x000A - 0x4000 range. This is why the =
Controller will reject this command, as shown in the following btmon captur=
e:
> >
> >
> > < HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 1=
4
> >         Options: 0x0000
> >         Use advertising SID, Advertiser Address Type and address
> >         Reporting initially enabled
> >         SID: 0x01
> >         Adv address type: Public (0x00)
> >         Adv address: C0:07:E8:8B:69:F2 (OUI C0-07-E8)
> >         Skip: 0x0000
> >         Sync timeout: 0 msec (0x0000)
> >         Sync CTE type: 0x0000
> >
> > > HCI Event: Command Status (0x0f) plen 4
> >       LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
> >         Status: Invalid HCI Command Parameters (0x12)
> >
> > Updating the "hci_pa_create_sync" function and setting the "sync_timeou=
t" field of the command parameters to a value in the required range solves =
the problem.
>
> Broadcast support is in its very early stages of development, and yes
> the sync_timeout probably need fixing as it using invalid range right
> now, we should probably a way to configure it via use of BT_ISO_QOS,
> currently both unicast and broadcast are using the same structure but
> perhaps it would be a good idea to differentiate them with more
> dedicated options.
>
> > The same issue appears when the kernel attempts to send the LE BIG Crea=
te Sync command with the BIG_Sync_Timeout parameter set to 0:
> >
> >
> > < HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)=
 plen 25
> >         BIG Handle: 0x00
> >         BIG Sync Handle: 0x0000
> >         Encryption: Encrypted (0x00)
> >         Broadcast Code: 00000000000000000000000000000000
> >         Maximum Number Subevents: 0x00
> >         Timeout: 0 ms (0x0000)
> >         Number of BIS: 1
> >         BIS ID: 0x01
> >
> > > HCI Event: Command Status (0x0f) plen 4
> >       LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
> >         Status: Parameter Out Of Manadatory Range (0x30)
> >
> > Updating the "hci_le_big_create_sync" function and setting the "timeout=
" field of the command parameters to a valid value solves the issue.
>
> Patches are welcome to fix this as well.
>
> > Hopefully someone can confirm the kernel issues I described and the fix=
es can be committed. I would also like to ask for some guidance regarding t=
he ISO socket usage when it comes to personalizing HCI command parameters -=
 is there a way to set the parameters from BlueZ? Or should this support be=
 implemented in the Bluetooth kernel?
>
> The setup of Qos is done via BT_ISO_QOS:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/tree/include/net/bluetooth/bluetooth.h#n174
>
> As you can see currently the structure is targeting unicast
> parameters, we should probably split this and have a dedicated one for
> broadcast.
>

Are you still planning to do the BASS support or you need more
feedback? I hope I didn't discourage you since we do appreciate
contributions.



--=20
Luiz Augusto von Dentz
