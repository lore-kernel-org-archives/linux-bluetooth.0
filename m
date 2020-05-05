Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDCC47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DA220721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IseOkpFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgEEXs0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728717AbgEEXsZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 19:48:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49BC061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 16:48:25 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s202so138335oih.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4LSZLHRkTneTsC05qk1XErBcOYfQNq134aUd24BU44=;
        b=IseOkpFdgDohX1nDwWyQfBzaT3abnWfYiq/MYEDGUYJb89oXEaE2rFQfrM1PPQ23aP
         VrAoHLJQOCCN6/MDnVtIRkgzuCTtYSxWbryk0Bz2Bj7PNYT0s/nvB5dn+a5XyqMKBnTs
         nu9fLbjzqGt/L8l51suoA435njkqtBVMzrua+jzDefc0S2VloYFnhzBeRnt+uk/Cgmt0
         KPt2XbToGKhHQIyXi9DTZEngadfWYX1xGWGTarBpWioIQCs7/Bgp0pXSHjhFwbTGmUSU
         gMcCyrh09YH2ro8KOpu5nWtrQf1cctejO5NPvU7EhwCnbIdDK8nvZSyFufJ/Ahu23AGJ
         /keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4LSZLHRkTneTsC05qk1XErBcOYfQNq134aUd24BU44=;
        b=DpQNM+eLPdF4CoOo+mivmVs/2q+WV98zjR/Cbj0PmhHoomaDIuyZpUp1R5SWduW1QZ
         jzZtSC+hoSVl+W2BkNgNDEeiGx7ARYy994SGTgeLlX4mYCkudZ4hBdl8faJKnHiKpTda
         Sg18wf3KoRTjBQh0X6bbb9bDbPj8SS9+1VBhOk43G+7h2TdsoDCitxARg4v64iLAYmNs
         KXOCkAqiIAAhjuxIJfbF6KPm5rAsmAKh/usQdQJ3X/zggbzdo3P4jU4NHszk8v/9y3kI
         +KWEDOOZJ9lENuAyuFoxufXuIPbxSYDVyJmeE1O5bL8x1mE5eToJRugMy8WndunZSJeQ
         KLPQ==
X-Gm-Message-State: AGi0PuZmtFqdGSA5DkpJCXFrAFK3SycJIYWEeWbmhRIH4IJk+52HbSNN
        3Jnoji1aCU/iBfp5pRC4vx+xdk9PXvhd1wytf0c=
X-Google-Smtp-Source: APiQypKSzj4twsXZ+Dq5h1aA2sN+nZUUepzHmZaehpcEWagUmWNhVSm69ozYE7oCN2AvabnQIOl9RzzboKgRXZLHfsQ=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr955936oif.108.1588722504638;
 Tue, 05 May 2020 16:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
 <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
 <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
 <CALWDO_Ux+=YtWsvnNxwpO7W_PSbAmUukyh6MHUoBqStNF7qC2Q@mail.gmail.com>
 <CALWDO_UJtMpTmvWj6KsAJkwzDE=ZXA_bq2Cp2DR-gcBgvQT0cA@mail.gmail.com> <CALWDO_WpiztCRau98_eFegrCKNsK4VigKQhw7kvyzFgKLm3NZA@mail.gmail.com>
In-Reply-To: <CALWDO_WpiztCRau98_eFegrCKNsK4VigKQhw7kvyzFgKLm3NZA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 May 2020 16:48:10 -0700
Message-ID: <CABBYNZJq43bjTneJ9wsCpzfMWHOGdZyhBFTDfAZcYUWFCv5brQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Alain Michaud <alainmichaud@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Alain,

