Return-Path: <SRS0=y60a=7P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDC2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B6206C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fm+L7Y+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgFBRHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRHy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jun 2020 13:07:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB6C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2020 10:07:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so6626871lfe.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2020 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MlwCnKGK5h6rbU/syP3JwPvktLJcYjd05EGrLFX3ms=;
        b=Fm+L7Y+D5mtg2IVBKJirjQJCZr5Jo9h0Buvg27iTw/kU6l53njPWbd7fkMuS0E307h
         IbWCEfb3dT2P1d2iomaY3m8mjYJ4h/E5bozxW5b1TRp4xdIti58c8Jyu61yVdUrIpDHl
         FXjX53cY67vYABYqWEPUY/fiJf24u7fB+mhBrG4G64+xkzxyPk2NLzohNXrlKk17deCl
         I0KH4fjLVaFuGLXj4Bvm75EzqNDd+HPIT56SrOpnq4d6DrE0XDL3uuMbogPww6dF2JTk
         C/Ei2Dt2Sf3GznxMZ71v62WikLVSj379nNb1SwYQmQVlG8JK2U0cyw3YiWKnsqSUdMPS
         nzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MlwCnKGK5h6rbU/syP3JwPvktLJcYjd05EGrLFX3ms=;
        b=gFaJUd3gIGHgQ6rCfppTXb5qq7edspNt6qBbjRrXpN5doixHiLPml5+fteL5E5OJMi
         2OAGG1zWgZjREh2BVRfr9ZozkVooJ5PsWns9eYL9Q0Fo175BL02H+iKv5IR8Dbt7eXEN
         ZkJBQfQXpLDO9X/4FTj4hDilTeFJn92ofCxlrjQHWeSWvtPg7o5y3ip9VDtCsOdMfQ9Z
         HoLlB6XvbmLu7vf8ZlpscqjQ8F/RLfhIxd9bi/xDLge0IAOm4cZIsgPBk7KLf1QjA1vB
         fIEP/bwpOSAr6YtOdisBOMS3fkY9BavH4ZIwcfuksodlTuLsR4/grUq1pO707qUbQmtd
         1WZw==
X-Gm-Message-State: AOAM533nSZr0yQTpruC+B3vyF8/josz6uVM8IroS1sgB1URezyUU8gxI
        pJm1QA051XUEDPJ9lpKujvf0T+AWB3kYwfm0MLb+XNrZdRA=
X-Google-Smtp-Source: ABdhPJy2v4bgrMvJbvQcm7LM3O/d04AmkxUg7tvJBswbHkJh76qDjSmzxvoWnl8Hkxw0Qq8JlggRaUwJoRsWvE1r5lE=
X-Received: by 2002:a19:4acf:: with SMTP id x198mr188796lfa.129.1591117672710;
 Tue, 02 Jun 2020 10:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200601213902.389278-1-luiz.dentz@gmail.com> <CALWDO_UDqCm_tgA5aGyeRz=GDQYFnS+UC-AJ3h2NjGfJCSSwLw@mail.gmail.com>
 <CABBYNZJFwv+UTU=h_AvUU5hOy2r3A+iYQ2UwpjcL+ZOEo0gBsQ@mail.gmail.com>
In-Reply-To: <CABBYNZJFwv+UTU=h_AvUU5hOy2r3A+iYQ2UwpjcL+ZOEo0gBsQ@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 2 Jun 2020 13:07:40 -0400
Message-ID: <CALWDO_VmJuCCQQmRGkbYVbDrpW5LDqh0=R=hXV_sGQAXeTfMkQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Fix crash on transport_cb
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz!

On Tue, Jun 2, 2020 at 1:01 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Mon, Jun 1, 2020 at 2:52 PM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Mon., Jun. 1, 2020, 5:39 p.m. Luiz Augusto von Dentz, <luiz.dentz@gmail.com> wrote:
> >>
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> There have been reports of crashes on transport_cb where the setup
> >> would most likely already have been freed but transport_cb would still
> >> be called, so instead of assuming the setup pointer would be valid try
> >> to lookup the list of active setups and log a warning when it happens.
> >
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> >>
> >> ---
> >>  profiles/audio/a2dp.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> >> index 7f14c880a..d88d1fa69 100644
> >> --- a/profiles/audio/a2dp.c
> >> +++ b/profiles/audio/a2dp.c
> >> @@ -2217,6 +2217,14 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
> >>  {
> >>         struct a2dp_setup *setup = user_data;
> >>         uint16_t omtu, imtu;
> >> +       GSList *l;
> >> +
> >> +       l = g_slist_find(setups, setup);
> >> +       if (!l) {
> >> +               warn("bt_io_accept: setup %p no longer valid", setup);
> >> +               g_io_channel_shutdown(io, TRUE, NULL);
> >> +               return;
> >> +       }
> >>
> >>         if (err) {
> >>                 error("%s", err->message);
> >> --
> >> 2.25.3
>
> Pushed.
>
> --
> Luiz Augusto von Dentz
