Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39EC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5892073A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHNG3ZpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgEFOKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgEFOKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 10:10:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600DC061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 07:10:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so2523630ljp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbwZ4r0pD7kFrVz9VwcR9OzSHWMeBGF3+0hoo6t/ztE=;
        b=FHNG3ZpOz27M3QbsjBJwzo2oUKAleunIUJE+lbDJh4EawFpXm5GJqhwes847/NLLWt
         wqUgE7LtvQlXesxfSExb5nBB3/Tq1eJaGxmWWCmELSm62dPIds4VY5tzktSWVgR9waaJ
         1IIHTWZHL+4+QH6nB+45sEi+58VbGTGLgOIBEduffFYK1O7JIQtFDdHQTAsxxJUQB7M1
         AQTNWAUwyJhYhyZ5V3k4EtR01YPWrxJ4INzfX/m2l63uoERL0UflSabxkQEd/iOj2NkV
         vKouIXjz5I1/5L5XwzxqEMgey0cXJVYHkGeI1T7n6mix3CMKMGN1w4IO6gmb4dLdGJ1K
         tsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbwZ4r0pD7kFrVz9VwcR9OzSHWMeBGF3+0hoo6t/ztE=;
        b=iGSaCpKl+g+SED0jyKJB8ww0xwQHDhW+an1fPxZTWQPyKHn+WCbZvvyHOK8ApL0Z6k
         5rmIU3RpYyQAd/GuQDDSbvXbAGmgJ3gLAdWWNe7xXkW1b9SMwt4shqql0QCWyb+VPLpU
         Yo+wVBtuYilr9XBEwSEApJztCwK7rndaSm1kEupid34ca9ulJ8IrFG/hsLgLzI7A4Kmq
         nYmikFdzrZS8WknmR+mN/yHbWuppittfk+s4xBFiQcOlN+tN5B3jHqiCxWxMQtBIbkaq
         P5btCwFjv6BwMxepc1LVJCkKsS0SnCh9uug3JyEF8F3zq3YoQXvYg3hJGwOv8coS/Ouu
         kItQ==
X-Gm-Message-State: AGi0PuaqmHoS+t/hDx3cI7s2MnzUPcBkQf0gC4OgwYjkeYvsvAisu8xx
        f7WtS8vmutW4omc4RKrsW1FyygL3WvUKvGOLbQQEgA==
X-Google-Smtp-Source: APiQypIpAYxa5GuWGpuJQ8aXAnK821MpMrGf/YRCZ1syE3wg3YEP+Bee0P/xWc9hTFiFH3UaM5HqVJngnCCLUNektcQ=
X-Received: by 2002:a2e:9c9a:: with SMTP id x26mr5234870lji.44.1588774251644;
 Wed, 06 May 2020 07:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
 <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
 <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
 <CALWDO_Ux+=YtWsvnNxwpO7W_PSbAmUukyh6MHUoBqStNF7qC2Q@mail.gmail.com>
 <CALWDO_UJtMpTmvWj6KsAJkwzDE=ZXA_bq2Cp2DR-gcBgvQT0cA@mail.gmail.com>
 <CALWDO_WpiztCRau98_eFegrCKNsK4VigKQhw7kvyzFgKLm3NZA@mail.gmail.com> <CABBYNZJq43bjTneJ9wsCpzfMWHOGdZyhBFTDfAZcYUWFCv5brQ@mail.gmail.com>
