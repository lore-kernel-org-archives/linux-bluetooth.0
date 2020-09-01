Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B0DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCEC2071B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuEvfc/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIATAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIATAN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 15:00:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2263EC061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 12:00:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c2so2839301ljj.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2a2eHRC4UrZkaHxq8PViyMXpd2KFeO0w59OoKcQ6wM=;
        b=LuEvfc/iMsq897RADN1GPbouFhFD7vrAxT0yLxElC+bFkwVNmfGih3ZMNkLo4x1nF3
         IiM2w2a+O13nF49FYYoCpnEeVpexkkn+Tglpcx2yT8CKPhZaXVzRtHRG3l++gK9MOXZn
         6qykvDaSXwmT0PNUi10YyTc0rpDn/9Fnpbc+ZpD8OHyCGwBfosaaE1PxGZeqkKPLggoj
         Vc6OFW6TkJ4GG1ahADAGG0A1tdIAmtkqRLW7DR9f2ihMuEklKGGabnEOUTLzJThK22Fp
         7VQe1Lg3Gkg8vpqjfUprw9NMaG8IQz/5e/JtwGcOpG7oY3QA3PnWUQnxced9+EvCx5Br
         wcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2a2eHRC4UrZkaHxq8PViyMXpd2KFeO0w59OoKcQ6wM=;
        b=N3q0OF8W2mycgaVChanUHcv/hV2OQy21cjJl/BclMiq8NMZBHnQf5kQpH31LMg8T/D
         DHv0/WF8KDeBT/iOR2zphbaElcck8uxlBg2F6poqE2q2edEKSzLUe228e7fbIiQYnLK9
         BRa2cW8RInifpFzm1jiOyiqWTaJlJknK38Zll6p/xMqjiYn/O10/xZ9oISOye3SNdHoZ
         fjT0I93HS/+qJ6UwW5/rhI66W9KXYJBZbr8jMzB3CoIysNwAH4wCRWDiVgGkM0owi1WO
         /4Jxos3KuClwvBaPUnuPvQUNAPqVJCrmmtRSL4xKuwUgQwVWivjuRcpqyP+IXsaxZeVB
         VLbg==
X-Gm-Message-State: AOAM5328ssmS8mScM4Npp8GuurLED3jeo81BDPitCp6OokwtRJeg0Ti7
        ZXL7pg+wCX21IJG72dBv1GLJOzLk8IMAXF9fog0TgQ==
X-Google-Smtp-Source: ABdhPJzlwrRTy9qT7aVCVvmafg/jgkrM7gZEw8kt6wcBjg4u+OC3q+0oMB5RrkbxoIob/FcIqzmLycVH6VwqDoupyVQ=
X-Received: by 2002:a2e:b4c6:: with SMTP id r6mr1285598ljm.274.1598986810973;
 Tue, 01 Sep 2020 12:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
 <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
 <CAHC-ybxFY_3HWrvnwF5DS-i-YJtYpUuR9K3-MSWJWo=C-CKQHA@mail.gmail.com>
 <CALWDO_Wsyx3s3SwBejAFdc6SFX=V29DnvPKmo48hd-yy9SqHSg@mail.gmail.com> <CABBYNZJxjYUvui7e-S4TGx21W2U9QvmXhyKNOaWg3RLR4jWg2A@mail.gmail.com>
In-Reply-To: <CABBYNZJxjYUvui7e-S4TGx21W2U9QvmXhyKNOaWg3RLR4jWg2A@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 1 Sep 2020 14:59:59 -0400
Message-ID: <CALWDO_XV+Hn-U+SgAe_tCcpST0NAo+UjRCBbdS8dzBQZuUCXEg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Yu Liu <yudiliu@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, Sep 1, 2020 at 1:47 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Tue, Sep 1, 2020 at 8:43 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Marcel/Luiz,
> >
> > I'd be particularly interested in seeing your opinion on whether this could be better described as some form of SCO socket property... even if this is indeed an adapter property.
>
> Yep, but wasn't that supposed to be what BT_PKT_STATUS is for? I mean
> one can just attempt to read it with getsockopt and in case of returns
> an error it means the controller does not support it, that said it
> doesn't look like we do check the adapter features when using
> BT_PKT_STATUS, should that be checking if HCI_WIDEBAND_SPEECH_ENABLED
> is set?
The problem here is that this will be after the connection is created
and a packet is exchanged.  In this context, we'd like to know if the
controller supports it ahead of creating a sco connection so we can
choose to use the headset at all.  For example, there are devices and
circumstances where using the device's built-in mic and A2DP will
yield a better experience for the user so the platform may choose that
as a default for the user rather than degrading down to narrow-band.

