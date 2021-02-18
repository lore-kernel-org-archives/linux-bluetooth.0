Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E267C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC6964EC7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBRXmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBRXmE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 18:42:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94CC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 15:41:23 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e5so3511967otb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oj6ZHxOv94XIAouJbOADK9eAQMPtrsE9yiwA1PnlSEY=;
        b=Yc7ItXFWvTNwnOYF2HJ67TSJIA1p0B9D1pCet46BkpPd5INKh0/MnQOO133UvHHsdR
         2DMa+zYhRR4GtZYl0eyM4OfE29Qb3CiLv1sG+YDkwQuJO9JDKw58vGwbZfP6Es6v2HMQ
         k+hm3rI3h0XoLSXtp7bRFqoMjre8Glq1XZJIpU/L7LbjVtHIKk5AB8rTI0MBTH4eAY0C
         v9AtWKhy+RrIc+2k0cf6OHM1oSggCvvhExQ0vEnXXzFvHUk2ZuJIbSkbO9ewsKBmmuGL
         Av97PvtXvlaCJiY9XT7LCtKQpibCeWO+27Tj4EQVuFkGYrqv+WWDOt0xhH26KyYmGBRx
         XjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oj6ZHxOv94XIAouJbOADK9eAQMPtrsE9yiwA1PnlSEY=;
        b=EQtg730XIJ3bfS1dacUR4MDcozC6uuZ2WvtkZ3gidSwS+6ylfaZKFwJxZ2JcFl6E1O
         qcpnkE58VIixsZgq2KVJ9XNFspRY8NiaazdNNVOA8RVmyh4Awlzd7Oh9pOjG1WV8rlEv
         LHWscRqMrYULAbR+fgUb9U/2tuES3KJpWUxjWCFTUg8dRAuEkXvYy/PuS1A1siQldJBb
         x8ky3yKAWj4JGW5nT0tVTdpmdc/m4TWYm4ROsWCNxBcj/OkCNgVQXrt8o8+dfUyPSi/B
         rrgc58MI3Cq6/FYi8TMII9uFEtnWlbwdxc+EktSb5pWDTMpO3oJtrtYj7H/c4vTaY3mE
         Ceig==
X-Gm-Message-State: AOAM5336Lfg/nsvYCDzyRpzjnUi4cMkwoq/7ZKUOAuc5yIcv3jkoOPCl
        +QA/htaJKCdimKzzSyyk9pX/CY3otVYd2a+JGL0=
X-Google-Smtp-Source: ABdhPJx4uIJkzdl5RvcUelyDWYIkIL2CZ23LBjOAPCd+k7T/UzbNisvvSiQpzDuR7iLWJEIYA2Q71dHb8d38S+BtDO0=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr4516173ota.44.1613691683133;
 Thu, 18 Feb 2021 15:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20210218123728.17067-1-hdegoede@redhat.com> <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com> <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
 <6CE927B6-449A-472C-9196-AF98895AA5E1@holtmann.org> <2bf12891-eeae-e55f-ab46-7434dffbad76@redhat.com>
In-Reply-To: <2bf12891-eeae-e55f-ab46-7434dffbad76@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Feb 2021 15:41:12 -0800
Message-ID: <CABBYNZ+euV5rwx=LeLKOGSL0AwnPfE7paEHhNhMiUpXGYixgBw@mail.gmail.com>
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Hui Wang <hui.wang@canonical.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

On Thu, Feb 18, 2021 at 2:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Marcel,
>
> On 2/18/21 9:01 PM, Marcel Holtmann wrote:
> > Hi Hans,
> >
> >>>> drivers/usb/core/hub.c: usb_new_device() contains the following:
> >>> [...]
> >>>>         err =3D hci_register_dev(hdev);
> >>>>       if (err < 0)
> >>>> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interf=
ace *intf)
> >>>>           gpiod_put(data->reset_gpio);
> >>>>         hci_free_dev(hdev);
> >>>> -
> >>>> -    if (!enable_autosuspend)
> >>>> -        usb_enable_autosuspend(data->udev);
> >>> Hi Hans,
> >>>
> >>> And Do we need to call usb_disable_autosuspend() in the disconnect()?=
 like below:
> >>>
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index 32161dd40ed6..ef831492363c 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interfa=
ce *intf)
> >>>
> >>>         hci_unregister_dev(hdev);
> >>>
> >>> +       if (enable_autosuspend)
> >>> +               usb_disable_autosuspend(data->udev);
> >>> +
> >>>         if (intf =3D=3D data->intf) {
> >>>                 if (data->isoc)
> >>> usb_driver_release_interface(&btusb_driver, data->isoc);
> >>>
> >>>
> >>> Before the btusb_probe() is called, the usb device is autosuspend dis=
abled, suppose users set the btusb.enable_autosuspend=3D1, the driver btusb=
 will enable the autosuspend on this device. If users remove this driver, t=
he disconnect() will be called, the usb device will keep autosuspend enable=
d. Next time if users reload this driver by 'sudo modprobe  btusb enalbe_au=
tosuspend=3D0',  they will find the device is autosuspend enabled instead o=
f disabled.
> >>
> >> The problem with calling usb_disable_autosuspend() is that the auto-su=
spend setting is a bool,
> >> rather then a counter, so if a udev-rule or the user manually through =
e.g. :
> >>
> >> echo auto > /sys/bus/usb/devices/1-10/power/control
> >>
> >> Has enabled autosuspend then we would be disabling it, which is undesi=
rable.
> >>
> >> Most USB drivers which have some way of enabling autosuspend by-defaul=
t
> >> (IOW which call usb_enable_autosuspend()) simply enable it at the end
> >> of a successful probe and leave it as is on remove.
> >>
> >> Also keep in mind that remove normally runs on unplug of the device, i=
n
> >> which case it does not matter as the device is going away.
> >>
> >> If a user wants to disable autosuspend after loading the btusb module,
> >> the correct way to do this is by simply running e.g. :
> >>
> >> echo on > /sys/bus/usb/devices/1-10/power/control
> >>
> >> Rather then rmmod-ing and insmod-ing the module with a different modul=
e-param value.
> >
> > then lets remove the module parameter from btusb.ko.
>
> The module parameter is useful to make sure runtime-suspend never gets
> enabled starting from boot onwards, either through the kernel cmdline
> or through modprobe.conf settings.
>
> Also the module parameter is used to implement CONFIG_BT_HCIBTUSB_AUTOSUS=
PEND
> Kconfig option which sets the default value for the module param;
> and most distros enable that option since it having autosuspend enabled
> is the right thing to do in almost all cases.

Actually in case we are connected we should probably disable
autosuspend as some BT controllers don't seem to be able to transmit
any data back to the host if the connection stays idle long enough to
trigger auto suspend.

> Regards,
>
> Hans
>


--=20
Luiz Augusto von Dentz
