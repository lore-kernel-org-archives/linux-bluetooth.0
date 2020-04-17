Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F86C2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCE420771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXhT8cLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgDQSWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730256AbgDQSWJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 14:22:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC0C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 11:22:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so2996344ljp.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXUuym8HjhBlWMO2UDeRgNNc/J05h1vHXtwkyKY9AOo=;
        b=bXhT8cLNGS7l+W/adHrJce3xM5EKctlFC/BEDtDVVjPngmmiJlqb7ThBRixGpxqceX
         +1Pdj8El2DjNE7MVB8eyF+BlIWzTNJJ9Ulf+4XyW6htOEWpO57vE1Gn95EL75QgoUaGP
         ZOgIN4XcP/Uf2YiQAdGu3Rk4PwgAYFbTgmAQ70Z7V32ZXAkAIqwzpnKlDgFsAb71/kzM
         PJrMn4qL6rie/1GUmaTVq/+9NKaiv5vr9skAI+u/2EeT2pfA5oKC2pEVyW9/uZ3GpwvE
         fkaATQBfncs+wAXNVYxwIpfqgPOIXJgePl3tvEKMem1k6wzni4X0ZC0EVz9HQp/9bMIT
         tQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXUuym8HjhBlWMO2UDeRgNNc/J05h1vHXtwkyKY9AOo=;
        b=q9RaIA3zgG+oJGRRGzPzQXRKdK7O6VT48HJnY88XI8DZJJLQFVW+P+hhUTW2XirxOz
         BaM9U53RWPGmuycrW3NPt8IZ1iq+03woPAtrPKi+Sn20LSDGR1he5PcKGgjzHJ69da2H
         bTAJNM5MuezcTXMU3h1AQ1qBELgAZZperKB5m6iY56q1jsn3GGtYa2eBwS64gPRSfKZA
         Rp07FzIqtCp85yzv0TPzp4gizLj06e0O/STrM2q4Hs53Lbm6ELY/3r6TVgTVnX457BH5
         D57ZjCj6EpeIfPuk/XrK/tzlDZ5hJAYLbvXuCjSXWuGuYTGGUelQb6mzsZ4RPcP3wi8w
         h6TA==
X-Gm-Message-State: AGi0Puau8a+5ykRVpqI2fzKeIws2Xz6O6Uo4XCwrf/6wM/vu3Gspz2uY
        QgqexV4T7s6Kw4CLmhc9+vP4E+V9bA7Rd5ztvLKMIQ==
X-Google-Smtp-Source: APiQypK62stJp728ZQrZT6BAyPw5x9ds9A0wqJNcd/ETCiR1tKRJtgl9WuWahxmnv4Mg3wWjqb2STn4sSSmlF1oy8E0=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2910561ljp.277.1587147726493;
 Fri, 17 Apr 2020 11:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com> <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
In-Reply-To: <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 17 Apr 2020 14:21:54 -0400
Message-ID: <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Apr 17, 2020 at 2:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > HI Luiz,
> >
> > On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Alain,
> >>
> >> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
> >> >
> >> > Friendly ping on this series.
> >> >
> >> >
> >> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
> >> > >
> >> > > This change adds an adapter Api to report the controller's
> >> > > widebandspeech enabled state.
> >>
> >> I wonder if this shouldn't be queried over SCO socket, or simple fail
> >> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
> >> normally used when using mSBC.
> >
> > I think there is value in both.
>
> Can you expand on that? I think this might generate confusion if the
> property indicates support for it but HFP implementation don't support
> it, since the later is usually implemented as a external profile so we
> don't have the features it may support, or perhaps the intention here
> is to actually indicate when it is in use?

This is a signal that the adapter supports it and has everything
enabled to support it.   Driver indicated it supports it and erroneous
data reporting was enabled.  The profile has it's own state which may
indicate if msbc will be used, but this will be on a per connection
basis and is independent from this adapter property.

The value in this property is to support diagnostic UX about
controller capabilities/state and also allow profiles that are
implemented outside of bluetoothd to see which codec it can attempt to
negotiate with the device.

>
>
> >>
> >>
> >> > > ---
> >> > >
> >> > >  doc/adapter-api.txt | 8 ++++++++
> >> > >  1 file changed, 8 insertions(+)
> >> > >
> >> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> >> > > index acae032d9..d8865e795 100644
> >> > > --- a/doc/adapter-api.txt
> >> > > +++ b/doc/adapter-api.txt
> >> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
> >> > >
> >> > >                         Local Device ID information in modalias format
> >> > >                         used by the kernel and udev.
> >> > > +
> >> > > +               boolean WidebandSpeechEnabled [readonly]
> >> > > +
> >> > > +                       Returns true if the adapter's wideband speech feature is
> >> > > +                       supported and enabled.
> >>
> >> There seems to be some extra empty lines here.
> >
> > ACK, will fix.
> >>
> >>
> >> > > +
> >> > > +
> >> > > +
> >> > > --
> >> > > 2.26.0.292.g33ef6b2f38-goog
> >> > >
> >>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
