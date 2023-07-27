Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A8C00528
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjG0Ssd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjG0SsZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 14:48:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB030FB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:48:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703a0453fso19901491fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483690; x=1691088490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfSIJHKVO4u5JFm2gLQ1JdCqsnXydYIvBCEF/5n3SZQ=;
        b=NHFRwP9CISX8G2xagBQUoP9L//iOwFAwa3Tw8ybCeAxROTO3JSyQNTIbDtjhpeZLBN
         468MqA0+zBYJqd3oqNfJz8t4qJ2ow42vV0qQbrcYbS9wot3Fhjrq25xYTcTipQ8KhCBC
         0I7693eFWk8kghChuZwzNgqRUxHYbnvM/Io6QVlpsCr0NBLrWcpGyIb2JU0aY9+NnKDQ
         Rhc9MmUiLt7nnSkntuJ7rZJh6I+gdv8P4qokj5vXjMXRPAjPdK/9HhikVSlWGQx/7eL2
         0wLDvcAeOJaOgxZuo66x7UlEIF6cnAM0i0rwhbGZ7uk+fPHzfTL/D+peuqGr2HbGExqN
         CWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483690; x=1691088490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfSIJHKVO4u5JFm2gLQ1JdCqsnXydYIvBCEF/5n3SZQ=;
        b=dMPBJ+sf364FQLXspLlGYh7PNrcrKZA+dzi90qhpb+/Oa/MqKZN2Rm5elM+ASIU9E/
         +R0hS4bwW1poUrS3E9Q6K6fU+7b8/n1PsQQrHty6b5sdnpc9pNxYwLXIwJIbeso8mVpy
         fCKvgi1ffWfZpS0UAPqKmnIpl4G5kMHU3UWh0xMBIfImKG3faSx1IXECrOcu3Au0cN7s
         J2Qnvi6GEe+hOEFjzq8wvlUkEMmCVpj21tcqubyO/54MUWOWDliynOCeQzm9ZiaG+DRL
         mbHvPsGyImVcRxRcWTyme/I3K0+m1dS5tYFjtp/fYolCbyFZukEtfKH6EVIGsM/CLl2V
         Q4JA==
X-Gm-Message-State: ABy/qLZQ7i+W62GVgIOYCzqGXoul6V9yedqhn6MQE4Er9QnIrBzxmdub
        Bs+/zt9lbz7t3mcG8su1e6DLM6uxOmIZi0dYjnSMbs1D
X-Google-Smtp-Source: APBJJlGCLkX5ZnBdvZm1bYs3b0eZm3rwZXQwKwe0Mv0BxVKL0XkX4l19zf6Xlx+/FXqTQeP9fyWz2w7M0nYdFqpfybM=
X-Received: by 2002:a2e:7304:0:b0:2b9:cb86:ef0f with SMTP id
 o4-20020a2e7304000000b002b9cb86ef0fmr616204ljc.32.1690483690125; Thu, 27 Jul
 2023 11:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com> <20230725084431.640332-9-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230725084431.640332-9-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 11:47:57 -0700
Message-ID: <CABBYNZ+yGTjzDwGCzf7ShUejDRz-THfh8w_=+Cn7xupxXogHng@mail.gmail.com>
Subject: Re: [PATCH BlueZ 8/8] adapter: Ensure that file exists on IRK write
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
> ---
>  src/adapter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4c3bb091d..fe8ae7604 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8823,6 +8823,8 @@ static void store_irk(struct btd_adapter *adapter, =
const bdaddr_t *peer,
>
>         g_key_file_set_string(key_file, "IdentityResolvingKey", "Key", st=
r);
>
> +       create_file(filename, 0600);
> +
>         store_data =3D g_key_file_to_data(key_file, &length, NULL);
>         if (!g_file_set_contents(filename, store_data, length, &gerr)) {
>                 error("Unable set contents for %s: (%s)", filename,
> --
> 2.34.1

This looks like a fix as well so reword it and send it separately,
also please add the runtime error in the description.


--=20
Luiz Augusto von Dentz
