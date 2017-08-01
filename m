Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: robh+dt@kernel.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	f.fainelli@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	stefan.wahren@i2se.com
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH v2 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial slave
Date: Tue,  1 Aug 2017 10:38:23 +0200
Message-Id: <1501576704-26423-2-git-send-email-loic.poulain@gmail.com>
In-Reply-To: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
This allows to automatically insert the bcm43438 to the bluetooth
subsystem instead of relying on userspace helpers (hciattach).

Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
of pl011/ttyAMA0.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
v2: dt-bindings as separate patch
    rebase on upcoming pi3 dts changes

 arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 20725ca..5abc1df 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -8,6 +8,11 @@
 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
 	model = "Raspberry Pi 3 Model B";
 
+	chosen {
+		/* 8250 auxiliar UART instead of pl011 */
+		bootargs = "earlyprintk console=ttyS0,115200";
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
+		max-speed = <921600>;
+	};
 };
 
 /* uart1 is mapped to the pin header */
-- 
1.9.1
