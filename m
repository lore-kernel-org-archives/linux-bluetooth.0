Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/14] Bluetooth: hci_uart: Use generic Intel support for address setting
Date: Sun,  5 Apr 2015 03:04:48 -0700
Message-Id: <1428228299-28415-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth address setting for Intel devices is provided by a generic
module now. Start using that module instead of relying it being included
in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  1 +
 drivers/bluetooth/hci_intel.c | 17 -----------------
 drivers/bluetooth/hci_ldisc.c |  3 ++-
 drivers/bluetooth/hci_uart.h  |  4 ----
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 95b4626da4fb..ee96d9cb54b4 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -102,6 +102,7 @@ config BT_HCIUART_3WIRE
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
index b265abcb9eb6..dc30473563c6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -44,6 +44,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btintel.h"
 #include "hci_uart.h"
 
 #define VERSION "2.3"
@@ -294,7 +295,7 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	switch (le16_to_cpu(ver->manufacturer)) {
 #ifdef CONFIG_BT_HCIUART_INTEL
 	case 2:
-		hdev->set_bdaddr = intel_set_bdaddr;
+		hdev->set_bdaddr = btintel_set_bdaddr;
 		break;
 #endif
 #ifdef CONFIG_BT_HCIUART_BCM
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 80e694a36143..30ebcd55f886 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -125,10 +125,6 @@ int h5_init(void);
 int h5_deinit(void);
 #endif
 
-#ifdef CONFIG_BT_HCIUART_INTEL
-int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-#endif
-
 #ifdef CONFIG_BT_HCIUART_BCM
 int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #endif
-- 
2.1.0

