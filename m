Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26AC001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGXRGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXRGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 13:06:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39EB0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 10:06:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so65398891fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690218399; x=1690823199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhmw6oCssaqjUN5GauBK6cmFD9VML3oz1aGp0hJ77+Q=;
        b=CpLjVdwv72w9yJbDkd7y8+Lk7bqu69xpnJlxJGIaS+4b0+BwvFMR7GjegGf0sjBiHR
         4ayOwKES/vLA+W+WwS7T2g1DOR5js9aQJ7EVw1kzSLZXseRcLITtS5u19fBKCQ2Sxire
         uEoO0DNus5GiZwJ6RthMhtc3zbTyEgtBoUGz3OAl2gOmNpJkjqB9UTJVCPV7ZQv9RjVk
         zJfGXIMnOihjjjA820ZreCAFgl5sUeiWBFiQ5Hoh9X4RQ8haHe4jnTpszVcCGyLbTB64
         8vQVqHmv8F/LlFTXoB61aN0igFTN6c0usM8Cq7m56iWRuV1QrQRTsNTTiWmiDEpnSDEF
         2fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218399; x=1690823199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhmw6oCssaqjUN5GauBK6cmFD9VML3oz1aGp0hJ77+Q=;
        b=BISYBCLTmP6KohYDvlEUByg4NHepwllPEJCtIqOoK7/LLTsBZkvQ97Nh1IGiY3WOU+
         nmgDX8MU932ZMrPjQzvSQGdTA9R4o/AdEYLkWqMr++FtqI4EecXylwlUOXJRl5URCon4
         skQyXZk4jHMiVByccrwMRxzMZlPchH782bMIy0ccxdy8DQQGQExXLfq2cC/XeP4HsQR9
         UZMABi5Xby2aukOnEcWZkBtbnuLeID3cU6u1pMqAzC2kkVUqcIK8W5xOQLyiUkZjl9nL
         JYyHHMfb+AGiHmOQqR9H16zLWFguQ0m6QoNVvc7ns14BKjW3PBPIPm7msgdxPHAVjyBp
         5pZA==
X-Gm-Message-State: ABy/qLY4Ou2gJlymIYAsvc2ZYBeDsaTDqrb5Oq2wAOtrEu7HSkR0Tjv6
        ME88Iqes2DUtJnBGxH3SHX5l9EDnMnEcjXZi0uygSZEM
X-Google-Smtp-Source: APBJJlHKfnvfvSS8a+ojyZe0AeVKEWnN1RSLjmotm0X88Lvre6E9gDz+3Zvy2hxuNfrOvZra7NKxQdIrWkU4j0s7Zj8=
X-Received: by 2002:a2e:8047:0:b0:2b6:e2aa:8fbc with SMTP id
 p7-20020a2e8047000000b002b6e2aa8fbcmr5954308ljg.8.1690218398189; Mon, 24 Jul
 2023 10:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230712122135.7734-1-claudia.rosu@nxp.com> <CABBYNZ+8MvwrB_50=cugsdTKSv_DSFePErb3w-7NestCT3nwjw@mail.gmail.com>
 <CABBYNZLEPLrm_rZ234_pxNNzi8Ls646B6nCybW8F7S6fnD8qSw@mail.gmail.com> <VI1PR04MB534401E37042C36D7FE9531AEB02A@VI1PR04MB5344.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB534401E37042C36D7FE9531AEB02A@VI1PR04MB5344.eurprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jul 2023 10:06:25 -0700
Message-ID: <CABBYNZKoreO2Zjj-qik02wS0SGp=LnbaimBsYFBn5C-ARDRqRQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v2 0/6] Add support for BAP broadcast sink
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>,
        Claudia Cristina Draghicescu <claudia.rosu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Mon, Jul 24, 2023 at 8:26=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Hi Luiz,
