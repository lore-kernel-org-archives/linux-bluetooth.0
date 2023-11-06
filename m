Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2996DC4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjKFQ0i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 11:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjKFQ0g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 11:26:36 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B32D51
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 08:26:33 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5056059e0so67371011fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Nov 2023 08:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699287992; x=1699892792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4vlVYMPfkiJdK9hdtcKI8OfdrUsbCVruswCBH2HGfw=;
        b=mtPm68o1R9A2izwkjHr8XpSJsa3lDgJ44sLZgGYL59uhHcqe1oWNCNDHbH2Y7A4Rv8
         t4h3YwcWJ4pepSN5YgY2afeF8EVzrQSsVRMnMrBGqZcoODGPU0YZGou+oOiLIMIYEv/M
         k9I8x85cRrwsQGejOxNgyQrL6+sA7/0Rny7Um/gUh9kM7WkviVRfVGutAFgVqJ1jdesJ
         xAvFz/RXySHj96sRrX+SHPwKq63kGObMjiup+yXNI3YnrxCxh31xl6VWgCQqU/XLxIFP
         JOZp1oW2uxsxAOuIAWY/EYHkmQTi+o9G8WKsy+lY3TgaXwIRi6GyN8KGEgRmylfEvO7h
         PKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287992; x=1699892792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4vlVYMPfkiJdK9hdtcKI8OfdrUsbCVruswCBH2HGfw=;
        b=ZNJGlirkdHWSBvi6F37BM+sEsfU+Re6egkC9uLA7kk1QfQ2BkAJtKfuf+P9b7VG/+S
         EclBvQ39PhwBWh5LM6af2XVQYHX0a25e7Ks3XS0moOQSRTNzXGEsVtfNJ9JRJH6Umw84
         jJvZVZZHvSYEaKa+/daOrxWXRw8OBqFh14QpN0lrW0XH6LyWbcdL8EAyvs9gBl3yU2ml
         NvlL/AlYos8NoQmiiwsL72CxAREFW9chbYob0SpfTfpOuWP9g358kCiyXe8ne4YaSFds
         FjI9CbuLAODzrpU5ybdzxvCkWosif2S+axHwl5iUlUiQR/Pu+ptcj6P2SXBuMPdx/B5w
         vRjA==
X-Gm-Message-State: AOJu0YypxuujhMqZ47sSnnb1c+iPFoOmYmz03jhk1cf9M9DXEutbeMqS
        Rc2IZTtIT5SVpTcootTn2f2mXf8z0/628WoNdx0=
X-Google-Smtp-Source: AGHT+IG3BFrKA08FjhsZ9ddXCP957d7+7cPmgInO554C26PDYDlG4fK9kjyIV5y9hNL8XXnVIQQcdVrwZ8SESzdoiLw=
X-Received: by 2002:a2e:a4c9:0:b0:2c6:ed19:58a6 with SMTP id
 p9-20020a2ea4c9000000b002c6ed1958a6mr10311908ljm.33.1699287991388; Mon, 06
 Nov 2023 08:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20231027055423.13617-1-juerg.haefliger@canonical.com> <20231030065341.8998-1-juerg.haefliger@canonical.com>
In-Reply-To: <20231030065341.8998-1-juerg.haefliger@canonical.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Nov 2023 11:26:20 -0500
Message-ID: <CABBYNZKkRtuTfT002ehf1QVq_enbJn_MhBnnAkNgxsMy5MJu_w@mail.gmail.com>
Subject: Re: [PATCH v2] shared/shell: Fix --init-script commandline option
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Juerg,

On Mon, Oct 30, 2023 at 2:54=E2=80=AFAM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
>
> The newly added option -i/--init-script introduced a short option
> namespace collision with btmgmt's --index, both of which use '-i'.
>
> As a result, a provided --index is treated as a file name:
>
> $ sudo btmgmt --index 0 info

Perhaps we could remove this --index since btmgmt supports setting the
index via select command; it doesn't seem very useful to have 2
different forms of selecting the index.

> Unable to open 0: No such file or directory (2)
>
> Fix this by using '-s' for --init-script.
>
> Fixes: https://github.com/bluez/bluez/issues/639
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
>
> ---
> v2:
>   - Replace reference to broken commit with reference to github issue.
> ---
>  src/shared/shell.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index db79c882ca3a..fbccff5b54d9 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1128,7 +1128,7 @@ static void rl_init(void)
>  static const struct option main_options[] =3D {
>         { "version",    no_argument, 0, 'v' },
>         { "help",       no_argument, 0, 'h' },
> -       { "init-script", required_argument, 0, 'i' },
> +       { "init-script", required_argument, 0, 's' },
>         { "timeout",    required_argument, 0, 't' },
>         { "monitor",    no_argument, 0, 'm' },
>         { "zsh-complete",       no_argument, 0, 'z' },
> @@ -1169,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const str=
uct bt_shell_opt *opt)
>         if (opt) {
>                 memcpy(options + offset, opt->options,
>                                 sizeof(struct option) * opt->optno);
> -               snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->optst=
r);
> +               snprintf(optstr, sizeof(optstr), "+mhvs:t:%s", opt->optst=
r);
>         } else
> -               snprintf(optstr, sizeof(optstr), "+mhvi:t:");
> +               snprintf(optstr, sizeof(optstr), "+mhvs:t:");
>
>         data.name =3D strrchr(argv[0], '/');
>         if (!data.name)
> @@ -1193,7 +1193,7 @@ void bt_shell_init(int argc, char **argv, const str=
uct bt_shell_opt *opt)
>                         data.argv =3D &cmplt;
>                         data.mode =3D 1;
>                         goto done;
> -               case 'i':
> +               case 's':
>                         if (optarg)
>                                 data.init_fd =3D open(optarg, O_RDONLY);
>                         if (data.init_fd < 0)
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
