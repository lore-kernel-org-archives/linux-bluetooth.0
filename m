Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add timer to force power off
Date: Fri, 28 Feb 2014 09:33:44 +0200
Message-Id: <1393572824-663-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If some of the cleanup commands caused by mgmt_set_powered(off) never
complete we should still force the adapter to be powered down. This is
rather easy to do since hdev->power_off is already a delayed work
struct. This patch schedules this delayed work if at least one HCI
command was sent by the cleanup procedure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/mgmt.c        | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c3834d3aecbb..8d1bf8c4689c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -182,6 +182,7 @@ enum {
 #define HCI_CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 73b6ff817796..e7c87231b9ea 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1031,8 +1031,10 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("%s status 0x%02x", hdev->name, status);
 
-	if (hci_conn_count(hdev) == 0)
+	if (hci_conn_count(hdev) == 0) {
+		cancel_delayed_work(&hdev->power_off);
 		queue_work(hdev->req_workqueue, &hdev->power_off.work);
+	}
 }
 
 static int clean_up_hci_state(struct hci_dev *hdev)
@@ -1139,9 +1141,13 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	} else {
 		/* Disconnect connections, stop scans, etc */
 		err = clean_up_hci_state(hdev);
+		if (!err)
+			queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
+					   HCI_POWER_OFF_TIMEOUT);
 
 		/* ENODATA means there were no HCI commands queued */
 		if (err == -ENODATA) {
+			cancel_delayed_work(&hdev->power_off);
 			queue_work(hdev->req_workqueue, &hdev->power_off.work);
 			err = 0;
 		}
@@ -5147,8 +5153,10 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		/* The connection is still in hci_conn_hash so test for 1
 		 * instead of 0 to know if this is the last one.
 		 */
-		if (!cp->val && hci_conn_count(hdev) == 1)
+		if (!cp->val && hci_conn_count(hdev) == 1) {
+			cancel_delayed_work(&hdev->power_off);
 			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+		}
 	}
 
 	if (!mgmt_connected)
@@ -5217,8 +5225,10 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		/* The connection is still in hci_conn_hash so test for 1
 		 * instead of 0 to know if this is the last one.
 		 */
-		if (!cp->val && hci_conn_count(hdev) == 1)
+		if (!cp->val && hci_conn_count(hdev) == 1) {
+			cancel_delayed_work(&hdev->power_off);
 			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+		}
 	}
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-- 
1.8.5.3

