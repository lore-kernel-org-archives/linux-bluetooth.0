Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/14] Bluetooth: btusb: Use generic Intel support for address setting
Date: Sun,  5 Apr 2015 03:04:47 -0700
Message-Id: <1428228299-28415-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth address setting for Intel devices is provided by a generic
module now. Start using that module instead of relying it being included
in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig |  1 +
 drivers/bluetooth/btusb.c | 23 ++++-------------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 951a80b2660e..95b4626da4fb 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -8,6 +8,7 @@ config BT_INTEL
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
+	select BT_INTEL
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6e4ff16e487b..8fafd880b148 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -29,6 +29,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btintel.h"
+
 #define VERSION "0.7"
 
 static bool disable_scofix;
@@ -2340,23 +2342,6 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 	kfree_skb(skb);
 }
 
-static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	long ret;
-
-	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: changing Intel device address failed (%ld)",
-		       hdev->name, ret);
-		return ret;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_shutdown_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -3068,7 +3053,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
@@ -3077,7 +3062,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
 		hdev->hw_error = btusb_hw_error_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.1.0

