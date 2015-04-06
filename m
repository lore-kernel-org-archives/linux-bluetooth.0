Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: hci_uart: Use generic Intel support for address setting
Date: Mon,  6 Apr 2015 00:52:14 -0700
Message-Id: <1428306734-14210-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth address setting for Intel devices is provided by a generic
module now. Start using that module instead of relying it being included
in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  1 +
 drivers/bluetooth/hci_intel.c | 17 -----------------
 drivers/bluetooth/hci_ldisc.c |  4 +++-
 drivers/bluetooth/hci_uart.h  |  4 ----
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index b50fe3361659..ed5c2738bea2 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -117,6 +117,7 @@ config BT_HCIUART_3WIRE
 config BT_HCIUART_INTEL
 	bool "Intel protocol support"
 	depends on BT_HCIUART
+	select BT_INTEL
 	help
 	  The Intel protocol support enables Bluetooth HCI over serial
 	  port interface for Intel Bluetooth controllers.
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b7bd50a41080..5dd07bf05236 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -29,20 +29,3 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "hci_uart.h"
-
-int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	int err;
-
-	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		BT_ERR("%s: Changing Intel device address failed (%d)",
-		       hdev->name, err);
-		return err;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a106c3e201e3..5c9a73f02664 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -44,6 +44,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btintel.h"
 #include "btbcm.h"
 #include "hci_uart.h"
 
@@ -295,7 +296,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	switch (le16_to_cpu(ver->manufacturer)) {
 #ifdef CONFIG_BT_HCIUART_INTEL
 	case 2:
-		hdev->set_bdaddr = intel_set_bdaddr;
+		hdev->set_bdaddr = btintel_set_bdaddr;
+		btintel_check_bdaddr(hdev);
 		break;
 #endif
 #ifdef CONFIG_BT_HCIUART_BCM
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index d1fa6263f7c2..72120a5ba13c 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -156,10 +156,6 @@ int h5_init(void);
 int h5_deinit(void);
 #endif
 
-#ifdef CONFIG_BT_HCIUART_INTEL
-int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-#endif
-
 #ifdef CONFIG_BT_HCIUART_BCM
 int bcm_init(void);
 int bcm_deinit(void);
-- 
2.1.0

