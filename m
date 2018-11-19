Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D9C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE5206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYzdRJ5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKSTpa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:45:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44386 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeKSTpa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 14:45:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id z33so26974892otz.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 01:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt3vBjwqwnZSf6tJ1u+4qDGkJKcM2W6EJKMeNouPAFM=;
        b=VYzdRJ5EnBtKz6Pp9dSyDcogLiPD/R2Yy6PS0Zt+Ls3OrlM8rIrrjxG5FNfwk0uUel
         1vE/zODkfFO0IFQc55bTNuPqO5Pgqggp7uhVIFTNme5lC0rnRWY5q+mC926zVTozxXOT
         U9jHwQVIIEZ3vLlpCP3+P6NQJ01QXXrLT5UAOEan0o/AMym7HEFAXFjisf81HX4j8Qrk
         X2y5bBk5gCNk5lAYamOxyBSHrBUi9MWeR0Cb7h6Xnv1q89uv8vCLIBeZrGGCly3M4cyd
         WiVTAprOsJR2KtQr0qjieu34gUYJSQwRrrIVkurHP6G9NyFq8bH9v7o+MrarupSCr6+5
         f+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt3vBjwqwnZSf6tJ1u+4qDGkJKcM2W6EJKMeNouPAFM=;
        b=BOfqC1wntx0p0OW/fQUlVAl4xa1q56gSUfihrXcguDSwa6SolAplvcAskfEXHE7odw
         H57jB8I97uSQ5URD0q+INxTaua2KgF0+GCaSlAWrOOeWhjFGDw/vnIk/adfxMkBvLCpz
         CkVEqkAigbYBijUwGdM1D/Vdh3UkXZUX/dJVfeUVbhvHqyOO0drJ4ac0L2R9QkTVf2JF
         0BAmF1w9egx8BqhFB3kahnFjmTT30M/y362a4pNWf2XEit+U6oDaeFDe6IUAgA19gwUE
         cNUF5iaQ7nSqgqxeDvUKguFxv4qqeRn3f76DEPSlEkGEDd+Hq0LkRYjpPg1o5NXIXDiz
         cYRg==
X-Gm-Message-State: AGRZ1gIg2W0gGp/AwUzEd5oLmz9cB0S5RNUtWQzAnJR30e+D/ta/XFIG
        ojE+JOHywxbalWeOLLgj7A00G7YONLt8+KhSn6e6mw==
X-Google-Smtp-Source: AJdET5fHX8nQj35vCgExaGV8ywjW62WmUfeb19+GpM+GDnhi3CrOvVpycKyHG2xegwAx8qf5RMCHte7VonbziZZaK0k=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr12090752otf.52.1542619347098;
 Mon, 19 Nov 2018 01:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20181117060024.10390-1-gbenhaim@augury.com> <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
 <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com>
In-Reply-To: <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Nov 2018 11:22:15 +0200
Message-ID: <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
To:     gbenhaim@augury.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

On Sat, Nov 17, 2018 at 10:48 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> i don't think it works at all... bluetoothd is still exiting with SIGPIPE.
> i'm a bit lost with fixing this, I tried few methods that were
> suggested here and the only one that actually worked is to ignore the
> signal.
>
> please advise how do you want to proceed with this..

We might be better of switching to socketpair instead of pipe2 then,
not only we can fix this problem using MSG_NOSIGNAL but also use
sendmsg and setting auxiliary data which can be used to set things
like the offset.

> On Sat, Nov 17, 2018 at 10:41 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > actually it does not log the broken pipe message, is it because errno
> > isn't set before the signal handler is done?
> > what do you think?
> > On Sat, Nov 17, 2018 at 8:00 AM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> > >
> > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > was acquired by AcquireNotify and there are no readers. it can be
> > > reproduced by terminating the reader process without closing the reader
> > > end of the pipe.
> > >
> > > Catching SIGPIPE will cause the write call to return an EPIPE error
> > > which will be logged as "io_send: Broken pipe".
> > > ---
> > >  src/main.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/src/main.c b/src/main.c
> > > index 4716f5388..54cdb8d3f 100644
> > > --- a/src/main.c
> > > +++ b/src/main.c
> > > @@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
> > >         case SIGUSR2:
> > >                 __btd_toggle_debug();
> > >                 break;
> > > +       case SIGPIPE:
> > > +               break;
> > >         }
> > >
> > >         return TRUE;
> > > @@ -549,6 +551,7 @@ static guint setup_signalfd(void)
> > >         sigaddset(&mask, SIGINT);
> > >         sigaddset(&mask, SIGTERM);
> > >         sigaddset(&mask, SIGUSR2);
> > > +       sigaddset(&mask, SIGPIPE);
> > >
> > >         if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
> > >                 perror("Failed to set signal mask");
> > > --
> > > 2.19.1
> > >



-- 
Luiz Augusto von Dentz
