Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDCC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5216923102
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAFJ36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFJ35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 04:29:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F958C06134D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 01:29:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o17so5146076lfg.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMcZukqZvTFBxvzJHvcc159rN6jrYVEi8Q4XYitDsKQ=;
        b=bRgI8mS2AgWROtESHtqXqRJ1QPrpiG9cmKr/9d/g0ELjmb5T0ui0ijYY2o0GpV+Dud
         yLACBxF/w+u5DM3yau4qhcjlVmvtWNJt36mpSv1YJ00Q8Yk6lGLzJ+/+Om9+XJa2JFM9
         dhopFz4d8BI/aWn0ZSXyZ97P9duHJzky4cJizAWAnaJuU14RIbYFZTzRd1dba0VBWgr4
         oUhJewtBDWelFXejVnnFn9EDEl1iFg6TYVqzNM/tG3YiGDY3wyFWx+TVNvhGzhrQ4vAT
         kp9vZWC/qCAP3ta/BwCdfGvLtSoiGGvn6eAls6z18432HEcKDxB9Y7VgSZdYSy7oIK6n
         dv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMcZukqZvTFBxvzJHvcc159rN6jrYVEi8Q4XYitDsKQ=;
        b=JmN/q2QNpNCvbQVfR7qbW2jjPFUuwdfsM2yFzhaFD0A9P+3l+DHklUClRqXpOkDSru
         SONYL4ErVqrCSnc074RAk/2hnjt/UuPm7sDEfHtTD6b1EEm+rb+ei37t77GUoa0GpkjR
         YXE8lIzSaoCvB/PxFstsaN5F9GsaItmaTeb7geeX5yOju0nFlpjNIs3OzVGDyHekU/gZ
         35Ci3MjTbzSCAuFzzxoQpnhlQPyo59p3L+bunIJQDLpY/KknYzXqgJFFIWlX3OrdT6Sb
         V5rOLuoSQ58c4runN24MGEACBM2rThG8TWrK+CWvGsEIKOKrVGCZOM+hE9hx40koKPwY
         eomw==
X-Gm-Message-State: AOAM5314jUuunMQZMUznzjiczJMPPJMGmSN7VcBJu9Ob0JmxTUCs34BQ
        UUwO33Ydb1XSTZi67IocrNn55TSTEioOKSX0WiYVuA==
X-Google-Smtp-Source: ABdhPJwcDEXxIbiLAkuEulyQxCQfrnJNiI4qdi5dSKlnDkkyN75OPLXOr9iIMn1Ks3vYcntuqtQXM5xM6lWaUpXFmrA=
X-Received: by 2002:a19:495b:: with SMTP id l27mr1455659lfj.451.1609925355433;
 Wed, 06 Jan 2021 01:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
 <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com>
 <CABBYNZL1TuDtSmyYxwK6uCLk8fm8U2jwxPi0aERsoUgAATeL0A@mail.gmail.com>
 <CAJQfnxGrfKJhCBCVD6kgLHnb4hgspUQPtJ0nSipO2kUOv3bSYQ@mail.gmail.com> <CABBYNZ+ScBp9QbR3ikMzxCyDaUo9PpNo2uaJZzy3ATp35pp=Kg@mail.gmail.com>
In-Reply-To: <CABBYNZ+ScBp9QbR3ikMzxCyDaUo9PpNo2uaJZzy3ATp35pp=Kg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 6 Jan 2021 17:29:04 +0800
Message-ID: <CAJQfnxHzfMk_MdKVzys3zgq=9H1wJB3Qz6ssQYN18aDF0Czmyw@mail.gmail.com>
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

Thanks for the suggestion. I had sent another patch (titled "adapter:
Remove temporary devices before power off") which implements your
idea.
That should make this patch obsolete.

Thanks,
Archie

On Wed, 6 Jan 2021 at 02:33, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Jan 4, 2021 at 7:17 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > Sorry for being unclear.
> >
> >
> > On Tue, 5 Jan 2021 at 03:17, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Mon, Jan 4, 2021 at 11:09 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Mon, Dec 28, 2020 at 10:34 PM Archie Pusaka <apusaka@google.com> wrote:
> > > > >
> > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > >
> > > > > If adapter is powered off when a device is being removed, there is a
> > > > > possibility that the kernel couldn't clean the device's information,
> > > > > for example the pairing information. This causes the kernel to
> > > > > disagree with the user space about whether the device is paired.
> > > > >
> > > > > Therefore, to avoid discrepancy we must not proceed to remove the
> > > > > device within the user space as well.
> > > >
> > > > This sounds like we have a bug in the kernel, aren't we calling
> > > > btd_adapter_remove_bonding or is that failing if the adapter is not
> > > > powered? Hmm it does like it:
> > > >
> > > > This command can only be used when the controller is powered.
> > > >
> > > > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > > > > ---
> > > > >
> > > > >  src/adapter.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index ec6a6a64c5..a2abc46706 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
> > > > >  {
> > > > >         GList *l;
> > > > >
> > > > > +       /* Test if adapter is or will be powered off.
> > > > > +        * This is to prevent removing the device information only on user
> > > > > +        * space, but failing to do so on the kernel.
> > > > > +        */
> > > > > +       if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
> > > > > +                       (adapter->pending_settings & MGMT_SETTING_POWERED))
> > > > > +               return;
> > > >
> > > > We might need to return an error here so we can reply with an error on
> > > > Adapter.RemoveDevice.
> > >
> > Should be unnecessary due to the check you mentioned below.
> >
> > > After some investigation it looks like there is already a similar check:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n3238
> > >
> > > That perhaps needs to updated or perhaps this is the result of the
> > > device being set to temporary which sets a timer to remove the device
> > > and then in the meantime the adapter is powered off? In that case
> > > perhaps we should clean up the devices set as temporary.
> > >
> > The problem occurs when the device is paired and is currently
> > connected, then Adapter.RemoveDevice is called. This would make us
> > disconnect the device first before actually removing the device.
> > During this disconnection phase, there is a chance the adapter is
> > powered off.
> >
> > If this happens, we would still attempt to remove the device anyway.
> > No problem on the user space, but it will fail on the kernel side (as
> > per the API, it requires adapter to be on). The check you mentioned is
> > unfortunately not executed during this phase.
> >
> > About the timer, I didn't have the exact issue you described, but this
> > version of patch might have other problems with it, because the timer
> > would still be running when we do the early return from
> > btd_adapter_remove_device. Although nothing will happen if the timer
> > runs out when the power is still off (we would just do the early
> > return again), but it might be unpleasant if the adapter is re-powered
> > and the timer kicks off to remove the device.
>
> Right, Id guess if RemoveDevice is called and either way we end up
> powering off the adapter I suppose we want the device removed either
> way thus why I suggested cleaning up the temporary devices before
> powering down.
>
> > > > >         adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
> > > > >
> > > > >         adapter->devices = g_slist_remove(adapter->devices, dev);
> > > > > --
> > > > > 2.29.2.729.g45daf8777d-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Archie
>
>
>
> --
> Luiz Augusto von Dentz
