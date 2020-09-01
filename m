Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF8C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 06:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F7B2087D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 06:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRbuGe3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAGab (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAGaa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 02:30:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69BC0612AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 23:30:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w13so147155wrk.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KJa7N0SPprWWdeB0qM0vnAJ/YjYjm3MX1q2sMQWlFc=;
        b=cRbuGe3iuJsEK97eRI7QEMrlRxkqxyrjq6Gt0GjU51yzd1QhXZAUMLB2cAHBydM33E
         PAk4uUNirHUW29fy+HmrVpMX5zPeHep0vT6LrJufTgWYNi8qH1Aj68B/+MWyU+ai0GMh
         kp46R2GrRiiKh7im++sW6rMWWObQVo5jd2hPK6+AcXB8sdaZQEFPQxXlnCvODd3dXoff
         PMbj0HAxW6zOJrpqxF93KqevZDhlmpUjP57Ypbi0Mp4hlDzHzaxhGyYy4pmg0ImX7C+w
         pBs7vHSkY9Hf3ToTRfjKhsUucXhgm3Ml6GP20jFS0aO2hDbFWPm1Z/330VGVvxOqszx9
         LLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KJa7N0SPprWWdeB0qM0vnAJ/YjYjm3MX1q2sMQWlFc=;
        b=lvIYbIi29KDIH3ERm6PnGBzhpWdfIH7hlhYEj/IFd09vvpMfzWCXj2WKF1zxRqVScQ
         PQDlJQaSQjHSy1ElshsOyItu3r2cNINmQp441+NmTf7Atec/5oQhYvNik1MYYN/1hfss
         4mwC0E3zhg7AuliogI7HMm5bUwpDcS7VQUyfVagIfL9WqmkHRtHf3k9YcYORAUHnVzAE
         a3+ElbK9wW+d+We4FSTmYbttb7xBliaeDpHifseu6WIpaAaiLDcTn22Tf2fwX2WzzZbX
         8tmB2aeP3ao3BpHkNmE5q4ls/iSHQ1nKveE1CFBAsWGKcM0lKQdGeb9oFEBnIe2XPX3N
         d7mg==
X-Gm-Message-State: AOAM533J7jADM/hhw71lr/s9bCIBEChM/7KrO6KwXIBYOKymNEbdb30n
        SBDD3Rz8Mmkxv5/mbdrgcpSoCXLAoTqC8kuzkcyqFcmjwkk=
X-Google-Smtp-Source: ABdhPJyQZvwz4WuMjEEeVEjjHsFGtNCqCty5CPPFQnUer2Q2ogSbxvk5fYo0PxPwVcDzO2RKT2fdbgzHO2WoSE78xDQ=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr134986wrm.120.1598941828405;
 Mon, 31 Aug 2020 23:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
 <CABBYNZ+Q84vmEDgfNuoYXAAMi6T3segO_hSkG5Oufc5F_w9Qeg@mail.gmail.com>
 <CAJQfnxHyzFAG6zJfsuneLX_rW8yNkd2ZpKotHu3DV6vZABT-qw@mail.gmail.com>
 <CABBYNZJ4Y-U1nvyBvFwUXf+c0uT-42pBbrNtBG_G4RhLXGYspw@mail.gmail.com>
 <CAJQfnxEauZcut7yr85X7gTRzr7qo3BrBzXG+wHe=74c5c3sCig@mail.gmail.com> <CABBYNZL=NfVk3zo9C8g-Urbztx2LKWG28=4qWNbBW+KhJJh=Jw@mail.gmail.com>
In-Reply-To: <CABBYNZL=NfVk3zo9C8g-Urbztx2LKWG28=4qWNbBW+KhJJh=Jw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 1 Sep 2020 14:30:17 +0800
Message-ID: <CAJQfnxGGmRSWZgvx8VLrTO9KV5hysLjgXMK1ONKCTQKYrQ1uLA@mail.gmail.com>
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

On Tue, 1 Sep 2020 at 13:42, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Aug 31, 2020 at 10:33 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, 1 Sep 2020 at 13:20, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Mon, Aug 31, 2020 at 8:19 PM Archie Pusaka <apusaka@google.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > The reason we introduced this method is because we need to send some
> > > > of AVRCP category 2 passthroughs in order to be able to qualify the
> > > > AVRCP absolute volume control as an audio source, despite we don't
> > > > actually plan to send any passthrough in the practice.
> > >
> > > I wonder what those are, are they volume up/down?
> > Yes, volume up/down and mute are the ones that are unique to category
> > 2, but there are also some other buttons which are included in
> > category 2 as well but not unique to it, for example button 0 - 9,
> > help, and power.
>
> Weird, there are dedicated commands for setting absolut volume, not
> sure why one would use volume up/down to qualify? Or is that testing
> any button that belongs to category 2? Anyway it would be nice to know
> what test that is and what is the expected behavior the test case
> expects from us.

Weird, yes. Sending absolute volume command capability is declared in
the AVRCP ICS 2/50, but it can only be selected if 2/8 is also
selected, which is sending passthrough command for category 2.
Therefore, we also need to be able to send a category 2 passthrough.

The test itself is AVRCP/CT/PTT/BV-02-I. This is the test to see
whether we can send a category 2 passthrough, not the one to see
whether we can send the absolute volume command. The test asks us to
send every category 2 passthrough we declared in the ICS file (table
4). There should be at least one passthrough declared.

>
> >
> > >
> > > > Therefore, which passthrough we send is actually not important (to
> > > > us), as long as we can do that to satisfy the requirement.
> > > > However, I see that there are over 50 passthroughs across category 1 -
> > > > 4, and thought that it would be cumbersome to have a different method
> > > > for each key if one day we decided to support them all, hence the
> > > > generic method.
> > >
> > > Yep, but there are button presses so things gets a little more
> > > complicated if we need to emulate press/hold/release semantics.
> > For now, I don't think having a separate method for each key will make
> > it easier if we need to emulate hold and release semantics.
> >
> > Could we have 3 methods as follows, all have avc_key as a param:
> > (a) press. This means BlueZ will auto-release it within a short amount of time
> > (b) hold. Bluez wouldn't release it unless it received (c).
> > (c) release. Bluez will release the previously held button.
> > What do you think?
>
> I'm fine with that, we might have to start the status of each request
> though, also the holding should not last longer than 2 seconds if I
> recall correctly.

Then I shall try to have this implemented.
Btw I only took a quick glance, but I did not find the 2 seconds
limitation in the spec.

>
> > >
> > > > May I have some questions?
> > > > (1) Why do you prefer a dedicated method per key?
> > > > (2) Let's say I need to add a dedicated method for a single category 2
> > > > passthrough key, do you have a key in mind or I can just pick by
> > > > myself?
> > > >
> > > > Thanks,
> > > > Archie
> > > >
> > > >
> > > > On Tue, 1 Sep 2020 at 01:16, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Archie,
> > > > >
> > > > > On Mon, Aug 31, 2020 at 12:37 AM Archie Pusaka <apusaka@google.com> wrote:
> > > > > >
> > > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > > >
> > > > > > This allows us to send any passthrough command.
> > > > > >
> > > > > > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > > > > > ---
> > > > > >
> > > > > >  doc/media-api.txt | 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > index dabc69936..fe7222eef 100644
> > > > > > --- a/doc/media-api.txt
> > > > > > +++ b/doc/media-api.txt
> > > > > > @@ -199,6 +199,14 @@ Methods            void Play()
> > > > > >                         Possible Errors: org.bluez.Error.NotSupported
> > > > > >                                          org.bluez.Error.Failed
> > > > > >
> > > > > > +               void Press(byte avc_key)
> > > > > > +
> > > > > > +                       Press a specific key to send as passthrough command.
> > > > > > +
> > > > > > +                       Possible Errors: org.bluez.Error.InvalidArguments
> > > > > > +                                        org.bluez.Error.NotSupported
> > > > > > +                                        org.bluez.Error.Failed
> > > > > > +
> > > > > >  Properties     string Equalizer [readwrite]
> > > > > >
> > > > > >                         Possible values: "off" or "on"
> > > > > > --
> > > > > > 2.28.0.402.g5ffc5be6b7-goog
> > > > >
> > > > > For now I would prefer to use dedicated method per key or are there
> > > > > many keys you would like to use from the upper layer?
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Archie
>
>
>
> --
> Luiz Augusto von Dentz
