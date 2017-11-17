Return-Path: <martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: mark.rutland@arm.com,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	gregkh@linuxfoundation.org,
	jslaby@suse.com,
	johan@kernel.org,
	linux-sunxi@googlegroups.com,
	linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 8/8] dt-bindings: net: bluetooth: add support for Realtek Bluetooth chips
Date: Fri, 17 Nov 2017 23:35:43 +0100
Message-Id: <20171117223543.32429-9-martin.blumenstingl@googlemail.com>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the documentation for Bluetooth functionality of the Realtek
RTL8723BS and RTL8723DS.
Both are SDIO wifi chips with an additional Bluetooth module which is
connected via UART to the host.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/net/realtek-bluetooth.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
new file mode 100644
index 000000000000..c919e06469f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
@@ -0,0 +1,31 @@
+Realtek Bluetooth Chips
+-----------------------
+
+This documents the binding structure and common properties for serial
+attached Realtek devices.
+
+Serial attached Realtek devices shall be a child node of the host UART
+device the slave device is attached to. See ../serial/slave-device.txt
+for more information
+
+Required properties:
+- compatible: should contain one of the following:
+    * "realtek,rtl8723bs-bluetooth"
+    * "realtek,rtl8723ds-bluetooth"
+
+Optional properties:
+- disable-gpios: GPIO specifier, used to enable/disable the BT module
+- reset-gpios: GPIO specifier, used to reset the BT module
+
+
+Example:
+
+&uart {
+	...
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bluetooth";
+		disable-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.15.0
