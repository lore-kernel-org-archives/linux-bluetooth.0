Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51FC47088
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2661610FA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEZFvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhEZFvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:51:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3EC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:49:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i9so668047lfe.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fqSc2l5mo5sBTBZukDBZ73kRYhYKhOPc/CnIaeSpNLo=;
        b=gwthCDi37VQYQzOr4lhRnnsp60U4qJYDQnvysWHFcPS3zYIMjFXNS4YpV3GQiYMHw/
         7xPCo7Bd6h+divbGo0b4GkIfi9oLH4G4dvmKk4eRocafIt+B28vwzCMML3imIJ2dzgcS
         +sfLBLgT5KI+DwC6Hs6QQboCQc3akM5QIj+GJDLLSrBXK54emwoRR6N4FcIVosAGHW5m
         H2grtZrJiYsrYmo8S3i6l5WG1p9Fqd+4aY3RRseZvX95sh5DDCntkjaD/fxItxW9x3t9
         TWtz9pxrAI0kRb6qEjUdL4SJIeAqtb0mInSarXa/ZEnwipwwz4I60tAFuoQQYgqn4Dcc
         9Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fqSc2l5mo5sBTBZukDBZ73kRYhYKhOPc/CnIaeSpNLo=;
        b=HMUt7vaF5MOD2WV7TrMP0e0gvvytsRo8bhvcP+iesVWNOKxdMxjwGzLxwzTgC0LlUe
         qiRBOMxu814grLJj37+dmoZXMguFtzLbqXYBjDyDUvMxy/c7+v4mWirpI27aR8a0e5GZ
         7bV1MVBrY8Agzl1wB6rkIMnC2uA72shdoU8A2LXhK0VvuNySC3rGLdBHwSrUOniNkApP
         iB1wC5N/GejrSyj4ab3zR0vtGLM3PlonrFVsuz6P3cCeyt+LTkKraCrQyJ/wXBMpMWLy
         XdaOsvxJaxDJ/97djvQBqeAr/eyp2KLJq6ysW6mh/uIVG6S/Z7FMJQQ7mad652R5FsK3
         SfFA==
X-Gm-Message-State: AOAM53242MiSJw3Pojuovkab7vB82M6N65Xo6HU8aOhHw7Co03pcOjyl
        Z5XC3mxk57ExfrDW/Rg393pMoUpirXLPdd8IvlXdAg==
X-Google-Smtp-Source: ABdhPJxALtjX8kLkZsnCaY0xaO6sQnZPeTH9N7RlkPuUT/hk9yOHNHQI6QxGmOOVNlOf8+GZmngS3PWqe9QnQy/5sLg=
X-Received: by 2002:a19:85c5:: with SMTP id h188mr975618lfd.121.1622008197482;
 Tue, 25 May 2021 22:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org> <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
 <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
 <3DB375AF-3BC3-43F3-A1F5-1E3CBF17318D@holtmann.org> <CAJQfnxE+qiPor8xUd8zuJH45LmbrHb8YwcvjrnhkG0LovP1vyw@mail.gmail.com>
In-Reply-To: <CAJQfnxE+qiPor8xUd8zuJH45LmbrHb8YwcvjrnhkG0LovP1vyw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 26 May 2021 13:49:46 +0800
Message-ID: <CAJQfnxErqfZ-+NgT2xeeOADChJxs2hkwkn-qePtJTRcU53BmGw@mail.gmail.com>
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

