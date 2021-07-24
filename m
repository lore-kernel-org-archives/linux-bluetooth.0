Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9DAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C0260EBC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 01:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhGXAn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 20:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhGXAn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 20:43:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CDBC061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 18:24:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp1so4945945lfb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFLKqCQMs4QJ4wkuMKLn39s+IHrWzISoltHLZE6/2V4=;
        b=XNqWMNSsGhcxi426XftVASsFLTqaG79Guc7kHP2Ml5oLtivIdkFH/t/V0DU+MavucT
         vlLRhAxyaN0YtQu+Q+cnexe4hG/yzzGhW2K9JovLaPBt95bp0dD1nBFayu/4HuR5sKb6
         o6St+77jfQjM+Gm3mbycwm65tq4S8JLYo5aDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFLKqCQMs4QJ4wkuMKLn39s+IHrWzISoltHLZE6/2V4=;
        b=kxXvKhMTVwPRw6uiGjKYwtC7R+IjdrfCaSVMi7fwh+TDogBu9qkw58im1ISwUrCswS
         mQd4vWz9bMNYRJmDAhhMo+BlDvukmOwe7EdcO+luemCi78ZaS/UKVjcVVti8aYNkft1+
         Dwvf3ITMIzFMFdseMPcDvikf/NzDCITrmy2TH/2Tcw3Pzla3U9Kp2IaYi7otHmgg+AHx
         H68P/IbvAZhVsUI81hqHmMqnCmi6TJJtfXeOe5lzfUC4qNWAXRw9PTunJhgBYETCf3UN
         PUFOLumgbJT3hnRSJBLBAWWjgrzH8xs2MFPsWUxxEKNwAqcQzbjd6NgVzrnIFiJibygo
         MfEg==
X-Gm-Message-State: AOAM531idsajtS59vgJ+ZVMIAk+/NqdSnXPgDcbXcRjO+/uz6gweORmg
        7M10+eHGKIhFfmZyYeGcqn4lnIcvLme/N1I7GhR6pw==
X-Google-Smtp-Source: ABdhPJxxg5shE1jQIJxuX+UwuL0SPjaJRLXxcQK+j1nSG3xAFUcjEz5IXf328tTXQyzLsVbyXstFcqAUBN5zQxpu5OA=
X-Received: by 2002:a05:6512:3456:: with SMTP id j22mr1067789lfr.538.1627089866266;
 Fri, 23 Jul 2021 18:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210626052152.2543526-1-mcchou@chromium.org> <CALWDO_V6y0sCVOGJjCfn7eqQ3RAc4NHqsFbXxRmGvnzGxU26ZQ@mail.gmail.com>
 <5350EBBD-7F81-448E-B96A-A1C09F8EC676@holtmann.org> <2206189.ElGaqSPkdT@ix> <CALWDO_UPexnNmFSf8i8ONkEfQknLqacgw8k4MQs9pejWnD99jQ@mail.gmail.com>
In-Reply-To: <CALWDO_UPexnNmFSf8i8ONkEfQknLqacgw8k4MQs9pejWnD99jQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 23 Jul 2021 18:24:15 -0700
Message-ID: <CABmPvSGJTHP4F9L=AO4vqZ1EG59m7_xzdedVKUCVKOQwZePU=Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/3] error: BR/EDR and LE connection failure reasons
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

Thanks Alain and Szymon for chiming in.

Doing a through-out API revamp is definitely worth considering.
However, I'd like to point out the fact that these error messages will
likely be applicable even after API revamp, since the majority of the
error codes are based on errno returned by the kernel.
Another comment was on the format of error return. I'd like to hear
your feedback on how we present errors in D-Bus return. The two
options that we have on the table is (1) string form of error
description (2) string form of uint16 error code.  (1) is more
extendable while (2) is easier to be processed by the client.

Regards,
Miao

