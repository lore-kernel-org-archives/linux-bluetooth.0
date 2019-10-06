Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E860C10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1902820835
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SvVWbrKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJFP3U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:39911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfJFP3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375741;
        bh=FkngokdC2rUS6EYd82B4YnpsaWxgmijFZFmYGpbP0VQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SvVWbrKMKvLFjTTXtTF5wP+iwQBqsCv24EiNmlE3We+LImczzgQlELGoqlGqSNlk9
         tKbGps8CTVV+CaMQwb6wNo2NTk1Mn7ME9+sj9Fq81N9HgwgOB8+YbK3FWKzr5L8vZQ
         hPVPNBcpUqt9QGFLVp6CFH3Rn+tw9HKEOLwjcgO0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFsYx-1iKD7T2iEx-00HROr; Sun, 06 Oct 2019 17:29:00 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 08/10] ARM: dts: Add minimal Raspberry Pi 4 support
Date:   Sun,  6 Oct 2019 17:28:26 +0200
Message-Id: <1570375708-26965-9-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:4Wlm88GOz3AYHH9St1U2/DPD63GIidkjHqYNhlei15yLV3NenRb
 55kqffLu4iznGaIVarPWo2HYlHz8m4P0nbj5nkVWRBnqbqgZiKvpdCigaRVUN9DxYtAQn3o
 /XBH+eqxEm02CVdcXyPIAwiI9cfMKcwm+3s5mcFoQciprrVc6iSqgLW8toRuRSuyk05ur6s
 OVekJfabgttT+bboogDOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5pfjuFdroGg=:cy6PnVTee79O/+daXKiWm6
 kqyXtcPMVVqo0HBvXHlLcneqxFpsG1CD99dxVMgf5tFJ4Zzk98/npmf+Oivfv91Q3+POZCSTw
 HVsxhtTc1EyuPpa3uIswxsX0eT9G4B9rQUng+35oB3U9EmGqyHeqpFoomT+jF2OdvA3yBjYjZ
 oP1SMEj/57FHoAUnCpCT76OLKEgfsegdnt5FlqEPnYHLbWQUhL15rvhEa3gBit/QN+bdlGoIS
 efcsLpILP/oumw2dfAVbrHv3G6+7blNmQUZoQkVb2oTKV9u6ki5xAeETd/uTNFhp8xJY04SWn
 m/8/3qbJf3bTwXMswAaRTL7jBh69gr2u7NqRlJ+7dmaipa5CLRgEH98Es0XNtFd/i2KURUBUk
 qtxIYOM7s4+cgEH11LuSqHTjvSTfdmXN/aJXdOQHlwSgXenydNkRPi3LdhZZ9atqvnnrLTY+B
 sNjcUnLyT4s12JeuLMANEsvg0FeKrnod0eJgwUFV5Ua9PvHD2/MY+EMTc7vlqthv2iuCH5tEt
 nTYXNfz9fRvQlHbF01otzXIlUr+hBjG3LRmNzU1jLDNudu4Si2QuJ182ghoHylCb9pGounB9v
 WBG+5mV9HQ1KWtIeGxR3cHy1Rzoa+hwhkXKxvaSlQ2FFoIJiK8llJFoPnpTSi6lYJtxdJSJDm
 AX7JjzC2U8n2B60hnpMNS0m1mwKlxoPGu8YNvVzfC9xTChdzbBe3DWO1bSBZHa2bW8ciTGZ3s
 NC2oK5IYDZjq4icCYpf6VEJS1H6Oj/fvM7BxJzbFIS4DjqPJFKmEJUFGSp8dLBO+VPqhiBgMI
 n8ByYH6OqcxcNC9yVG866eBwIjfUNUTo6QqH/VEbGlu4qhfNO4hkgwmZDD0LZiFgD2lXpjcoc
 VcUWA69mmB5ZJKvtWy0tEoSXTbQnF1HYGDmdamFzKA3/pGHMa3GZFo2iM1s7ApOyb12jQWtdE
 4vUW5q9pBYsZqEaeh08pKplgukzQCGg4F3oA6ikP8+A1Ak31SkvTqjYRF/QaQN+/ymtB7aTah
 iHpDqZzkxtUDEMT055UOdZXt8pIlt92ioZDFgu9iFyVWI8/Ua5vh5IqwD2RX1tJOAGBF8Fgq7
 snOGBSwEF8CF8R7GjAFeOI6G3icrDvNr+gkaT9ijPxJfwcuJDDwpOlxIE6B+B/tKZbptdEfbP
 UUt/YEMdFw7vwRL0s4wzn3wFRw36tFhls0x3uM77dFeMM1Pl7lHekHKnAKw+8iXoFuhqpi4yU
 y9/sedqLwO1QU7NyVQZDUg4QPDHbkdhDQzF+Pjw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds minimal support for the new Raspberry Pi 4 without the
