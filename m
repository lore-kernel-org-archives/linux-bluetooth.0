Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D10DC55165
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047CF23770
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437696AbgLLAKh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 19:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395019AbgLLAKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 19:10:20 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89CC0613D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:09:40 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id s85so5763481vsc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtXNsBL24PkYHIXJVZ3ab7cYWzYLRnR7ioq8t9HJ7Iw=;
        b=dpf5JiSNy9Rn99cwZdn/BLC5WhyDlmztCFq1dMfbNYX2oBCVD5NJiGnf/9DHwLaIxu
         8id5XOCo5HfWlyvbo2AJ0++f9zrh1VKMbiCjHbv47qKJa2MSQdwxK7/U80msbsFqisCW
         Hvx8xq886apSGQ8Jf5gFSA1nacE1il7Vj32dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtXNsBL24PkYHIXJVZ3ab7cYWzYLRnR7ioq8t9HJ7Iw=;
        b=CA+gIaJwLf8OwcXYPD/1ZMUCapLYfx0k9KFAZKzjbicQJidBsZZbWmAKkLSqyvmPX4
         0flCbHNvgBnbGObyF029JzMa1lRYcyo7Gxgn2XK8abJkzTut+OEEUZRLR4GnLiUIz5t4
         t1OumdwbXqjLhMtv7Jsg27Lp+66/JBorKBSnjl6GidYGpKHVDs8+C13dqNMlv5rI+e5U
         gc47JgLMHGpYQwZq9NlxzzQhUqdE755qqQCbBVrWbEtGsrua/u6rqY4nKo/L3W81B2AF
         Fh4fqGfCyhY2UFEsUbaqlsvRkI7+We6jh351oEZMc8hIvJcJ85ab21rSwomRGaYEKwUo
         IWNw==
X-Gm-Message-State: AOAM530IdHl+MgEaDtylJZaGBLVVUklOxCb3pnxIGdi5l2DVLt3GB9lK
        cB8qwpyxSW4q3lSvSJZ1xkZV6nSWvjkUNWoFjpamdfLU00Y=
X-Google-Smtp-Source: ABdhPJzSZtTktP+Z+iDT+ow0MiNJWonlj7MnZOXN7aZLcFoYQh1TIDybGbC/Q/QDClt7QOyEqsNjJBX8GcaA2OigBaA=
X-Received: by 2002:a67:881:: with SMTP id 123mr15443744vsi.10.1607731779450;
 Fri, 11 Dec 2020 16:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20201211160253.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
In-Reply-To: <20201211160253.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 11 Dec 2020 16:09:27 -0800
Message-ID: <CANFp7mVnd1ZM4ktxZwqYn8eYpwgWHA_6hh3OAsCN_t58W-BepA@mail.gmail.com>
Subject: Re: [PATCH] adapter: Change noisy log to DBG
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sorry -- forgot the bluez prefix here. Re-sent with the proper prefix.

Please disregard this patch.

On Fri, Dec 11, 2020 at 4:03 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> The controller resume message tends to be pretty noisy (printed on every
> resume from suspend) so make it a debug message instead.
> ---
>
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ec6a6a64c..775c9c921 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8835,7 +8835,7 @@ static void controller_resume_callback(uint16_t index, uint16_t length,
>                 return;
>         }
>
> -       info("Controller resume with wake event 0x%x", ev->wake_reason);
> +       DBG("Controller resume with wake event 0x%x", ev->wake_reason);
>
>         controller_resume_notify(adapter);
>  }
> --
> 2.29.2.576.ga3fc446d84-goog
>
