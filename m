Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 23:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EC6206FA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 23:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkQf1pyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFEX0b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgFEX0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 19:26:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4525C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 16:26:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m2so8937421otr.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Fm0vmuswOS+nn/jfsCOojXiNI5DdGdJnBsSVeSiONu8=;
        b=NkQf1pyZ3dpm3yIwGXHIG379KtMPBCDZ19qGHDiMgCsooiiwYJLNCOsyyOuIaHZ40G
         s5AUVH9UtO3FV54goGEZAUl9HzThbFUgrMGZCZSsi6RtgQA9yqlZKeumCuwKxa7eRF6r
         rqD9HlykpAFKHJ0Jr5eeKgICzYuwoflNFm8CSbp5+AKgEoplH7mHi0L1AJFms4vOHHn3
         RUtd/vmryGADgPKSBWO5XU7eUORJ6N+yRpp/fdjCIqymJW51J02zu3vHM11isymWsf5Z
         Drkl3dPiY7rOCJvhbs50JbtDYTW2S+tuYyndEsxHYh/JaXUn+++q5W9LpnyXmQHO3ATJ
         0yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Fm0vmuswOS+nn/jfsCOojXiNI5DdGdJnBsSVeSiONu8=;
        b=ld64JS9ZD4CggF5caPQAZgXNXrS4hmrjc5frwnGYASFxrRipUKK4gP8moa0jcbzYTs
         buU7dS5nQdNNkH2WAFWYQ5Pk0ln1NHQaIJEHpLEhOJ/Y5ZV1ZjpMZOzpOYfaZpOew869
         yfkcxi1xbaqrkZo+1oVZsnM0Gt+KgHQjhAqYDr8Xp+QestZ9/96nQHZtAa1R6Jle7FEl
         ATKe/+WabtxG57AajG5dac0tdIKfydPQxQulX/YB8wwR53+a6AfzDVSAezdKkJrGeXJb
         2lgHmWZa9wkYd/YAOM9vrvKpDAU21dW++UVVi0mckbBJPTprkXJ7QJ/0zSg3KcecZ5s2
         8BMg==
X-Gm-Message-State: AOAM530LHCXWyZteDxACPLHrmF3qQ0w/9yWmezKFlDPoS/tnq7cK7VPN
        kqxqGygCq7eyEU234pLBAQQJTvWgg0S2uH0S3YX03Q==
X-Google-Smtp-Source: ABdhPJxzI5ydCGfPhb9vpMs6TBjZUd+5k2Q5yVV2dk92n/r1mtNEl7Y39cAQILrxDUnH2SRzAaBDF9M3X1PjEDxuWZI=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr9696789otq.79.1591399588645;
 Fri, 05 Jun 2020 16:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200605181743.720661-1-luiz.dentz@gmail.com>
In-Reply-To: <20200605181743.720661-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 16:26:16 -0700
Message-ID: <CABBYNZ+Tu03XW4q7YgCXnzhbuEqBxkjLf7n+yreMFdsEFmefpw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] shared/ad: Add defines for possible flags
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 5, 2020 at 11:17 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds defines for limited disverable, general discoveral and BR/EDR
> not supported.
> ---
>  src/advertising.c | 9 +++++----
>  src/shared/ad.h   | 5 +++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 829c481f6..4c91586c2 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -673,7 +673,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
>
>         /* Set BR/EDR Not Supported for LE only */
>         if (!btd_adapter_get_bredr(client->manager->adapter))
> -               flags |= 0x04;
> +               flags |= BT_AD_FLAG_NO_BREDR;
>
>         if (!bt_ad_add_flags(client->data, &flags, 1))
>                 return false;
> @@ -700,8 +700,8 @@ static bool parse_discoverable(DBusMessageIter *iter,
>         if (discoverable) {
>                 /* Set BR/EDR Not Supported if adapter is no discoverable */
>                 if (!btd_adapter_get_discoverable(client->manager->adapter))
> -                       flags = 0x04;
> -               flags |= 0x02;
> +                       flags = BT_AD_FLAG_NO_BREDR;
> +               flags |= BT_AD_FLAG_GENERAL;
>         } else
>                 flags = 0x00;
>
> @@ -1065,7 +1065,8 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>                 }
>
>                 /* Set Limited Discoverable if DiscoverableTimeout is set */
> -               if (client->disc_to_id && !set_flags(client, 0x01)) {
> +               if (client->disc_to_id &&
> +                               !set_flags(client, BT_AD_FLAG_LIMITED)) {
>                         error("Failed to set Limited Discoverable Flag");
>                         goto fail;
>                 }
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index a31df0fe5..19aa1d035 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -71,6 +71,11 @@
>  #define BT_AD_3D_INFO_DATA             0x3d
>  #define BT_AD_MANUFACTURER_DATA                0xff
>
> +/* Low Energy Advertising Flags */
> +#define BT_AD_FLAG_LIMITED             0x01 /* Limited Discoverable */
> +#define BT_AD_FLAG_GENERAL             0x02 /* General Discoverable */
> +#define BT_AD_FLAG_NO_BREDR            0x04 /* BR/EDR not supported */
> +
>  typedef void (*bt_ad_func_t)(void *data, void *user_data);
>
>  struct bt_ad;
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
