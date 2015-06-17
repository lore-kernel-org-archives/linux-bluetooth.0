Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v3 1/5] Broadcom Bluetooth UART Device Tree bindings
Date: Wed, 17 Jun 2015 11:42:43 -0400
Message-ID: <1434555767-18234-2-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Device Tree bindings to configure the Broadcom Bluetooth UART device.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt

diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
new file mode 100644
index 0000000..c2cf93a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
@@ -0,0 +1,82 @@
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
+  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/off.
+
+  - oper-speed : Bluetooth device operational baud rate.
+    Default: 3000000.
+
+  - manual-fc : flow control UART in suspend / resume scenarios.
+    Default: 0.
+
+  - configure-sleep : configure suspend / resume flag.
+    Default: false.
+
+  - configure-audio : configure platform PCM SCO flag.
+    Default: false.
+
+  - pcm-clockmode : PCM clock mode. 0-slave, 1-master.
+    Default: 0.
+
+  - pcm-fillmethod : PCM fill method. 0 to 3.
+    Default: 2.
+
+  - pcm-fillnum : PCM number of fill bits. 0 to 3.
+    Default: 0.
+
+  - pcm-fillvalue : PCM fill value. 0 to 7.
+    Default: 3.
+
+  - pcm-incallbitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512Kbps,
+    3-1024Kbps, 4-2048Kbps.
+    Default: 0.
+
+  - pcm-lsbfirst : PCM LSB first. 0 or 1.
+    Default: 0.
+
+  - pcm-rightjustify : PCM Justify. 0-left, 1-right.
+    Default: 0.
+
+  - pcm-routing : PCM routing. 0-PCM, 1-SCO over HCI.
+    Default: 0.
+
+  - pcm-shortframesync : PCM sync. 0-short, 1-long.
+    Default: 0.
+
+  - pcm-syncmode : PCM sync mode. 0-slave, 1-master.
+    Default: 0.
+
+
+Example:
+
+	bcm4354_bt_uart: bcm4354-bt-uart {
+		compatible = "brcm,brcm-bt-uart";
+		bt-wake-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		bt-host-wake-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+		tty = "ttyS0";
+		oper-speed = <3000000>;
+		configure-sleep;
+		configure-audio;
+		pcm-clockmode = <0>;
+		pcm-fillmethod = <2>;
+		pcm-fillnum = <0>;
+		pcm-fillvalue = <3>;
+		pcm-incallbitclock = <0>;
+		pcm-lsbfirst = <0>;
+		pcm-rightjustify = <0>;
+		pcm-routing = <0>;
+		pcm-shortframesync = <0>;
+		pcm-syncmode = <0>;
+	};
+
-- 
1.9.1
