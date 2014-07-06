Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sending Device Removed when clearing all parameters
Date: Sun,  6 Jul 2014 13:06:51 +0300
Message-Id: <1404641211-17487-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When calling Device Remove with BDADDR_ANY we should in a similar way
emit Device Removed events as we do when removing a single device. Since
we have to iterate the list and call device_removed() the dedicated
hci_conn_params_clear_enabled() is not really useful anymore. This patch
removes the helper function and does the event emission and list item
removal in a single loop.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 18 ------------------
 net/bluetooth/mgmt.c             | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aff285698c85..9d838a072db4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -867,7 +867,6 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
-void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f996e2c4815c..d01bd043c231 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3622,24 +3622,6 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_conn_params_clear_enabled(struct hci_dev *hdev)
-{
-	struct hci_conn_params *params, *tmp;
-
-	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
-		if (params->auto_connect == HCI_AUTO_CONN_DISABLED)
-			continue;
-		list_del(&params->action);
-		list_del(&params->list);
-		kfree(params);
-	}
-
-	hci_update_background_scan(hdev);
-
-	BT_DBG("All enabled LE connection parameters were removed");
-}
-
-/* This function requires the caller holds hdev->lock */
 void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
 	struct hci_conn_params *params, *tmp;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f514eb15e0fb..04a66429ad4d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5284,6 +5284,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
+		struct hci_conn_params *p, *tmp;
+
 		if (cp->addr.type) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
 					   MGMT_STATUS_INVALID_PARAMS,
@@ -5291,7 +5293,18 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		hci_conn_params_clear_enabled(hdev);
+		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
+			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
+				continue;
+			device_removed(sk, hdev, &p->addr, p->addr_type);
+			list_del(&p->action);
+			list_del(&p->list);
+			kfree(p);
+		}
+
+		BT_DBG("All LE connection parameters were removed");
+
+		hci_update_background_scan(hdev);
 	}
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-- 
1.9.3

