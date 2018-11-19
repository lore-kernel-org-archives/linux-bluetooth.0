Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD551C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E47208E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvU9CjZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E47208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKSVXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:23:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35805 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeKSVXH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 16:23:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so12595484oif.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGQ675VHdMMOvU9UOa6/uAbbNHCNa1Wo+U1yyACVGQ4=;
        b=XvU9CjZNSd6rmJ0K5B7YixiYgOQD9pWrYM3nFCoQzvXMB1ndg2P+UFTNzEuWF7yVKK
         29+xKVvNIyPX0+TUD5KZfBdDAZBH6nBGL8PVbTpwixyyGFt8clAnhS070RhQwHJqQzwR
         XJuMHzIiGN7OZu8NnetDVCsoUz9UQLwNuUn0DsmrQRpTs9JEFKqV/o0V4rDhujNG1/TC
         zduKWdG7bUUfTR38f1yfwqN2FgSQ6A+7LXpEeAqq3CawgTvprA3vtmUDPzYTsg//agMG
         sbVrISTVftX7d7TJc7aiGbpTXyOBnw6OltPf8UrZgftlKMF8dHuNcF7ioQtArfiLsakd
         M8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGQ675VHdMMOvU9UOa6/uAbbNHCNa1Wo+U1yyACVGQ4=;
        b=RatZK9kbCwNMh0oO0306eDpCdZuzvfqDzg33F0xdXwEsqxM3kgTNwjS8M6gP1RzaL+
         NmC2oxVFgtpPipVJB9wbU9xUM0G503Cw20HeLq7cwQErrCqMo70Mux5uvjALtzX2HjZN
         RmUY8+4X34h7Nq/zI5bnuWrymSVGHFj4YCDRQb+h13L2e2fc19GGbtGDRUQsI12J1eJ3
         o8UhpvACnkwciB0jLFyWV6G5NXIPmaw3h5JTLhsWp6YT8XQGnFxQ0Y0J4W0hbRevK/5j
         TR8BBuhSjSjzdsfd4wmZTsYmUBm/RzZKsHJdmh616BMfD9sd4cl72BDamrqyzs4rib1g
         fA5A==
X-Gm-Message-State: AGRZ1gJO3fsWXweVJmyuVxddJmnnewbc15ueijjJ5sCeFnKpNysF2BO1
        Wj7VqjrBCr+yCdiYQ6aex8msNh7+FYnb2zIidW8T4A==
X-Google-Smtp-Source: AJdET5cu/2zneZLk0H7BSDiWvPyMOuwEbDT3O62dAYlQSy9M+kk1XgBDxj0UXGpTr+r3/+/sQdESA3V5NG2cyErlYqU=
X-Received: by 2002:aca:32c6:: with SMTP id y189-v6mr6252521oiy.153.1542625190692;
 Mon, 19 Nov 2018 02:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20181117060024.10390-1-gbenhaim@augury.com> <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
 <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com>
 <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com> <CAHotPr-pPNwawo+uU=4QbSNSdNbFcoBbnr-LY_fMiwMQW+1aew@mail.gmail.com>
In-Reply-To: <CAHotPr-pPNwawo+uU=4QbSNSdNbFcoBbnr-LY_fMiwMQW+1aew@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Nov 2018 12:59:37 +0200
Message-ID: <CABBYNZ+uRoC_Pk8cUTFh6vH4T_xQ+BhQdAuL9-ZTjzfA=qboHQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
To:     gbenhaim@augury.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Im taking care of it, will send the patches when they are ready.
On Mon, Nov 19, 2018 at 11:47 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> are you suggesting to have a single socketpair for both notify_io and
> write_io or 2x socketpair instead of 2x pipe2 ?
>
> On Mon, Nov 19, 2018 at 11:22 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Gal,
> >
> > On Sat, Nov 17, 2018 at 10:48 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > >
> > > i don't think it works at all... bluetoothd is still exiting with SIGPIPE.
> > > i'm a bit lost with fixing this, I tried few methods that were
> > > suggested here and the only one that actually worked is to ignore the
> > > signal.
> > >
> > > please advise how do you want to proceed with this..
> >
> > We might be better of switching to socketpair instead of pipe2 then,
> > not only we can fix this problem using MSG_NOSIGNAL but also use
> > sendmsg and setting auxiliary data which can be used to set things
> > like the offset.
> >
> > > On Sat, Nov 17, 2018 at 10:41 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > >
> > > > actually it does not log the broken pipe message, is it because errno
> > > > isn't set before the signal handler is done?
> > > > what do you think?
> > > > On Sat, Nov 17, 2018 at 8:00 AM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> > > > >
> > > > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > > > was acquired by AcquireNotify and there are no readers. it can be
> > > > > reproduced by terminating the reader process without closing the reader
> > > > > end of the pipe.
> > > > >
> > > > > Catching SIGPIPE will cause the write call to return an EPIPE error
> > > > > which will be logged as "io_send: Broken pipe".
> > > > > ---
> > > > >  src/main.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/src/main.c b/src/main.c
> > > > > index 4716f5388..54cdb8d3f 100644
> > > > > --- a/src/main.c
> > > > > +++ b/src/main.c
> > > > > @@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
> > > > >         case SIGUSR2:
> > > > >                 __btd_toggle_debug();
> > > > >                 break;
> > > > > +       case SIGPIPE:
> > > > > +               break;
> > > > >         }
> > > > >
> > > > >         return TRUE;
> > > > > @@ -549,6 +551,7 @@ static guint setup_signalfd(void)
> > > > >         sigaddset(&mask, SIGINT);
> > > > >         sigaddset(&mask, SIGTERM);
> > > > >         sigaddset(&mask, SIGUSR2);
> > > > > +       sigaddset(&mask, SIGPIPE);
> > > > >
> > > > >         if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
> > > > >                 perror("Failed to set signal mask");
> > > > > --
> > > > > 2.19.1
> > > > >
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
