Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EFC10F29
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3275420724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0WfZGFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgCQGxI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:53:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37804 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgCQGxI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 02:53:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so20601930wme.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQJFThQABfvaCXGRaom/ZTc/xTYIP6obwBzxYLhhNQ0=;
        b=I0WfZGFoApAUjGvD6N6OPpsoRlcuYsIKcHG9jN0rQjwYCpKonPhs4M2+9cFR1igT0m
         qXiZjQtDUQAl8zNm9x0gfsVlt524WRYGNp4ONWKIjeuoikmftO+7HvxRR1MmEzh/+4lr
         5+jixtrqoK1SZWqm2zypUkXlxAoXPPz7wjJAVKNZ4odpnLLG4UZfLCX5j7bWFpDqltOM
         +09t4pDOTE4y6AEJal4c7qhmMDB5s8j4eBEjA2Y9yhyb8WHjBr/cA8IceAv1EODm303h
         Hx2GOmN2oEczjJzzzWPVQuwHAiF2oDvhOwzgtqSTBBpkOFv4T9Dvi56PIQJGd1icOwPV
         xUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQJFThQABfvaCXGRaom/ZTc/xTYIP6obwBzxYLhhNQ0=;
        b=cd+8yIYOELFtNxUPBJ0dLKqEKAkU8Q02vzztDqee4KjXMTVjz8uhqzlCDNvyMSwf4G
         ZRYQv7m/cTc+A4hz/tvkwJlBitr8067xg6LWlFs8lLjZWZcms4m8dKbyFlpyMmCebRoI
         t/xMzpa/F/JTEgOhwpa/Lpq43vTT/z2p0HDy6bzlkXpVHz7Cx4GzFfszXt+x5hncQ1j/
         eUN2vfXJN9kVhq4M0e9iFW7MGAK+/LvJmkQ/6ysAFJwPXJbzG0Zua6C3txudBWTi+at4
         9dpFPC3tNDMXsIksQlt5ke54wl5unwNKcDL4MhPboeX5TbJbNc+CSW+arbzj7G0DLi23
         RhVA==
X-Gm-Message-State: ANhLgQ0tF8T7b0ac/Gu+9Tc0gNeUqE0rjrJAn4IOAvLltMVdIQP2PJrT
        sehS2e7ueUAxNGc28X3r27ALdfNeIjz4FX+cWuiadE6xvSZFhQ==
X-Google-Smtp-Source: ADFU+vssGEKeVK6wNocQtEMxDmM4PpzMSah9tMTCHShJaCRvUCW+4A/4a7aDToAkuK0OgAbqj3T2l7iRybi2duAtPeg=
X-Received: by 2002:a7b:c391:: with SMTP id s17mr3491567wmj.55.1584427985365;
 Mon, 16 Mar 2020 23:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
In-Reply-To: <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 17 Mar 2020 14:52:54 +0800
Message-ID: <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Luckily you asked, because I found out that actually the patch didn't
wait for the disconnection response for any case. It does delay the
disconnection of the ctrl channel slightly though, but that doesn't
guarantee a proper order of disconnection. Therefore, as of now, this
patch is not fixing anything.

Digging more into this matter, I found out by removing this condition
(sk->sk_shutdown == SHUTDOWN_MASK) in [1], it makes intr_watch_cb()
called after truly receiving the interrupt disconnection response.
However, I haven't checked whether removal of such condition will
break other things.
Do you have any suggestions?

With this patch and removal of that condition, I confirm that it works
with situations where the device is being removed and/or just being
disconnected. It also works with virtual cable unplug when UHID is
used.
* Virtual cable unplug has another problem which doesn't adhere to the
specs, but it is unrelated to disconnection.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/af_bluetooth.c#n470

Thanks,
Archie

On Tue, 17 Mar 2020 at 04:58, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Mar 15, 2020 at 9:40 PM Archie Pusaka <apusaka@google.com> wrote:
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
> >  profiles/input/device.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index 8ada1b4ff..8ef3714c9 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -1010,14 +1010,19 @@ static bool is_connected(struct input_device *idev)
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
> > +               shutdown(sock, SHUT_RDWR);
> > +       }
> >
> >         if (idev->uhid)
> >                 return 0;
> > --
> > 2.25.1.481.gfbce0eb801-goog
>
> Just to confirm, have you checked if this works with both situation
> where the device is being removed or just being disconnected,
> specially the case of HIDP_CTRL_VIRTUAL_CABLE_UNPLUG which perhaps was
> not working before as well since we disconnect the ctrl channel before
> transmitting it.
>
> --
> Luiz Augusto von Dentz
