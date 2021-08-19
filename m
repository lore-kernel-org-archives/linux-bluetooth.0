Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96729C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 17:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D29F601FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 17:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhHSRwK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHSRwJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 13:52:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D744C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 10:51:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k65so13755968yba.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaS1SUAQmdtqY+NjJV5NNuqZc5tJAZy4kKZdDjcHQzE=;
        b=Uf5vGzk9ytP+dFki+RzSxPf+wfzTi1X4J7UuSwGqJdFS/E4WWTvR2hFNLj1EQm9eRy
         40LdJcihH5h3yCR8a/x2N41TTlwhvDOBcd+4VE2KF7yVqRD0r6LkEqQGHfp6Tn+WbPRF
         QcMjyiQ27yKPHwH4TVK3MwxgdPsr/C2ebz49Ul3Ne7clIFulRt+fKlgiaIhapbmQauot
         gXLcFd/bv6y15Q6bF07VZkbpmZ1SR2OTtAzEvtI6nimOd3gZ8Rc7KvXkbwHTS8OzVxS3
         gJZbN2UoyUq/tnh4fVcgJ1OyQKqQnC0kzKecQanEC+p/y1ucrHUep7NInW/U7eEWB8h6
         J/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaS1SUAQmdtqY+NjJV5NNuqZc5tJAZy4kKZdDjcHQzE=;
        b=OG/Qt4JQqJsTfCArXlz71dAZ2hqZohTM62yZQX5YuTHZp7QttfBUAROj8Kp5rLsGZ1
         pjrjV/9eZxg61XQpso8BkjDXsWaVzhnO7PHj49yK84dkbGMn6lm4rlG/V/Bi34DAHL+S
         0oE0ekvP00vBntP80pl/Fy1WMYlht8DkoW6T3R14qRI4IuReMHdryZ3fu43mZhroLPMb
         DzWLmnwWtxwCm1Rcntu7JHPZTDFI43qwEqFYDqNW4KMM21Y83ewX8ueJzgAo5y9Xj5ep
         uVQwwWyrtil79NyQ7xAAPEcBKQ78SpmgdGuF2bBNN7O60Kw/9Yu4CLVtyxWcU5HTk6j+
         OgEg==
X-Gm-Message-State: AOAM531p0em3hpDSCXVgsSSXwQDw0KFcxj2WkT8MTEPDZSz3ZyGEFXEg
        btECk0nJtQPWQmKrokryUHP7J6cAcnQ5TlDZL2OyeCOncnY=
X-Google-Smtp-Source: ABdhPJzGKTFrJdSa4StbzxQ1KsbLrwIsFZ8JXbci2Uxy4YiJnj/PLResLC3Jg0dE4dXEfpXid1X7j+6PHODD4st6PYw=
X-Received: by 2002:a25:d183:: with SMTP id i125mr21290308ybg.408.1629395492116;
 Thu, 19 Aug 2021 10:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <e17b2044-62cb-cbf7-64b8-c647aa7f6ee7@pabigot.com> <A6782BCD-0C05-40AD-B567-7A1E163184E0@holtmann.org>
In-Reply-To: <A6782BCD-0C05-40AD-B567-7A1E163184E0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Aug 2021 10:51:21 -0700
Message-ID: <CABBYNZLg=zujCZbbhrZq4mGpNLTSuKK6BrN8b_8Sf-NrhmDbbw@mail.gmail.com>
Subject: Re: how to cleanly shutdown an application using HCI_CHANNEL_USER
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "Peter A. Bigot" <pab@pabigot.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Peter,

On Thu, Aug 19, 2021 at 8:04 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Peter,
>
> > I'm using an AF_BLUETOOTH socket bound with HCI_CHANNEL_USER from a
> > user-mode application with cap_net_admin=ep.  As expected this
> > requires the device be down, and brings the device up automatically.
> >
> > When I close that socket and exit the application, the device appears
> > to remain up forever.  Which prevents me from re-starting the
> > application.
> >
> > I tried to issue HCIDEVDOWN before closing, but that produces EBADFD
> > because ioctls cannot be performed with HCI_CHANNEL_RAW.
> >
> > I can bring the interface down from within the application if, after
> > closing the socket, I wait a second or so, then create a new bound
> > HCI_CHANNEL_RAW socket and issue HCIDEVDOWN on it.
> >
> > Is there some other way to cleanly shut down an application that used
> > HCI_CHANNEL_USER so that the device is returned to down state on exit?
> > Or is this supposed to happen automatically (I see code that suggests
> > it should)?
> >
> > Kernel version is 5.11.0-7620-generic (System76), and I'm using go
> > 1.16, if that's relevant.
>
> I think you found a regression. Calling close() on the HCI User Channel should bring the device back down. This used to work correctly, can you please bisect which kernel patch broke this.
>
> Back in the days I added tools/userchan-tester, but it seems I never included enough test cases to catch this regression.
>
> Regards
>
> Marcel

It is worth checking if this is affected by the following fix:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=58ce6d5b271ab25fb2056f84a8e5546945eb5fc9

-- 
Luiz Augusto von Dentz
