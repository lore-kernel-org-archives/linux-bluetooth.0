Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C9CA0FE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjILVFQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjILVFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 17:05:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0966199
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 14:05:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so105690611fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694552710; x=1695157510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBsOCujGtmnuDBUeKQtQ0tSGczirc+tgjS5/dddK7rE=;
        b=URP/+LjxlOLXZj+XZ9Dd2eWowP8DF3EWEeac/8gOUYpxQXSrZEdUFBJ6a3ScZREUf7
         xcBw8HsVUcBf4fGjajloRijOq6sE4C1EeawTGrEtbQiUI1+FkPvYLcLIvCR0wyG73NlP
         ZQLnsHNd2f2AgU/+k46ZZN2QkWLDt0NwbFthetlnTotMniVxazaEy+LB+Fdzdh/dlQ39
         mCZ0Ny3YHFg/gs4XhH/AaJ0rswIvF5a/rGoLU+HomIqEHU3+7wa2d5KQsAR4aTN1rdR+
         FDvw2tBgCpm7LKBCmXx53JHO2zo5lumwPL7XiGUwQ9qoSN4l82ps6EV1xW/HvuG5SNLs
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552710; x=1695157510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBsOCujGtmnuDBUeKQtQ0tSGczirc+tgjS5/dddK7rE=;
        b=vfx30FqZbCBq/dfBM4+CoyhjZzAy9wZHNTyYlbB+/SK5yPJ4+hEPjOn6DEM5ttdLFG
         zYa/dS149bVHtHSmBJ+2h/EaQgyrSnY7umr7srqIwgWzt1a3SBh33H7GG7es613sbh9k
         5iq+ELXEPgwO0fZigJTrSLY8yeBs5do4a/vnfR5UYI6LRNGouSy6FzWACEH5Mt5pziG0
         tjXVGOMMCn5Uw3pHFVtuEQ90ZGWKut18/v09lQxMo4E7HMTKtQrxs36BWG7NZo6S6Hx9
         AHR4i1oQT58ix+4uve8ZQSmYIJqcX5AINxVLUPRPhxY5OzSf1jGkqv7uQlLlbRuQrOLc
         mDZQ==
X-Gm-Message-State: AOJu0Yw9FJlC9BzCcXq26wodnwOJ9G9PEeoWOgxpaDznxy+kq/WWg2Wd
        +bSB6AqfBIRVvdsLJcXCS/bySoCYga3jnFTQNZuS5UVL
X-Google-Smtp-Source: AGHT+IHOlKwghDlYmUqDznGvXgbf9DT/gF3GHjAi7DZI1P6WDIeM4mXpaFH2PO+xA+dFOuBSFFX+lW9bj4imdGMVwWA=
X-Received: by 2002:a2e:9455:0:b0:2bc:fc2e:7671 with SMTP id
 o21-20020a2e9455000000b002bcfc2e7671mr763276ljh.13.1694552709448; Tue, 12 Sep
 2023 14:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
 <168858002504.7518.9584432839192702711.git-patchwork-notify@kernel.org>
 <CABBYNZ+7kcMqxMCH+VEJgk3x=37RU2Mchdxn3xFuU2uVp7nsqw@mail.gmail.com> <0711a8538290d26724ca39b684cc064eb89ab185.camel@iki.fi>
In-Reply-To: <0711a8538290d26724ca39b684cc064eb89ab185.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Sep 2023 14:04:57 -0700
Message-ID: <CABBYNZKZAcZumCWHhdRf=MY5qHfHp63Ob0+_0bKNLAv+5Qxhaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: detach io for source ASEs only
 after Stop Ready
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Sep 10, 2023 at 9:31=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-08-31 kello 14:04 -0700, Luiz Augusto von Dentz kirjoitti:
> > On Wed, Jul 5, 2023 at 11:18=E2=80=AFAM <patchwork-bot+bluetooth@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This series was applied to bluetooth/bluez.git (master)
> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > >
> > > On Sun,  2 Jul 2023 21:43:04 +0300 you wrote:
> > > > The Client may terminate a CIS when sink is in QOS and source in
> > > > Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it =
when
> > > > Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.=
5.1).
> > > >
> > > > It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Rece=
iver
> > > > Stop Ready command if CIS is already disconnected, and then gets st=
uck
> > > > in disabling state. It works if CIS is disconnected after Receiver =
Stop
> > > > Ready.
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after S=
top Ready
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7b10e72d=
e6f4
> > >   - [BlueZ,v2,2/2] bap: wait for CIG to become configurable before re=
creating CIS
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D8c317019=
0d6f
> > >
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> > Looks like this one introduces a problem when using the emulator:
> >
> > https://gist.github.com/Vudentz/5c7ef940fc97b054227559dcd47b99f7?permal=
ink_comment_id=3D4677775#gistcomment-4677775
> >
> > If I try to release then acquire then it won't trigger recreate logic,
> > I suspect this is due to bap_io_disconnected being called ahead of
> > states changes.
>
> Sorry for the delay. Was this fixed by d06b912df5ab ("bap: Fix not
> always calling bap_io_close on disconnect")? If not, I'll try to
> reproduce.

Yeah, that should have been fixed already.

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
