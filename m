Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Move Intel specific flags into common module
Date: Sun,  5 Apr 2015 05:09:48 -0700
Message-Id: <1428235788-24002-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the Intel specific flags into common module code for all
Intel devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.h |  6 ++++++
 drivers/bluetooth/btusb.c   | 41 ++++++++++++++++++-----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 6c14ef090ab8..698e4270f88e 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -21,6 +21,12 @@
  *
  */
 
+#define BTINTEL_BOOTLOADER	16
+#define BTINTEL_DOWNLOADING	17
+#define BTINTEL_FIRMWARE_LOADED	18
+#define BTINTEL_FIRMWARE_FAILED	19
+#define BTINTEL_BOOTING		20
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 10c525e919da..cdc4e324825f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -298,11 +298,6 @@ static const struct usb_device_id blacklist_table[] = {
 #define BTUSB_ISOC_RUNNING	2
 #define BTUSB_SUSPENDING	3
 #define BTUSB_DID_ISO_RESUME	4
-#define BTUSB_BOOTLOADER	5
-#define BTUSB_DOWNLOADING	6
-#define BTUSB_FIRMWARE_LOADED	7
-#define BTUSB_FIRMWARE_FAILED	8
-#define BTUSB_BOOTING		9
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1740,7 +1735,7 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
 	 */
-	if (test_bit(BTUSB_BOOTLOADER, &data->flags))
+	if (test_bit(BTINTEL_BOOTLOADER, &data->flags))
 		return btusb_recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
@@ -1750,7 +1745,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+	if (test_bit(BTINTEL_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
 		/* When the firmware loading completes the device sends
@@ -1760,13 +1755,13 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		if (skb->len == 7 && hdr->evt == 0xff && hdr->plen == 0x05 &&
 		    skb->data[2] == 0x06) {
 			if (skb->data[3] != 0x00)
-				test_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
+				test_bit(BTINTEL_FIRMWARE_FAILED, &data->flags);
 
-			if (test_and_clear_bit(BTUSB_DOWNLOADING,
+			if (test_and_clear_bit(BTINTEL_DOWNLOADING,
 					       &data->flags) &&
-			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
+			    test_bit(BTINTEL_FIRMWARE_LOADED, &data->flags)) {
 				smp_mb__after_atomic();
-				wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
+				wake_up_bit(&data->flags, BTINTEL_DOWNLOADING);
 			}
 		}
 
@@ -1776,9 +1771,9 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		 */
 		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
 		    skb->data[2] == 0x02) {
-			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
+			if (test_and_clear_bit(BTINTEL_BOOTING, &data->flags)) {
 				smp_mb__after_atomic();
-				wake_up_bit(&data->flags, BTUSB_BOOTING);
+				wake_up_bit(&data->flags, BTINTEL_BOOTING);
 			}
 		}
 	}
@@ -1798,7 +1793,7 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
-		if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+		if (test_bit(BTINTEL_BOOTLOADER, &data->flags)) {
 			struct hci_command_hdr *cmd = (void *)skb->data;
 			__u16 opcode = le16_to_cpu(cmd->opcode);
 
@@ -1979,7 +1974,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	if (ver->fw_variant == 0x23) {
 		kfree_skb(skb);
-		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		clear_bit(BTINTEL_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
 		return 0;
 	}
@@ -2078,7 +2073,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		goto done;
 	}
 
-	set_bit(BTUSB_DOWNLOADING, &data->flags);
+	set_bit(BTINTEL_DOWNLOADING, &data->flags);
 
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
@@ -2131,7 +2126,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		fw_ptr += cmd_len;
 	}
 
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+	set_bit(BTINTEL_FIRMWARE_LOADED, &data->flags);
 
 	BT_INFO("%s: Waiting for firmware download to complete", hdev->name);
 
@@ -2146,7 +2141,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * and thus just timeout if that happens and fail the setup
 	 * of this device.
 	 */
-	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+	err = wait_on_bit_timeout(&data->flags, BTINTEL_DOWNLOADING,
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(5000));
 	if (err == 1) {
@@ -2161,7 +2156,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		goto done;
 	}
 
-	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+	if (test_bit(BTINTEL_FIRMWARE_FAILED, &data->flags)) {
 		BT_ERR("%s: Firmware loading failed", hdev->name);
 		err = -ENOEXEC;
 		goto done;
@@ -2181,7 +2176,7 @@ done:
 
 	calltime = ktime_get();
 
-	set_bit(BTUSB_BOOTING, &data->flags);
+	set_bit(BTINTEL_BOOTING, &data->flags);
 
 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
 			     HCI_INIT_TIMEOUT);
@@ -2199,7 +2194,7 @@ done:
 	 */
 	BT_INFO("%s: Waiting for device to boot", hdev->name);
 
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+	err = wait_on_bit_timeout(&data->flags, BTINTEL_BOOTING,
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(1000));
 
@@ -2219,7 +2214,7 @@ done:
 
 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
 
-	clear_bit(BTUSB_BOOTLOADER, &data->flags);
+	clear_bit(BTINTEL_BOOTLOADER, &data->flags);
 
 	return 0;
 }
@@ -2630,7 +2625,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
-		set_bit(BTUSB_BOOTLOADER, &data->flags);
+		set_bit(BTINTEL_BOOTLOADER, &data->flags);
 	} else {
 		data->recv_event = hci_recv_frame;
 		data->recv_bulk = btusb_recv_bulk;
-- 
2.1.0

