Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDFDC282C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C4820861
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 02:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAVCmh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:42:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41695 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfAVCmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 21:42:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so18072776edc.8;
        Mon, 21 Jan 2019 18:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXhQDQAi1e18Uu7imO5KBtXmSh8nOiaaK0PbWDcyVXk=;
        b=GxVrt8lkN7BcN4cEENrQ+PIOl3eeVkEbGZH2h6HqNi5yIicgyzVVQlWPlFblN9JfMM
         ucrq5NENHMNZd27pmIkB/qBJ4LuotevuNYRAxsmALWuJdc0WIt8fUIZULYBsTVGUd8Pg
         stDfjhJJbblO9phpSNqf9O+iNXGq6m5EA3gzwwnZtQlWNfkikC6Ee4JUJzbCKodl5vo7
         Cb7rXbjt++T5/t1vKoJmNB5UOtrIrOTDBbGO/6eN1mmy9a30AClut2S1quXWIvSzAQYO
         27buw5SlRomZ8g6XTBQhqEFeED57orPm0A1T66veuYKp3t+FyA2Ltlqgw7hiNoA0kTaW
         6hbw==
X-Gm-Message-State: AJcUukfw3544AKSpBKdyMsMkrO3UresXqT7FCnTxmPaOMxdq+Yk8zXIs
        TRQ3fiECWbfnXZIm+l15Jm7xY4yiG+0=
X-Google-Smtp-Source: ALg8bN6ug7bFyCqgYpF5aB93JQy8tzxPg7PJ20dUkBaXs+be058sVyTNUTzFzZmD1F03tUI9fgWq1w==
X-Received: by 2002:a17:906:6085:: with SMTP id t5-v6mr26849899ejj.47.1548124954689;
        Mon, 21 Jan 2019 18:42:34 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id v9sm9404283edl.3.2019.01.21.18.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:42:34 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id s12so25599989wrt.4;
        Mon, 21 Jan 2019 18:42:34 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr31802531wrv.188.1548124953877;
 Mon, 21 Jan 2019 18:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
In-Reply-To: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 22 Jan 2019 10:42:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64pnz=uHBUCYESM-gM=c7pRc22MCP12pvNvT2wYgxx87Q@mail.gmail.com>
Message-ID: <CAGb2v64pnz=uHBUCYESM-gM=c7pRc22MCP12pvNvT2wYgxx87Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_h5: Add the Realtek compatible
 flags for the device tree
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jan 22, 2019 at 4:39 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> With the changes requested by Marcel Holtmann and Rob Herring.
>
> The patch is unchanged, but subject changed to the norm.

Same stuff with the commit log.

> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..056ab2decccc 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
>  };
>  #endif
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +       { .compatible = "realtek,rtl8723as-bt"},
> +       { .compatible = "realtek,rtl8723bs-bt"},
> +       { .compatible = "realtek,rtl8723ds-bt"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bt"},
> +       { .compatible = "realtek,rtl8821cs-bt"},
> +       { .compatible = "realtek,rtl8822bs-bt"},
> +#endif
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, h5_of_match);
> +#endif
> +

You added the list of compatibles, but you aren't actually
referencing the list in the driver. Which means this patch
actually does nothing in terms of functionality.

ChenYu

>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id h5_acpi_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
> --
> beagleboard@davidjohnsummers.uk
>
