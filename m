Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A696C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 21:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F2920738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3cjS5SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCQVbY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:31:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34004 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgCQVbY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 17:31:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so23342939otl.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2020 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPvFEGqI9mQfsI11OXNvHEax6/EWC7cYKUYPPbuRuNc=;
        b=G3cjS5SQyh+SIE9K+C2ZISwdXjUafqtw835Q1wkiVVhkmfM2uVxybVugh+1Jp4Bhxt
         dn1xXTvFPQb/kg6XIPST/RG7J+Mbidivx5iV1tx25vER9gDW9/KvQmilaz7L4U8bFBUQ
         Kx623N1BCsuHJ688zbh6Oca+cuFHyZXMcH5V3Jr4uaQXYtkl+LB1Zdtyd68nbCu4m1vW
         h9X4iRqZ25krCp27O4SUat0yFHA0x6qN/Ugn68g+qTfH7SfVWsGfzxF4H7xD2dEpYKMW
         lgA5DLZOEuTY63Z8NZuZaFziA2w8WHC38wqyu9aSiA2KXPwgVi9IDcSqwpEOPPoJEKN8
         28ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPvFEGqI9mQfsI11OXNvHEax6/EWC7cYKUYPPbuRuNc=;
        b=a8F0iVKOznS1aOHD1fMGdudV5NgmrHDmkHldG/n/ZBVBe4uNkI2o3nPzwbxOceFCwL
         HwdwFDEr/GKSSt/GyZvG8C8rXM6vrJK+a/1H3cEr+WtnS+2pzn6NM3bovP2po29vC1hQ
         4svyZKsgLmK3Jewm/ZHjTyIek1DIyafxrj4ESWzSXmzwtkAdH58x1mhcQkwU2v7W/Eb1
         HytYIaQ44XPrC921Dm3cwHTm8iz+h/TVtxfWO1gbMgAMF8LHDYRsvvUZuT2ibS+GyL+T
         bFFBdcW0052OOsYIfLxRWK+DkkgZU65mY7/F6KljfA/H5t8Rr0cw9GoVRCjmjlDJhXlS
         vcAw==
X-Gm-Message-State: ANhLgQ3uVvtaTx4YRdVl/21A1sElf5qi6PC9JXnBb8R/T5iR0JorPMlS
        FWMpuYgonXJiKdnK4YnMEfqkC2OhMBQsJtcFz81Raw==
X-Google-Smtp-Source: ADFU+vt4UzM37z9zbq7PL9IyM3kZo0DDeipLmO/d+IkSR4lJ0QZ++UWySKdw8CfUfBH2ZqaJUGwSA6O0gdfygOJ45b0=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr1103353otc.146.1584480683699;
 Tue, 17 Mar 2020 14:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com> <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
In-Reply-To: <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Mar 2020 14:31:11 -0700
Message-ID: <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Mar 16, 2020 at 11:53 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> Luckily you asked, because I found out that actually the patch didn't
> wait for the disconnection response for any case. It does delay the
> disconnection of the ctrl channel slightly though, but that doesn't
> guarantee a proper order of disconnection. Therefore, as of now, this
> patch is not fixing anything.
>
> Digging more into this matter, I found out by removing this condition
> (sk->sk_shutdown == SHUTDOWN_MASK) in [1], it makes intr_watch_cb()
> called after truly receiving the interrupt disconnection response.
> However, I haven't checked whether removal of such condition will
> break other things.
> Do you have any suggestions?

I see, we shutdown the socket immediately since the socket API itself
don't seem to have a concept of disconnect syscall not sure if other
values could be passed to shutdown second parameter to indicate we
want to actually wait it to be disconnected.

> With this patch and removal of that condition, I confirm that it works
> with situations where the device is being removed and/or just being
> disconnected. It also works with virtual cable unplug when UHID is
> used.
> * Virtual cable unplug has another problem which doesn't adhere to the
> specs, but it is unrelated to disconnection.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/af_bluetooth.c#n470
>
> Thanks,
> Archie
>
> On Tue, 17 Mar 2020 at 04:58, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Sun, Mar 15, 2020 at 9:40 PM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > According to bluetooth HID Profile spec Ver 1.0, section 7.2.2, A
> > > host or device shall always complete the disconnection of the
> > > interrupt channel before disconnecting the control channel.
> > > However, the current implementation disconnects them both
> > > simultaneously.
> > >
> > > This patch postpone the disconnection of control channel to the
> > > callback of interrupt watch, which shall be called upon receiving
> > > interrupt channel disconnection response.
> > > ---
> > >
> > >  profiles/input/device.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > > index 8ada1b4ff..8ef3714c9 100644
> > > --- a/profiles/input/device.c
> > > +++ b/profiles/input/device.c
> > > @@ -1010,14 +1010,19 @@ static bool is_connected(struct input_device *idev)
> > >
> > >  static int connection_disconnect(struct input_device *idev, uint32_t flags)
> > >  {
> > > +       int sock;
> > > +
> > >         if (!is_connected(idev))
> > >                 return -ENOTCONN;
> > >
> > > -       /* Standard HID disconnect */
> > > -       if (idev->intr_io)
> > > -               g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
> > > -       if (idev->ctrl_io)
> > > -               g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
> > > +       /* Standard HID disconnect
> > > +        * Intr channel must be disconnected before ctrl channel, so only
> > > +        * disconnect intr here, ctrl is disconnected in intr_watch_cb.
> > > +        */
> > > +       if (idev->intr_io) {
> > > +               sock = g_io_channel_unix_get_fd(idev->intr_io);
> > > +               shutdown(sock, SHUT_RDWR);
> > > +       }
> > >
> > >         if (idev->uhid)
> > >                 return 0;
> > > --
> > > 2.25.1.481.gfbce0eb801-goog
> >
> > Just to confirm, have you checked if this works with both situation
> > where the device is being removed or just being disconnected,
> > specially the case of HIDP_CTRL_VIRTUAL_CABLE_UNPLUG which perhaps was
> > not working before as well since we disconnect the ctrl channel before
> > transmitting it.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
