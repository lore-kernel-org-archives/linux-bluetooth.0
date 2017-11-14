Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix BT_HCIBTUSB_AUTOSUSPEND Kconfig option name
Date: Tue, 14 Nov 2017 10:15:23 +0100
Message-Id: <20171114091523.12284-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fix: drivers/bluetooth/Kconfig:35:warning: multi-line strings not
supported warning.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 20940417d937..ecd687c4776e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -31,7 +31,7 @@ config BT_HCIBTUSB
 	  kernel or say M to compile it as module (btusb).
 
 config BT_HCIBTUSB_AUTOSUSPEND
-	bool "Enable USB autosuspend for Bluetooth USB devices by default.
+	bool "Enable USB autosuspend for Bluetooth USB devices by default"
 	depends on BT_HCIBTUSB
 	help
 	  Say Y here to enable USB autosuspend for Bluetooth USB devices by
-- 
2.14.3
