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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B0DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 05:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89877611AE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 05:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhECFdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 01:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECFdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 01:33:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0AC06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 May 2021 22:32:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s25so5433575lji.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 May 2021 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+x9X+bH9sVIQ7YhvysouTeiyyXRivn1vpvp9jCbJ/A=;
        b=MlUPJ8cVgmBivf5rX8Cdn25uK5zo5i6ImJV9Xvcp1dTtH+2/zGlukHMVhK7Cp+i1Ly
         jn/Sa5pWbXbVw4raldm7Pt0215esET2yMzV5Wf/h/m6NXP1UDpjP7R4wdm1kbiy2GtWi
         w4Kkq1KwliNHOsLIXL0uxGzokOpHnsJdfR5c0r/7RvE6d0AENXCw3vgXi3GwIGteWvNG
         FcjidFNOFxVOQ8RaFMEyFAo3kO0th4X2q7BPIrHeOthIUJB9aRW0SMOc7ZIgz0RPQpNT
         KKWzwWJjUDaISDq2cYwE+z5o9tdePsLLc9cdV/2AZA7skfrCbp3SENw2oyWXIa9VSDFX
         WcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+x9X+bH9sVIQ7YhvysouTeiyyXRivn1vpvp9jCbJ/A=;
        b=IzAHnOTyXOKcFjDWQt/ka6b4p/sYi58tGMEtBl5M+xK7J6XmeFILhNDjfCLnlZk5k7
         t78ssxDDZm/ORo0zH5/fD6/4CqYmN5ZyOiuIqFlKONuVhdDfNCZxMhIIWewuVSFpphCu
         bHEbsXo981Jn9CRSoQtHE+wIkIBYyGE8bHUoJ5CAdeta/shIP5AhTpgOOK+ivmq8VVgp
         uf1Sf6djLd790PC+Q4yPvExZUygYI7bWRttJzadVBPMtWG+cpxa0UI9EYK5v0lgi0O75
         D87o9Yw0DvAIBpetrImitWAaxqdy9oelddCPmXAihDRHDuFgGg5D/ccKTV4O9dd1S8ew
         rqTQ==
X-Gm-Message-State: AOAM5314mcjcOFDHt3dMyFjtwJ/zf6PSo3l2toRQn/K2Am4ir4s1xzO+
        RxHxmFFBCJiPirqb73TlDIFoGR7g0R9LbTluiM6WFQ==
X-Google-Smtp-Source: ABdhPJx4yaGFvb9iHAdHysyvdFWzFQ1snaGsMOViAQAGAMCBJHwCSKUUuMB0yV4s0/wZFQdgBb/wlvsz2z0EXdDzRpw=
X-Received: by 2002:a2e:8797:: with SMTP id n23mr12234159lji.347.1620019969150;
 Sun, 02 May 2021 22:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775@changeid>
In-Reply-To: <20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 3 May 2021 13:32:38 +0800
Message-ID: <CAJQfnxHcag62zp4_0R9=KomC7FJB=xaRbmfaHsTp8JrOgkV9Pg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Add driver capabilities for RTL8822CS
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     drinkcat@chromium.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi maintainers,

Could you take another look at this patch?

Thanks,
Archie


