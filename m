Return-Path: <SRS0=Lkqy=OU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D2DC07E85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B912084A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 12:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B912084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeLKMtq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:49:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51534 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLKMtq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Dec 2018 07:49:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so2100102wmh.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Dec 2018 04:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrMBaLzH5r0cuQEw0g7bLsnIqu8YhS2a6FaDqAVdlrQ=;
        b=JVxo/c3jrxTdWQftaWwvkI5c4am0kzGrtyIuuQhET5TV6vl3TYzwV3Gd3StGiiWCMf
         fAQM62Q9vYsJ1QXs4IAPKYvTkr4kd9TXeGr43Yc359apY5FJ8tGlWocQCtPkRJ8szo4h
         zD5Eqx2UzsGwFqovTkw5TLnMr6CH4B1Y0ZNOUiRB0Ek2iGCY+l0eujRbBjCePIcaFbKE
         SYXF/kkWEOTEYs6xBN8ak7M4DMaanYzHH1yTRacIy2LJ/LR3O3HUmgtHE2pblyM/u4B5
         NuMEX0xuAfU7Dh/c19H23inuafcoEzcW0uGvIH2rkWqhtW5bIHtfdM0kkIyEKExUYHj1
         VRHw==
X-Gm-Message-State: AA+aEWYI6ydUtDA114Q0hV9QCTLYBwaSuYaszMATLPmiG4dy8ni0KxP1
        BaXfCnAbty15tSSHC0GFVBwZiQ==
X-Google-Smtp-Source: AFSGD/UtkycDInu66Jm3dH8hpMSe/fiu+INJIXatuCEJqvjSvGxfE4l0yTkQZ/ypAf04Fm+DrD9KIQ==
X-Received: by 2002:a1c:1f81:: with SMTP id f123mr2004108wmf.64.1544532583658;
        Tue, 11 Dec 2018 04:49:43 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p6sm20068142wrx.50.2018.12.11.04.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 04:49:42 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_h5: Add suspend / resume ops
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20181030131723.4589-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <57436796-dbed-2744-612d-8043eff4e0e3@redhat.com>
Date:   Tue, 11 Dec 2018 13:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181030131723.4589-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 30-10-18 14:17, Hans de Goede wrote:
> Add support for vendor specific suspend / resume callbacks.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Ping? What is the status of this series ?

Regards,

Hans




> ---
>   drivers/bluetooth/hci_h5.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..beddb89a00f2 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -115,6 +115,8 @@ struct h5_vnd {
>   	int (*setup)(struct h5 *h5);
>   	void (*open)(struct h5 *h5);
>   	void (*close)(struct h5 *h5);
> +	int (*suspend)(struct h5 *h5);
> +	int (*resume)(struct h5 *h5);
>   	const struct acpi_gpio_mapping *acpi_gpio_map;
>   };
>   
> @@ -841,6 +843,28 @@ static void h5_serdev_remove(struct serdev_device *serdev)
>   	hci_uart_unregister_device(&h5->serdev_hu);
>   }
>   
> +static int __maybe_unused h5_serdev_suspend(struct device *dev)
> +{
> +	struct h5 *h5 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (h5->vnd && h5->vnd->suspend)
> +		ret = h5->vnd->suspend(h5);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused h5_serdev_resume(struct device *dev)
> +{
> +	struct h5 *h5 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (h5->vnd && h5->vnd->resume)
> +		ret = h5->vnd->resume(h5);
> +
> +	return ret;
> +}
> +
>   #ifdef CONFIG_BT_HCIUART_RTL
>   static int h5_btrtl_setup(struct h5 *h5)
>   {
> @@ -935,12 +959,17 @@ static const struct acpi_device_id h5_acpi_match[] = {
>   MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
>   #endif
>   
> +static const struct dev_pm_ops h5_serdev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
> +};
> +
>   static struct serdev_device_driver h5_serdev_driver = {
>   	.probe = h5_serdev_probe,
>   	.remove = h5_serdev_remove,
>   	.driver = {
>   		.name = "hci_uart_h5",
>   		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> +		.pm = &h5_serdev_pm_ops,
>   	},
>   };
>   
> 
