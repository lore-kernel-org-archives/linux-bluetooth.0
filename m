Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Fix using hci_conn_get() for hci_conn pointers
Date: Fri, 15 Aug 2014 21:06:58 +0300
Message-Id: <1408126019-29761-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
References: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Wherever we keep hci_conn pointers around we should be using
hci_conn_get/put to ensure that they stay valid. This patch fixes
all places violating against the principle currently.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  |  1 +
 net/bluetooth/hci_core.c  |  9 +++++++--
 net/bluetooth/hci_event.c |  3 ++-
 net/bluetooth/mgmt.c      | 10 +++++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index faff6247ac8f..4ecc9d5fce7a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -595,6 +595,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 					   conn->dst_type);
 	if (params && params->conn) {
 		hci_conn_drop(params->conn);
+		hci_conn_put(params->conn);
 		params->conn = NULL;
 	}
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9b7145959a49..ed60d37ea646 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2541,6 +2541,7 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
 		if (p->conn) {
 			hci_conn_drop(p->conn);
+			hci_conn_put(p->conn);
 			p->conn = NULL;
 		}
 		list_del_init(&p->action);
@@ -3734,8 +3735,10 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!params)
 		return;
 
-	if (params->conn)
+	if (params->conn) {
 		hci_conn_drop(params->conn);
+		hci_conn_put(params->conn);
+	}
 
 	list_del(&params->action);
 	list_del(&params->list);
@@ -3767,8 +3770,10 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	struct hci_conn_params *params, *tmp;
 
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
-		if (params->conn)
+		if (params->conn) {
 			hci_conn_drop(params->conn);
+			hci_conn_put(params->conn);
+		}
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d2ee162ecddb..e6a496ae0318 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4231,6 +4231,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		list_del_init(&params->action);
 		if (params->conn) {
 			hci_conn_drop(params->conn);
+			hci_conn_put(params->conn);
 			params->conn = NULL;
 		}
 	}
@@ -4322,7 +4323,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 * the parameters get removed and keep the reference
 		 * count consistent once the connection is established.
 		 */
-		params->conn = conn;
+		params->conn = hci_conn_get(conn);
 		return;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c2457435a670..c2d571c10544 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3063,6 +3063,7 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	conn->disconn_cfm_cb = NULL;
 
 	hci_conn_drop(conn);
+	hci_conn_put(conn);
 
 	mgmt_pending_remove(cmd);
 }
@@ -4914,6 +4915,7 @@ static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
 		     match->mgmt_status, &rp, sizeof(rp));
 
 	hci_conn_drop(conn);
+	hci_conn_put(conn);
 
 	mgmt_pending_remove(cmd);
 }
@@ -5070,7 +5072,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 
 		hci_conn_hold(conn);
-		cmd->user_data = conn;
+		cmd->user_data = hci_conn_get(conn);
 
 		conn->conn_info_timestamp = jiffies;
 	} else {
@@ -5134,8 +5136,10 @@ send_rsp:
 	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
 		     &rp, sizeof(rp));
 	mgmt_pending_remove(cmd);
-	if (conn)
+	if (conn) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5198,7 +5202,7 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (conn) {
 		hci_conn_hold(conn);
-		cmd->user_data = conn;
+		cmd->user_data = hci_conn_get(conn);
 
 		hci_cp.handle = cpu_to_le16(conn->handle);
 		hci_cp.which = 0x01; /* Piconet clock */
-- 
1.9.3

