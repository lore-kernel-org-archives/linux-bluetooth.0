Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD2C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjG1Rss (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjG1Rss (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:48:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DE3588
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:48:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so4016271e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566523; x=1691171323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUVxgr2AboIe788gre9SEUahrkyEM9bee7EOqosWQJI=;
        b=MXMOiS8Dmo3066m1iGNXXJUl0y1wEtPvaT7b7v4/hF6GTJg7zJoc6HpH+mplf2Ujb3
         e81n3n8Z3rt5Tf5/J85kA5Ions2/52tBcvKfj/EtpNcfvapQt7D5t43vpE1vadYpWf7O
         n6IJF7H42yKBkxrko4c3oYyviaRC2oNJdbLIzvkj4X3KRjOxBTaz8tsaHscqNwdgEIff
         44mHkHkIx/y+yg4FQRmps99Dn3LVOrioAp6w08MWkdztNYf6YNjrf1/re+b3JOsmE25H
         fo9MNMRlsBv9sDM+Af4vY64Npy0wSzVUi4q2xb1zAokV/f76EyDGA22iCbWwl1bWkq+C
         upkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566523; x=1691171323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUVxgr2AboIe788gre9SEUahrkyEM9bee7EOqosWQJI=;
        b=WVD0lsyPgB5ZF0JGOO6krvQEQorNdDHuMF6ykC8T/6eKfJVZGgxRtG8hwBbWrNE7Z7
         0aIWSHiXPIYJCYdTgZuAN4G1QFZ7sCL1FXcad/K5B+Cxrg343gf0ag7WWfWG+GReD9+2
         DDMpDwPMaif5RpcSvAne2orAolJHmYuLsxvKeZG33hQMDIr4VoC7Ma0arVQ4/H2lVOUR
         Skx8dOV/wZGXmnUDD0ibLaRGWg7ypkcto6Rjl+B5o8l0F/60FGGYD6TcHBDRuYAaGr0X
         Q0DEnuU6sEt7/Q2ESIwG4jfmCPIwm2K0c31QnQq6ewZfFPucahe5J31HebszO1CSWVgv
         UlIQ==
X-Gm-Message-State: ABy/qLYFGURwEr7BcR+dPjyKxvw1YJI9AO6BMtFz3Nhp0kw3d+QiPJ1I
        hTiDLh1yDKFlWT2Ik0CbMH9QpZ09CBqJ2dYtT/Q=
X-Google-Smtp-Source: APBJJlEoebiuQ/Gk1+LoS2Su3yHEgH/8kmy5B4b4nGO6KuzdXHWS/IRvy17yqoxZm1au7GuAQG4XnWHiBuX8oPlBd0I=
X-Received: by 2002:a2e:9198:0:b0:2b6:d603:7667 with SMTP id
 f24-20020a2e9198000000b002b6d6037667mr2436180ljg.8.1690566523168; Fri, 28 Jul
 2023 10:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230728052506.582394-1-simon.mikuda@streamunlimited.com> <20230728052506.582394-2-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230728052506.582394-2-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Jul 2023 10:48:31 -0700
Message-ID: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] adapter: Be able to use ConnectDevice for
 discovered devices
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Jul 27, 2023 at 10:46=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> This can be useful when you want to specify trasport type for already
> paired device (e.g. use LE transport for dual mode device).
> ---
>  doc/adapter-api.txt | 2 +-
>  src/adapter.c       | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 9b2721c1b..239d9463d 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -182,7 +182,7 @@ Methods             void StartDiscovery()
>                         profile will be connected. There is no need for c=
alling
>                         Connect on Device1 after this call. If connection=
 was
>                         successful this method returns object path to cre=
ated
> -                       device object.
> +                       device object or device that already exist.

Perhaps we should mention the intent here is to allow applications to
specify what bearer to connect as opposed to Device.Connect that
connects on the last seen bearer first.

>
>                         Parameters that may be set in the filter dictiona=
ry
>                         include the following:
> diff --git a/src/adapter.c b/src/adapter.c
> index 2679d4302..17f4a637d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3763,9 +3763,6 @@ static DBusMessage *connect_device(DBusConnection *=
conn,
>         if (!bacmp(&addr, BDADDR_ANY))
>                 return btd_error_invalid_args(msg);
>
> -       if (btd_adapter_find_device(adapter, &addr, addr_type))
> -               return btd_error_already_exists(msg);
> -
>         device_connect(adapter, &addr, addr_type, msg);
>         return NULL;
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
