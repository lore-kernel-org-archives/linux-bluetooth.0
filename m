Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8754C07E99
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9300861221
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhGLQkL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhGLQkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 12:40:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0ABC0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 09:37:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a16so29976959ybt.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKdXluYtiPLE0QE4IPmo99nu3D6nEXBkSEuFLUWgKc8=;
        b=Ppssvdob6fkq3swoKd/OaLuUbh3yHSL0gvQsJvXlUJ++9BJ9tMK/Zqh8nENizFHBay
         YLsJ4IY4bZx+eBLGEmYfA6n9WW8s8xVI+4H/I6OW6pX86b+lQjB71JIcr8od91mBZ8bB
         9rAK/v+FstAhR9BneZiEl/KnQ1pDtsjrNI5M43Hk2GBiSC9Ff416itbLw8EAIvbh8qxz
         c+JbxvNLqEeJfbQGT06fyDM6RkPYOcI7BNPvUty9ImADou59JoHPOIterdeNDIuh/D+v
         gV6Iyi3qvrDL05kIm0oyZ5vBVvYdYAQXRFnnRuZp9Wqi223qRaP9ks9YFEAqetCQaj76
         peDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKdXluYtiPLE0QE4IPmo99nu3D6nEXBkSEuFLUWgKc8=;
        b=hp6EAF7LdPmClohDTNAgKuCLRj4u2tWHRjCY5t/JH7fkRTpx/Fv7QbjOWXHbiciEYU
         qbEzOMqrjrNigaMeWiBrtquUtTkfwW0xyJCGQmbc5f5M6/GRYeVmOO6dPY3x3F/vE5Dp
         y6sePPrFB/+158XSnlt89EYTNyPiIQdu3Zu8c+2JTzLlJoVYD1ceiPlRd59hOry47t0H
         L3gzKSVnngEzdqJtHk7TT22G5LBqnSIbkaRmci80mdnxDECFrJIf3Q/lg72j8WmksUg2
         y9obwlwxVnP8SQ+bhJOXQmYlgw+fwWBLi7RB8o47ixzK2KvnIPgrOKOy0QAlpYm6PRsL
         EJQg==
X-Gm-Message-State: AOAM533Wxevt9oZ8dzTgScA/weJvHdfxBaZ1oyl0A4Xb/SCm9aOPLBEs
        IuoOfN1V4UY2vn3n7lEqS1N0EHUdR6llV0Qbe2E=
X-Google-Smtp-Source: ABdhPJzPSzPTgjVyzr2h3G4G44ryTLk4dUDdJNYnwTHAmdL64O6dLojteT/TwLXS0Z2t2JmNlXnwChKrA+kyFzywKUs=
X-Received: by 2002:a25:7647:: with SMTP id r68mr67010700ybc.432.1626107841532;
 Mon, 12 Jul 2021 09:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
 <20210708142059.Bluez.v1.6.I123189fa93aad2c2d1be645d38dbc494aa15563c@changeid>
 <CABBYNZ+_hYCZX=QMbrYALK6QwVnxcT4-XM-aaFvNHxC06fR2vQ@mail.gmail.com> <CAPHZWUfQSECsHDB4AB2OfhTeRra9JoiwK_gqxysD1nrqtknyyw@mail.gmail.com>
In-Reply-To: <CAPHZWUfQSECsHDB4AB2OfhTeRra9JoiwK_gqxysD1nrqtknyyw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Jul 2021 09:37:10 -0700
Message-ID: <CABBYNZ+FO0h_AExsCGeNf23UAhUx2T1DhXPhwE3siTEX-dQmOw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 06/14] audio: Remove Media1 interface when a2dp
 source disallowed
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Jul 12, 2021 at 1:17 AM Yun-hao Chung <howardchung@google.com> wrote:
>
> I agree this is a trick for CrOS and probably not suitable for
> upstreaming. If we want to allow/disallow profiles without
> reprobing/removing them, here is what we need to do:
> For each profile in profiles/, reject the connection if its UUID is
> not allowed. Note that checking the UUID in btd_request_authorization
> is not enough since some profiles like profiles/health/mcap.c don't
> call btd_request_authorization.
> The same check will need to be added in src/profiles.c as well so that
> we can also manage external profiles.
> Does that make sense?

Yep, afaik when Ive implemented the service plugin I did the
blocking/allowing at the service level, not sure if you want to
replicate that.

> On Fri, Jul 9, 2021 at 1:49 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Howard,
> >
> > On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
> > >
> > > When A2DP source profile is removed from adapter, a2dp_server and
> > > everything inside the object will be removed, which also releases all
> > > MediaEndpoints and MediaPlayer. When A2DP source profile is re-added,
> > > although a2dp_server will be created, clients are not able to know they
> > > can register their endpoints and player by then.
> > >
> > > This patch handles this case by unregistering Media1 interface
> > > when we remove a2dp_server, and register it back when a2dp_source is
> > > allowed.
> >
> > This sounds more like a bug fix for a regression introduced by the
> > very set, so Id recommend fixup the original patch that introduced the
> > problem, also Im afraid there could other instances like this perhaps
> > it would have been better to propagate the allow/block to the profiles
> > that way they don't have to be reprobed, I also have my doubts clients
> > would react properly to Media1 disappearing and appearing again so Id
> > leave it up if there is any endpoint/player registered to avoid having
> > them to re-register.
> >
> > >
> > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > ---
> > > perform following steps
> > > 1. SetServiceAllowList to empty list
> > > 2. pair with an LE headset, then turn off the headset
> > > 3. SetServiceAllowList to "0x1234"
> > > 4. SetServiceAllowList to empty list
> > > 5. turn on the headset and check if it is reconnected.
> > >
> > >  profiles/audio/a2dp.c  | 2 ++
> > >  profiles/audio/avrcp.c | 3 +++
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index d31ed845cbe7..26d4f365207e 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -3275,6 +3275,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
> > >  {
> > >         struct a2dp_server *server;
> > >
> > > +       media_register(adapter);
> > >         DBG("path %s", adapter_get_path(adapter));
> > >
> > >         server = find_server(servers, adapter);
> > > @@ -3315,6 +3316,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
> > >                 return;
> > >
> > >         a2dp_server_unregister(server);
> > > +       media_unregister(adapter);
> > >  }
> > >
> > >  static int a2dp_sink_server_probe(struct btd_profile *p,
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index ccf34b2207a9..997a5be9a0f4 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -4751,6 +4751,8 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
> > >
> > >         if (server->tg_record_id == 0)
> > >                 avrcp_server_unregister(server);
> > > +
> > > +       media_unregister(adapter);
> > >  }
> > >
> > >  static int avrcp_controller_server_probe(struct btd_profile *p,
> > > @@ -4761,6 +4763,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
> > >
> > >         DBG("path %s", adapter_get_path(adapter));
> > >
> > > +       media_register(adapter);
> > >         server = find_server(servers, adapter);
> > >         if (server != NULL)
> > >                 goto done;
> > > --
> > > 2.32.0.93.g670b81a890-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
