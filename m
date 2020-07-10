Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3828CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0926D20748
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVBBdLnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJU1S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJU1S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 16:27:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD16C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:27:18 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id p26so1236408oos.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlueREa58b7R7VgL4TssSAMNWNyU4cNA/gxFnLfVl+c=;
        b=HVBBdLnXBVyVmBkn+U8swcNvwrekcAUYiq9XAL/9Jx17Y/CEgfq1lwNp4dB/qhNYmR
         Nxk08EfnmjL8vG0XO8JL3nCTjjzhpdysRO0bPoCo4pBhMkZXJHHKU9BMfN0IUwcYa7ac
         Js2kOpqY4vDJSB1sso6tQ/Skl3LGJDnETckjEuuleTUgIpfhIF6ytiCEi/DiaYyivSZx
         55bxfLddOXGmC/76sAQT6ONhcqtZY/Nr+ZuYx76BsvG6p9f9O5U1ZHuy/iOnqjH74btI
         fRFu4ZxGm/nvUutVVSK8CgOjJnD+lRCzNhVYCltHpAAWT6cPpMeOlGuQiGWZVyHNwigg
         MwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlueREa58b7R7VgL4TssSAMNWNyU4cNA/gxFnLfVl+c=;
        b=nRXiOzkt9PwQIEd/pOqKOPoW4vDacg2wPJD8rw9Ob4onyFMpKI3YkEJCuADJr+YohN
         1o9asr53WICAjAmfqawIKVXOcxLC8H2jRQ69N6yN/VRGO3ZyEfszf7rHEnNCAYE/laPK
         H9wm1ZPFYs4u6fpYz+Ap3jGFbed++2fGoE4iYhEGHwHSrzTR2tTD+1ab4JdzfZ+HmXKn
         WDEJRx7YMeP/h3DEkwy55na6cxxC7oMWEG7gF6azV5d3Nr2qzditW0EhLALHpIiFJJmT
         L/x7XRmBeSmqqbCgH0/xIv7cJ854LgzZyUXi7+5ZCuVIFWeCqB/W0VLAkLttwUU5nu7g
         U/iw==
X-Gm-Message-State: AOAM532XXNcKPpQzOI5CwbHeCp7uU6uIo38uEL8LwBwp3TV1K8fNhDck
        HU6jRjTr4bEElTNz/+ndrTY1UqyIIFLE2GaqhES37JDD
X-Google-Smtp-Source: ABdhPJyzxmQbbgtFuQaFSVkySsG4ZUkgrRodCAHhtsAFP0B5YZr3/TaXUnPjZL0SR2iNG/Se/hJ5rLJQVSNL6X9vCA8=
X-Received: by 2002:a4a:b284:: with SMTP id k4mr22935561ooo.49.1594412836576;
 Fri, 10 Jul 2020 13:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
 <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
 <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
 <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
 <ddb9a0761e52a2e70e1c0dcc6fcefca02937dda6.camel@hadess.net>
 <CABBYNZ+y9UTv1yakyB3Z+1oa+B4dw5TmSiuhCmWQCq88sXpXgw@mail.gmail.com> <3f9aeb5d7aa896770946a8c04bd8483e9d7ba4f3.camel@hadess.net>
In-Reply-To: <3f9aeb5d7aa896770946a8c04bd8483e9d7ba4f3.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jul 2020 13:27:05 -0700
Message-ID: <CABBYNZJ2ak66EK42owiLtk1Gqu-RMoXUHu8a1eQVVNQ+syh5cw@mail.gmail.com>
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

On Fri, Jul 10, 2020 at 12:00 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2020-07-10 at 11:06 -0700, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Thu, Jul 9, 2020 at 1:26 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > > On Thu, 2020-07-09 at 01:57 +0300, Andrey Batyiev wrote:
> > > > Hi Luiz,
> > > >
> > > > On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > > The delta logic might be a nice addition as a separate patch,
> > > > > it is
> > > > > more for detecting devices disappearing then actually cleanup
> > > > > during
> > > > > power off.
> > > > No-no, it's not about adapter powering off.
> > > >
> > > > I meant that (external) devices never disappear from the bluez
> > > > device
> > > > list during the discovery,
> > > > even if the (external) devices are turned off (i.e. they should
> > > > be
> > > > purged by bluez).
> > > >
> > > > So:
> > > > - bluez is central
> > > > - bluez is discovering
> > > > - peripheral appear for a moment, than disappear (i.e. peripheral
> > > > would be turned off)
> > > > - bluez would not remove device from the list (at least until
> > > > discovery is stopped)
> > > >
> > > > Use case:
> > > > - bluez is monitoring environment (discovering literally forever)
> > > > - peripherals are brought in and out of bluez visibility range
> > > > - bluez list of visible devices grows infinitely and causes
> > > > problems
> > > > (hundreds of devices)
> > >
> > > I'd also expect devices that are recently discovered to disappear
> > > if
> > > they haven't replied to a discovery in 30 seconds. It would stop
> > > GNOME's Bluetooth Settings's Bluetooth list forever expanding.
> > >
> > > Or we need to give the ability for front-ends to do that by
> > > exporting
> > > the "last seen" dates.
> >
> > I am fine with that as well, 30 seconds doesn't sound too bad even
> > for
> > cleanup temporary devices as the current 3 minutes seems awful long
> > sometimes, we could perhaps have a filter for configuring that though
> > so if the application wants to have its own timeout, the only problem
> > is if there are multiple application doing that on parallel we would
> > need a strategy on how to handle that.
>
> In which case it might be easier to export that last seen date,
> otherwise that's just a lot of moving parts inside bluetoothd when we
> could filter it trivially in the front-ends.
>
Right, we still need to clean up the temporary devices though, but
perhaps adding a LastSeen property is not a bad idea after all so
applications can do this sort of filtering themselves.

-- 
Luiz Augusto von Dentz
