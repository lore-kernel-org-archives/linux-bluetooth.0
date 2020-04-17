Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E0C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 20:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C609B21841
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpydHFZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDQU6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDQU6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 16:58:17 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFE8C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 13:58:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r66so3270141oie.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Nl7KIrATNNNuYbJShhhMx6q0S0ImP69tIKt1eLf4Nk=;
        b=rpydHFZXOQn/cwdgnj/vXWFdgXcDxOOdxDjMr70zkfUdk7lnGKKS4butncHtoVZmt/
         R/mwYcg0Q5DejJRfCf9cx5kxhYa6ZYpy8Bn87Z6k1GHMIyctwZB6hEH42IBZBULARZa4
         YEDk/xRJVDyakg8EZvSiMQPMBaZ0pq6q46/NuY+njniCaWlrjg6225F+JMVo+TJscWLA
         JTBBu4G5WqlBbATzXWj1DzNLF5jwm+Bjsy+5I8tKkXpeq1gQtsJ2rJ1CIM9uOiFoq94X
         JnvRm8swQjetEQamH7G2xezsBtHUK57QUqhdYpB4VWRKxIjrRomvWDJnI6U6RgoDH6wn
         vv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Nl7KIrATNNNuYbJShhhMx6q0S0ImP69tIKt1eLf4Nk=;
        b=i5vYNHTqvTkRow4NJ5k63DeM9tbkQVplcRs0KEgfcUTXOm+prAm8enNooNkNSanyyF
         OGNJDx3S8vzS0cE3WrJJk2PXNDOx5SErgS650/s7+Ai8VrQfEwi362GnI942VO9CYkxE
         A0i2+bRq8hZHVFCfvH4zrgJLqRNt+y3y1cmwLZadcfrmQM2kZcudooAUBWwQFzaAbZCy
         svxz/GUhfvUY7ibhFLAVC+5RkSnf5anpr7a3JKDl8FRUVllRSYp81XhbaYlPBUi3PB8d
         yBTDWNKZc7ztbUgKaHc5xyBIavPZilpE2+nfRRZdmFb2UAODqUILpBU6ZQOTDypVbDNd
         zhBA==
X-Gm-Message-State: AGi0PuZIrlBO0qvXXzYG9/wEtoy5YO2WM0110fbLK5Wz63sdn15/0W1L
        MUwrGvyvveHxyAarveTGHkZAZkK1QkUwW0D0mvaPk5CB
X-Google-Smtp-Source: APiQypIiKbXqxNl06G1BaKoQ0PmNTMnwVFQOLs37YNkGDXV1vyhhJtpD9aVn/lnegXs8qEs/7WKznVOokB/uX8ul6O0=
X-Received: by 2002:aca:db8a:: with SMTP id s132mr3675698oig.110.1587157096160;
 Fri, 17 Apr 2020 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com> <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
In-Reply-To: <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Apr 2020 13:58:04 -0700
Message-ID: <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, Apr 17, 2020 at 11:22 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> On Fri, Apr 17, 2020 at 2:16 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> > >
> > > HI Luiz,
> > >
> > > On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > >>
> > >> Hi Alain,
> > >>
> > >> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
> > >> >
> > >> > Friendly ping on this series.
> > >> >
> > >> >
> > >> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
> > >> > >
> > >> > > This change adds an adapter Api to report the controller's
> > >> > > widebandspeech enabled state.
> > >>
> > >> I wonder if this shouldn't be queried over SCO socket, or simple fail
> > >> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
> > >> normally used when using mSBC.
> > >
> > > I think there is value in both.
> >
> > Can you expand on that? I think this might generate confusion if the
> > property indicates support for it but HFP implementation don't support
> > it, since the later is usually implemented as a external profile so we
> > don't have the features it may support, or perhaps the intention here
> > is to actually indicate when it is in use?
>
> This is a signal that the adapter supports it and has everything
> enabled to support it.   Driver indicated it supports it and erroneous
> data reporting was enabled.  The profile has it's own state which may
> indicate if msbc will be used, but this will be on a per connection
> basis and is independent from this adapter property.
>
> The value in this property is to support diagnostic UX about
> controller capabilities/state and also allow profiles that are
> implemented outside of bluetoothd to see which codec it can attempt to
> negotiate with the device.

For diagnosic I think we would be better off with some dedicated
interface to query this, as for the later the information we are
giving does not actually tell anything about the codec support, which
was part of my original argument that for the likes of HFP and other
profiles using it it might not be enough and they still need to use
BT_VOICE in order to enable the use of custom codecs, if you take
ofono for example it does implement support for wideband speech
already and it would completely disregard this property which can give
the false impression that wideband speech cannot be activated when in
fact it can, it just don't have erroneous data reporting enable, so
perhaps we should indicate the actual adapter feature (e.g.
ErrnoneousDataReporting) not the profile feature here, so the profile
implementation can check weather this would disable use of wideband
speech or not, futhermore we should probably report the errors back to
the SCO socket or is that just for diagnostic and cannot be used to
adjust the streaming?

> >
> >
> > >>
> > >>
> > >> > > ---
> > >> > >
> > >> > >  doc/adapter-api.txt | 8 ++++++++
> > >> > >  1 file changed, 8 insertions(+)
> > >> > >
> > >> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > >> > > index acae032d9..d8865e795 100644
> > >> > > --- a/doc/adapter-api.txt
> > >> > > +++ b/doc/adapter-api.txt
> > >> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
> > >> > >
> > >> > >                         Local Device ID information in modalias format
> > >> > >                         used by the kernel and udev.
> > >> > > +
> > >> > > +               boolean WidebandSpeechEnabled [readonly]
> > >> > > +
> > >> > > +                       Returns true if the adapter's wideband speech feature is
> > >> > > +                       supported and enabled.
> > >>
> > >> There seems to be some extra empty lines here.
> > >
> > > ACK, will fix.
> > >>
> > >>
> > >> > > +
> > >> > > +
> > >> > > +
> > >> > > --
> > >> > > 2.26.0.292.g33ef6b2f38-goog
> > >> > >
> > >>
> > >>
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
