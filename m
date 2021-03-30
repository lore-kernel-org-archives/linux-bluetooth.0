Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E15C433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D2060241
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhC3SYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhC3SYI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:24:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74148C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:24:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so19317092eds.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UfCZumSjjZ+gCLKiVpTNp4n1wCiRZNAE9JXSMeCYMA=;
        b=I77lQP/14JsBMZfPU/eO4Pi8WbA4bZJCjeibvwRlA5A5FTslb21WP2Nu8waaLxeZhw
         /gDQWNXhgNgM9YntfUG7RLZEp4EQu8XZ7iNZ12yVxeFQGrgMguJGfaiT9cRiqF466w27
         UUqF84ccoB3VZQXhC2QcMh0m/y5D/VO9+7Fac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UfCZumSjjZ+gCLKiVpTNp4n1wCiRZNAE9JXSMeCYMA=;
        b=OUrlC+A3YOe0Y1lGkZnOBuQQhGaQY2qsX5VvaSQYioJo9ZYHt7RJlmuXtF3EV+dTe7
         jdaLA0e9qM0lmYX1m7uS+miMwWrSrtXDez0xNpaLQdcXbfTqqXEGLwsMmp7NQ2kHiJrk
         v3Gy7iSyzKUoSQtQ+IBzRNtXPvFUOHqrMZzEEDQCQxGtGv/xT0oJ5MXURZzKF5ylg2/K
         E9DDRxiU23Ru0UY77qTTy//dEpUfLqewnQqNx315Sg2ey1QZiMqCG7/fQy8b8yEz1YEu
         QwdMEUfLtaIaBwhoMgZYMIxjLJUPdOhfgJtMsMLA/Vwi857jAtjXrcYm0ds/K9AaeYDE
         wvvw==
X-Gm-Message-State: AOAM531smLmSDByxL0QjUkVEnbKoy7k3ADG3uE9cjvDkmNMOAUGMKv9/
        mcaAXuhjQQkk4UvDcbf5XWyNBL7vugPVYg==
X-Google-Smtp-Source: ABdhPJxS5pucpsH4ztd4WeVid1P3kxmQfWDRUAQ89Sy2x7IcFOZjh1zCFcWBNj1vwYm7QkhJZJR9fg==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr34490340edd.322.1617128647113;
        Tue, 30 Mar 2021 11:24:07 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h8sm11506999ede.25.2021.03.30.11.24.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:24:06 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id v11so17131112wro.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:24:06 -0700 (PDT)
X-Received: by 2002:adf:c186:: with SMTP id x6mr35791013wre.253.1617128645577;
 Tue, 30 Mar 2021 11:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210330170924.16983-1-sonnysasaka@chromium.org> <48cba7cf96bb9c6f5d6c95d8ab0b62ecf1b8d107.camel@hadess.net>
In-Reply-To: <48cba7cf96bb9c6f5d6c95d8ab0b62ecf1b8d107.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 30 Mar 2021 11:23:54 -0700
X-Gmail-Original-Message-ID: <CAO271mkY-ser7Yp=H1CGug+hyUVerNJMzVosjrhNXn9jYdGBLg@mail.gmail.com>
Message-ID: <CAO271mkY-ser7Yp=H1CGug+hyUVerNJMzVosjrhNXn9jYdGBLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/battery: Always update initial battery value
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

That's a good idea. I updated it in v2.


On Tue, Mar 30, 2021 at 10:16 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2021-03-30 at 10:09 -0700, Sonny Sasaka wrote:
> > Due to cache in gatt db, bluetoothd fails to update publish the battery
> > value after reconnection when the battery value does not change
> > compared
> > to before reconnection. For initial battery value, we should update the
> > value to D-Bus regardless of the cache value.
> >
> > ---
> >  profiles/battery/battery.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> > index 81f849d57..0f8d6ef18 100644
> > --- a/profiles/battery/battery.c
> > +++ b/profiles/battery/battery.c
> > @@ -88,12 +88,13 @@ static void batt_reset(struct batt *batt)
> >  }
> >
> >  static void parse_battery_level(struct batt *batt,
> > -                               const uint8_t *value)
> > +                               const uint8_t *value,
> > +                               bool force_update)
> >  {
> >         uint8_t percentage;
> >
> >         percentage = value[0];
> > -       if (batt->percentage != percentage) {
> > +       if (force_update || batt->percentage != percentage) {
> >                 batt->percentage = percentage;
> >                 DBG("Battery Level updated: %d%%", percentage);
> >                 if (!batt->battery) {
> > @@ -110,7 +111,7 @@ static void batt_io_value_cb(uint16_t value_handle,
> > const uint8_t *value,
> >         struct batt *batt = user_data;
> >
> >         if (value_handle == batt->batt_level_io_handle) {
> > -               parse_battery_level(batt, value);
> > +               parse_battery_level(batt, value, false /* force_update
> > */);
> >         } else {
> >                 g_assert_not_reached();
> >         }
> > @@ -134,7 +135,7 @@ static void batt_io_ccc_written_cb(uint16_t
> > att_ecode, void *user_data)
> >                 return;
> >         }
> >
> > -       parse_battery_level(batt, batt->initial_value);
> > +       parse_battery_level(batt, batt->initial_value, true /*
> > force_update */);
>
> If you need to do this, that means that you should probably declare an
> enum instead.
>
> This is old, but still relevant:
> https://blog.ometer.com/2011/01/20/boolean-parameters-are-wrong/
>
> >         g_free (batt->initial_value);
> >         batt->initial_value = NULL;
> >
>
>
