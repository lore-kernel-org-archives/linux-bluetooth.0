Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF8C001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 18:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjG0Swd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjG0Swc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 14:52:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882E319A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:52:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso16430851fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483950; x=1691088750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTDYBwnrtmU4tEYWjAn5wR9gSZjZPlSw9u4lZXgN/X4=;
        b=h4madP68UIum4gYbCE4P0QIUVWb38CSZHxgVQrz+pcEGiK+XVT0ueaoZ2p95MZrVCY
         bwJAGdDA/9YbB176NzoxWh5qHcZhybccheFet5kjk/Rd0lghx2DqvTxGvxyMa5FeRHdZ
         nSxke7YhZ0yE4zDzinh0KScakW11MQGAh2EOlkEJg5sji56KWhENKXlXWSvMaQ9p+Ahn
         YMMVhz7xeOWYN6jZX/rSARpxGYe0LaUBePsfvkkxNeqoYUZCYMzHswrifUCW8DZn4DD7
         /+XSiAuZWKIsEyqdIbKGXvuH86m9M3e/QLcHPxIMlX72pwxXGnBtbuTcbILz2Qg82QpB
         J30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483950; x=1691088750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTDYBwnrtmU4tEYWjAn5wR9gSZjZPlSw9u4lZXgN/X4=;
        b=PmbouvzLUkBajqBQDY0WGX4PMWt4mAeHFBF5uusYyEIGvbeOGWN3dyTKNhncao/0g2
         DJuiBGuALyixFUfP/QS7hbh246NtTUupVKufRDcgQ7ieyPCw3fcVa55QmrtB4iOTopir
         wXTteohzCNGfPR+KlpvlmkV/d/FHKRnun+agt+mvfL7PFIX8DaEeVtFIzw9ZIcGyoG+v
         ZLCdOoVaNBP7F4uC8IoXm6YbpTCaASzcMtDC4BCwCsrVCFmLfUG1sJ7hEP0BlGAnb2Be
         kiGZqZfbyYz/MYGvuUUfutPo1qu74x5Ey1XoSoqRs2iWzedvTbRVHJjQS5eQ11aT2EvE
         KdAw==
X-Gm-Message-State: ABy/qLbsVz7RsN5aWsRW7nPDRD8ynJcDuPWdxFFjJyrBMGDh3z3IM3N+
        VhzLPbWOdvy4n4AmYB8XbmUOlvLmzsPhR4hXQOVZua4t
X-Google-Smtp-Source: APBJJlFGvuGG3Da9Hcpo8UStGaUnrbUvQ00mNWplvlfQrHZyb8Mt0b+f0WYje6KjLtvtaPIgodx3FwHPnbQCHYl3fPo=
X-Received: by 2002:a2e:8e72:0:b0:2b9:a588:50b9 with SMTP id
 t18-20020a2e8e72000000b002b9a58850b9mr1184017ljk.18.1690483949527; Thu, 27
 Jul 2023 11:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com> <20230725084431.640332-3-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230725084431.640332-3-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 11:52:17 -0700
Message-ID: <CABBYNZJ0ZNe1vUvjkP5RD8NQ_3HkCyO-09Qciq9s2Y+Tkxno+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/8] adapter: Be able to use ConnectDevice for
 discovered devices
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Tue, Jul 25, 2023 at 1:56=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> This can be useful when you want to specify trasport type for already
> paired device (e.g. use LE transport for dual mode device).
> ---
>  src/adapter.c | 3 ---
>  1 file changed, 3 deletions(-)
>
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

While this is probably a good idea we need to document it on
adapter-api first, also not that Device.Connect could be used a second
time to connect both transports but this seems to be a better
alternative if one wants to bypass the daemon policy of connecting the
last seen bearer first.

--=20
Luiz Augusto von Dentz
