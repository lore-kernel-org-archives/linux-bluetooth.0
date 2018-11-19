Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D50C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4754420823
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="ITC6hopR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4754420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeKSUKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:10:20 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43111 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 15:10:20 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so17353485vsc.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojEB0mFYj4bSHqY8VtJai8o56cAmoblotScWOW7kWd8=;
        b=ITC6hopR1P3hES1lu5tqjd3wHGlvQ8B1kU9jZoyOCucCsLFgAPbSqTuuxIsHCDmlBP
         yyzVpqvDWTZ1wuehM8tX+gVhlTnyL2JIByJRFomD3zfgOj0XpPG0egIUzcEiJoOBktW0
         PqzkfB+SG/HqTt38/qt1gWcvYPJcYia6hmVeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojEB0mFYj4bSHqY8VtJai8o56cAmoblotScWOW7kWd8=;
        b=H/7C5FoS48G1CGsmsV34j1o75UMt/5CswFcPKkG3wzbbvMYrq6irueUNEjhtfReC71
         H37BTSDft4S6mRN9gdrrPNGij0akuKuHN9ukMmJcwNBMWOS9TE1KqnBcfneCK3vWQgO/
         9wJDFr/fXmkZ3yJL/Wik9pACKB5OqulIxOqDolq8e8O0KiIJRiIqqVsJUAAMHXPXLIQU
         1neQCVyeKEDlq6QckGGHBxWU3Xr49R/yQKaWqlVKF83TF/RI+IOnRPiA4oz4jVI+ssfe
         j74QORIMD5NVMuf0t+4eIhlM/gvKpxRFNFgcCnqtjChyZKMAGaQHvU9ygGq9vL4LWSqf
         cJ1g==
X-Gm-Message-State: AGRZ1gI/oe0gxH9dOwERmhHPYl3sfsxBTXajew0mRxRlXrBAZsKXUAfl
        UZTylLeyD2CCVhs8iIweKURz6kZPuA/8eYis65+9win5
X-Google-Smtp-Source: AJdET5eJOALikuGOFkSg1UJDyMZEDA/LLJIlMXEopdPbYDgjYfGTfU2hKD+gryCcyCPkC0f+OEVbdq9U0oXvfB6smUE=
X-Received: by 2002:a67:dd11:: with SMTP id y17mr9157760vsj.111.1542620833472;
 Mon, 19 Nov 2018 01:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20181117060024.10390-1-gbenhaim@augury.com> <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
 <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com> <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Mon, 19 Nov 2018 11:47:02 +0200
Message-ID: <CAHotPr-pPNwawo+uU=4QbSNSdNbFcoBbnr-LY_fMiwMQW+1aew@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

are you suggesting to have a single socketpair for both notify_io and
write_io or 2x socketpair instead of 2x pipe2 ?

On Mon, Nov 19, 2018 at 11:22 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Gal,
>
> On Sat, Nov 17, 2018 at 10:48 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > i don't think it works at all... bluetoothd is still exiting with SIGPIPE.
> > i'm a bit lost with fixing this, I tried few methods that were
> > suggested here and the only one that actually worked is to ignore the
> > signal.
> >
> > please advise how do you want to proceed with this..
>
> We might be better of switching to socketpair instead of pipe2 then,
> not only we can fix this problem using MSG_NOSIGNAL but also use
> sendmsg and setting auxiliary data which can be used to set things
> like the offset.
>
> > On Sat, Nov 17, 2018 at 10:41 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > >
> > > actually it does not log the broken pipe message, is it because errno
> > > isn't set before the signal handler is done?
> > > what do you think?
> > > On Sat, Nov 17, 2018 at 8:00 AM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> > > >
> > > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > > was acquired by AcquireNotify and there are no readers. it can be
> > > > reproduced by terminating the reader process without closing the reader
> > > > end of the pipe.
> > > >
> > > > Catching SIGPIPE will cause the write call to return an EPIPE error
> > > > which will be logged as "io_send: Broken pipe".
> > > > ---
> > > >  src/main.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/src/main.c b/src/main.c
> > > > index 4716f5388..54cdb8d3f 100644
> > > > --- a/src/main.c
> > > > +++ b/src/main.c
> > > > @@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
> > > >         case SIGUSR2:
> > > >                 __btd_toggle_debug();
> > > >                 break;
> > > > +       case SIGPIPE:
> > > > +               break;
> > > >         }
> > > >
> > > >         return TRUE;
> > > > @@ -549,6 +551,7 @@ static guint setup_signalfd(void)
> > > >         sigaddset(&mask, SIGINT);
> > > >         sigaddset(&mask, SIGTERM);
> > > >         sigaddset(&mask, SIGUSR2);
> > > > +       sigaddset(&mask, SIGPIPE);
> > > >
> > > >         if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
> > > >                 perror("Failed to set signal mask");
> > > > --
> > > > 2.19.1
> > > >
>
>
>
> --
> Luiz Augusto von Dentz
