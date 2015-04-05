Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/14] Bluetooth: hci_uart: Use generic functionality by Broadcom module
Date: Sun,  5 Apr 2015 03:04:55 -0700
Message-Id: <1428228299-28415-10-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new Broadcom Bluetooth support module provides generic functionality
for changing and checking the Bluetooth device address. Use these new
features instead of keeping a duplicate in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  1 +
 drivers/bluetooth/hci_bcm.c   | 17 -----------------
 drivers/bluetooth/hci_ldisc.c |  4 +++-
 drivers/bluetooth/hci_uart.h  |  4 ----
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 70026883a71b..2f4a52c018cf 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -116,6 +116,7 @@ config BT_HCIUART_INTEL
 config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
+	select BT_BCM
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
 	  port interface for Broadcom Bluetooth controllers.
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a5817bda7c6..dd338fa77433 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -29,20 +29,3 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "hci_uart.h"
-
-int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	int err;
-
-	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Change address command failed (%d)",
-		       hdev->name, err);
-		return err;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dc6391a98182..58faa642b2c5 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -45,6 +45,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "btintel.h"
+#include "btbcm.h"
 #include "hci_uart.h"
 
 #define VERSION "2.3"
@@ -301,7 +302,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
 #endif
 #ifdef CONFIG_BT_HCIUART_BCM
 	case 15:
-		hdev->set_bdaddr = bcm_set_bdaddr;
+		hdev->set_bdaddr = btbcm_set_bdaddr;
+		btbcm_check_bdaddr(hdev);
 		break;
 #endif
 	}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 30ebcd55f886..0b58a33eb5b2 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -124,7 +124,3 @@ int ath_deinit(void);
 int h5_init(void);
 int h5_deinit(void);
 #endif
-
-#ifdef CONFIG_BT_HCIUART_BCM
-int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-#endif
-- 
2.1.0

