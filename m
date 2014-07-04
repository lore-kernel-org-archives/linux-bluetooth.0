Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/12] Bluetooth: Convert pend_le_conn list to a generic action list
Date: Fri,  4 Jul 2014 12:37:17 +0300
Message-Id: <1404466647-16352-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In preparation to store also HCI_AUTO_CONN_REPORT entries in a list it
makes sense to convert the existing pend_le_conn list head of
hci_conn_params into a more generically named "action". This makes sense
because a parameter entry will never participate in more than one action
list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 09f9fb85d8fd..3b1143caa380 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -439,7 +439,7 @@ struct hci_chan {
 
 struct hci_conn_params {
 	struct list_head list;
-	struct list_head pend_le_conn;
+	struct list_head action;
 
 	bdaddr_t addr;
 	u8 addr_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 750f969df8db..fed2a0648d3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3440,7 +3440,7 @@ struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 	if (!hci_is_identity_address(addr, addr_type))
 		return NULL;
 
-	list_for_each_entry(param, &hdev->pend_le_conns, pend_le_conn) {
+	list_for_each_entry(param, &hdev->pend_le_conns, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
 			return param;
@@ -3452,8 +3452,8 @@ struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 /* This function requires the caller holds hdev->lock */
 void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params)
 {
-	list_del_init(&params->pend_le_conn);
-	list_add(&params->pend_le_conn, &hdev->pend_le_conns);
+	list_del_init(&params->action);
+	list_add(&params->action, &hdev->pend_le_conns);
 
 	BT_DBG("addr %pMR (type %u)", &params->addr, params->addr_type);
 
@@ -3463,7 +3463,7 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params)
 /* This function requires the caller holds hdev->lock */
 void hci_pend_le_conn_del(struct hci_dev *hdev, struct hci_conn_params *params)
 {
-	list_del_init(&params->pend_le_conn);
+	list_del_init(&params->action);
 
 	BT_DBG("addr %pMR (type %u)", &params->addr, params->addr_type);
 
@@ -3504,7 +3504,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	params->addr_type = addr_type;
 
 	list_add(&params->list, &hdev->le_conn_params);
-	INIT_LIST_HEAD(&params->pend_le_conn);
+	INIT_LIST_HEAD(&params->action);
 
 	params->conn_min_interval = hdev->le_conn_min_interval;
 	params->conn_max_interval = hdev->le_conn_max_interval;
-- 
1.9.3

