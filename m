Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB3C47E49
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6C2222C1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572992280;
	bh=89UNiJCkPkbGDdpt0eoB4A3Td4KAiBAyCGUfym4A040=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jefYCJ+5Pk7mdpteYTs3twv1zNrHcv0sfZ8NKYYI3wRC1BTyjbXyTWjEZU8oGzkzQ
	 asObVgWcOjw0Ds9tf9tkW4SG2QnHWC4HQKqzPwNmhBc2rBMs5/S0ZnH5DF+KJTO+z5
	 wjgso8OMtl/nwh958jk7kufdw4DjHVkSc1XRuCzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKEWR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:17:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41293 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfKEWR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 17:17:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so19054303oty.8;
        Tue, 05 Nov 2019 14:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlDa37MatdZAoZEVtVb/vuu5xcyJ2yd9PLghK+7oV+Y=;
        b=OFNpUOkjW5Nrdj0HsbMwC6Av4ojrDURhw1fFpk6w7Xjfkf8+Cv8MyQRdOhWwPvG5g2
         /Q8SSWDMHW3GQwbp59vCjYAO2RyJrqPorcpslDePH8v69V8+u0LwFxu0+Jud1UwHOxrG
         qrKy140T2Po7ly8HxOvZdyZ7zqX6PXRvb6jL2/qB3sd0UrxMxEU0xCWUrpWC6tFI03wE
         VnxNEFDRiAL//4VhV9ee8pA4Fc9v5k/u7xjIpqIYDOgQpNWxWj8lMaY3bTxJYWfjmE/W
         whGHJazu32R+89n5mtjtZal9G3lQqQ6mjPYMbBvA9ScycKmwwGUBXyyTUI8sAu4flsAl
         K7zA==
X-Gm-Message-State: APjAAAUlefeQV54DK/L8YSoFHrknCFcNtpdatHoYn/KFuXPn0DBhfgz6
        N+YrqS/G2mUmjm/gX2ttuA==
X-Google-Smtp-Source: APXvYqxTL385Ync46f4camw5ZMSBXIBOCu372UJEtS5dlHGGyIWdJUwQw9+KaXqIlLLooSfcbtIaSA==
X-Received: by 2002:a05:6830:1d52:: with SMTP id p18mr25309538oth.130.1572992278135;
        Tue, 05 Nov 2019 14:17:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e62sm914612oif.12.2019.11.05.14.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:17:57 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:17:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: add DT binding for
 Realtek controllers
Message-ID: <20191105221756.GA15425@bogus>
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
 <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 30, 2019 at 11:43:31PM +0100, Hugo Grostabussiat wrote:
> The rtl_bt driver already supports some Realtek controllers on ACPI
> platforms.
> This commit adds bindings for DT-only platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
>  .../bindings/net/realtek-bluetooth.txt        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> new file mode 100644
> index 000000000000..01d4ed146705
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> @@ -0,0 +1,25 @@
> +Realtek Bluetooth controllers
> +=============================
> +
> +This documents the binding structure and properties for the serial
> +attached Bluetooth controllers from Realtek.
> +
> +Required properties:
> +- compatible: currently, only "realtek,rt8723bs-bt" is supported
> +
> +Optional properties:
> +- enable-gpio: gpio line controlling the power down (BT_DIS#) signal

enable-gpios

Though based on the pin name, powerdown-gpios may be more appropriate. 

> +- device-wake: gpio line controlling the device wakeup (BT_WAKE) signal

device-wake-gpios

> +- config-name: postfix added to the name of the firmware file
> +  containing the chip configuration

'firmware-name' is the common property for this. It's the full filename 
which is more flexible. 

What's the default name?

> +
> +Example:
> +
> +&uart1 {
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bt";
> +		enable-gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
> +		device-wake-gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */

PL4 and PL6 aren't meaningful in this context.

> +		config-name = "teres_a64_i";
> +	};
> +};
> -- 
> 2.23.0
> 
