Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32873C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiBQBg1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:36:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBQBg0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 20:36:26 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7972A8D14
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 17:36:12 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p5so9809330ybd.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCNxlnbZWccnxCFylB+uz0XF+MQaehR2MVihofaD5EU=;
        b=XAtN7V/VKnhgSxCXvox/mTZRJ0wYS/0bbIG+lCFxhdwbNVRHJRKyoWFImHQCsR8Or8
         K2PCtptxGlkP+qEM3Bcbbh6tgHFyJXurEgzJYS6aT7FNoiHqOh/RMP7NXqtBuaQNVUaQ
         phA0KP0gwXMw+40As+vyi19a0OZtlpzpLdIEgXXnrvWGHGDB7U2DCfm7iP/qbfoP+/h1
         1v/23WlyGKrdtafHqmtogLr779Puq3WoXf6omYupvpyhxUt6+NfTEUqxS0x7ERohBmBH
         h095za2TItJH6EBnDA1Fx7hRUwv/36nJ09ZK8R/4xPmTdbA5XRiQCtkLdai60rmTYF2c
         Wc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCNxlnbZWccnxCFylB+uz0XF+MQaehR2MVihofaD5EU=;
        b=tXt85oqptmHojvVwU2zDfeuS4WX/EfKbfpWhqZ/GGfY4FsngoV/akHPHRVWr0C/s6S
         ZcXAMdZFVPDh0P9qjf9Fui7zno1YmdLHSmxYW8rPGV3EGTWmsrh4alrB+UyZjHmXWpOq
         A5x3GVgzTrqQc70XDjpwFxhlF9Y0fHx1p+Wx02bSGcsyHhlKV+3Xfg2cFvG2lCkx+YtH
         +FWxVEvg01uM+yOTkZKcwlmOrpAwPbNp+B6SnhvRvhMGV9QVwCYKj8fFjIXOmA8M2irv
         in6B1FVdrzib/pXkT4CHfyO1tWHnv/eaFe+FfGNdcii9u6Gm/NpCymSuSeDqYdDdlFBf
         X63w==
X-Gm-Message-State: AOAM530OTe7s0w5ZDzPjqgnpwrmn3SYL44wiR6ltgB4W+hOYYXZ9IaWu
        jwGAWKJAac/Mr5PBpTdod19Xu26cQxwXrwYW0u6PxA==
X-Google-Smtp-Source: ABdhPJxBF9TPV14SrtFaqgrcga9bypMEKjcXh1cRSu0GEFS74CGZ4yA1LCIzaw6IaucHOiF33ieOyVItk4odf96ll2k=
X-Received: by 2002:a25:ba46:0:b0:622:8a:1272 with SMTP id z6-20020a25ba46000000b00622008a1272mr523225ybj.642.1645061771886;
 Wed, 16 Feb 2022 17:36:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com> <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
In-Reply-To: <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 16 Feb 2022 18:35:55 -0700
Message-ID: <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Feb 16, 2022 at 4:49 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Tue, Feb 15, 2022 at 10:40 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 8:38 AM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > On Tue, Feb 15, 2022 at 8:29 AM Chris Murphy <lists@colorremedies.com> wrote:
> > > >
> > > > On Thu, Feb 10, 2022 at 6:44 PM Chris Murphy <lists@colorremedies.com> wrote:
> > > >
> > > > > Case 2:
> > > > >
> > > > > Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > > > > Jefferson Peak (JfP)
> > > >
> > > > Comparing 5.16.9 (working) and 5.17.0-rc7 (non-working) on this
> > > > Thinkpad X1 Carbon, I'm seeing two notable differences:
> > > >
> > > > Multiple messages like this:
> > > > [   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> >
> >
> > btmon is here:
> > https://bugzilla.redhat.com/attachment.cgi?id=1860485
>
> LE or Classic? Perhaps this is related to:

I don't understand the question, how can I find out? All I know is
it's a Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)


> https://patchwork.kernel.org/project/bluetooth/patch/20220216221822.2694867-1-luiz.dentz@gmail.com/
>
> Btw, in the logs it doesn't really show any connection attempt just
> advertisements reports so perhaps you want to collect the logs while
> attempting to connect or perhaps you are just waiting for the
> auto-connect to kick in? Does your device appear to be advertising?

I was collecting logs while toggling the "connect" switch in GNOME
settings->bluetooth-> for my bluetooth headset that had already been
paired; and then I chose to "forget" the device in the list; turned
the device off then back on in pairing mode, but it just hangs when I
try to set it up. All while running btmon. Seems like it can see
devices, but won't pair or connect.

When I keep user space the same and revert to kernel 5.16, the headset
immediately connects within seconds of being turned on.

Thanks!

-- 
Chris Murphy
