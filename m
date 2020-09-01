Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEFC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43C8208CA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9nkLnJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIAFdg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAFde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 01:33:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EFEC061290
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:33:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so4193467wrn.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMSYJRKXJ9UZBEBmYlNcCrdjo4Oyld9VegMp+OutfRo=;
        b=O9nkLnJ/gKybOEyH2OCtKD//i4X4q1TQtxp8fYyNYU/UoMGo/0DJkhAyYNuBAokYA8
         iLeFBXreBn4Bs3xsKAEViX8n6qPFU/1noOFABd+BXwdRMISaTiL+q+9Z2byZJrdda0/K
         5rADqfxLbDchJZ25N/3jIFZvlQQHUEElOjYPRIB73q8ZhKhIpAosZrgQ7gOtJ9gSOPjh
         5kAPYbd9V5FDQ0y1K02pBb2leeY72UWepiuijWVOHA/ettLZ2Kyfd9DOm+GG4yRBmbtU
         N0K9pSRYeN2vstDnqY5o9j1v7rmyjSsAsM3r2wZqGKmKfPc9wqH4pTYDWSmJpLbNtzSO
         tCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMSYJRKXJ9UZBEBmYlNcCrdjo4Oyld9VegMp+OutfRo=;
        b=FNpFmc91pZ6BJ5vzMOJkO4IxKfPK78TskeP/AYqkao0i9JLvz1bgB+jeTIG3at4Lwo
         kvhNEC7ioPfIIO/egPGLnw2WvLSQW8pg+SbbUNidkQ8WESVtz678TfCJ5wOs685bWFXD
         l+oIHedWcYC4bXEQkT1SJxEDZTtrY1bcMq77vbUtKQofRXUkkBtvoS8mJH6P8X4poZE2
         jqUNoYUAiUxKOvDEwgj566SYR9lncZPLyZ1TAHCBNYO9dHquobvK3BSkImjDejN2ZRAk
         eWofDC3+OVKK3/p5wP6+UTubeaHaRzowFEBZD6/17H+b+yTZb9T/IjRiKTT5eDf7uQkP
         VEGQ==
X-Gm-Message-State: AOAM532tWpLiv1Ys/tt4wQDMkHjCTdCfqsPCkXBp22S0LnmEpesIwWZy
        P7zSoUpd4ti8I188NWV1uWAo0kBuu3dKe3SjJztUVw==
X-Google-Smtp-Source: ABdhPJyJCsIWhtCFHfQsD8IbGIEuiKctTELgpEuGwMGzbZFrNsZbuqH6dlJdqjKzzdchJyfaJjBX2VnuwJkzPRh5MJw=
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr4560635wrr.406.1598938411019;
 Mon, 31 Aug 2020 22:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
 <CABBYNZ+Q84vmEDgfNuoYXAAMi6T3segO_hSkG5Oufc5F_w9Qeg@mail.gmail.com>
 <CAJQfnxHyzFAG6zJfsuneLX_rW8yNkd2ZpKotHu3DV6vZABT-qw@mail.gmail.com> <CABBYNZJ4Y-U1nvyBvFwUXf+c0uT-42pBbrNtBG_G4RhLXGYspw@mail.gmail.com>
In-Reply-To: <CABBYNZJ4Y-U1nvyBvFwUXf+c0uT-42pBbrNtBG_G4RhLXGYspw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 1 Sep 2020 13:33:19 +0800
Message-ID: <CAJQfnxEauZcut7yr85X7gTRzr7qo3BrBzXG+wHe=74c5c3sCig@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/media-api: Add Press method for MediaPlayer1
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 1 Sep 2020 at 13:20, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Aug 31, 2020 at 8:19 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > The reason we introduced this method is because we need to send some
> > of AVRCP category 2 passthroughs in order to be able to qualify the
> > AVRCP absolute volume control as an audio source, despite we don't
> > actually plan to send any passthrough in the practice.
>
> I wonder what those are, are they volume up/down?
Yes, volume up/down and mute are the ones that are unique to category
2, but there are also some other buttons which are included in
category 2 as well but not unique to it, for example button 0 - 9,
help, and power.

>
> > Therefore, which passthrough we send is actually not important (to
> > us), as long as we can do that to satisfy the requirement.
> > However, I see that there are over 50 passthroughs across category 1 -
> > 4, and thought that it would be cumbersome to have a different method
> > for each key if one day we decided to support them all, hence the
> > generic method.
>
> Yep, but there are button presses so things gets a little more
> complicated if we need to emulate press/hold/release semantics.
For now, I don't think having a separate method for each key will make
it easier if we need to emulate hold and release semantics.

Could we have 3 methods as follows, all have avc_key as a param:
(a) press. This means BlueZ will auto-release it within a short amount of time
(b) hold. Bluez wouldn't release it unless it received (c).
(c) release. Bluez will release the previously held button.
What do you think?
>
> > May I have some questions?
> > (1) Why do you prefer a dedicated method per key?
> > (2) Let's say I need to add a dedicated method for a single category 2
> > passthrough key, do you have a key in mind or I can just pick by
> > myself?
> >
> > Thanks,
> > Archie
> >
> >
> > On Tue, 1 Sep 2020 at 01:16, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Mon, Aug 31, 2020 at 12:37 AM Archie Pusaka <apusaka@google.com> wrote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > This allows us to send any passthrough command.
> > > >
> > > > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > > > ---
> > > >
> > > >  doc/media-api.txt | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > index dabc69936..fe7222eef 100644
> > > > --- a/doc/media-api.txt
> > > > +++ b/doc/media-api.txt
> > > > @@ -199,6 +199,14 @@ Methods            void Play()
> > > >                         Possible Errors: org.bluez.Error.NotSupported
> > > >                                          org.bluez.Error.Failed
> > > >
> > > > +               void Press(byte avc_key)
> > > > +
> > > > +                       Press a specific key to send as passthrough command.
> > > > +
> > > > +                       Possible Errors: org.bluez.Error.InvalidArguments
> > > > +                                        org.bluez.Error.NotSupported
> > > > +                                        org.bluez.Error.Failed
> > > > +
> > > >  Properties     string Equalizer [readwrite]
> > > >
> > > >                         Possible values: "off" or "on"
> > > > --
> > > > 2.28.0.402.g5ffc5be6b7-goog
> > >
> > > For now I would prefer to use dedicated method per key or are there
> > > many keys you would like to use from the upper layer?
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
