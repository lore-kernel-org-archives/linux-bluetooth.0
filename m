Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B5AC001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 19:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjGMTAq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGMTAn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 15:00:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E02715
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 12:00:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b9c368f4b5so15828255ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274841; x=1691866841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q42znYC/4ppNtl/EcFGD17RiQO8YiQzg8sPILT+Owc=;
        b=Ndw6JItRCii3ihW+oQoPlgX8y0prpaV0qK/gJs0HBSaANUVY5yUsk9oqru0l+xRxwn
         LtZcBWQU6Gd/HSyvSVSwXNWJ75EKtMhUaFGFW98q3vULGTGKv2ubUTdbcl85ODLbkCpa
         kTbQYtkNg83ILR016KXmCKHGXtTlPtj+YzAgaDbWlivtdndrh0VfuIZr/lEseCMeXLJc
         J1DxYTY1oV8IMbCB3ietzomVQyy3roVjP+xeb/9QwA3yVy0UkBAp5OTl0cmQan4m3H5B
         MFwS5AJ1zq3OVHxtYwenOamnjQypgsWZelFkCfqk7HmQ/uGjmU/K2JkHll2iToFWnJLH
         QduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274841; x=1691866841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q42znYC/4ppNtl/EcFGD17RiQO8YiQzg8sPILT+Owc=;
        b=g3HFnVQw99HkN+1y2IY8sNWojujgiTdLITy2ZYG3Ahc75mWNRXKVk51IBChbV+0I0B
         Wlw7opwnxY33DKlwQwg5TtlYFVtFy2shn/wImiInBK+XdcbG8Ryasuoyh/2Dmi8hFInF
         Y3EHTzkn4YSd2j73oaHbxumceetlP2VBbYMcZqCiB578g2Xmtvk8cLQg4I++4GmjGEUw
         GuWdc3z0898lr1fWV89l4bnxo2+HzbfUavVsxI2RqCWPaUtRhtt1HCSJ0VOqP7mXLBzv
         iCnldAh1jSS4ow7bGVFrneHBFfj2pIdpl2BqNmduVsTj813rbEWbNXfq3sM2SaDfzwUV
         +Fcw==
X-Gm-Message-State: ABy/qLaG9ojYfb6gCUYWPdNFXqDSdmdDe8tpETL/VDnKkbTqvMe4C2Lh
        J35fZI5F9kXsYSyx+sMVacHWex34rbHx5w4rhuZiKHBM
X-Google-Smtp-Source: APBJJlF1tdfOVJkyp8w+RR1e3cVuehMkSZyxJkQeyf4kG+oVqDMDJrNqpommOt1jMV4fLuqQmYVKt7mYBUBTjwxKw2Y=
X-Received: by 2002:a17:902:c412:b0:1b1:99c9:8ce5 with SMTP id
 k18-20020a170902c41200b001b199c98ce5mr739582plk.16.1689274841008; Thu, 13 Jul
 2023 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230712122135.7734-1-claudia.rosu@nxp.com> <CABBYNZ+8MvwrB_50=cugsdTKSv_DSFePErb3w-7NestCT3nwjw@mail.gmail.com>
In-Reply-To: <CABBYNZ+8MvwrB_50=cugsdTKSv_DSFePErb3w-7NestCT3nwjw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Jul 2023 12:00:27 -0700
Message-ID: <CABBYNZLEPLrm_rZ234_pxNNzi8Ls646B6nCybW8F7S6fnD8qSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/6] Add support for BAP broadcast sink
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Wed, Jul 12, 2023 at 10:45=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Claudia,
>
> On Wed, Jul 12, 2023 at 5:46=E2=80=AFAM Claudia Draghicescu
> <claudia.rosu@nxp.com> wrote:
> >
> > This series of patches adds support for BAP broadcast sink.
> > It consists in registering a sink endpoint using the Sink PAC UUID,
> > discovering of broadcast advertisers that announce the
> > Broadcast Audio Announcement service, synchronizes to the Periodic
> > advertisements of the source and synchronizes to the BIG advertised
> > in the PA train.
> > To retrieve the BASE info advertised in the PA train, the patch
> > Bluetooth: ISO: Add support for periodic adv reports processing
> > was used.
> >
> > This feature was tested using bluetoothctl with the following commands:
> >
> > [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x0=
6
> > [/local/endpoint/ep0] Auto Accept (yes/no): y
> > [/local/endpoint/ep0] Max Transports (auto/value): a
> > [/local/endpoint/ep0] unicast/broadcast (u/b): b
> > [/local/endpoint/ep0] BIG (auto/value): a
> > [/local/endpoint/ep0] BIS (auto/value): a
>
> Ive thought we would be using BAA UUID instead to follow the same
> setup as the broadcaster role.
>
> > [bluetooth]# scan on
>
> Then while scanning if we find an announcement it should create a
> remote endpoint under the device object path, just as in case of
> unicast, which can later be used with endpoint.config.

I had a few more thoughts about how to enumerate the remote broadcast
endpoints, we may want to introduce a driver for BAA UUID so when a
device is found with BAA as part of the advertised UUID would get
probed and the driver can take care of creating the MediaEndpoint
objects based of the advertised data, probably each BIS should have a
endpoint,

> > [bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
> > /local/endpoint/ep0 16_2_1 <source_address>
>
> Here then one would replace /org/bluez/hci0/pac_bcast0 with the one
> found during the scanning, so the difference with broadcaster becomes
> the source endpoint, if you pass the adapter it is for broadcaster
> role or in case it is a remote endpoint the it is for listener role so
> the commands would work similarly in all directions
>
> > Claudia Draghicescu (6):
> >   client/player: Add broadcast sink endpoint registration and
> >     configuration.
> >   client/main: Add broadcast source discovery
> >   media: Add support for a broadcast sink media endpoint
> >   transport: Update transport properties for a broadcast stream
> >   btio: Add support for getsockopt(BT_ISO_BASE)
> >   bap: Add gdbus interface for BAP broadcast sink, create
> >     synchronization with source and create BAP broadcast sink stream
> >
> >  btio/btio.c                |  13 +-
> >  client/main.c              |  57 +++++-
> >  client/player.c            | 187 +++++++++++++++++++-
> >  client/player.h            |   3 +
> >  profiles/audio/bap.c       | 347 ++++++++++++++++++++++++++++++++++---
> >  profiles/audio/media.c     |  35 +++-
> >  profiles/audio/media.h     |   2 +-
> >  profiles/audio/transport.c | 244 +++++++++++++++++++++++++-
> >  src/shared/bap.c           |  50 +++++-
> >  src/shared/bap.h           |   4 +-
> >  10 files changed, 888 insertions(+), 54 deletions(-)
> >
> >
> > base-commit: 838e1578072900d1f98dfb31cc538940d2fad876
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
