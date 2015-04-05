Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/14] Bluetooth: btusb: Use generic Intel support for address verification
Date: Sun,  5 Apr 2015 03:04:50 -0700
Message-Id: <1428228299-28415-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth address verification for Intel devices is supported by
the generic module now. Start using that function instead of relying
it being included in the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 57 +++++------------------------------------------
 1 file changed, 6 insertions(+), 51 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8fafd880b148..ab2d587e97a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1534,51 +1534,6 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
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
@@ -1651,7 +1606,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
 			hdev->name, ver->fw_patch_num);
 		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 
@@ -1664,7 +1619,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	fw = btusb_setup_intel_get_fw(hdev, ver);
 	if (!fw) {
 		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 	fw_ptr = fw->data;
@@ -1745,7 +1700,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_disable:
@@ -1761,7 +1716,7 @@ exit_mfg_disable:
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_deactivate:
@@ -1782,7 +1737,7 @@ exit_mfg_deactivate:
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btintel_check_bdaddr(hdev);
 	return 0;
 }
 
@@ -2058,7 +2013,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver->fw_variant == 0x23) {
 		kfree_skb(skb);
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btusb_check_bdaddr_intel(hdev);
+		btintel_check_bdaddr(hdev);
 		return 0;
 	}
 
-- 
2.1.0

