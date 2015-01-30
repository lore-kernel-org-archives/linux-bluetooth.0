Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Fix race when waiting for BTUSB_DOWNLOADING
Date: Fri, 30 Jan 2015 10:58:54 +0200
Message-Id: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The test for BTUSB_DOWNLOADING must be after adding to the wait queue
and setting the TASK_INTERRUPTIBLE state. Otherwise the flag may get
cleared after we test for it and we end up getting a timeout since
schedule_timeout() waits for the full duration. This patch uses a
wait_on_bit_timeout() + wake_up_bit(). To perform the task both
race-free as well as in a much simpler way.

Since there's no global wait_on_bit_timeout() helper yet (even though
all the building blocks for it are in place) this patch creates a
temporary local btusb copy of it until the global one has made it to
upstream trees.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 67 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3aa4b3c776b2..808568d2722f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -334,6 +334,16 @@ struct btusb_data {
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 };
 
+static int btusb_wait_on_bit_timeout(void *word, int bit, unsigned long timeout,
+				     unsigned mode)
+{
+	might_sleep();
+	if (!test_bit(bit, word))
+		return 0;
+	return out_of_line_wait_on_bit_timeout(word, bit, bit_wait_timeout,
+					       mode, timeout);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -1800,8 +1810,10 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 			if (test_and_clear_bit(BTUSB_DOWNLOADING,
 					       &data->flags) &&
-			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
-				wake_up_interruptible(&hdev->req_wait_q);
+			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
+				smp_mb__after_atomic();
+				wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
+			}
 		}
 
 		/* When switching to the operational firmware the device
@@ -2165,43 +2177,32 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 
+	BT_INFO("%s: Waiting for firmware download to complete", hdev->name);
+
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
 	 * that all fragments have been successfully received.
 	 *
-	 * When the event processing receives the notification, then this
-	 * flag will be cleared. So just in case that happens really quickly,
-	 * check it first before adding the wait queue.
+	 * When the event processing receives the notification, then the
+	 * BTUSB_DOWNLOADING flag will be cleared.
+	 *
+	 * The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
 	 */
-	if (test_bit(BTUSB_DOWNLOADING, &data->flags)) {
-		DECLARE_WAITQUEUE(wait, current);
-		signed long timeout;
-
-		BT_INFO("%s: Waiting for firmware download to complete",
-			hdev->name);
-
-		add_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		/* The firmware loading should not take longer than 5 seconds
-		 * and thus just timeout if that happens and fail the setup
-		 * of this device.
-		 */
-		timeout = schedule_timeout(msecs_to_jiffies(5000));
-
-		remove_wait_queue(&hdev->req_wait_q, &wait);
-
-		if (signal_pending(current)) {
-			BT_ERR("%s: Firmware loading interrupted", hdev->name);
-			err = -EINTR;
-			goto done;
-		}
+	err = btusb_wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+					msecs_to_jiffies(5000),
+					TASK_INTERRUPTIBLE);
+	if (err == 1) {
+		BT_ERR("%s: Firmware loading interrupted", hdev->name);
+		err = -EINTR;
+		goto done;
+	}
 
-		if (!timeout) {
-			BT_ERR("%s: Firmware loading timeout", hdev->name);
-			err = -ETIMEDOUT;
-			goto done;
-		}
+	if (err) {
+		BT_ERR("%s: Firmware loading timeout", hdev->name);
+		err = -ETIMEDOUT;
+		goto done;
 	}
 
 	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
-- 
2.1.0

