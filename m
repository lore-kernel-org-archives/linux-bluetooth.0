Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC 1/2] Bluetooth UART Device Tree bindings
Date: Thu, 7 May 2015 16:25:28 -0400
Message-ID: <1431030329-22929-2-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com>
References: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device Tree bindings to configure the Bluetooth UART device.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 .../devicetree/bindings/net/bluetooth/btbcm.txt    | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt

diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
new file mode 100644
index 0000000..cc9f225
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
@@ -0,0 +1,54 @@
+btbcm
+------
+
+Required properties:
+
+	- compatible : must be "brcm,brcm-bt-uart".
+	- tty : tty device connected to this Bluetooth device.
+
+Optional properties:
+
+  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
+
+  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
+
+  - reg-on-gpios : reg-on output GPIO to be used to power device on/off.
+
+  - baud-rate-before-config-download : initial Bluetooth device baud rate.
+    Default: 3000000.
+
+  - manual-fc : flow control UART in suspend / resume scenarios.
+    Default: 0.
+
+  - configure-sleep : configure suspend / resume flag.
+    Default: 0.
+
+  - configure-audio : configure platform PCM SCO flag.
+    Default: 0.
+
+  - PCM* : SCO PCM platform parameters. Work with Broadcom on setting.
+    Defaults: see the example below.
+
+
+Example:
+
+	bcm4354_bt_uart: bcm4354-bt-uart {
+		compatible = "bcm-bt-uart,bcm4354-bt-uart";
+		bt-wake-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		bt-host-wake-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+		tty = "ttyS0";
+		baud-rate-before-config-download = <3000000>;
+		configure-sleep = <1>;
+		configure-audio = <1>;
+		PCMClockMode = <0>;
+		PCMFillMethod = <2>;
+		PCMFillNum = <0>;
+		PCMFillValue = <3>;
+		PCMInCallBitclock = <0>;
+		PCMLSBFirst = <0>;
+		PCMRightJustify = <0>;
+		PCMRouting = <0>;
+		PCMShortFrameSync = <0>;
+		PCMSyncMode = <0>;
+	};
+
-- 
1.9.1

