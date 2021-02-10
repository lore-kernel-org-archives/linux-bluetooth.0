Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB88164E0B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 10:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBJKkf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 05:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhBJKiR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 05:38:17 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B710C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 02:37:37 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q5so1346597ilc.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 02:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxifE+FrLS1X49k5wbrrTitDpayGrp62aCO6ryDI7Ww=;
        b=i2KxmGhXP6mgzJ4o3Hkme9qaNz+eEabHQ/j8pIstBP/gR9Vm5XjvC8gajIBEp/mxO9
         7sSinnC1jCtrnJIQ6KmjPCj/JKLZ/tRTmWOza0Tzbi7N6Zq2/cAcrvMubQTKnIe9BfQZ
         jEnBsY+U9hdMjtHtlgRMYE6WYMnLsIKeTFuLSNSzirxMTopOb0nPviyPRF1B/kHOhlfe
         XK25af/T7zUkeHURYEKmh5lTY9M4HBtIoZD4qp/7FlzB/kNYBVsSKPUd/wgKRclipn0S
         a5GqA8K+nrt6cN+h35VV/rjGSLqunn/OA88eFuqvsRQewTanLM/+1d7LLi9GaDXvvEZf
         yOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxifE+FrLS1X49k5wbrrTitDpayGrp62aCO6ryDI7Ww=;
        b=d2KyymD9rE2WrScKrIYKS402SX4IJAmT8Q6xYzxitOAHbdf6OzGLq52FwOzE8OMkst
         bNbfjY8TWu4RT8ETjrCTkFDlkFD6GnhS4qOhFaTjhOLdHgWCJelke+GotvryymxJwP5G
         Ktj2k5Wb71/QKUdQESLklR6Yc38OYJwlEXz8vIN0mDdbLpCUsiV8D6JhKzYPRJmTJGf1
         VasJ9ONG4zNrHwV+FhlA8sQkKfF6VBiVg9Yr3lRzfDhuC9A7bsyL9rGGoJBpsOsQV8eH
         EJcEIEdt9IrRtwubc0b6M4wSpe6x6MosLuqR529+OGQI5yHmgMseSEfw2jRZmYf+ywkC
         Dh2g==
X-Gm-Message-State: AOAM531W3Bo5b2Xj/bRDJCRKYkfhm8vb/uKdVke7KeIz01dWUyhuTOWo
        nZbAIAdi7iSjwRYsVsoQ5D3/Mnxol0u28MORiPWFFcxrBoB78A==
X-Google-Smtp-Source: ABdhPJx4MvM2z2MTxjI3/2xhLBoMU2Tb6tr5p+yGUuTMIDWh9wt/RhiGUmxaTkGY5Wii4/oSmOcrJPtx77rBFffs1MQ=
X-Received: by 2002:a92:d485:: with SMTP id p5mr405445ilg.114.1612953456531;
 Wed, 10 Feb 2021 02:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20210209114024.2910-1-falbrechtskirchinger@gmail.com>
 <20210209114024.2910-2-falbrechtskirchinger@gmail.com> <94DD2143-175D-4FAC-B001-D4F362DC604C@holtmann.org>
In-Reply-To: <94DD2143-175D-4FAC-B001-D4F362DC604C@holtmann.org>
From:   Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
Date:   Wed, 10 Feb 2021 11:37:24 +0100
Message-ID: <CAHOGuTyuxdrtBe339aOczsVjXOmyMLYoGu6Dd25X_bt8a-rZ2w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fallback to 16 bit ROM version lookup
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Feb 9, 2021 at 2:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Florian,
>
> > Commit b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
> > support") changes ROM version lookup from 16 bit to 32 bit. Previously, the
> > upper 16 bit of the version number were ignored. This breaks setups, where the
> > upper 16 bits are non-zero, but are now assumed to be zero.
> >
> > An example of such a device would be
> > 0cf3:3008 Qualcomm Atheros Communications Bluetooth (AR3011)
> > with ROM version 0x1020200 and this corresponding entry in the device table:
> > { 0x00000200, 28, 4, 16 }, /* Rome 2.0 */
> >
> > This patch adds a potential second round of lookups that mimics the old
> > behavior, should no version have been matched by comparing the full 32 bits.
> > During this second round only the lower 16 bits are compared, but only where
> > the upper 16 bits are defined zero in the lookup table.
> >
> > Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
> > support")
> >
> > Signed-off-by: Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
> > ---
> > drivers/bluetooth/btusb.c | 17 ++++++++++++++++-
> > 1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 03b83aa91277..d8c4c6474f14 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4054,6 +4054,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> >       const struct qca_device_info *info = NULL;
> >       struct qca_version ver;
> >       u32 ver_rom;
> > +     u16 ver_rom_low;
> >       u8 status;
> >       int i, err;
> >
> > @@ -4065,8 +4066,22 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> >       ver_rom = le32_to_cpu(ver.rom_version);
> >
> >       for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
> > -             if (ver_rom == qca_devices_table[i].rom_version)
> > +             if (ver_rom == qca_devices_table[i].rom_version) {
> >                       info = &qca_devices_table[i];
> > +                     break;
> > +             }
> > +     }
> > +     if (!info) {
> > +             // If we don't find an exact version match, try with
> > +             // the lower half, but only where the upper half is 0
>
> please use correct comment style.
Noted for next time. I would've expected checkpatch.pl to catch issues
like that?
A proper fix by Hui Wang has already been committed to bluetooth-next.

> > +             ver_rom_low = ver_rom & 0xffff;
> > +             for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
> > +                     if (!(qca_devices_table[i].rom_version & 0xffff0000) &&
> > +                         ver_rom_low == qca_devices_table[i].rom_version) {
> > +                             info = &qca_devices_table[i];
> > +                             break;
> > +                     }
> > +             }
> >       }
> >       if (!info) {
> >               bt_dev_err(hdev, "don't support firmware rome 0x%x", ver_rom);
>
> Regards
>
> Marcel

- Florian
