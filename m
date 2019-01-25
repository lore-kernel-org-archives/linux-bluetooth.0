Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C262C282C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187EC218B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548445608;
	bh=i7eIPcSDkUDjtD738+GkP64WVdJN6mCno1YMpPNnyuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ChlWYWYTQdaRMkuDY5f7yal4mx8APpnWduI96AW7IGowqw9k2H0cTBtnzsn9bysl/
	 Gh/M1FExugC6jPeJZcFVhI0JQFtvJbzTW58iWJ2LsF/Y/s3gJWQf35WFjNayvjswxY
	 TExHOq5dNnOad/oLr8GCC6OinpPa7XRCUfdqSH18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAYTqr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYTqr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jan 2019 14:46:47 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B49218FE;
        Fri, 25 Jan 2019 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548445605;
        bh=i7eIPcSDkUDjtD738+GkP64WVdJN6mCno1YMpPNnyuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UMaoSckpAJy5wXpqJSm3ZYL3GJEYFYh2Q3PcHcbmZNK/IsLQZztJdbgeCD7hmKegt
         Uq0Sh2aMC5lx6jP1xHk6QPppLz9EuvlxEriNxLH+CfKyiR18Q5YEgKASAq5u0bCqVo
         5sGOl9jc642pte308auxgUQPwKlDD5kTPnM85hCE=
Received: by mail-qk1-f171.google.com with SMTP id c21so6092208qkl.6;
        Fri, 25 Jan 2019 11:46:45 -0800 (PST)
X-Gm-Message-State: AJcUukddMRUMr6952DNTUMQlInCWBqcqVBXdG5/32uOL74VSuratuVxZ
        jxDjosb5hYiVwzRZpqoNmvBigJEpwfgtyzLmUg==
X-Google-Smtp-Source: ALg8bN7p9pR51CG7fcekwg044VVCWUSprZivwYVNxdVzm0ddEkUAfxsyhEclOhzehXAmJL8luTmz6uqhuCMDSWq3A+k=
X-Received: by 2002:a37:7682:: with SMTP id r124mr11039921qkc.79.1548445604581;
 Fri, 25 Jan 2019 11:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk> <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
In-Reply-To: <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 25 Jan 2019 13:46:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9zjPaDiJ0Uynp9p7WpH-NK-sT91vUm-+R7D_me8a9Mw@mail.gmail.com>
Message-ID: <CAL_Jsq+9zjPaDiJ0Uynp9p7WpH-NK-sT91vUm-+R7D_me8a9Mw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jan 21, 2019 at 2:39 PM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> With the changes requested by Marcel Holtmann and Rob Herring.
>
> Capitalisation as requested.

Write something that makes sense for the git history. The above 2
lines are not useful information.

> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
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

Don't show 'status' in examples.

> +       pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +       bluetooth {
> +               compatible = "realtek,rtl8723bs-bt";
> +               uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;

We already have a standard property name and location for handling RTS
on a GPIO and this is not it.

> +               pinctrl-names = "default","rts_gpio";
> +               pinctrl-0 = <&uart0_rts>;

This belongs in the parent node.

> +               pinctrl-1 = <&uart0_gpios>;
> +               BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +               BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +               BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;

All the above need to be documented. Putting in an example is not documented.

Drop the 'BT,' as the part preceding the comma should be a vendor name
if present and use '-' rather than '_' in property names.

'reset-gpios' is the standard name for a reset gpio. An irq should use
the 'interrupts' binding even if connected to a GPIO on the host.

Rob
