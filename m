Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Xinming Hu <huxm@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v8 1/2] dt: bindings: add MARVELL's bt-sd8xxx wireless device
Date: Tue, 26 Apr 2016 06:57:26 -0700
Message-ID: <1461679047-22631-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

Add device tree binding documentation for MARVELL's bluetooth sdio
(sd8897 and sd8997) chip.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
Listing changelist for both 1/2 and 2/2 here
v2: Fixed build error reported by kbuild test robot
drivers/bluetooth/btmrvl_platform.c:141:22: error:
'btmrvl_plt_pm_ops' undeclared here (not in a function)

v3: Add NULL check for 'btmrvl_plt_dev'

v4: Moved the bindings file to bindings/net/
    Corrected the name of 'name' and 'compatible' properties(Rob Herring)

v5: Comments for wlan patches were applicable here as well. Like all binding
    changes in single file, specifying node as a child of SDIO controller.

v6: a)Use <chip>-bt order for compatible attribute(Rob Herring)
    b)Split wakeuppin-gap to wakeup-pin and wakeup-gap(Rob Herring) 
    c)Use sdio function number for both the unit address and reg(Rob Herring)

v7: a)Use suggested vendor name and generic node name(Rob Herring)
v8: a)Nodes are renamed as per suggestions from Rob Herring
      btmrvl,* -> marvell,*
      "wakeup-gap-msec" -> "wakeup-gap-ms"
---
 Documentation/devicetree/bindings/btmrvl.txt       | 29 -----------
 .../devicetree/bindings/net/marvell-bt-sd8xxx.txt  | 56 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/btmrvl.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt

diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
deleted file mode 100644
index 58f964b..0000000
--- a/Documentation/devicetree/bindings/btmrvl.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-btmrvl
-------
-
-Required properties:
-
-  - compatible : must be "btmrvl,cfgdata"
-
-Optional properties:
-
-  - btmrvl,cal-data : Calibration data downloaded to the device during
-		      initialization. This is an array of 28 values(u8).
-
-  - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
-		      configured.
-
-Example:
-
-GPIO pin 13 is configured as a wakeup source and GAP is set to 100 msecs
-in below example.
-
-btmrvl {
-	compatible = "btmrvl,cfgdata";
-
-	btmrvl,cal-data = /bits/ 8 <
-		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
-		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
-		0x00 0x00 0xf0 0x00>;
-	btmrvl,gpio-gap = <0x0d64>;
-};
diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
new file mode 100644
index 0000000..14aa6cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
@@ -0,0 +1,56 @@
+Marvell 8897/8997 (sd8897/sd8997) bluetooth SDIO devices
+------
+
+Required properties:
+
+  - compatible : should be one of the following:
+	* "marvell,sd8897-bt"
+	* "marvell,sd8997-bt"
+
+Optional properties:
+
+  - marvell,cal-data: Calibration data downloaded to the device during
+		      initialization. This is an array of 28 values(u8).
+
+  - marvell,wakeup-pin: It represents wakeup pin number of the bluetooth chip.
+		        firmware will use the pin to wakeup host system.
+  - marvell,wakeup-gap-ms: wakeup gap represents wakeup latency of the host
+		      platform. The value will be configured to firmware. This
+		      is needed to work chip's sleep feature as expected.
+  - interrupt-parent: phandle of the parent interrupt controller
+  - interrupts : interrupt pin number to the cpu. Driver will request an irq based
+		 on this interrupt number. During system suspend, the irq will be
+		 enabled so that the bluetooth chip can wakeup host platform under
+		 certain condition. During system resume, the irq will be disabled
+		 to make sure unnecessary interrupt is not received.
+
+Example:
+
+IRQ pin 119 is used as system wakeup source interrupt.
+wakeup pin 13 and gap 100ms are configured so that firmware can wakeup host
+using this device side pin and wakeup latency.
+calibration data is also available in below example.
+
+&mmc3 {
+	status = "okay";
+	vmmc-supply = <&wlan_en_reg>;
+	bus-width = <4>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	btmrvl: bluetooth@2 {
+		compatible = "marvell,sd8897-bt";
+		reg = <2>;
+		interrupt-parent = <&pio>;
+		interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
+
+		marvell,cal-data = /bits/ 8 <
+			0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
+			0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
+			0x00 0x00 0xf0 0x00>;
+		marvell,wakeup-pin = <0x0d>;
+		marvell,wakeup-gap-ms = <0x64>;
+	};
+};
-- 
1.8.1.4
