Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CAC38A29
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 21:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB81121841
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 21:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ug98DiMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDQVDS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgDQVDS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 17:03:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509FC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 14:03:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so3458523ljn.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shCVvUCygo6J9nr+MnC+tpq/t7YaApzC1zkRpvi41hY=;
        b=ug98DiMjqD9lF3S56pOuYnFfkbGHEcgDPsaS04PRCOuB79wmBYqTipBGIYIADplZ3I
         OX4qWgiErowqCy+XiC+Lc+E68rzHK0ud0Aqq2TG0fPYAOwL+nWmkta8GkCHo8p7VyG8/
         sfP/P0z2dZN6foh9jzpEPpf4/qrI2nhN4YUlXGJe+ywbfxkIG+VEUPq262bflqYCF/uv
         EFi3QABH2+MoLneUQEQckn/++E8yNu2h8NpnA784LuINVytcMctNTqSk9xJ8FRBgWRnr
         Xyr9+HH+IRkzP6FzrSWf2z+RCzWYjhIuJlXDrIl4RpaNbGiR7vgoudTDQlQhqFfSE0PX
         eLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shCVvUCygo6J9nr+MnC+tpq/t7YaApzC1zkRpvi41hY=;
        b=hAY6lztvwk+lbFIl/pVGr2QeLKzfYHQKhOj+3drMc8B30w8GDeomtvOSeFSI5Rvy+t
         JFfKgmVvlLNgHR5PYZDclRiagyN9Jr7lCX1qJYlAKEH2lpl4VEensWbHeOkNgAwXhsjG
         fkOQ9Hc2VJLlSs15rX3FrG5YICQHxntRRQbBXhtfFsekzZ8ZxwUP2//Udbh3kYvXaqhz
         0Xl3mwvjTGhuLmZHfHZsTq9W8iRNBdeMm+mn/fo2c5DjW+9gpWqHLl8ux/N8NyuBUGJ9
         vsLyY/u83t1f2PeFPWDfXwbLGuxiffwFRqz5Hf54f7hsHPP/fV9AffiwmQAY+VgvBQE+
         vong==
X-Gm-Message-State: AGi0PubLk548xqYK+MMDwxpc3ktI/Yy/Cgrfk4zJt4ZqetTU7sqoq4Gk
        fNTggfE5bpJlpR9WP6wm8ACkoBnPa7818YrjREZq70rNfbY=
X-Google-Smtp-Source: APiQypLlzCzUae4oXVN0JLlZGbFcTa9sYiY85pwSDURCtggmP8P6uktOovNEibgaRyJvh3JJwr1e6joBNVuHXnYMflo=
X-Received: by 2002:a2e:8290:: with SMTP id y16mr3315796ljg.186.1587157395638;
 Fri, 17 Apr 2020 14:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
 <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com> <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 17 Apr 2020 17:03:04 -0400
Message-ID: <CALWDO_Ux+=YtWsvnNxwpO7W_PSbAmUukyh6MHUoBqStNF7qC2Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Apr 17, 2020 at 4:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Fri, Apr 17, 2020 at 11:22 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > On Fri, Apr 17, 2020 at 2:16 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Alain,
> > >
> > > On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> > > >
> > > > HI Luiz,
> > > >
> > > > On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > > >>
> > > >> Hi Alain,
> > > >>
> > > >> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
> > > >> >
> > > >> > Friendly ping on this series.
> > > >> >
> > > >> >
> > > >> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
> > > >> > >
> > > >> > > This change adds an adapter Api to report the controller's
> > > >> > > widebandspeech enabled state.
> > > >>
> > > >> I wonder if this shouldn't be queried over SCO socket, or simple fail
> > > >> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
> > > >> normally used when using mSBC.
> > > >
> > > > I think there is value in both.
> > >
> > > Can you expand on that? I think this might generate confusion if the
> > > property indicates support for it but HFP implementation don't support
> > > it, since the later is usually implemented as a external profile so we
> > > don't have the features it may support, or perhaps the intention here
> > > is to actually indicate when it is in use?
> >
> > This is a signal that the adapter supports it and has everything
> > enabled to support it.   Driver indicated it supports it and erroneous
> > data reporting was enabled.  The profile has it's own state which may
> > indicate if msbc will be used, but this will be on a per connection
> > basis and is independent from this adapter property.
> >
> > The value in this property is to support diagnostic UX about
> > controller capabilities/state and also allow profiles that are
> > implemented outside of bluetoothd to see which codec it can attempt to
> > negotiate with the device.
>
> For diagnosic I think we would be better off with some dedicated
> interface to query this, as for the later the information we are
> giving does not actually tell anything about the codec support, which
> was part of my original argument that for the likes of HFP and other
> profiles using it it might not be enough and they still need to use
> BT_VOICE in order to enable the use of custom codecs, if you take
> ofono for example it does implement support for wideband speech
> already and it would completely disregard this property which can give
> the false impression that wideband speech cannot be activated when in
> fact it can, it just don't have erroneous data reporting enable, so
> perhaps we should indicate the actual adapter feature (e.g.
> ErrnoneousDataReporting) not the profile feature here, so the profile
> implementation can check weather this would disable use of wideband
> speech or not, futhermore we should probably report the errors back to
> the SCO socket or is that just for diagnostic and cannot be used to
> adjust the streaming?

My original patch actually had this MGMT feature called erroneous data
reporting and Marcel argued against it.  If you both agree, then I'm
happy to rename all of this to erroneous data reporting.  We'd still
need some way for the driver support to be messaged some other way
though. see:

if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
        set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);


> > >
> > >
> > > >>
> > > >>
> > > >> > > ---
> > > >> > >
> > > >> > >  doc/adapter-api.txt | 8 ++++++++
> > > >> > >  1 file changed, 8 insertions(+)
> > > >> > >
> > > >> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > >> > > index acae032d9..d8865e795 100644
> > > >> > > --- a/doc/adapter-api.txt
> > > >> > > +++ b/doc/adapter-api.txt
> > > >> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
> > > >> > >
> > > >> > >                         Local Device ID information in modalias format
> > > >> > >                         used by the kernel and udev.
> > > >> > > +
> > > >> > > +               boolean WidebandSpeechEnabled [readonly]
> > > >> > > +
> > > >> > > +                       Returns true if the adapter's wideband speech feature is
> > > >> > > +                       supported and enabled.
> > > >>
> > > >> There seems to be some extra empty lines here.
> > > >
> > > > ACK, will fix.
> > > >>
> > > >>
> > > >> > > +
> > > >> > > +
> > > >> > > +
> > > >> > > --
> > > >> > > 2.26.0.292.g33ef6b2f38-goog
> > > >> > >
> > > >>
> > > >>
> > > >>
> > > >> --
> > > >> Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
