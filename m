Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B7CC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C490205F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 16:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCKQlO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:41:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52230 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQlO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 12:41:14 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6086ECF2C9;
        Mon, 11 Mar 2019 17:49:11 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline
 Bluetooth support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
Date:   Mon, 11 Mar 2019 17:41:12 +0100
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        frowand.list@gmail.com, Johan Hedberg <johan.hedberg@gmail.com>,
        anarsoul@gmail.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C67B8798-ACD1-470B-B69A-650A62AE7982@holtmann.org>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

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
> arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 0ffab1b7c940..d29f5b34d7e6 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -486,6 +486,17 @@
> 
> &uart0 {
> 	status = "okay";
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
> };

I need an ACK from Rob for this and also you might want to send the whole series for me to review in full context.

Regards

Marcel

