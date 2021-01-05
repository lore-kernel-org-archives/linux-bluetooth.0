Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C1922581
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbhAEDSd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhAEDSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 22:18:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5DC061793
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 19:17:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m12so69385004lfo.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 19:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9qIu5DTJT+Za2/ApWVVGoH9CbIRMgAjcbjp/1Tm+08=;
        b=PvGqbkz5YNVfHMsyQU/lejC0UaJ8rk1Ip8OkoM219dxsWQ5L90PhoZFRZqVVtzOxbY
         XIsa/UAbUF0fk902CVsPMOPWRfZmx5qcudDhTSoHQbdMDKqgJ13BuUlp8YMRfELP9WeH
         re7FgolWtfyur2MENiVCo1SNyWq+ar7ZyiFpdUAM80zi7Ph1OXBZ3UDXHaE8wDWclYw3
         XCgivMffIx8oiMfqboCdU5y69a6Vhz9SBl7Px51vstECl6PfAB4Hf/WTPbrXY5NpRXSV
         Gf5Bav9H3hGBfMHwhtIeqQen0Trv9j+Q/AizGqYVw3dx38k31ASNFUM2ypEly6A2zHM+
         2Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9qIu5DTJT+Za2/ApWVVGoH9CbIRMgAjcbjp/1Tm+08=;
        b=cVPOf+FpQvtAIdNWXV3TUqngDEVvqWl9t23++zLsAv1MmYFmjlMn+vOTlyM0yhKfrt
         Ndd7wPMG5qE6mKJ1ziAJ6sikUR7iT9TfAnM4fDnFMguiRbO8VunkAnuwxWzWgbXhJnSD
         382LzCvtd+kHujMYdLBw5APRymxG4HpWHavAX5X2qgvrB/vuEtyWYpE/3GQsXMFmvjQ1
         Ns8PHiR7tPZtfRFT8lCr4PgsuLcMVDDogbRJlrr8S4vps4fRu62TeoeidYCMliPijp7l
         crcpmwZvoS83fLkp+iBQyc0Znm70Gmh8RqVzpvDsDJbEjmFvPGsUhGQeoF2oKCQDD4nX
         yejw==
X-Gm-Message-State: AOAM531jNXEV+C2TQTNfpzYYfPQ2hgPJe4W4v25LO/w5SoW0nBZuBogC
        mZoxfcS1m++xV8f4su6Pfi/LXfVwtmP610+qQ5wq2A==
X-Google-Smtp-Source: ABdhPJy+OwGlSSxciDczTJLpmFL+AuwQs2USfu4c8iu7E3Zt4Nq1rh1o0ccKvuOfeiWnYsEfoi8+y/xfhSlr3pBN2os=
X-Received: by 2002:a2e:9b4e:: with SMTP id o14mr12647110ljj.309.1609816670527;
 Mon, 04 Jan 2021 19:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
 <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com> <CABBYNZL1TuDtSmyYxwK6uCLk8fm8U2jwxPi0aERsoUgAATeL0A@mail.gmail.com>
In-Reply-To: <CABBYNZL1TuDtSmyYxwK6uCLk8fm8U2jwxPi0aERsoUgAATeL0A@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 5 Jan 2021 11:17:39 +0800
Message-ID: <CAJQfnxGrfKJhCBCVD6kgLHnb4hgspUQPtJ0nSipO2kUOv3bSYQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Don't remove device if adapter is
 powered off
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry for being unclear.


On Tue, 5 Jan 2021 at 03:17, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Jan 4, 2021 at 11:09 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Mon, Dec 28, 2020 at 10:34 PM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > If adapter is powered off when a device is being removed, there is a
> > > possibility that the kernel couldn't clean the device's information,
> > > for example the pairing information. This causes the kernel to
> > > disagree with the user space about whether the device is paired.
> > >
> > > Therefore, to avoid discrepancy we must not proceed to remove the
> > > device within the user space as well.
> >
> > This sounds like we have a bug in the kernel, aren't we calling
> > btd_adapter_remove_bonding or is that failing if the adapter is not
> > powered? Hmm it does like it:
> >
> > This command can only be used when the controller is powered.
> >
> > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > > ---
> > >
> > >  src/adapter.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index ec6a6a64c5..a2abc46706 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
> > >  {
> > >         GList *l;
> > >
> > > +       /* Test if adapter is or will be powered off.
> > > +        * This is to prevent removing the device information only on user
> > > +        * space, but failing to do so on the kernel.
> > > +        */
> > > +       if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
> > > +                       (adapter->pending_settings & MGMT_SETTING_POWERED))
> > > +               return;
> >
> > We might need to return an error here so we can reply with an error on
> > Adapter.RemoveDevice.
>
Should be unnecessary due to the check you mentioned below.

> After some investigation it looks like there is already a similar check:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n3238
>
> That perhaps needs to updated or perhaps this is the result of the
> device being set to temporary which sets a timer to remove the device
> and then in the meantime the adapter is powered off? In that case
> perhaps we should clean up the devices set as temporary.
>
The problem occurs when the device is paired and is currently
connected, then Adapter.RemoveDevice is called. This would make us
disconnect the device first before actually removing the device.
During this disconnection phase, there is a chance the adapter is
powered off.

If this happens, we would still attempt to remove the device anyway.
No problem on the user space, but it will fail on the kernel side (as
per the API, it requires adapter to be on). The check you mentioned is
unfortunately not executed during this phase.

About the timer, I didn't have the exact issue you described, but this
version of patch might have other problems with it, because the timer
would still be running when we do the early return from
btd_adapter_remove_device. Although nothing will happen if the timer
runs out when the power is still off (we would just do the early
return again), but it might be unpleasant if the adapter is re-powered
and the timer kicks off to remove the device.

> > >         adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
> > >
> > >         adapter->devices = g_slist_remove(adapter->devices, dev);
> > > --
> > > 2.29.2.729.g45daf8777d-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
