Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F91FC2D0C9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02322527
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576276058;
	bh=axY4rGnunz7vuk85RHaGJxTK/73TSIsc14PnD4lJozY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AqBIEl+qhwRbkpaY4zQLqjL5Kviw20YRdqaLbtKsT3xAj4I+J3XWJ1pELbFqCgy0d
	 ZZFbSIKgKYuvtl7oKi2Tga12f6xiad7M9vx+zRJtxwMNXZahqW9o8AcAk+rl29Yghh
	 aNVTknLxjE0GWD/uRBhnXr1Q3G8N63shyTeIUDT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLMW1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:27:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44418 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMW1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 17:27:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id x3so839028oto.11;
        Fri, 13 Dec 2019 14:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUrvPMiCDtXnhqrg59MpZ/13pnaz/iZ88MgzmTpy4Uk=;
        b=NxQfqF6+a6u/L3hWaIfXiBouawHXHW1+uf/e2KJplRYGi8gFoejk4xPo8DpQDA7J3L
         glfcS+ZLR2lM5KmexGJzUTKDTj1HynrhM33ZWDEnu+UGP5kmxm4IQDd3nIv0EgeN+ft+
         YvXMgvvJse4Y0piOwRugOkp13SYRXpZyH0fmqCZoMNJy3NyLBDJ8B1bd2POBxzSZQjSd
         +bbzg+fPGfh/95xSvZFW+i47E4zcNNf6n6SuMqrCDSvXHws6j49Ykh/EB/lytvSZIh1T
         I3XMD8zTEtaZb7iIa34yBLW6wBgBVL+Xc9mZ4ob55J2FfyntLfPu8nsbIvsz669JvUzb
         BQ3A==
X-Gm-Message-State: APjAAAWUQ1hJjcuHM/9VGT64WRGvwbGsLnLl31POCaLeuy2H3ZfhP0Ls
        37ncY4ce9ndce55Y4A79Gg==
X-Google-Smtp-Source: APXvYqyGkIUrZPq7+IYf+cJy5RzuFTEd7QfG91GtnXfuBL0xk/hpDG676A2pBOwmoCHsx3dmxHBnPg==
X-Received: by 2002:a05:6830:1b6d:: with SMTP id d13mr17365107ote.258.1576276056206;
        Fri, 13 Dec 2019 14:27:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm3797099otq.5.2019.12.13.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:27:35 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:27:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: net: bluetooth: add DT bindings for
 Realtek controllers
Message-ID: <20191213222735.GA456@bogus>
References: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
 <20191130202314.142096-2-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130202314.142096-2-bonstra@bonstra.fr.eu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 30, 2019 at 09:23:12PM +0100, Hugo Grostabussiat wrote:
> The rtl_bt driver already supports some Realtek controllers on ACPI
> platforms.
> This commit adds bindings for DT-only platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
>  .../bindings/net/realtek-bluetooth.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> new file mode 100644
> index 000000000000..6b62e5132c90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek Bluetooth controllers device tree bindings
> +
> +description: |
> +  Device tree bindings for serial attached Realtek Bluetooth controllers.
> +
> +maintainers:
> +  - Marcel Holtmann <marcel@holtmann.org>
> +  - Johan Hedberg <johan.hedberg@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: realtek,rt8723bs-bt
> +
> +  powerdown-gpios:
> +    description: GPIO line controlling the power down (BT_DIS#) signal
> +    maxItems: 1
> +
> +  device-wake-gpios:
> +    description: GPIO line controlling the device wakeup (BT_WAKE) signal
> +    maxItems: 1
> +
> +  host-wake-gpios:
> +    description: GPIO line sampling the host wakeup (BT_HOST_WAKE) signal
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Name of the configuration file to load in addition to firmware
> +    $ref: http://devicetree.org/schemas/types.yaml#/definitions/string

This should be just:

$ref: /schemas/types.yaml#/definitions/string

> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    uart1 {
> +      bluetooth {
> +        compatible = "realtek,rtl8723bs-bt";
> +        powerdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
> +        host-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
> +        device-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
> +        firmware-name = "rtl8723bs_config-teres_a64_i.bin";
> +      };
> +    };
> -- 
> 2.24.0
> 
