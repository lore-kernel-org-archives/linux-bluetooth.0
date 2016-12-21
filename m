Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] doc/test-runner: Add Bluetooth config options
Date: Wed, 21 Dec 2016 16:05:47 +0200
Message-Id: <20161221140547.11293-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

List the build options for Bluetooth necessary to run testers.
---
v2: Add missing options for android-tester, note it still fails on A2DP
with error: Unexpected Daemon shutdown with status 11, all other test
seem to work fine though.

 do/ctest-runner.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 72e17ce..fe0a0d4 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -32,6 +32,27 @@ minimal options for a successful boot.
 	CONFIG_DEVTMPFS=y
 	CONFIG_DEBUG_FS=y
 
+For Bluetooth functionality:
+
+	CONFIG_BT=y
+	CONFIG_BT_BREDR=y
+	CONFIG_BT_RFCOMM=y
+	CONFIG_BT_BNEP=y
+	CONFIG_BT_HIDP=y
+	CONFIG_BT_LE=y
+
+	CONFIG_BT_HCIVHCI=y
+
+	CONFIG_CRYPTO_CMAC=y
+	CONFIG_CRYPTO_USER_API=y
+	CONFIG_CRYPTO_USER_API_HASH=y
+	CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+	CONFIG_UNIX=y
+
+	CONFIG_UHID=y
+
+
 These options should be installed as .config in the kernel source directory
 followed by this command.
 
-- 
2.9.3

