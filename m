Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix race when waiting for BTUSB_DOWNLOADING
Date: Thu, 29 Jan 2015 13:11:55 +0200
Message-Id: <1422529915-31609-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The test for BTUSB_DOWNLOADING must be after adding to the wait queue
and setting the TASK_INTERRUPTIBLE state. Otherwise the flag may get
cleared after we test for it and we end up getting a timeout since
schedule_timeout() waits for the full duration. This patch moves the
condition test after add_wait_queue() & set_current_state() and thereby
eliminates the chance of missing the firmware download completion event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 54 ++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d114786490b1..f91263a83b82 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1940,6 +1940,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	char fwname[64];
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
+	DECLARE_WAITQUEUE(wait, current);
+	signed long timeout;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2169,41 +2171,41 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * booting the loaded firmware, wait for the bootloader notification
 	 * that all fragments have been successfully received.
 	 *
-	 * When the event processing receives the notification, then this
-	 * flag will be cleared. So just in case that happens really quickly,
-	 * check it first before adding the wait queue.
+	 * When the event processing receives the notification, then the
+	 * BTUSB_DOWNLOADING flag will be cleared.
 	 */
-	if (test_bit(BTUSB_DOWNLOADING, &data->flags)) {
-		DECLARE_WAITQUEUE(wait, current);
-		signed long timeout;
+	BT_INFO("%s: Waiting for firmware download to complete", hdev->name);
 
-		BT_INFO("%s: Waiting for firmware download to complete",
-			hdev->name);
+	add_wait_queue(&hdev->req_wait_q, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 
-		add_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
+	if (!test_bit(BTUSB_DOWNLOADING, &data->flags)) {
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_RUNNING);
+		goto complete;
+	}
 
-		/* The firmware loading should not take longer than 5 seconds
-		 * and thus just timeout if that happens and fail the setup
-		 * of this device.
-		 */
-		timeout = schedule_timeout(msecs_to_jiffies(5000));
+	/* The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
+	 */
+	timeout = schedule_timeout(msecs_to_jiffies(5000));
 
-		remove_wait_queue(&hdev->req_wait_q, &wait);
+	remove_wait_queue(&hdev->req_wait_q, &wait);
 
-		if (signal_pending(current)) {
-			BT_ERR("%s: Firmware loading interrupted", hdev->name);
-			err = -EINTR;
-			goto done;
-		}
+	if (signal_pending(current)) {
+		BT_ERR("%s: Firmware loading interrupted", hdev->name);
+		err = -EINTR;
+		goto done;
+	}
 
-		if (!timeout) {
-			BT_ERR("%s: Firmware loading timeout", hdev->name);
-			err = -ETIMEDOUT;
-			goto done;
-		}
+	if (!timeout) {
+		BT_ERR("%s: Firmware loading timeout", hdev->name);
+		err = -ETIMEDOUT;
+		goto done;
 	}
 
+complete:
 	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
 		BT_ERR("%s: Firmware loading failed", hdev->name);
 		err = -ENOEXEC;
-- 
2.1.0

