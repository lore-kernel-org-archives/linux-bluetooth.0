Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: robh+dt@kernel.org,
	f.fainelli@gmail.com,
	rjui@broadcom.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	stefan.wahren@i2se.com
Cc: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH v4 3/4] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave
Date: Thu, 17 Aug 2017 19:59:50 +0200
Message-Id: <1502992791-10265-3-git-send-email-loic.poulain@gmail.com>
In-Reply-To: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add BCM43438 (bluetooth) as a slave device of uart0 (pl011/ttyAMA0).
This allows to automatically insert the bcm43438 to the bluetooth
subsystem instead of relying on userspace helpers (hciattach).

Overwrite chosen/stdout-path to use 8250 aux uart as console.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
 v2: dt-bindings as separate patch
     rebase on upcoming pi3 dts changes
 v3: changes in bcm serdev drivers:
     name refactoring and additional comments
     Add generic host_set_baudrate method
     Use agnostic device_property_read
 v4: changes in doc and dts:
     Add additional params to broadcom bt dt-bindings
     Set the max baudrate to 2000000 instead of 921600
     use chosen/stdout-path instead of console=
     remove useless earlyprintk
     same changes in bcm283x.dtsi

 arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 20725ca..e4488cb 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -8,6 +8,11 @@
 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
 	model = "Raspberry Pi 3 Model B";
 
+	chosen {
+		/* 8250 auxiliar UART instead of pl011 */
+		stdout-path = "serial1:115200n8";
+	};
+
 	memory {
 		reg = <0 0x40000000>;
 	};
@@ -24,6 +29,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <2000000>;
+	};
 };
 
 /* uart1 is mapped to the pin header */
-- 
1.9.1
