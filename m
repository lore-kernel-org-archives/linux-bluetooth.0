Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B97C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3705A20890
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 17:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHv6CM1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgE0RNd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgE0RNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 13:13:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EADC03E97D
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 10:13:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so14928499lfh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZHtT2Bp3K+1ClVmevm9CmmkyfAlYicPKhcmoTd/HGc=;
        b=qHv6CM1HOvfRjMQRKcFtfPBIojU+dX3rNW/fwz/xKLW6JZCZwbYjK6KeMkBxyr5aFI
         vySSSaX/07ch8pY5hHDAe83v152dbbm6/ibIBdJ6lyyfYQkfPP+cOvLaMWhiAX1MW+Z1
         zVvhgeVFK+gkEovyGj1sNF/ZI8ohRez2Dh0dfYAAGrxC56bxrPa+c3EYnKTGzcOJBRyx
         iDulx3HN9nFCfX70Ypo3k7K9eU94tOc1VuoQsYMZxK7EoS4nKzKQAJyWHCNf9REdSiQ+
         anv5QT2tzTOfc92Nz9b1DZYkm/fJfN49sT0a3BIJ3co5WsHTy0fsH9tUNytk5UjqFf8F
         7L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZHtT2Bp3K+1ClVmevm9CmmkyfAlYicPKhcmoTd/HGc=;
        b=cT1bZgjDUmIwQb6+ENy1nYR7L5oJIWLJL83rb9Qt74BbsoNq8hV7r8EjbI/v3fbFPZ
         5443uh3jZ2eqvekWt21w6/T3CUuMW6yNtX8GkbQPxGZgJT/gAjeuZnOP0pxrFm5tDy6o
         47DjOY78Ns+6a8mZUg6sB4+s+Vf0X3+zwBK3Bldiob7wHakhDjw0DdFc8zydrIm/+p0O
         VZv2CSKoN3YhoPEIvrhJme/2tn6TekpBZb9q1ms+rbh3t+sDiYivSECMy8jTnKcfl4Mw
         sdva240jv47HEGyOpZr6otcS3GjEMzZezNjW2c2ZFmFEDHWUoewML4o5ozhcLCjaIgCu
         Uc9w==
X-Gm-Message-State: AOAM5334jAJ9H+sI7JfnsEKqjAsGq9jll+n19q8s3bcRVHvJh2C9wMsV
        e3XSHy/eAgNANrecUsrR6A4Rm2HVCutpo3EzgRLy6w==
X-Google-Smtp-Source: ABdhPJxaaLnEHlhBqKaRrIKypp+bIK7vcGhnElvdJLRC8lT7N/sW99D+td6FtDIC06jF/+jTCI2eH0bfOPoG2Cu1F9I=
X-Received: by 2002:a19:c64c:: with SMTP id w73mr3522637lff.67.1590599610261;
 Wed, 27 May 2020 10:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200527050228.117532-1-stimim@google.com>
In-Reply-To: <20200527050228.117532-1-stimim@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 May 2020 10:13:17 -0700
Message-ID: <CABBYNZLfHexzfm=S6U-gRnx95DkS74ytFFDrsVXZtnhyYv0PjQ@mail.gmail.com>
Subject: Re: [PATCH] shared/shell: don't hook io_hup on non-interactive
To:     Stimim Chen <stimim@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stimim,

On Tue, May 26, 2020 at 10:02 PM Stimim Chen <stimim@google.com> wrote:
>
> When we are in non-interactive mode (data.mode == 1), we should not
> terminate the mainloop when stdin is disconnected.
>
> For example, in bash, the following command would terminate immediately
> without any output.
>
>   : | btmgmt info
>
> ---
>  src/shared/shell.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 2e094b8f1..d58e2d7d1 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1277,10 +1277,10 @@ bool bt_shell_attach(int fd)
>
>         io = io_new(fd);
>
> -       if (!data.mode)
> +       if (!data.mode) {
>                 io_set_read_handler(io, input_read, NULL, NULL);
> -
> -       io_set_disconnect_handler(io, io_hup, NULL, NULL);
> +               io_set_disconnect_handler(io, io_hup, NULL, NULL);
> +       }
>
>         data.input = io;
>
> --
> 2.27.0.rc0.183.gde8f92d652-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
