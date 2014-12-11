Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix notifying mgmt power off before flushing connection list
Date: Thu, 11 Dec 2014 21:45:46 +0200
Message-Id: <1418327146-15899-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
References: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves the mgmt_powered() notification earlier in the
hci_dev_do_close() function. This way the correct "not powered" error
gets passed to any pending mgmt commands. Without the patch the pending
commands would instead get a misleading "disconnected" response when
powering down the adapter.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc60465ea774..5dcacf9607e4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2634,6 +2634,12 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	drain_workqueue(hdev->workqueue);
 
 	hci_dev_lock(hdev);
+
+	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+		if (hdev->dev_type == HCI_BREDR)
+			mgmt_powered(hdev, 0);
+	}
+
 	hci_inquiry_cache_flush(hdev);
 	hci_pend_le_actions_clear(hdev);
 	hci_conn_hash_flush(hdev);
@@ -2681,14 +2687,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hdev->flags &= BIT(HCI_RAW);
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
-	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
-		if (hdev->dev_type == HCI_BREDR) {
-			hci_dev_lock(hdev);
-			mgmt_powered(hdev, 0);
-			hci_dev_unlock(hdev);
-		}
-	}
-
 	/* Controller radio is available but is currently powered down */
 	hdev->amp_status = AMP_STATUS_POWERED_DOWN;
 
-- 
2.1.0

