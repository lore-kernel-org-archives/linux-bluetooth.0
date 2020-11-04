Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB3C4742C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC67206D9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604516671;
	bh=ahMw4r7hu9J2xZbNQHotVVNZ6SvzF52shQpPQubI8/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SDGy931Dc29y9fNGe6V5lgnnojsfHDM11MUOdudnF6FXZmFzlMdGy35qd8b1pL6Ti
	 K887Gkks/4SxsDNZJdGbPBQ3EvBpu6lDjwwqthE8Q6BFY+1Xpui1t+5OU0kxgo6wZL
	 50Yx6j0U7cI2TPLmDDB/XQYGCnO+RFgO7M3N80Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgKDTE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:04:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33977 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbgKDTDa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:03:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id j14so10107294ots.1;
        Wed, 04 Nov 2020 11:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rafZGYBrfEQQLEYQc+p11NEeE73tuSFzrva3qWYS3U=;
        b=UdETCtlBSuXsh5JRucIdLkqnw5DLTZC6a89Wr6Ou11wjm0v6jRTnERLFHKbR+mzy7g
         61ug34LF8DiV4QlkzNpa2bsAS6yag1Cvu/myWq1ZO37+/R6+T5VLZqWjWGW9gSuOs/nP
         eO8Idcob2I1fjUD5f2GB8dCqssdg+FGqxjqcu2m4mKVhHGLXPE8oRC0DW52G5cSl1Mqp
         NL9MEBk9a2PMFNhQh9Bqb1AVs3b7JuRTSxEbAtPl+fpAyUBeHVCvYHB6kxQYZwFeDYDv
         DGXjQ6ysPJvM5HsLPXAs5CDeoI6zYXKIik9JRs036CLriA4dEYFwpSV9KinvcxTRTzDV
         5rwA==
X-Gm-Message-State: AOAM531+7xloQFAVXMBUi58s/4qFYv3FmyMj5u9+51vvzrb/38CSk4Fx
        /LJo0uw9yFCUEvq+fmFB7A==
X-Google-Smtp-Source: ABdhPJyX14RhEJRNZyzwOGuKoZ92rfWILCwxvhTkERzEO1eBU08bNN0DjjU30VTz1O2kEC4nO8sc6A==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr14231765otk.15.1604516609458;
        Wed, 04 Nov 2020 11:03:29 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k20sm772047ooh.47.2020.11.04.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:03:29 -0800 (PST)
Received: (nullmailer pid 3956153 invoked by uid 1000);
        Wed, 04 Nov 2020 19:03:28 -0000
Date:   Wed, 4 Nov 2020 13:03:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Rewrite bindings i YAML and add
 reset
Message-ID: <20201104190328.GA3954499@bogus>
References: <20201103120943.1289277-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103120943.1289277-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 03, 2020 at 01:09:42PM +0100, Linus Walleij wrote:
> This rewrites the Broadcom bluetooth bindings in YAML and
> adds a GPIO handle for the BT_RST_N line as used on some
> platforms.

Typo in subject.

> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/broadcom-bluetooth.txt       |  56 ---------
>  .../bindings/net/broadcom-bluetooth.yaml      | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>  create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> deleted file mode 100644
> index a7d57ba5f2ac..000000000000
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Broadcom Bluetooth Chips
> ----------------------
> -
> -This documents the binding structure and common properties for serial
> -attached Broadcom devices.
> -
> -Serial attached Broadcom devices shall be a child node of the host UART
> -device the slave device is attached to.
> -
> -Required properties:
> -
> - - compatible: should contain one of the following:
> -   * "brcm,bcm20702a1"
> -   * "brcm,bcm4329-bt"
> -   * "brcm,bcm4330-bt"
> -   * "brcm,bcm43438-bt"
> -   * "brcm,bcm4345c5"
> -   * "brcm,bcm43540-bt"
> -   * "brcm,bcm4335a0"
> -
> -Optional properties:
> -
> - - max-speed: see Documentation/devicetree/bindings/serial/serial.yaml
> - - shutdown-gpios: GPIO specifier, used to enable the BT module
> - - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
> - - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor.
> -                      deprecated, replaced by interrupts and
> -                      "host-wakeup" interrupt-names
> - - clocks: 1 or 2 clocks as defined in clock-names below, in that order
> - - clock-names: names for clock inputs, matching the clocks given
> -   - "extclk": deprecated, replaced by "txco"
> -   - "txco": external reference clock (not a standalone crystal)
> -   - "lpo": external low power 32.768 kHz clock
> - - vbat-supply: phandle to regulator supply for VBAT
> - - vddio-supply: phandle to regulator supply for VDDIO
> - - brcm,bt-pcm-int-params: configure PCM parameters via a 5-byte array
> -    - sco-routing: 0 = PCM, 1 = Transport, 2 = Codec, 3 = I2S
> -    - pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
> -    - pcm-frame-type: short, long
> -    - pcm-sync-mode: slave, master
> -    - pcm-clock-mode: slave, master
> - - interrupts: must be one, used to wakeup the host processor
> - - interrupt-names: must be "host-wakeup"
> -
> -Example:
> -
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&uart2_pins>;
> -
> -       bluetooth {
> -               compatible = "brcm,bcm43438-bt";
> -               max-speed = <921600>;
> -               brcm,bt-pcm-int-params = [01 02 00 01 01];
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> new file mode 100644
> index 000000000000..bdd6ca617e23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Bluetooth Chips
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  This binding describes Broadcom UART-attached bluetooth chips.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm20702a1
> +      - brcm,bcm4329-bt
> +      - brcm,bcm4330-bt
> +      - brcm,bcm43438-bt
> +      - brcm,bcm4345c5
> +      - brcm,bcm43540-bt
> +      - brcm,bcm4335a0
> +
> +  shutdown-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the line BT_REG_ON used to
> +      power on the BT module
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the line BT_RST_N used to
> +      reset the BT module. This should be marked as
> +      GPIO_ACTIVE_LOW.
> +
> +  device-wakeup-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the line BT_WAKE used to
> +      wakeup the controller. This is using the BT_GPIO_0
> +      pin on the chip when in use.
> +
> +  host-wakeup-gpios:
> +    maxItems: 1
> +    deprecated: true
> +    description: GPIO specifier for the line HOST_WAKE used
> +      to wakeup the host processor. This is using he BT_GPIO_1
> +      pin on the chip when in use. This is deprecated and replaced
> +      by interrupts and "host-wakeup" interrupt-names
> +
> +  clocks:
> +    maxItems: 2
> +    description: 1 or 2 clocks as defined in clock-names below,
> +      in that order
> +
> +  clock-names:
> +    description: Names of the 1 to 2 supplied clocks
> +    items:
> +      - const: txco
> +      - const: lpo
> +      - const: extclk
> +
> +  vbat-supply:
> +    description: phandle to regulator supply for VBAT
> +
> +  vddio-supply:
> +    description: phandle to regulator supply for VDDIO
> +
> +  brcm,bt-pcm-int-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 5
> +    maxItems: 5
> +    description: |-
> +      configure PCM parameters via a 5-byte array:
> +       sco-routing: 0 = PCM, 1 = Transport, 2 = Codec, 3 = I2S
> +       pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
> +       pcm-frame-type: short, long
> +       pcm-sync-mode: slave, master
> +       pcm-clock-mode: slave, master
> +
> +  interrupts:
> +    items:
> +      - description: Handle to the line HOST_WAKE used to wake
> +          up the host processor. This uses the BT_GPIO_1 pin on
> +          the chip when in use.
> +
> +  interrupt-names:
> +    items:
> +      - const: host-wakeup
> +
> +  max-speed: true
> +  current-speed: true
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    uart {
> +        uart-has-rtscts;
> +
> +        bluetooth {
> +            compatible = "brcm,bcm4330-bt";
> +            max-speed = <921600>;
> +            brcm,bt-pcm-int-params = [01 02 00 01 01];
> +            shutdown-gpios = <&gpio 30 GPIO_ACTIVE_HIGH>;
> +            device-wakeup-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> -- 
> 2.26.2
> 
