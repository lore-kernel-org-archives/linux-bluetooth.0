Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81635C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A8A60FC4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 02:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhG1CUK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1CUJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 22:20:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F0C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 19:20:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o5so2047035ejy.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igsOLvBESUcRgxaqZtcUjwOr4/I59ieON4y08DvjreI=;
        b=DwRCfimOpsPUaHoq4L35vCRCPOMsFMd9qDBTGxCPvWRf+NMx4Drcsz9B89nVT+OsbJ
         tJbCFUIdeikeA0HqCeZNlM3Bf6IAahAJKhXMWu3IbSCQw2UI+lOvqSXRq2clqiLixeCY
         b4CNIo6KJ5PNohLzAmYLBkp6+XJgvcujT0jvLbNhY6VwnYbR6poZPD0w9Xe2RAnBdDDx
         lnSg9biP6y0rXmYUcMzPhSnHhnMh0hA7Hm73y11ohRG2red++d5Q9OxkgGoh08Jn4Yny
         0pfZtrfFL60ldxhSZ7mcjGFrjq87PsaQpbBV806tgY6sqx8jJxc1UPE50yz/76UgwzhD
         rkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igsOLvBESUcRgxaqZtcUjwOr4/I59ieON4y08DvjreI=;
        b=IdL1Z11+KmHvueLp8pJuLW4PS6eggdS+4bjLzDtq5JiOUzoCcC8Wc9TK+FhQeEhuAq
         75zYakZBphUiuO4rG6gyCfwC0r51wtUq2WeFheR0u/DPOF0Er7uYVN5Z5fh9xy2kPx+3
         e7NwOSeeur+qt0V9RVjhgXuWyK7J2BQ02YEHBI3LsQjR0wjmUOWNRTRozulV4vahUqHR
         8dN5ptHBKb5mlg/6VVqof+47nebcvRG4L981yGqa5Qqj7l1/qjFtk9RtdCS6PZg9C9fD
         DS7AeavGeM96R/gYzIGkLq/HQTOg4o3IPB2eMmXIHxO8kP08G3q0++j5IDIxSFApiKsQ
         KXcw==
X-Gm-Message-State: AOAM531Vx2+Ohckx1882BptfDwc3Mmduq7GXOqG6M2CivsO0jb0Kfg+K
        yCU04pRYyHW6vr4owMG4dQfbhg6Wxg5/ekOEcL9fyA==
X-Google-Smtp-Source: ABdhPJzTS1wtZpHEE5STTwQiBcxXbadkHhpoSuTFYIPM2xwEvbprMrDN+4JoCYHXVeGIaGncXHX4cfNBW7lvHQs/9PA=
X-Received: by 2002:a17:906:8a98:: with SMTP id mu24mr13299394ejc.404.1627438805196;
 Tue, 27 Jul 2021 19:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
 <CABBYNZJkvaeuMJLKXueoLKq7hXBskxYSPbGujHEj72=qfF4+DQ@mail.gmail.com>
In-Reply-To: <CABBYNZJkvaeuMJLKXueoLKq7hXBskxYSPbGujHEj72=qfF4+DQ@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 28 Jul 2021 10:19:54 +0800
Message-ID: <CAPHZWUeCGeu+gpYkfhMUKxXGMPZY0ZeKTpHDO-QcCvhwarR0dw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt-db: fix service in range check
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I see. To be honest, I didn't encounter any issues with this function.
I was trying to solve another problem and found this might be a typo.
Thanks for the explanation.

On Wed, Jul 28, 2021 at 6:18 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Tue, Jul 27, 2021 at 4:53 AM Howard Chung <howardchung@google.com> wrote:
> >
> > From: Yun-Hao Chung <howardchung@chromium.org>
> >
> > If foreach_data->start < svc_start < foreach_data->end < svc_end,
> > foreach_in_range runs foreach_service_in_range to this service.
> >
> > This patch fix the above bug.
> >
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> >  src/shared/gatt-db.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index 8bff4d37aaa2..38d93f273a9e 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -1349,7 +1349,7 @@ static void foreach_in_range(void *data, void *user_data)
> >
> >         if (!foreach_data->attr) {
> >                 if (svc_start < foreach_data->start ||
> > -                                       svc_start > foreach_data->end)
> > +                                               svc_end > foreach_data->end)
> >                         return;
>
> Actually if I recall this check is correct, we want to iterate to
> every service within the range of start to end, if the range is lets
> say 1-9 and the service is 1-14 is still within the range since it
> matches the range of 1-9, or perhaps you want to explain why that
> would be a problem since that is not explained in the patch
> description, if we do switch to strict matching it is probably worth
> documenting that we would only match if the entire range of services
> is within the range, anyway I would still keep svc_start >
> foreach_data->end since that would stop iterating early instead of
> continuing to all the list.
>
> >                 return foreach_service_in_range(data, user_data);
> >         }
> > --
> > 2.32.0.432.gabb21c7263-goog
> >
>
>
> --
> Luiz Augusto von Dentz
