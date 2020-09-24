Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B190C4346E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E155D2399A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoTc6W0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIXXZG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXZG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 19:25:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53DC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:25:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so573772ota.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywS3L0LbtMmnI8SMeK1q/vOdWENG8lGa1ljoO5LFLLY=;
        b=EoTc6W0kKZXyRBXc7R+K82CeQ0SOJBKcksJxmm6BSMbHDOpBdTm71MwR72XdATHII+
         1CjMwSjoykIy9DTXI3OkvC0NjsSccPU2XwEbmTvZ398VEby2HD2nyxoorr2F4fmi01tT
         C1TGrUSxDWeFIG/fvqmKiFOxOzih2rwdgmXAbmLsJ6SiIKSDPzkqTG1RcHCbWqCcsi3/
         DMBAtdIVwPX32WJ/jjEGDHSz8fIWlJJE372toAhfSLwR8l6L3FzGf5803RckbGpWcolS
         TtGVvFj4J4bBadRSJheEwldixTVYYG4o3QvEl5WnJvDdhKBbYGbf8+Dl17xaAfYjC8Bl
         x4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywS3L0LbtMmnI8SMeK1q/vOdWENG8lGa1ljoO5LFLLY=;
        b=gqr3rWq/ttoH7qgyyQkfIUGX9qN6sKV+xWY6npUvVY7DLcsPprbNH36Sz2L2ZgmZZT
         wtCzbcRb1UsB1VOIuWOQK64ZIzwr6ipfCTYKEMnftSX9944htgg1QGV205zLEfneRpUu
         uOa/WlIrBEDMK47j589uX2lLmu7t8K3A38JcU6Sm5uD+KYdZ/yCLOftUj8YMml99PHqo
         aK1fejiPlaUS3Hv8AVnN+n5ywul02g1qL5phlh5IK+gSUq7Z02Vk28LFbqXrc00afATB
         8x4HdslzXCUNiCgyEo4fD+hIl3bRmyP5qLnpTf47CGN3d4gT5SpvbTX2BPjDw/tYdpDe
         +cgQ==
X-Gm-Message-State: AOAM5335bKm3xNzN34PcXKACkiy1BkSSyjpJyc/GrXOdCn6bfExb+hlf
        j6sEjV4fGULDq+B3WMmbt1tJvjU26hXl/EtwIxgqmK+W
X-Google-Smtp-Source: ABdhPJxObJJG/D7bjHpmcbJ9lDmn3okkr6cyZJB6Y0ZmKP+6s3XTtJC8H8aXzYXmM+llkMVooot2Pom5USU1MGF7Bko=
X-Received: by 2002:a05:6830:22e6:: with SMTP id t6mr1012089otc.88.1600989905510;
 Thu, 24 Sep 2020 16:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200924182002.22978-1-inga.stotland@intel.com>
In-Reply-To: <20200924182002.22978-1-inga.stotland@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Sep 2020 16:24:53 -0700
Message-ID: <CABBYNZLBTtxYeRcBfCPv4XhyZHeWGrMBZQbqdc_s1cD69ugaCA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-ell: Fix ELL io wrapper
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Thu, Sep 24, 2020 at 11:20 AM Inga Stotland <inga.stotland@intel.com> wrote:
>
> This modifies the internal io structure inside io-ell to retain
> correct user data associated with write and read handlers and
> to return these data with the corresponding callbacks.
> ---
>  src/shared/io-ell.c | 54 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
> index c4a115478..485c613e0 100644
> --- a/src/shared/io-ell.c
> +++ b/src/shared/io-ell.c
> @@ -22,8 +22,48 @@
>
>  struct io {
>         struct l_io *l_io;
> +       io_callback_func_t read_cb;
> +       io_destroy_func_t read_destroy;
> +       void *read_data;
> +       io_callback_func_t write_cb;
> +       io_destroy_func_t write_destroy;
> +       void *write_data;
>  };
>
> +static bool read_callback(struct l_io *l_io, void *user_data)
> +{
> +       struct io *io = user_data;
> +       bool result = false;
> +
> +       if (!io)
> +               return false;
> +
> +       if (io->read_cb)
> +               result = io->read_cb(io, io->read_data);
> +
> +       if (io->read_destroy)
> +               io->read_destroy(io->read_data);
> +
> +       return result;
> +}
> +
> +static bool write_callback(struct l_io *l_io, void *user_data)
> +{
> +       struct io *io = user_data;
> +       bool result = false;
> +
> +       if (!io)
> +               return false;
> +
> +       if (io->write_cb)
> +               result = io->write_cb(io, io->write_data);
> +
> +       if (io->write_destroy)
> +               io->write_destroy(io->write_data);
> +
> +       return result;
> +}
> +
>  struct io *io_new(int fd)
>  {
>         struct io *io;
> @@ -80,8 +120,11 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
>         if (!io || !io->l_io)
>                 return false;
>
> -       return l_io_set_read_handler(io->l_io, (l_io_read_cb_t) callback,
> -                                                       user_data, destroy);
> +       io->read_cb = callback;
> +       io->read_data = user_data;
> +       io->read_destroy = destroy;
> +
> +       return l_io_set_read_handler(io->l_io, read_callback, io, NULL);
>  }
>
>  bool io_set_write_handler(struct io *io, io_callback_func_t callback,
> @@ -90,8 +133,11 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
>         if (!io || !io->l_io)
>                 return false;
>
> -       return l_io_set_write_handler(io->l_io, (l_io_write_cb_t) callback,
> -                                                       user_data, destroy);
> +       io->write_cb = callback;
> +       io->write_data = user_data;
> +       io->write_destroy = destroy;
> +
> +       return l_io_set_write_handler(io->l_io, write_callback, io, NULL);
>  }
>
>  bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> --
> 2.26.2
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
