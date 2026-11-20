Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217673;
	b=BjJRIAOobuG8ADdc+HlKWk0ycVR2l0vwCBENZvBD9PImVpFRbsn9PlnklSqIeOQhn+ro
	 CivpbQYKAo/sQ3Acuf00IcjIM7qUIKxUNaqKOxqS8Npwcno54sbu7/tjItK8z+Eh/b61t
	 SjqMRznB1Si5nnSnxWN2hfgczXLTPx/lGlK+ZfX84gtlAhusN2TMBs4jh+63ylvaTqSqi
	 BbqlB2ZzWO4bjk/yxEe2r8Zj7g034ttjf2YRrjqDCkoFZxhxTiKjR+VXwKTGnmwkvGrgx
	 6Qr9YH9lPOcB5Yj/Uzu/7Bmv2LQbPy9HhrT3sURDEtzAe+gQUq13qGWyGQXjsFKVqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217673;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jSVkms071gBFhS0ZEXeIERho5bLbtUl4WQoLD2P05l8=;
	b=2u1PsT6BaCos5OYtpFyvIfnKVt0Gi+PZ1b1kM1AKhl2KCmgNwcnhTfy9qImZ6592y2AX
	 yheHG6UDZT9Ueun7R6cotdUNrR/ob0IeOWCJmEEXeFh+G3uSAdud2+VnQFXWsH69uQa+U
	 OgyLoNE07dZCquj8oHuo0K91fMGKUK1nLBNlCc/kplmqVeCGGnf0L79+EpAH2Zy3ZDZTZ
	 7cBPUzBHklAQXrfPAaX0T5S7FAsd87BpVa3QfNV13OUeB3o+rsZaUTcG4GFg/V/U28G5+
	 Gj9uhnoR07tgosw/aSyvEMr3R0tNLfxTAisNJMpBt2A6hdkSn76eJUHViq0NxJn8PZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VgPZKB/F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D96606A33C;
	Fri, 20 Nov 2026 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgPZKB/F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA221F000D4;
	Fri, 20 Nov 2026 23:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795217672;
	bh=jSVkms071gBFhS0ZEXeIERho5bLbtUl4WQoLD2P05l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VgPZKB/FSgIyhPRU6BJYdxGdGWMbuTB1hYp8WeiDLcp7OqO7xtBLeAWRf0yiArqL1
	 yRmCt4VQ9hNrcQ8cJGcmDLApMT56qKBGzgV3HSE/ALZvkJfpYxQpNtlGG66lU0gHf0
	 T/DnImfPtOY+vW0qgVOARu43s01XRcGkLKL/pjWFzC9nEaWsFA2KZv0OftdLoMhkOu
	 kG2HsjJqwxPkE4/6X5hb2juou9TKL67jsUTjTxpPiM5lQhdKtc0ZcrUySuhuQdFk7M
	 R/mRtk9CmTlXzLmuT/FLb0jDiAPtT1RG+uw1ygFAH1Ph9cXS+fDVECujNZA2jzukGu
	 0aVQC8o8vSyGg==
Date: Fri, 20 Nov 2026 15:34:30 -0800
From: Drew Fustini <fustini@kernel.org>
To: Thomas Gerner <thomas.gerner@muenchen-mail.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: thead: Enable bluetooth on
 BeagleV-Ahead
Message-ID: <awDZBiX1VoSkO6F3@x1>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
 <20261020132604.90708-3-thomas.gerner@muenchen-mail.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020132604.90708-3-thomas.gerner@muenchen-mail.de>

On Tue, Oct 20, 2026 at 03:26:04PM +0200, Thomas Gerner wrote:
> On the BeagleV-Ahead the bluetooth module of the Ampak AP6203BM is
> identified by the btbcm driver as BCM4362A2. The module is connected by
> UART4, several gpio pins and an I2S interface. The I2S is currently not
> used as there is currently no driver.
> 
> Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
> ---
> Changes in v2:
> 	- use default pinctrl definition for bluetooth in and out pins

Thanks for sending v2. Sorry for the delay in review.

> 	
>  .../boot/dts/thead/th1520-beaglev-ahead.dts   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index e16484a47653..7161a9d4c61f 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -76,6 +76,23 @@ led-5 {
>  		};
>  	};
>  
> +	reg_vbat_1v8: regulator-vbat-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-boot-on;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "vbat-1v8";
> +	};
> +
> +	reg_vbat_3v3: regulator-vbat-3v3 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;

enable-active-high has no effect without a gpio.

> +		regulator-boot-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "vbat-3v3";
> +	};

Nothing can switch these two rails so regulator-always-on describes them
better than regulator-boot-on.

> +
>  	hdmi-connector {
>  		compatible = "hdmi-connector";
>  		type = "d";
> @@ -152,6 +169,28 @@ led-pins {
>  };
>  
>  &padctrl0_apsys {
> +	bluetooth_pins: bluetooth-0 {
> +		in-pins {
> +			bias-disable;
> +			drive-strength = <1>;
> +			function = "gpio";
> +			input-enable;
> +			input-schmitt-enable;
> +			pins = "GPIO2_30";
> +			slew-rate = <0>;
> +		};
> +
> +		out-pins {
> +			bias-disable;
> +			drive-strength = <3>;
> +			input-disable;
> +			input-schmitt-disable;
> +			pins = "SDIO1_DETN",	/* GPIO2_29 */
> +			       "SDIO1_WPRTN";	/* GPIO2_28 */
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	gmac0_pins: gmac0-0 {
>  		tx-pins {
>  			pins = "GMAC0_TX_CLK",
> @@ -268,6 +307,30 @@ reg-on-pins {
>  	};
>  };
>  
> +&padctrl1_apsys {
> +	uart4_pins: uart4-0 {
> +		rx-pins {
> +			bias-disable;
> +			drive-strength = <1>;
> +			function = "uart";
> +			input-enable;
> +			pins = "UART4_RXD", "UART4_CTSN";
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +
> +		tx-pins {
> +			bias-disable;
> +			drive-strength = <3>;
> +			function = "uart";
> +			input-disable;
> +			pins = "UART4_TXD", "UART4_RTSN";
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &sdio0 {
>  	bus-width = <4>;
>  	max-frequency = <198000000>;
> @@ -314,3 +377,25 @@ &uart0 {
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&uart4 {
> +	pinctrl-0 = <&uart4_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm4329-bt";
> +		device-wakeup-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <30 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "host-wakeup";
> +		max-speed = <921600>;
> +		pinctrl-0 = <&bluetooth_pins>;
> +		pinctrl-names = "default";
> +		shutdown-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>; 	/* BT-REG-ON */

This triggers checkpatch:

WARNING: please, no space before tabs
#230: FILE: arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts:397:
+^I^Ishutdown-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>; ^I/* BT-REG-ON */$

> +		vbat-supply = <&reg_vbat_3v3>;
> +		vddio-supply = <&reg_vbat_1v8>;
> +	};
> +};
> -- 
> 2.53.0
> 

Thanks,
Drew
