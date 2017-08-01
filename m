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
Subject: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add broadcom-bluetooth
Date: Tue,  1 Aug 2017 10:38:22 +0200
Message-Id: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add binding document for serial bluetooth chips using
Broadcom protocol.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
v2: dt-bindings as separate patch
    rebase on upcoming pi3 dts changes

 .../devicetree/bindings/net/broadcom-bluetooth.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
new file mode 100644
index 0000000..c51ea1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -0,0 +1,29 @@
+Broadcom Bluetooth Chips
+---------------------
+
+This documents the binding structure and common properties for serial
+attached Broadcom devices.
+
+Serial attached Broadcom devices shall be a child node of the host UART
+device the slave device is attached to.
+
+Required properties:
+
+ - compatible: should contain one of the following:
+   * "brcm,bcm43438-bt"
+
+Optional properties:
+
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Example:
+
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins>;
+
+       bluetooth {
+               compatible = "brcm,bcm43438-bt";
+               max-speed = <921600>;
+       };
+};
-- 
1.9.1
