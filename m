Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7763C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8AB2245C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XKCWfMb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLFA6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:58:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42498 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfLFA6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 19:58:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id i5so2395888pgj.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7Hnuh/lhbaWi78zw47f4T7dSKS95Ee02qVxYEAo3AJs=;
        b=XKCWfMb4QVNiufc2OLqSEvsCeB+7bLRHN20uFBfrt59dBJT/SgzoA6qehPcrONCMWv
         qYLqZqHgkEjBtbRaeNMdK0TkNzNNq36de60MThmXWCSLKuBbgMM/ctmNkfWCq1xOMrzw
         YOP2KjaFZ41eDvZ17cDg27xpENCOq4fg6UJZBpNri7lNrSXYCIJ5ETnSO42yELksrhPD
         Rex8eS7cHn46wU7whzIAXg2Xj82jorofAiQKypMqsp2/hzBu89J4beD9lmQolbq9K4/2
         CEYZ1ZlIj+QEgAgiV0sDR/IqfObtRKHLemeMfnBcApAD/N8cgg3ryxIGb1nHxo4SGqGC
         kwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7Hnuh/lhbaWi78zw47f4T7dSKS95Ee02qVxYEAo3AJs=;
        b=SusvjRPlsVhSgw9tv7rLKPsyzSTNDuuiubbU3uZ4A5OHmND5UO3Q5ecAOE9zPFHgRk
         fcbBV9WiaHIBjsx7PyPxTffXM2unIJR90qUOWqjHXPpHH816kZm2naNPHo7MKS+HdzB3
         Hq1hPLmW8BMSgAKklyUFSIRlH+za7zrtL+rprWmm0gjYtut2NoJiKgtEJShccOXkO7a/
         FSSyF0V0NH/efb2m3fvlbXF81tLCQ+KT33DMURRVEk5b3bx6W5j+zNvKzeWszQUWmQny
         U+mBFpFbO9SKaq99DbK+iASDkwlT+n4ksnEutgmZGRTfr4Jxr7VxWALXajWllnj7npMf
         tznw==
X-Gm-Message-State: APjAAAW/W1q6Yl1dgkbyGgmgFxeM1362ahArnN8q0cQ4/ft4hi1gNjQ6
        ge+hpsZaFVk8KpUjmZ0JcT9wOA==
X-Google-Smtp-Source: APXvYqxr+lwRkxpfc0ZURjTqY+KCamdHypKJniTnQq5FbwwNIkUC38xRGVONLHE4KLCVnUBmRLoPlg==
X-Received: by 2002:a62:87c5:: with SMTP id i188mr11903453pfe.52.1575593915169;
        Thu, 05 Dec 2019 16:58:35 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d6sm875807pju.8.2019.12.05.16.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2019 16:58:34 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bluetooth: hci_bcm: enable IRQ capability from node
In-Reply-To: <20191204161239.16653-1-glaroque@baylibre.com>
References: <20191204161239.16653-1-glaroque@baylibre.com>
Date:   Thu, 05 Dec 2019 16:58:34 -0800
Message-ID: <7hv9qu2rt1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Actually IRQ can be found from GPIO but all platorms don't support

nit: s/platorms/platforms/

> gpiod_to_irq, it's the case on amlogic chip.
> so to have possibility to use interrupt mode we need to add interrupts
> field in node and support it in driver.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> sorry for noise,
>
> v2 is for rebasing on master branch
>
> guillaume
>
>  drivers/bluetooth/hci_bcm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index f8f5c593a05c..9f52d57c56de 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct bcm_device *bcmdev;
>  	const struct bcm_device_data *data;
> +	struct platform_device *pdev;
>  	int err;
>  
>  	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>  #endif
>  	bcmdev->serdev_hu.serdev = serdev;
>  	serdev_device_set_drvdata(serdev, bcmdev);
> +	pdev = to_platform_device(bcmdev->dev);
> +	bcmdev->irq = platform_get_irq(pdev, 0);

I don't know this driver well enough to be sure, but don't you need some
error checking here?

If this fails (on platforms with no IRQ defined), is an error code in
bcmdev->irq going to affect later code that tries to setup IRQs?

Kevin

