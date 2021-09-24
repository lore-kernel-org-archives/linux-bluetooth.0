Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB7FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 02:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3FB60C40
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 02:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhIXC7A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhIXC7A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 22:59:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B9CC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 19:57:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so22749604wrw.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGHXGrdGXxK061QNP8riHSRvPlRLcFCMH+WwFTSwsco=;
        b=hQ5rkBWXQ7t648EhHaY0OCvGFbhA2bkJm588PLYdWMPXHOHG58EyzfN6zu1zo+XGoO
         CKM6WyTEtYbHlX8xSa7PGYGK/X9ldHUGR749dJte67eDwrRnVK54SPS/lsnId5HqTV5f
         WZyAKTI6uI0vrDotKrlHl9eJsXTZgkZU6D69lUsX8qU4yPRkWBuYQYU74Ugg8K1R6V5j
         5z1WPHIKsBe5Zb8phN/zThG7Ae9noiZ2Jwuo/c0WHQjJXbyP3keNo7Jb6phmvd6Dsw5i
         4e66nBI/LCPYydO+yLfHGawqYnXEInshmO4wDNBFagnxXSSBd7f1nUG3mvkO6ZH2F5M6
         zM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGHXGrdGXxK061QNP8riHSRvPlRLcFCMH+WwFTSwsco=;
        b=UT0ort74SKPTjSloQH54s0KrLqVDlzzBuMUngLKZOIfwIBS+6H86CGZo37vodfEDB/
         oUqZVOIfzYWiPPkJh2KTdbfw7Egy/AEC5S0S5B2AIVRFZpL+MliFqkqDGCk9JBOyBorO
         wu13k5tTVGblRF60+1rMwU5PVhcsRTQhR2uW+C3EbW7k2xsZu3dEhG0q66QHCN9o+EzK
         3ynBirO8L3PrgY5bbHshggHjBw9AOY09ORR9YmGTB4YToEDluMdxVAHLSySBYaS2tOnH
         xwXNArnAtkZ5xu+e278Op5x0Z/K6K5PklRC78x7FrBQ0SrM46yDcPl13ieXxTMLdNE5x
         HIDg==
X-Gm-Message-State: AOAM5313v4F9CMxUwnB34aJHN6wgv+4vIwX2cYycczJG9taxa6tSmNfT
        dNMsT0+CyVZpSCt4iGLSgZ3FF6PenqVum6b1kGTksA==
X-Google-Smtp-Source: ABdhPJyjOQ8H1S35D/FSttlwfixAH03xCrF6eeNhPa1elL3upAVwNRvlOKMt35hm0uBYVZ/h++orey60VihYJpLV2AU=
X-Received: by 2002:a7b:c947:: with SMTP id i7mr7574919wml.179.1632452245857;
 Thu, 23 Sep 2021 19:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210920125739.111846-1-hdegoede@redhat.com>
In-Reply-To: <20210920125739.111846-1-hdegoede@redhat.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 24 Sep 2021 10:57:15 +0800
Message-ID: <CAJQfnxHarzJOqTjG_-bpgTTna0E3EfcWrrVrvkpyFTwkJeBVkw@mail.gmail.com>
Subject: Re: [PATCH 5.15 regression fix] Bluetooth: hci_h5: Fix
 (runtime)suspend issues on RTL8723BS HCIs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

On Mon, 20 Sept 2021 at 20:57, Hans de Goede <hdegoede@redhat.com> wrote:
>
> The recently added H5_WAKEUP_DISABLE h5->flags flag gets checked in
> h5_btrtl_open(), but it gets set in h5_serdev_probe() *after*
> calling  hci_uart_register_device() and thus after h5_btrtl_open()
> is called, set this flag earlier.
>
> Also on devices where suspend/resume involves fully re-probing the HCI,
> runtime-pm suspend should not be used, make the runtime-pm setup
> conditional on the H5_WAKEUP_DISABLE flag too.
>
> This fixes the HCI being removed and then re-added every 10 seconds
> because it was being reprobed as soon as it was runtime-suspended.
>
> Cc: Archie Pusaka <apusaka@chromium.org>
> Fixes: 66f077dde749 ("Bluetooth: hci_h5: add WAKEUP_DISABLE flag")
> Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

You are correct, I should have checked H5_WAKEUP_DISABLE before using
autosuspend.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>

> ---
>  drivers/bluetooth/hci_h5.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 0c0dedece59c..59b712742d33 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -846,6 +846,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>                 h5->vnd = data->vnd;
>         }
>
> +       if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
> +               set_bit(H5_WAKEUP_DISABLE, &h5->flags);
>
>         h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
>         if (IS_ERR(h5->enable_gpio))
> @@ -860,9 +862,6 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>         if (err)
>                 return err;
>
> -       if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
> -               set_bit(H5_WAKEUP_DISABLE, &h5->flags);
> -

We can simplify by just returning err and not check its value.

>         return 0;
>  }
>
> @@ -962,11 +961,13 @@ static void h5_btrtl_open(struct h5 *h5)
>         serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
>         serdev_device_set_baudrate(h5->hu->serdev, 115200);
>
> -       pm_runtime_set_active(&h5->hu->serdev->dev);
> -       pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
> -       pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
> -                                        SUSPEND_TIMEOUT_MS);
> -       pm_runtime_enable(&h5->hu->serdev->dev);
> +       if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
> +               pm_runtime_set_active(&h5->hu->serdev->dev);
> +               pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
> +               pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
> +                                                SUSPEND_TIMEOUT_MS);
> +               pm_runtime_enable(&h5->hu->serdev->dev);
> +       }
>
>         /* The controller needs up to 500ms to wakeup */
>         gpiod_set_value_cansleep(h5->enable_gpio, 1);
> @@ -976,7 +977,8 @@ static void h5_btrtl_open(struct h5 *h5)
>
>  static void h5_btrtl_close(struct h5 *h5)
>  {
> -       pm_runtime_disable(&h5->hu->serdev->dev);
> +       if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags))
> +               pm_runtime_disable(&h5->hu->serdev->dev);
>
>         gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
>         gpiod_set_value_cansleep(h5->enable_gpio, 0);
> --
> 2.31.1
>

Thanks,
Archie
