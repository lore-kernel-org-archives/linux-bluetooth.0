Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: Use hci_conn_params in pend_le_conns
Date: Thu,  3 Jul 2014 19:33:49 +0300
Message-Id: <1404405231-16390-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the connection parameters are always a basis for adding entries to
hdev->pend_le_conns (so far of type bdaddr_list) it's simpler and more
efficient to have the parameters themselves be the entries in the
pend_le_conns list. We do this by adding another list_head to the
hci_conn_params struct.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  9 +++---
 net/bluetooth/hci_core.c         | 68 +++++++++++++---------------------------
 net/bluetooth/hci_event.c        |  7 +++--
 net/bluetooth/mgmt.c             |  4 +--
 4 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5f4405b41c2..09f9fb85d8fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -439,6 +439,7 @@ struct hci_chan {
 
 struct hci_conn_params {
 	struct list_head list;
+	struct list_head pend_le_conn;
 
 	bdaddr_t addr;
 	u8 addr_type;
@@ -867,10 +868,10 @@ void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 
-struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
-					    bdaddr_t *addr, u8 addr_type);
-void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
-void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
+						bdaddr_t *addr, u8 addr_type);
+void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params);
+void hci_pend_le_conn_del(struct hci_dev *hdev, struct hci_conn_params *params);
 void hci_pend_le_conns_clear(struct hci_dev *hdev);
 
 void hci_update_background_scan(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 41cc64429ea1..8882a6cd2876 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3427,73 +3427,46 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
-					    bdaddr_t *addr, u8 addr_type)
+struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
+						bdaddr_t *addr, u8 addr_type)
 {
-	struct bdaddr_list *entry;
+	struct hci_conn_params *param;
 
-	list_for_each_entry(entry, &hdev->pend_le_conns, list) {
-		if (bacmp(&entry->bdaddr, addr) == 0 &&
-		    entry->bdaddr_type == addr_type)
-			return entry;
+	list_for_each_entry(param, &hdev->pend_le_conns, pend_le_conn) {
+		if (bacmp(&param->addr, addr) == 0 &&
+		    param->addr_type == addr_type)
+			return param;
 	}
 
 	return NULL;
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params)
 {
-	struct bdaddr_list *entry;
-
-	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
-	if (entry)
-		goto done;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) {
-		BT_ERR("Out of memory");
-		return;
-	}
+	list_del_init(&params->pend_le_conn);
+	list_add(&params->pend_le_conn, &hdev->pend_le_conns);
 
-	bacpy(&entry->bdaddr, addr);
-	entry->bdaddr_type = addr_type;
-
-	list_add(&entry->list, &hdev->pend_le_conns);
-
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+	BT_DBG("addr %pMR (type %u)", &params->addr, params->addr_type);
 
-done:
 	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+void hci_pend_le_conn_del(struct hci_dev *hdev, struct hci_conn_params *params)
 {
-	struct bdaddr_list *entry;
-
-	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
-	if (!entry)
-		goto done;
-
-	list_del(&entry->list);
-	kfree(entry);
+	list_del_init(&params->pend_le_conn);
 
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+	BT_DBG("addr %pMR (type %u)", &params->addr, params->addr_type);
 
-done:
 	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
 void hci_pend_le_conns_clear(struct hci_dev *hdev)
 {
-	struct bdaddr_list *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &hdev->pend_le_conns, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
+	while (!list_empty(&hdev->pend_le_conns))
+		list_del_init(hdev->pend_le_conns.next);
 
 	BT_DBG("All LE pending connections cleared");
 
@@ -3523,6 +3496,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	params->addr_type = addr_type;
 
 	list_add(&params->list, &hdev->le_conn_params);
+	INIT_LIST_HEAD(&params->pend_le_conn);
 
 	params->conn_min_interval = hdev->le_conn_min_interval;
 	params->conn_max_interval = hdev->le_conn_max_interval;
@@ -3552,16 +3526,16 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
-		hci_pend_le_conn_del(hdev, addr, addr_type);
+		hci_pend_le_conn_del(hdev, params);
 		break;
 	case HCI_AUTO_CONN_REPORT:
 		if (params->auto_connect != HCI_AUTO_CONN_REPORT)
 			hdev->pend_le_reports++;
-		hci_pend_le_conn_del(hdev, addr, addr_type);
+		hci_pend_le_conn_del(hdev, params);
 		break;
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type))
-			hci_pend_le_conn_add(hdev, addr, addr_type);
+			hci_pend_le_conn_add(hdev, params);
 		break;
 	}
 
@@ -3585,7 +3559,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (params->auto_connect == HCI_AUTO_CONN_REPORT)
 		hdev->pend_le_reports--;
 
-	hci_pend_le_conn_del(hdev, addr, addr_type);
+	hci_pend_le_conn_del(hdev, params);
 
 	list_del(&params->list);
 	kfree(params);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 643c5a8d4050..4ebfcedd9ae7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2209,7 +2209,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			/* Fall through */
 
 		case HCI_AUTO_CONN_ALWAYS:
-			hci_pend_le_conn_add(hdev, &conn->dst, conn->dst_type);
+			hci_pend_le_conn_add(hdev, params);
 			break;
 
 		default:
@@ -4036,6 +4036,7 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
 	u8 addr_type;
@@ -4152,7 +4153,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_proto_connect_cfm(conn, ev->status);
 
-	hci_pend_le_conn_del(hdev, &conn->dst, conn->dst_type);
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params)
+		hci_pend_le_conn_del(hdev, params);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 02a4d31fee30..59ca4057955c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5201,7 +5201,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
 			hdev->pend_le_reports--;
 
-		hci_pend_le_conn_del(hdev, &cp->addr.bdaddr, addr_type);
+		hci_pend_le_conn_del(hdev, params);
 		list_del(&params->list);
 		kfree(params);
 
@@ -5514,7 +5514,7 @@ static void restart_le_auto_conns(struct hci_dev *hdev)
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
 		if (p->auto_connect == HCI_AUTO_CONN_ALWAYS) {
-			hci_pend_le_conn_add(hdev, &p->addr, p->addr_type);
+			hci_pend_le_conn_add(hdev, p);
 			added = true;
 		}
 	}
-- 
1.9.3

