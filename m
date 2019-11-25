Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B1C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EF620870
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6Gi/KQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKYRwy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:52:54 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40858 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKYRwy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 12:52:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id i3so6094799qvv.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOxNYqzU89MqU1PCUrQBuyOezF6La6jeXCO4IlpvZZE=;
        b=T6Gi/KQ/gK7wxHo0B6VxSNQTqeNhGcB4DXYNtZOnEbxQDscSNE0McqFPeTZJDDjBx7
         BNkR6OK6CgmzKwRbzWwLL2VbIOSAosxeJddn5nachIdY86nuBSl6ib2si/plak+yrtr8
         AJh/+b2uqryidmoVto5FBiszmhZMleYunnjhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOxNYqzU89MqU1PCUrQBuyOezF6La6jeXCO4IlpvZZE=;
        b=Wm05LLU1x3yD/huX5o4r31NMpUpXC5kky0AYEEt1jLHVhSQkjT1vl1N4JcsEl/64c0
         6pGK2D3OzlqQi2c1a8qRJhzZ4zTHP0e9V2ri8/Qtwo8Lkx9KK8dQG2tzVm/SawGLaoOF
         p3aBkMzdNkUasFkX3lXmimt7PPnMFvAI68vi+iWmO/CF1IlRMmpq+s+2XhqCpzN6PMij
         lssFcPI0mMHoHJO8FpN38Y0uHhD0Krwmniu9mAi1UhgK1Nz6IfZpjqmMm8TkXsIKFvnU
         svO/nAhd1jET6dHE1dT2fsHaNYPmC3JdxdDDQd5RG/aBdllnG47oiuHb7rvPmg8n7V66
         V2dQ==
X-Gm-Message-State: APjAAAVExWuPHrBSdeATQQd+kO5DPy4V8dhWrZwGvKl0EGxRco3eIuda
        q2II+9PSAOdDKD+vz6cm0WzyNyJgDnS86PcrWPNDSeD+
X-Google-Smtp-Source: APXvYqw8RuHJhPNCMKt64vtzUF0kBO1hEtWBdRuTJF/i12FrR4V0SEJPryCcYT3ZrAnWZ0X0oqcBhQaHaMaUlTZ8g/U=
X-Received: by 2002:a05:6214:547:: with SMTP id ci7mr28830594qvb.32.1574704371459;
 Mon, 25 Nov 2019 09:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20191123100111.219190-1-marcel@holtmann.org>
In-Reply-To: <20191123100111.219190-1-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 25 Nov 2019 09:52:40 -0800
Message-ID: <CANFp7mWUtWqs8JaC7hvs1gEq0QKt3rx9C+YnxsG3cPwPr4DuLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 23, 2019 at 2:01 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Without updating the patchram, the BCM4354 does not support a higher
> operating speed. The normal bcm_setup follows the correct order
> (init_speed, patchram and then oper_speed) but the serdev driver will
> set the operating speed before calling the hu->setup function. Thus,
> for the BCM4354, don't set the operating speed before patchram.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index d2a6a4afdbbb..d48044276895 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -47,6 +47,14 @@
>
>  #define BCM_NUM_SUPPLIES 2
>
> +/**
> + * struct bcm_device_data - device specific data
> + * @no_early_set_baudrate: Disallow set baudrate before driver setup()
> + */
> +struct bcm_device_data {
> +       bool    no_early_set_baudrate;
> +};
> +
>  /**
>   * struct bcm_device - device driver resources
>   * @serdev_hu: HCI UART controller struct
> @@ -79,6 +87,7 @@
>   * @hu: pointer to HCI UART controller struct,
>   *     used to disable flow control during runtime suspend and system sleep
>   * @is_suspended: whether flow control is currently disabled
> + * @no_early_set_baudrate: don't set_baudrate before setup()
>   */
>  struct bcm_device {
>         /* Must be the first member, hci_serdev.c expects this. */
> @@ -112,6 +121,7 @@ struct bcm_device {
>         struct hci_uart         *hu;
>         bool                    is_suspended;
>  #endif
> +       bool                    no_early_set_baudrate;
>  };
>
>  /* generic bcm uart resources */
> @@ -447,7 +457,13 @@ static int bcm_open(struct hci_uart *hu)
>         if (bcm->dev) {
>                 hci_uart_set_flow_control(hu, true);
>                 hu->init_speed = bcm->dev->init_speed;
> -               hu->oper_speed = bcm->dev->oper_speed;
> +
> +               /* If oper_speed is set, ldisc/serdev will set the baudrate
> +                * before calling setup()
> +                */
> +               if (!bcm->dev->no_early_set_baudrate)
> +                       hu->oper_speed = bcm->dev->oper_speed;
> +
>                 err = bcm_gpio_set_power(bcm->dev, true);
>                 hci_uart_set_flow_control(hu, false);
>                 if (err)
> @@ -565,6 +581,8 @@ static int bcm_setup(struct hci_uart *hu)
>         /* Operational speed if any */
>         if (hu->oper_speed)
>                 speed = hu->oper_speed;
> +       else if (bcm->dev && bcm->dev->oper_speed)
> +               speed = bcm->dev->oper_speed;
>         else if (hu->proto->oper_speed)
>                 speed = hu->proto->oper_speed;
>         else
> @@ -1374,6 +1392,7 @@ static struct platform_driver bcm_driver = {
>  static int bcm_serdev_probe(struct serdev_device *serdev)
>  {
>         struct bcm_device *bcmdev;
> +       const struct bcm_device_data *data;
>         int err;
>
>         bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> @@ -1408,6 +1427,10 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>         if (err)
>                 dev_err(&serdev->dev, "Failed to power down\n");
>
> +       data = device_get_match_data(bcmdev->dev);
> +       if (data)
> +               bcmdev->no_early_set_baudrate = data->no_early_set_baudrate;
> +
>         return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
>  }
>
> @@ -1424,7 +1447,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>         { .compatible = "brcm,bcm4345c5" },
>         { .compatible = "brcm,bcm4330-bt" },
>         { .compatible = "brcm,bcm43438-bt" },
> -       { .compatible = "brcm,bcm43540-bt" },
> +       { .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
>         { .compatible = "brcm,bcm4335a0" },
>         { },
>  };
> --
> 2.23.0
>

Looks good except missing `bcm4354_device_data` as noted by kbuild test robot.
