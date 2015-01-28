Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Provide hardware error handler for Intel devices
Date: Wed, 28 Jan 2015 11:09:56 -0800
Message-Id: <1422472196-9595-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Bluetooth controllers can provide an additional exception
info string when a hardware error event occurs. The core will now
call hdev->hw_error to let the driver read out this information.

This change will cause a reset of the hardware to bring it back
into functional state and then read the Intel exception info
string and print it along with the error information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 70513b8d4d4a..b2753d79edcf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2266,6 +2266,46 @@ done:
 	return 0;
 }
 
+static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
+{
+	struct sk_buff *skb;
+	u8 type = 0x00;
+
+	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reset after hardware error failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != 13) {
+		BT_ERR("%s: Exception info size mismatch", hdev->name);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (skb->data[0] != 0x00) {
+		BT_ERR("%s: Exception info command failure (%02x)",
+		       hdev->name, skb->data[0]);
+		kfree_skb(skb);
+		return;
+	}
+
+	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
+
+	kfree_skb(skb);
+}
+
 static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	struct sk_buff *skb;
@@ -2649,12 +2689,14 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
+		hdev->hw_error = btusb_hw_error_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
+		hdev->hw_error = btusb_hw_error_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
-- 
2.1.0

