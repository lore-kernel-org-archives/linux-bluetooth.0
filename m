Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/14] Bluetooth: btusb: Use generic functionality by Broadcom module
Date: Sun,  5 Apr 2015 03:04:54 -0700
Message-Id: <1428228299-28415-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new Broadcom Bluetooth support module provides generic functionality
for changing and checking the Bluetooth device address. Use these new
features instead of keeping a duplicate in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig |  1 +
 drivers/bluetooth/btusb.c | 61 +++--------------------------------------------
 2 files changed, 4 insertions(+), 58 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 8fa7fa38ea48..70026883a71b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -12,6 +12,7 @@ config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
 	select BT_INTEL
+	select BT_BCM
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 664bcb0745b0..543992bc0ef2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "btintel.h"
+#include "btbcm.h"
 
 #define VERSION "0.7"
 
@@ -2325,8 +2326,6 @@ static const struct {
 	{ }
 };
 
-#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
-
 static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2341,7 +2340,6 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
-	struct hci_rp_read_bd_addr *bda;
 	long ret;
 	int i;
 
@@ -2479,43 +2477,7 @@ reset_fw:
 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
-	/* Read BD Address */
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_READ_BD_ADDR failed (%ld)",
-		       hdev->name, ret);
-		goto done;
-	}
-
-	if (skb->len != sizeof(*bda)) {
-		BT_ERR("%s: HCI_OP_READ_BD_ADDR event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		ret = -EIO;
-		goto done;
-	}
-
-	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
-		BT_ERR("%s: HCI_OP_READ_BD_ADDR error status (%02x)",
-		       hdev->name, bda->status);
-		kfree_skb(skb);
-		ret = -bt_to_errno(bda->status);
-		goto done;
-	}
-
-	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
-	 * with no configured address.
-	 */
-	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
-		BT_INFO("%s: BCM: using default device address (%pMR)",
-			hdev->name, &bda->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	kfree_skb(skb);
+	btbcm_check_bdaddr(hdev);
 
 done:
 	release_firmware(fw);
@@ -2523,23 +2485,6 @@ done:
 	return ret;
 }
 
-static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	long ret;
-
-	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Change address command failed (%ld)",
-		       hdev->name, ret);
-		return ret;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_setup_bcm_apple(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2963,7 +2908,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
 		hdev->setup = btusb_setup_bcm_patchram;
-		hdev->set_bdaddr = btusb_set_bdaddr_bcm;
+		hdev->set_bdaddr = btbcm_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.1.0

