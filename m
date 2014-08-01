Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Disable page scan if all whitelisted devices are connected
Date: Fri,  1 Aug 2014 11:13:32 +0300
Message-Id: <1406880812-19731-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
References: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not connectable and all whitelisted (BR/EDR) devices are
connected it doesn't make sense to keep page scan enabled. This patch
adds code to check for any disconnected whitelist devices and if there
are none take the appropriate action in the hci_update_page_scan()
function to disable page scan.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  | 20 +++++++++++++++++++-
 net/bluetooth/hci_event.c | 11 ++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3f42c80070e..de98da0bdcc3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5687,6 +5687,24 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		BT_ERR("Failed to run HCI request: err %d", err);
 }
 
+static bool disconnected_whitelist_entries(struct hci_dev *hdev)
+{
+	struct bdaddr_list *b;
+
+	list_for_each_entry(b, &hdev->whitelist, list) {
+		struct hci_conn *conn;
+
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
+		if (!conn)
+			return true;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			return true;
+	}
+
+	return false;
+}
+
 void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req)
 {
 	u8 scan;
@@ -5701,7 +5719,7 @@ void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req)
 		return;
 
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
-	    !list_empty(&hdev->whitelist))
+	    disconnected_whitelist_entries(hdev))
 		scan = SCAN_PAGE;
 	else
 		scan = SCAN_DISABLED;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index be35598984d9..da7ab6b9bb69 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2071,6 +2071,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			cp.handle = ev->handle;
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
+
+			hci_update_page_scan(hdev, NULL);
 		}
 
 		/* Set packet type for incoming connection */
@@ -2247,9 +2249,12 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
 				reason, mgmt_connected);
 
-	if (conn->type == ACL_LINK &&
-	    test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
-		hci_remove_link_key(hdev, &conn->dst);
+	if (conn->type == ACL_LINK) {
+		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+			hci_remove_link_key(hdev, &conn->dst);
+
+		hci_update_page_scan(hdev, NULL);
+	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
-- 
1.9.3

