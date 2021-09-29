Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAD8613A9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbhI2VHT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2VHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 17:07:15 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9EC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:05:32 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id y141so4702366vsy.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2BcNEmPaUXLpq1gPlQI1niVZYvihN3NeY0qgMoH550=;
        b=p1GgG3oUCBninSE5mzFBdkUKQXMOEsoKQppanbW/QnvNqIfiqDMMmNEf19+ugMyXNL
         zdiHyrHPA1THkBdacAijhcHToN37I3+Fn+PKxD832RYUpmYu0m3u6svPymWV+AQdm+wx
         UOuQnb7B2EEBsFxpeENFW2tgFZN8i3qIqX/IDQZCGMLZ0Ak966RFpUk+yvZE/oG2/But
         BKDIO8wsxgLbutUdQCySWG9xQzLambDsbPj381Gcn9tKNMVWPbV9UN/CNTi8d3E+C6CG
         9P+A/UEIB5oAgIvjLSJP/sfR4GXL3uGYnuTkQZHsSEO2TBfM7Lh6Th2V3tSHlfSaBdoD
         qIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2BcNEmPaUXLpq1gPlQI1niVZYvihN3NeY0qgMoH550=;
        b=wNxmrA0X8y/N/i5aQHhKege2d2VIt9AJIdbO6LUtv6R09+mRdRQJJ7f04rgw6PnrXk
         TZiy5V05/sJ2oCTmaOTHOGyF3ldtzRkUfwYaLJIFWWKMN1d1AtkO4q4PRSnOsGaW2h1d
         VcizExsLe3YbmCjwtPd5k87WqGLw7Q3/6S3+aumtGUYgLQvqmfdlpvrVB8e+AbjLXHq/
         71ieoXiiJL3Yg2iqcibbIIhip4rqXwdO1HT4q2WKnhmpKXgjNADX/2ggsw8R2AX3r+Ny
         PxRyAepOnaFrTrzNRhZoDg53MNziFNS7k4vYYd0OC12bAlxq3qTqvy7Wn8EmWf3SRAuY
         T1WA==
X-Gm-Message-State: AOAM531Pb5DKK7Yo8K3EdrLqK9Inh3EVsHxtHyAKUUmUGLyaSf4ENrmt
        OQcKnBBS5R3H/3ZZQhZSH5rk9vfen20dux9eK/jFwhAyjQI=
X-Google-Smtp-Source: ABdhPJxHXW7sH3EqVi42kCi3EA9ZfxcMkcdhdm86essX8TVe8y1QBxfxanIi0kqdgzo4+2NH7akczEN+VqdylbuhwZc=
X-Received: by 2002:a67:ea83:: with SMTP id f3mr586458vso.39.1632949531778;
 Wed, 29 Sep 2021 14:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210928230015.26295-1-bernie@allthenticate.net>
In-Reply-To: <20210928230015.26295-1-bernie@allthenticate.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 14:05:20 -0700
Message-ID: <CABBYNZLv5=Wj_PJ7UVtLouWiAudaZDcvJiAhKzQRSmDbzXy5kg@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ v2] Cleaning up gatt operations on a disconnect
 to fix possible use after free
To:     Bernie Conrad <bernie@allthenticate.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bernie,

