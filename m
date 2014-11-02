Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce BT_BREDR and BT_LE config options
Date: Sun,  2 Nov 2014 03:32:25 +0100
Message-Id: <1414895545-108621-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current kernel options do not make it clear which modules are for
Bluetooth Classic (BR/EDR) and which are for Bluetooth Low Energy (LE).

To make it really clear, introduce BT_BREDR and BT_LE options with
proper dependencies into the different modules. Both new options
default to y to not create a regression with previous kernel config
files.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Kconfig        | 20 +++++++++++++++-----
 net/bluetooth/bnep/Kconfig   |  2 +-
 net/bluetooth/cmtp/Kconfig   |  2 +-
 net/bluetooth/hidp/Kconfig   |  2 +-
 net/bluetooth/rfcomm/Kconfig |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 600fb29288f4..5e97a8ff850b 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -39,11 +39,10 @@ menuconfig BT
 	  to Bluetooth kernel modules are provided in the BlueZ packages.  For
 	  more information, see <http://www.bluez.org/>.
 
-config BT_6LOWPAN
-	tristate "Bluetooth 6LoWPAN support"
-	depends on BT && 6LOWPAN
-	help
-	  IPv6 compression over Bluetooth Low Energy.
+config BT_BREDR
+	bool "Bluetooth Classic (BR/EDR) features"
+	depends on BT
+	default y
 
 source "net/bluetooth/rfcomm/Kconfig"
 
@@ -53,4 +52,15 @@ source "net/bluetooth/cmtp/Kconfig"
 
 source "net/bluetooth/hidp/Kconfig"
 
+config BT_LE
+	bool "Bluetooth Low Energy (LE) features"
+	depends on BT
+	default y
+
+config BT_6LOWPAN
+	tristate "Bluetooth 6LoWPAN support"
+	depends on BT_LE && 6LOWPAN
+	help
+	  IPv6 compression over Bluetooth Low Energy.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/bnep/Kconfig b/net/bluetooth/bnep/Kconfig
index 71791fc9f6b1..9b70317c49dc 100644
--- a/net/bluetooth/bnep/Kconfig
+++ b/net/bluetooth/bnep/Kconfig
@@ -1,6 +1,6 @@
 config BT_BNEP
 	tristate "BNEP protocol support"
-	depends on BT
+	depends on BT_BREDR
 	select CRC32
 	help
 	  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
diff --git a/net/bluetooth/cmtp/Kconfig b/net/bluetooth/cmtp/Kconfig
index 94cbf42ce155..939da0fbdd88 100644
--- a/net/bluetooth/cmtp/Kconfig
+++ b/net/bluetooth/cmtp/Kconfig
@@ -1,6 +1,6 @@
 config BT_CMTP
 	tristate "CMTP protocol support"
-	depends on BT && ISDN_CAPI
+	depends on BT_BREDR && ISDN_CAPI
 	help
 	  CMTP (CAPI Message Transport Protocol) is a transport layer
 	  for CAPI messages.  CMTP is required for the Bluetooth Common
diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
index 9332bc7aa851..bc8610b24077 100644
--- a/net/bluetooth/hidp/Kconfig
+++ b/net/bluetooth/hidp/Kconfig
@@ -1,6 +1,6 @@
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT && INPUT
+	depends on BT_BREDR && INPUT
 	select HID
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
diff --git a/net/bluetooth/rfcomm/Kconfig b/net/bluetooth/rfcomm/Kconfig
index 18d352ea2bc7..335df7515220 100644
--- a/net/bluetooth/rfcomm/Kconfig
+++ b/net/bluetooth/rfcomm/Kconfig
@@ -1,6 +1,6 @@
 config BT_RFCOMM
 	tristate "RFCOMM protocol support"
-	depends on BT
+	depends on BT_BREDR
 	help
 	  RFCOMM provides connection oriented stream transport.  RFCOMM
 	  support is required for Dialup Networking, OBEX and other Bluetooth
-- 
1.9.3

