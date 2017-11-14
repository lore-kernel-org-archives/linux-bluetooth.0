Return-Path: <valdis.kletnieks@vt.edu>
From: valdis.kletnieks@vt.edu
To: Hans de Goede <hdegoede@redhat.com>, Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: linux-next: Kconfig warning in drivers/bluetooth/Kconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2017 14:36:22 -0500
Message-ID: <59126.1510688182@turing-police.cc.vt.edu>
List-ID: <linux-bluetooth.vger.kernel.org>

commit 86be3c232877b59f08561b256ff7e73ad39b0785
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Mon Nov 13 14:44:16 2017 +0100

    Bluetooth: btusb: Add a Kconfig option to enable USB autosuspend by default

causes a warning message due to a missing double qupte:

drivers/bluetooth/Kconfig:35:warning: multi-line strings not supported

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index eb4101aee787..b44ab176418e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -32,7 +32,7 @@ config BT_HCIBTUSB
 	  kernel or say M to compile it as module (btusb).
 
 config BT_HCIBTUSB_AUTOSUSPEND
-	bool "Enable USB autosuspend for Bluetooth USB devices by default.
+	bool "Enable USB autosuspend for Bluetooth USB devices by default."
 	depends on BT_HCIBTUSB
 	help
 	  Say Y here to enable USB autosuspend for Bluetooth USB devices by