On Tue, May 5, 2020 at 8:47 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Friendly ping on this series.
>
>
> On Tue, May 5, 2020 at 11:46 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Friendly ping on this series.
> >
> > On Fri, Apr 17, 2020 at 5:03 PM Alain Michaud <alainmichaud@google.com> wrote:
> >>
> >> On Fri, Apr 17, 2020 at 4:58 PM Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >> >
> >> > Hi Alain,
> >> >
> >> > On Fri, Apr 17, 2020 at 11:22 AM Alain Michaud <alainmichaud@google.com> wrote:
> >> > >
> >> > > On Fri, Apr 17, 2020 at 2:16 PM Luiz Augusto von Dentz
> >> > > <luiz.dentz@gmail.com> wrote:
> >> > > >
> >> > > > Hi Alain,
> >> > > >
> >> > > > On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> >> > > > >
> >> > > > > HI Luiz,
> >> > > > >
> >> > > > > On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >> > > > >>
> >> > > > >> Hi Alain,
> >> > > > >>
> >> > > > >> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
> >> > > > >> >
> >> > > > >> > Friendly ping on this series.
> >> > > > >> >
> >> > > > >> >
> >> > > > >> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
> >> > > > >> > >
> >> > > > >> > > This change adds an adapter Api to report the controller's
> >> > > > >> > > widebandspeech enabled state.
> >> > > > >>
> >> > > > >> I wonder if this shouldn't be queried over SCO socket, or simple fail
> >> > > > >> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
> >> > > > >> normally used when using mSBC.
> >> > > > >
> >> > > > > I think there is value in both.
> >> > > >
> >> > > > Can you expand on that? I think this might generate confusion if the
> >> > > > property indicates support for it but HFP implementation don't support
> >> > > > it, since the later is usually implemented as a external profile so we
> >> > > > don't have the features it may support, or perhaps the intention here
> >> > > > is to actually indicate when it is in use?
> >> > >
> >> > > This is a signal that the adapter supports it and has everything
> >> > > enabled to support it.   Driver indicated it supports it and erroneous
> >> > > data reporting was enabled.  The profile has it's own state which may
> >> > > indicate if msbc will be used, but this will be on a per connection
> >> > > basis and is independent from this adapter property.
> >> > >
> >> > > The value in this property is to support diagnostic UX about
> >> > > controller capabilities/state and also allow profiles that are
> >> > > implemented outside of bluetoothd to see which codec it can attempt to
> >> > > negotiate with the device.
> >> >
> >> > For diagnosic I think we would be better off with some dedicated
> >> > interface to query this, as for the later the information we are
> >> > giving does not actually tell anything about the codec support, which
> >> > was part of my original argument that for the likes of HFP and other
> >> > profiles using it it might not be enough and they still need to use
> >> > BT_VOICE in order to enable the use of custom codecs, if you take
> >> > ofono for example it does implement support for wideband speech
> >> > already and it would completely disregard this property which can give
> >> > the false impression that wideband speech cannot be activated when in
> >> > fact it can, it just don't have erroneous data reporting enable, so
> >> > perhaps we should indicate the actual adapter feature (e.g.
> >> > ErrnoneousDataReporting) not the profile feature here, so the profile
> >> > implementation can check weather this would disable use of wideband
> >> > speech or not, futhermore we should probably report the errors back to
> >> > the SCO socket or is that just for diagnostic and cannot be used to
> >> > adjust the streaming?
> >>
> >> My original patch actually had this MGMT feature called erroneous data
> >> reporting and Marcel argued against it.  If you both agree, then I'm
> >> happy to rename all of this to erroneous data reporting.  We'd still
> >> need some way for the driver support to be messaged some other way
> >> though. see:
> >>
> >> if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> >>         set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);

So this will get a little bit confusing if we don't have a HFP
implementation that actually does implement the profile parts to
enable wideband speech so I wonder if we should rename it to the
underline feature it enables, that said this sort of feature is
probably easier to be queried over the socket itself rather than over
D-Bus so it can be used in conjunction with the likes of BT_VOICE,
also regarding the erroneous data should that be also enabled by the
HFP profile, because depending on the platform it may not support
wideband speech so enabling erroneous data automatically may result in
artifacs, specially in cases where the codecs don't have error
correction or data loss concealment to handle data with possible error
and lost data respectively, btw we don't seem to be parsing the
SCO/ESCO flags and even if we do this properly we need to find a way
to notify them over the socket so things like plc works properly.

> >>
> >>
> >> > > >
> >> > > >
> >> > > > >>
> >> > > > >>
> >> > > > >> > > ---
> >> > > > >> > >
> >> > > > >> > >  doc/adapter-api.txt | 8 ++++++++
> >> > > > >> > >  1 file changed, 8 insertions(+)
> >> > > > >> > >
> >> > > > >> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> >> > > > >> > > index acae032d9..d8865e795 100644
> >> > > > >> > > --- a/doc/adapter-api.txt
> >> > > > >> > > +++ b/doc/adapter-api.txt
> >> > > > >> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
> >> > > > >> > >
> >> > > > >> > >                         Local Device ID information in modalias format
> >> > > > >> > >                         used by the kernel and udev.
> >> > > > >> > > +
> >> > > > >> > > +               boolean WidebandSpeechEnabled [readonly]
> >> > > > >> > > +
> >> > > > >> > > +                       Returns true if the adapter's wideband speech feature is
> >> > > > >> > > +                       supported and enabled.
> >> > > > >>
> >> > > > >> There seems to be some extra empty lines here.
> >> > > > >
> >> > > > > ACK, will fix.
> >> > > > >>
> >> > > > >>
> >> > > > >> > > +
> >> > > > >> > > +
> >> > > > >> > > +
> >> > > > >> > > --
> >> > > > >> > > 2.26.0.292.g33ef6b2f38-goog
> >> > > > >> > >
> >> > > > >>
> >> > > > >>
> >> > > > >>
> >> > > > >> --
> >> > > > >> Luiz Augusto von Dentz
> >> > > >
> >> > > >
> >> > > >
> >> > > > --
> >> > > > Luiz Augusto von Dentz
> >> >
> >> >
> >> >
> >> > --
> >> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
