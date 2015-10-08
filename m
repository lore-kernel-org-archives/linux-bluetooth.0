Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bpa10x: Add support for set_diag driver callback
Date: Thu,  8 Oct 2015 03:01:44 +0200
Message-Id: <1444266104-76648-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BPA-10x devices support tracing operation. Use the set_diag driver
callback to allow enabling and disabling that functionality.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bpa10x.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 618b1ef20145..a1a0f80212b3 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -438,6 +438,25 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int bpa10x_set_diag(struct hci_dev *hdev, bool enable)
+{
+	const u8 req[] = { 0x00, enable };
+	struct sk_buff *skb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	/* Enable sniffer operation */
+	skb = __hci_cmd_sync(hdev, 0xfc0e, sizeof(req), req, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
 static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct bpa10x_data *data;
@@ -474,6 +493,7 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	hdev->flush    = bpa10x_flush;
 	hdev->setup    = bpa10x_setup;
 	hdev->send     = bpa10x_send_frame;
+	hdev->set_diag = bpa10x_set_diag;
 
 	set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-- 
2.4.3

