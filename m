Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7CC001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGZRK7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGZRK7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 13:10:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0532126
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 10:10:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b702319893so104522601fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690391456; x=1690996256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik8ZwSu5T4EXDiNvC+FWhWa6uj7Vx2ERwidY4Ti3bjI=;
        b=oDusZn2isjPNC/QvVlPg2GObsXJ3EGpBFLliiMOxw4lbDFQWwcKzj+a8/se11sEewc
         lxHXX4kQSsD6W2yqWuurOUcpIAO6LZYvhLMfUQKgUpUyVoj0wp8qSdT/JrX5ztcnpSbo
         hTxjkS9XvWsPWxz7bUll8IPBsUhFuw/sBRITGfISitBzlzHF38LbGtmWdGGJcMzsJW/S
         tT8IvJ4EZcexhvd0cmJJCBSMuYJQMB9iVeg71Z6nldkVOMGkiB32LtPXapUhxLPzPtwM
         W4mysdgDfD62ARSfJwU0kbHliHxluNB/QC8pGriTM4aP9AHFGVk0jUplPU2VnQzflpbg
         3nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391456; x=1690996256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik8ZwSu5T4EXDiNvC+FWhWa6uj7Vx2ERwidY4Ti3bjI=;
        b=ceDlGSjLFXNTzQ7ZY6C6Nz8ebyVi4LDtFoEL8sB/hyJ0UXDrnW9JkfWBk5JMPxVZjc
         mpdLaEktN3oNGbsvekl4hukRLugsJxgehEHdwfMywdhgMDM9Ue7QgEjfvVsfy3nml6Xc
         ULXwhfytjJBCFIovVcXGkS8f0PRlUoaN38jdCfaDpGCeEz1M86fuJzqe2/ymZEIDVpjh
         nK25XL2FPToaLo4fGm4/3/8zdfSdtT5TkdlwWT+IBJI8t8NZ1sTFaA9AvqQIGmD1WtB3
         tl+WL2oajarSCydQQRbaUCM9bfKVs9SakYYQ/Wu6dtvqChcCyOmuOpfeC2f2ZViQtvls
         WWvw==
X-Gm-Message-State: ABy/qLaGvzKh3rDMhoKcC8+PvB+zb6teJGhdp9xz4KuhccPdTEod9t6X
        4TWoQ2B5hgTSBHUDlcgAzI7caE6cqb7Zf9mnKO1V/u/r
X-Google-Smtp-Source: APBJJlF7nPCgbneHhCfuH+zcAl/wm3kQ11fEq3iqWoPYaeYqAmBw8Ze8fK6/580BPfCX11DHCmPxGIAxWsZfbuPgb3E=
X-Received: by 2002:a2e:8743:0:b0:2b6:e283:32cb with SMTP id
 q3-20020a2e8743000000b002b6e28332cbmr1923127ljj.23.1690391455934; Wed, 26 Jul
 2023 10:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230726145303.137597-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20230726145303.137597-1-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Jul 2023 10:10:42 -0700
Message-ID: <CABBYNZLJeeE3SG1wfjkoy3aihSAQnS3YDkbhw0GGJFBrcs9oUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/1] Rename BAA_SERVICE to BCAST_AA_SERVICE add BASIC_AA_SERVICE
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Wed, Jul 26, 2023 at 8:03=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Rename BAA_SERVICE to BCAST_AA_SERVICE and added BCAST_AA_SERVICE(0x1851)
> as UUID for the broadcast sink.
>
> Silviu Florian Barbulescu (1):
>   Rename BAA_SERVICE to BCAST_AA_SERVICE and added
>     BASIC_AA_SERVICE(0x1851) as UUID for the broadcast sink.

How about BCAA and BAA instead?

>  client/player.c            | 8 ++++----
>  lib/uuid.h                 | 7 +++++--
>  profiles/audio/bap.c       | 2 +-
>  profiles/audio/media.c     | 2 +-
>  profiles/audio/transport.c | 4 ++--
>  5 files changed, 13 insertions(+), 10 deletions(-)
>
>
> base-commit: d8ca06631b7434ea8837f9c571bfe31d6602d31f
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
