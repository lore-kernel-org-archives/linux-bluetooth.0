Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9DCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D21208CA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWOLS2Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIAFm2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFm0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 01:42:26 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3DC0612A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:42:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 109so164885otv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toz6DlAhhEzITefjqP2fJc0hANXyinkwDVinSBQ0LU0=;
        b=sWOLS2OvG7Vd7GfI/cLGuJsGZwHxzTPLNuJdtRuJx0TSy0sHyDQZmTejFip0ioCMgo
         CHT3rlCZOeK/eLUv5YQUAdVADlFyKiHBkGhXiNopeZL6tI0UySdJtkyV1xuJPoK7WCdj
         O4VytazIr+jsuSFtAfq41UsfIE162ilzbDyhkOJQCeI1CFfrNfFPIBY6dSg2IIqoG14A
         onOB4ejVY2P2i7zQpKFBBf9U8FM/66woRquVhRCRbU2iwinn4cKoJZCqgUO84QOwiCRa
         SoB3E1z2HiOIBVWjrD31DLyxJR0rOLXdaERucHzTg2Zl3NkhTahsqqT7pSU+2Z/GBntJ
         Z5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toz6DlAhhEzITefjqP2fJc0hANXyinkwDVinSBQ0LU0=;
        b=jESi9ITutEyAlW+SjZw3yU0V+Cln6XszlGOLn3h3WMGkmWHBWmR6npY+bYLpO9mxQP
         LAF0YRRbMxL02/oEuJ8KlqN+i+YqCQoUlTt/k3JX3Z+NP9ZEk+dLQbv0rJpNuRRIiRjP
         Oq1/xRo2PUVdSAl1xBxirdoAEmi3ELH2VBlCFkYgedGyw5JbltVDMiu3RIWnnom72j8g
         ICXp1ddYjixKYzi6GMkMlt3ZGJ814DdA0SahpruGgWUIoCyQuN1K6o/C8KO0lejuajSH
         4XQdW2CKTfjAJYSTzav8F3rbnpMHQpp4dS9jlzQR2ZFHtLsjZFZBIYa5PhsBkmYwyfGV
         k2YQ==
X-Gm-Message-State: AOAM532iIbK27NJ2XWZwagbwmcUVu3pglMYWpSooZNByf6LUAKz0EmlZ
        PTBDMBJ+kjKIodfhV5I/u2EGqU+gPEz53cfhq0NmHOHh
X-Google-Smtp-Source: ABdhPJy63B/T2QI+EakCQqxZiWhnS4dX1/B6Gjxe/fE8bv/8BQ8nI3Jvxfw1klc6XjELYVgQtK4sWj104KktGbCR8NU=
X-Received: by 2002:a9d:429:: with SMTP id 38mr235452otc.88.1598938945514;
 Mon, 31 Aug 2020 22:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
 <CABBYNZ+Q84vmEDgfNuoYXAAMi6T3segO_hSkG5Oufc5F_w9Qeg@mail.gmail.com>
 <CAJQfnxHyzFAG6zJfsuneLX_rW8yNkd2ZpKotHu3DV6vZABT-qw@mail.gmail.com>
 <CABBYNZJ4Y-U1nvyBvFwUXf+c0uT-42pBbrNtBG_G4RhLXGYspw@mail.gmail.com> <CAJQfnxEauZcut7yr85X7gTRzr7qo3BrBzXG+wHe=74c5c3sCig@mail.gmail.com>
In-Reply-To: <CAJQfnxEauZcut7yr85X7gTRzr7qo3BrBzXG+wHe=74c5c3sCig@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 22:42:15 -0700
Message-ID: <CABBYNZL=NfVk3zo9C8g-Urbztx2LKWG28=4qWNbBW+KhJJh=Jw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/media-api: Add Press method for MediaPlayer1
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 31, 2020 at 10:33 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> On Tue, 1 Sep 2020 at 13:20, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Mon, Aug 31, 2020 at 8:19 PM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > The reason we introduced this method is because we need to send some
> > > of AVRCP category 2 passthroughs in order to be able to qualify the
> > > AVRCP absolute volume control as an audio source, despite we don't
> > > actually plan to send any passthrough in the practice.
> >
> > I wonder what those are, are they volume up/down?
> Yes, volume up/down and mute are the ones that are unique to category
> 2, but there are also some other buttons which are included in
> category 2 as well but not unique to it, for example button 0 - 9,
> help, and power.

Weird, there are dedicated commands for setting absolut volume, not
sure why one would use volume up/down to qualify? Or is that testing
any button that belongs to category 2? Anyway it would be nice to know
what test that is and what is the expected behavior the test case
expects from us.

>
> >
> > > Therefore, which passthrough we send is actually not important (to
> > > us), as long as we can do that to satisfy the requirement.
> > > However, I see that there are over 50 passthroughs across category 1 -
> > > 4, and thought that it would be cumbersome to have a different method
> > > for each key if one day we decided to support them all, hence the
> > > generic method.
> >
> > Yep, but there are button presses so things gets a little more
> > complicated if we need to emulate press/hold/release semantics.
> For now, I don't think having a separate method for each key will make
> it easier if we need to emulate hold and release semantics.
>
> Could we have 3 methods as follows, all have avc_key as a param:
> (a) press. This means BlueZ will auto-release it within a short amount of time
> (b) hold. Bluez wouldn't release it unless it received (c).
> (c) release. Bluez will release the previously held button.
> What do you think?

I'm fine with that, we might have to start the status of each request
though, also the holding should not last longer than 2 seconds if I
recall correctly.

> >
> > > May I have some questions?
> > > (1) Why do you prefer a dedicated method per key?
> > > (2) Let's say I need to add a dedicated method for a single category 2
> > > passthrough key, do you have a key in mind or I can just pick by
> > > myself?
> > >
> > > Thanks,
> > > Archie
> > >
> > >
> > > On Tue, 1 Sep 2020 at 01:16, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Mon, Aug 31, 2020 at 12:37 AM Archie Pusaka <apusaka@google.com> wrote:
> > > > >
> > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > >
> > > > > This allows us to send any passthrough command.
> > > > >
> > > > > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > > > > ---
> > > > >
> > > > >  doc/media-api.txt | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > index dabc69936..fe7222eef 100644
> > > > > --- a/doc/media-api.txt
> > > > > +++ b/doc/media-api.txt
> > > > > @@ -199,6 +199,14 @@ Methods            void Play()
> > > > >                         Possible Errors: org.bluez.Error.NotSupported
> > > > >                                          org.bluez.Error.Failed
> > > > >
> > > > > +               void Press(byte avc_key)
> > > > > +
> > > > > +                       Press a specific key to send as passthrough command.
> > > > > +
> > > > > +                       Possible Errors: org.bluez.Error.InvalidArguments
> > > > > +                                        org.bluez.Error.NotSupported
> > > > > +                                        org.bluez.Error.Failed
> > > > > +
> > > > >  Properties     string Equalizer [readwrite]
> > > > >
> > > > >                         Possible values: "off" or "on"
> > > > > --
> > > > > 2.28.0.402.g5ffc5be6b7-goog
> > > >
> > > > For now I would prefer to use dedicated method per key or are there
> > > > many keys you would like to use from the upper layer?
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie



-- 
Luiz Augusto von Dentz
