Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4015EC433EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B73B20714
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu9oMjvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgGWQi7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgGWQi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 12:38:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4FC0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 09:38:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h1so4796748otq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+k6tAPdKA8egZIakYW/hwYr6S0mppD43czoiEEi8acU=;
        b=cu9oMjvNZ71JgITrfgZlh270OiNQtK3s9LOS/AwIDumEYpY1JUukyvG4/P43fE1aTL
         7OQvQGtAPBzdBPnsT9Q3OB/el4BunVwP2HD4FE6LYwd9ydqIwOCKUV9sPdLgiVXzk8YQ
         5o97kum+N5CcuS7ANtJ56WV8GG0J+6o5LVDfrDN0oA2k4aSr9GAYIuXH6zyBEN1nBr7o
         dHIhelYRJ4ONAOSwiS1h6YobE5PANWUqDCy9C57zG4Yh6ky1lKk7CUgq8NrhA2M5FVnO
         HQNBeIPlrl92WGCy3wYHiTh++qH/vKc+EuPwWmmhWmvDLKlkWMHYzBoi9ipyoa5Qhg4O
         NCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+k6tAPdKA8egZIakYW/hwYr6S0mppD43czoiEEi8acU=;
        b=Lf8aZdF9EtI2zXLqh3ui3oiQJm3lCrNf1Pq9GxtucZw1R7Er5KV5xe8IEjqR7EHsFq
         K/EkkCFfY61VpbhA3xLEnVQjdFM6c4hEgI0qoe3cR7plUkv7PzMPDmGNKvTdBhhSFDbs
         dnUu6eWZcubxcEQ5VJ8rIgwGD/vW2lnCFd8w2rbTDpN5HY74zNY+thEDdU69jEabMDLL
         FoW2kzV+1gt9sSORyBMSwS7sOAwM9m8WQdYy8GGcwQGpwrTmjAkoFz9v/Dv3y9+IZvWc
         ApUkEexWEH609GDfETfcn/Pgj7z6uZ9nxP7DKv3UKa57+HTaVe3TB3DtJmC3WB+z9hLS
         vTtA==
X-Gm-Message-State: AOAM5335rKplJS8ncCcWsh/R5/+bDzqWil8Py7sVZmZfhZlV20/HSSrX
        cdhYrN8wkEElDwRvJX39pPNJsmTYVWSi3CeRM9cXzJrc
X-Google-Smtp-Source: ABdhPJwcdBgpmLx2yLjiHwjN/peSZ4TxQ8ZLd+8DMD5bFWg9g9CXKzcZlq8iRfUePsOJbWYftWqlnMyHXNxcceeUCQQ=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr4848377oti.88.1595522338476;
 Thu, 23 Jul 2020 09:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200718004942.326261-1-luiz.dentz@gmail.com>
In-Reply-To: <20200718004942.326261-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Jul 2020 09:38:47 -0700
Message-ID: <CABBYNZK3vKavAbzzy1QuW6YwyU=w1fzJ0FZcra9ygHm0CMeMGA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Don't remove temporary devices on disconnect
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jul 17, 2020 at 5:50 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes the disconnect logic just update last seen field of the
> device so in case it is temporary it would trigger its timer and be
> removed after the timeout which is consistent with the discovery
> session givin a grace time for application to react to such events.
> ---
>  src/adapter.c | 7 -------
>  src/device.c  | 2 ++
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c757447e2..5e896a9f0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6837,13 +6837,6 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
>                 return;
>
>         adapter->connections = g_slist_remove(adapter->connections, device);
> -
> -       if (device_is_temporary(device) && !device_is_retrying(device)) {
> -               const char *path = device_get_path(device);
> -
> -               DBG("Removing temporary device %s", path);
> -               btd_adapter_remove_device(adapter, device);
> -       }
>  }
>
>  static void adapter_stop(struct btd_adapter *adapter)
> diff --git a/src/device.c b/src/device.c
> index 470596ee4..2237a7670 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3039,6 +3039,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>         if (device->bredr_state.connected || device->le_state.connected)
>                 return;
>
> +       device_update_last_seen(device, bdaddr_type);
> +
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
>  }
> --
> 2.26.2

Applied.

-- 
Luiz Augusto von Dentz
