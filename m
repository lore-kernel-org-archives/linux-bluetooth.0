Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E74C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A404620678
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 15:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5FPHdwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgFAPSV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPSU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 11:18:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B681C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 08:18:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o9so8589707ljj.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1NrWnBXAgRg2KxeLwW3lntZ1glhDJtcdN6wq+Yi4xU=;
        b=s5FPHdwyTRiWjZTOyyta1XIkfCT+fnvNXmjFpodI8rZkC2pw5ptI57INJDMLnzjCLY
         AHysbWqwbC6OrtgmBgOV2zgIkra5Nqxizx7eYI41iXGWmGm/MDnXMh149kNZfhiIfR8T
         +tJL+zl3vkqKfq7q/ub7RYHazI2+QxzqtEPSKFrpNqorOYel61sgWHNGiohmB+vyUGX5
         HcLaW/Dny0Vf5YJi8THWg1Z5IlJnySqrK4UcK/dveiMOUTfexCDu5+QYGl2L0iqYf2uh
         uwvveBX1LzuKe3E0H5B2zLJxebXLNkJ+0dRpKjbcppuni6gX7YAnTD+KmO7Oq+BdI97r
         A2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1NrWnBXAgRg2KxeLwW3lntZ1glhDJtcdN6wq+Yi4xU=;
        b=VhEl5xU+2NZpWYnlCn3+4/CwI+tViBloITY7j19HTbJF25mfmi/S0HD9OpomoVFFFa
         bAlbO1TmVgqzLa/iJMwG3egiWCBO5RN0FgsAEUitbKhnrwikrKuOPk0gEJ+irr95TU2C
         ksfc59KgLukOHJu2zVh7VLhzvg5e/J2YlKSBQwWP8TVqKBE0SmtV1Y94fEQ5qRMqnTVF
         LI7AhyaxP0Ai2lwWkY5t8dpXo3ouEH1NDSHRZ9hFgBrdMeOfd8frI/e39lbY27dtwuk7
         TYXRTd7k1ZbO9f8vD2BOEvm+bsJbTo1tSOzODERQVlJ+m/ntJrzCc311E0z0FZsc6rUO
         ++TA==
X-Gm-Message-State: AOAM533I3z0hTEBLgLM7C6WVNmYlJn+Xf+YrLM9qCy9cyqWW5kkpmwrH
        iz/ja9WnNXSbZGvoBO3sWyYdZhE6Ml0PG+vvy3x+gg==
X-Google-Smtp-Source: ABdhPJw92rK7krw/F9CCxzv7fX+vAiEU+Q9JPG9ODdQFOD5QayhXqp68Wk4RaSck+P4PeXcEM0S3uQT8m0PeUwWEKYg=
X-Received: by 2002:a2e:9586:: with SMTP id w6mr10599490ljh.274.1591024698761;
 Mon, 01 Jun 2020 08:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200529153814.213125-1-alainm@chromium.org> <20200529153814.213125-5-alainm@chromium.org>
 <CABBYNZJJ751fxpjpZ0MFvUsQ21H9CptM_gySAgZbcGPwz76W2Q@mail.gmail.com>
In-Reply-To: <CABBYNZJJ751fxpjpZ0MFvUsQ21H9CptM_gySAgZbcGPwz76W2Q@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 1 Jun 2020 11:18:06 -0400
Message-ID: <CALWDO_UoNKFcFgTNUgY691Lj61udG0WsL9vdxbSF4Q0fpqBwEg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 4/4] fixing const decoration warnins on options.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, May 29, 2020 at 1:17 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Fri, May 29, 2020 at 8:41 AM Alain Michaud <alainm@chromium.org> wrote:
> >
> > This changes fixes const decoration warnins on options.
>
> What us this fixing?
>
> > ---
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >  src/main.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/src/main.c b/src/main.c
> > index ca27f313d..cea50a3d2 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -80,7 +80,7 @@ static enum {
> >         MPS_MULTIPLE,
> >  } mps = MPS_OFF;
> >
> > -static const char *supported_options[] = {
> > +static const char * const supported_options[] = {
> >         "Name",
> >         "Class",
> >         "DiscoverableTimeout",
> > @@ -129,7 +129,7 @@ static const char * const controller_options[] = {
> >         NULL
> >  };
> >
> > -static const char *policy_options[] = {
> > +static const char * const policy_options[] = {
> >         "ReconnectUUIDs",
> >         "ReconnectAttempts",
> >         "ReconnectIntervals",
> > @@ -137,7 +137,7 @@ static const char *policy_options[] = {
> >         NULL
> >  };
> >
> > -static const char *gatt_options[] = {
> > +static const char * const gatt_options[] = {
> >         "Cache",
> >         "KeySize",
> >         "ExchangeMTU",
> > @@ -146,8 +146,8 @@ static const char *gatt_options[] = {
> >  };
> >
> >  static const struct group_table {
> > -       const char *name;
> > -       const char **options;
> > +       const char * const name;
> > +       const char * const * const options;
> >  } valid_groups[] = {
> >         { "General",    supported_options },
> >         { "Controller", controller_options },
> > @@ -243,7 +243,7 @@ static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
> >
> >
> >  static void check_options(GKeyFile *config, const char *group,
> > -                                               const char **options)
> > +                                       const char * const * const options)
> >  {
> >         char **keys;
> >         int i;
> > --
> > 2.27.0.rc0.183.gde8f92d652-goog
> >
>
> I wonder how usufull is to tell it is a constant pointer to a constant
> character given that is so rarely in the kernel and userspace,
> something like const char * const * const would be very hard to keep
> it readable.

I'm personally a big fan of leveraging the compiler to find bugs, but
in this case it also allows the compiler to put all the strings into
read only sections.  In this example, it will catch code trying to
write into the string or prevent code execution in the read only
sections if there is ever a bug that leverages this data section to
store code that can be manipulated.  For readability, I've seen other
platforms use type definitions LPCSTR to typedef const char * const
etc..  I'm happy to follow guidance here.


>
> --
> Luiz Augusto von Dentz
