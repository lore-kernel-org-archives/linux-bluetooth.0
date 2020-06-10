Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6F52078D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFsUSFgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFJUWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJUWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:22:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE98C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:22:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so2799979otv.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSJwoJOONFjfcicEnTC8HxvKhhMUTlXSAnKW+KEzDx0=;
        b=gFsUSFgBvbqua7BAtgsTG3DNEs24quQX59JszaZlfb7pu9lrgjTVkM2VM8Drv0k2WJ
         xNS0F7d1oIQuDjr/CjhD59K7D5coPOb/N9WwrQw5HTT0/xqW20X5For0chYwId2tWn1U
         9A58OWx1crbVRSh7JdylEfVyYK40lFs+li5QkAHTYKF5hyyZ6/y+EpXTsxtkJmRqW8nv
         pHNRoAtUhEHz5EbMhDT10hBepof6M6gM+7q0SRvYsQeNF45os0qaWMySnfxZMYooj3ci
         Ambfwir6WmJhCMmhL5GwMwYYBy/bKHaLVsULX9lJEat6ZSWRItM1FAjlYJ7KPlGFPaXN
         vzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSJwoJOONFjfcicEnTC8HxvKhhMUTlXSAnKW+KEzDx0=;
        b=XAtboURp0ocWZlTWBGZhPzcrbP+/urR8XlywdBfGOSUV98LRdeaZH4TmtwsR5bL5RW
         LHlQSrCfazgDa7rWAlOL/6bOBNE17ZVc2dRZia0LNF/JxndfBbMEcT6EMKGUCtFU3WsV
         ArLnqKyguDB+QSyepYK5QwFx+pfBQSRuhnEaWmdppGBxEP1uPk8ELpASoyO9Uhsu9/BF
         cpvphMlecoXvOWfbN1gLI9qODvvr7EUZcKmWmHuf66vb/2SAer05qHHoxB1FY/+bWWEt
         /h7RL0h3fgPYrHmzM4txG4XOUPt+50T3hVcCP1BUHV4QyQ532bE0wAJ5U9jC3PjWWYlq
         lSLg==
X-Gm-Message-State: AOAM533l+uzbBY7knjjbDwJVJJJ77tN2J50nFXx0b8xi1Sq21LnTf/Pp
        VyMBLcjKCcKv38Vh2Lt0O0b/4iUUkpAtUm2Eltk=
X-Google-Smtp-Source: ABdhPJz2ro0xCJpfPhElxnz2IJ5xdRC9zxFd4venu/x7zIghVa/FvfpU2NAhIg7/Z9wuHZ1cCrPXKfqhK/A+4HyhN7g=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr4198025otq.79.1591820552050;
 Wed, 10 Jun 2020 13:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200609225813.Bluez.v2.1.I1952bb847ed07631095daf37fe281a49ccf864d0@changeid>
 <CAJQfnxGAAFY0j1GQcOLvWuoYmLmmBSyimMz-hn7-Lh25A6fOtg@mail.gmail.com>
In-Reply-To: <CAJQfnxGAAFY0j1GQcOLvWuoYmLmmBSyimMz-hn7-Lh25A6fOtg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Jun 2020 13:22:20 -0700
Message-ID: <CABBYNZJq0qggkBagHuxyvmw7rW-boq4ju1O79eZDm_bGjkaB3Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] input: disconnect intr channel before ctrl channel
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Jun 9, 2020 at 8:03 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> Sorry, I didn't realize sooner that the version which I sent earlier
> as v1 is different than the one in my local repo. This is the correct
> version.
>
> Thanks,
> Archie
>
>
> On Tue, 9 Jun 2020 at 22:58, Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth HID Profile spec Ver 1.0, section 7.2.2, A
> > host or device shall always complete the disconnection of the
> > interrupt channel before disconnecting the control channel.
> > However, the current implementation disconnects them both
> > simultaneously.
> >
> > This patch postpone the disconnection of control channel to the
> > callback of interrupt watch, which shall be called upon receiving
> > interrupt channel disconnection response.
> > ---
> >
> > Changes in v2:
> > -change socket shut mode to SHUT_WR
> >
> >  profiles/input/device.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index d89da2d7c..e2ea459fe 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -1026,14 +1026,19 @@ static bool is_connected(struct input_device *idev)
> >
> >  static int connection_disconnect(struct input_device *idev, uint32_t flags)
> >  {
> > +       int sock;
> > +
> >         if (!is_connected(idev))
> >                 return -ENOTCONN;
> >
> > -       /* Standard HID disconnect */
> > -       if (idev->intr_io)
> > -               g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
> > -       if (idev->ctrl_io)
> > -               g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
> > +       /* Standard HID disconnect
> > +        * Intr channel must be disconnected before ctrl channel, so only
> > +        * disconnect intr here, ctrl is disconnected in intr_watch_cb.
> > +        */
> > +       if (idev->intr_io) {
> > +               sock = g_io_channel_unix_get_fd(idev->intr_io);
> > +               shutdown(sock, SHUT_WR);
> > +       }
> >
> >         if (idev->uhid)
> >                 return 0;
> > --
> > 2.27.0.278.ge193c7cf3a9-goog
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
