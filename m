Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6377C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A738722D57
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbhAESea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbhAESe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 13:34:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AEBC061793
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 10:33:37 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 11so592901oty.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDywb7B7VVpsBi9sZoz2XFTneDOyRxDKxwR01v6jv0I=;
        b=L+p68mhJ3y3jjxTQnTZd5zrAmHE7KjNSPsE98hyWLsKRe2AnzoeMlLb6KCATgNnD+5
         uGEsqtA5OvL2Gdi1i05flTuJrsQX/pbjyXJnPFz2mv7w+m8sVoA4OTJjEPYkaGMLFUty
         PD0oAh3+b4NO5h7zi7NvmM76SkVYfnbqXgXG67Rl9wDM/SENiUCUsQdKKXrlkiLlz5cj
         y+1psfur87HPwUyeKR5T8EkoqOZi8TdTa/MsFzgLhfLO7Es3XoAnEOCNe7ruQhHaCTcQ
         OhoG8PfXQK6Nf7QfMT1hsu1HDRdOcubTtIsvRlhJe6G0dqdGW9Lhdjqe+750Mc9qMqK2
         s8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDywb7B7VVpsBi9sZoz2XFTneDOyRxDKxwR01v6jv0I=;
        b=B6wsrXGvTMKUnsEg/14lsW3Ny+PMl9yr0lSx3N5rYPL1AYOlGi/StfGUWvJAby3AyA
         sVqlpfV5f0YClMZCK9vgpj8PYWWq0UCBnOfCaxLzu9FfysmS2OfOU8I5f6s4/UZBxCRJ
         sKGhNK5Tx3YbW7J0Es4jiYNNBjGun2aCDNnUTyNueA9m+B2NTyMc/wdkn0syJ09N/kvQ
         AR0oEiRCtk+VXlfP7KIN9grJXZf5npyEgd8onGhSvaSXkL4FXxPxzIduO02z7gFQAeoO
         mYhFAyASXnLG3hCj4WS3+6wMDUJ4R12gOCo0wr8sLlcmdlVQcSbJhVN0TQ8et3YBaAUj
         eg5g==
X-Gm-Message-State: AOAM533ckbMbelOyXcsVlbClZx6XjAz5tMgscq+/idzKwOGzGttYc0vx
        OyVbbGwp1wk5VjiAJj8BcErmHoL7F4wTtAKfvZJTwWHo
X-Google-Smtp-Source: ABdhPJwLSVvRrsebc27Lyb6MEvrJJW2glORmyljpZ/WufgdkA1AxcMeVlJMKSTwbf6yA60k7XdnakSg7LFGqvg2MDrI=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr620621otq.240.1609871616638;
 Tue, 05 Jan 2021 10:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
 <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com>
 <CABBYNZL1TuDtSmyYxwK6uCLk8fm8U2jwxPi0aERsoUgAATeL0A@mail.gmail.com> <CAJQfnxGrfKJhCBCVD6kgLHnb4hgspUQPtJ0nSipO2kUOv3bSYQ@mail.gmail.com>
In-Reply-To: <CAJQfnxGrfKJhCBCVD6kgLHnb4hgspUQPtJ0nSipO2kUOv3bSYQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 Jan 2021 10:33:25 -0800
Message-ID: <CABBYNZ+ScBp9QbR3ikMzxCyDaUo9PpNo2uaJZzy3ATp35pp=Kg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Don't remove device if adapter is
 powered off
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Jan 4, 2021 at 7:17 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> Sorry for being unclear.
>
>
> On Tue, 5 Jan 2021 at 03:17, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Mon, Jan 4, 2021 at 11:09 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Mon, Dec 28, 2020 at 10:34 PM Archie Pusaka <apusaka@google.com> wrote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > If adapter is powered off when a device is being removed, there is a
> > > > possibility that the kernel couldn't clean the device's information,
> > > > for example the pairing information. This causes the kernel to
> > > > disagree with the user space about whether the device is paired.
> > > >
> > > > Therefore, to avoid discrepancy we must not proceed to remove the
> > > > device within the user space as well.
> > >
> > > This sounds like we have a bug in the kernel, aren't we calling
> > > btd_adapter_remove_bonding or is that failing if the adapter is not
> > > powered? Hmm it does like it:
> > >
> > > This command can only be used when the controller is powered.
> > >
> > > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > > > ---
> > > >
> > > >  src/adapter.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > index ec6a6a64c5..a2abc46706 100644
> > > > --- a/src/adapter.c
> > > > +++ b/src/adapter.c
> > > > @@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
> > > >  {
> > > >         GList *l;
> > > >
> > > > +       /* Test if adapter is or will be powered off.
> > > > +        * This is to prevent removing the device information only on user
> > > > +        * space, but failing to do so on the kernel.
> > > > +        */
> > > > +       if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
> > > > +                       (adapter->pending_settings & MGMT_SETTING_POWERED))
> > > > +               return;
> > >
> > > We might need to return an error here so we can reply with an error on
> > > Adapter.RemoveDevice.
> >
> Should be unnecessary due to the check you mentioned below.
>
> > After some investigation it looks like there is already a similar check:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n3238
> >
> > That perhaps needs to updated or perhaps this is the result of the
> > device being set to temporary which sets a timer to remove the device
> > and then in the meantime the adapter is powered off? In that case
> > perhaps we should clean up the devices set as temporary.
> >
> The problem occurs when the device is paired and is currently
> connected, then Adapter.RemoveDevice is called. This would make us
> disconnect the device first before actually removing the device.
> During this disconnection phase, there is a chance the adapter is
> powered off.
>
> If this happens, we would still attempt to remove the device anyway.
> No problem on the user space, but it will fail on the kernel side (as
> per the API, it requires adapter to be on). The check you mentioned is
> unfortunately not executed during this phase.
>
> About the timer, I didn't have the exact issue you described, but this
> version of patch might have other problems with it, because the timer
> would still be running when we do the early return from
> btd_adapter_remove_device. Although nothing will happen if the timer
> runs out when the power is still off (we would just do the early
> return again), but it might be unpleasant if the adapter is re-powered
> and the timer kicks off to remove the device.

Right, Id guess if RemoveDevice is called and either way we end up
powering off the adapter I suppose we want the device removed either
way thus why I suggested cleaning up the temporary devices before
powering down.

> > > >         adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
> > > >
> > > >         adapter->devices = g_slist_remove(adapter->devices, dev);
> > > > --
> > > > 2.29.2.729.g45daf8777d-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie



-- 
Luiz Augusto von Dentz
