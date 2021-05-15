Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764C261444
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 00:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhEOAEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 20:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhEOAEx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 20:04:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FCC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 17:03:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i204so1163208yba.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxoIM040RmJhqg1xZIqFyFQIm7R+jXpieBkeBUVfrDk=;
        b=mhnfj6LApbJcupXGolSSDM0Jy1x/4Zm7Lj8liBTktgdvVLmhQLgaKuhePQvwv9IdFX
         ukenQysKWykD9KYs+16stIBQWoTpbSgHCsnn7E9LMqN99Czduvy6Syo4jpXMVK8/yjVc
         XS6AYeCZN8kvXS2lkQQhoYz5om4Yo5iN9tz9Qi9UjX65qi9EhQPtq/sFtn+A6L0HUk37
         HA4n/isV10lhDhoMazKPVcd6qm/Pwl8+Qcc2bcUy8dufivEXPHTHLJ9FZkHDJkSFMD0u
         ZMxkoWXySWe9OlW7YTITPKgmmO53UR3DEU8M6y0nfHY1tFnioRpvA95rSUfpuF086rBU
         F9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxoIM040RmJhqg1xZIqFyFQIm7R+jXpieBkeBUVfrDk=;
        b=ruZw6getKiy8CbtoEfW+XaQG+Xz62T0JY0xGQkKYeef7PzZT9I9ldQm+WTnF81Rrou
         FS/8Qj4NK+G5SM1uZzoUGI5tPjIsvMIzWNd+hSETzSoCZ9XLZFtcqptaLgOj5L6cZUib
         mqqFN6ezArwrnokSqCsar96dIIFuShquBJ0Rq2QN7G6BIr3hKIsUhWAi/G70pxXj+MIy
         6p3dlI9wqb7NP1PyqdU5ghK2HgLNcQL9EULPfuzYML3JN3Pa+Q4MRE10f1SBHoCbuTqn
         2+Z2OSDhQO+yZ40f8Vo85BWbVzIsBQwjQjjRVvqYAP8/uegZuJ0yhp7Z5bEFj2mBBw0D
         N2RQ==
X-Gm-Message-State: AOAM533CXOCulJIbZowA5FOnKQGj9xHDaBl7G3DOyx+gwoqED+eli3lU
        l10NUIrjUxj98Z7VCw1hQsbsxMm8mbyYy1hParbH3hv32kM=
X-Google-Smtp-Source: ABdhPJyQbt4u4RA9Br7kmGr/OGHVyHowMLsWFUdrWQXwNp5TjAZJP4le1g4zpMnVaSrvW9egoX0J1yzg7AXlCKbz5bo=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr51179545ybn.440.1621037019467;
 Fri, 14 May 2021 17:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210514095905.59358796@ivy-bridge>
In-Reply-To: <20210514095905.59358796@ivy-bridge>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 May 2021 17:03:28 -0700
Message-ID: <CABBYNZK7m=t2ExO5fZwfr0oosx8pUEQy4dOKT5HrpD_iLwqPPQ@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/6 v2] Fix leaks in obex
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Fri, May 14, 2021 at 11:51 AM Steve Grubb <sgrubb@redhat.com> wrote:
>
>
> In filesystem, g_file_get_contents allocates fresh memory to buf.
> It needs to be freed after conversion to a GString object.
>
> Destination was missed on an error path as is mld.
>
> ---
>  obexd/plugins/filesystem.c     | 2 +-
>  obexd/plugins/ftp.c            | 8 ++++++--
>  obexd/plugins/messages-dummy.c | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> index 09bff8ad0..44e3cf3d2 100644
> --- a/obexd/plugins/filesystem.c
> +++ b/obexd/plugins/filesystem.c@@ -416,6 +416,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
>                 }
>
>                 object->buffer = g_string_new(buf);
> +               g_free(buf);
>
>                 if (size)
>                         *size = object->buffer->len;
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 259bfcae2..4b04bab06 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> @@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index 34199fa05..e37b52df6 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
>                         int err = -errno;
>                         DBG("fopen(): %d, %s", -err, strerror(-err));
>                         g_free(path);
> +                       g_free(mld);
>                         return -EBADR;
>                 }
>         }
> --
> 2.31.1

You will need to resend this since apparently patchwork cannot
identify this as the same set as the others:

https://patchwork.kernel.org/project/bluetooth/list/?series=482521


-- 
Luiz Augusto von Dentz
