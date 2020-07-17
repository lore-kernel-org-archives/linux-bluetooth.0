Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38239C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B052064B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRjJl1x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGQVhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQVhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 17:37:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4EC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 14:37:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so9153963oie.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhUmSQousSwz/kbvYQi3hzGQnX8co6XG7O0Zkp3kB1A=;
        b=LRjJl1x2q8I/pT1qsGnVN9LXx33CVQsx8ys9MGgHR9an0Ew5mFwK3KdkU8bq+WADe1
         KItMid9hqU6FBTU9CUW0nhEGxUDUCfBCKEidCzO6HMoAQjmKKkLcu/wAh6o+oL+bErHg
         iXJuFTUKSNbf9NK/5dEuQLZU9iRXKZ9iYWFrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhUmSQousSwz/kbvYQi3hzGQnX8co6XG7O0Zkp3kB1A=;
        b=KrXAxql/oCJpE5trlMOjmM0DnEBmZ6hyLCO0kooig2+VYcN12oR8t1Tl+0m1EKvSxp
         MclKuoesskG6xO+krFn6zl2a4+W8Pn5x7IAX2HchxNmyy+FUw2YPAGoPmLpzA5jKKa9T
         rjF9qeTnq7AaWn9DqDhXrXlobUAACgmmxysiyn6PYeLxLqLcBZ9CodGIS7igVS5pp0Fy
         8LYp6TDQiuI47TZJE6QUGxfKDg1SGPmtQMyzg2umH0ebJw6cc9PVJJxFW2A2Shyu7S+j
         2WnCqptpZ66wzyxubv5hQk2FVRy6GAOdXSpG6+9N/4+0n5Dsf9fPVxhndtMKA7Cy++Y6
         bnzA==
X-Gm-Message-State: AOAM531Fmlb97OVUHWft9mXrteYAeBJ7mT2KHDjj2AtzsKw2rafcdh2a
        pFNvynv2Ykl7VwcBGjZnbwez9jxyaqqeI/aauJfIhg==
X-Google-Smtp-Source: ABdhPJxNTsm+y6J7JnJufGgddi/8Kn0pN0G+IAhW8StZoBitgdHcufaYywAVWa4r7o2DWsM74SSfaxRM7jlSqJwVEU8=
X-Received: by 2002:aca:3043:: with SMTP id w64mr9074257oiw.27.1595021826525;
 Fri, 17 Jul 2020 14:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
 <20200715224740.238527-1-sonnysasaka@chromium.org> <CAOxioNm_D1E9RY6R6U0F356HfTUJtkGFFhJaa=44hBLevHzTjQ@mail.gmail.com>
 <CABBYNZJ7mOD6pRo4hRPWpScgcJMnwNcByEecpre-SHrHQ9vFHA@mail.gmail.com> <CABBYNZ+af9SRd-zvkFusZvuxdE7_B+vP95LYqswQRVsuf2b+hg@mail.gmail.com>
In-Reply-To: <CABBYNZ+af9SRd-zvkFusZvuxdE7_B+vP95LYqswQRVsuf2b+hg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 17 Jul 2020 14:36:54 -0700
Message-ID: <CAOxioNkTQ3AGHY4rhmPOFp5EAx1XJ6dcTQXLKrYb1ekfTAFREg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] profile: Add exception to battery profile for
 external access
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Luiz.

On Fri, Jul 17, 2020 at 1:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Jul 17, 2020 at 1:33 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Fri, Jul 17, 2020 at 1:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Friendly ping on this simple patch.
> > >
> > > On Wed, Jul 15, 2020 at 3:47 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > This gives exception to battery profile to be shared both internally and
> > > > externally.
> > > >
> > > > ---
> > > >  profiles/battery/battery.c | 1 +
> > > >  src/profile.h              | 4 ++++
> > > >  2 files changed, 5 insertions(+)
> > > >
> > > > diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> > > > index 4da4355a1..c9a1af4b9 100644
> > > > --- a/profiles/battery/battery.c
> > > > +++ b/profiles/battery/battery.c
> > > > @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
> > > >         .device_remove  = batt_remove,
> > > >         .accept         = batt_accept,
> > > >         .disconnect     = batt_disconnect,
> > > > +       .external       = true,
> > > >  };
> > > >
> > > >  static int batt_init(void)
> > > > diff --git a/src/profile.h b/src/profile.h
> > > > index 4448a2a6d..95523e50a 100644
> > > > --- a/src/profile.h
> > > > +++ b/src/profile.h
> > > > @@ -35,6 +35,10 @@ struct btd_profile {
> > > >         const char *remote_uuid;
> > > >
> > > >         bool auto_connect;
> > > > +       /* Some profiles are considered safe to be handled internally and also
> > > > +        * be exposed in the GATT API. This flag give such profiles exception
> > > > +        * from being claimed internally.
> > > > +        */
> > > >         bool external;
> > > >
> > > >         int (*device_probe) (struct btd_service *service);
> > > > --
> > > > 2.26.2
> > > >
> >
> > I've might have forgotten to announce it on the mailing list but this
> > has been applied for a while:
> >
> > commit 0509a4a217256ac46020b957a6532dc150729748 (HEAD -> master)
> > Author: Sonny Sasaka <sonnysasaka@chromium.org>
> > Date:   Wed Jul 15 15:47:40 2020 -0700
> >
> >     profile: Add exception to battery profile for external access
> >
> >     This gives exception to battery profile to be shared both internally and
> >     externally.
>
> Nevermind, it was just in my local tree for some reason, now I've applied it.
>
> --
> Luiz Augusto von Dentz