On Fri, Jul 23, 2021 at 6:20 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> On Fri, Jul 23, 2021 at 4:20 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
> >
> > Hi,
> >
> > On Friday, 23 July 2021 09:38:40 CEST Marcel Holtmann wrote:
> >
> > > >>>>> What is the intention to split BR/EDR and LE here. You do know
> > > >>>>> up-front what connection type you are. Trying to figure out from the
> > > >>>>> error code what connection you have been trying to establish is plain
> > > >>>>> wrong.>>>>
> > > >>>> In fact the up-front connection type is not necessarily known. In the
> > > >>>> case of dual-mode devices, such as Bose QC35, a D-Bus client can issue
> > > >>>> Connect(), and it depends on the timing of connection request (adv
> > > >>>> usually arrive first compared to inquiry result), it can be either
> > > >>>> BR/EDR or LE link being established. Another aspect of this is the
> > > >>>> metrics collection, where knowing transport can be handy. For
> > > >>>> instance, we can associate the certain error to particular use cases
> > > >>>> at application layer, and that can help targeting the bottleneck to
> > > >>>> tackle.
> > > >>>
> > > >>> Then we need to find a different way to convey the transport chosen.
> > > >>> Doing this by error message is a bad idea.>>>
> > > >>>>> The description is that you want to know exactly where the connection
> > > >>>>> failed. And I think that can be established independent from the
> > > >>>>> transport.>>>>
> > > >>>> Indeed the intention is to know where it failed exactly. However, as
> > > >>>> mentioned above, transport information is also an important piece of
> > > >>>> information to know.
> > > >>>
> > > >>> We need to find a different way to inform about which transport failed
> > > >>> (or better which was chosen in the first place).>
> > > > I would love to hear your thoughts on an alternative.  Many of the
> > > > Apis are transport agnostic (Connect/Pair may end up connecting to
> > > > either available transports for dual mode devices), but yet the error
> > > > that results from them are not.  Errors from one transport doesn't
> > > > make sense for one and vice versa.  A platform wanting to leverage
> > > > telemetry and metrics to drive ecosystem improvements would ultimately
> > > > need to know the difference even if the applications may not need to
> > > > care.
> > >
> > > and we might have made a mistake in the API design and should have given the
> > > caller more control. We need to review the API design and see if things
> > > have to change. Just glueing things on at the end makes me suspicious.
> >
> > Some (5, wow!) years back I've loosely proposed split for org.bluez.Device API
> > that was meant to handle some of the dual mode devices issues we've been
> > seeing [1] [2].
> >
> > We never got time to fully implement it (mostly due to hacking around device.c
> > instead of properly splitting internal implementation into device_le.c and
> > device_bredr.c) but got some very initial PoC running.
> >
> > With new interfaces old Device1 could be simply super-set of two for legacy
> > applications purposes.
> >
> > Maybe such approach is worth re-considering?
> >
> >
> > [1] https://marc.info/?l=linux-bluetooth&m=145710680912268&w=2
> > [2] https://marc.info/?l=linux-bluetooth&m=145973293118003&w=2
> Definitely worth reconsidering.  We've recently introduced a ConnectLE
> Api as a stop gap measure for something very similar.  I'd love to see
> the equivalent of a ConnectClassic / ConnectLE distinction.
>
> However, I still believe the "Generic" Connect serves its purpose as
> you alluded to above.  Even if it could be built using layers, I still
> believe there is value from a telemetry POV to understand the errors
> from the field better and there, the distinction between the specific
> transport matter.  Just like today, I suspect many applications will
> continue to use the generic "Connect" as to not replicate the logic it
> ultimately implements for dealing with dual mode devices, yet
> results/metrics would be important.
>
> The team strives to improve interoperability at a large scale in the
> ecosystem, I believe these data point distinctions are a critical
> enabler to get better insights into the specific errors customers are
> seeing.  A counter proposal that would be acceptable to you, achieves
> the objectives and that the team can implement would be a nice next
> step.
>
> Thanks!
> Alain
> >
> >
> > --
> > pozdrawiam
> > Szymon Janc
> >
> >
