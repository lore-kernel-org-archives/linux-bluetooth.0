Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/test-runner: Add Bluetooth config options
Date: Tue, 20 Dec 2016 16:10:39 +0200
Message-Id: <20161220141039.5981-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

List the build options for Bluetooth necessary to run testers.
---
 doc/test-runner.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 72e17ce..5ed5af9 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -32,6 +32,23 @@ minimal options for a successful boot.
 	CONFIG_DEVTMPFS=y
 	CONFIG_DEBUG_FS=y
 
+For Bluetooth functionality:
+
+	CONFIG_BT=y
+	CONFIG_BT_BREDR=y
+	CONFIG_BT_RFCOMM=y
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
+
 These options should be installed as .config in the kernel source directory
 followed by this command.
 
-- 
2.9.3

