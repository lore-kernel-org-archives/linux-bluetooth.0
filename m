Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A57C5ACD3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0742086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfARROJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:14:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40666 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARROJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:14:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so11701461edr.7;
        Fri, 18 Jan 2019 09:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktKsigAQx+weGoNj6gtSnvxHTDmILfP/OH8CmOk6WZQ=;
        b=IxZer6iTdMpVoaSeIKLuizSg5gJU/ql2VwTTOqQA8mvLhLawQ+TjniwZdwHVC+COAj
         Tlo6kORD+N/ntS5tnK7+dAO0IKB+bu6m782/zzi78z4Q9BDevQPe+xkMtmv8PutW91iE
         YgMaZLeFacuz2Bm03+gTCUSLyTHD0IeqmTnG8WUpH52BWToZXEb3kqEP3S5Ve90Yqgki
         DO//G8E+KGpVfcfiGUsjD2gnUkf2AVKnSNXyzhpI1Pcko/GQsHeHKgOyHM8Dmd9ppaGt
         oGdpC6qzGXpE/lIAp26dmXCuP513022OvK8TU3gP8v8EPYszTzVsL8d+dswjteHS0spI
         4sSQ==
X-Gm-Message-State: AJcUukfWVifdXTQKAp8+ZG2Oda5K7n2mSM5YFZM5kB87NW65j3erbYEs
        3BR2UwMEA/FxG8uYdG8AuptjSf34cFk=
X-Google-Smtp-Source: ALg8bN5qFhu7RKcLzksjq1SOLr1G8jsKX7WOiHtS7t+FxvWYV+jz8OqQRB+5Nci0qj+iWwggwbelmQ==
X-Received: by 2002:a50:cd5c:: with SMTP id d28mr15917198edj.176.1547831646602;
        Fri, 18 Jan 2019 09:14:06 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id e26-v6sm4013243ejb.29.2019.01.18.09.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:14:06 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id t200so5232499wmt.0;
        Fri, 18 Jan 2019 09:14:05 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr16981898wmc.116.1547831645652;
 Fri, 18 Jan 2019 09:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-3-anarsoul@gmail.com>
In-Reply-To: <20190118170232.16142-3-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 19 Jan 2019 01:13:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v665Wsu5dhNi1=-bMmPYP-5nfTamtu0uXVYym+RxzNeN=A@mail.gmail.com>
Message-ID: <CAGb2v665Wsu5dhNi1=-bMmPYP-5nfTamtu0uXVYym+RxzNeN=A@mail.gmail.com>
Subject: Re: [PATCH 2/8] Bluetooth: hci_h5: Add support for reset GPIO
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Jan 19, 2019 at 1:02 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Some boards (e.g. Pine64 and Pinebook) wire a GPIO to reset pin of
> RTL8723BS

Pine64 / Pinebook don't have the enable pin. One could say that the
enable pin and the reset pin you add here are actually the same thing.

ChenYu

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/bluetooth/hci_h5.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 069d1c8fde73..7ead8c3d8657 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -107,6 +107,7 @@ struct h5 {
>         const struct h5_vnd *vnd;
>         const char *id;
>
> +       struct gpio_desc *reset_gpio;
>         struct gpio_desc *enable_gpio;
>         struct gpio_desc *device_wake_gpio;
>  };
> @@ -833,6 +834,10 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>         if (IS_ERR(h5->device_wake_gpio))
>                 return PTR_ERR(h5->device_wake_gpio);
>
> +       h5->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(h5->reset_gpio))
> +               return PTR_ERR(h5->reset_gpio);
> +
>         return hci_uart_register_device(&h5->serdev_hu, &h5p);
>  }
>
> @@ -921,6 +926,9 @@ static void h5_btrtl_open(struct h5 *h5)
>
>         /* The controller needs up to 500ms to wakeup */
>         gpiod_set_value_cansleep(h5->enable_gpio, 1);
> +       /* Take it out of reset */
> +       gpiod_set_value_cansleep(h5->reset_gpio, 0);
> +       msleep(100);
>         gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
>         msleep(500);
>  }
> @@ -928,6 +936,7 @@ static void h5_btrtl_open(struct h5 *h5)
>  static void h5_btrtl_close(struct h5 *h5)
>  {
>         gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> +       gpiod_set_value_cansleep(h5->reset_gpio, 1);
>         gpiod_set_value_cansleep(h5->enable_gpio, 0);
>  }
>
> --
> 2.20.1
>
