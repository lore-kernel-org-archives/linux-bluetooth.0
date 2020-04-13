Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869F5C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6427720732
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZwUzrS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgDMQK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgDMQK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:10:57 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A57AC0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:10:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i27so6682653ota.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/gbJ9Pr+EPLUwQJR8woeoN7yCQBLMMliIHRcFFuyZE=;
        b=JZwUzrS3zag21Y7abyS5wRVpDtkD+PU4uNv8ym3VQkYVTMauQXXyKY3UOJtudLHWIH
         L07cS/ITX8qr2eyDuXKNN1k3lCY5+8c2x/AgmTOw5GpImGcGzqPWh3e32K2JnbGwA7uf
         XWIu10V0S8f5gWEOqFD3c6Su7PvWjQQmmF3A0J7JU94J80QSsQ2bIELWNoCNnIIX8qcn
         PUIxK9ljqbU6++sM+uoIaNq9zst55bas+NlI23S/Qpr42Qjc0SWj7looOBEsun6Ds0gX
         QSmF0CgUQx2p40nq+F452atwKvXWypprIAfatFD0bqsQnY2jneKyq6lWILmldfx0aqgZ
         eS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/gbJ9Pr+EPLUwQJR8woeoN7yCQBLMMliIHRcFFuyZE=;
        b=NA087PfiWvDJGsQ5l7PH33DUs+RaUE/HgHwCETTC6ESwBahGWyj0PvIXSlgJBrTvpV
         Ycx8CsoAHdgF+Rvk3NFJaF+J+cWl5IWtSXFIKaxoT8748Z1OGz/Xdbhp3Q9vosewDMl2
         +puTfQOhkv5hIQaF87Tpa+3rYlj8lP0HA4JBwr4ABbqZVqZl6lvTh91+i5PQBbu57mOj
         j7taPD5YkKuqh+Yso5tP66B/xu7N8lfk8MLuGpAQMpWmk1V6zx0DutBu6BxWpEpbe7iq
         2YE/fusbrmypQSra0K4IcQBzkU8dvIViuDlnh8E8vKuWjLY9CiLIyeaqP96yZ8RFFC+/
         gTag==
X-Gm-Message-State: AGi0PuZuU+Omh0FrEEu/W9LNeMoaHi8JCV6GfVFedHe4G80nVVwishcT
        4OgyBNZvgPk4jSmF68M/UCyM+e+8vcsKdbu3We9eOrzuK8E=
X-Google-Smtp-Source: APiQypIUyJDWcxw6umVsaEc876kayMsUmSB91Drwp9Rhi3if5wNYUJjmEKISv/qFDPQC5bWCfa6FuJ4CwMxlxQyA/Vw=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr7840688otp.79.1586794256132;
 Mon, 13 Apr 2020 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
 <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
 <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com>
 <14E46BF4-0688-4A0B-AE84-46C4426C5E9A@holtmann.org> <CAJQfnxELMMDa6nbxRUrW46VjEBj6Txfeym62PKi+R3iXHKU0CQ@mail.gmail.com>
 <CAJQfnxG_AnWArBg8_Pg3coAeFbRuG08KkXh1G==CuXWCvJpf5Q@mail.gmail.com>
In-Reply-To: <CAJQfnxG_AnWArBg8_Pg3coAeFbRuG08KkXh1G==CuXWCvJpf5Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 09:10:44 -0700
Message-ID: <CABBYNZLYzsKNknN_A4GaRevh=32=dGrPDPW-ksSGd7+PrGXS6Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Archie Pusaka <apusaka@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Apr 13, 2020 at 6:48 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Marcel, Luiz,
>
> I found out that shutdown second parameter is passed as the "how"
> parameter in l2cap_sock_shutdown() [1].
> Currently the value of the parameter is unused, but I think we can
> assign it to sk->sk_shutdown. Therefore, we can differentiate whether
> we are interested to wait for the disconnection reply or not, by
> supplying SHUT_RDWR and SHUT_WR, respectively.
>
> Do you think this is a sound idea?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/l2cap_sock.c#n1267

That was what I meant on my reply, that way we can detect if the has
been shutdown on both directions or not, so in case of SHUT_WR it
shall on indicate POLL_HUP if the userspace is polling with POLL_OUT,
thus POLL_IN would still wait for the disconnect to complete, I guess
this is worth the shot since this does not introduce any new APIs, but
we might want to introduce a test to l2cap-tester to cover this
functionality.

> Thanks,
> Archie
>
> On Wed, 18 Mar 2020 at 20:41, Archie Pusaka <apusaka@google.com> wrote:
> >
> > > > I see, we shutdown the socket immediately since the socket API itself
> > > > don't seem to have a concept of disconnect syscall not sure if other
> > > > values could be passed to shutdown second parameter to indicate we
> > > > want to actually wait it to be disconnected.
> >
> > I don't think the second parameter matters, I tried every possible
> > valid values and intr_watch_cb is still called without waiting for the
> > response.
> >
> > >
> > > in a blocking synchronous system call world we have SO_LINGER for that. In the world of asynchronous IO handling (what we do), we need to check what is the right way of handling this.
> > >
> >
> > I spot this piece of code [1] which utilizes getsockopt to query
> > socket connection information from the kernel space to the user space.
> > We can use a similar method to query whether (sk->sk_state ==
> > BT_CLOSED), which is only true when we get the response.
> > What do you think?
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/l2cap_sock.c#n476



-- 
Luiz Augusto von Dentz
