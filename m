Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3585860233
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhETEqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 00:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhETEqn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 00:46:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D067C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 21:45:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q7so21089871lfr.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 21:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zw0nTpXp38z80nGvmgA/4q7PhN9TFnaAJESbmHbZFjU=;
        b=ZyGI9sY8UgGF8Otij2KxxO9EqFYXob2klz+/wcPxXokME8z0EHy2TnqdTr46a618bD
         JrWq9TkiBrMdcf7WWmZLmaNxeEwISX6ziOfss4S1Bb9sRmS1Y1d8mmN8/Zw9PZRw2Cg8
         JR31Rxp03Sd/Y8332e7F2hHIaoiuiTdM3YH6GDVXiJRE7Q66/Kv92Wp0dF5ACWDinktu
         3y3YZQqA87bBududwlipPudo3sR7M8rwATqzi0NFZYS8WLCFLOfyHKnLA7vBGgrSSVxG
         o59YEUEirDfveKD7MZXEL/fwg1o0J2+rLd1HIGaL9edlS8dWOZ9XZte5D75ac+lDYrs/
         f4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zw0nTpXp38z80nGvmgA/4q7PhN9TFnaAJESbmHbZFjU=;
        b=BB0gMPNaFmdTCjryr1XeLasrINvtWzOmQH7nEP6qBH1EdAodFBMhC4WlJnK1UpHKxJ
         PrToG5RQOepRmYTSYecDoBrWJs9bszhOspN6+7e5bHYTfuez6HTZW3XK0oR5CMSGzKhr
         NGlx2GqVuWvAMG8nQ0IFvdIzizaYiKqYsgIcgcaPqGTR905hNY1Kqby4xrpV1pZI3z+o
         SlWrj9RxrhDZ1aHEgsf1qwOWYbc8RFjevt/W0aoxqOF1dukFh82gve1JcfOzvxlTb+pz
         4V5dMDyxHH2BCJQWjNVZTbtR7gMd9Twc+GF+KT9WNEP5EnqNwas8J9m5EVxJRuanprpL
         tCvw==
X-Gm-Message-State: AOAM533dD2rDdJYctFRRaS4Pv06GJ/+Bmshh3/Zow77yvJyU/mZbyH+z
        fRtdJw/mffzxJaDgOqjKUHBIJfH9ZBsBKDseK5E+uQ==
X-Google-Smtp-Source: ABdhPJyhST/2Er7PeAModLsj1LA90lFhThfPsYnLhsrEMfKTFiNTiEItXWGTyC4VikCNwjyX3322IJPpdWXGQozxf5g=
X-Received: by 2002:a05:6512:3145:: with SMTP id s5mr1959086lfi.414.1621485919529;
 Wed, 19 May 2021 21:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org> <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
 <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
In-Reply-To: <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 20 May 2021 12:45:08 +0800
Message-ID: <CAJQfnxG57TKwG3h+jTCg8vcexyPeaKvipN8FjFSFE6=p=L9Fcg@mail.gmail.com>
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

Friendly ping to review this patch again. Thanks!