On Fri, 21 May 2021 at 00:02, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Marcel,
>
> On Thu, 20 May 2021 at 23:18, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> >
> > Hi Archie,
> >
> > >>>>>> RTL8822 chipset supports WBS, and this information is conveyed i=
n
> > >>>>>> btusb.c. However, the UART driver doesn't have this information =
just
> > >>>>>> yet.
> > >>>>>>
> > >>>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > >>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org=
>
> > >>>>>> ---
> > >>>>>>
> > >>>>>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> > >>>>>> drivers/bluetooth/btrtl.h  |  2 ++
> > >>>>>> drivers/bluetooth/hci_h5.c |  5 +----
> > >>>>>> 3 files changed, 19 insertions(+), 14 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl=
.c
> > >>>>>> index e7fe5fb22753..988a09860c6b 100644
> > >>>>>> --- a/drivers/bluetooth/btrtl.c
> > >>>>>> +++ b/drivers/bluetooth/btrtl.c
> > >>>>>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev =
*hdev,
> > >>>>>> }
> > >>>>>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > >>>>>>
> > >>>>>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> > >>>>>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device=
_info *btrtl_dev)
> > >>>>>> {
> > >>>>>> -     struct btrtl_device_info *btrtl_dev;
> > >>>>>> -     int ret;
> > >>>>>> -
> > >>>>>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > >>>>>> -     if (IS_ERR(btrtl_dev))
> > >>>>>> -             return PTR_ERR(btrtl_dev);
> > >>>>>> -
> > >>>>>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > >>>>>> -
> > >>>>>>     /* Enable controller to do both LE scan and BR/EDR inquiry
> > >>>>>>      * simultaneously.
> > >>>>>>      */
> > >>>>>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hde=
v)
> > >>>>>>             rtl_dev_dbg(hdev, "WBS supported not enabled.");
> > >>>>>>             break;
> > >>>>>>     }
> > >>>>>> +}
> > >>>>>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> > >>>>>> +
> > >>>>>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> > >>>>>> +{
> > >>>>>> +     struct btrtl_device_info *btrtl_dev;
> > >>>>>> +     int ret;
> > >>>>>> +
> > >>>>>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > >>>>>> +     if (IS_ERR(btrtl_dev))
> > >>>>>> +             return PTR_ERR(btrtl_dev);
> > >>>>>> +
> > >>>>>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > >>>>>> +
> > >>>>>> +     btrtl_set_quirks(hdev, btrtl_dev);
> > >>>>>>
> > >>>>>>     btrtl_free(btrtl_dev);
> > >>>>>>     return ret;
> > >>>>>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl=
.h
> > >>>>>> index 2a582682136d..260167f01b08 100644
> > >>>>>> --- a/drivers/bluetooth/btrtl.h
> > >>>>>> +++ b/drivers/bluetooth/btrtl.h
> > >>>>>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(str=
uct hci_dev *hdev,
> > >>>>>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> > >>>>>> int btrtl_download_firmware(struct hci_dev *hdev,
> > >>>>>>                         struct btrtl_device_info *btrtl_dev);
> > >>>>>> +void btrtl_set_quirks(struct hci_dev *hdev,
> > >>>>>> +                   struct btrtl_device_info *btrtl_dev);
> > >>>>>> int btrtl_setup_realtek(struct hci_dev *hdev);
> > >>>>>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> > >>>>>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> > >>>>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_=
h5.c
> > >>>>>> index 27e96681d583..e0520639f4ba 100644
> > >>>>>> --- a/drivers/bluetooth/hci_h5.c
> > >>>>>> +++ b/drivers/bluetooth/hci_h5.c
> > >>>>>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> > >>>>>>     /* Give the device some time before the hci-core sends it a =
reset */
> > >>>>>>     usleep_range(10000, 20000);
> > >>>>>>
> > >>>>>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
> > >>>>>> -      * simultaneously.
> > >>>>>> -      */
> > >>>>>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->q=
uirks);
> > >>>>>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> > >>>>>
> > >>>>> any reason why not just setting WBS quirk here?
> > >>>>
> > >>>> Hmm, I think WBS is the feature of the chipset and not the transpo=
rt.
> > >>>> Therefore isn't it better to just have it set in one place?
> > >>>> Setting the quirks here means we need to copy paste the settings f=
rom btrtl.c.
> > >>>
> > >>> but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY =
right now, I don=E2=80=99t see the difference.
> > >>
> > >> Sorry, I don't get what you mean.
> > >> With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
> > >> btrtl.c, so it's together with the WBS quirk.
> > >>
> > >>> Can we actually verify that we still need the WBS quirk. I think we=
 fixed the broken errerrnous packet flag handling.
> > >>
> > >> To be honest, I am not aware about the story of the broken erroneous
> > >> packet flag.
> > >> Last time I checked I still needed the quirk to have RTL8822 on UART
> > >> properly run WBS, but that was months ago...
> > >> Let me verify whether this quirk is still needed.
> > >
> > > It looks like we still need the WBS quirk because otherwise the host
> > > wouldn't know whether the controller supports WBS or not. It's used i=
n
> > > get_supported_settings() in mgmt.c.
> >
> > and why not set it unconditionally for all Realtek chips?
>
> Not all Realtek chips supports WBS, therefore
> HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED is only set on some of them.

Are there any other concerns you might have?

Cheers,
Archie