On Sat, 10 Oct 2020 at 04:32, Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Certain controller capabilities must be exposed by the driver because it
> can't be queried from HCI (wideband speech support, for example). Update
> the match data structure to set the supported capabilities and set the
> proper quirks on hdev after registering the device.
>
> Also update the 8822CS capabilities to show it supports wideband speech
> and has valid le states (allows central peripheral role).
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  drivers/bluetooth/hci_h5.c | 53 +++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index a10d710fc3f13e..3833a2d276665f 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -97,6 +97,11 @@ struct h5 {
>         struct gpio_desc *device_wake_gpio;
>  };
>
> +enum h5_capabilities {
> +       H5_CAP_WIDEBAND_SPEECH = BIT(0),
> +       H5_CAP_VALID_LE_STATES = BIT(1),
> +};
> +
>  struct h5_vnd {
>         int (*setup)(struct h5 *h5);
>         void (*open)(struct h5 *h5);
> @@ -106,6 +111,11 @@ struct h5_vnd {
>         const struct acpi_gpio_mapping *acpi_gpio_map;
>  };
>
> +struct h5_device_data {
> +       uint32_t capabilities;
> +       struct h5_vnd *vnd;
> +};
> +
>  static void h5_reset_rx(struct h5 *h5);
>
>  static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
> @@ -791,7 +801,10 @@ static const struct hci_uart_proto h5p = {
>  static int h5_serdev_probe(struct serdev_device *serdev)
>  {
>         struct device *dev = &serdev->dev;
> +       struct hci_dev *hdev;
>         struct h5 *h5;
> +       const struct h5_device_data *data;
> +       int err;
>
>         h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
>         if (!h5)
> @@ -808,23 +821,21 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>                 if (!match)
>                         return -ENODEV;
>
> -               h5->vnd = (const struct h5_vnd *)match->driver_data;
> +               data = (const struct h5_device_data *)match->driver_data;
> +               h5->vnd = data->vnd;
>                 h5->id  = (char *)match->id;
>
>                 if (h5->vnd->acpi_gpio_map)
>                         devm_acpi_dev_add_driver_gpios(dev,
>                                                        h5->vnd->acpi_gpio_map);
>         } else {
> -               const void *data;
> -
>                 data = of_device_get_match_data(dev);
>                 if (!data)
>                         return -ENODEV;
>
> -               h5->vnd = (const struct h5_vnd *)data;
> +               h5->vnd = data->vnd;
>         }
>
> -
>         h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
>         if (IS_ERR(h5->enable_gpio))
>                 return PTR_ERR(h5->enable_gpio);
> @@ -834,7 +845,20 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>         if (IS_ERR(h5->device_wake_gpio))
>                 return PTR_ERR(h5->device_wake_gpio);
>
> -       return hci_uart_register_device(&h5->serdev_hu, &h5p);
> +       err = hci_uart_register_device(&h5->serdev_hu, &h5p);
> +       if (err)
> +               return err;
> +
> +       hdev = h5->serdev_hu.hdev;
> +
> +       /* Set match specific quirks */
> +       if (data->capabilities & H5_CAP_WIDEBAND_SPEECH)
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> +
> +       if (data->capabilities & H5_CAP_VALID_LE_STATES)
> +               set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +
> +       return 0;
>  }
>
>  static void h5_serdev_remove(struct serdev_device *serdev)
> @@ -1000,12 +1024,21 @@ static struct h5_vnd rtl_vnd = {
>         .resume         = h5_btrtl_resume,
>         .acpi_gpio_map  = acpi_btrtl_gpios,
>  };
> +
> +static const struct h5_device_data h5_data_rtl8822cs = {
> +       .capabilities = H5_CAP_WIDEBAND_SPEECH | H5_CAP_VALID_LE_STATES,
> +       .vnd = &rtl_vnd,
> +};
> +
> +static const struct h5_device_data h5_data_rtl8723bs = {
> +       .vnd = &rtl_vnd,
> +};
>  #endif
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id h5_acpi_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
> -       { "OBDA8723", (kernel_ulong_t)&rtl_vnd },
> +       { "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs},
>  #endif
>         { },
>  };
> @@ -1019,9 +1052,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
>  static const struct of_device_id rtl_bluetooth_of_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
>         { .compatible = "realtek,rtl8822cs-bt",
> -         .data = (const void *)&rtl_vnd },
> +         .data = &h5_data_rtl8822cs,
> +       },
>         { .compatible = "realtek,rtl8723bs-bt",
> -         .data = (const void *)&rtl_vnd },
> +         .data = &h5_data_rtl8723bs,
> +       },
>  #endif
>         { },
>  };
> --
> 2.28.0.1011.ga647a8990f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chromium.org.
> To view this discussion on the web visit https://groups.google.com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775%40changeid.
