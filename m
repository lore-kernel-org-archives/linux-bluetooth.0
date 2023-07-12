Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3FEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 17:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGLRpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLRpW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 13:45:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F61FD4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 10:45:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso23451fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689183917; x=1691775917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6OqCU5wAPQ++4ZxThpOx7EAj7O48JAkR2/f0ypEfZw=;
        b=UVhQngfeQ0EaItQud/jk79ow/fIf1CDO/d6fggFS9GUMQcVJKRRRJE0MuYYetIpwgz
         GOW2BCqILDIcD5/aUmESwttUTN82EjzdUmC088sjAVKD5asy8pe5hEwMov3Ht8/JNNnM
         EVGQA040bL/KKZh38Fk8kkaZIH9qCeDgGepq4vQDXEqb5E7jQyJifgz4gaurSZHSX3SX
         WKMVZMPdBY6ooMdkkXFkBsWtd+fjWAFuVCbfWte4TomlezDK8y2x1aum35b5nOyyBHlH
         gZkPFcPkg2MGTstRCoBC4gRYmbJ2IB78ks7WWMFWk9HsXMuybELWIlSXGdKHLo9p+V0Y
         EedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183917; x=1691775917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6OqCU5wAPQ++4ZxThpOx7EAj7O48JAkR2/f0ypEfZw=;
        b=G4Qnmyl3VQ/MTv+R2487OXkK5zP+5EXZLl6NoAKMQP0Q+Hpj9r+UCpDmybwHPENuYQ
         M/hSd5FZ20/SILOAgq/Jtz+rux/mc5Sp1UcaNirOB9aJ4InwpKzZTlCH2brsH2nwOj2Y
         LmRQeJ4duV+s7CBegvb4cpQQLecUT96qle7oE4Oc9jzRGdPdxFDnqh9u7bXkGSGmOHU6
         ZocY1uxFmkRYSgaWpPoLUTcbhj/tAcO+uXbeAMjFWlqxZQffetO0JJhEJKl8MDyfjAmB
         ieBoYI3QMMsnUchvmiVIF9XqmK4AWQvFRViRAXWjOvA5E2Ul8Qfn3NQzji3Iw0qUNHc3
         ZiUw==
X-Gm-Message-State: ABy/qLY67+3gpcGgmWmckaFOT//WGqAehvLwXJmTjUQPPoO/pZkPNRTB
        PeHRcPm2gzk/G0kCOVADpERnGJrPGkxc2aAyPNJUZEzW57A=
X-Google-Smtp-Source: APBJJlGobLo5kX/GHTivMOiuS0AQhBAHoYlltbT/jT//WaG6oJdNVL8GsqeFZKiJRfkl1Nzc049iq+15A9F+MtLnRxk=
X-Received: by 2002:a2e:b10f:0:b0:2b6:a694:aaa1 with SMTP id
 p15-20020a2eb10f000000b002b6a694aaa1mr1039040ljl.1.1689183916893; Wed, 12 Jul
 2023 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230712122135.7734-1-claudia.rosu@nxp.com>
In-Reply-To: <20230712122135.7734-1-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Jul 2023 10:45:04 -0700
Message-ID: <CABBYNZ+8MvwrB_50=cugsdTKSv_DSFePErb3w-7NestCT3nwjw@mail.gmail.com>
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

On Wed, Jul 12, 2023 at 5:46=E2=80=AFAM Claudia Draghicescu
<claudia.rosu@nxp.com> wrote:
>
> This series of patches adds support for BAP broadcast sink.
> It consists in registering a sink endpoint using the Sink PAC UUID,
> discovering of broadcast advertisers that announce the
> Broadcast Audio Announcement service, synchronizes to the Periodic
> advertisements of the source and synchronizes to the BIG advertised
> in the PA train.
> To retrieve the BASE info advertised in the PA train, the patch
> Bluetooth: ISO: Add support for periodic adv reports processing
> was used.
>
> This feature was tested using bluetoothctl with the following commands:
>
> [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] unicast/broadcast (u/b): b
> [/local/endpoint/ep0] BIG (auto/value): a
> [/local/endpoint/ep0] BIS (auto/value): a

Ive thought we would be using BAA UUID instead to follow the same
setup as the broadcaster role.

> [bluetooth]# scan on

Then while scanning if we find an announcement it should create a
remote endpoint under the device object path, just as in case of
unicast, which can later be used with endpoint.config.

> [bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
> /local/endpoint/ep0 16_2_1 <source_address>

Here then one would replace /org/bluez/hci0/pac_bcast0 with the one
found during the scanning, so the difference with broadcaster becomes
the source endpoint, if you pass the adapter it is for broadcaster
role or in case it is a remote endpoint the it is for listener role so
the commands would work similarly in all directions

> Claudia Draghicescu (6):
>   client/player: Add broadcast sink endpoint registration and
>     configuration.
>   client/main: Add broadcast source discovery
>   media: Add support for a broadcast sink media endpoint
>   transport: Update transport properties for a broadcast stream
>   btio: Add support for getsockopt(BT_ISO_BASE)
>   bap: Add gdbus interface for BAP broadcast sink, create
>     synchronization with source and create BAP broadcast sink stream
>
>  btio/btio.c                |  13 +-
>  client/main.c              |  57 +++++-
>  client/player.c            | 187 +++++++++++++++++++-
>  client/player.h            |   3 +
>  profiles/audio/bap.c       | 347 ++++++++++++++++++++++++++++++++++---
>  profiles/audio/media.c     |  35 +++-
>  profiles/audio/media.h     |   2 +-
>  profiles/audio/transport.c | 244 +++++++++++++++++++++++++-
>  src/shared/bap.c           |  50 +++++-
>  src/shared/bap.h           |   4 +-
>  10 files changed, 888 insertions(+), 54 deletions(-)
>
>
> base-commit: 838e1578072900d1f98dfb31cc538940d2fad876
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
