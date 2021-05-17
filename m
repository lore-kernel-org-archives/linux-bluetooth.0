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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292AFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 04:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D7C6109F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 04:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEQEdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 00:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEQEdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 00:33:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E6C061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 May 2021 21:31:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c15so5527058ljr.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 May 2021 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3iLQ1tptdplZl/aA36a0VSppXS1DKptyQ7u4dZiuFvw=;
        b=htGSXP2RKllOoPfes+o5aRs8N2SAYwNscFGSNbl9cx5FhQ9rViWuCBFdPR36VqoBsK
         Yi3FnyGyt1dzyMOrBDqX1lD1gDoLSqakbv0GVZiGh+DtSmt+pI5jEyuv2m3mbbTlGzp0
         aIdSlhpb0vcg4sFVEJ9Zz3rRzMPFnA71fZLsUQIjTZnlikSv5BX7fmtjePmriTaTkEzn
         Cv6Fs5H4z1aKLQ35eL2Ltym6CA0CX9N2wWuXrWALTDfXPiWdiAGKaYx80gEVKIli4ZUX
         0D79p6ZJejHmCI1lOqC82Jzm+t7Rkc6lFOcyTPF4Lvr6F1Ud+eX7BOrvAab29mtGdvSs
         T4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3iLQ1tptdplZl/aA36a0VSppXS1DKptyQ7u4dZiuFvw=;
        b=R1BWFssWdpR6Zs4hu7MA6ZUsyh3Lzv6joKGhmf93hP+66BhowtyGen6npwC3i5DPyt
         fy4Jb33/W4ABN4VYpIZVbBQiR3nfj4PSNr9+Skpz240a2Fsj+PQHEqFyLRQufBN1LyGe
         k5QWhyXMes0mQXcxbG/57HWCmrGhD+GyaG5sELbL4hH3Qv/rBLLZm6wsYUQrVxGBgSyv
         uRxMcvLOYtHsi/DPA2xIyPfDQn2PoxsZMrpcJK8irrOHjIEzbN2qRPG3hf++ir6j+i/p
         PLsbbkTB70ljl1EaUk26QR+YIevwt6ni2LcGZvK5bHMyB6kufe7UR4kUd3vmGVXCSGpP
         g1VA==
X-Gm-Message-State: AOAM533Pt5bxfLKB/1FMnOVgwyDdBk7zNYq/X1UqWmOZKecOpTXYE3eq
        GvWqWKsQ8sFILDat0ZniCbGxLysJXpFmu2nq3Cq7sA==
X-Google-Smtp-Source: ABdhPJy9XKM6yMZGl/SkQSsxH9fddXvLgPCMEc4WrJH0e325bQpEilNCV6FPBbChgfnUa8E3aFcGaY9aVg0IP//PUgI=
X-Received: by 2002:a2e:9896:: with SMTP id b22mr47225301ljj.329.1621225913369;
 Sun, 16 May 2021 21:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org> <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
In-Reply-To: <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 17 May 2021 12:31:42 +0800
Message-ID: <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
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

On Fri, 14 May 2021 at 19:40, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Marcel,
>
> On Fri, 14 May 2021 at 03:03, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> >
> > Hi Archie,
> >
> > >>> RTL8822 chipset supports WBS, and this information is conveyed in
> > >>> btusb.c. However, the UART driver doesn't have this information jus=
t
> > >>> yet.
> > >>>
> > >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > >>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > >>> ---
> > >>>
> > >>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> > >>> drivers/bluetooth/btrtl.h  |  2 ++
> > >>> drivers/bluetooth/hci_h5.c |  5 +----
> > >>> 3 files changed, 19 insertions(+), 14 deletions(-)
> > >>>
> > >>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > >>> index e7fe5fb22753..988a09860c6b 100644
> > >>> --- a/drivers/bluetooth/btrtl.c
> > >>> +++ b/drivers/bluetooth/btrtl.c
> > >>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hd=
ev,
> > >>> }
> > >>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > >>>
> > >>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> > >>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_in=
fo *btrtl_dev)
> > >>> {
> > >>> -     struct btrtl_device_info *btrtl_dev;
> > >>> -     int ret;
> > >>> -
> > >>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > >>> -     if (IS_ERR(btrtl_dev))
> > >>> -             return PTR_ERR(btrtl_dev);
> > >>> -
> > >>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > >>> -
> > >>>      /* Enable controller to do both LE scan and BR/EDR inquiry
> > >>>       * simultaneously.
> > >>>       */
> > >>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> > >>>              rtl_dev_dbg(hdev, "WBS supported not enabled.");
> > >>>              break;
> > >>>      }
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> > >>> +
> > >>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> > >>> +{
> > >>> +     struct btrtl_device_info *btrtl_dev;
> > >>> +     int ret;
> > >>> +
> > >>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > >>> +     if (IS_ERR(btrtl_dev))
> > >>> +             return PTR_ERR(btrtl_dev);
> > >>> +
> > >>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > >>> +
> > >>> +     btrtl_set_quirks(hdev, btrtl_dev);
> > >>>
> > >>>      btrtl_free(btrtl_dev);
> > >>>      return ret;
> > >>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> > >>> index 2a582682136d..260167f01b08 100644
> > >>> --- a/drivers/bluetooth/btrtl.h
> > >>> +++ b/drivers/bluetooth/btrtl.h
> > >>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev,
> > >>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> > >>> int btrtl_download_firmware(struct hci_dev *hdev,
> > >>>                          struct btrtl_device_info *btrtl_dev);
> > >>> +void btrtl_set_quirks(struct hci_dev *hdev,
> > >>> +                   struct btrtl_device_info *btrtl_dev);
> > >>> int btrtl_setup_realtek(struct hci_dev *hdev);
> > >>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> > >>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> > >>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.=
c
> > >>> index 27e96681d583..e0520639f4ba 100644
> > >>> --- a/drivers/bluetooth/hci_h5.c
> > >>> +++ b/drivers/bluetooth/hci_h5.c
> > >>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> > >>>      /* Give the device some time before the hci-core sends it a re=
set */
> > >>>      usleep_range(10000, 20000);
> > >>>
> > >>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
> > >>> -      * simultaneously.
> > >>> -      */
> > >>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quir=
ks);
> > >>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> > >>
> > >> any reason why not just setting WBS quirk here?
> > >
> > > Hmm, I think WBS is the feature of the chipset and not the transport.
> > > Therefore isn't it better to just have it set in one place?
> > > Setting the quirks here means we need to copy paste the settings from=
 btrtl.c.
> >
> > but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY righ=
t now, I don=E2=80=99t see the difference.
>
> Sorry, I don't get what you mean.
> With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
> btrtl.c, so it's together with the WBS quirk.
>
> > Can we actually verify that we still need the WBS quirk. I think we fix=
ed the broken errerrnous packet flag handling.
>
> To be honest, I am not aware about the story of the broken erroneous
> packet flag.
> Last time I checked I still needed the quirk to have RTL8822 on UART
> properly run WBS, but that was months ago...
> Let me verify whether this quirk is still needed.

It looks like we still need the WBS quirk because otherwise the host
wouldn't know whether the controller supports WBS or not. It's used in
get_supported_settings() in mgmt.c.

> Cheers,
> Archie
