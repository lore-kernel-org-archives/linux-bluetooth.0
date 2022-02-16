Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 03:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiBPDs1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:48:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBPDs0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 22:48:26 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796C7644
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 19:48:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id bt13so2244047ybb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GAuVlW0R/ewXWsMgjo/kh1121wvDGkRn5pmEluMsSQQ=;
        b=XywlANa/WB+XQQ4LIv7sajNzwCiji9bbtVwhXTjgBhuogz1GatIZkpWNKpoknIbXG4
         4yAUyKTm5Gpr/MEmLLiW6dGKDJo3JqC3S1MFcBzAdpC2YcSWJ8jjg/kgvxGDXPjeRn+r
         /9llXrkANk7p2dwgsCmCO/5ucG58P7h+cD0MgImjGOPn4++5fJ3p1gI5mL2blFdFW8TD
         AcF1qfnxjYnQhqcNQPCxC+iPnLZsRQtTcgTSc/GRAOYqmXZnXHRnUQ7EFbUR5Dfy2/SP
         2b+BSeLQKqtCc5wRiqV9t6TrPfO9e9pJlrOgzkiE/nCiLmmRJ4UfvsK3l9kLL16fKnTa
         0RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GAuVlW0R/ewXWsMgjo/kh1121wvDGkRn5pmEluMsSQQ=;
        b=aHOnfa7fHoUD+PnljjtSSAzzd+VgFab95HAvrykYnzEIFcnBlvhEPGPq3O4DMiS/GL
         /R5zIOLmL14iVYUdKNMR2Xeu+yTKdmOgR3rjKWCrWQ9uRv3M0E4RVCoDmhyfFuKQeuQt
         v79w+nNIZFtT3ZAivZZAyY/7lnUPrPAjRgA8RKcKc++Ss6EvCzfB/Lv9KFg8fBaV9c4i
         eH2y72ohhA3RQ2VTMw7nmjCgcAc1YLxxJtrho7R8kT6+yqGd9Nt/6LTs41cqumqPOOWK
         XmhTCaaNC1jaw9EsBgd1J/tN2VAWUBB+w+GgBqlrFFTEJnetbMWgywuwKPOp82J3Tk23
         kHug==
X-Gm-Message-State: AOAM532x5miCQHvJ8W9nsUOJpv2wkyxI8ytukCprq8xf5v8G7cTkFMV+
        cJ2ZeeqEKlMSH3kwL8pGYiWL5Givyi2C7AyaYu1DnR0z8R6g4t3J
X-Google-Smtp-Source: ABdhPJwcKVGrwFHJfG/+V/m4d14wuvxogMAuIgYRJLA8gx2MRv5Ir7tULKC6dvrwhMz5DwYFsV7g4loYQmS4U3wNIbQ=
X-Received: by 2002:a25:cc91:0:b0:623:d177:28c9 with SMTP id
 l139-20020a25cc91000000b00623d17728c9mr636123ybf.524.1644983294456; Tue, 15
 Feb 2022 19:48:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com> <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
In-Reply-To: <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 15 Feb 2022 20:47:58 -0700
Message-ID: <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Feb 15, 2022 at 8:38 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Feb 15, 2022 at 8:29 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Thu, Feb 10, 2022 at 6:44 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > > Case 2:
> > >
> > > Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > > Jefferson Peak (JfP)
> >
> > Comparing 5.16.9 (working) and 5.17.0-rc7 (non-working) on this
> > Thinkpad X1 Carbon, I'm seeing two notable differences:
> >
> > Multiple messages like this:
> > [   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0


btmon is here:
https://bugzilla.redhat.com/attachment.cgi?id=1860485



>
> This matches with a complaint I found here
> https://lore.kernel.org/linux-bluetooth/20220125144639.2226-1-mike@fireburn.co.uk/
> about this patch
> https://lore.kernel.org/linux-bluetooth/20211201000215.1134831-13-luiz.dentz@gmail.com/
>
>
>
> --
> Chris Murphy



-- 
Chris Murphy
