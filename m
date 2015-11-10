Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Remove unnecessary call to hci_update_background_scan
Date: Tue, 10 Nov 2015 09:44:53 +0200
Message-Id: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_conn_params_clear_all() function is only called from
hci_unregister_dev() at which point it's completely futile to try to
do any LE scanning updates. Simply remove this unnecessary function
call. At the same time we can make the function static since it's only
accessed from within the same c-file.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/hci_core.c         | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1878d0a96333..15e6a2bffc2b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1036,7 +1036,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
-void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c270feaac8a1..9421b079de55 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3065,15 +3065,13 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_conn_params_clear_all(struct hci_dev *hdev)
+static void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
 	struct hci_conn_params *params, *tmp;
 
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list)
 		hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
-
 	BT_DBG("All LE connection parameters were removed");
 }
 
-- 
2.5.0

