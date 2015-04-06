Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] Bluetooth: hci_uart: Use generic functionality from Broadcom module
Date: Sun,  5 Apr 2015 22:52:12 -0700
Message-Id: <1428299539-8273-3-git-send-email-marcel@holtmann.org>
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
index b593e5f766df..9f68e11c1671 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -111,6 +111,7 @@ config BT_HCIUART_INTEL
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
index b265abcb9eb6..b182ddc43dfe 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -44,6 +44,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btbcm.h"
 #include "hci_uart.h"
 
 #define VERSION "2.3"
@@ -299,7 +300,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
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
index 80e694a36143..ad03f57e794b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -128,7 +128,3 @@ int h5_deinit(void);
 #ifdef CONFIG_BT_HCIUART_INTEL
 int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #endif
-
-#ifdef CONFIG_BT_HCIUART_BCM
-int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-#endif
-- 
2.1.0

