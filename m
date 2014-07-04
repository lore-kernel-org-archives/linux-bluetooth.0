Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/12] Bluetooth: Simplify use of hci_pend_le_conns_clear()
Date: Fri,  4 Jul 2014 12:37:19 +0300
Message-Id: <1404466647-16352-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that pend_le_connections is a list of hci_conn_params entries we can
simply remove items from that list as we iterate through the global list
of le_conn_params. This also moves the responsibility of calling
hci_update_background_scan() to the functions that were previously
calling hci_pend_le_conns_clear(). The only user that's left for
hci_pend_le_conns_clear() is hci_dev_do_close() which anyway does not
need to call hci_update_background_scan().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 296f44748636..dd8aa5f86810 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3477,8 +3477,6 @@ void hci_pend_le_conns_clear(struct hci_dev *hdev)
 		list_del_init(hdev->pend_le_conns.next);
 
 	BT_DBG("All LE pending connections cleared");
-
-	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -3601,13 +3599,12 @@ void hci_conn_params_clear_enabled(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED)
 			continue;
-		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-			list_del_init(&params->action);
+		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
 	}
 
-	hci_pend_le_conns_clear(hdev);
+	hci_update_background_scan(hdev);
 
 	BT_DBG("All enabled LE connection parameters were removed");
 }
@@ -3618,11 +3615,12 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	struct hci_conn_params *params, *tmp;
 
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
+		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
 	}
 
-	hci_pend_le_conns_clear(hdev);
+	hci_update_background_scan(hdev);
 
 	BT_DBG("All LE connection parameters were removed");
 }
-- 
1.9.3

