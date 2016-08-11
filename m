Return-Path: <Bart.VanAssche@sandisk.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH, RFC] Bluetooth: btusb, hci_intel: Fix wait_on_bit_timeout()
 return value checks
Message-ID: <fae0be30-bd77-e5ce-37c6-58591916d28c@sandisk.com>
Date: Thu, 11 Aug 2016 16:02:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

wait_on_bit_timeout() returns one of the following three values:
* 0 to indicate success.
* -EINTR to indicate that a signal has been received;
* -EAGAIN to indicate timeout;
Make the wait_on_bit_timeout() callers check for these values.
This patch has not yet been tested.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
---
 drivers/bluetooth/btusb.c     | 5 ++---
 drivers/bluetooth/hci_intel.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a3be65e..8df720a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2213,9 +2213,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(5000));
-	if (err == 1) {
+	if (err == -EINTR) {
 		BT_ERR("%s: Firmware loading interrupted", hdev->name);
-		err = -EINTR;
 		goto done;
 	}
 
@@ -2267,7 +2266,7 @@ done:
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(1000));
 
-	if (err == 1) {
+	if (err == -EINTR) {
 		BT_ERR("%s: Device boot interrupted", hdev->name);
 		return -EINTR;
 	}
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f6f2b01..533fec3 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -128,7 +128,7 @@ static int intel_wait_booting(struct hci_uart *hu)
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(1000));
 
-	if (err == 1) {
+	if (err == -EINTR) {
 		bt_dev_err(hu->hdev, "Device boot interrupted");
 		return -EINTR;
 	}
@@ -151,7 +151,7 @@ static int intel_wait_lpm_transaction(struct hci_uart *hu)
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(1000));
 
-	if (err == 1) {
+	if (err == -EINTR) {
 		bt_dev_err(hu->hdev, "LPM transaction interrupted");
 		return -EINTR;
 	}
@@ -815,7 +815,7 @@ static int intel_setup(struct hci_uart *hu)
 	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
 				  TASK_INTERRUPTIBLE,
 				  msecs_to_jiffies(5000));
-	if (err == 1) {
+	if (err == -EINTR) {
 		bt_dev_err(hdev, "Firmware loading interrupted");
 		err = -EINTR;
 		goto done;
-- 
2.9.2
