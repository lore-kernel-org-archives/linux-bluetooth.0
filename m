Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA5EC43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704E2080F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="eMVmCGHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D704E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKRHFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:05:19 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43837 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKRHFT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 02:05:19 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so5999864vke.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Nov 2018 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7nVDsWMxGi5vs+lXwrIquRp/2a/y+rtgIEVnz/FntZI=;
        b=eMVmCGHxvJLtZRsS+hwyQJTUwyLuDwwZSSLqOe2PGzBeO6ZvT+7l4KEGNsjeL1JBKj
         mGud2KFdHwBsnxmc0xhbiLMR3CtKPyA/TK7QNIqA0nXbLG9+JKeYE75vJCXwK59Pprs+
         AJX3Z/BVXc8EDnfnFMobbDtPJlNOA6H7RFWeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7nVDsWMxGi5vs+lXwrIquRp/2a/y+rtgIEVnz/FntZI=;
        b=d6ujnDv86FpO7mGhqJF7FS2HGiB/myYAuzx+QfiAtOkVa7qTNtSfy1zdEM5jDEzXQ0
         EoOmDQa7UbQBUNz7nEJCGZliJukpv43Z/8A4zvxfgaeqQbwUrpCwgJP4AFT/64Ws+4gT
         ENLOyr3ZcvxC3jj0pshH7c49qC7mT7z++ZlJZViWHlLEipMf96f1N6uxThQ8No1mSoKk
         I3vDR2c67QIu8nI48M3f62owwPFe3AUI/JpS1rtZh29RCDySaVm3kbem8WKO49H8cqJL
         p+q6TutXRk5u3jw7ZLBbR5cbZXw3q5xBTbLpbswAzNR95TyWHyUv4CgAjmF0CbkD2RBL
         3rng==
X-Gm-Message-State: AGRZ1gJUqaDAHu5vQIV8SXED/wDzDPxsGLkvyi6DMPdOzbySj2s+H9JO
        ZTm2rA0kBE54aLUI/p+ohODc0HWRxY9BwNjCJc5nDSvj
X-Google-Smtp-Source: AJdET5dG4Ctp+ZS+ivknEn5TvkfLZ+vWYZt1/gVfM7AsdcpmqROlcfta7XMK3UGZl6qoK1ZJmX6abFpyVjZl0IKJBcg=
X-Received: by 2002:a1f:f409:: with SMTP id s9mr6910112vkh.38.1542487644428;
 Sat, 17 Nov 2018 12:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20181117060024.10390-1-gbenhaim@augury.com> <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
In-Reply-To: <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 17 Nov 2018 22:47:13 +0200
Message-ID: <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

i don't think it works at all... bluetoothd is still exiting with SIGPIPE.
i'm a bit lost with fixing this, I tried few methods that were
suggested here and the only one that actually worked is to ignore the
signal.

please advise how do you want to proceed with this..

On Sat, Nov 17, 2018 at 10:41 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> actually it does not log the broken pipe message, is it because errno
> isn't set before the signal handler is done?
> what do you think?
> On Sat, Nov 17, 2018 at 8:00 AM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> >
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > Catching SIGPIPE will cause the write call to return an EPIPE error
> > which will be logged as "io_send: Broken pipe".
> > ---
> >  src/main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/src/main.c b/src/main.c
> > index 4716f5388..54cdb8d3f 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
> >         case SIGUSR2:
> >                 __btd_toggle_debug();
> >                 break;
> > +       case SIGPIPE:
> > +               break;
> >         }
> >
> >         return TRUE;
> > @@ -549,6 +551,7 @@ static guint setup_signalfd(void)
> >         sigaddset(&mask, SIGINT);
> >         sigaddset(&mask, SIGTERM);
> >         sigaddset(&mask, SIGUSR2);
> > +       sigaddset(&mask, SIGPIPE);
> >
> >         if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
> >                 perror("Failed to set signal mask");
> > --
> > 2.19.1
> >
