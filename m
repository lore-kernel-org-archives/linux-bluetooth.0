Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use proper data structures for Intel vendor events
Date: Wed,  8 Apr 2015 22:52:28 -0700
Message-Id: <1428558748-527-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel vendors events indicating firmware loading result and the
bootup of the operational firmware are currently hardcoded byte
comparisons. So intead of doing that, provide proper data structures
and actually use them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.h | 15 +++++++++
 drivers/bluetooth/btusb.c   | 79 ++++++++++++++++++++++++++++++---------------
 2 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d1581150679a..4bda6ab34f60 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -54,6 +54,21 @@ struct intel_boot_params {
 	__u8     unlocked_state;
 } __packed;
 
+struct intel_bootup {
+	__u8     zero;
+	__u8     num_cmds;
+	__u8     source;
+	__u8     reset_type;
+	__u8     reset_reason;
+	__u8     ddc_status;
+} __packed;
+
+struct intel_secure_send_result {
+	__u8     result;
+	__le16   opcode;
+	__u8     status;
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c06ceec13dbb..55760bb870e9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1746,6 +1746,38 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static void btusb_intel_bootup(struct btusb_data *data, const void *ptr,
+			       unsigned int len)
+{
+	const struct intel_bootup *evt = ptr;
+
+	if (len != sizeof(*evt))
+		return;
+
+	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
+		smp_mb__after_atomic();
+		wake_up_bit(&data->flags, BTUSB_BOOTING);
+	}
+}
+
+static void btusb_intel_secure_send_result(struct btusb_data *data,
+					   const void *ptr, unsigned int len)
+{
+	const struct intel_secure_send_result *evt = ptr;
+
+	if (len != sizeof(*evt))
+		return;
+
+	if (!evt->result)
+		test_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
+
+	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
+	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
+		smp_mb__after_atomic();
+		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
+	}
+}
+
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -1753,32 +1785,27 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
-		/* When the firmware loading completes the device sends
-		 * out a vendor specific event indicating the result of
-		 * the firmware loading.
-		 */
-		if (skb->len == 7 && hdr->evt == 0xff && hdr->plen == 0x05 &&
-		    skb->data[2] == 0x06) {
-			if (skb->data[3] != 0x00)
-				test_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
-
-			if (test_and_clear_bit(BTUSB_DOWNLOADING,
-					       &data->flags) &&
-			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
-				smp_mb__after_atomic();
-				wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
-			}
-		}
-
-		/* When switching to the operational firmware the device
-		 * sends a vendor specific event indicating that the bootup
-		 * completed.
-		 */
-		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
-		    skb->data[2] == 0x02) {
-			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
-				smp_mb__after_atomic();
-				wake_up_bit(&data->flags, BTUSB_BOOTING);
+		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+		    hdr->plen > 0) {
+			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+
+			switch (skb->data[2]) {
+			case 0x02:
+				/* When switching to the operational firmware
+				 * the device sends a vendor specific event
+				 * indicating that the bootup completed.
+				 */
+				btusb_intel_bootup(data, ptr, len);
+				break;
+			case 0x06:
+				/* When the firmware loading completes the
+				 * device sends out a vendor specific event
+				 * indicating the result of the firmware
+				 * loading.
+				 */
+				btusb_intel_secure_send_result(data, ptr, len);
+				break;
 			}
 		}
 	}
-- 
2.1.0

