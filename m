Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 21:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhKWVeP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWVeO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 16:34:14 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20934C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:31:06 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id y5so711430ual.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=te6Rj4ZRXZxJf+3RUMX/2lKPrmpOVXZe4XOsE3RVkCc=;
        b=kN5dd+0yI50v4B3T+aM8vSkiUbIveA3+UF03rsJ2tEjWlmhqb9HX7Ped1mTvqN08/s
         nQqB7/o0mmKhEuKlG55cqyWlFKzJtdLPKW4c30eTl7p3kOGqSfe0/Gn3Ok1wLkRAHfdv
         x3QD4+gwIILSF5eaK9dEFjlNLzFnew4Q/w1enjWlOfqfPuO2SLvxQcG519Y+HmrpP7VS
         +c7FmPvPVNYu1v1HQXNBa3pyRZ57aEmEgbhnIarzEj5IbOFhSw4KLlifVWZeZt3dR0RD
         lPiUdDWVS2BrPnp8gg8AU1Y0xgZd+iBxQmpBpaXwiD/Gr42fv6FMqxOVSZEHhA008zDQ
         APHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=te6Rj4ZRXZxJf+3RUMX/2lKPrmpOVXZe4XOsE3RVkCc=;
        b=rJti3UJ6pdkmehy6CqBpsuVZNQGPCx9smjQkmcpSQVkSXT/KULviqPGds1FZ3R0Cq1
         5K9KNZZdGXRWvp9Ye2NBe/B0Y3KakKMVof+3X5cJ5x9dkT0XK/5qhft2WkoSyWuaBbSF
         02IFo74PAIXwYgR/Yk9ooxpxbl1Sao6albzDulrAmsfrd/LQz+8f/g5WsUsLE5Fk4U1M
         McqX57EBp4V7HLZvzQT4EZhnxrq4X4BV8jt3ZI1BQBayScIXrfhMm0hiRBIejwDHfo0c
         DTpt0ZCyb2ezpVeKqYKsj87VxNpW2dq2ghKDph0yY/XM+uSK7EflbXbCu597BXvI8+/s
         sESg==
X-Gm-Message-State: AOAM532JvUhGsWSaBG9t8ph6mX62eq1XLR7wn6cc9bjUisSShpZKKyDw
        WBCgKTc8pYagNSBRhRZa4E1kR1POALRYDkb2iaG71tptQ4M=
X-Google-Smtp-Source: ABdhPJxCnrzcumyaf+vaxTuU/leGf6RzBwQA3caVagrCn+B9ViHWPV+g9UlyVJRbrGncAcSh8fBvGbUhuOM4Oa6RCqA=
X-Received: by 2002:a05:6102:c06:: with SMTP id x6mr14334649vss.23.1637703065124;
 Tue, 23 Nov 2021 13:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20211122211707.2219208-1-luiz.dentz@gmail.com>
 <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
 <CABBYNZJgpB8Y9gc92BupiBBkjyPf5SNkOBpp6B1qtYktxmAb_g@mail.gmail.com>
 <189034533844f15d220ece574427956c42a4b16e.camel@hadess.net> <93A5D079-D324-4B31-95F4-F4EA3C64CFA6@holtmann.org>
In-Reply-To: <93A5D079-D324-4B31-95F4-F4EA3C64CFA6@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Nov 2021 13:30:54 -0800
Message-ID: <CABBYNZJH8HQqDE5rnZN5LiPn0Tj6h7z+pk+-XibNj29tRnq_Lw@mail.gmail.com>
Subject: Re: [PATCH v2] uhid: Remove local copy of uhid header
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Bastien,

On Tue, Nov 23, 2021 at 5:24 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Batien,
>
> >>>> uhid.h is part of kernel uapi nowadays so it can be included
> >>>> directly from linux/uhid.h so this removes the local copy to use
> >>>> it
> >>>> instead.
> >>>
> >>> This will cause the same problems that importing those headers into
> >>> the
> >>> repository was supposed to solve. If you remove those headers, then
> >>> older distributions will be stuck on old kernel headers, and bluez
> >>> compilations will regularly fail when it uses new structs, struct
> >>> members, functions, or constants that are in the upstream uapi
> >>> headers
> >>> but not yet propagated to the user's distribution.
> >>
> >> I'm not following you on this, the distros don't have uapi headers
> >> that match their kernel release? Afaik being a kernel uapi means
> >> these
> >> APIs are considered stable and I suspect they haven't been changed in
> >> a while, you are right that this introduces a kernel dependency if we
> >> were to use new members but I still think this is better than having
> >> copies that at some point goes out of sync, specially when nothing
> >> indicates that things like input_event was not accepted by the
> >> kernel.
> >
> > Let's say you want to use a KEY_* definition that was recently added to
> > the kernel, what would you do?
> >
> >>> Strong NAK on this one and the uinput header change too.
> >>
> >> I didn't introduce the usage of any new symbols, so the only new
> >> requirement is that linux/uinput.h and linux/uhid.h headers exist, I
> >> could however rollback if we have another way to check if those
> >> headers exists use then otherwise we can keep using copies, perhaps
> >> move then under linux/ directory, anyway it is not like we don't have
> >> kernel dependencies already and we actually have been debating on
> >> having the bluetooth socket definitions as part of the uapi instead
> >> of
> >> libbluetooth, so we will need to sort out how we can update the
> >> userspace parts with new kernel interface without breaking the build
> >> on systems that don't actually ship with e.g. linux/bluetooth.h.
> >
> > You're talking about the state of things now, I'm talking about the
> > compilation failures once you rely on a slightly newer header that
> > isn't shipped with a distribution.
> >
> > But if you're willing to react to the compilation failure in the
> > future, I can't really stand in your way. It just seems weird to do
> > this now just to undo it the moment you'll need a slightly newer kernel
> > header.
>
> if I can=E2=80=99t build the tarballs on 5.10.0-7-powerpc, then they don=
=E2=80=99t get released.

The way I see this is only really a problem for unstable uapi headers,
so in case we are early adopters it is probably a good practice to
have a copy to make sure the packages can be compiled on systems
without these headers, once these headers becomes stable and most
distros already ship with them, imo, there is no reason to keep the
copies as they are not subject to major redesign and normally just
receive minor updates for bugs, etc,  which is the kind of change we
would likely miss given we were no longer paying attention to changes
on those headers as they are considered stable.

Also we might as well include these headers to be check like we do in
the following check:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/configure.ac#n66

--=20
Luiz Augusto von Dentz
