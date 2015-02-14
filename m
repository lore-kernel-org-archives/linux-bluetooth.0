Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Remove unneeded btusb_wait_on_bit_timeout()
Date: Sat, 14 Feb 2015 09:33:35 +0200
Message-Id: <1423899215-31128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's now a proper wait_on_bit_timeout() API in linux/wait.h so we can
remove our own copy from btusb.c. Our copy had the task state and
timeout variables swapped so the patch also changes their order.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b87688881143..0e5158eaec6c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -338,16 +338,6 @@ struct btusb_data {
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 };
 
-static int btusb_wait_on_bit_timeout(void *word, int bit, unsigned long timeout,
-				     unsigned mode)
-{
-	might_sleep();
-	if (!test_bit(bit, word))
-		return 0;
-	return out_of_line_wait_on_bit_timeout(word, bit, bit_wait_timeout,
-					       mode, timeout);
-}
-
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -2196,9 +2186,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * and thus just timeout if that happens and fail the setup
 	 * of this device.
 	 */
-	err = btusb_wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
-					msecs_to_jiffies(5000),
-					TASK_INTERRUPTIBLE);
+	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(5000));
 	if (err == 1) {
 		BT_ERR("%s: Firmware loading interrupted", hdev->name);
 		err = -EINTR;
@@ -2249,9 +2239,9 @@ done:
 	 */
 	BT_INFO("%s: Waiting for device to boot", hdev->name);
 
-	err = btusb_wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-					msecs_to_jiffies(1000),
-					TASK_INTERRUPTIBLE);
+	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
 
 	if (err == 1) {
 		BT_ERR("%s: Device boot interrupted", hdev->name);
-- 
2.1.0

