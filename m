Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 23:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiBPXuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:50:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBPXuJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 18:50:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D827C237
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:49:56 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p19so9513129ybc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqYf9p3WW1FplShqmzmxJORMTRv/j9aLEl+f8jd9C/0=;
        b=ZuiokVftdXkC4UZFho8+OlkXmtFdnw4XZ+KG04XuyOCDO6iQ7UOoT+EpG669tru4mv
         8IAPF/G3UNwftUojOePvMsta2e2+86QkZpL+ahSH9uUW4sdLY/9oWFRJpMLL8Uoo4yu/
         JNcal9SNZF/cLkc/XpqQcNKm2P2vOI1n8wVYZ2NA+aV/ukYHqsDH0312CQDHNL95Pa1Z
         EVkDEaPGKWvko7oSQhncnoCVaynpet8H0duKMhRHEodZTAezfqwSaAKkwmSJVNr4Rpm3
         nO1tRL8/Bv2zR7sE7VXrq8rzlXgmj3mY1JFzYxRzhM6B0zO/UEAn51huTVIQUrG/ToYy
         EQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqYf9p3WW1FplShqmzmxJORMTRv/j9aLEl+f8jd9C/0=;
        b=tv41CVR3rGq2WKJqEJFeXzOiBA9Vl7+MZZLdQZ5kFwb63TyeV5cxwqDMTNVoVPJc+w
         0XI8LV1LvzjLjBvKn6jOrL9z3k1NXxNJB/7pQuCQvbXJmFzHtDINn5ndg3JcUvSL/9q6
         S+vLhBiJHLwqbXHhND3XxJTXiwW66YxJpHz1Qc1vkzI2m5FLshg5ueFSdKdvVyLndVuf
         5uQ2l1dD68oXxRNwtNqlVRspZ2Z/WOrTQS0el+DRlakXa0B6iqb2cBEFv946poWC0iZx
         fE9XIVIgo//kM9JoTEHtwRRST2UvHHECY7mY1tHJJWbwPQZPHPpGRzbbI6mG3rcvgorC
         J0Ng==
X-Gm-Message-State: AOAM530HPd8vb0Ra4LTsSdZ2l1OVSWixZ/WFKZlUh+kC3wpspeDDdqlE
        dlFfsXWhkv37FlzyZdPk3NflkQ8zyEnWxyT0f7YoE30w0UI64g==
X-Google-Smtp-Source: ABdhPJw2ReyabXh5N18w2l/GOKgYMxeiLT8qmzgzLGf7dSbdSQoNGPxpqBiag87v1bExrrJDLnaCBkn2bax1nZBm/JI=
X-Received: by 2002:a25:2692:0:b0:61d:7f1f:3076 with SMTP id
 m140-20020a252692000000b0061d7f1f3076mr226676ybm.293.1645055396063; Wed, 16
 Feb 2022 15:49:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com> <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
In-Reply-To: <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Feb 2022 15:49:45 -0800
Message-ID: <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Tue, Feb 15, 2022 at 10:40 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Feb 15, 2022 at 8:38 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 8:29 AM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > On Thu, Feb 10, 2022 at 6:44 PM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > > Case 2:
> > > >
> > > > Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > > > Jefferson Peak (JfP)
> > >
> > > Comparing 5.16.9 (working) and 5.17.0-rc7 (non-working) on this
> > > Thinkpad X1 Carbon, I'm seeing two notable differences:
> > >
> > > Multiple messages like this:
> > > [   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0
>
>
> btmon is here:
> https://bugzilla.redhat.com/attachment.cgi?id=1860485

LE or Classic? Perhaps this is related to:

https://patchwork.kernel.org/project/bluetooth/patch/20220216221822.2694867-1-luiz.dentz@gmail.com/

Btw, in the logs it doesn't really show any connection attempt just
advertisements reports so perhaps you want to collect the logs while
attempting to connect or perhaps you are just waiting for the
auto-connect to kick in? Does your device appear to be advertising?

>
>
> >
> > This matches with a complaint I found here
> > https://lore.kernel.org/linux-bluetooth/20220125144639.2226-1-mike@fireburn.co.uk/
> > about this patch
> > https://lore.kernel.org/linux-bluetooth/20211201000215.1134831-13-luiz.dentz@gmail.com/
> >
> >
> >
> > --
> > Chris Murphy
>
>
>
> --
> Chris Murphy



-- 
Luiz Augusto von Dentz
