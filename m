Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0ABC7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 00:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjFCAX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjFCAX0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 20:23:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6D1A5
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 17:23:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1a6777dd8so30640441fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685751803; x=1688343803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ktxA7OaCrS++b79xJMbVK9k6ccfN9ST0oT5GbkoBw=;
        b=qBxY+2yHP6mLmJfJ70KggSCLyfZwODZU3YiDaUwA80Tk+TICRvWzcF6TRFC6ZoKL9q
         KshlAisPnV80NepK0nBdzU0MkZ1iBUZWtqgAMLFHZv97Igd2JM4cHLgaEE68c4Y/XpAU
         U7smEKN5P6ZlXyfVnnjqXcxWW9s0nAuXLZUcZfhOk7SSn8PD3kd9sR2vuzBHNrqtORQW
         UKqURD/WR9tj1kpg6bk55Ftudu065J7LbIq4OZ45nlOqlL5aXTvoWeQJdemxb8YEsetJ
         4lAiOOaMV2mDV9/gBJhvGCeAD0r36xsQQWZa0d+89XAGwI4zIHHiz8vfEFYPg6/hc01+
         NelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751803; x=1688343803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ktxA7OaCrS++b79xJMbVK9k6ccfN9ST0oT5GbkoBw=;
        b=Ns5tf7i9MaUUJcdN5XcjeZSCNzD6Cep0kjZn7rUoljQsM9Pc7uAOBUnedwbPNMLyuu
         JBIMj53mk0S56ORL1xxameWkxvXtLbwryBxmi+JsNZaYvXo6jtxO1f7BBpsC1ZTmVzUb
         Pq48t4y3RHrwLbMyyjpK6qFLblbLl0k/ZMA1d92sLEwzxM/nzKCex3f80+yuJY4SAdSD
         AS2AfSP8Q8Yu5xAOo/85W/tvLhkQIXQRdCJ1+2z2bw8cp8kf3UKZl6zMajHcgEA/iv4o
         VOQk2arRW3WZEFMZy5H9wmEOdaFLlORC6CqASoRRp9q1G7o2OCzrEpuAPp6QgvepnVR0
         y8EQ==
X-Gm-Message-State: AC+VfDxOeUoAk+RJQVkzxdbYV+QzD2qx9rMyz51ebnINdk1eMpWka+is
        c+eCaYGBpRxgwIfXerLBfQ1WZRiVyTpQNikX/ZHbhH1O
X-Google-Smtp-Source: ACHHUZ5gYlP0vNJ7u+jr5yXPl+QVaO2p2Q8nstoFn4vMDR2B7s6IIdCzVkwhVYqI4kr5yVOYuyBLaPUnkEwJpaVkVMw=
X-Received: by 2002:a2e:960b:0:b0:2a8:ac5c:d8f1 with SMTP id
 v11-20020a2e960b000000b002a8ac5cd8f1mr962875ljh.1.1685751802941; Fri, 02 Jun
 2023 17:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230530141339.100733-1-silviu.barbulescu@nxp.com> <CABBYNZJ1=ehCm5aDnOO=Zk1gYcxzMk6w0+ASaCrccWTNZWoGHA@mail.gmail.com>
In-Reply-To: <CABBYNZJ1=ehCm5aDnOO=Zk1gYcxzMk6w0+ASaCrccWTNZWoGHA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Jun 2023 17:23:10 -0700
Message-ID: <CABBYNZ+u_7Lj6Emc1pz=WRw-Eg2CDxsaynOOzVF4k4JXmDtM7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/4] Add initial support for BAP broadcast source
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Tue, May 30, 2023 at 5:22=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Silviu,
>
> On Tue, May 30, 2023 at 7:15=E2=80=AFAM Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com> wrote:
> >
> > This patch adds initial support for BAP broadcast source.
> >
> > The current implementation allows BAP source endpoint registration,
> > media transport creation, transport acquiring and sending broadcast ISO=
 data.
> >
> > Currently, one BIG containing one BIS is supported.
> >
> > To test the current implementation use bluetoothctl with the following =
commands:
> > # endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> > # transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast=
0/fd0
> > # transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/f=
d0 <file.wav>
>
> I was trying to test this but it doesn't work for me:
>
> transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd=
0
> Transport /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 not fo=
und
>
> Anyway I would suggest not to create the endpoint at
> device_00_00_00_00_00_00 as that is sort of overkill just to be able
> to broadcast, instead we can probably expose it at adapter level e.g:
> /org/bluez/hci0/pac_bcast0, and we configure it like:
>
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep3 [preset]

Are you planning to continue working on this set? Or are you waiting
for some more feedback?

> > The curent implementation checks that ISO_BROADCASTER is suported on th=
e board so
> > "Check for ISO support in controller" patch is required
> > (https://patchwork.kernel.org/project/bluetooth/patch/20230510134557.11=
486-2-claudia.rosu@nxp.com/)
> >
> > Silviu Florian Barbulescu (4):
> >   Split bt_bap_qos structure into unicast and broadcast structures
> >   Update bluetoothctl with support for broadcast source
> >   This adds the initial code for BAP broadcast source
> >   Update BAP plugin with broadcast source support
>
> Btw, please use proper prefix e.g. shared/bap, client/player, etc, and
> there are still some lines that are over 80 columns that need fixing.
>
> >
> >  client/player.c            | 223 +++++++++++++++--
> >  profiles/audio/bap.c       | 478 ++++++++++++++++++++++++++++++++-----
> >  profiles/audio/media.c     | 142 +++++++++--
> >  profiles/audio/transport.c |  57 +++--
> >  src/shared/bap.c           | 370 ++++++++++++++++++++++------
> >  src/shared/bap.h           |  80 +++++--
> >  unit/test-bap.c            |  75 +++---
> >  7 files changed, 1168 insertions(+), 257 deletions(-)
> >
> >
> > base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
