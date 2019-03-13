Return-Path: <SRS0=EDUn=RQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956CBC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 10:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D12020449
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 10:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCMK5H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:57:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40524 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfCMK5H (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Mar 2019 06:57:07 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h41ZD-00080d-Au; Wed, 13 Mar 2019 11:56:59 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, anarsoul@gmail.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline Bluetooth support
Date:   Wed, 13 Mar 2019 11:56:58 +0100
Message-ID: <4537885.W6WcYDDAQ4@diego>
In-Reply-To: <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk> <20190309153923.22806-1-beagleboard@davidjohnsummers.uk> <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

Am Samstag, 9. März 2019, 16:39:23 CET schrieb David Summers:
> This patch is an outline for bluetooth on the ASUS Tinker Board (S).
> 
> Bluetooth is provided my RTL8723BS on these machine, and this is wired
> into UART0.
> 
> Here this is performed as a SerDev device.
> 
> Now as presented, this does not give functioning bluetooth. The
> updates needed to the device driver:
> 
> https://www.spinics.net/lists/linux-bluetooth/msg78661.html
> 
> Haven't yet been accepted. So this device tree hook doesn't yet have
> "realtek,rtl8723bs-bt" compatible flag.
> 
> It is however still submitted as a patch, as it sets the UART up
> correctly. And so basic communciation can be had with the device. This
> has been confirmed by Tony McKahan @ Armbian, in particular that the
> CTS/RTS is needed.
> 
> When Vasily patch is accepted, this will be added as a minor patch on
> top of this patch; as this patch gives the pins needed.
> 
> The one oddity, is the RESET pin, it is labeled this way on the
> schematic. However the hci_h5.c driver calls this ENABLE. Here we have
> stuck with the schematic name.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi
> b/arch/arm/boot/dts/rk3288-tinker.dtsi index 0ffab1b7c940..d29f5b34d7e6
> 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -486,6 +486,17 @@
> 
>  &uart0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
> +
> +	bluetooth {
> +		clocks = <&rk808 RK808_CLKOUT1>;
> +		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +		vcc-18-supply = <&vcc_18>;
> +		vcc-io-supply = <&vcc_io>;
> +	};

As this is supposed to work as serial attached device it should follow a
dt-binding, so first of all definitly needs a compatible and a binding
specifying all the properties declared above.

See for example Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
for a similar device.

Heiko


