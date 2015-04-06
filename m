Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: btusb: Use generic Intel support for address support
Date: Mon,  6 Apr 2015 00:52:12 -0700
Message-Id: <1428306734-14210-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth address handling for Intel devices is provided by a generic
module now. Start using that module instead of relying it being included
in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig |  1 +
 drivers/bluetooth/btusb.c | 79 ++++++-----------------------------------------
 2 files changed, 10 insertions(+), 70 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e4aff8ca7870..b50fe3361659 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -12,6 +12,7 @@ config BT_BCM
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
+	select BT_INTEL
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8dae3daf821d..5798aec44824 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -28,6 +28,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btintel.h"
 #include "btbcm.h"
 
 #define VERSION "0.8"
@@ -1533,51 +1534,6 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 	return 0;
 }
 
-#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
-
-static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	struct hci_rp_read_bd_addr *rp;
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel device address failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*rp)) {
-		BT_ERR("%s Intel device address length mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	rp = (struct hci_rp_read_bd_addr *)skb->data;
-	if (rp->status) {
-		BT_ERR("%s Intel device address result failed (%02x)",
-		       hdev->name, rp->status);
-		kfree_skb(skb);
-		return -bt_to_errno(rp->status);
-	}
-
-	/* For some Intel based controllers, the default Bluetooth device
-	 * address 00:03:19:9E:8B:00 can be found. These controllers are
-	 * fully operational, but have the danger of duplicate addresses
-	 * and that in turn can cause problems with Bluetooth operation.
-	 */
-	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
-		BT_ERR("%s found Intel default device address (%pMR)",
-		       hdev->name, &rp->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1650,7 +1606,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
 			hdev->name, ver->fw_patch_num);
 		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 
@@ -1663,7 +1619,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	fw = btusb_setup_intel_get_fw(hdev, ver);
 	if (!fw) {
 		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 	fw_ptr = fw->data;
@@ -1744,7 +1700,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_disable:
@@ -1760,7 +1716,7 @@ exit_mfg_disable:
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_deactivate:
@@ -1781,7 +1737,7 @@ exit_mfg_deactivate:
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 }
 
@@ -2057,7 +2013,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver->fw_variant == 0x23) {
 		kfree_skb(skb);
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 
@@ -2341,23 +2297,6 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
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
@@ -2808,7 +2747,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
@@ -2817,7 +2756,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
 		hdev->hw_error = btusb_hw_error_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.1.0

