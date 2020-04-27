Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D787C55199
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1822F2078E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5WerY8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD0Qrx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgD0Qrw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 12:47:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E2C03C1A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:47:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j26so27341040ots.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GZ+BCL7qN3UO0nqfcKxsasUhMHjakP9Hx2ZS83UMSk=;
        b=d5WerY8Ldr6y5C2/E6aETZIlGbBWyKk9k2URmjNBnuiP3UEKFpNzSw8oKGbv0Y4sxI
         tnfrtTNAXRvjud5TeswhjYKFsmUHoy9DoW2mu8Brj+MzuJoYkBCmQa5/Xl0+JlWPgJL/
         nqN5zjOm3yBYMm0tgt4GOvixp6ZK9fsbn7lzKp3oRF1Zo7hhV2wpe0MtF8+NM11sxfz/
         XoxAD39gKBRvJEg/WJr5A1mzRBYWkZG+dahthH2H0uKCP5PoyRA73cV/htLOmpPS8FhA
         CaLZnS0co0Cm/teaicD8RXkrevMDXqVtcYYOsIDMUepr/t12YuBxo2aDbseuRNqZ60ZT
         JKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GZ+BCL7qN3UO0nqfcKxsasUhMHjakP9Hx2ZS83UMSk=;
        b=oxKokm8NP8bXSDRFuIiVArh1+sc6vJfMtXVXezXszUIm/PxZEwmXZCD6Im/XBuW/4/
         5ZwmykiVXIFvzzW+iMaSbSByqXM/5cDbKKGC9plAyNBhZB4snwT+VkIKvDwuyhOZP7sL
         QRsPGeNd1XfS+J8B1z1ILYF/qPPA9iJdDMLZg2i4kLd0qNNjfWlxK2fX+OZGstMYJGz1
         jOsXXcihZTiUKPgR04yUZisSV+svyaT1Zke8V9SDxfMKrz9XTK35DxQg6Nk3Sv2Vy7nW
         p6QMTFSusXeA/G2c3BcMDH66f+7GpDNvFU4GPk4Qf778B383vL7AIY0aVvCIMKHerMSj
         yPzw==
X-Gm-Message-State: AGi0PuawevuHVEDAi+Qdn+Wyja7seS+b6lYa5rrWw/GDTolgWL7AMGjb
        bLZb1XmHA2n2qy4VfTQjd+03TXLTOqluJKeJnEk=
X-Google-Smtp-Source: APiQypJyvy7z4jLaqLnKqK+WCFT2OK7M+xVLO6cNdiqJzZzHUtPyc9hpPUztKWAoiGk1rChIGivrzfeYlezhL2VlwMY=
X-Received: by 2002:aca:b155:: with SMTP id a82mr14667666oif.110.1588006070758;
 Mon, 27 Apr 2020 09:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200423142305.66778-1-alainm@chromium.org> <5347568.DvuYhMxLoT@ix>
 <CALWDO_Vk-JCtViCWSoCZRxhGtKKhFkJZTJKctOw7NBRJwT_zdg@mail.gmail.com> <CALWDO_XsouHaxheRgR7HGkLxf4U1ag0pxCnVN6zLLqbZF=rjVg@mail.gmail.com>
In-Reply-To: <CALWDO_XsouHaxheRgR7HGkLxf4U1ag0pxCnVN6zLLqbZF=rjVg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 09:47:39 -0700
Message-ID: <CABBYNZJv8ucqYztJqVikO29vkd1LuTHj1yEvpTbV_kgGgP5tAg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:Adding Roles property
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Apr 27, 2020 at 8:02 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Any more feedback on this Api design?
>
> On Thu, Apr 23, 2020 at 10:51 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > On Thu, Apr 23, 2020 at 10:42 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
> > >
> > > Hi,
> > >
> > > On Thursday, 23 April 2020 16:23:05 CEST Alain Michaud wrote:
> > > > This change adds a new property to indicate the support for concurrent
> > > > roles which means that the controller has reported the appropriate
> > > > LE_Supported_States (hdev->le_states) and that the controller's driver
> > > > has reported correctly handling the various reported states.
> > > > ---
> > > >
> > > >  doc/adapter-api.txt | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > > index acae032d9..1a7255750 100644
> > > > --- a/doc/adapter-api.txt
> > > > +++ b/doc/adapter-api.txt
> > > > @@ -326,3 +326,11 @@ Properties       string Address [readonly]
> > > >
> > > >                       Local Device ID information in modalias format
> > > >                       used by the kernel and udev.
> > > > +
> > > > +             array{string} Roles [readonly]
> > > > +
> > > > +                     List of supported roles. Possible values:
> > > > +                             "central": Supports the central role.
> > > > +                             "peripheral": Supports the peripheral
> > > role.
> > > > +                             "central-peripheral": Supports both
> > > roles
> > > > +
> > > concurrently.
> > >
> > > If this is an array os strings why central-peripheral is needed?
> > The keyword in the description is "concurrently".  Not all adapters
> > support being peripheral and central concurrently.

Applied, thanks.

-- 
Luiz Augusto von Dentz
