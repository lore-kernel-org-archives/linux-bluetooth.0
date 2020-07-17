Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8388C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824F520704
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENOqu9KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgGQUN5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgGQUN4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 16:13:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97044C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:13:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c25so7754821otf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wnVFsN0Fi5deQ7siuUTnPpQvD4/RnQHeHH1eSFWHzW8=;
        b=ENOqu9KM9VOKT1NQzZu9nQAF5iWeaHC/x92DzXH4mvfUoi9KSW44U+JNSNmpOXtOsK
         P9DrTwctLkQtXwiDKLPNmyxXFDu9KXMKIKKwAKLckpMCAvDahPR+9Eif/WsccURRMV48
         L2sIWPn7HC4eBHzQeRfeunZBiVNUV99bgA2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wnVFsN0Fi5deQ7siuUTnPpQvD4/RnQHeHH1eSFWHzW8=;
        b=jRWBztC2yiPhvKPtde7Qu5MlejAAHl5yytSJTh8zJlcK4gb6QuE4bZK1Eq9Jpe4DFy
         89D3bvPMAKvM1ePM239iaqlqmhk2hKfCFrisb1vAzU/9se+i6HjAjVP2MlL2f3UyjlHE
         zJO4PgpgeivLcZhvNXZCWMuq2kXkRVbRJeHUnI+c2iVslSqUWM00S+t3cZ9ueQIIYnRq
         osEnlwkN2Z7+EUYbN6lMJNrFbp55GkdrbaFbOXjudvY4j8Ki8ugP/G9DxbHCJQkJ2304
         xhwU+GYs0Dz4yRg5I72bLgq/n0tcYaaot9/IaLCO/9qkA0vDApaHpqHBZq3VQPWKIJhN
         Z3ZA==
X-Gm-Message-State: AOAM5307NtLImZ4hOcP8cyBoPEbMBwbesW4UhtKdLiXcKxtac4t7JfHw
        6ND8al6JrsdUvhez+bz8WXNxeifuos3EfzTrPhLiTAbJ5dM=
X-Google-Smtp-Source: ABdhPJy53/cgClluap7XHPqI1ltOGT6BGJmscXjVyLIMN7qVysDp5UXuAEbhF6JeMd1C1DvyLOmr/Jb7JUOMA22Eb04=
X-Received: by 2002:a9d:554d:: with SMTP id h13mr9638517oti.329.1595016835648;
 Fri, 17 Jul 2020 13:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
 <20200715224740.238527-1-sonnysasaka@chromium.org>
In-Reply-To: <20200715224740.238527-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 17 Jul 2020 13:13:44 -0700
Message-ID: <CAOxioNm_D1E9RY6R6U0F356HfTUJtkGFFhJaa=44hBLevHzTjQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] profile: Add exception to battery profile for
 external access
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendly ping on this simple patch.

On Wed, Jul 15, 2020 at 3:47 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This gives exception to battery profile to be shared both internally and
> externally.
>
> ---
>  profiles/battery/battery.c | 1 +
>  src/profile.h              | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> index 4da4355a1..c9a1af4b9 100644
> --- a/profiles/battery/battery.c
> +++ b/profiles/battery/battery.c
> @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
>         .device_remove  = batt_remove,
>         .accept         = batt_accept,
>         .disconnect     = batt_disconnect,
> +       .external       = true,
>  };
>
>  static int batt_init(void)
> diff --git a/src/profile.h b/src/profile.h
> index 4448a2a6d..95523e50a 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -35,6 +35,10 @@ struct btd_profile {
>         const char *remote_uuid;
>
>         bool auto_connect;
> +       /* Some profiles are considered safe to be handled internally and also
> +        * be exposed in the GATT API. This flag give such profiles exception
> +        * from being claimed internally.
> +        */
>         bool external;
>
>         int (*device_probe) (struct btd_service *service);
> --
> 2.26.2
>