>
> >Hi Claudia,
> >
> >On Wed, Jul 12, 2023 at 10:45=E2=80=AFAM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> >>
> >> Hi Claudia,
> >>
> >> On Wed, Jul 12, 2023 at 5:46=E2=80=AFAM Claudia Draghicescu
> >> <claudia.rosu@nxp.com> wrote:
> >> >
> >> > This series of patches adds support for BAP broadcast sink.
> >> > It consists in registering a sink endpoint using the Sink PAC UUID,
> >> > discovering of broadcast advertisers that announce the Broadcast
> >> > Audio Announcement service, synchronizes to the Periodic
> >> > advertisements of the source and synchronizes to the BIG advertised
> >> > in the PA train.
> >> > To retrieve the BASE info advertised in the PA train, the patch
> >> > Bluetooth: ISO: Add support for periodic adv reports processing was
> >> > used.
> >> >
> >> > This feature was tested using bluetoothctl with the following comman=
ds:
> >> >
> >> > [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb
> >> > 0x06 [/local/endpoint/ep0] Auto Accept (yes/no): y
> >> > [/local/endpoint/ep0] Max Transports (auto/value): a
> >> > [/local/endpoint/ep0] unicast/broadcast (u/b): b
> >> > [/local/endpoint/ep0] BIG (auto/value): a [/local/endpoint/ep0] BIS
> >> > (auto/value): a
> >>
> >> Ive thought we would be using BAA UUID instead to follow the same
> >> setup as the broadcaster role.
>
> We think adding a new UUID for the broadcast sink (0x1851) along with the
> UUID for the broadcast source (0x1852) is the best choice because we need
> to differentiate the endpoint and transport in other applications like Pi=
peWire.
> This follows the same procedure as for bap unicast where PAC_SOURCE_UUID
> and PAC_SINK_UUID are used to differentiate between BAP unicast source an=
d sink
> endpoints and transports.

Sure,  I wasn't aware there was a broadcast sink UUID, anyway the
point is to have a similar flow for both Broadcast and Unicast.

> >>
> >> > [bluetooth]# scan on
> >>
> >> Then while scanning if we find an announcement it should create a
> >> remote endpoint under the device object path, just as in case of
> >> unicast, which can later be used with endpoint.config.
> >
> >I had a few more thoughts about how to enumerate the remote broadcast en=
dpoints, we may want to introduce a driver for BAA UUID so when a device is=
 found with BAA as part of the advertised
> >UUID would get probed and the driver can take care of creating the Media=
Endpoint objects based of the advertised data, probably each BIS should hav=
e a endpoint,
> >
> >> > [bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
> >> > /local/endpoint/ep0 16_2_1 <source_address>
> >>
> >> Here then one would replace /org/bluez/hci0/pac_bcast0 with the one
> >> found during the scanning, so the difference with broadcaster becomes
> >> the source endpoint, if you pass the adapter it is for broadcaster
> >> role or in case it is a remote endpoint the it is for listener role so
> >> the commands would work similarly in all directions
> >>
> >> > Claudia Draghicescu (6):
> >> >   client/player: Add broadcast sink endpoint registration and
> >> >     configuration.
> >> >   client/main: Add broadcast source discovery
> >> >   media: Add support for a broadcast sink media endpoint
> >> >   transport: Update transport properties for a broadcast stream
> >> >   btio: Add support for getsockopt(BT_ISO_BASE)
> >> >   bap: Add gdbus interface for BAP broadcast sink, create
> >> >     synchronization with source and create BAP broadcast sink stream
> >> >
> >> >  btio/btio.c                |  13 +-
> >> >  client/main.c              |  57 +++++-
> >> >  client/player.c            | 187 +++++++++++++++++++-
> >> >  client/player.h            |   3 +
> >> >  profiles/audio/bap.c       | 347 ++++++++++++++++++++++++++++++++++=
---
> >> >  profiles/audio/media.c     |  35 +++-
> >> >  profiles/audio/media.h     |   2 +-
> >> >  profiles/audio/transport.c | 244 +++++++++++++++++++++++++-
> >> >  src/shared/bap.c           |  50 +++++-
> >> >  src/shared/bap.h           |   4 +-
> >> >  10 files changed, 888 insertions(+), 54 deletions(-)
> >> >
> >> >
> >> > base-commit: 838e1578072900d1f98dfb31cc538940d2fad876
> >> > --
> >> > 2.34.1
> >> >
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
