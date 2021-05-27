Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E30DC47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A37A613DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 07:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhE0HG4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhE0HGz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 03:06:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348DEC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 00:05:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so6445061lfr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yK4NtyP2YDloKEM3MRgN2MPiK62c2cwQQp+Gi12UUm0=;
        b=bd/TflAT1QFQ8BRPCZfHrcM/q0Oj8PMqOslGeo/HvkSSeXwPdPZ4i+0B3NuJu51VBC
         ud/fwYG7p9f7k8sCzFyt/6DKrURCGp7iR4fG1DrBdML1AY3zSISxvCFsQTbxTbh/FVhW
         1ggaMD+Ht17wMsnr5Q0rQGIjaGUafhDT5MyQAmnFPoQKm9lFxqgSJPSJZIOfl5gh7vjc
         lKKpjT15DZMGMv2VElJNuqad5S8rf++uCLQLBHaOsmYNcbWytOW6VS74Qo+Xa58PY9sL
         zyXzlZ09kfOlvpyAIBxAqagfzNRB+1aLVEPhKPxy4SylmmxfdKmfk3BH0axzckiR0iii
         i1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yK4NtyP2YDloKEM3MRgN2MPiK62c2cwQQp+Gi12UUm0=;
        b=ZRR2zST0NjXqik+KSftPkegBTz+oqv+OX2f7fOtJjfsw9GNPb97B/xQse0EFTwTrqP
         Orrnllh4RXm2p6gxnDpGTAHSyOxnPoeXcUVwmN+EQvUlo8eHqAasxqLfw/16eUYYab9x
         kHhIJ0gdl8QVRUmqQUA3IOkm8JPjSz9MI88iY/SmT5TYjkcp1bGKKn0AA1iov1fNVmSM
         4AsbTY5vUESew88I5cEBFgLglE1LE/JEA3rGmIhn+uDPAgwLBOkgFNpx4+4p8wYMIx3e
         8wtGpzh4o+7qlDJ4IUGpuAR8b1dMNo+49yldPC8Eozfvwfszfcoaa6zPU35iBVsS5ubL
         e9tA==
X-Gm-Message-State: AOAM531sOvdFia6CoEIW5V6TVwTEoEYCOF2eGsuLFgPGLI2I8ugXqgL0
        MMyw72/bbEQSv3DmsDXM3Ic538f6FST4O6/kEPYvMg==
X-Google-Smtp-Source: ABdhPJx4bMA6MXFlrjrowJpEEpwS5VVepNDaw7TtP8sTCsBHxS0gJ8cwcTZ442OgncQy1EEydmlJuFVleW9Lky0ejng=
X-Received: by 2002:a05:6512:44b:: with SMTP id y11mr1340009lfk.451.1622099120084;
 Thu, 27 May 2021 00:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org> <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
 <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
 <3DB375AF-3BC3-43F3-A1F5-1E3CBF17318D@holtmann.org> <CAJQfnxE+qiPor8xUd8zuJH45LmbrHb8YwcvjrnhkG0LovP1vyw@mail.gmail.com>
 <CAJQfnxErqfZ-+NgT2xeeOADChJxs2hkwkn-qePtJTRcU53BmGw@mail.gmail.com> <14DD0026-DE65-4EAA-B5EF-F98C3407BA1A@holtmann.org>
In-Reply-To: <14DD0026-DE65-4EAA-B5EF-F98C3407BA1A@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 27 May 2021 15:05:09 +0800
Message-ID: <CAJQfnxF6zYr=-t46yjYSev+RtPhhnZep4Vh2AFaARfzoEM8mDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Add RTL8822CS capabilities
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, 26 May 2021 at 22:59, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>>>>>>>> RTL8822 chipset supports WBS, and this information is conveyed =
in
> >>>>>>>>> btusb.c. However, the UART driver doesn't have this information=
 just
> >>>>>>>>> yet.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>>>>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.or=
g>
> >>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> >>>>>>>>> drivers/bluetooth/btrtl.h  |  2 ++
> >>>>>>>>> drivers/bluetooth/hci_h5.c |  5 +----
> >>>>>>>>> 3 files changed, 19 insertions(+), 14 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrt=
l.c
> >>>>>>>>> index e7fe5fb22753..988a09860c6b 100644
> >>>>>>>>> --- a/drivers/bluetooth/btrtl.c
> >>>>>>>>> +++ b/drivers/bluetooth/btrtl.c
> >>>>>>>>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev=
 *hdev,
