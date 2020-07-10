Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC954C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A636220720
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 18:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXsLtgdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGJSGf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJSGf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 14:06:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E963BC08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 11:06:34 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t198so5496708oie.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mwwxt+6Dm0ceODIWJuacgu8G2+IT6Ypl2+OAhI2wq48=;
        b=dXsLtgdIutKGrFJ+t1nZg/NvSd2nia9K52l7u1DSdYJeipCK2p/LXuLdR8DopSq8Ey
         aFTkYa9JUaVVuyPbKqYShTkb6nutyBzRaDWAlTqAi7Qw3JZp7D4rd7isGjIPfqS5qTYx
         Rm5JbyXzvDrUPUNqgQ0p6VNOyrAthJddWV6o7f9vm1HX92GXRz5AmAWd/Z+WCGZxFAAD
         BJ+VN4c7NJOrsGqRUeJuiGTjBgWNiK1ZE5vz4jS4mMdOe6AzPVA1sGXtlatVEOBSgL7s
         J7h9T0zmaAN+U9ofTjzJ3ZQxJpNPF1cweR3q68fE7ZEAeiy4pcuWY5Q+C+meFoJgP67+
         bAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mwwxt+6Dm0ceODIWJuacgu8G2+IT6Ypl2+OAhI2wq48=;
        b=ctFA+DXGfRF4zi8d1AvwxpUzjUbpHJAUtFKlVxHgt4zszZChXeSYRl8F4y4OkTsMRq
         pclDxJzaqRQuqQ94Ydlo1okFiJbHK1O4i+i2mxyRd32OBHc7PZuwlFzQ3q5snD4JbsPD
         5u77+Jx9Kz3evI3KsZDOMVOfQrDTXxvmCanSvL6fIQ4ZE8/LzpZsFSxPWpMVH+jsyTW+
         uv3bdrhKvmHoAgw+uUJjk9wL/MGt+ge///XC0iMbZXg/GhqsVO15IZdT7trYbUnqDISq
         SHN568WjDbx+SdcO/4gpgp6MJFNQgWzx1Zj7sU8X5S6sPtCMQVEeg+EmdfJqqmEXqn8B
         UV2Q==
X-Gm-Message-State: AOAM532YzYRmt//Z/p8mWopeZTvGFeUuURcuWkRXW0CbAOLmU0a331Oc
        SJLPGE+5L2gH0SA9TYtoSwg15NRNYRM3m24fd1w=
X-Google-Smtp-Source: ABdhPJyaZ42ywxpwRjsUjOjUP22rq2zM7MRTu54uRilzOkq0s0p5vGnKyQfobFbk+49P1rvCvrxP9wqPuZtteWTRUmY=
X-Received: by 2002:aca:4a04:: with SMTP id x4mr4898436oia.152.1594404394207;
 Fri, 10 Jul 2020 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
 <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
 <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
 <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com> <ddb9a0761e52a2e70e1c0dcc6fcefca02937dda6.camel@hadess.net>
In-Reply-To: <ddb9a0761e52a2e70e1c0dcc6fcefca02937dda6.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jul 2020 11:06:22 -0700
Message-ID: <CABBYNZ+y9UTv1yakyB3Z+1oa+B4dw5TmSiuhCmWQCq88sXpXgw@mail.gmail.com>
Subject: Re: Temporary device removal during discovery
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Andrey Batyiev <batyiev@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Jul 9, 2020 at 1:26 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2020-07-09 at 01:57 +0300, Andrey Batyiev wrote:
> > Hi Luiz,
> >
> > On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > > The delta logic might be a nice addition as a separate patch, it is
> > > more for detecting devices disappearing then actually cleanup
> > > during
> > > power off.
> > No-no, it's not about adapter powering off.
> >
> > I meant that (external) devices never disappear from the bluez device
> > list during the discovery,
> > even if the (external) devices are turned off (i.e. they should be
> > purged by bluez).
> >
> > So:
> > - bluez is central
> > - bluez is discovering
> > - peripheral appear for a moment, than disappear (i.e. peripheral
> > would be turned off)
> > - bluez would not remove device from the list (at least until
> > discovery is stopped)
> >
> > Use case:
> > - bluez is monitoring environment (discovering literally forever)
> > - peripherals are brought in and out of bluez visibility range
> > - bluez list of visible devices grows infinitely and causes problems
> > (hundreds of devices)
>
> I'd also expect devices that are recently discovered to disappear if
> they haven't replied to a discovery in 30 seconds. It would stop
> GNOME's Bluetooth Settings's Bluetooth list forever expanding.
>
> Or we need to give the ability for front-ends to do that by exporting
> the "last seen" dates.

I am fine with that as well, 30 seconds doesn't sound too bad even for
cleanup temporary devices as the current 3 minutes seems awful long
sometimes, we could perhaps have a filter for configuring that though
so if the application wants to have its own timeout, the only problem
is if there are multiple application doing that on parallel we would
need a strategy on how to handle that.

-- 
Luiz Augusto von Dentz
