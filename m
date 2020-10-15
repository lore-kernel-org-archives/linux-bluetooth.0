Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A8C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D38B2225E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 17:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eelJr10E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbgJORNJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403909AbgJORNI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 13:13:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC659C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 10:13:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w141so3908221oia.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Osw6NqVYNmHUMRwCYRyMfaozlp7BCYpLh7My51/r2BU=;
        b=eelJr10EjXooFkYvRC0YgTs8c+BXon2D/IIM/MRqfQr36hrPc0lgQSRYolTlQrlbfe
         JAD40ziRnWrAWDd2t4138cTrOSZ5BJXbVqtLCi5Rv8BiOaULFHma2bG08dOHPIROxfND
         kJ6I7GNp3QiPS5CEDT8ISe3S4e7yj880NttWAPrYA0ckrWWyVf0UUkaRP9qbivqmUIwE
         fCmNyPloLyON0luS8ptD1qNQ6eip0Xx0NQ79kbD/PHjd3JCqKqBsJ5mh6jxVM8RbkB61
         dG/p67jc3wNEz9Aj9YJQtWv+HeYWXwlwP4YBKqRbZ4o6tikDv9AwZmExNBwuyFyTownf
         QVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Osw6NqVYNmHUMRwCYRyMfaozlp7BCYpLh7My51/r2BU=;
        b=Oe83Wq/ZGD0Vo1QJ+T3MuFOUiOteh+IM7WViECuGZv+ws9qwVJ9DgcupCPi82p4Twp
         Sr9gTls4CjvWsdy7LlV+dEwa7mTIbt+reQZB3+ppF0QvvoUhhJUFwV+zfyRwz5wT1TOC
         knOdw5uMkItfGZzP8FZb6G+RI8oWnPUT3YUWbWaOmYphrFXqIBuAmL391QMcjgp62BKH
         icepP+VS2tm6JyvDKu/Xo+Okvpq6D8wSvoOVgB4ZXbU2KruuRRJgRhO9ZTMhaP0elhds
         GY91d8oM78SgOf05Zc5BmXs33+GJ9hBgZczhDurm7LKUF0prBI9+cw8AUuiFFhn23bQ9
         4FmA==
X-Gm-Message-State: AOAM531ym9wRbc8ny1Mo/P0zq+vHeVtSIjG1mY+FhcQwEBXz8rfNvKW5
        Y3OR9fAGzGHINQtxoSb3iY6NNuh+e5p7RoRs3JZ7WQ24
X-Google-Smtp-Source: ABdhPJwrALW3OEZCReFmJA9f8BAH86kK1t/fxys600Al92ToxSg/sPXbhg7mrxoom1NUkervZ5/u3PlcF7mZ0TItz3U=
X-Received: by 2002:aca:4c7:: with SMTP id 190mr2906123oie.58.1602781988041;
 Thu, 15 Oct 2020 10:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
In-Reply-To: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Oct 2020 10:12:57 -0700
Message-ID: <CABBYNZ+ahHHmZx2dOx8zpQ34LEiYk0btpLQ_6Kv8e6+d_Ko66g@mail.gmail.com>
Subject: Re: [PATCH] 100% CPU usage on keyboard disconnect
To:     Steven Newbury <steve@snewbury.org.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steven,

On Thu, Oct 15, 2020 at 4:13 AM Steven Newbury <steve@snewbury.org.uk> wrote:
>
> There are a couple of issues with g_io_channel usage in bluez which
> cause CPUs to spin on half-closed channels.
>
> This patch fixes bugs where bluetooth keyboards fail to work on initial
> connection, and cause 100% cpu on disconnect.
>
> Also fix bug with similar symptoms triggered by some other HID devices
> such as Sony PS3 BD Remotes.
>
> In the previous discussion on the kernel bugzilla below, it was
> suggested to remove sec_watch, and I attached a follow-up patch to do
> so, however that change causes problems with current bluez-5 releases
> where a fd is used after being closed.
>
> See https://bugzilla.kernel.org/show_bug.cgi?id=204275
>
> Signed-off-by: Steven Newbury <steve@snewbury.org.uk>
> ---
>  attrib/interactive.c    | 4 +++-
>  profiles/input/device.c | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/attrib/interactive.c b/attrib/interactive.c
> index 9a7976d34..453ff064e 100644
> --- a/attrib/interactive.c
> +++ b/attrib/interactive.c
> @@ -64,6 +64,7 @@ static int opt_psm = 0;
>  static int opt_mtu = 0;
>  static int start;
>  static int end;
> +static guint gsrc;
>
>  static void cmd_help(int argcp, char **argvp);
>
> @@ -193,6 +194,7 @@ static void disconnect_io()
>         attrib = NULL;
>         opt_mtu = 0;
>
> +       g_source_remove(gsrc);
>         g_io_channel_shutdown(iochannel, FALSE, NULL);
>         g_io_channel_unref(iochannel);
>         iochannel = NULL;
> @@ -415,7 +417,7 @@ static void cmd_connect(int argcp, char **argvp)
>                 error("%s\n", gerr->message);
>                 g_error_free(gerr);
>         } else
> -               g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
> +               gsrc = g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
>  }

I wouldn't bother with the fix above since the attrib part will be
going away soon.

>  static void cmd_disconnect(int argcp, char **argvp)
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index a711ef527..9abf595f6 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -982,7 +982,8 @@ static int hidp_add_connection(struct input_device *idev)
>                 }
>
>                 idev->req = req;
> -               idev->sec_watch = g_io_add_watch(idev->intr_io, G_IO_OUT,
> +               if (!idev->sec_watch)
> +                       idev->sec_watch = g_io_add_watch(idev->intr_io, G_IO_IN,
>                                                         encrypt_notify, idev);

If this is happening isn't there a idev->req already set and we are
overwriting it?

>                 return 0;
> --
> 2.22.0
>
>


-- 
Luiz Augusto von Dentz
