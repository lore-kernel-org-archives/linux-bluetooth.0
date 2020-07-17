Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A1C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3963820684
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plsU2H2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGQUdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgGQUdi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 16:33:38 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71486C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:33:38 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id z23so2080619ood.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UUkbXvkZXe8NVtarmx0b2nzNEqKIGpAHjV6phStybs=;
        b=plsU2H2y1UC8eAFJkrx9Nkehhw57sbGZako2KFikz7fGYYHFqnrWkG4SASw9NJ/tzs
         Z6ofXqdJrlir93bhOxznrWZ8d7ve9C7l53Z0d6uIDxssDTLePGDBW1rYRkEu6lNFZDhS
         RkUJ567ngqStRGep4hdsePk83YC4p+/hCjBqgAiAcJtZLa08EXk4NoOjDFAqv6Sw0nut
         KOm+ncGVVzbW5QZH/MCJP2Rmz623UkSKzciyIVOPmUNWZe3pk0uDx2VDA2IFePSh5rb6
         Oxk0tyvDdyq2JsibvQZAWYNs8Wj6MyzzhXkwygo3uEg6P+1hp2uKGIHfcdn9e8qBINnH
         vJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UUkbXvkZXe8NVtarmx0b2nzNEqKIGpAHjV6phStybs=;
        b=qd70vBaMgKt2zro5qdLdKYdEn51ZzOPMmj5mvzV4vhBrxyfjjCArLOUq4ulOSjidD0
         BvPvXnIsImziLYiZEK/ELZDbuYhRojQAxE4E24QAGF7MLF0+8cf23f5Wnl/BDs6JUKi9
         9SbApURwbVvdY7aQlzOQ4xN2BtC87du0geKHBeXtLiwAqkE8a5WwV0b7TkHd2/JGZdhX
         7qUCnok9IJQdsklbh/mAu2czPuc0qus0328e/ztkM6jh2xUEqp3kWV+zU4sONauXLr6w
         VVu1Gnhk9RqsDmoLGXjfGLNyzRz/g2B5HZ/ix5OnYBeWRZfmZs4mAHNbx0AeqvngOFTN
         pw0A==
X-Gm-Message-State: AOAM532mgJKsBs4Lq6XWoI4NU9bc+DiNoutCXPLALdXK0yTGVnyGN4xl
        NBCyHYy6EQQRwDSX8Ifw6z9JcTu+G/4UjtkMoY0=
X-Google-Smtp-Source: ABdhPJyw9DdsfIzgING4tcvorhTkZGQpZ1sU0YxTQ04a0aCgcmlTSqQF4LQ9c6TcysB2AeE8Rt/PxRrz+OjJaPuh66o=
X-Received: by 2002:a4a:a21d:: with SMTP id m29mr10094897ool.17.1595018017594;
 Fri, 17 Jul 2020 13:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
 <20200715224740.238527-1-sonnysasaka@chromium.org> <CAOxioNm_D1E9RY6R6U0F356HfTUJtkGFFhJaa=44hBLevHzTjQ@mail.gmail.com>
In-Reply-To: <CAOxioNm_D1E9RY6R6U0F356HfTUJtkGFFhJaa=44hBLevHzTjQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jul 2020 13:33:26 -0700
Message-ID: <CABBYNZJ7mOD6pRo4hRPWpScgcJMnwNcByEecpre-SHrHQ9vFHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] profile: Add exception to battery profile for
 external access
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Jul 17, 2020 at 1:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Friendly ping on this simple patch.
>
> On Wed, Jul 15, 2020 at 3:47 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > This gives exception to battery profile to be shared both internally and
> > externally.
> >
> > ---
> >  profiles/battery/battery.c | 1 +
> >  src/profile.h              | 4 ++++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> > index 4da4355a1..c9a1af4b9 100644
> > --- a/profiles/battery/battery.c
> > +++ b/profiles/battery/battery.c
> > @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
> >         .device_remove  = batt_remove,
> >         .accept         = batt_accept,
> >         .disconnect     = batt_disconnect,
> > +       .external       = true,
> >  };
> >
> >  static int batt_init(void)
> > diff --git a/src/profile.h b/src/profile.h
> > index 4448a2a6d..95523e50a 100644
> > --- a/src/profile.h
> > +++ b/src/profile.h
> > @@ -35,6 +35,10 @@ struct btd_profile {
> >         const char *remote_uuid;
> >
> >         bool auto_connect;
> > +       /* Some profiles are considered safe to be handled internally and also
> > +        * be exposed in the GATT API. This flag give such profiles exception
> > +        * from being claimed internally.
> > +        */
> >         bool external;
> >
> >         int (*device_probe) (struct btd_service *service);
> > --
> > 2.26.2
> >

I've might have forgotten to announce it on the mailing list but this
has been applied for a while:

commit 0509a4a217256ac46020b957a6532dc150729748 (HEAD -> master)
Author: Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed Jul 15 15:47:40 2020 -0700

    profile: Add exception to battery profile for external access

    This gives exception to battery profile to be shared both internally and
    externally.


-- 
Luiz Augusto von Dentz
