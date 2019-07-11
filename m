Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9BCC74A50
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3086208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYhdC96c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGKIhU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:37:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34261 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKIhU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 04:37:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so5058685otk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2019 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht+00erux/jbGt2cdAjlypI50xYsu6MyRHHv09uo8SI=;
        b=iYhdC96cYOme64Bkt1QH1E8hgH2h95F25qr1Vd5FSfJ+KUiv7efbElnBW7jBxpvzhA
         N0584czqEEzk89dEw7KoBvUoMKpao5PX2nud7y99fzMeucmvuACUm8fEC3ns6v3GsVAg
         eSJYcWs+7RhNzVCi9YybCeNLKHLmsDF0d/WvGjCAEJRXKKUYU8XVErntfsfGscsXFi+J
         8ZfXrnR/ZLG+BlbbpIU4aHoPOcKRbMU0+P8YInjgpWERS0ffj5YfVWVYf6Glqw/ON9Ii
         YlKp1bq3JmSBnnk2IR8Q2dUrjXl4ulKi4k4FniAUIpevL5Rpfq8XZ7Jh5bawRbt99GlS
         QDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht+00erux/jbGt2cdAjlypI50xYsu6MyRHHv09uo8SI=;
        b=iTFQhCCxBlFKWe+4BJd8tQ0g7CzwxLdWSfM5Hp+HXYbWPwKZQM2nGWyrW4QHb2RpUa
         Or3daEEvcgHWlhSOT2ghKpfsFOPzbWO+Gmd778x7UagBkPwriF8sfMtxW2qgi0P9YbGH
         I+kJbjBYLXKkYiDe+AOb4MY5pHuvz25hLl2CkBltQufzOgNlaEzfXAQSAL3AMdbUUkBy
         SJoN6/iUAvpiPNik2YrTNXl1j+GJDsyGGoV5zSrgExP4uCDBXp7nQroEuZhMud3OwrWr
         qTFjufRT1J9y/lz9iNDHNcFBhwMQ2j/Ib+In34OlxKKJkhr98itrs2aWsEkidxmW4vkZ
         7K2Q==
X-Gm-Message-State: APjAAAVlWMLuO51JbQ6z31j/bAWSRAQKK9hjBPRSlMhAJNn6aky4YXD1
        7usQpRLqg02Xx4y5lEHOChPvyxIJTehwPHf6077FBtZY
X-Google-Smtp-Source: APXvYqzZkH/03u7eVicZUGf5Vl5Mkb8w3VKeyXSnqFfZVJIyvrkAIRsIzZVG0rtVDILgcCZKKYY6BsTwdShEVKKVToo=
X-Received: by 2002:a9d:7003:: with SMTP id k3mr1722867otj.28.1562834239315;
 Thu, 11 Jul 2019 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <5730d9a34cc331e46ad86c2073f2cb5a94c80807.camel@adventurousmachines.com>
In-Reply-To: <5730d9a34cc331e46ad86c2073f2cb5a94c80807.camel@adventurousmachines.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Jul 2019 11:37:07 +0300
Message-ID: <CABBYNZJ5cQ=Jg2zjD-Dj9XK2d9UD36ewjRsHfkyFSKi7gdHJPQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix failure of repeated AcquireNotify calls
To:     rob@adventurousmachines.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rob,

On Tue, Jul 9, 2019 at 8:09 PM Rob Spanton <rob@adventurousmachines.com> wrote:
>
> This patch fixes a problem that can be encountered if a DBUS client
> performs the following steps:
>
>  1) Calls AcquireNotify on a characteristic
>  2) Closes the fd produced by AcquireNotify
>  3) Immediately calls AcquireNotify again on the same characteristic
>  4) Disconnects DBUS client (does not have to be immediately)
>  5) Reconnects DBUS client and call AcquireNotify
>
> If these steps are followed, then the third call to AcquireNotify
> will often be responded to with an error message stating "Notify
> acquired".  Furthermore, the second call to AcquireNotify will not be
> provided with an fd.
>
> It turns out that the following was happening:  Closing the fd causes
> bluez to disable notifications on that characteristic by writing to
> the CCC.  If the second call to AcquireNotify is made before that CCC
> write has completed, then a new write to the CCC to re-enable
> notifications is enqueued.  Once that first write has completed, the
> second write is then taken from the queue and started in
> `disable_ccc_callback()`.  Unfortunately `disable_ccc_callback()` was
> not actually using the data from the queue, but was instead just
> re-using the data that it had been passed (`notify_data` instead of
> `next_data`).
>
> This meant that the write to the CCC to enable notifications would
> happen, but the callback that needed to be made to the code that was
> waiting for the enqueued operation to complete would never happen.  In
> this AcquireNotify case, the register_notify_io_cb() function would
> not be called, resulting in no socket creation and no response to the
> second AcquireNotify call.  Instead it would leave some state
> hanging around on bluez's representation of the characteristic, and so
> subsequent calls to AcquireNotify by any DBUS client would fail with
> the aforementioned error.
>
> The fix is simple here -- make `disable_ccc_callback()` pass the
> correct data through.
> ---
>  src/shared/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 858209c24..2c104097e 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1947,7 +1947,7 @@ static void disable_ccc_callback(uint8_t opcode, const void *pdu,
>          */
>         while (1) {
>                 next_data = queue_pop_head(notify_data->chrc->reg_notify_queue);
> -               if (!next_data || notify_data_write_ccc(notify_data, true,
> +               if (!next_data || notify_data_write_ccc(next_data, true,
>                                                         enable_ccc_callback))
>                         return;
>         }
> --
> 2.21.0
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
