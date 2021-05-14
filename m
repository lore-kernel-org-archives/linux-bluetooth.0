Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB6DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C861458
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhENLmR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhENLmR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 07:42:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E2C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 04:41:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t11so42603981lfl.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dyDgBBYohiWUHEQaVWhAuDowFUmWLAU+xoaFS4LStco=;
        b=Czheqcie5CZzNBGYQ2Bi9KJgOmg9T28kJk2Mx6UGkbTW132TJX2d8UfsIuDviplFDF
         2yOx7ypDjZMGkFquIG0aL2vrwyPukiKSl5ll7bjAbxIHJMqBPNrdCaIZStGRcYWtw/hb
         pX/GsYn1qpnz2dSQYZFqYqbO6EjkUj/h1MrEcLwIcSB5kecdgjpMopiG5RDA83xZozGK
         /N/rA7QADPJgCkJjYwVZz56aBZ9c56pRO5F9WqJNyVM6w/cahHoVMu91s83++ayJnSpY
         vaU581Cyf2t2Es63Ci4Fb7wly5asG6OqMVvQboWY6HC5hlGL9ek+sSiro1g0nIbG+pL5
         ULTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dyDgBBYohiWUHEQaVWhAuDowFUmWLAU+xoaFS4LStco=;
        b=P+amqQTzXQDkl4zKTKSzCbx2VFR8AoAg5qpD5G16CiEoCwehGtFtEXkF3tokn1RGo5
         wq8jbY8QMzKZbq/9fHGY0sZqwl45ogaesUWcIMybYXWI1/Bsjazh9d8YlG6HPxMCi467
         p8PbdWPZzrQSn2kXGRgmdhIRHLq6sxXARrlnEeh/IWi4pma3ftgUEImYxvYVlx+u1KRH
         Vd5znQlr8JisnYGK0KcDDgJyu7TEfYyAHcX92BOmRe1R887CvM+yjpK7aOktgFS4ZRu6
         ochlsscdw8+Tp4ZNsdZ5SdQxW6f/LESpZzyXnrcdlzJqi3qcuFoFMbQ2+cSkLhAweZB4
         i+BQ==
X-Gm-Message-State: AOAM532YqLJd5efIjQmNaCc7UrBXbKeI7/drugywOhuYXmN2w1LIFsE0
        dMljyGFDPUYISxypFJ/8IZIRmxbXbgYo02orDQ9aXQ==
X-Google-Smtp-Source: ABdhPJxzKBabSaeS/LSaVvHJnJbzkI4Y47IoCkK1UxQDdIWoVMou4CmyTkIlkIybFnTHE0U8KEsJ/mY2eYnm3P/SGsU=
X-Received: by 2002:a05:6512:6d5:: with SMTP id u21mr32636003lff.586.1620992463856;
 Fri, 14 May 2021 04:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org>
In-Reply-To: <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 14 May 2021 19:40:52 +0800
Message-ID: <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
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

On Fri, 14 May 2021 at 03:03, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>> RTL8822 chipset supports WBS, and this information is conveyed in
> >>> btusb.c. However, the UART driver doesn't have this information just
> >>> yet.
> >>>
> >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >>> ---
> >>>
> >>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> >>> drivers/bluetooth/btrtl.h  |  2 ++
> >>> drivers/bluetooth/hci_h5.c |  5 +----
> >>> 3 files changed, 19 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> >>> index e7fe5fb22753..988a09860c6b 100644
> >>> --- a/drivers/bluetooth/btrtl.c
> >>> +++ b/drivers/bluetooth/btrtl.c
> >>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hdev=
,
> >>> }
> >>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> >>>
> >>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> >>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info=
 *btrtl_dev)
> >>> {
> >>> -     struct btrtl_device_info *btrtl_dev;
> >>> -     int ret;
> >>> -
> >>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>> -     if (IS_ERR(btrtl_dev))
> >>> -             return PTR_ERR(btrtl_dev);
> >>> -
> >>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>> -
> >>>      /* Enable controller to do both LE scan and BR/EDR inquiry
> >>>       * simultaneously.
> >>>       */
> >>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>              rtl_dev_dbg(hdev, "WBS supported not enabled.");
> >>>              break;
> >>>      }
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> >>> +
> >>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> >>> +{
> >>> +     struct btrtl_device_info *btrtl_dev;
> >>> +     int ret;
> >>> +
> >>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>> +     if (IS_ERR(btrtl_dev))
> >>> +             return PTR_ERR(btrtl_dev);
> >>> +
> >>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>> +
> >>> +     btrtl_set_quirks(hdev, btrtl_dev);
> >>>
> >>>      btrtl_free(btrtl_dev);
> >>>      return ret;
> >>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> >>> index 2a582682136d..260167f01b08 100644
> >>> --- a/drivers/bluetooth/btrtl.h
> >>> +++ b/drivers/bluetooth/btrtl.h
> >>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
> >>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> >>> int btrtl_download_firmware(struct hci_dev *hdev,
> >>>                          struct btrtl_device_info *btrtl_dev);
> >>> +void btrtl_set_quirks(struct hci_dev *hdev,
> >>> +                   struct btrtl_device_info *btrtl_dev);
> >>> int btrtl_setup_realtek(struct hci_dev *hdev);
> >>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> >>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> >>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> >>> index 27e96681d583..e0520639f4ba 100644
> >>> --- a/drivers/bluetooth/hci_h5.c
> >>> +++ b/drivers/bluetooth/hci_h5.c
> >>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> >>>      /* Give the device some time before the hci-core sends it a rese=
t */
> >>>      usleep_range(10000, 20000);
> >>>
> >>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
> >>> -      * simultaneously.
> >>> -      */
> >>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks=
);
> >>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> >>
> >> any reason why not just setting WBS quirk here?
> >
> > Hmm, I think WBS is the feature of the chipset and not the transport.
> > Therefore isn't it better to just have it set in one place?
> > Setting the quirks here means we need to copy paste the settings from b=
trtl.c.
>
> but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY right =
now, I don=E2=80=99t see the difference.

Sorry, I don't get what you mean.
With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
btrtl.c, so it's together with the WBS quirk.

> Can we actually verify that we still need the WBS quirk. I think we fixed=
 the broken errerrnous packet flag handling.

To be honest, I am not aware about the story of the broken erroneous
packet flag.
Last time I checked I still needed the quirk to have RTL8822 on UART
properly run WBS, but that was months ago...
Let me verify whether this quirk is still needed.

Cheers,
Archie
