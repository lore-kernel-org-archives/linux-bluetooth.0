Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593D8C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 00:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjEaAXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 20:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEaAW6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 20:22:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2FC7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 17:22:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af30a12e84so55279201fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685492575; x=1688084575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwsK7cOqI5ghHQotajkswOPYQY/BYp0XHEVvEGMUwGs=;
        b=HY2jjn/SS8T+0yUfAGFczliF5RJANcLc8Xb82P8Ttl7QQfg6f0lkuIeLu5ZpfcO6dR
         1DtNF2qCpZCPIDIBPL2OLug1YGiy1BefKc7v3LDnl2dR0tSFrNRSucZdtsm8Bpz0wOyn
         HSyGP7vSTnFZoBgPEmA8pnSMsenOcZSJ2+4L/r/Z5oyiElpfQsYKPXRBf1TTaS3NRAki
         ZaY0BDymJTBNdQo6gOpOE9kJ0mOJ1trwbLrmBzyZLJgaEWJINmLmwZUnc/3n13hlh0VR
         OCXTXWhmfTtxNNEwMQY2yxh7t964v7bRIkS80OpfRAccsbtT45AiUQF7DMfT4qQ2qdXE
         Z27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685492575; x=1688084575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwsK7cOqI5ghHQotajkswOPYQY/BYp0XHEVvEGMUwGs=;
        b=GnWzfvh38FqIWTtSPW9dMczKAwouiUHXf/smT26t4wQSYvTq9bByhwYPDStd+u7DjZ
         1CsPnsJQUTWp8tGpCO61aecTIWawKeCi88hAIzMbLk24b+TAbv1ztbwDupWoiAzIXpUh
         pzL6VDtuGDDb3D5caJtjT1DoY7ODpQoSZjVlNyHEZZTvvL0n4wxO5n7XD7+HXvFIPgXq
         7C+YWtbc8c/VQJJnNTypawunXfNEgsCJspYFPFkGm//p1INVXV7cN/ACsT3dXKjv5p+V
         eBdtcEzyx5dNo1N+DUmJMpLLZhez9p3U66wxkD/0XrEH1csGOJErhXIIkCCS/gBjZJPn
         0a+g==
X-Gm-Message-State: AC+VfDx6uO6dh1OsH961Bk0ZP/Bg2akfDqP5zoYV6Uj50Kg+PxTw/MQj
        LxMjm8HxiYH0+e6HEQzlFr0YOjIesepjSNMSmKMtiOC2RXk=
X-Google-Smtp-Source: ACHHUZ7vp6je5JFCVebvrq6IUb6QHN68fLCymTyOHkeqvrnAMjHnlBr5VPhZ5/qQ1H8Jj7dZiSlvr2mvDGI52ie/eYM=
X-Received: by 2002:a2e:3501:0:b0:2ad:b674:a7a3 with SMTP id
 z1-20020a2e3501000000b002adb674a7a3mr1702127ljz.31.1685492574693; Tue, 30 May
 2023 17:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 May 2023 17:22:42 -0700
Message-ID: <CABBYNZJ1=ehCm5aDnOO=Zk1gYcxzMk6w0+ASaCrccWTNZWoGHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/4] Add initial support for BAP broadcast source
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Tue, May 30, 2023 at 7:15=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> This patch adds initial support for BAP broadcast source.
>
> The current implementation allows BAP source endpoint registration,
> media transport creation, transport acquiring and sending broadcast ISO d=
ata.
>
> Currently, one BIG containing one BIS is supported.
>
> To test the current implementation use bluetoothctl with the following co=
mmands:
> # endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> # transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/=
fd0
> # transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0=
 <file.wav>

I was trying to test this but it doesn't work for me:

transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0
Transport /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 not foun=
d

Anyway I would suggest not to create the endpoint at
device_00_00_00_00_00_00 as that is sort of overkill just to be able
to broadcast, instead we can probably expose it at adapter level e.g:
/org/bluez/hci0/pac_bcast0, and we configure it like:

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep3 [preset]

> The curent implementation checks that ISO_BROADCASTER is suported on the =
board so
> "Check for ISO support in controller" patch is required
> (https://patchwork.kernel.org/project/bluetooth/patch/20230510134557.1148=
6-2-claudia.rosu@nxp.com/)
>
> Silviu Florian Barbulescu (4):
>   Split bt_bap_qos structure into unicast and broadcast structures
>   Update bluetoothctl with support for broadcast source
>   This adds the initial code for BAP broadcast source
>   Update BAP plugin with broadcast source support

Btw, please use proper prefix e.g. shared/bap, client/player, etc, and
there are still some lines that are over 80 columns that need fixing.

>
>  client/player.c            | 223 +++++++++++++++--
>  profiles/audio/bap.c       | 478 ++++++++++++++++++++++++++++++++-----
>  profiles/audio/media.c     | 142 +++++++++--
>  profiles/audio/transport.c |  57 +++--
>  src/shared/bap.c           | 370 ++++++++++++++++++++++------
>  src/shared/bap.h           |  80 +++++--
>  unit/test-bap.c            |  75 +++---
>  7 files changed, 1168 insertions(+), 257 deletions(-)
>
>
> base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
