Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA1C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BF024655
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkNqdDl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVAcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:32:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43383 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVAcx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 19:32:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so4470062oif.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJC/caOwVfR2LAFwhDN8te/tMZBb509QuBHyr248398=;
        b=FkNqdDl3USNVop1D576/b4snGQe/Srx7+oBfvdIM6doQlpWUh5dZCVyDOSJIl6C1Af
         3NTd9Y8Fw31y3E3zItRK/Xgyhf7N1L0dz0w+s8T5awevNxhCjlCYuCf1+tvRgSXZMo+O
         5AeoMAacAXNoiOiuNE4tyk0LDfAmg6dVdYminkmOG8Px2zAxhdJCro3hppREL6Umbstp
         rylDEk0blCzafy1o+DwQap8zilhuy1y8FoUbobDE9JL0yF0amuY8pXjFI5O7pZLl23TU
         Z0jfmOarhXP3eSSXWKocxuoC0v0+hXQvsSRHrNtE2t7CjZVQoJugro303sTWOnVFbWFR
         Ci8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJC/caOwVfR2LAFwhDN8te/tMZBb509QuBHyr248398=;
        b=TMVXp76GPfE0e1GUpcdz3cc8QKmca4SAGKPNi1bL23z6nFW2EXIHAeRjHAkHn3hl/v
         G5zV66agcX+ZeEPdvK/fL+ufEaF50A0qOKIwaNrRHX+En25kdd5n++YkKVqr3nW8cFp7
         GDMRpp1lGqipisGiw/MEV9XnoHIhYP26AMXP9uAMPr0cJGXuRbSsAKfalNC5gXH4h2wb
         G7pnuWmdXw/Lbt1SHGd99m2cLSZdeUm8WaACeoL80Hve/nwTKjEL36MDjDwTmAQLRoAI
         OZL/l96f+nR+bkHfqmZ4gwWaxNrkNbC6XESwkBILpMn8VkIjQgHbQ20CiXrFShqIWMw5
         GGuA==
X-Gm-Message-State: APjAAAVMMi/PB8ewAaaPrY5yhddmxOkOb2H0CNo+3fCM4yuUTp93IWqi
        aMHSPEg10axaUQ0SKAczv2Nb8QRn/3vm8xIwqBo=
X-Google-Smtp-Source: APXvYqyq+CuR21avMVbnxKyCWs8VqoddKgNvoFgxJ9iZMRr+4aBD5Qk1IdNMKx6neChqfzUhadro2zfv6oxgLHmMh2Y=
X-Received: by 2002:aca:4c15:: with SMTP id z21mr4926521oia.8.1579653172960;
 Tue, 21 Jan 2020 16:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20200118204423.494209-1-marijns95@gmail.com>
In-Reply-To: <20200118204423.494209-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jan 2020 16:32:41 -0800
Message-ID: <CABBYNZLmQK6+MXT1AQt_OYYFeXJmE+t+Mkw1hjSC0Gdss=+60g@mail.gmail.com>
Subject: Re: [BlueZ PATCH] shared: shell: Only omit consecutive duplicate
 history lines.
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Sat, Jan 18, 2020 at 12:46 PM Marijn Suijten <marijns95@gmail.com> wrote:
>
> From: Marijn Suijten <marijns95@gmail.com>
>
> Change rl_handler to append duplicate history, as long as it isn't
> identical to the last line. It prevents consecutive duplicates while
> still having an accurate overview of the most recent commands used,
> mimicking most modern shells.
>
> This addresses my only major gripe with bluetoothctl: pressing UP does
> not retrieve the last typed command when it is a duplicate of something
> else written (much) earlier in the history. It is especially noticeable
> when needing the same command repeatedly.
> ---
>  src/shared/shell.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index cfdcc76c4..2e094b8f1 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -681,6 +681,7 @@ int bt_shell_release_prompt(const char *input)
>  static void rl_handler(char *input)
>  {
>         wordexp_t w;
> +       HIST_ENTRY *last;
>
>         if (!input) {
>                 rl_insert_text("quit");
> @@ -696,7 +697,9 @@ static void rl_handler(char *input)
>         if (!bt_shell_release_prompt(input))
>                 goto done;
>
> -       if (history_search(input, -1))
> +       last = history_get(history_length + history_base - 1);
> +       /* append only if input is different from previous command */
> +       if (!last || strcmp(input, last->line))
>                 add_history(input);
>
>         if (data.monitor)
> --
> 2.25.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
