Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD62C83000
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC4E2074A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 00:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH/Gj0p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD2Ah6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD2Ah5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 20:37:57 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9DC03C1AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 17:37:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t199so265497oif.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXbjiSGR70Rs7XnaC6XEPPYDg/3o7H6rfC5H6HvRnD8=;
        b=hH/Gj0p/WQVF76WcR21W+7hJsABBWH/oubVBV2w02Ev8N5wA6ocMIXDsUfE8J7VtI2
         Cn0MH1jeiif8eio9sm03YP/3d3P5rAJgG/jFVpZmj3IEJvi68WQy/2ju/WiKvkNjUmtn
         2OHsesjDxw5jmW9Cw9qUCxRNvaX5xycaPbj4ZdW7/PS1b0lk50BsIq94Xar5S07ZI9wV
         /ZgU0JkDBXZ7SCU/IlV1o5uAHKSnU4Iu73vexP3FxHQXh43qwL4rQ/L8OZuu2Q5MY5qr
         J7UUQ3AowrzmR25V74OnlKSVAgbqLBafS9UM9IKqwl/SC96Yi0ii/bo/JKTCduuBp7tc
         wOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXbjiSGR70Rs7XnaC6XEPPYDg/3o7H6rfC5H6HvRnD8=;
        b=Oil72rtp9qualhNCTk9yTCjyA7yohp7EqSDGtTYPVU70iv60ggRTVK6A1Y5VgGbNMp
         tuRRmz5Xi4PvNvEHcuWY4z5WN0u1tBDVCS+2R1nRry/OMWXYpXGtQHwmTWfeFCwrwTa5
         x2jW4sPx/fsBPEiiYWDx7LZ0WAraztUvEIWa8QVhfOh4g5gPiR07OPGII1cNJS0v/Xag
         BEgvYXxZMbeD49VcDGJMblmEimfHDYVfelMd4JNYPY9xeTBh5lDEmJxcxVqT7dTYsG+8
         X51nlwDfwBuKi92jM3RaaRf8JfEoQ07Y+DFwCULfpG/5Y9IXpreChWuzFY8rvUj345sK
         G0PQ==
X-Gm-Message-State: AGi0PuahwAQbS4XgvdOjZ9dkbcsCP+ML4zi6gtSm9Y53UjYihlwi9JV1
        9EcQlSpicexxp2bR+8QEJ51Q5iuQ2tttEMu1N19iX3je
X-Google-Smtp-Source: APiQypLVhf7p4sdshplb+CQfJyZBmuzBX4w2puDOe6ScBU9N0DBV6FPRF5VuWKhnOJSh610sFU3SxhLuPTxpalJXOIo=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr66264oif.108.1588120675667;
 Tue, 28 Apr 2020 17:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200428175149.1784-1-david@lechnology.com>
In-Reply-To: <20200428175149.1784-1-david@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Apr 2020 17:37:43 -0700
Message-ID: <CABBYNZ+6JZ0x0bJW8jNJnrg5tS=-ujKkq_rNZX2Rk3NWi0mwSQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/gatt-client: allow "command" even when property
 not set
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Tue, Apr 28, 2020 at 10:59 AM David Lechner <david@lechnology.com> wrote:
>
> This modifies the GATT client characteristic WriteValue D-Bus method to
> not check that the characteristic supports the requested type of
> write when the "type" option is set to "command".
>
> Before this change, if the "type" option was used and it was set to
> "reliable" or "request", then BlueZ would attempt the write even if the
> characteristic does not support that write type. On the other hand, if
> "type" was set to "command" or was not specified, the method would
> return a org.bluez.Error.NotSupported error without attempting to write.
>
> After this change, the WriteValue method will consistently always
> ignore the characteristic properties and attempt to write when the
> "type" option is used instead of having a different behavior for the
> "command" type.
> ---
>
> Related discussion:
> https://lore.kernel.org/linux-bluetooth/685ddf1b-c824-9c45-298f-97b70cbf975f@lechnology.com
>
>
>  src/gatt-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index a9bfc2802..20c3fbec2 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1050,8 +1050,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         return NULL;
>         }
>
> -       if ((type && strcasecmp(type, "command")) || offset ||
> -                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> +       if ((type && strcasecmp(type, "command")) || offset || (!type &&
> +                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
>                 goto fail;
>
>         supported = true;
> --
> 2.17.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
