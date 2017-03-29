Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable <stable@vger.kernel.org>,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/2] Bluetooth: hci_intel: add missing tty-device sanity check
Date: Wed, 29 Mar 2017 18:15:28 +0200
Message-Id: <20170329161528.17843-3-johan@kernel.org>
In-Reply-To: <20170329161528.17843-1-johan@kernel.org>
References: <20170329161528.17843-1-johan@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure to check the tty-device pointer before looking up the sibling
platform device to avoid dereferencing a NULL-pointer when the tty is
one end of a Unix98 pty.

Fixes: 74cdad37cd24 ("Bluetooth: hci_intel: Add runtime PM support")
Fixes: 1ab1f239bf17 ("Bluetooth: hci_intel: Add support for platform driver")
Cc: stable <stable@vger.kernel.org>     # 4.3
Cc: Loic Poulain <loic.poulain@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/hci_intel.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 9e271286c5e5..73306384af6c 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -307,6 +307,9 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 	struct list_head *p;
 	int err = -ENODEV;
 
+	if (!hu->tty->dev)
+		return err;
+
 	mutex_lock(&intel_device_list_lock);
 
 	list_for_each(p, &intel_device_list) {
@@ -379,6 +382,9 @@ static void intel_busy_work(struct work_struct *work)
 	struct intel_data *intel = container_of(work, struct intel_data,
 						busy_work);
 
+	if (!intel->hu->tty->dev)
+		return;
+
 	/* Link is busy, delay the suspend */
 	mutex_lock(&intel_device_list_lock);
 	list_for_each(p, &intel_device_list) {
@@ -889,6 +895,8 @@ static int intel_setup(struct hci_uart *hu)
 	list_for_each(p, &intel_device_list) {
 		struct intel_device *dev = list_entry(p, struct intel_device,
 						      list);
+		if (!hu->tty->dev)
+			break;
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
 			if (device_may_wakeup(&dev->pdev->dev)) {
 				set_bit(STATE_LPM_ENABLED, &intel->flags);
@@ -1056,6 +1064,9 @@ static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 	BT_DBG("hu %p skb %p", hu, skb);
 
+	if (!hu->tty->dev)
+		goto out_enqueue;
+
 	/* Be sure our controller is resumed and potential LPM transaction
 	 * completed before enqueuing any packet.
 	 */
@@ -1072,7 +1083,7 @@ static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		}
 	}
 	mutex_unlock(&intel_device_list_lock);
-
+out_enqueue:
 	skb_queue_tail(&intel->txq, skb);
 
 	return 0;
-- 
2.12.2
