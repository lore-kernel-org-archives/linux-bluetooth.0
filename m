Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5455C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDEE20704
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3uyfWjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGQUiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGQUiy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 16:38:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAAC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:38:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a21so7786082otq.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0O2m/tF6hZ3t+aiG7c6/NvWqpwmmFtehL2XgyEwNsw=;
        b=G3uyfWjdaQlFYGx7RcQ0aJ37BGyR9TbOq2bKNgJZVT1lNk8xrRDJRRLjkAcoVCMJnv
         oNq8KdZLBXeJS/o2ArgB54zewfxT67gOLzLRqhqd3f3yycdmQAiNZdGNDZZiqCijknUy
         Np0TCu117x9JQBbQmg4Yxz8uD3T57vA/BWCq+LhMjSNMGBDNBcpqYJSMe+DPcAUUYK0e
         EOKyVNb+xOfrREkE8Zk6XWx7MnV8dvNs33Gdj7VTB7Wzb5qBZjmjf48F6bBVlbepsNbp
         jHCnhw4gnUOk6G4CqryiRtgcZ2PCL06kC+XGFGka1IbJCKfBkJDEdi75DZyS7DzduEha
         osYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0O2m/tF6hZ3t+aiG7c6/NvWqpwmmFtehL2XgyEwNsw=;
        b=lk9xlqvSVA5ZI7SS9uTxWpAJ9AkU9EEI+0hd81JKVhMdkIrataK/oG7T+GNzABbLiF
         6sdJ25vniFyf28k6aaz/h9AdfPiYxzFFZO9F/OlwfjCPSt23UvwwK0s8G44Fsl6NKyLZ
         m7dVNERAHmztMw2YcFo0r8WeeJpo5sbZrNmkKckIiIdCjNN5Wm2F3CKvGtCPprZR2N+E
         oR+tpqaGVNR0olQj7AtVyd2vwqFrNetDuFpx3SATnfVqlQQcjF3pLvgvyuTqLvvDffAo
         tNHGlS+mBgLHe0cvfGnEgemnRKzmu/A34oKUMd5h3AwwNKJ4p7I0aFLXzoKFj5CBoojG
         DIbw==
X-Gm-Message-State: AOAM531HXdajwZhuKdmvJNuXFcDSuUtfo6RGYmWkRYiNixjU2sigfx3x
        SH2jZ+Pj0Zpr1Y4cB++p7YbHxtza94SMyNL4aCU=
X-Google-Smtp-Source: ABdhPJyERsMC38bR31BgWPiVTMRh9g1ryzrobHlxG9tMQGP75I1OBNEzvBuA96OLwBxHpkmdUpz/CcFDjX/AqnfnoDE=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr10088176otq.362.1595018333289;
 Fri, 17 Jul 2020 13:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
 <20200715224740.238527-1-sonnysasaka@chromium.org> <CAOxioNm_D1E9RY6R6U0F356HfTUJtkGFFhJaa=44hBLevHzTjQ@mail.gmail.com>
 <CABBYNZJ7mOD6pRo4hRPWpScgcJMnwNcByEecpre-SHrHQ9vFHA@mail.gmail.com>
In-Reply-To: <CABBYNZJ7mOD6pRo4hRPWpScgcJMnwNcByEecpre-SHrHQ9vFHA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jul 2020 13:38:42 -0700
Message-ID: <CABBYNZ+af9SRd-zvkFusZvuxdE7_B+vP95LYqswQRVsuf2b+hg@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 1:33 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Jul 17, 2020 at 1:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Friendly ping on this simple patch.
> >
> > On Wed, Jul 15, 2020 at 3:47 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > This gives exception to battery profile to be shared both internally and
> > > externally.
> > >
> > > ---
> > >  profiles/battery/battery.c | 1 +
> > >  src/profile.h              | 4 ++++
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> > > index 4da4355a1..c9a1af4b9 100644
> > > --- a/profiles/battery/battery.c
> > > +++ b/profiles/battery/battery.c
> > > @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
> > >         .device_remove  = batt_remove,
> > >         .accept         = batt_accept,
> > >         .disconnect     = batt_disconnect,
> > > +       .external       = true,
> > >  };
> > >
> > >  static int batt_init(void)
> > > diff --git a/src/profile.h b/src/profile.h
> > > index 4448a2a6d..95523e50a 100644
> > > --- a/src/profile.h
> > > +++ b/src/profile.h
> > > @@ -35,6 +35,10 @@ struct btd_profile {
> > >         const char *remote_uuid;
> > >
> > >         bool auto_connect;
> > > +       /* Some profiles are considered safe to be handled internally and also
> > > +        * be exposed in the GATT API. This flag give such profiles exception
> > > +        * from being claimed internally.
> > > +        */
> > >         bool external;
> > >
> > >         int (*device_probe) (struct btd_service *service);
> > > --
> > > 2.26.2
> > >
>
> I've might have forgotten to announce it on the mailing list but this
> has been applied for a while:
>
> commit 0509a4a217256ac46020b957a6532dc150729748 (HEAD -> master)
> Author: Sonny Sasaka <sonnysasaka@chromium.org>
> Date:   Wed Jul 15 15:47:40 2020 -0700
>
>     profile: Add exception to battery profile for external access
>
>     This gives exception to battery profile to be shared both internally and
>     externally.

Nevermind, it was just in my local tree for some reason, now I've applied it.

-- 
Luiz Augusto von Dentz
