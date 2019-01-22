Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D4BC282C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B73920870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 02:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVCk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:40:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42121 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVCk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 21:40:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so18052052edw.9;
        Mon, 21 Jan 2019 18:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cz/lFKQSSJLlHf1bGr3Q5xkouLJJKTAy2cjlq2O2Fw=;
        b=FA6VjsFupHuivuIZWwnfext5/p3/N+LM/DBflcWk6xO83COwpS2qImZoHZ92zAZ7QA
         zZ+FUDWNSEqvQMVz3UGQPcfd9zVrTrZncOXTXa7B4UqsZcguut20nek9EcFAYQ53H9GL
         Jl7cEsH3kkufwMiZrGKV06mko6PxD3H96Zbj6npeXgTchLisXtxa09CKw53WU4zb6GEY
         jUeOIZbkeTZafOvpvNXlVHNR72EzixjDrGo2OiO1l4KrHeo8mWrWcMuoB/1AOD02HyxX
         FBMvz5LOeR7BNWoQZW8Jl2DDwOVEF3unHkxPDu4vqJV4FnTTMQe97Vl3RtlD+e9gOSkr
         QV6Q==
X-Gm-Message-State: AJcUuke675uOcL/9LwSII1xXRX3s05LnyH5940l1C2or//9zrbXY57LC
        To3/H+NwjEHPuMzomO+R/C0GCzDbBr0=
X-Google-Smtp-Source: ALg8bN4rX4hKaXfvukDWI4Ewjs9dTD+FmahuQ0Z4ZMZhidBvE6lG1d+TsbswnhRTMvq97xWHZ3IXmQ==
X-Received: by 2002:a17:906:938e:: with SMTP id l14-v6mr26267311ejx.246.1548124824496;
        Mon, 21 Jan 2019 18:40:24 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id l41sm9840390eda.83.2019.01.21.18.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:40:23 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id y185so7472183wmd.1;
        Mon, 21 Jan 2019 18:40:23 -0800 (PST)
X-Received: by 2002:a1c:578e:: with SMTP id l136mr1543215wmb.124.1548124823178;
 Mon, 21 Jan 2019 18:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk> <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
In-Reply-To: <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 22 Jan 2019 10:40:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v64j=hGFhb3GVocRo9B1uY+tFBjbrm6F71L4ejA+cruUvA@mail.gmail.com>
Message-ID: <CAGb2v64j=hGFhb3GVocRo9B1uY+tFBjbrm6F71L4ejA+cruUvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
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

Hi,

Interested party here. I'd like to get this working on the Pine64 which has
an RTL8723BS module. I had made some changes and had it working but didn't
get around to doing the patches yet.

On Tue, Jan 22, 2019 at 4:39 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> With the changes requested by Marcel Holtmann and Rob Herring.
>
> Capitalisation as requested.
>
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>

The commit log is a bit lacking, as it doesn't provide any context or details
relevant to the changes in this patch, but also has details that should be
in the changelog, and not the commit log.

> ---
>  .../bindings/net/realtek-bluetooth-serial.txt | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> new file mode 100644
> index 000000000000..2eddde1a0cf1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> @@ -0,0 +1,32 @@
> +Realtek Bluetooth devices connected via a UART.
> +These devices typically also have a WI-FI connected via SDIO - the
> +compatible described here is used just for referencing the Bluetooth.
> +
> +- compatible: should be "realtek,<name>-bt"
> +  except for "realtek,trl8761atv" - which only has a serial Bluetooth connection
> +       "realtek,rtl8723as-bt"
> +       "realtek,rtl8723bs-bt"
> +       "realtek,rtl8723ds-bt"
> +       "realtek,rtl8761atv"
> +       "realtek,rtl8821as-bt"
> +       "realtek,rtl8821cs-bt"
> +       "realtek,rtl8822bs-bt"
> +
> +Example:
> +
> +&uart0 {
> +       status = "okay";
> +       pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +       bluetooth {
> +               compatible = "realtek,rtl8723bs-bt";
> +               uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +               pinctrl-names = "default","rts_gpio";
> +               pinctrl-0 = <&uart0_rts>;
> +               pinctrl-1 = <&uart0_gpios>;
> +               BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +               BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +               BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;

You haven't listed these three properties in the bindings.

Second, for the last one, the property name says irq, but it takes
a GPIO phandle. This is slightly misleading.

Furthermore, ACPI already uses the names "device-wake-gpios",
"enable-gpios", and "host-wake-gpios". Would it be possible to
stick to those?

Last, you don't actually add support for them in the driver.

So why are they there?

Regards
ChenYu

> +       };
> +};
> +
> +this ensures that the Bluetooth device is tied to the correct uart.
> --
> beagleboard@davidjohnsummers.uk
>
