Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507DC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5054160241
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhC3SZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhC3SZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:25:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A6C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:25:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso16488739otq.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KL9iPK60wP/pqQowpgVvgJX56lp5odnBnpAbntpETLE=;
        b=umQupaVNiimV+S9Y9b5FvwDCd07ri7QjqU4bdEp9yTJOK3IP+5GA2x5dlbphLSRdE4
         LvoCiZ9TYfhOsLbLuj8GijOu6mQsYCYZmkZsnNB7KD+D26g0sBYrtapycp3lZ5Y/B8D4
         hkTcHcFl4p4m8LHtVyqjwEujTr1Wlp/DG/rs2Xy+XMLn50Sq8q5PLeR3g1ZQbMlmJU0E
         G6rX/kOb4Xgyi+OCq3j/VaHutptARttGFUIzUbdZGq6VYrZ2KnfD1WrCohp8qluOjZtA
         5jE5yfXUgkhhmYwoJnhjGtFk/SSEYFe/Yg6XuFLmPa5QmDfV5UbPDbfNnLBdwrwiHV3D
         fnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL9iPK60wP/pqQowpgVvgJX56lp5odnBnpAbntpETLE=;
        b=erp1I8dFffWtigHC6dWHDz/A6GDHuo9uQjZYFhmbBFd9EQjGMTnCmgpmEBHFG4Suy1
         75tq8WbV3WS6vK7ak1/j/nZ30xfg1hhQzczRYS4nvOkR43TImQbF7w5zPahA7At9Yo7i
         UB2xlHnANcHVfdO6MeWjBW090TVwivg2eEvAZff9FIyHuNhn6IR7UAc+2n+T6gaopQ6x
         CJ+Hj/NwtXk3z/QIksJ3XHqLWGzG2CGnfe38foqUzeALH0EJv6TI8e4+uMjGwjTB50r9
         bu4Ok7ziwYELU7ObR3v86lMWArgKLbMv0b7Yk05UEWnYAGzjow4oQEJYjsHBW+yXiE7j
         WPSA==
X-Gm-Message-State: AOAM532IfLAf9uNnVA4cg1m7uDrRVNBQZoXxhoiNG87EjnSB4fyq+HzH
        EomU2Rm95jAPLATUyq/29txNWj8NAlXrYfNIZVIdWcd/ipI=
X-Google-Smtp-Source: ABdhPJxW3XHu46Mifi92JYu/p8P7FcQl6djtJuwuAXayAt8e3yfSLpi9J6VmxMTaDJ+KMqW55BmGeECYpeC62Q4VLXA=
X-Received: by 2002:a9d:21a5:: with SMTP id s34mr29374273otb.240.1617128731704;
 Tue, 30 Mar 2021 11:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210330170924.16983-1-sonnysasaka@chromium.org>
In-Reply-To: <20210330170924.16983-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Mar 2021 11:25:20 -0700
Message-ID: <CABBYNZ+XOdrtNBjGjUtJrV=SdiCEkMc80=4UFX17v+5Z1ojm5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/battery: Always update initial battery value
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Mar 30, 2021 at 10:12 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Due to cache in gatt db, bluetoothd fails to update publish the battery
> value after reconnection when the battery value does not change compared
> to before reconnection. For initial battery value, we should update the
> value to D-Bus regardless of the cache value.
>
> ---
>  profiles/battery/battery.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> index 81f849d57..0f8d6ef18 100644
> --- a/profiles/battery/battery.c
> +++ b/profiles/battery/battery.c
> @@ -88,12 +88,13 @@ static void batt_reset(struct batt *batt)
>  }
>
>  static void parse_battery_level(struct batt *batt,
> -                               const uint8_t *value)
> +                               const uint8_t *value,
> +                               bool force_update)
>  {
>         uint8_t percentage;
>
>         percentage = value[0];
> -       if (batt->percentage != percentage) {
> +       if (force_update || batt->percentage != percentage) {
>                 batt->percentage = percentage;
>                 DBG("Battery Level updated: %d%%", percentage);
>                 if (!batt->battery) {
> @@ -110,7 +111,7 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
>         struct batt *batt = user_data;
>
>         if (value_handle == batt->batt_level_io_handle) {
> -               parse_battery_level(batt, value);
> +               parse_battery_level(batt, value, false /* force_update */);
>         } else {
>                 g_assert_not_reached();
>         }
> @@ -134,7 +135,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
>                 return;
>         }
>
> -       parse_battery_level(batt, batt->initial_value);
> +       parse_battery_level(batt, batt->initial_value, true /* force_update */);

I guess it would have been better to reset the initial_value on disconnect.

>         g_free (batt->initial_value);
>         batt->initial_value = NULL;
>
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
