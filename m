Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A2C48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D03D613CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFKWQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:16:16 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:41591 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKWQP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 18:16:15 -0400
Received: by mail-yb1-f174.google.com with SMTP id q21so6340049ybg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rCHhAsGLCgsxBu4NS8eS34kTv5wY4x3bvnFh7VmHjQ=;
        b=YtGuFaxkik0i5o8PRje7O7h/gqRjN5huUo7OWosMT3LqvGoZygEzWAMXKdOpaH34XW
         j7ThaFQSO0ubCzYzdG5eJZsCwuCxlTMYM5H1J0JiOWguKtRqnUKkgo3r4nqCI4dDaYDO
         0C8vXnOhLThHmdM+Vio27vTw5BIAyZJV8GQFLmtP844alPxOqdIQ7glwGKy8WPZzPT0x
         yg/TX+u+jP08mYxORjrNDhPrAhQITF/zSHSTl9E1GV4s7ZIwkkLvGGHVm8zS+VXoG7s4
         YQOyvqsdTl9eTotB/G78jQ0CWKQVIkjIM4HyzvGbl+Dia9QitEW/ugSU1XcbHiExNjaG
         pHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rCHhAsGLCgsxBu4NS8eS34kTv5wY4x3bvnFh7VmHjQ=;
        b=MDC3yBrOIp720gQGTvzVsvygwRNxa7bqFsX40s1FRH17e8dy4ROBYpBZwDBKlmbvGy
         csTZc8rPxiCZIsb5y1QWnjPDlyjEyxbTdHNBKCnaNPovDaX7gpzJliC8iM26Xc1nY0Z7
         0wsY6CrQQfsgmWfNnehZB091SS5D3Y+BHAYXYLymvAWynS1cv4p1SARz/IcZ/3wLEQ1D
         xCuVLxLrdkN36QsawToAW38qAhkxE+wvZWslPiHKgk/tamLf/+aQwVTaBaG9RNzXyjak
         qM8sNmCAOE1tNrNxJvqS0UifQ/bjmFaKsP7gMc0JeZWjqS7Z6BIWFz9ztKV8WCDETn68
         ne4g==
X-Gm-Message-State: AOAM532bFebZ82DyvSKZVnjK4ogYUjE8GjNcwO8glvoINaP1qi/pnRG4
        JFItg9VmcpN9f3Ym4dFUxEpI3UWKcbX8QU1o4Uyo8r0l41liQw==
X-Google-Smtp-Source: ABdhPJxKu8x6A6aMLcibph1Bem1uD06QaBmoKE+YKcw8UT9697lGSF21mQ7fvLP9NQXQfhk7u46xPqRzAbEZ7EwTVwk=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr9188722ybt.408.1623449596585;
 Fri, 11 Jun 2021 15:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210611122915.21068-1-surban@surban.net>
In-Reply-To: <20210611122915.21068-1-surban@surban.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Jun 2021 15:13:05 -0700
Message-ID: <CABBYNZJBbiBvw+r1XLxE5=uXVv3cXe8EpCd3YOF7ZQVmDGxyBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-server: Flush notify multiple buffer when full
 and fix overflow
To:     Sebastian Urban <surban@surban.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sebastian,

On Fri, Jun 11, 2021 at 5:31 AM Sebastian Urban <surban@surban.net> wrote:
>
> This fixes the calculation of available buffer space in
> bt_gatt_server_send_notification and sends pending notifications
> immediately when there is no more room to add a notification.
>
> Previously there was a buffer overflow caused by incorrect calculation
> of available buffer space: data->offset can equal data->len
> from a previous call to this function, leading
> (data->len - data->offset) to underflow after data->offset += 2.
> ---
>  src/shared/gatt-server.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 970c35f94..d53efe782 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1700,20 +1700,35 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
>         if (!server || (length && !value))
>                 return false;
>
> -       if (multiple)
> +       if (multiple) {
>                 data = server->nfy_mult;
>
> +               /* flush buffered data if this request hits buffer size limit */
> +               if (data && data->offset > 0 &&
> +                               data->len - data->offset < 4 + length) {
> +                       if (server->nfy_mult->id)
> +                               timeout_remove(server->nfy_mult->id);
> +                       notify_multiple(server);
> +                       data = NULL;
> +               }
> +       }
> +
>         if (!data) {
>                 data = new0(struct nfy_mult_data, 1);
>                 data->len = bt_att_get_mtu(server->att) - 1;
>                 data->pdu = malloc(data->len);
>         }
>
> +       if (multiple) {
> +               if (data->len - data->offset < 4 + length)
> +                       return false;
> +       } else {
> +               if (data->len - data->offset < 2 + length)
> +                       return false;
> +       }

We are missing free(data) when the code returns above, beside I think
it is better to group the code in something like this:

bool notify_append_le16(struct nfy_mult_data *data, uin16_t value)
{
    if (data->offset + sizeof(value) > data->size)
        return false;

    put_le16(value, data->pdu + data->offset);
    data->offset += 2;

    return true;
}

So this can be called for both adding handle and length, it may also
be cleaner to add a similar function but taking arbitrary length which
will deal with checking if the data fits and memcpy.

> +
>         put_le16(handle, data->pdu + data->offset);
>         data->offset += 2;
> -
> -       length = MIN(data->len - data->offset, length);

This was supposed to truncate the data if it was bigger than MTU, I'm
not sure we shall remove this logic or this was actually intentional?

> -
>         if (multiple) {
>                 put_le16(length, data->pdu + data->offset);
>                 data->offset += 2;
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
