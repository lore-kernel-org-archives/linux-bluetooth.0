Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D61C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 00:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023BB64EE2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 00:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBTA4A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Feb 2021 19:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBTAz5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Feb 2021 19:55:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC12C06178A
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 16:55:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y199so7806465oia.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91KdcJL+lyGhRpAHzqCrWweWKfPWy6lKqdSxpOudc20=;
        b=uS1RtHHoCoR2rw4pWl6miNADyHzk+WFDXAi40tiy8w1PNdLKtLSMZirmqqGf8zeDo6
         pvJGEEu6azNgZQjs6Cqwhx9xhSSWjExRjevslInxCh5K2aWmqkQ04wAl9aaSal4ELyyh
         De1y5y4TcDaQrf74sS1OfdOL1ko7re591MLTHlmtVi1TTjHllRGtuU7zC60VakLxOQcO
         s1FTEEJpUlnr+Ba4AZ/ejkYtoueR6UQdmiVddyMY24JaeEm/ot85uMKfIDnyTPOR7479
         +hk4tVW7wVhGkXhmqh5C29LNaV4e2qpMYt0Gt3P709wCRhJaWiDZtqoVk2yfszAYLnpB
         y8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91KdcJL+lyGhRpAHzqCrWweWKfPWy6lKqdSxpOudc20=;
        b=RttsfSEDJzCvxTwLmDw7ziYy0exUlaF8iw6k5vk2Ho+dyouowH+XBgDGtANMuse/mW
         0ZQDe7Xw8zN462jXwLFf3qu7o4m1sPWFawEvozXg17/ERMMY+3wquq0wxNngK5FNFuPd
         B9m3EyD8C46X1z3rvbXX8SxGhyQsZFeTIQlbti//ijVyBwmE9ynrpjzXhuI72ShFvETt
         PGCfHiqxHcCIqM3s8ySqdkpOkr5jgXoGg2p7kGTY1rGM1crc/y1462jLfsojSZCeE/sN
         C6eUFcd5G3OGqdJozDMMoTOJFkiraKo27gx+cTGEw6TOHfvcac/lngRz0kOO/caiZk43
         phzg==
X-Gm-Message-State: AOAM533E9i8xDe/KXq5RzWt/0JYo0EhF/2YXDAE50IIdZKKXqZyiQsZK
        C6x0sojLb948I5g5Fl479J65K56W1QaVOWXnIhjmL+5LI38=
X-Google-Smtp-Source: ABdhPJxEgASKjgLcDaZEGNjq0YHiJ/jncATG+WJu6zcY2QiUzuGQDKh4bgBYTYHrUPIVB8TtJ7lfWn0bWRMH7JNmx0E=
X-Received: by 2002:aca:c109:: with SMTP id r9mr8421592oif.64.1613782516964;
 Fri, 19 Feb 2021 16:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20210219174946.599144-1-curtis@maves.io>
In-Reply-To: <20210219174946.599144-1-curtis@maves.io>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Feb 2021 16:55:06 -0800
Message-ID: <CABBYNZKakfpzTOdZaoa0tZ5Umqu9MKMmkMfNN51XY5owC_KWwQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-database: Fix notifying on indicatable attr
To:     Curtis <curtis@maves.io>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Curtis,

On Fri, Feb 19, 2021 at 10:11 AM Curtis <curtis@maves.io> wrote:
>
> When a local GATT characteristic has both the indicate and notify
> properties, notifications will not be send to clients requesting them.
> This change fixes this, allowing for notifications to be sent.
>
> Also simplifies logic about when notifications/indications should
> be sent.
> ---
>  src/gatt-database.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index d635c3214..bd5864bcd 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1344,10 +1344,7 @@ static void send_notification_to_device(void *data, void *user_data)
>         }
>
>         ccc = find_ccc_state(device_state, notify->ccc_handle);
> -       if (!ccc)
> -               return;
> -
> -       if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
> +       if (!ccc || !(ccc->value & 0x0003))
>                 return;
>
>         device = btd_adapter_find_device(notify->database->adapter,
> @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data)
>          * TODO: If the device is not connected but bonded, send the
>          * notification/indication when it becomes connected.
>          */
> -       if (!notify->conf) {
> +       if (!(ccc->value & 0x0002)) {
>                 DBG("GATT server sending notification");
>                 bt_gatt_server_send_notification(server,
>                                         notify->handle, notify->value,
> @@ -2415,8 +2412,8 @@ static bool sock_io_read(struct io *io, void *user_data)
>                                 gatt_db_attribute_get_handle(chrc->attrib),
>                                 buf, bytes_read,
>                                 gatt_db_attribute_get_handle(chrc->ccc),
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
> -                               conf_cb : NULL, chrc->proxy);
> +                               conf_cb,
> +                               chrc->proxy);

Not why are you changing this code to always set the conf_cb? This
would then always send indication rather then notifications:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1387

We might need to check what value it stored in the ccc state if both
indication and notification is supported.

>
>         return true;
>  }
> @@ -2725,8 +2722,8 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>                                 gatt_db_attribute_get_handle(chrc->attrib),
>                                 value, len,
>                                 gatt_db_attribute_get_handle(chrc->ccc),
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
> -                               conf_cb : NULL, proxy);
> +                               conf_cb,
> +                               proxy);
>  }
>
>  static bool database_add_ccc(struct external_service *service,
> --
> 2.30.1
>
>


-- 
Luiz Augusto von Dentz