On Mon, 17 May 2021 at 12:31, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Marcel,
>
> On Fri, 14 May 2021 at 19:40, Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Marcel,
> >
> > On Fri, 14 May 2021 at 03:03, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> > >
> > > Hi Archie,
> > >
> > > >>> RTL8822 chipset supports WBS, and this information is conveyed in
> > > >>> btusb.c. However, the UART driver doesn't have this information j=
ust
> > > >>> yet.
> > > >>>
> > > >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > >>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > >>> ---
> > > >>>
> > > >>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> > > >>> drivers/bluetooth/btrtl.h  |  2 ++
> > > >>> drivers/bluetooth/hci_h5.c |  5 +----
> > > >>> 3 files changed, 19 insertions(+), 14 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.=
c
> > > >>> index e7fe5fb22753..988a09860c6b 100644
> > > >>> --- a/drivers/bluetooth/btrtl.c
> > > >>> +++ b/drivers/bluetooth/btrtl.c
> > > >>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *=
hdev,
> > > >>> }
> > > >>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > > >>>
> > > >>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> > > >>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_=
info *btrtl_dev)
> > > >>> {
> > > >>> -     struct btrtl_device_info *btrtl_dev;
> > > >>> -     int ret;
> > > >>> -
> > > >>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > > >>> -     if (IS_ERR(btrtl_dev))
> > > >>> -             return PTR_ERR(btrtl_dev);
> > > >>> -
> > > >>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > > >>> -
> > > >>>      /* Enable controller to do both LE scan and BR/EDR inquiry
> > > >>>       * simultaneously.
> > > >>>       */
> > > >>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev=
)
> > > >>>              rtl_dev_dbg(hdev, "WBS supported not enabled.");
> > > >>>              break;
> > > >>>      }
> > > >>> +}
> > > >>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> > > >>> +
> > > >>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> > > >>> +{
> > > >>> +     struct btrtl_device_info *btrtl_dev;
> > > >>> +     int ret;
> > > >>> +
> > > >>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> > > >>> +     if (IS_ERR(btrtl_dev))
> > > >>> +             return PTR_ERR(btrtl_dev);
> > > >>> +
> > > >>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> > > >>> +
> > > >>> +     btrtl_set_quirks(hdev, btrtl_dev);
> > > >>>
> > > >>>      btrtl_free(btrtl_dev);
> > > >>>      return ret;
> > > >>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.=
h
> > > >>> index 2a582682136d..260167f01b08 100644
> > > >>> --- a/drivers/bluetooth/btrtl.h
> > > >>> +++ b/drivers/bluetooth/btrtl.h
> > > >>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(stru=
ct hci_dev *hdev,
> > > >>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> > > >>> int btrtl_download_firmware(struct hci_dev *hdev,
> > > >>>                          struct btrtl_device_info *btrtl_dev);
> > > >>> +void btrtl_set_quirks(struct hci_dev *hdev,
> > > >>> +                   struct btrtl_device_info *btrtl_dev);
> > > >>> int btrtl_setup_realtek(struct hci_dev *hdev);
> > > >>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> > > >>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> > > >>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h=
5.c
> > > >>> index 27e96681d583..e0520639f4ba 100644
> > > >>> --- a/drivers/bluetooth/hci_h5.c
> > > >>> +++ b/drivers/bluetooth/hci_h5.c
> > > >>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> > > >>>      /* Give the device some time before the hci-core sends it a =
reset */
> > > >>>      usleep_range(10000, 20000);
> > > >>>
> > > >>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
> > > >>> -      * simultaneously.
> > > >>> -      */
> > > >>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->qu=
irks);
> > > >>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> > > >>
> > > >> any reason why not just setting WBS quirk here?
> > > >
> > > > Hmm, I think WBS is the feature of the chipset and not the transpor=
t.
> > > > Therefore isn't it better to just have it set in one place?
> > > > Setting the quirks here means we need to copy paste the settings fr=
om btrtl.c.
> > >
> > > but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY ri=
ght now, I don=E2=80=99t see the difference.
> >
> > Sorry, I don't get what you mean.
> > With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
> > btrtl.c, so it's together with the WBS quirk.
> >
> > > Can we actually verify that we still need the WBS quirk. I think we f=
ixed the broken errerrnous packet flag handling.
> >
> > To be honest, I am not aware about the story of the broken erroneous
> > packet flag.
> > Last time I checked I still needed the quirk to have RTL8822 on UART
> > properly run WBS, but that was months ago...
> > Let me verify whether this quirk is still needed.
>
> It looks like we still need the WBS quirk because otherwise the host
> wouldn't know whether the controller supports WBS or not. It's used in
> get_supported_settings() in mgmt.c.
>
> > Cheers,
> > Archie
