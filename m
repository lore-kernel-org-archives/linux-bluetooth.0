Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] Bluetooth: Simplify hci_conn_params->action list usage
Date: Fri,  4 Jul 2014 12:37:21 +0300
Message-Id: <1404466647-16352-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since params->action is used for both the pend_le_conns and
pend_le_reports lists we can simplify the adding and deleting of the
lists considerably. For example, when deleting entries in most
situations we no-longer need to check the auto_connect value but can
directly proceed with calling list_del_init on param->action (which is
safe even if the entry is not part of any list).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  | 28 +++++++++++-----------------
 net/bluetooth/hci_event.c |  6 ++++--
 net/bluetooth/mgmt.c      |  6 ++----
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0601fcbd21eb..3b0da6eeb449 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3528,26 +3528,22 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (params->auto_connect == auto_connect)
 		return 0;
 
-	if (params->auto_connect == HCI_AUTO_CONN_REPORT &&
-	    auto_connect != HCI_AUTO_CONN_REPORT)
-		list_del_init(&params->action);
+	list_del_init(&params->action);
 
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
-		hci_pend_le_conn_del(hdev, params);
+		hci_update_background_scan(hdev);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		if (params->auto_connect != HCI_AUTO_CONN_REPORT) {
-			list_del_init(&params->action);
-			list_add(&params->action,
-				 &hdev->pend_le_reports);
-		}
-		hci_pend_le_conn_del(hdev, params);
+		list_add(&params->action, &hdev->pend_le_reports);
+		hci_update_background_scan(hdev);
 		break;
 	case HCI_AUTO_CONN_ALWAYS:
-		if (!is_connected(hdev, addr, addr_type))
-			hci_pend_le_conn_add(hdev, params);
+		if (!is_connected(hdev, addr, addr_type)) {
+			list_add(&params->action, &hdev->pend_le_conns);
+			hci_update_background_scan(hdev);
+		}
 		break;
 	}
 
@@ -3568,14 +3564,12 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!params)
 		return;
 
-	if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-		list_del_init(&params->action);
-
-	hci_pend_le_conn_del(hdev, params);
-
+	list_del(&params->action);
 	list_del(&params->list);
 	kfree(params);
 
+	hci_update_background_scan(hdev);
+
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2a2ef698e851..0ccdf9df2188 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4154,8 +4154,10 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_proto_connect_cfm(conn, ev->status);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params)
-		hci_pend_le_conn_del(hdev, params);
+	if (params) {
+		list_del_init(&params->action);
+		hci_update_background_scan(hdev);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a823cccf81f1..77c64b8cb7e2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5225,12 +5225,10 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-			list_del_init(&params->action);
-
-		hci_pend_le_conn_del(hdev, params);
+		list_del_init(&params->action);
 		list_del(&params->list);
 		kfree(params);
+		hci_update_background_scan(hdev);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
-- 
1.9.3

