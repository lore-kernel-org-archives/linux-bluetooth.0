Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] Bluetooth: Convert pend_le_reports into a list
Date: Fri,  4 Jul 2014 12:37:18 +0300
Message-Id: <1404466647-16352-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To simplify manipulation and lookup of hci_conn_params entries of the
type HCI_AUTO_CONN_REPORT it makes sense to store them in their own
list. The new action list_head in hci_conn_params is used for this
purpose.
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 17 +++++++++++------
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/mgmt.c             |  4 ++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3b1143caa380..9670f4c66ee3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -312,7 +312,7 @@ struct hci_dev {
 	struct list_head	le_white_list;
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
-	unsigned int		pend_le_reports;
+	struct list_head	pend_le_reports;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fed2a0648d3d..296f44748636 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3529,7 +3529,7 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 
 	if (params->auto_connect == HCI_AUTO_CONN_REPORT &&
 	    auto_connect != HCI_AUTO_CONN_REPORT)
-		hdev->pend_le_reports--;
+		list_del_init(&params->action);
 
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
@@ -3537,8 +3537,11 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		hci_pend_le_conn_del(hdev, params);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		if (params->auto_connect != HCI_AUTO_CONN_REPORT)
-			hdev->pend_le_reports++;
+		if (params->auto_connect != HCI_AUTO_CONN_REPORT) {
+			list_del_init(&params->action);
+			list_add(&params->action,
+				 &hdev->pend_le_reports);
+		}
 		hci_pend_le_conn_del(hdev, params);
 		break;
 	case HCI_AUTO_CONN_ALWAYS:
@@ -3565,7 +3568,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 		return;
 
 	if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-		hdev->pend_le_reports--;
+		list_del_init(&params->action);
 
 	hci_pend_le_conn_del(hdev, params);
 
@@ -3599,7 +3602,7 @@ void hci_conn_params_clear_enabled(struct hci_dev *hdev)
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED)
 			continue;
 		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-			hdev->pend_le_reports--;
+			list_del_init(&params->action);
 		list_del(&params->list);
 		kfree(params);
 	}
@@ -3859,6 +3862,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->le_white_list);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->pend_le_conns);
+	INIT_LIST_HEAD(&hdev->pend_le_reports);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -5362,7 +5366,8 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (list_empty(&hdev->pend_le_conns) && !hdev->pend_le_reports) {
+	if (list_empty(&hdev->pend_le_conns) &&
+	    list_empty(&hdev->pend_le_reports)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
 		 * scanning.
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e0407e674061..2a2ef698e851 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4240,7 +4240,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 				return;
 		}
 
-		if (!hdev->pend_le_reports)
+		if (list_empty(&hdev->pend_le_reports))
 			return;
 
 		if (type == LE_ADV_DIRECT_IND)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 474b6dcdf665..a823cccf81f1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5226,7 +5226,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
-			hdev->pend_le_reports--;
+			list_del_init(&params->action);
 
 		hci_pend_le_conn_del(hdev, params);
 		list_del(&params->list);
@@ -6540,7 +6540,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	if (!hci_discovery_active(hdev)) {
 		if (link_type == ACL_LINK)
 			return;
-		if (link_type == LE_LINK && !hdev->pend_le_reports)
+		if (link_type == LE_LINK && list_empty(&hdev->pend_le_reports))
 			return;
 	}
 
-- 
1.9.3

