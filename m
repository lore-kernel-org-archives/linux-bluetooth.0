Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BD2073B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4ggr3Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAQ3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAQ3h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 12:29:37 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35396C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 09:29:37 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v17so8513068ote.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXyFualFd9q9VNoT+F1BinqWNS7HvcnYJGgYXeqNWyI=;
        b=s4ggr3Os+DGVYKP217fUzYF+I5gjJ48qwYMoxaORie/1PLdQQ69xUcm9pTX8UWVxXL
         cXUce8lfFIOGeWvIhmmpYguebP9hjEdv0Y4v6hQukEhU+XS+1V8NHLdncgm7mm/PouqE
         x8mGw3oikT6wF5lQgvWIDXGXtOjD7NFWQz/ERe9MHI+b+q+SeAgKcwuSEfSJGVGXgWt9
         V7KQeVjFW0eKJEhFlqglOT+8QFiCOeHkGUHeQ9sGEg2HBgOuQJtTUAmycA5l94xaM8IK
         NfzReLPaHpNkLPnjIo86NNPF7fF96nQuyVQXZH3b9BEsTBS5Wr4U24/6+pYw34AbZ4aa
         5bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXyFualFd9q9VNoT+F1BinqWNS7HvcnYJGgYXeqNWyI=;
        b=rwExcIXb0LKT2TETRCoJwFYSsmILvKuJCl26mVj0YtMLcvH15WbrzD6BxAZsYvSUs2
         0c9Fd8dqKzCwd7zMMuTX+JTfEYWlbaAik727plwgMz0lWqtO8FodqoyTSbtL9WCe9Dwr
         N2coz+M0p1yhWHFC3iiF8T3kUPYgy8Q35F/8132v39mL6CpaTzh4TCnZvNJuhv0ZmCPA
         90o8qgkY69DsIKLScniyu5nhvAtyC32k15ECFusB1n9ZgZZo+lbiNhm2zZFus6VTFP3i
         uxKhLbonya0mhfZd504UcQacwkgR/X7E4GMQeM7jh7sveABI4H1CCXwG86qr0XSvfON1
         ivVw==
X-Gm-Message-State: AOAM533AR441h3PCI506PsygjpGwEswb0G9IWZY9dMCdv/U0FUEkfgMC
        cmEyzktWfzKWWmcFwoa3yirxfaBi3DixHZjEM/frzg==
X-Google-Smtp-Source: ABdhPJwaCLGQoa16K4QVCqqqDnvOqzX2vZZ9vy/dkVQsiFnbcSADTyKJQcA8b97vU1F3Kjmucs+yVC7cKHGWzLqvpvw=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr17720811ots.11.1591028976505;
 Mon, 01 Jun 2020 09:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200601005600.254025-1-alainm@chromium.org>
In-Reply-To: <20200601005600.254025-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Jun 2020 09:29:24 -0700
Message-ID: <CABBYNZLVK=KNOY6oDnCSAFP_y=wekmZYkFMYh21sj=J2V_XFuw@mail.gmail.com>
Subject: Re: [BlueZ PATCH] a2dp:fixing double free in load_remote_sep
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Sun, May 31, 2020 at 6:03 PM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch fixes a double free condition in load_remote_sep. Value is
> freed, then the inner loop is broken, but the rest of the outer loop
> will attempt to free value again.
>
> ---
>
>  profiles/audio/a2dp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a2ce3204d..6f46c92bf 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1967,7 +1967,6 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>
>                         if (sscanf(caps + i, "%02hhx", tmp) != 1) {
>                                 warn("Unable to load Endpoint: seid %u", rseid);
> -                               g_free(value);
>                                 break;
>                         }
>                 }
> --
> 2.27.0.rc2.251.g90737beb825-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
