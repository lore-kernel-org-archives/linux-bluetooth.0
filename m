Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A7C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 11:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0709720672
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeUtaTR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeKZWWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:22:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40049 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeKZWWn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 17:22:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so15451376oie.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=16kiMo0uNG814jMAOYzK1rwm7rWDgEV3IX5YaWAqsTk=;
        b=oeUtaTR22o4oLrF6CUYC3Qg3Wh5j0OHmi9C72N2F4zhZ9zTZKKkYj1L4SyM5oab42H
         aWp+qbkmWjQNji5zAawjAtGdgvHimiWyblmduRAoC4HYJ8EucqQk4ekzPxFCiYJ3vAUo
         YzZtz4q3PmQl6Oiry6gwZ86fMAd7F4qb3GH8K1I5j5ELX8CmKE3zUl0lsulkZ/yr9I+U
         tHdz7weGdLWolJXKsHQ7g+wKW5yPVL16SMrijh3iZn3dOsplGp5l3cgVpJjMLMRCGK2b
         dRHNxcOUY3bOp9fpGq1gtXzrZz8SZ9cL7KMxYkkgL1uP0HkbqtxI7Fm6SaA4qb3XGe/M
         5N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=16kiMo0uNG814jMAOYzK1rwm7rWDgEV3IX5YaWAqsTk=;
        b=i0pLjwlyvvVdyeyz07pNA2lGDO3xlcfSvvulniDu1E6Uda43KWd31cvlfmiOxwyWiN
         53vbzQtmM2bIXOq9NDValHfNcdOVjE2km2WNByFr8HQXiMK7JylrLkNODJqcVTC+Vdsw
         HzgJP9p0EczTtjCB3aMlO3Y3WGkOX3FkIv2WUMrisi+dxE4OPFOTaTdA02qpPYKtu6qo
         ojA+ZdOHJz7A0jLfW4txJuUK5qG1kYxpvtRIMuV7ydjn3Rdf4gx9qM2/UEcsL6Aa9PDx
         ENkO01icDXNjqIafiua91eRHhlkAoE3qg0k1+bm7K72yfH7uFafwJv6P2oZT7qNUiNkG
         etBg==
X-Gm-Message-State: AGRZ1gIRimG/o8ZuHKR7sAjrC7OPK93ZCAHXzk1keRmQ7LgSWP0yOBY8
        IVR+smzWx81kOTATx6ftZN92+7vGhgjMkVn1u3UCWg==
X-Google-Smtp-Source: AJdET5ce7Q4x01Giin8273IMhhJ7j/5LwbBGtu10f5KTMRafWoucBFQ+wvwtdUFo4lj37pYh0gF9enMylbTNVpoxIgQ=
X-Received: by 2002:aca:32c6:: with SMTP id y189-v6mr13766676oiy.153.1543231732116;
 Mon, 26 Nov 2018 03:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20181122160208.6933-1-luiz.dentz@gmail.com>
In-Reply-To: <20181122160208.6933-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Nov 2018 13:28:40 +0200
Message-ID: <CABBYNZKTyWM+jU7ecMhrX=MsYW4hDRsUQCBL7yDokQd+BrKwfQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shell: Fix artifacts when asking for user input
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Thu, Nov 22, 2018 at 6:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Instead of printing a message use set the new prompt so it is carried
> over when new lines are printed. Unfortunately this has some drawbacks
> as apparently readline is not really able to redisplay properly if the
> prompt contain colors.
> ---
>  src/shared/shell.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 89a2e82bc..aabbc5d0e 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -562,6 +562,8 @@ void bt_shell_usage()
>  void bt_shell_prompt_input(const char *label, const char *msg,
>                         bt_shell_prompt_input_func func, void *user_data)
>  {
> +       char *str;
> +
>         if (!data.init || data.mode)
>                 return;
>
> @@ -573,9 +575,11 @@ void bt_shell_prompt_input(const char *label, const char *msg,
>         data.saved_prompt = true;
>         data.saved_func = func;
>         data.saved_user_data = user_data;
> +       asprintf(&str, "[%s] %s ", label, msg);
>
>         rl_save_prompt();
> -       bt_shell_printf(COLOR_RED "[%s]" COLOR_OFF " %s ", label, msg);
> +       bt_shell_set_prompt(str);
> +       free(str);
>  }
>
>  int bt_shell_release_prompt(const char *input)
> @@ -1209,7 +1213,7 @@ void bt_shell_set_prompt(const char *string)
>                 return;
>
>         rl_set_prompt(string);
> -       bt_shell_printf("\r");
> +       rl_redisplay();
>  }
>
>  static bool input_read(struct io *io, void *user_data)
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
