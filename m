Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E27DC433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1751F207A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 19:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393213AbhALTif (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393150AbhALTid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 14:38:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E995AC061786
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 11:37:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w124so3562304oia.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 11:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tuei7sFWPbUI7nOlvTWJ6kjxJgj733Mcp85h5bxTmL8=;
        b=PX0eYJLeziJ1W17AjXTWAGKoP40FaIUCcEDnaaXP4GpKrq0e6aExjMvBi29izMFp5Z
         me5MVzmjjWlHu10lrclhSOFxZVGN8NIxHHzcpCPAqfn0a4T8wzuA+6GXjRILu2FXNq0J
         WAsEnO9WI7Pl+GFZ3FrcQMkYvD8DmsK1j4AaV21Tdc66ps8Jhy01z4SxJwy0IweDVWSy
         gqQcAhnPuunKTqHwvfGkfu4iMGRHAOcok5+VLxgMBDs+AacaHtwMBqhhLlQTSYtQthe3
         8KngAzwUu+uqanfRQ9lhzRuXY7wSmKR6bp0fvzsz5NiEWP5m8EbLm8unvcDZ9HMnZPIi
         BVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tuei7sFWPbUI7nOlvTWJ6kjxJgj733Mcp85h5bxTmL8=;
        b=WqgNfeqk/jhaPGE/ofTd4aZwLBnIhuImBbm2g3Nj+45yo/WWGISpEEikZ/GwXcUWg3
         719K4dYN49jwdkDpvBDm2kezjy/Xh1398+4WSbMuKJ/Jo16WImOUKiCm1Rui7dckvl0t
         HZ8BHEOwDXRuIM6crFCA0a10M0noK1CaNO7jrGhVWmAAN/1c6umxUGceiilN2Q88Mssa
         uaRqeB6W+nqal52hMEM2/Vt0qfWT2Pa3i3+j+jaF8KxE1Mk0e9Tp2Gm2VfkS+x66Yalt
         EvbPH6THxx3VMj843apxd3ddotoeasL6a4iVr+F1TrSIQWub8+pZ6mohsZwJvSzYgRuV
         sJrA==
X-Gm-Message-State: AOAM531DtaintCAIl0H2mLpwH4iVjsGUZfFZh8U3lnEuB0RZfx2urpqA
        XmrFJuWIETezKztbAQ2TtpiZ8Z+5iPqIR8iO093MxOjPneA=
X-Google-Smtp-Source: ABdhPJz2X15BCQyRhtTexLGTxDEoM8rKVZXDk01zY5Ap7QAPYuTmpFqOVeD3GJEJqm7ZI5hcGliTBfJ5LfA0jOb/Vis=
X-Received: by 2002:aca:f456:: with SMTP id s83mr483075oih.58.1610480272215;
 Tue, 12 Jan 2021 11:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20201222124651.101063-1-marcel@holtmann.org> <CANFp7mV8RpF8gkrEbyA8ZOP1YH5CH0xkJeyPcaetROsqHiZWWg@mail.gmail.com>
 <CABBYNZJ7ednKQfBG+Ky+39+d2qO3YvXGn7TTvm-3SZ-uSNcsfA@mail.gmail.com> <CANFp7mVYx3oBLnq=oj2gODcK6Wm_bq8Ykv2MD6DnqvS4gdOu9Q@mail.gmail.com>
In-Reply-To: <CANFp7mVYx3oBLnq=oj2gODcK6Wm_bq8Ykv2MD6DnqvS4gdOu9Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Jan 2021 11:37:40 -0800
Message-ID: <CABBYNZLVN7GV5fMb05pgosAEfHPur-EPrvggffUikaKd4hOO5Q@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Tue, Jan 12, 2021 at 10:03 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> On Mon, Jan 11, 2021 at 1:55 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Mon, Jan 11, 2021 at 11:38 AM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Hi Marcel,
> > >
> > > I don't think this solves the original problem we were talking about:
> > > the driver should replace the runtime firmware on reload if it doesn't
> > > match what's on disk.
> > >
> > > Some background for the mailing list:
> > > - On a ChromeOS laptop, we discovered that the Bluetooth controller
> > > wasn't being fully powered down in some reboots. As a result, a new
> > > firmware wasn't being applied after an update.
> > > - The kernel driver was checking if the bluetooth controller had
> > > loaded some firmware already. If it was in bootloader mode, it would
> > > download new firmware. If it was not, it would skip downloading new
> > > firmware.
> > >
> > > The useful part of this mgmt command is to force the driver to reset
> > > to bootloader (Action = 0 in Set Runtime Firmware). However, without
> > > being able to compare the firmware version loaded on the controller,
> > > there's no clear signal for when this should be called. Loading the
> > > firmware through mgmt may be useful for debugging but you could also
> > > just replace the firmware on disk and "reset to bootloader" to achieve
> > > the same effect. I would actually expect unloading and reloading the
> > > module should do that.
> > >
> > > Also, moving the firmware loading from the driver to the userspace
> > > seems odd to me. Since the comparison is between the controller
> > > firmware and disk firmware, there's not much extra that the userspace
> > > knows that the kernel does not.
> >
> > My last suggestion was just to have a MGMT command suggesting the
> > kernel to load the firmware from a different location, this could be
> > useful for testing purpose so one can set for example an old/beta
> > firmware to compare for regressions or test new features that
> > otherwise would not be available. That said perhaps we don't actually
> > need a new MGMT command for doing this and just by replacing the
> > current file would trigger a reload but that may get tricky when if
> > the location does get unmonted/remounted etc.
> >
> > >
> > > ----
> > >
> > > Coming back to the original problem of when to reload runtime
> > > firmware, here are the conditions under which we do and don't want a
> > > reload.
> > >
> > > Do want a reload:
> > > - Reboot
> > > - Module is unloaded and reloaded
> > >
> > > Don't want a reload:
> > > - Transport disconnection (i.e. usb disconnect; some laptops will
> > > power down USB during suspend to save additional power but BT will
> > > stay powered up)
> >
> > Well if the device disappears from the host I'm not really sure how
> > you will be able to detect that the firmware was retained, that said
> > when the adapter is power up again it should be possible to query it
> > what firmware it is currently running and then compare with the one
> > from file before attempting to load it, this should also work
> > regardless of the underlying transport/bus so it would work regardless
> > of the driver in use.
>
> Generally the device drivers detect whether it's in bootloader mode or
> runtime firmware is uploaded. With the runtime firmware, it can also
> query what version is running. However, there's currently no way to
> read the version on disk because the firmware version isn't stored at
> some known location in the firmware blob. That's the crux of the
> problem here.

Hmm I believe we can extract the build number of the firmware, I mean
it is obviously in there and we could possibly start encoding its
version/build as part of the filename as well not just the model.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/bluetooth/btintel.c#n226
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/bluetooth/btusb.c#n2723

So we just have to figure out where the build number is in the
firmware file, so store it somewhere else perhaps using some metadata
perhaps.
