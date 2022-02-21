Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D850C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 17:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381586AbiBURTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbiBURTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 12:19:21 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3337C5B
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:18:57 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id bt13so35799560ybb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rknmyMXx7/392B870puMvK2H3U77pmgT+VwW9ncPig=;
        b=Y+kyxHFuqnQJG5RXtl4iNt86IsXjpNt3Sfy2HhfUv7tSOVqaoJrRzVUbJPfo/j2d6L
         n4WohJw7XCrk6wyhm8Uscw9YCmFPl8ZLZEOi2R3tyqDKwpkplgPT48AO/ReresOm0vKB
         FLhhDa51MvEXi7paczQLG8B8lZLP5c45qDCPhqZqPiyIwQbXAbKm6tv14bT7Oy7E2pk7
         I0kQgtxqDaCP0Nx9OMV3asklHXIh9OieNG8U8C4n2nU1Avsgc7Kndfj7l09jPcaEbCRC
         p4q2jS60VSMGEHjU5d6NFzwfhiUSamtol2oKwR6qKjIu5gSjW9Z3krTMJ3aJp+SJZwF3
         HKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rknmyMXx7/392B870puMvK2H3U77pmgT+VwW9ncPig=;
        b=qy1qaLNNtm2zI3W9U3DqUIWF5ulCOtVyd6/ki43ihvphvxrrL1eFQSrrJrg7Xhaslp
         paVnEFKyNaft7SnbgpysPxRYbrOs54ZYccSrkBGWrtGrFjtssMPxzQhojS1xU+eCyLq+
         vINAkp8/3ezQLgv7cqvykiUQsx6BbRW60mQW6e6kScEOmPwObDAu6J33yCzazHEavEAd
         g/6jXJe5r38e/0U1namYtUoUkLCWvdbiswpDBeqhv+/FjvsHa6Q9J1VH2h2BFpFbD2Dv
         oPphBMucg1dCCLwGexgfn04bdxATU64Z6pcNiul1Gr8Q+CPswcAiMbdDhNVSBdhfl1wV
         pGcA==
X-Gm-Message-State: AOAM533Xbmj1kihRwU9xl3vQmnReCrwuUs6/i7mC6jkX4X8jc8x1d1zZ
        p2287wVFVjywFECbVTzQzS1tLRrH77fS9iHXCfUf6XvJfIk=
X-Google-Smtp-Source: ABdhPJxc/YKpQYblkgMmbtUGQTmiLI8l/Gn1sSeqSA1VsHrvK+Lmd0AaqqsM5wLpOsbvyNqLTqp8o5JVeMW1vHyANEc=
X-Received: by 2002:a25:d803:0:b0:614:b201:a798 with SMTP id
 p3-20020a25d803000000b00614b201a798mr19623213ybg.612.1645463936960; Mon, 21
 Feb 2022 09:18:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com> <CABBYNZL3ARfn7DkQ7n_P-NqHvThdB+EbeKoHkEEk1i0g3iZVeg@mail.gmail.com>
In-Reply-To: <CABBYNZL3ARfn7DkQ7n_P-NqHvThdB+EbeKoHkEEk1i0g3iZVeg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Feb 2022 09:18:46 -0800
Message-ID: <CABBYNZKXHHegTqZ7JwGopo3gE5Z8riEQ+zmz8m3YP0GggmrBKQ@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi.

On Mon, Feb 21, 2022 at 9:12 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Thu, Feb 17, 2022 at 7:49 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Chris,
> > >
> > > On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> > > >
> > > > OK I started over, and for now keeping the reporting constrained to
> > > > the hardware I personally have on hand.
> > > >
> > > > Hardware:
> > > > Lenovo Thinkpad X1 Carbon Gen 7
> > > > Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > > > Jefferson Peak (JfP)
> > > > Sony 1000XM3 headset
> > > > bluez-5.63-3.fc36.x86_64
> > > >
> > > > kernel 5.17.0-rc4
> > > > * remove the paired headset with bluetoothctl
> > > > * reset the headset so it's not longer paired either
> > > > * put the headset in pairing mode
> > > > * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> > > > * click on Not Setup and nothing happens
> > >
> > > Well from the logs it doesn't seem the GNOME Setting is trying to do
> > > anything, have you tried bluetoothctl> connect <address>
> >
> > `bluetoothctl scan on`  does see the device
> > $ bluetoothctl pair 38:18:4C:24:2D:1D
> > Device 38:18:4C:24:2D:1D not available
> > $ bluetoothctl connect 38:18:4C:24:2D:1D
> > Device 38:18:4C:24:2D:1D not available
>
> Well you are unable to scan the device you won't be able to connect to
> it, are you sure the device is discoverable?
>
> > $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> > https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing

So looking at the logs it does seem the device is found and it is
created so I wonder why you cannot pair it or perhaps it got removed
when you stopped scanning?


> >
> >
> >
> > --
> > Chris Murphy
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
