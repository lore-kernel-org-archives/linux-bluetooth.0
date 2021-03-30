Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723EAC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267FA619DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhC3Sjd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhC3SjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:39:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:39:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so19352278edt.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3alyGEBvGi920HN5uHjFjp9GGLAfe3KXLwuYe7WnNM=;
        b=d0+dA4MX2Rds/Zqi7gPN3ro5LW9pCYivsZ62E3SX27pH05iWB2Q9gGngISStpIZcHw
         FPoeeGJLb+ngf5M/B9zO5AcrA/tImdWNw5nuTuGT7EBciamKbs6FL2VBrGvUXtoClDhC
         WYHELueJdwtwaRxUKDiD9x9sAqZg2Is6ytXOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3alyGEBvGi920HN5uHjFjp9GGLAfe3KXLwuYe7WnNM=;
        b=N7tEqull61SW9AQEYYzmdxDjmKBbmqGV1rwb0RsdNxBBM+e/241YBmrRG7LOp0u5yk
         tLJxGyWKvuaJYtRwCBYRnBYYS6rnGjU8NQ2DL109ItoV4T2cl8Oowj+ZN8Lgr2nwYYtU
         kyetBREdTfckjFddrh95S9SOcgje4LEFRXFkyIGD9my/wHrtBI2Arpnm0IVIjvL2d47S
         uQDw+/2RgugENU3mbyZEAgs6m67Etg6leM+pTIPpoUJ9l1LNr5fkcWHyBoIv7SqbFy/+
         az4PI67aPa1bJGa1Tgan+y7vVztJAkpcfeploPIpfwmyjUznJKDTqYxgah+UlQ9XdAyz
         bpLw==
X-Gm-Message-State: AOAM533d31y1z1Qmz+eUFcVtxNdTee4pL39mAaY1BXtVisae9Cii840H
        5P5FEPbG/DRcefMZiS1erlXzs1UpaoJBtQ==
X-Google-Smtp-Source: ABdhPJwcxkXQOLYJcWrQTQEm/+thqQCDo8L7H0mdQuTY4+HoP2J6btfNTQFrwkjyjif0NSkwLosM6A==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr35392096edb.304.1617129555214;
        Tue, 30 Mar 2021 11:39:15 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id gn19sm10269945ejc.4.2021.03.30.11.39.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:39:14 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so8941216wmj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:39:14 -0700 (PDT)
X-Received: by 2002:a1c:318b:: with SMTP id x133mr5429596wmx.154.1617129554001;
 Tue, 30 Mar 2021 11:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210330170924.16983-1-sonnysasaka@chromium.org> <CABBYNZ+XOdrtNBjGjUtJrV=SdiCEkMc80=4UFX17v+5Z1ojm5w@mail.gmail.com>
In-Reply-To: <CABBYNZ+XOdrtNBjGjUtJrV=SdiCEkMc80=4UFX17v+5Z1ojm5w@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 30 Mar 2021 11:39:02 -0700
X-Gmail-Original-Message-ID: <CAO271mkMkjonV2nNxAsH6owKFE9ktEK71ShLKBzCn4p1MPH6ww@mail.gmail.com>
Message-ID: <CAO271mkMkjonV2nNxAsH6owKFE9ktEK71ShLKBzCn4p1MPH6ww@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/battery: Always update initial battery value
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

That's a good idea. Please take a look at the latest patch titled
"Reset battery value cache on disconnect".

On Tue, Mar 30, 2021 at 11:25 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Mar 30, 2021 at 10:12 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Due to cache in gatt db, bluetoothd fails to update publish the battery
> > value after reconnection when the battery value does not change compared
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
> > @@ -110,7 +111,7 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
> >         struct batt *batt = user_data;
> >
> >         if (value_handle == batt->batt_level_io_handle) {
> > -               parse_battery_level(batt, value);
> > +               parse_battery_level(batt, value, false /* force_update */);
> >         } else {
> >                 g_assert_not_reached();
> >         }
> > @@ -134,7 +135,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
> >                 return;
> >         }
> >
> > -       parse_battery_level(batt, batt->initial_value);
> > +       parse_battery_level(batt, batt->initial_value, true /* force_update */);
>
> I guess it would have been better to reset the initial_value on disconnect.
>
> >         g_free (batt->initial_value);
> >         batt->initial_value = NULL;
> >
> > --
> > 2.29.2
> >
>
>
> --
> Luiz Augusto von Dentz
