Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407BCC432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B33207FD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JxDiWV9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKYSTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:19:25 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33487 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfKYSTZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 13:19:25 -0500
Received: by mail-qv1-f67.google.com with SMTP id x14so6161601qvu.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pkkdhb+/Z2QWGsdN+hFDKjr9JHaHTnQp4dHTiLqkWCs=;
        b=JxDiWV9kUkV0x0caXAQLBYv8HAHTaDaSDVzUUfjVgLeqzLZVD10aQACqu3SpISL3mv
         CYJhD8g4TLv5ZsxxPj+DSYQoDovH9LgaPoNYjAkbDG7sEpVkVT2RcZaGGlTd2ecqFvQe
         UkJ54kb7+LQutUvWFnvV4tErVsSRDS4b5dPsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pkkdhb+/Z2QWGsdN+hFDKjr9JHaHTnQp4dHTiLqkWCs=;
        b=k9v5nwcAp2dt9+jL2GkIWzrxkYJ5S9XlpD0R8beWiZU5lNa+i83FuhUx6+c3sZBJ0e
         3FLp9n8fSyslFWl6lZwqJLUdkcpjWunpi3yVW82dRuOdnlKpct2tzrtyyMyrEWZAncuQ
         EwvjLU3xO7R0XlozMarwGppgWsJeXDi1jhJgOSLfgdoSWEsWIzvdDYkqQB3i6IJeYTew
         Vf+smUuF748wVy9ptnJSTMf5hkrwXHiQzF7CBASgTx0jBUYVIUcuQGFmaVbBaW85J3dX
         iZkcHUGDVYiiL93PSPE7ZotcvgQLUQDYCbuv5NP+kdkyK8QvhlfOkUTOs+3P0iFjFLKF
         6pGw==
X-Gm-Message-State: APjAAAXMfEonkaVbnLAADxkxF0MAYCo6AmN0YYFZQfrDVBB5fmPttabi
        btaPHTDFrfxFfHxshrJxDFffgqY6ktPy24WRmzY8TtW+
X-Google-Smtp-Source: APXvYqyW/LED9B1kRHiZadBNTYt2Scjx7rcoJbVPhBzkuAa7aYNJ9N5cLqVPNbTkD+dR1R6kfxaX0ellBQcJpxHoAn8=
X-Received: by 2002:a05:6214:547:: with SMTP id ci7mr28977858qvb.32.1574705962934;
 Mon, 25 Nov 2019 10:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20191123100111.219190-4-marcel@holtmann.org>
In-Reply-To: <20191123100111.219190-4-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 25 Nov 2019 10:19:11 -0800
Message-ID: <CANFp7mXLdmLchTKENP5-jxAWfOWNv6T+L+XR0_ALX+EF3pFB2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: hci_bcm: Support pcm params in dts
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
> BCM chips may require configuration of PCM to operate correctly and
> there is a vendor specific HCI command to do this. Add support in the
> hci_bcm driver to parse this from devicetree and configure the chip.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index d48044276895..9cfb202bbeca 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -122,6 +122,7 @@ struct bcm_device {
>         bool                    is_suspended;
>  #endif
>         bool                    no_early_set_baudrate;
> +       u8                      pcm_int_params[5];
>  };
>
>  /* generic bcm uart resources */
> @@ -594,6 +595,16 @@ static int bcm_setup(struct hci_uart *hu)
>                         host_set_baudrate(hu, speed);
>         }
>
> +       /* PCM parameters if provided */
> +       if (bcm->dev && bcm->dev->pcm_int_params[0] != 0xff) {
> +               struct bcm_set_pcm_int_params params;
> +
> +               btbcm_read_pcm_int_params(hu->hdev, &params);
This seems redundant since we just overwrite it anyway.

> +
> +               memcpy(&params, bcm->dev->pcm_int_params, 5);
> +               btbcm_write_pcm_int_params(hu->hdev, &params);
> +       }
> +
>  finalize:
>         release_firmware(fw);
>
> @@ -1131,6 +1142,8 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>  static int bcm_of_probe(struct bcm_device *bdev)
>  {
>         device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
> +       device_property_read_u8_array(bdev->dev, "brcm,bt-pcm-int-params",
> +                                     bdev->pcm_int_params, 5);
>         return 0;
>  }
>
> @@ -1146,6 +1159,9 @@ static int bcm_probe(struct platform_device *pdev)
>         dev->dev = &pdev->dev;
>         dev->irq = platform_get_irq(pdev, 0);
>
> +       /* Initialize routing field to an unsued value */
unused
> +       dev->pcm_int_params[0] = 0xff;
> +
>         if (has_acpi_companion(&pdev->dev)) {
>                 ret = bcm_acpi_probe(dev);
>                 if (ret)
> @@ -1406,6 +1422,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>         bcmdev->serdev_hu.serdev = serdev;
>         serdev_device_set_drvdata(serdev, bcmdev);
>
> +       /* Initialize routing field to an unsued value */
unused
> +       bcmdev->pcm_int_params[0] = 0xff;
> +
>         if (has_acpi_companion(&serdev->dev))
>                 err = bcm_acpi_probe(bcmdev);
>         else
> --
> 2.23.0
>
