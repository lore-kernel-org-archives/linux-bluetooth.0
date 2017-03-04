Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: dts: N9/N950: add bluetooth
Date: Sat,  4 Mar 2017 12:58:24 +0100
Message-Id: <20170304115833.3538-2-sre@kernel.org>
In-Reply-To: <20170304115833.3538-1-sre@kernel.org>
References: <20170304115833.3538-1-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The Nokia N950 and N9 have a wl1271 (with nokia bootloader) bluetooth
module connected to second UART.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 5d8c4b4a4205..704f11c83165 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -58,6 +58,13 @@
 			pinctrl-0 = <&debug_leds>;
 		};
 	};
+
+	/* controlled (enabled/disabled) directly by wl1271 */
+	vctcxo: vctcxo {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
 };
 
 &omap3_pmx_core {
@@ -125,6 +132,15 @@
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE4)            /* gpio_93 (cmt_apeslpx) */
 		>;
 	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)		/* uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -435,3 +451,19 @@
 &ssi_port2 {
 	status = "disabled";
 };
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+
+	bluetooth {
+		compatible = "nokia,ti,wl1271-bluetooth";
+
+		reset-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>; /* 26 */
+		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
+		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
+
+		clocks = <&vctcxo>;
+		clock-names = "sysclk";
+	};
+};
-- 
2.11.0