> >>>>>>>>> }
> >>>>>>>>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> >>>>>>>>>
> >>>>>>>>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>>>>>>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_devic=
e_info *btrtl_dev)
> >>>>>>>>> {
> >>>>>>>>> -     struct btrtl_device_info *btrtl_dev;
> >>>>>>>>> -     int ret;
> >>>>>>>>> -
> >>>>>>>>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>>>>>>>> -     if (IS_ERR(btrtl_dev))
> >>>>>>>>> -             return PTR_ERR(btrtl_dev);
> >>>>>>>>> -
> >>>>>>>>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>>>>>>>> -
> >>>>>>>>>    /* Enable controller to do both LE scan and BR/EDR inquiry
> >>>>>>>>>     * simultaneously.
> >>>>>>>>>     */
> >>>>>>>>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hd=
ev)
> >>>>>>>>>            rtl_dev_dbg(hdev, "WBS supported not enabled.");
> >>>>>>>>>            break;
> >>>>>>>>>    }
> >>>>>>>>> +}
> >>>>>>>>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> >>>>>>>>> +
> >>>>>>>>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>>>>>>> +{
> >>>>>>>>> +     struct btrtl_device_info *btrtl_dev;
> >>>>>>>>> +     int ret;
> >>>>>>>>> +
> >>>>>>>>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>>>>>>>> +     if (IS_ERR(btrtl_dev))
> >>>>>>>>> +             return PTR_ERR(btrtl_dev);
> >>>>>>>>> +
> >>>>>>>>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>>>>>>>> +
> >>>>>>>>> +     btrtl_set_quirks(hdev, btrtl_dev);
> >>>>>>>>>
> >>>>>>>>>    btrtl_free(btrtl_dev);
> >>>>>>>>>    return ret;
> >>>>>>>>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrt=
l.h
> >>>>>>>>> index 2a582682136d..260167f01b08 100644
> >>>>>>>>> --- a/drivers/bluetooth/btrtl.h
> >>>>>>>>> +++ b/drivers/bluetooth/btrtl.h
> >>>>>>>>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(st=
ruct hci_dev *hdev,
> >>>>>>>>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> >>>>>>>>> int btrtl_download_firmware(struct hci_dev *hdev,
> >>>>>>>>>                        struct btrtl_device_info *btrtl_dev);
> >>>>>>>>> +void btrtl_set_quirks(struct hci_dev *hdev,
> >>>>>>>>> +                   struct btrtl_device_info *btrtl_dev);
> >>>>>>>>> int btrtl_setup_realtek(struct hci_dev *hdev);
> >>>>>>>>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> >>>>>>>>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> >>>>>>>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci=
_h5.c
> >>>>>>>>> index 27e96681d583..e0520639f4ba 100644
> >>>>>>>>> --- a/drivers/bluetooth/hci_h5.c
> >>>>>>>>> +++ b/drivers/bluetooth/hci_h5.c
> >>>>>>>>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> >>>>>>>>>    /* Give the device some time before the hci-core sends it a =
reset */
> >>>>>>>>>    usleep_range(10000, 20000);
> >>>>>>>>>
> >>>>>>>>> -     /* Enable controller to do both LE scan and BR/EDR inquir=
y
> >>>>>>>>> -      * simultaneously.
> >>>>>>>>> -      */
> >>>>>>>>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->=
quirks);
> >>>>>>>>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> >>>>>>>>
> >>>>>>>> any reason why not just setting WBS quirk here?
> >>>>>>>
> >>>>>>> Hmm, I think WBS is the feature of the chipset and not the transp=
ort.
> >>>>>>> Therefore isn't it better to just have it set in one place?
> >>>>>>> Setting the quirks here means we need to copy paste the settings =
from btrtl.c.
> >>>>>>
> >>>>>> but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY=
 right now, I don=E2=80=99t see the difference.
> >>>>>
> >>>>> Sorry, I don't get what you mean.
> >>>>> With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
> >>>>> btrtl.c, so it's together with the WBS quirk.
> >>>>>
> >>>>>> Can we actually verify that we still need the WBS quirk. I think w=
e fixed the broken errerrnous packet flag handling.
> >>>>>
> >>>>> To be honest, I am not aware about the story of the broken erroneou=
s
> >>>>> packet flag.
> >>>>> Last time I checked I still needed the quirk to have RTL8822 on UAR=
T
> >>>>> properly run WBS, but that was months ago...
> >>>>> Let me verify whether this quirk is still needed.
> >>>>
> >>>> It looks like we still need the WBS quirk because otherwise the host
> >>>> wouldn't know whether the controller supports WBS or not. It's used =
in
> >>>> get_supported_settings() in mgmt.c.
> >>>
> >>> and why not set it unconditionally for all Realtek chips?
> >>
> >> Not all Realtek chips supports WBS, therefore
> >> HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED is only set on some of them.
> >
> > Are there any other concerns you might have?
>
> can we do the quirk setting in btrtl_setup_realtek() instead of creating =
another exported function.

It cannot be done easily since the first part of btrtl_setup_realtek()
is used exclusively for btusb, which is done differently in hci_h5.

We can have it another way: define btrtl_setup_realtek_h5() to do the
setup for h5 part in btrtl.c. This would effectively move all of
h5_btrtl_setup() inside hci_h5.c, most notably the serdev setup. In
turn, we don't have to expose btrtl_set_quirks(), and we can even hide
btrtl_initialize(), btrtl_free(), and btrtl_download_firmware() inside
btrtl.c.
I'm not sure though why would one want that? We still need to export
the new btrtl_setup_realtek_h5().

BTW I just noticed I missed a declaration in btrtl.h, so I will send a
v2 patch to fix it.

Cheers,
Archie