In-Reply-To: <CABBYNZJq43bjTneJ9wsCpzfMWHOGdZyhBFTDfAZcYUWFCv5brQ@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 6 May 2020 10:10:38 -0400
Message-ID: <CALWDO_XXb8riTsVfVTsYngYwY3u6sZeHDLP9Es8DnfBJfzgkGg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, May 5, 2020 at 7:48 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel and Alain,
>
> On Tue, May 5, 2020 at 8:47 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Friendly ping on this series.
> >
> >
> > On Tue, May 5, 2020 at 11:46 AM Alain Michaud <alainmichaud@google.com> wrote:
> > >
> > > Friendly ping on this series.
> > >
> > > On Fri, Apr 17, 2020 at 5:03 PM Alain Michaud <alainmichaud@google.com> wrote:
> > >>
> > >> On Fri, Apr 17, 2020 at 4:58 PM Luiz Augusto von Dentz
> > >> <luiz.dentz@gmail.com> wrote:
> > >> >
> > >> > Hi Alain,
> > >> >
> > >> > On Fri, Apr 17, 2020 at 11:22 AM Alain Michaud <alainmichaud@google.com> wrote:
> > >> > >
> > >> > > On Fri, Apr 17, 2020 at 2:16 PM Luiz Augusto von Dentz
> > >> > > <luiz.dentz@gmail.com> wrote:
> > >> > > >
> > >> > > > Hi Alain,
> > >> > > >
> > >> > > > On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> > >> > > > >
> > >> > > > > HI Luiz,
> > >> > > > >
> > >> > > > > On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > >> > > > >>
> > >> > > > >> Hi Alain,
> > >> > > > >>
> > >> > > > >> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
> > >> > > > >> >
> > >> > > > >> > Friendly ping on this series.
> > >> > > > >> >
> > >> > > > >> >
> > >> > > > >> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
> > >> > > > >> > >
> > >> > > > >> > > This change adds an adapter Api to report the controller's
> > >> > > > >> > > widebandspeech enabled state.
> > >> > > > >>
> > >> > > > >> I wonder if this shouldn't be queried over SCO socket, or simple fail
> > >> > > > >> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
> > >> > > > >> normally used when using mSBC.
> > >> > > > >
> > >> > > > > I think there is value in both.
> > >> > > >
> > >> > > > Can you expand on that? I think this might generate confusion if the
> > >> > > > property indicates support for it but HFP implementation don't support
> > >> > > > it, since the later is usually implemented as a external profile so we
> > >> > > > don't have the features it may support, or perhaps the intention here
> > >> > > > is to actually indicate when it is in use?
> > >> > >
> > >> > > This is a signal that the adapter supports it and has everything
> > >> > > enabled to support it.   Driver indicated it supports it and erroneous
> > >> > > data reporting was enabled.  The profile has it's own state which may
> > >> > > indicate if msbc will be used, but this will be on a per connection
> > >> > > basis and is independent from this adapter property.
> > >> > >
> > >> > > The value in this property is to support diagnostic UX about
> > >> > > controller capabilities/state and also allow profiles that are
> > >> > > implemented outside of bluetoothd to see which codec it can attempt to
> > >> > > negotiate with the device.
> > >> >
> > >> > For diagnosic I think we would be better off with some dedicated
> > >> > interface to query this, as for the later the information we are
> > >> > giving does not actually tell anything about the codec support, which
> > >> > was part of my original argument that for the likes of HFP and other
> > >> > profiles using it it might not be enough and they still need to use
> > >> > BT_VOICE in order to enable the use of custom codecs, if you take
> > >> > ofono for example it does implement support for wideband speech
> > >> > already and it would completely disregard this property which can give
> > >> > the false impression that wideband speech cannot be activated when in
> > >> > fact it can, it just don't have erroneous data reporting enable, so
> > >> > perhaps we should indicate the actual adapter feature (e.g.
> > >> > ErrnoneousDataReporting) not the profile feature here, so the profile
> > >> > implementation can check weather this would disable use of wideband
> > >> > speech or not, futhermore we should probably report the errors back to
> > >> > the SCO socket or is that just for diagnostic and cannot be used to
> > >> > adjust the streaming?
> > >>
> > >> My original patch actually had this MGMT feature called erroneous data
> > >> reporting and Marcel argued against it.  If you both agree, then I'm
> > >> happy to rename all of this to erroneous data reporting.  We'd still
> > >> need some way for the driver support to be messaged some other way
> > >> though. see:
> > >>
> > >> if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> > >>         set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>
> So this will get a little bit confusing if we don't have a HFP
> implementation that actually does implement the profile parts to
> enable wideband speech so I wonder if we should rename it to the
> underline feature it enables, that said this sort of feature is
> probably easier to be queried over the socket itself rather than over
> D-Bus so it can be used in conjunction with the likes of BT_VOICE,
> also regarding the erroneous data should that be also enabled by the
> HFP profile, because depending on the platform it may not support
> wideband speech so enabling erroneous data automatically may result in
> artifacs, specially in cases where the codecs don't have error
> correction or data loss concealment to handle data with possible error
> and lost data respectively, btw we don't seem to be parsing the
> SCO/ESCO flags and even if we do this properly we need to find a way
> to notify them over the socket so things like plc works properly.

This indeed makes sense, but we'll need to decide how erroneous data
reporting gets enabled.  The SCO socket is a per connection scope
thing while erroneous data reporting is a controller level thing.


>
> > >>
> > >>
> > >> > > >
> > >> > > >
> > >> > > > >>
> > >> > > > >>
> > >> > > > >> > > ---
> > >> > > > >> > >
> > >> > > > >> > >  doc/adapter-api.txt | 8 ++++++++
> > >> > > > >> > >  1 file changed, 8 insertions(+)
> > >> > > > >> > >
> > >> > > > >> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > >> > > > >> > > index acae032d9..d8865e795 100644
> > >> > > > >> > > --- a/doc/adapter-api.txt
> > >> > > > >> > > +++ b/doc/adapter-api.txt
> > >> > > > >> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
> > >> > > > >> > >
> > >> > > > >> > >                         Local Device ID information in modalias format
> > >> > > > >> > >                         used by the kernel and udev.
> > >> > > > >> > > +
> > >> > > > >> > > +               boolean WidebandSpeechEnabled [readonly]
> > >> > > > >> > > +
> > >> > > > >> > > +                       Returns true if the adapter's wideband speech feature is
> > >> > > > >> > > +                       supported and enabled.
> > >> > > > >>
> > >> > > > >> There seems to be some extra empty lines here.
> > >> > > > >
> > >> > > > > ACK, will fix.
> > >> > > > >>
> > >> > > > >>
> > >> > > > >> > > +
> > >> > > > >> > > +
> > >> > > > >> > > +
> > >> > > > >> > > --
> > >> > > > >> > > 2.26.0.292.g33ef6b2f38-goog
> > >> > > > >> > >
> > >> > > > >>
> > >> > > > >>
> > >> > > > >>
> > >> > > > >> --
> > >> > > > >> Luiz Augusto von Dentz
> > >> > > >
> > >> > > >
> > >> > > >
> > >> > > > --
> > >> > > > Luiz Augusto von Dentz
> > >> >
> > >> >
> > >> >
> > >> > --
> > >> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