fancy stuff like GENET, PCIe, xHCI, 40 bit DMA and V3D. The RPi 4 is
available in 3 different variants (1, 2 and 4 GB RAM), so leave the memory
size to zero and let the bootloader take care of it. The DWC2 is still
usable as peripheral via the USB-C port.

Other differences to the Raspberry Pi 3:
- additional GIC 400 Interrupt controller
- new thermal IP and HWRNG
- additional MMC interface (emmc2)
- additional UART, I2C, SPI and PWM interfaces
- clock stretching bug in I2C IP has been fixed

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Eric Anholt <eric@anholt.net>
Acked-by: Florian Fanelli <f.fainelli@gmail.com>
=2D--
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts             | 123 ++++
 arch/arm/boot/dts/bcm2711.dtsi                    | 844 +++++++++++++++++=
+++++
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi |   7 +
 arch/arm/boot/dts/bcm283x.dtsi                    |   4 +-
 5 files changed, 977 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b21b3a6..21002cd 100644
=2D-- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_BCM2835) +=3D \
 	bcm2837-rpi-3-b.dtb \
 	bcm2837-rpi-3-b-plus.dtb \
 	bcm2837-rpi-cm3-io3.dtb \
+	bcm2711-rpi-4-b.dtb \
 	bcm2835-rpi-zero.dtb \
 	bcm2835-rpi-zero-w.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) +=3D \
diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm=
2711-rpi-4-b.dts
new file mode 100644
index 0000000..cccc1cc
=2D-- /dev/null
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2711.dtsi"
+#include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-usb-peripheral.dtsi"
+
+/ {
+	compatible =3D "raspberrypi,4-model-b", "brcm,bcm2711";
+	model =3D "Raspberry Pi 4 Model B";
+
+	chosen {
+		/* 8250 auxiliary UART instead of pl011 */
+		stdout-path =3D "serial1:115200n8";
+	};
+
+	/* Will be filled by the bootloader */
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0 0 0>;
+	};
+
+	leds {
+		act {
+			gpios =3D <&gpio 42 GPIO_ACTIVE_HIGH>;
+		};
+
+		pwr {
+			label =3D "PWR";
+			gpios =3D <&expgpio 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		reset-gpios =3D <&expgpio 1 GPIO_ACTIVE_LOW>;
+	};
+
+	sd_io_1v8_reg: sd_io_1v8_reg {
+		compatible =3D "regulator-gpio";
+		regulator-name =3D "vdd-sd-io";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-settling-time-us =3D <5000>;
+		gpios =3D <&expgpio 4 GPIO_ACTIVE_HIGH>;
+		states =3D <1800000 0x1
+			  3300000 0x0>;
+		status =3D "okay";
+	};
+};
+
+&firmware {
+	expgpio: gpio {
+		compatible =3D "raspberrypi,firmware-gpio";
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "BT_ON",
+				  "WL_ON",
+				  "PWR_LED_OFF",
+				  "GLOBAL_RESET",
+				  "VDD_SD_IO_SEL",
+				  "CAM_GPIO",
+				  "",
+				  "";
+		status =3D "okay";
+	};
+};
+
+&pwm1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pwm1_0_gpio40 &pwm1_1_gpio41>;
+	status =3D "okay";
+};
+
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&emmc_gpio34>;
+	bus-width =3D <4>;
+	non-removable;
+	mmc-pwrseq =3D <&wifi_pwrseq>;
+	status =3D "okay";
+
+	brcmf: wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+	};
+};
+
+/* EMMC2 is used to drive the SD card */
+&emmc2 {
+	vqmmc-supply =3D <&sd_io_1v8_reg>;
+	broken-cd;
+	status =3D "okay";
+};
+
+/* uart0 communicates with the BT module */
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart0_ctsrts_gpio30 &uart0_gpio32>;
+	uart-has-rtscts;
+	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		max-speed =3D <2000000>;
+		shutdown-gpios =3D <&expgpio 0 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* uart1 is mapped to the pin header */
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart1_gpio14>;
+	status =3D "okay";
+};
+
+&vchiq {
+	interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dt=
si
new file mode 100644
index 0000000..dfc035f
=2D-- /dev/null
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -0,0 +1,844 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bcm283x.dtsi"
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/bcm2835-pm.h>
+
+/ {
+	compatible =3D "brcm,bcm2711";
+
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+
+	interrupt-parent =3D <&gicv2>;
+
+	soc {
+		/*
+		 * Defined ranges:
+		 *   Common BCM283x peripherals
+		 *   BCM2711-specific peripherals
+		 *   ARM-local peripherals
+		 */
+		ranges =3D <0x7e000000  0x0 0xfe000000  0x01800000>,
+			 <0x7c000000  0x0 0xfc000000  0x02000000>,
+			 <0x40000000  0x0 0xff800000  0x00800000>;
+		/* Emulate a contiguous 30-bit address range for DMA */
+		dma-ranges =3D <0xc0000000  0x0 0x00000000  0x3c000000>;
+
+		/*
+		 * This node is the provider for the enable-method for
+		 * bringing up secondary cores.
+		 */
+		local_intc: local_intc@40000000 {
+			compatible =3D "brcm,bcm2836-l1-intc";
+			reg =3D <0x40000000 0x100>;
+		};
+
+		gicv2: interrupt-controller@40041000 {
+			interrupt-controller;
+			#interrupt-cells =3D <3>;
+			compatible =3D "arm,gic-400";
+			reg =3D	<0x40041000 0x1000>,
+				<0x40042000 0x2000>,
+				<0x40044000 0x2000>,
+				<0x40046000 0x2000>;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+						 IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		dma: dma@7e007000 {
+			compatible =3D "brcm,bcm2835-dma";
+			reg =3D <0x7e007000 0xb00>;
+			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     /* DMA lite 7 - 10 */
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "dma0",
+					  "dma1",
+					  "dma2",
+					  "dma3",
+					  "dma4",
+					  "dma5",
+					  "dma6",
+					  "dma7",
+					  "dma8",
+					  "dma9",
+					  "dma10";
+			#dma-cells =3D <1>;
+			brcm,dma-channel-mask =3D <0x07f5>;
+		};
+
+		pm: watchdog@7e100000 {
+			compatible =3D "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			#power-domain-cells =3D <1>;
+			#reset-cells =3D <1>;
+			reg =3D <0x7e100000 0x114>,
+			      <0x7e00a000 0x24>,
+			      <0x7ec11000 0x20>;
+			clocks =3D <&clocks BCM2835_CLOCK_V3D>,
+				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+				 <&clocks BCM2835_CLOCK_H264>,
+				 <&clocks BCM2835_CLOCK_ISP>;
+			clock-names =3D "v3d", "peri_image", "h264", "isp";
+			system-power-controller;
+		};
+
+		rng@7e104000 {
+			interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+
+			/* RNG is incompatible with brcm,bcm2835-rng */
+			status =3D "disabled";
+		};
+
+		uart2: serial@7e201400 {
+			compatible =3D "arm,pl011", "arm,primecell";
+			reg =3D <0x7e201400 0x200>;
+			interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_UART>,
+				 <&clocks BCM2835_CLOCK_VPU>;
+			clock-names =3D "uartclk", "apb_pclk";
+			arm,primecell-periphid =3D <0x00241011>;
+			status =3D "disabled";
+		};
+
+		uart3: serial@7e201600 {
+			compatible =3D "arm,pl011", "arm,primecell";
+			reg =3D <0x7e201600 0x200>;
+			interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_UART>,
+				 <&clocks BCM2835_CLOCK_VPU>;
+			clock-names =3D "uartclk", "apb_pclk";
+			arm,primecell-periphid =3D <0x00241011>;
+			status =3D "disabled";
+		};
+
+		uart4: serial@7e201800 {
+			compatible =3D "arm,pl011", "arm,primecell";
+			reg =3D <0x7e201800 0x200>;
+			interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_UART>,
+				 <&clocks BCM2835_CLOCK_VPU>;
+			clock-names =3D "uartclk", "apb_pclk";
+			arm,primecell-periphid =3D <0x00241011>;
+			status =3D "disabled";
+		};
+
+		uart5: serial@7e201a00 {
+			compatible =3D "arm,pl011", "arm,primecell";
+			reg =3D <0x7e201a00 0x200>;
+			interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_UART>,
+				 <&clocks BCM2835_CLOCK_VPU>;
+			clock-names =3D "uartclk", "apb_pclk";
+			arm,primecell-periphid =3D <0x00241011>;
+			status =3D "disabled";
+		};
+
+		spi3: spi@7e204600 {
+			compatible =3D "brcm,bcm2835-spi";
+			reg =3D <0x7e204600 0x0200>;
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		spi4: spi@7e204800 {
+			compatible =3D "brcm,bcm2835-spi";
+			reg =3D <0x7e204800 0x0200>;
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		spi5: spi@7e204a00 {
+			compatible =3D "brcm,bcm2835-spi";
+			reg =3D <0x7e204a00 0x0200>;
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		spi6: spi@7e204c00 {
+			compatible =3D "brcm,bcm2835-spi";
+			reg =3D <0x7e204c00 0x0200>;
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@7e205600 {
+			compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg =3D <0x7e205600 0x200>;
+			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@7e205800 {
+			compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg =3D <0x7e205800 0x200>;
+			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c5: i2c@7e205a00 {
+			compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg =3D <0x7e205a00 0x200>;
+			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c6: i2c@7e205c00 {
+			compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg =3D <0x7e205c00 0x200>;
+			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2835_CLOCK_VPU>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		pwm1: pwm@7e20c800 {
+			compatible =3D "brcm,bcm2835-pwm";
+			reg =3D <0x7e20c800 0x28>;
+			clocks =3D <&clocks BCM2835_CLOCK_PWM>;
+			assigned-clocks =3D <&clocks BCM2835_CLOCK_PWM>;
+			assigned-clock-rates =3D <10000000>;
+			#pwm-cells =3D <2>;
+			status =3D "disabled";
+		};
+
+		emmc2: emmc2@7e340000 {
+			compatible =3D "brcm,bcm2711-emmc2";
+			reg =3D <0x7e340000 0x100>;
+			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clocks BCM2711_CLOCK_EMMC2>;
+			status =3D "disabled";
+		};
+
+		hvs@7e400000 {
+			interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	arm-pmu {
+		compatible =3D "arm,cortex-a72-pmu", "arm,armv8-pmuv3";
+		interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		/* This only applies to the ARMv7 stub */
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	cpus: cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		enable-method =3D "brcm,bcm2836-smp"; // for ARM 32-bit
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			reg =3D <0>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x000000d8>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			reg =3D <1>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x000000e0>;
+		};
+
+		cpu2: cpu@2 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			reg =3D <2>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x000000e8>;
+		};
+
+		cpu3: cpu@3 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			reg =3D <3>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x000000f0>;
+		};
+	};
+};
+
+&clk_osc {
+	clock-frequency =3D <54000000>;
+};
+
+&clocks {
+	compatible =3D "brcm,bcm2711-cprman";
+};
+
+&cpu_thermal {
+	coefficients =3D <(-487) 410040>;
+};
+
+&dsi0 {
+	interrupts =3D <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&dsi1 {
+	interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio {
+	compatible =3D "brcm,bcm2711-gpio";
+	interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+
+	gpclk0_gpio49: gpclk0_gpio49 {
+		pin-gpclk {
+			pins =3D "gpio49";
+			function =3D "alt1";
+			bias-disable;
+		};
+	};
+	gpclk1_gpio50: gpclk1_gpio50 {
+		pin-gpclk {
+			pins =3D "gpio50";
+			function =3D "alt1";
+			bias-disable;
+		};
+	};
+	gpclk2_gpio51: gpclk2_gpio51 {
+		pin-gpclk {
+			pins =3D "gpio51";
+			function =3D "alt1";
+			bias-disable;
+		};
+	};
+
+	i2c0_gpio46: i2c0_gpio46 {
+		pin-sda {
+			function =3D "alt0";
+			pins =3D "gpio46";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt0";
+			pins =3D "gpio47";
+			bias-disable;
+		};
+	};
+	i2c1_gpio46: i2c1_gpio46 {
+		pin-sda {
+			function =3D "alt1";
+			pins =3D "gpio46";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt1";
+			pins =3D "gpio47";
+			bias-disable;
+		};
+	};
+	i2c3_gpio2: i2c3_gpio2 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio2";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio3";
+			bias-disable;
+		};
+	};
+	i2c3_gpio4: i2c3_gpio4 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio4";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio5";
+			bias-disable;
+		};
+	};
+	i2c4_gpio6: i2c4_gpio6 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio6";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio7";
+			bias-disable;
+		};
+	};
+	i2c4_gpio8: i2c4_gpio8 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio8";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio9";
+			bias-disable;
+		};
+	};
+	i2c5_gpio10: i2c5_gpio10 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio10";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio11";
+			bias-disable;
+		};
+	};
+	i2c5_gpio12: i2c5_gpio12 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio12";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio13";
+			bias-disable;
+		};
+	};
+	i2c6_gpio0: i2c6_gpio0 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio0";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio1";
+			bias-disable;
+		};
+	};
+	i2c6_gpio22: i2c6_gpio22 {
+		pin-sda {
+			function =3D "alt5";
+			pins =3D "gpio22";
+			bias-pull-up;
+		};
+		pin-scl {
+			function =3D "alt5";
+			pins =3D "gpio23";
+			bias-disable;
+		};
+	};
+	i2c_slave_gpio8: i2c_slave_gpio8 {
+		pins-i2c-slave {
+			pins =3D "gpio8",
+			       "gpio9",
+			       "gpio10",
+			       "gpio11";
+			function =3D "alt3";
+		};
+	};
+
+	jtag_gpio48: jtag_gpio48 {
+		pins-jtag {
+			pins =3D "gpio48",
+			       "gpio49",
+			       "gpio50",
+			       "gpio51",
+			       "gpio52",
+			       "gpio53";
+			function =3D "alt4";
+		};
+	};
+
+	mii_gpio28: mii_gpio28 {
+		pins-mii {
+			pins =3D "gpio28",
+			       "gpio29",
+			       "gpio30",
+			       "gpio31";
+			function =3D "alt4";
+		};
+	};
+	mii_gpio36: mii_gpio36 {
+		pins-mii {
+			pins =3D "gpio36",
+			       "gpio37",
+			       "gpio38",
+			       "gpio39";
+			function =3D "alt5";
+		};
+	};
+
+	pcm_gpio50: pcm_gpio50 {
+		pins-pcm {
+			pins =3D "gpio50",
+			       "gpio51",
+			       "gpio52",
+			       "gpio53";
+			function =3D "alt2";
+		};
+	};
+
+	pwm0_0_gpio12: pwm0_0_gpio12 {
+		pin-pwm {
+			pins =3D "gpio12";
+			function =3D "alt0";
+			bias-disable;
+		};
+	};
+	pwm0_0_gpio18: pwm0_0_gpio18 {
+		pin-pwm {
+			pins =3D "gpio18";
+			function =3D "alt5";
+			bias-disable;
+		};
+	};
+	pwm1_0_gpio40: pwm1_0_gpio40 {
+		pin-pwm {
+			pins =3D "gpio40";
+			function =3D "alt0";
+			bias-disable;
+		};
+	};
+	pwm0_1_gpio13: pwm0_1_gpio13 {
+		pin-pwm {
+			pins =3D "gpio13";
+			function =3D "alt0";
+			bias-disable;
+		};
+	};
+	pwm0_1_gpio19: pwm0_1_gpio19 {
+		pin-pwm {
+			pins =3D "gpio19";
+			function =3D "alt5";
+			bias-disable;
+		};
+	};
+	pwm1_1_gpio41: pwm1_1_gpio41 {
+		pin-pwm {
+			pins =3D "gpio41";
+			function =3D "alt0";
+			bias-disable;
+		};
+	};
+	pwm0_1_gpio45: pwm0_1_gpio45 {
+		pin-pwm {
+			pins =3D "gpio45";
+			function =3D "alt0";
+			bias-disable;
+		};
+	};
+	pwm0_0_gpio52: pwm0_0_gpio52 {
+		pin-pwm {
+			pins =3D "gpio52";
+			function =3D "alt1";
+			bias-disable;
+		};
+	};
+	pwm0_1_gpio53: pwm0_1_gpio53 {
+		pin-pwm {
+			pins =3D "gpio53";
+			function =3D "alt1";
+			bias-disable;
+		};
+	};
+
+	rgmii_gpio35: rgmii_gpio35 {
+		pin-start-stop {
+			pins =3D "gpio35";
+			function =3D "alt4";
+		};
+		pin-rx-ok {
+			pins =3D "gpio36";
+			function =3D "alt4";
+		};
+	};
+	rgmii_irq_gpio34: rgmii_irq_gpio34 {
+		pin-irq {
+			pins =3D "gpio34";
+			function =3D "alt5";
+		};
+	};
+	rgmii_irq_gpio39: rgmii_irq_gpio39 {
+		pin-irq {
+			pins =3D "gpio39";
+			function =3D "alt4";
+		};
+	};
+	rgmii_mdio_gpio28: rgmii_mdio_gpio28 {
+		pins-mdio {
+			pins =3D "gpio28",
+			       "gpio29";
+			function =3D "alt5";
+		};
+	};
+	rgmii_mdio_gpio37: rgmii_mdio_gpio37 {
+		pins-mdio {
+			pins =3D "gpio37",
+			       "gpio38";
+			function =3D "alt4";
+		};
+	};
+
+	spi0_gpio46: spi0_gpio46 {
+		pins-spi {
+			pins =3D "gpio46",
+			       "gpio47",
+			       "gpio48",
+			       "gpio49";
+			function =3D "alt2";
+		};
+	};
+	spi2_gpio46: spi2_gpio46 {
+		pins-spi {
+			pins =3D "gpio46",
+			       "gpio47",
+			       "gpio48",
+			       "gpio49",
+			       "gpio50";
+			function =3D "alt5";
+		};
+	};
+	spi3_gpio0: spi3_gpio0 {
+		pins-spi {
+			pins =3D "gpio0",
+			       "gpio1",
+			       "gpio2",
+			       "gpio3";
+			function =3D "alt3";
+		};
+	};
+	spi4_gpio4: spi4_gpio4 {
+		pins-spi {
+			pins =3D "gpio4",
+			       "gpio5",
+			       "gpio6",
+			       "gpio7";
+			function =3D "alt3";
+		};
+	};
+	spi5_gpio12: spi5_gpio12 {
+		pins-spi {
+			pins =3D "gpio12",
+			       "gpio13",
+			       "gpio14",
+			       "gpio15";
+			function =3D "alt3";
+		};
+	};
+	spi6_gpio18: spi6_gpio18 {
+		pins-spi {
+			pins =3D "gpio18",
+			       "gpio19",
+			       "gpio20",
+			       "gpio21";
+			function =3D "alt3";
+		};
+	};
+
+	uart2_gpio0: uart2_gpio0 {
+		pin-tx {
+			pins =3D "gpio0";
+			function =3D "alt4";
+			bias-disable;
+		};
+		pin-rx {
+			pins =3D "gpio1";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+	};
+	uart2_ctsrts_gpio2: uart2_ctsrts_gpio2 {
+		pin-cts {
+			pins =3D "gpio2";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+		pin-rts {
+			pins =3D "gpio3";
+			function =3D "alt4";
+			bias-disable;
+		};
+	};
+	uart3_gpio4: uart3_gpio4 {
+		pin-tx {
+			pins =3D "gpio4";
+			function =3D "alt4";
+			bias-disable;
+		};
+		pin-rx {
+			pins =3D "gpio5";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+	};
+	uart3_ctsrts_gpio6: uart3_ctsrts_gpio6 {
+		pin-cts {
+			pins =3D "gpio6";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+		pin-rts {
+			pins =3D "gpio7";
+			function =3D "alt4";
+			bias-disable;
+		};
+	};
+	uart4_gpio8: uart4_gpio8 {
+		pin-tx {
+			pins =3D "gpio8";
+			function =3D "alt4";
+			bias-disable;
+		};
+		pin-rx {
+			pins =3D "gpio9";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+	};
+	uart4_ctsrts_gpio10: uart4_ctsrts_gpio10 {
+		pin-cts {
+			pins =3D "gpio10";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+		pin-rts {
+			pins =3D "gpio11";
+			function =3D "alt4";
+			bias-disable;
+		};
+	};
+	uart5_gpio12: uart5_gpio12 {
+		pin-tx {
+			pins =3D "gpio12";
+			function =3D "alt4";
+			bias-disable;
+		};
+		pin-rx {
+			pins =3D "gpio13";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+	};
+	uart5_ctsrts_gpio14: uart5_ctsrts_gpio14 {
+		pin-cts {
+			pins =3D "gpio14";
+			function =3D "alt4";
+			bias-pull-up;
+		};
+		pin-rts {
+			pins =3D "gpio15";
+			function =3D "alt4";
+			bias-disable;
+		};
+	};
+};
+
+&i2c0 {
+	compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+	interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&i2c1 {
+	compatible =3D "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+	interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mailbox {
+	interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sdhci {
+	interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sdhost {
+	interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spi {
+	interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spi1 {
+	interrupts =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spi2 {
+	interrupts =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&system_timer {
+	interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&txp {
+	interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart0 {
+	interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart1 {
+	interrupts =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&usb {
+	interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&vec {
+	interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi b/arch/arm/=
boot/dts/bcm283x-rpi-usb-peripheral.dtsi
new file mode 100644
index 0000000..0ff0e9e
=2D-- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+&usb {
+	dr_mode =3D "peripheral";
+	g-rx-fifo-size =3D <256>;
+	g-np-tx-fifo-size =3D <32>;
+	g-tx-fifo-size =3D <256 256 512 512 512 768 768>;
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dt=
si
index addf3be..3caaa57 100644
=2D-- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -53,7 +53,7 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;

-		timer@7e003000 {
+		system_timer: timer@7e003000 {
 			compatible =3D "brcm,bcm2835-system-timer";
 			reg =3D <0x7e003000 0x1000>;
 			interrupts =3D <1 0>, <1 1>, <1 2>, <1 3>;
@@ -64,7 +64,7 @@
 			clock-frequency =3D <1000000>;
 		};

-		txp@7e004000 {
+		txp: txp@7e004000 {
 			compatible =3D "brcm,bcm2835-txp";
 			reg =3D <0x7e004000 0x20>;
 			interrupts =3D <1 11>;
=2D-
2.7.4

