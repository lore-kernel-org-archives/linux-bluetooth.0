Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609D9C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FFD223FD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP2G35an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgJSUSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgJSUSB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 16:18:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 13:18:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m128so1381637oig.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UV3TT9GP9b4RmjEZNl69WJ2tbj+2zPSx8Vyo9cyPEuQ=;
        b=iP2G35an8Cyn369VpmGVPa1vF5SZPHr2zhhT9VkERmprnR5ij6/IrD25dbXPaZlpzJ
         SJK0TS8ateJCM/MGSsy8Hs10zva+7zpWtXO8+OwUukbx2G1B+DG+CA3LDa/Sy1K2WtL0
         9+1x/9GCEcJEtx38F/YtT1iqzX7mBIcU6m0Z26/EyrQwDyhZJkcvW4QnNbKusBFl77EG
         uwyXKcrj2Q3nSLIFp5c6GLsORPvJJsCdzxbtkcqmqfu5w00IzCDIcth1hDeCN8cTAoxE
         an2rN2eFm0uOcmbxiI9tZ9e4XeZ8hwnska101sLH7N3XgLN0OKWeJFlOeIt13jnDAG8w
         05Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UV3TT9GP9b4RmjEZNl69WJ2tbj+2zPSx8Vyo9cyPEuQ=;
        b=XpAqXNSs5cK7fy/Le3EK4vH48LwOOCn4f0rt2RerVCjY1180AzfmEQQjfl+9N7gEfs
         NcH1XX5dCS++e4HdBX7lAMSM7IzpmCnprIjb7Picev3Kn4KwAH1y3UfLocXvRpoJuK6G
         sODLLfjWM7w/6V5qHg/vlldkD96njceLIItCrDl85iRr8GYFVRLe4TTbvTTdZKAFoFSr
         p3Bb59y3nf7N4IH+6NoWGJTkczEvanmDKu4AtoBDPUOzfHZ8HxlKJyIlxlFGJ4I6W7Sq
         hnBZAu6ErXc8uD3dfSwtxzKqV7Q0mhpzMfwT2ITpq3OrUub2RevMaJqDB78ic+zTPopD
         gcnQ==
X-Gm-Message-State: AOAM532Px8TDTPlRTrYrxWbwwDVkCT5FjdWzizLE9ZDhAZMI5e1QmBUC
        4NeirUjPiuO4yvyKmVwJU7UH4WWNBR+ALtRgt133h60rrqA=
X-Google-Smtp-Source: ABdhPJxtKm7DkNqSHgLlTaXuttPMV881QhazmJfe1e7aYosckc1UuLULdX9B+xzjGzBuXp+L3jEDVlXsuG2COc5p9g4=
X-Received: by 2002:aca:5143:: with SMTP id f64mr724740oib.161.1603138680527;
 Mon, 19 Oct 2020 13:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200925223849.76623-1-inga.stotland@intel.com>
 <28971312d4000cf290ed1868dc7835aa8e063283.camel@intel.com>
 <5a8c06c73e1a4a18aea6dcbb33910eac9e93f38f.camel@intel.com> <34b8fe82558fa3467a99181bc5a4a4f1e185b756.camel@intel.com>
