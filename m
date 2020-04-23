Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A96C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5D12098B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvO0eAQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgDWOvg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDWOvg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:51:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749CC08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:51:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so6524439ljd.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLnN5nTKM+qDck/1d36x41LYQVtwBQrDB08K4OHNPYM=;
        b=TvO0eAQxGRqh5WiZaahZjX8Bhg3C4dVLSHLMJbivrcbHXgiQu9Pg+l5lKCN0o8y6la
         DqSrKMqSmUFK2ymk2TABUsUeSR8NQyyCmMTHxEqvIjoYUHkcxqEAz4KJUUdRM08HF8NR
         fDcf6Sbipu0fEYhLKQFx80ds7R9p02icxmdjkT1GBoic3kTuPwlaoZGXm6/LovUFESUm
         d37rvpyxqtdX+jy1hhJswvjS0U57bnchz0yY7bcb7HnH37eZV1rzmXt2Zj/oK9d0Mzut
         N2FlMJNFj7mbasimeT0+KPzt2w7XaOl0vF6uR7FVmgsPN9KCKCtUxZ6TlUJxZ/8xEcup
         Nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLnN5nTKM+qDck/1d36x41LYQVtwBQrDB08K4OHNPYM=;
        b=jgqnhxpcd72SfDEOtePfBA+TGj8ncSStKrDdvBMMjNM+u3GgMPm9ZxoZE0Qaw3yAZl
         Od6cEirG5QGYRTl9OYW7ASmS830taOPj1mW4HxwtUh12xvtXdg/8V+KSvufX9FQwiu2B
         wRQF9NQQuvsYXdzRWRg5qhCVarqF11QaybxsMd0/ygUfK0N+jzNNUZzIv0yspSWyifUd
         0Poi2ZSqSS8zVyY9cv+UHsqRTnCXLjq0wynoqflqKDkKmEs74r+a9z9ampzCaOubeZQ8
         db9KBHd+VJeN96ZjYI8eHUngQUd75pi5LMig1A9I0Lj4159prG8MvoE20/DPmNCnPD8b
         p3QQ==
X-Gm-Message-State: AGi0Pua1nBk6ZGTdVJjh0uXUOk6nBCucF/YZngRLydIhaGTBN9Sp8nZB
        Ten81X33OcJiafkH6HQ3j4l8WA+qqY2X0LUwvEdhJkpaJ6A=
X-Google-Smtp-Source: APiQypKG4ra+V4/UPqnS+xcfJHICovQQbIkeYtCZiM6aqWmQUH9wN+yoUfttyV239/ThkurPy0q5FHVlFlDAc3mOuyA=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2626789ljp.277.1587653494027;
 Thu, 23 Apr 2020 07:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200423142305.66778-1-alainm@chromium.org> <5347568.DvuYhMxLoT@ix>
In-Reply-To: <5347568.DvuYhMxLoT@ix>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 23 Apr 2020 10:51:22 -0400
Message-ID: <CALWDO_Vk-JCtViCWSoCZRxhGtKKhFkJZTJKctOw7NBRJwT_zdg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:Adding Roles property
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 23, 2020 at 10:42 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Thursday, 23 April 2020 16:23:05 CEST Alain Michaud wrote:
> > This change adds a new property to indicate the support for concurrent
> > roles which means that the controller has reported the appropriate
> > LE_Supported_States (hdev->le_states) and that the controller's driver
> > has reported correctly handling the various reported states.
> > ---
> >
> >  doc/adapter-api.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index acae032d9..1a7255750 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -326,3 +326,11 @@ Properties       string Address [readonly]
> >
> >                       Local Device ID information in modalias format
> >                       used by the kernel and udev.
> > +
> > +             array{string} Roles [readonly]
> > +
> > +                     List of supported roles. Possible values:
> > +                             "central": Supports the central role.
> > +                             "peripheral": Supports the peripheral
> role.
> > +                             "central-peripheral": Supports both
> roles
> > +
> concurrently.
>
> If this is an array os strings why central-peripheral is needed?
The keyword in the description is "concurrently".  Not all adapters
support being peripheral and central concurrently.

>
>
> --
> pozdrawiam
> Szymon Janc
>
>
