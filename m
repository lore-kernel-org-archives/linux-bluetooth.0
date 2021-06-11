Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC77C48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 22:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B232C613C6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFKWex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:34:53 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:34310 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKWev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 18:34:51 -0400
Received: by mail-yb1-f175.google.com with SMTP id c8so4695719ybq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FszwJk624O2s2hl4Xst4LxIBE2qUUXJ6Zp6MAFsDVH8=;
        b=vhrl7nWhAYgpMxpNA03kzVd7TgfFUhhrwi5RuIULtxioZlOJFAUc+avwxfpOGX6s3r
         8atE5D9eB/assD2r3MmmTnDcI40ijTfGMPoOJuig+DeFgunDX3eHueg+sRPj42J95aP4
         LVw1btVP0BGI73HLuMT/wdCGGGHjgte5IBzu1v2aAZRT089CILtRVnxWXxRBZTtYUbGF
         BgmkXKRhJfRNyqLJv4dH0pnv4hkbQY/bxsUdgx0LWLTmHlpEL+xLDSvKu8kWCjxDeDu1
         cz47qh6OXfhMTJ2+3C1ZxdeCkAI+HRelnqgwA0b19uQuB1MSui3fsMrWyneShLHx8Ld3
         k4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FszwJk624O2s2hl4Xst4LxIBE2qUUXJ6Zp6MAFsDVH8=;
        b=Wu88Ql2V1xI2WC3poYJCmRd+/QlvGza9kjASmbvRIVTDO1TlPn3ymqPGQ5Dum8HOD9
         rMzwxB6QNQbfxxYhR5oNiWriBUkFHOoIpMhmEzPcQGrXlOa2DcGO7DYVePTm2/VM2WRD
         jN4ckoD6B7IBND/In/6nZvRoBOTEXITMa8bad7qes7ui6exg2k5bdapKe05oJ4le0qbt
         Ml2cSEoNP0xbT7pCrda9q/73XLQchURhkF2k+HO+2I5bKqY0JzkCeJki9OYDU6REdkaH
         1ItP9pNNe6qiA6xQwYHT/48vgd+Cso/KJQu6VN/4Qxd9o2u/ST64C9n2PfAdjxr4qh5F
         acxg==
X-Gm-Message-State: AOAM533tfqCxd4rouyhOQhsnbaGiLvIa6eCXDgTOdfGbP0rjPpeYIl+R
        doem0tZiLUhFfBptaR/egp7qpgGU8ddgP6gwtJrhUqD7QUg=
X-Google-Smtp-Source: ABdhPJwY4nW57LZQeRJR4M/3Qw4swh4UqZY+VSw0+CJWGd7G0JqvWauQXKcZ2s5o8hJVkyb9JhBf/rle5WRkiRWPJYw=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr8773613ybn.440.1623450712798;
 Fri, 11 Jun 2021 15:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210611123042.21288-1-surban@surban.net>
In-Reply-To: <20210611123042.21288-1-surban@surban.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Jun 2021 15:31:42 -0700
Message-ID: <CABBYNZ+Z-Z8e2XPpRxfdWoP2AP5QeMVFqhk7Go+2HMD7xpdc4g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-database: No multiple calls to AcquireWrite
To:     Sebastian Urban <surban@surban.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sebastian,

On Fri, Jun 11, 2021 at 5:32 AM Sebastian Urban <surban@surban.net> wrote:
>
> This checks if an outstanding call to AcquireWrite is already in
> progress. If so, the write request is placed into the queue, but
> AcquireWrite is not called again. When a response to AcquireWrite is
> received, acquire_write_reply sends all queued writes over the acquired
> socket.
>
> Making multiple simultaneous calls to AcquireWrite makes no sense,
> as this would open multiple socket pairs and only the last returned
> socket would be used for further writes.
> ---
>  src/gatt-database.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index be6dfb265..071f88583 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2447,6 +2447,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>  {
>         struct pending_op *op = user_data;
>         struct external_chrc *chrc;
> +       struct queue *resend;
>         DBusError err;
>         int fd;
>         uint16_t mtu;
> @@ -2488,18 +2489,35 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>
>         chrc->write_io = sock_io_new(fd, chrc);
>
> -       if (sock_io_send(chrc->write_io, op->data.iov_base,
> -                               op->data.iov_len) < 0)
> -               goto retry;
> +       while ((op = queue_peek_head(chrc->pending_writes)) != NULL) {
> +               if (sock_io_send(chrc->write_io, op->data.iov_base,
> +                                       op->data.iov_len) < 0)
> +                       goto retry;
>
> -       gatt_db_attribute_write_result(op->attrib, op->id, 0);
> +               gatt_db_attribute_write_result(op->attrib, op->id, 0);
> +               pending_op_free(op);
> +       }
>
>         return;
>
>  retry:
> -       send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
> -                               op->data.iov_base, op->data.iov_len, 0,
> -                               op->link_type, false, false);
> +       /*
> +        * send_write pushes to chrc->pending_writes, so we need a
> +        * temporary queue to avoid an infinite loop.
> +        */
> +       resend = queue_new();
> +
> +       while ((op = queue_pop_head(chrc->pending_writes)) != NULL)
> +               queue_push_tail(resend, op);
> +
> +       while ((op = queue_pop_head(resend)) != NULL) {
> +               send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
> +                                       op->data.iov_base, op->data.iov_len, 0,
> +                                       op->link_type, false, false);
> +               pending_op_free(op);
> +       }

It might be better to have a separate function to flush the operation
on pending_writes since it just creating another pending_write_new we
could just call WriteValue directly since the original op can be
reused as we no longer free the op automatically.

> +       queue_destroy(resend, NULL);
>  }
>
>  static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
> @@ -2527,14 +2545,18 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
>                                         uint8_t link_type)
>  {
>         struct pending_op *op;
> +       bool acquiring = !queue_isempty(chrc->pending_writes);
>
>         op = pending_write_new(device, chrc->pending_writes, attrib, id, value,
>                                 len, 0, link_type, false, false);
>
> +       if (acquiring)
> +               return op;
> +
>         if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
>                                         acquire_write_setup,
>                                         acquire_write_reply,
> -                                       op, pending_op_free))
> +                                       op, NULL))
>                 return op;
>
>         pending_op_free(op);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
