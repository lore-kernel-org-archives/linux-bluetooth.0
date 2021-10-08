Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D40C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1275160FF2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJHT0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhJHT0K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:26:10 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF79C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:24:14 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id e7so7442010ual.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLQgtEJuUPoGE/JuZBkEZQdt4QGU1zl2CS9aovqDGec=;
        b=ZulmgsfvqA7Kz5xyu1b7+UWM/FOr7hpomyPAKZZ3P6F/7buch+GFi8kWGXXJQhq0Vr
         Jfkm5TgxuC4UPebGttGdjHX2YFYdh5jA95p1Hpxd9LktS0tYOqR47K1lJZgMCiAC6fUP
         md4wJ+CWZ7Pv7sjQQld4i4JqfiDNfJ1kEGXZDdyyQxdwGQGgxLTu149lP5g0q1C6q/mL
         JzNsgyAUlIDyHc6mKdYXSCE+PQQCuWEKneF5wILvjFLViiuvdrilsMBucvi39y+JAgbn
         eFJgRMFFqvL82U8/vp3+w8ms1wsNOphByjTMw4BiczJwF84l/Szg7VUHZ616GnJET6hc
         dYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLQgtEJuUPoGE/JuZBkEZQdt4QGU1zl2CS9aovqDGec=;
        b=htsGdD8gtrMRTjBsbiwvPvj0AwI8EUYwfHm0kAQpuLTj4hKyJBCFBA+QMp4kEwTbnP
         zF6JbIuWjsBkoZWxqMPjFyUsG2qvUjhinV0apF+rtKdo32suI2vqCcYlzKJTkfTjjnxP
         ZJ3f2REyzVehuPBC4w+CGx+pAna/i1fAek5nX1ZcY5loaCRU3gEQqWVpkqHnt74xSVmG
         a+YZLWjGt5Bcm0tWRKbLFkSHZGiCnXfe1fB6w9JsIOqj3B+Ws61g4vISyPObvK5+nkEi
         sUej2Wk2h9gEKME08bo3rTooZGv/StYUwFLLqivBxqLwEFpT7w2ms08ghrU9HAb72HHf
         qIrA==
X-Gm-Message-State: AOAM530TT5jIPLo7WaZZCB4/F5vi3Tg3NU08dFqU6m03NMl/WhqOnlgz
        jwV484WkErdXGMi8PMajx9TDzgVmIrPnzC5f/M4lwdIcqVw=
X-Google-Smtp-Source: ABdhPJz67mC/LX1F8yypcWvlKN1huLOCok0rRTgV6Va9FnbHDNE/A8TzpBgRCLqtsyDXm7giP1Dxlr5pOooyT8omXWg=
X-Received: by 2002:ab0:2404:: with SMTP id f4mr5262488uan.102.1633721053456;
 Fri, 08 Oct 2021 12:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211008190023.15462-1-bernie@allthenticate.net>
In-Reply-To: <20211008190023.15462-1-bernie@allthenticate.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 8 Oct 2021 12:24:02 -0700
Message-ID: <CABBYNZLx8HCO3f6+NsPaAUVKSshdiPM_eEq2qK82mkwno-1pkw@mail.gmail.com>
Subject: Re: [BlueZ v2] gatt: more fixes with cleanup on disconnect/timeout
To:     Bernie Conrad <bernie@allthenticate.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Bernie Conrad <bernie@allthenticate.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bernie,

