Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for default address of Broadcom BCM20702A0 controllers
Date: Wed,  2 Jul 2014 12:38:22 +0200
Message-Id: <1404297502-26014-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom BCM20702A0 USB controllers might come with the default
address 00:20:70:02:A0:00 when booting up. If this happens, then warn
about such address being used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 32aabea731f2..3244e311ca29 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1448,6 +1448,8 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+
 static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -1461,6 +1463,7 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	u16 opcode;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
+	struct hci_rp_read_bd_addr *bda;
 	long ret;
 
 	snprintf(fw_name, sizeof(fw_name), "brcm/%s-%04x-%04x.hcd",
@@ -1470,8 +1473,7 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 
 	ret = request_firmware(&fw, fw_name, &hdev->dev);
 	if (ret < 0) {
-		BT_INFO("%s: BCM: patch %s not found", hdev->name,
-			fw_name);
+		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
 		return 0;
 	}
 
@@ -1590,6 +1592,42 @@ reset_fw:
 		ver->lmp_ver, ver->lmp_subver);
 	kfree_skb(skb);
 
+	/* Read BD Address */
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: HCI_OP_READ_BD_ADDR failed (%ld)",
+			hdev->name, ret);
+		goto done;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		BT_ERR("%s: HCI_OP_READ_BD_ADDR event length mismatch",
+			hdev->name);
+		kfree_skb(skb);
+		ret = -EIO;
+		goto done;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *) skb->data;
+	if (bda->status) {
+		BT_ERR("%s: HCI_OP_READ_BD_ADDR error status (%02x)",
+		       hdev->name, bda->status);
+		kfree_skb(skb);
+		ret = -bt_to_errno(bda->status);
+		goto done;
+	}
+
+	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
+	 * with no configured address.
+	 */
+	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0))
+		BT_INFO("%s: BCM: using default device address (%pMR)",
+			hdev->name, &bda->bdaddr);
+
+	kfree_skb(skb);
+
 done:
 	release_firmware(fw);
 
-- 
1.9.3

