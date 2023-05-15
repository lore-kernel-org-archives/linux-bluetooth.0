Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08497C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbjEOTR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjEOTR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 15:17:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF79030
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 12:17:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so130635981fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684178263; x=1686770263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyOZ0oIZTfkXxnAAAuTIV2J70qHGcyFE8nzCDXGSNj8=;
        b=XcDuBr8Ulcysmx6MfgDl/yVvMZ/a5yXTag7418Ro5t+aXF1bD92fZQKZTvA2D8+d8l
         2Y98dZV2sS5ls0SHJrd720l+YhdJJzT+gC+4CUBxDo0bNmUiViMqsToa4O3h5rz6tYud
         VnZEPJeMpJal2IrM+9px/p9nJ+pukg6VlPqDuQh2XywbszLLH+KzpYhzfhep/qAtR5XZ
         qYIY+NfpIyB5wI430aska7WCn3Y5xqyQy+WeMFVuVBeWm+T1YIeKyRZhtW3exjC+GE6B
         bH+1tHn13v1t4cFKyg5eaGVX2RTypNVfbjIuoeXTEb1cHVVKWnutGOD9vpV0TrRCqahm
         5fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178263; x=1686770263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyOZ0oIZTfkXxnAAAuTIV2J70qHGcyFE8nzCDXGSNj8=;
        b=dBrMl3A+TGQ2bRmvjy+ihV6N4GRIVEG+DZNIbNFNTfv+NogrBsa8dizKJeXkVbQntu
         spuwTx7H/ChuD9EOihNGQi+cf66kOZ4ZOva743CrO0xNWlbDE0wT/cflV8cKFrZVyl7a
         8UufRMM/0hWWKES702jOEstBUeEyrh1Jeu9k8ifxYDJ1rP8cq6xxAPcxCL9aMYtT7UIu
         mTz5qj9MqeYey2Q/geCetxT0xGPd6gd8sNH/VZP/7kDZtK2ykudfATStewN6ZBS907Ql
         HFMlmw69nq2C9MhuANIx5fhLr1R2l/oWX8alZ6BLJO7NhrwZddGiw5HZCc/u2iIrtSVk
         ju+w==
X-Gm-Message-State: AC+VfDw0iX7nORqHsN363/8oJ64/7E8v3I1mx8MQVxVOXpBlI19KR5N9
        Fg/JUI2rCXmDoS5SglIDPqJiPzHaTwMnuYm4EisjsZJM
X-Google-Smtp-Source: ACHHUZ6/v2hozTj0K10BMgF+J3vwmtia5i+ZNPw9JB/h1sGzcEBg2dPdYdeXSNFKmA0Pe4qeP03LDeOvaFAjqB+Fc8I=
X-Received: by 2002:a2e:93d5:0:b0:2ae:d757:4c41 with SMTP id
 p21-20020a2e93d5000000b002aed7574c41mr1927069ljh.23.1684178262851; Mon, 15
 May 2023 12:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230511002252.30868-1-alice@ayaya.dev> <20230511002252.30868-2-alice@ayaya.dev>
In-Reply-To: <20230511002252.30868-2-alice@ayaya.dev>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 May 2023 12:17:30 -0700
Message-ID: <CABBYNZJu2bWA=RprU88Q3DhRmmcVEJUPrDmT2-WMEdkLGDe-ag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] client/player: use long long for off_t print
To:     psykose <alice@ayaya.dev>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Psykose,

On Wed, May 10, 2023 at 5:42=E2=80=AFPM psykose <alice@ayaya.dev> wrote:
>
> %lld is guaranteed to be a 64-bit int, which we enforce via
> -D_FILE_OFFSET_BITS=3D64.
>
> Signed-off-by: psykose <alice@ayaya.dev>

We don't use Signed-off-by for userspace patches.

> ---
>  client/player.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/client/player.c b/client/player.c
> index 7719076c8..856997319 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -3578,7 +3578,7 @@ static int transport_send_seq(struct transport *tra=
nsport, int fd, uint32_t num)
>
>                 offset =3D lseek(fd, 0, SEEK_CUR);
>
> -               bt_shell_echo("[seq %d %d.%03ds] send: %zd/%zd bytes",
> +               bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>                                 transport->seq, secs,
>                                 (nsecs + 500000) / 1000000,
>                                 offset, transport->stat.st_size);
> --
> 2.40.1

Perhaps we just promote offset to intmax_t and then print with %jd,
that way it should work regardless of the actual size of off_t.

--=20
Luiz Augusto von Dentz
