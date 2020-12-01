Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053AC64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90DD221E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLAXOO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgLAXOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 18:14:14 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2044C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 15:13:33 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id y3so829574ooq.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 15:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q42maWTIittNAB3tYJjXe+oA7RxdXXS71k8qozgz8vk=;
        b=MiYLZt30BcI3CDGFtgCxZua85WsQ9Op8fMakUICjf0t1bY/tzqD5Gmv8NRoC9nxrMW
         B+Vo8iwhij9yKK1Xi9GBmhR/lTvfErkcPuDSoQQAgD/3umvM/RrROLJUt741aCRKzAJ5
         QMt+unsJjNMZ2NWmvLHxy3oSJ2WbIl7LdASVnJB5fePgJqyC52oHL+gkTvbgJmFGdhIo
         XLowDs9dHARv8S/R2RO8fKrn16oWTZeP5S3BmHAzh9tZYPBGb1nnFKkHICl7/U4wYuJC
         nSjZ6n+ojHBM88HkRcyw3vahf1u7b2jzYvGywT2cWN1sIaR2FMZaaOeHiBJficQzYmTq
         QS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q42maWTIittNAB3tYJjXe+oA7RxdXXS71k8qozgz8vk=;
        b=P9H7+vxOyuQwU7w8j5J4muVbUVgZNym+UND86lFDZ679QC29wIJKoOBAg1BUoO+L5f
         15ARYUApeFWCuTK6Ym9L8uRUhKVVEmLpfcXOiFSmEiVLz8bOyrEoPZQpHm0C2/NU8Dvv
         U2D64mqm1jjD3eGtMpxbyZ7n94KeUN0ZqrKEK3unlVoyaaPPFLoWin3K/72Zy2lgIa7b
         JwdZXk3CinMp61BGHY+N1Qs2V1N5G9nvYEfH502gIcAN8ZsRKXOQC6gRI0A6dJrgQPPP
         03bmtpNDW2w7XDc2HDP0rBKlxGins22gqRu4u1JQti1/KqJsLwpIMbyWcDEvy7/QdxbF
         WzaQ==
X-Gm-Message-State: AOAM531FRAvbQKMBk2FyAtZfDAnndQAEF1ez3NatcW7ytbt8Fv2aHmTR
        qnwdlt3ys7B6asdf4oYRojaYhBocqiaflDEB9qg=
X-Google-Smtp-Source: ABdhPJyF11lDvjMTw/Jcagza9e0LTQUwFaN3OcYE5dI6fi6+EDOVnSYOUTJXUHnRl4Wp+TR1MCL3PnZXA4kKsRxEw80=
X-Received: by 2002:a4a:3c59:: with SMTP id p25mr3552197oof.63.1606864413233;
 Tue, 01 Dec 2020 15:13:33 -0800 (PST)
MIME-Version: 1.0
References: <CALWDO_Ug-VzXmrTOUmMKgQSqqVx-b_L5rekwnv53d4ynjzyfYg@mail.gmail.com>
 <C7HTF3EX487A.12XRHXZKFSF76@rxps> <CALWDO_XbKaLVsfTmkOU56-xtad7RAFAVnGRux_Ls40qDzF-yFg@mail.gmail.com>
In-Reply-To: <CALWDO_XbKaLVsfTmkOU56-xtad7RAFAVnGRux_Ls40qDzF-yFg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Dec 2020 15:13:22 -0800
Message-ID: <CABBYNZLN+kGfkhBeANmchjQcEmOTE7DBhZxuJ0mh=DLp-S+Ncg@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Ronan Pigott <rpigott314@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Dec 1, 2020 at 3:03 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> I likely won't get to it for a little while, but if someone will be
> fixing this, we also noticed this issue while reviewing the related
> patch:
>
> { "PageTimeout",
> &btd_opts.defaults.br.page_timeout,
> sizeof(btd_opts.defaults.br.page_scan_win), //<-- this should also be
> page_timeout rather than page_scan_win
> 0x0001,
> 0xFFFF},

Nice catch:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=a37d53db9ae7d21a8f812925303d767d3f03e597

> Thanks!
> Alain
>
> On Tue, Dec 1, 2020 at 5:53 PM Ronan Pigott <rpigott314@gmail.com> wrote:
> >
> > On Tue Dec 1, 2020 at 8:33 AM MST, Alain Michaud wrote:
> > > Hi Luiz/Ronan,
> > >
> > > This appears to have been an incorrect fix since
> > > parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params)); will
> > > attempt to read from the BREDR section. My suggestion would be to
> > > update the group table entry instead:
> >
> > Oh, that's right. Whoops.
> >
> > Updating the group table sounds good to me.

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=e2863c003c8e65b386a981ef6037518beb605795

So now everything should be using BR as group name.


-- 
Luiz Augusto von Dentz