>
> Also it doesn't seem we have updated userspace to support
> BT_PKT_STATUS, we should probably have something to test it via
> isotest and perhaps create a iso-tester.c to validate all the options.
>
> > Thanks,
> > Alain
> >
> > On Mon, Aug 31, 2020 at 5:44 PM Yu Liu <yudiliu@google.com> wrote:
> >>
> >> +Alain Michaud
> >>
> >> Hi Marcel,
> >>
> >> Can you please comment on the cl as well as Luiz's suggestion? Thanks.
> >>
> >> On Thu, Aug 20, 2020 at 10:20 AM Yu Liu <yudiliu@google.com> wrote:
> >> >
> >> > Friendly ping for comments from Marcel. Thanks.
> >> >
> >> >
> >> > On Mon, Aug 17, 2020 at 4:17 PM Luiz Augusto von Dentz
> >> > <luiz.dentz@gmail.com> wrote:
> >> > >
> >> > > Hi Marcel,
> >> > >
> >> > > On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
> >> > > >
> >> > > > From: Archie Pusaka <apusaka@chromium.org>
> >> > > >
> >> > > > Initially this is introduced to query whether WBS is supported by the adapter,
> >> > > > the API is generic enough to be extended to support querying others in
> >> > > > the future.
> >> > > >
> >> > > > Reviewed-by: sonnysasaka@chromium.org
> >> > > >
> >> > > > Signed-off-by: Yu Liu <yudiliu@google.com>
> >> > > > ---
> >> > > >
> >> > > > Changes in v2:
> >> > > > - Return an array of strings instead of a dict
> >> > > >
> >> > > > Changes in v1:
> >> > > > - Initial change
> >> > > >
> >> > > >  doc/adapter-api.txt | 12 ++++++++++++
> >> > > >  1 file changed, 12 insertions(+)
> >> > > >
> >> > > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> >> > > > index 1a7255750..8fbcadb54 100644
> >> > > > --- a/doc/adapter-api.txt
> >> > > > +++ b/doc/adapter-api.txt
> >> > > > @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
> >> > > >                                          org.bluez.Error.NotReady
> >> > > >                                          org.bluez.Error.Failed
> >> > > >
> >> > > > +               array{string} GetCapabilities()
> >> > > > +
> >> > > > +                       This method returns a list of supported
> >> > > > +                       capabilities that is populated when the adapter
> >> > > > +                       initiated.
> >> > > > +
> >> > > > +                       Possible values:
> >> > > > +                               "wbs" - Wide band speech
> >> > >
> >> > > Btw, should we stick to use wbs terminology here, or we should
> >> > > actually use the HCI feature/command, because wbs has actually to be
> >> > > implemented by the HFP afaik this is only indicating that the
> >> > > controller is able to notify packets drops, etc, with use of erroneous
> >> > > command. Perhaps we should actually use the term PLC (Packet Loss
> >> > > Concealment) instead since that seems to be the real capability here,
> >> > > afaik WBS does not actually require PLC.
> >> > >
> >> > > > +
> >> > > > +                       Possible errors: org.bluez.Error.NotReady
> >> > > > +                                        org.bluez.Error.Failed
> >> > > > +
> >> > > >  Properties     string Address [readonly]
> >> > > >
> >> > > >                         The Bluetooth device address.
> >> > > > --
> >> > > > 2.28.0.220.ged08abb693-goog
> >> > > >
> >> > >
> >> > >
> >> > > --
> >> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