On Fri, Oct 8, 2021 at 12:01 PM Bernie Conrad <bernie@allthenticate.net> wrote:
>
> From: Bernie Conrad <bernie@allthenticate.com>
>
> The changes in gatt-database.c fix a use after free that was introduced
> after the last cleanup patch, ccc_new and write_new operations were not
> being properly unregistered because they were not assigned a disconn_id.
>
> The changes in gatt-db add similar cleanup to pending reads/writes where
> timeouts after a disconnect would cause a similar use after free with
> already cleaned up resoureces, this adds a simple cb to set on a pending
> read/write if a disconnect has occurred to skip the use.
>
> v2: Fixing formatting issues
>
> ---
>  src/gatt-database.c  |  4 ++--
>  src/shared/gatt-db.c | 38 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 475e7873c..00647cf08 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -978,7 +978,7 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
>         op->attrib = attrib;
>         op->link_type = link_type;
>
> -       bt_att_register_disconnect(att,
> +       op->disconn_id = bt_att_register_disconnect(att,
>                                    pending_disconnect_cb,
>                                    op,
>                                    NULL);
> @@ -2418,7 +2418,7 @@ static struct pending_op *pending_write_new(struct bt_att *att,
>         op->prep_authorize = prep_authorize;
>         queue_push_tail(owner_queue, op);
>
> -       bt_att_register_disconnect(att,
> +       op->disconn_id = bt_att_register_disconnect(att,
>                             pending_disconnect_cb,
>                             op, NULL);

These changes above shall be split into another patch.

> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 3a02289ce..8423961f8 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -77,17 +77,23 @@ struct attribute_notify {
>
>  struct pending_read {
>         struct gatt_db_attribute *attrib;
> +       struct bt_att *att;
>         unsigned int id;
>         unsigned int timeout_id;
>         gatt_db_attribute_read_t func;
> +       bool disconn;
> +       unsigned int disconn_id;
>         void *user_data;
>  };
>
>  struct pending_write {
>         struct gatt_db_attribute *attrib;
> +       struct bt_att *att;
>         unsigned int id;
>         unsigned int timeout_id;
>         gatt_db_attribute_write_t func;
> +       bool disconn;
> +       unsigned int disconn_id;
>         void *user_data;
>  };
>
> @@ -139,8 +145,10 @@ static void pending_read_result(struct pending_read *p, int err,
>         if (p->timeout_id > 0)
>                 timeout_remove(p->timeout_id);
>
> -       p->func(p->attrib, err, data, length, p->user_data);
> +       if (!p->disconn)
> +               p->func(p->attrib, err, data, length, p->user_data);
>
> +       bt_att_unregister_disconnect(p->att, p->disconn_id);
>         free(p);
>  }
>
> @@ -156,8 +164,10 @@ static void pending_write_result(struct pending_write *p, int err)
>         if (p->timeout_id > 0)
>                 timeout_remove(p->timeout_id);
>
> -       p->func(p->attrib, err, p->user_data);
> +       if (!p->disconn)
> +               p->func(p->attrib, err, p->user_data);
>
> +       bt_att_unregister_disconnect(p->att, p->disconn_id);
>         free(p);
>  }

I wonder if it wouldn't be better to use a specific error to inform it
the operation has been aborted e.g. -ECONNABORTED instead of
duplicating the handling of disconnection, btw if we don't call the
callback who is doing the cleanup in gatt-server.c, we still need to
call async_read_op_destroy/async_write_op_destroy or that is taken
care somewhere else?

Also it would be great if we had a test in unit/test-gatt.c that
covers such scenarios, e.g disconnect while read/write is pending.

> @@ -1868,6 +1878,13 @@ bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
>         return true;
>  }
>
> +static void pending_read_cb(int err, void *user_data)
> +{
> +       struct pending_read *p = user_data;
> +
> +       p->disconn = 1;
> +}
> +
>  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                                 uint8_t opcode, struct bt_att *att,
>                                 gatt_db_attribute_read_t func, void *user_data)
> @@ -1901,6 +1918,11 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                 p->func = func;
>                 p->user_data = user_data;
>
> +               p->disconn = 0;
> +               p->disconn_id = bt_att_register_disconnect(att,
> +                                       pending_read_cb, p, NULL);
> +               p->att = att;
> +
>                 queue_push_tail(attrib->pending_reads, p);
>
>                 attrib->read_func(attrib, p->id, offset, opcode, att,
> @@ -1956,6 +1978,13 @@ static bool write_timeout(void *user_data)
>         return false;
>  }
>
> +static void pending_write_cb(int err, void *user_data)
> +{
> +       struct pending_write *p = user_data;
> +
> +       p->disconn = 1;
> +}
> +
>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         const uint8_t *value, size_t len,
>                                         uint8_t opcode, struct bt_att *att,
> @@ -1995,6 +2024,11 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                 p->func = func;
>                 p->user_data = user_data;
>
> +               p->disconn = 0;
> +               p->disconn_id = bt_att_register_disconnect(att,
> +                                       pending_write_cb, p, NULL);
> +               p->att = att;
> +
>                 queue_push_tail(attrib->pending_writes, p);
>
>                 attrib->write_func(attrib, p->id, offset, value, len, opcode,
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
