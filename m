Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Use wait_on_bit_timeout() for BTUSB_BOOTING
Date: Fri, 30 Jan 2015 10:58:55 +0200
Message-Id: <1422608335-29090-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com>
References: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The wait_on_bit_timeout() is a simpler and race-free way of waiting for
a bit to be cleared than the current code in btusb.c. This patch updates
the code to use the helper function (its btusb copy - to be later
updated to use a global one).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 808568d2722f..f67bf761144e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1822,8 +1822,10 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		 */
 		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
 		    skb->data[2] == 0x02) {
-			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags))
-				wake_up_interruptible(&hdev->req_wait_q);
+			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
+				smp_mb__after_atomic();
+				wake_up_bit(&data->flags, BTUSB_BOOTING);
+			}
 		}
 	}
 
@@ -2236,33 +2238,25 @@ done:
 
 	/* The bootloader will not indicate when the device is ready. This
 	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
 	 */
-	if (test_bit(BTUSB_BOOTING, &data->flags)) {
-		DECLARE_WAITQUEUE(wait, current);
-		signed long timeout;
-
-		BT_INFO("%s: Waiting for device to boot", hdev->name);
-
-		add_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		/* Booting into operational firmware should not take
-		 * longer than 1 second. However if that happens, then
-		 * just fail the setup since something went wrong.
-		 */
-		timeout = schedule_timeout(msecs_to_jiffies(1000));
+	BT_INFO("%s: Waiting for device to boot", hdev->name);
 
-		remove_wait_queue(&hdev->req_wait_q, &wait);
+	err = btusb_wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+					msecs_to_jiffies(1000),
+					TASK_INTERRUPTIBLE);
 
-		if (signal_pending(current)) {
-			BT_ERR("%s: Device boot interrupted", hdev->name);
-			return -EINTR;
-		}
+	if (err == 1) {
+		BT_ERR("%s: Device boot interrupted", hdev->name);
+		return -EINTR;
+	}
 
-		if (!timeout) {
-			BT_ERR("%s: Device boot timeout", hdev->name);
-			return -ETIMEDOUT;
-		}
+	if (err) {
+		BT_ERR("%s: Device boot timeout", hdev->name);
+		return -ETIMEDOUT;
 	}
 
 	rettime = ktime_get();
-- 
2.1.0

