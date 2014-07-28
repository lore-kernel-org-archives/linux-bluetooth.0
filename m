Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Disable page scan if all whitelisted devices are connected
Date: Mon, 28 Jul 2014 14:00:36 +0300
Message-Id: <1406545236-1447-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406545236-1447-1-git-send-email-johan.hedberg@gmail.com>
References: <1406545236-1447-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not connectable and all whitelisted (BR/EDR) devices are
connected it doesn't make sense to keep page scan enabled. This patch
adds code to remove entries from the whitelist upon connection complete
and to put them back into it upon disconnection complete. A new flag is
also needed so that we know which devices need to be re-entered into the
whitelist.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8394abc4fd87..48b372a415ce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -551,6 +551,7 @@ enum {
 	HCI_CONN_FIPS,
 	HCI_CONN_STK_ENCRYPT,
 	HCI_CONN_AUTH_INITIATOR,
+	HCI_CONN_WHITELIST,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ba26fbfe481a..493a4bfb45e3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2071,6 +2071,20 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			cp.handle = ev->handle;
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
+
+			if (!hci_bdaddr_list_del(&hdev->whitelist, &ev->bdaddr,
+						 BDADDR_BREDR)) {
+				set_bit(HCI_CONN_WHITELIST, &conn->flags);
+
+				if (list_empty(&hdev->whitelist) &&
+				    !test_bit(HCI_CONNECTABLE,
+					      &hdev->dev_flags)) {
+					u8 scan = SCAN_DISABLED;
+					hci_send_cmd(hdev,
+						     HCI_OP_WRITE_SCAN_ENABLE,
+						     1, &scan);
+				}
+			}
 		}
 
 		/* Set packet type for incoming connection */
@@ -2247,9 +2261,24 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
 				reason, mgmt_connected);
 
-	if (conn->type == ACL_LINK &&
-	    test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
-		hci_remove_link_key(hdev, &conn->dst);
+	if (conn->type == ACL_LINK) {
+		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+			hci_remove_link_key(hdev, &conn->dst);
+
+		if (test_bit(HCI_CONN_WHITELIST, &conn->flags)) {
+			bool was_empty = list_empty(&hdev->whitelist);
+
+			hci_bdaddr_list_add(&hdev->whitelist, &conn->dst,
+					    BDADDR_BREDR);
+
+			if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+			    was_empty && !mgmt_powering_down(hdev)) {
+				u8 scan = SCAN_PAGE;
+				hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1,
+					     &scan);
+			}
+		}
+	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
-- 
1.9.3