In-Reply-To: <34b8fe82558fa3467a99181bc5a4a4f1e185b756.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Oct 2020 13:17:47 -0700
Message-ID: <CABBYNZL6Ejk4EiS23=xut8kUvH63OffsCTTPapj_VcFgCLmtMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-ell: Add reference count to io structure
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Mon, Oct 19, 2020 at 1:00 PM Stotland, Inga <inga.stotland@intel.com> wrote:
>
> Another ping
>
> On Fri, 2020-10-09 at 21:06 -0700, Inga Stotland wrote:
>
>  Ping
> On Sun, 2020-10-04 at 21:20 -0700, Inga Stotland wrote:
>
> Ping
>
> On Fri, 2020-09-25 at 15:38 -0700, Inga Stotland wrote:
>
> This adds reference count to io wrapper structure.
>
> Also, correctly handles IO destroy case by unsetting
>
> read/write/disconnect halers and freeing the corresponding
>
> resources.
>
> ---
>
>  src/shared/io-ell.c | 193 +++++++++++++++++++++++++++++++++++---------
>
>  1 file changed, 155 insertions(+), 38 deletions(-)
>
>
> diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
>
> index 485c613e0..dee9a95c9 100644
>
> --- a/src/shared/io-ell.c
>
> +++ b/src/shared/io-ell.c
>
> @@ -20,48 +20,96 @@
>
>
>
>  #include "src/shared/io.h"
>
>
>
> +struct io_watch {
>
> + struct io *io;
>
> + io_callback_func_t cb;
>
> + io_destroy_func_t destroy;
>
> + void *user_data;
>
> +};
>
> +
>
>  struct io {
>
> + int ref_count;
>
>   struct l_io *l_io;
>
> - io_callback_func_t read_cb;
>
> - io_destroy_func_t read_destroy;
>
> - void *read_data;
>
> - io_callback_func_t write_cb;
>
> - io_destroy_func_t write_destroy;
>
> - void *write_data;
>
> + struct io_watch *read_watch;
>
> + struct io_watch *write_watch;
>
> + struct io_watch *disc_watch;
>
>  };
>
>
>
> -static bool read_callback(struct l_io *l_io, void *user_data)
>
> +static struct io *io_ref(struct io *io)
>
>  {
>
> - struct io *io = user_data;
>
> - bool result = false;
>
> + if (!io)
>
> + return NULL;
>
> +
>
> + __sync_fetch_and_add(&io->ref_count, 1);
>
> +
>
> + return io;
>
> +}
>
>
>
> +static void io_unref(struct io *io)
>
> +{
>
>   if (!io)
>
> - return false;
>
> + return;
>
>
>
> - if (io->read_cb)
>
> - result = io->read_cb(io, io->read_data);
>
> + if (__sync_sub_and_fetch(&io->ref_count, 1))
>
> + return;
>
>
>
> - if (io->read_destroy)
>
> - io->read_destroy(io->read_data);
>
> + l_free(io);
>
> +}
>
>
>
> - return result;
>
> +static void watch_destroy(void *user_data)
>
> +{
>
> + struct io_watch *watch = user_data;
>
> + struct io *io;
>
> +
>
> + if (!watch)
>
> + return;
>
> +
>
> + io = watch->io;
>
> +
>
> + if (watch == io->read_watch)
>
> + io->read_watch = NULL;
>
> + else if (watch == io->write_watch)
>
> + io->write_watch = NULL;
>
> + else if (watch == io->disc_watch)
>
> + io->disc_watch = NULL;
>
> +
>
> + if (watch->destroy)
>
> + watch->destroy(watch->user_data);
>
> +
>
> + io_unref(watch->io);
>
> + l_free(watch);
>
>  }
>
>
>
> -static bool write_callback(struct l_io *l_io, void *user_data)
>
> +static struct io_watch *watch_new(struct io *io, io_callback_func_t cb,
>
> + void *user_data, io_destroy_func_t destroy)
>
>  {
>
> - struct io *io = user_data;
>
> - bool result = false;
>
> + struct io_watch *watch;
>
>
>
> - if (!io)
>
> + watch = l_new(struct io_watch, 1);
>
> + watch->io = io_ref(io);
>
> + watch->cb = cb;
>
> + watch->user_data = user_data;
>
> + watch->destroy = destroy;
>
> +
>
> + return watch;
>
> +}
>
> +
>
> +static bool watch_callback(struct l_io *l_io, void *user_data)
>
> +{
>
> + struct io_watch *watch = user_data;
>
> +
>
> + if (!watch->cb)
>
>   return false;
>
>
>
> - if (io->write_cb)
>
> - result = io->write_cb(io, io->write_data);
>
> + return watch->cb(watch->io, watch->user_data);
>
> +}
>
>
>
> - if (io->write_destroy)
>
> - io->write_destroy(io->write_data);
>
> +static void disc_callback(struct l_io *l_io, void *user_data)
>
> +{
>
> + struct io_watch *watch = user_data;
>
>
>
> - return result;
>
> + if (watch->cb)
>
> + watch->cb(watch->io, watch->user_data);
>
>  }
>
>
>
>  struct io *io_new(int fd)
>
> @@ -84,7 +132,7 @@ struct io *io_new(int fd)
>
>
>
>   io->l_io = l_io;
>
>
>
> - return io;
>
> + return io_ref(io);
>
>  }
>
>
>
>  void io_destroy(struct io *io)
>
> @@ -92,10 +140,22 @@ void io_destroy(struct io *io)
>
>   if (!io)
>
>   return;
>
>
>
> - if (io->l_io)
>
> - l_io_destroy(io->l_io);
>
> + l_io_set_read_handler(io->l_io, NULL, NULL, NULL);
>
> + watch_destroy(io->read_watch);
>
> + io->read_watch = NULL;
>
>
>
> - l_free(io);
>
> + l_io_set_write_handler(io->l_io, NULL, NULL, NULL);
>
> + watch_destroy(io->write_watch);
>
> + io->write_watch = NULL;
>
> +
>
> + l_io_set_disconnect_handler(io->l_io, NULL, NULL, NULL);
>
> + watch_destroy(io->disc_watch);
>
> + io->disc_watch = NULL;
>
> +
>
> + l_io_destroy(io->l_io);
>
> + io->l_io = NULL;
>
> +
>
> + io_unref(io);
>
>  }
>
>
>
>  int io_get_fd(struct io *io)
>
> @@ -117,37 +177,94 @@ bool io_set_close_on_destroy(struct io *io, bool do_close)
>
>  bool io_set_read_handler(struct io *io, io_callback_func_t callback,
>
>   void *user_data, io_destroy_func_t destroy)
>
>  {
>
> + bool result;
>
> +
>
>   if (!io || !io->l_io)
>
>   return false;
>
>
>
> - io->read_cb = callback;
>
> - io->read_data = user_data;
>
> - io->read_destroy = destroy;
>
> + if (io->read_watch) {
>
> + l_io_set_read_handler(io->l_io, NULL, NULL, NULL);
>
>
>
> - return l_io_set_read_handler(io->l_io, read_callback, io, NULL);
>
> + if (!callback) {
>
> + watch_destroy(io->read_watch);
>
> + io->read_watch = NULL;
>
> + return true;
>
> + }
>
> + }
>
> +
>
> + io->read_watch = watch_new(io, callback, user_data, destroy);
>
> +
>
> + result = l_io_set_read_handler(io->l_io, watch_callback, io->read_watch,
>
> + watch_destroy);
>
> +
>
> + if (!result) {
>
> + watch_destroy(io->read_watch);
>
> + io->read_watch = NULL;
>
> + }
>
> +
>
> + return result;
>
>  }
>
>
>
>  bool io_set_write_handler(struct io *io, io_callback_func_t callback,
>
>   void *user_data, io_destroy_func_t destroy)
>
>  {
>
> + bool result;
>
> +
>
>   if (!io || !io->l_io)
>
>   return false;
>
>
>
> - io->write_cb = callback;
>
> - io->write_data = user_data;
>
> - io->write_destroy = destroy;
>
> + if (io->write_watch) {
>
> + l_io_set_write_handler(io->l_io, NULL, NULL, NULL);
>
>
>
> - return l_io_set_write_handler(io->l_io, write_callback, io, NULL);
>
> + if (!callback) {
>
> + watch_destroy(io->write_watch);
>
> + io->write_watch = NULL;
>
> + return true;
>
> + }
>
> + }
>
> +
>
> + io->write_watch = watch_new(io, callback, user_data, destroy);
>
> +
>
> + result = l_io_set_write_handler(io->l_io, watch_callback,
>
> + io->write_watch, watch_destroy);
>
> +
>
> + if (!result) {
>
> + watch_destroy(io->write_watch);
>
> + io->write_watch = NULL;
>
> + }
>
> +
>
> + return result;
>
>  }
>
>
>
>  bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
>
>   void *user_data, io_destroy_func_t destroy)
>
>  {
>
> + bool result;
>
> +
>
>   if (!io || !io->l_io)
>
>   return false;
>
>
>
> - return l_io_set_disconnect_handler(io->l_io, (void *) callback,
>
> - user_data, destroy);
>
> + if (io->disc_watch) {
>
> + l_io_set_disconnect_handler(io->l_io, NULL, NULL, NULL);
>
> +
>
> + if (!callback) {
>
> + watch_destroy(io->disc_watch);
>
> + io->disc_watch = NULL;
>
> + return true;
>
> + }
>
> + }
>
> +
>
> + io->disc_watch = watch_new(io, callback, user_data, destroy);
>
> +
>
> + result = l_io_set_disconnect_handler(io->l_io, disc_callback,
>
> + io->disc_watch, watch_destroy);
>
> +
>
> + if (!result) {
>
> + watch_destroy(io->disc_watch);
>
> + io->disc_watch = NULL;
>
> + }
>
> +
>
> + return result;
>
>  }
>
>
>
>  ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)

Applied, thanks.

-- 
Luiz Augusto von Dentz
