Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bpa10x: Read revision information in setup stage
Date: Thu,  8 Oct 2015 02:11:00 +0200
Message-Id: <1444263060-71864-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging pruposes, read the revision string of the BPA-10x devices
and print it. For example one of the latest devices respond with the
string SNIF_102,BB930,02/01/18,10:37:56.

  < HCI Command: Vendor (0x3f|0x000e) plen 1
          07                                               .
  > HCI Event: Command Complete (0x0e) plen 49
        Vendor (0x3f|0x000e) ncmd 1
          Status: Success (0x00)
          53 4e 49 46 5f 31 30 32 2c 42 42 39 33 30 2c 30  SNIF_102,BB930,0
          32 2f 30 31 2f 31 38 2c 31 30 3a 33 37 3a 35 36  2/01/18,10:37:56
          00 00 00 00 00 00 00 00 00 00 00 00 00           .............

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bpa10x.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 88e004ee137e..7df870c4ca8f 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -342,6 +342,24 @@ static int bpa10x_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+static int bpa10x_setup(struct hci_dev *hdev)
+{
+	const u8 req[] = { 0x07 };
+	struct sk_buff *skb;
+
+	BT_DBG("%s", hdev->name);
+
+	/* Read revision string */
+	skb = __hci_cmd_sync(hdev, 0xfc0e, sizeof(req), req, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
+
+	kfree_skb(skb);
+	return 0;
+}
+
 static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct bpa10x_data *data = hci_get_drvdata(hdev);
@@ -451,10 +469,11 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
-	hdev->open     = bpa10x_open;
-	hdev->close    = bpa10x_close;
-	hdev->flush    = bpa10x_flush;
-	hdev->send     = bpa10x_send_frame;
+	hdev->open  = bpa10x_open;
+	hdev->close = bpa10x_close;
+	hdev->flush = bpa10x_flush;
+	hdev->setup = bpa10x_setup;
+	hdev->send  = bpa10x_send_frame;
 
 	set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-- 
2.4.3

