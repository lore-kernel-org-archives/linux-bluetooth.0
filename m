Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add public address configration for Intel USB devices
Date: Wed,  2 Jul 2014 11:25:25 +0200
Message-Id: <1404293125-14202-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the Intel based USB devices add support for configuration of
the public device address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e0e39cc1af31..66966b9c4244 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1382,6 +1382,23 @@ exit_mfg_deactivate:
 	return 0;
 }
 
+static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	long ret;
+
+	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: changing Intel device address failed (%ld)",
+			hdev->name, ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -1657,8 +1674,10 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_bcm;
 	}
 
-	if (id->driver_info & BTUSB_INTEL)
+	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
+		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+	}
 
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
-- 
1.9.3