On Tue, Sep 28, 2021 at 4:01 PM Bernie Conrad <bernie@allthenticate.net> wrote:
>
> There is a current use after free possible on a gatt server if a client
> disconnects while a WriteValue call is being processed with dbus.
>
> This patch includes the addition of a pending disconnect callback to handle
> cleanup better if a disconnect occurs during a write, an acquire write
> or read operation using bt_att_register_disconnect with the cb.
>
> v2: Fixed a bad call to pending_read_new
>
> ---
>  src/gatt-database.c | 115 +++++++++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 50 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 1f7ce5f02..a03c579cf 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -933,6 +933,24 @@ static struct btd_device *att_get_device(struct bt_att *att)
>         return btd_adapter_find_device(adapter, &dst, dst_type);
>  }
>
> +
> +static void pending_op_free(void *data)
> +{
> +       struct pending_op *op = data;
> +
> +       if (op->owner_queue)
> +               queue_remove(op->owner_queue, op);
> +
> +       free(op);

We might need to do something like the following:

https://gist.github.com/Vudentz/958d540591d1ae6a32d226ef8a0d6d54

Otherwise we risk the op being freeing when the op is completely
properly but when att is disconnected it still runs
pending_disconnect_cb causing a UAF.

> +}
> +
> +static void pending_disconnect_cb(int err, void *user_data)
> +{
> +       struct pending_op *op = user_data;
> +
> +       op->owner_queue = NULL;
> +}
> +
>  static struct pending_op *pending_ccc_new(struct bt_att *att,
>                                         struct gatt_db_attribute *attrib,
>                                         uint16_t value,
> @@ -956,17 +974,12 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
>         op->attrib = attrib;
>         op->link_type = link_type;
>
> -       return op;
> -}
> +       bt_att_register_disconnect(att,
> +                                  pending_disconnect_cb,
> +                                  op,
> +                                  NULL);
>
> -static void pending_op_free(void *data)
> -{
> -       struct pending_op *op = data;
> -
> -       if (op->owner_queue)
> -               queue_remove(op->owner_queue, op);
> -
> -       free(op);
> +       return op;
>  }
>
>  static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
> @@ -2169,24 +2182,26 @@ done:
>         gatt_db_attribute_read_result(op->attrib, op->id, ecode, value, len);
>  }
>
> -static struct pending_op *pending_read_new(struct btd_device *device,
> +
> +static struct pending_op *pending_read_new(struct bt_att *att,
>                                         struct queue *owner_queue,
>                                         struct gatt_db_attribute *attrib,
> -                                       unsigned int id, uint16_t offset,
> -                                       uint8_t link_type)
> +                                       unsigned int id, uint16_t offset)
>  {
>         struct pending_op *op;
>
>         op = new0(struct pending_op, 1);
>
>         op->owner_queue = owner_queue;
> -       op->device = device;
> +       op->device = att_get_device(att);
>         op->attrib = attrib;
>         op->id = id;
>         op->offset = offset;
> -       op->link_type = link_type;
> +       op->link_type = bt_att_get_link_type(att);
>         queue_push_tail(owner_queue, op);
>
> +       bt_att_register_disconnect(att, pending_disconnect_cb, op, NULL);
> +
>         return op;
>  }
>
> @@ -2243,18 +2258,16 @@ static void read_setup_cb(DBusMessageIter *iter, void *user_data)
>         dbus_message_iter_close_container(iter, &dict);
>  }
>
> -static struct pending_op *send_read(struct btd_device *device,
> +static struct pending_op *send_read(struct bt_att *att,
>                                         struct gatt_db_attribute *attrib,
>                                         GDBusProxy *proxy,
>                                         struct queue *owner_queue,
>                                         unsigned int id,
> -                                       uint16_t offset,
> -                                       uint8_t link_type)
> +                                       uint16_t offset)
>  {
>         struct pending_op *op;
>
> -       op = pending_read_new(device, owner_queue, attrib, id, offset,
> -                                                       link_type);
> +       op = pending_read_new(att, owner_queue, attrib, id, offset);
>
>         if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup_cb,
>                                 read_reply_cb, op, pending_op_free) == TRUE)
> @@ -2337,15 +2350,17 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
>         }
>
>  done:
> -       gatt_db_attribute_write_result(op->attrib, op->id, ecode);
> +       // Make sure that only reply if the device is connected
> +       if (btd_device_is_connected(op->device))
> +               gatt_db_attribute_write_result(op->attrib, op->id, ecode);
>  }
>
> -static struct pending_op *pending_write_new(struct btd_device *device,
> +static struct pending_op *pending_write_new(struct bt_att *att,
>                                         struct queue *owner_queue,
>                                         struct gatt_db_attribute *attrib,
>                                         unsigned int id,
>                                         const uint8_t *value, size_t len,
> -                                       uint16_t offset, uint8_t link_type,
> +                                       uint16_t offset,
>                                         bool is_characteristic,
>                                         bool prep_authorize)
>  {
> @@ -2356,33 +2371,37 @@ static struct pending_op *pending_write_new(struct btd_device *device,
>         op->data.iov_base = (uint8_t *) value;
>         op->data.iov_len = len;
>
> -       op->device = device;
> +       op->device = att_get_device(att);
>         op->owner_queue = owner_queue;
>         op->attrib = attrib;
>         op->id = id;
>         op->offset = offset;
> -       op->link_type = link_type;
> +       op->link_type = bt_att_get_link_type(att);
>         op->is_characteristic = is_characteristic;
>         op->prep_authorize = prep_authorize;
>         queue_push_tail(owner_queue, op);
>
> +       bt_att_register_disconnect(att,
> +                           pending_disconnect_cb,
> +                           op, NULL);
> +
>         return op;
>  }
>
> -static struct pending_op *send_write(struct btd_device *device,
> +static struct pending_op *send_write(struct bt_att *att,
>                                         struct gatt_db_attribute *attrib,
>                                         GDBusProxy *proxy,
>                                         struct queue *owner_queue,
>                                         unsigned int id,
>                                         const uint8_t *value, size_t len,
> -                                       uint16_t offset, uint8_t link_type,
> +                                       uint16_t offset,
>                                         bool is_characteristic,
>                                         bool prep_authorize)
>  {
>         struct pending_op *op;
>
> -       op = pending_write_new(device, owner_queue, attrib, id, value, len,
> -                                       offset, link_type, is_characteristic,
> +       op = pending_write_new(att, owner_queue, attrib, id, value, len,
> +                                       offset, is_characteristic,
>                                         prep_authorize);
>
>         if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
> @@ -2558,17 +2577,16 @@ static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
>  }
>
>  static struct pending_op *acquire_write(struct external_chrc *chrc,
> -                                       struct btd_device *device,
> +                                       struct bt_att *att,
>                                         struct gatt_db_attribute *attrib,
>                                         unsigned int id,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t link_type)
> +                                       const uint8_t *value, size_t len)
>  {
>         struct pending_op *op;
>         bool acquiring = !queue_isempty(chrc->pending_writes);
>
> -       op = pending_write_new(device, chrc->pending_writes, attrib, id, value,
> -                               len, 0, link_type, false, false);
> +       op = pending_write_new(att, chrc->pending_writes, attrib, id, value,
> +                               len, 0, false, false);
>
>         if (acquiring)
>                 return op;
> @@ -2851,8 +2869,8 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
>                 goto fail;
>         }
>
> -       if (send_read(device, attrib, desc->proxy, desc->pending_reads, id,
> -                                       offset, bt_att_get_link_type(att)))
> +       if (send_read(att, attrib, desc->proxy, desc->pending_reads, id,
> +                                       offset))
>                 return;
>
>  fail:
> @@ -2883,10 +2901,9 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
>         if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
>                 if (!device_is_trusted(device) && !desc->prep_authorized &&
>                                                 desc->req_prep_authorization)
> -                       send_write(device, attrib, desc->proxy,
> +                       send_write(att, attrib, desc->proxy,
>                                         desc->pending_writes, id, value, len,
> -                                       offset, bt_att_get_link_type(att),
> -                                       false, true);
> +                                       offset, false, true);
>                 else
>                         gatt_db_attribute_write_result(attrib, id, 0);
>
> @@ -2896,9 +2913,8 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
>         if (opcode == BT_ATT_OP_EXEC_WRITE_REQ)
>                 desc->prep_authorized = false;
>
> -       if (send_write(device, attrib, desc->proxy, desc->pending_writes, id,
> -                       value, len, offset, bt_att_get_link_type(att), false,
> -                       false))
> +       if (send_write(att, attrib, desc->proxy, desc->pending_writes, id,
> +                       value, len, offset, false, false))
>                 return;
>
>  fail:
> @@ -2977,8 +2993,8 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
>                 goto fail;
>         }
>
> -       if (send_read(device, attrib, chrc->proxy, chrc->pending_reads, id,
> -                                       offset, bt_att_get_link_type(att)))
> +       if (send_read(att, attrib, chrc->proxy, chrc->pending_reads, id,
> +              offset))
>                 return;
>
>  fail:
> @@ -3016,9 +3032,9 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
>         if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
>                 if (!device_is_trusted(device) && !chrc->prep_authorized &&
>                                                 chrc->req_prep_authorization)
> -                       send_write(device, attrib, chrc->proxy, queue,
> +                       send_write(att, attrib, chrc->proxy, queue,
>                                         id, value, len, offset,
> -                                       bt_att_get_link_type(att), true, true);
> +                                       true, true);
>                 else
>                         gatt_db_attribute_write_result(attrib, id, 0);
>
> @@ -3039,13 +3055,12 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
>         }
>
>         if (g_dbus_proxy_get_property(chrc->proxy, "WriteAcquired", &iter)) {
> -               if (acquire_write(chrc, device, attrib, id, value, len,
> -                                               bt_att_get_link_type(att)))
> +               if (acquire_write(chrc, att, attrib, id, value, len))
>                         return;
>         }
>
> -       if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
> -                       offset, bt_att_get_link_type(att), false, false))
> +       if (send_write(att, attrib, chrc->proxy, queue, id, value, len,
> +                       offset, false, false))
>                 return;
>
>  fail:
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
