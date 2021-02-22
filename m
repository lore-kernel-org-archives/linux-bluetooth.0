Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C460C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4064E32
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhBVS1b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhBVS1J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 13:27:09 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B13C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:26:28 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id f3so14915692oiw.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqEGoIAFQJRuUf5lbgT50yn6bPpNVsaSOeWTqV9pG3Y=;
        b=ox+S8xJOZjCyPJ/HCf7L5o7DrvGnar57qbG6ngko8b5Zr49qip8g+7ccTC9QVlxkap
         gkfmNTMpM6b+dOX7XA5NP1xc+R3qK64j8164VjdoSsDg/7izzsst2D8OZX+VihRH8oF8
         0wr/OXFz2pe3y5ocOUo0VLYhmRKIC9f2mSF8Ry8cwlM0aGEpVdKwWehH3M7UD4yj40V7
         FKKO3i48yMr5JGj16rFYOhZtSA2JH9aVY6Ahout7ieXcfk3//ADYPOLwD2gadM6bm6dw
         AgXL8/1C8m8rDTroI+lndSHkugk+qhPmzmlOjKFMaptrdr5z7AbnxRoxMyHn44hixFnf
         lxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqEGoIAFQJRuUf5lbgT50yn6bPpNVsaSOeWTqV9pG3Y=;
        b=b/h+CaAToO45PXSvlv+4IonSRz6OK2lSt5bwDqsKofZlhAzHhlVeL08tnpq0iigt4D
         jqwcOn9UtLbQ7VQ2rtnOUFDCLDCfNeUueEK6a84q+Eee6cwEX6x+ykk3RjO5YNnkcFxg
         FeAJaKa/y33ngdJ4xl6+/zv7XdhrRISmuU6KccKh+yU8Ch4szU/N1z9730iFbsP0ZvDM
         cuWQ0N57PXqQzayexigEbkKGx4FZ8IpLOF2/v74sOQav9DERdF6rqESSI4xz3mmz0ZVq
         u/B07v2zl+JLp2Siv0bX9JE17ev9Y7KedUT9vPyoggOq4IeRNao8B/QkNSFg54ww/3dJ
         X3Tw==
X-Gm-Message-State: AOAM531/tVt2TrrAqpQ4V9yylcQzzj8llH2W4O1QJosFHk9nSzs3iiBA
        8rANvMa/ZcoNE2pYhDDu2cCudZAZBaasvK29Hg0=
X-Google-Smtp-Source: ABdhPJwIrwo9AbeZXxA47QinL8inMzKK8WSxWN4LdGDa2zchcgENTGKRs9ycvjA9OyN96te4IdfoZf2qr2wiv1c926s=
X-Received: by 2002:a54:468f:: with SMTP id k15mr16503329oic.58.1614018387517;
 Mon, 22 Feb 2021 10:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20210219174946.599144-1-curtis@maves.io>
In-Reply-To: <20210219174946.599144-1-curtis@maves.io>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Feb 2021 10:26:16 -0800
Message-ID: <CABBYNZ+g8b8TKh7Hb-N74xX7ioFeDAu=zO5BZLcSv_dyopeVwQ@mail.gmail.com>
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
