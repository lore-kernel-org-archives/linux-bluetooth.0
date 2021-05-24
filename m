Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE1C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE26140B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 20:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhEXUUB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 May 2021 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhEXUUA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 May 2021 16:20:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BEC061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 13:18:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r7so17727497ybs.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHNKKLqUKxpUaWsSmeurMF+ccookkVxQhxTNb5LgT58=;
        b=BwwxbD32Fuc+alAOU83i6mzlmKRu6BeVfa2R8KOwFoNr3XSnjA9G7FRZNvKne+W18P
         9i+7xzo5l7PtRfJmJs/yjjWq6d76BRM6tmaFDrIi0wVHovFdgCcMt3PnKTUPGbYQGmA3
         qwtabOoMUQ6iqoReQdYZLPc+MIyLA1/TV/V43wNf4zZyN9d1HscTw2fJPTW8zTupcuG6
         99mbUEirUkmy+ATIqMBKv86s1fOef8DoZ/+jZ84Dn2daPdBYLFO+bAzU+/kbKJVB0MSd
         974tnCOSNgzlOm5kxsVAeUt9aJoijsdItslPvN1fYOHqIK06ap47CnDsbQwjlry4V5sF
         NQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHNKKLqUKxpUaWsSmeurMF+ccookkVxQhxTNb5LgT58=;
        b=hxMXa72apd4mITh5enjqb/WSIY7XUBEi9H0wyTXuXo5BAl18Yf80z78xZt4Hj/dmTj
         mFBs0yBG7YRZuGTreLMkOFNHbJnHH6NIC4fpuhOVCjo2yXxPyRLvw+gRofxnS0G0E3Mr
         jEOueRKAdC1qSu9uCU9fJkJUXu12HHt54dkqk+v1e4VlwsWbHh+t8FMwCZc0DspxLJyg
         V4eVZ0O9KsSsKKKTaIfywks2Y5mJwAHMN2FSeqbDOrL7J0u3UM2eYwIm0OiFdRMwZTh/
         V0PZlmhr35yNMBrZ0cobiit6NV7HoyA3vyECOC2Wg4tQfUtbHITSunxnb+zJ9qDzVxQg
         nG9Q==
X-Gm-Message-State: AOAM530dT4J+Fms0g7mnQMhahC/qsWva5wl3Ej/7ECPSh0r4Cj85KXGM
        oLMYpYDi69S5/inzIKuKCvriy98LT+HgG/EzfeM=
X-Google-Smtp-Source: ABdhPJy3Qq6LYraaLrFk0ouCCLI6zGB8TFbAk6718gw3/B968Q9+tvOHJfpZI1y3khVsHw7aEKxFA6WJk7HfM87C81M=
X-Received: by 2002:a25:69c7:: with SMTP id e190mr38204327ybc.91.1621887510398;
 Mon, 24 May 2021 13:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
 <CAJQfnxH8p+pffk49LTMN+JR2UvZwoOPTM_Dg44DCSDz3weOYSQ@mail.gmail.com>
In-Reply-To: <CAJQfnxH8p+pffk49LTMN+JR2UvZwoOPTM_Dg44DCSDz3weOYSQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 May 2021 13:18:19 -0700
Message-ID: <CABBYNZJ1QuNKh0XOdoMaCKmjsN-6J+iVAg_fy6hFOo+Oxnx-eA@mail.gmail.com>
Subject: Re: [Bluez PATCH] lib/uuid: Fix string to uuid32 conversion
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, May 23, 2021 at 9:24 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> A friendly ping to review this patch. Thanks!
>
> Cheers,
> Archie
>
> On Wed, 19 May 2021 at 16:21, Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Use strtoul to prevent 32 bit overflow
> >
> > Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
> > ---
> >
> >  lib/uuid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/uuid.c b/lib/uuid.c
> > index a09321dc6e..3d97dc8359 100644
> > --- a/lib/uuid.c
> > +++ b/lib/uuid.c
> > @@ -209,7 +209,7 @@ static int bt_string_to_uuid32(bt_uuid_t *uuid, const char *string)
> >         uint32_t u32;
> >         char *endptr = NULL;
> >
> > -       u32 = strtol(string, &endptr, 16);
> > +       u32 = strtoul(string, &endptr, 16);
> >         if (endptr && *endptr == '\0') {
> >                 bt_uuid32_create(uuid, u32);
> >                 return 0;
> > --
> > 2.31.1.751.gd2f1c929bd-goog

Applied, thanks.


-- 
Luiz Augusto von Dentz
