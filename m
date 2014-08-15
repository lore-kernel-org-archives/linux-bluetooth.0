Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix hci_conn reference counting for auto-connections
Date: Fri, 15 Aug 2014 20:33:00 +0300
Message-Id: <1408123980-26578-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408122859-24674-1-git-send-email-johan.hedberg@gmail.com>
References: <1408122859-24674-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Recently the LE passive scanning and auto-connections feature was
introduced. It uses the hci_connect_le() API which returns a hci_conn
along with a reference count to that object. All previous users would
tie this returned reference to some existing object, such as an L2CAP
channel, and there'd be no leaked references this way. For
auto-connections however the reference was returned but not stored
anywhere, leaving established connections with one higher reference
count than they should have.

Instead of playing special tricks with hci_conn_hold/drop this patch
associates the returned reference from hci_connect_le() with the object
that in practice does own this reference, i.e. the hci_conn_params
struct that caused us to initiate a connection in the first place. Once
the connection is established or fails to establish this reference is
removed appropriately.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  8 ++++++++
 net/bluetooth/hci_core.c         |  5 +++++
 net/bluetooth/hci_event.c        | 17 +++++++++++++++--
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f0b77b71b45..b0ded1333865 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -464,6 +464,8 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
 	} auto_connect;
+
+	struct hci_conn *conn;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b50dabb3f86a..faff6247ac8f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -589,6 +589,14 @@ EXPORT_SYMBOL(hci_get_route);
 void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 {
 	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn_params *params;
+
+	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
+					   conn->dst_type);
+	if (params && params->conn) {
+		hci_conn_drop(params->conn);
+		params->conn = NULL;
+	}
 
 	conn->state = BT_CLOSED;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index abeb5e47311e..455f3fee46d3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3729,6 +3729,9 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!params)
 		return;
 
+	if (params->conn)
+		hci_conn_drop(params->conn);
+
 	list_del(&params->action);
 	list_del(&params->list);
 	kfree(params);
@@ -3759,6 +3762,8 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	struct hci_conn_params *params, *tmp;
 
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
+		if (params->conn)
+			hci_conn_drop(params->conn);
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da7ab6b9bb69..3a99f30a3317 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4226,8 +4226,13 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_proto_connect_cfm(conn, ev->status);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params)
+	if (params) {
 		list_del_init(&params->action);
+		if (params->conn) {
+			hci_conn_drop(params->conn);
+			params->conn = NULL;
+		}
+	}
 
 unlock:
 	hci_update_background_scan(hdev);
@@ -4309,8 +4314,16 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
-	if (!IS_ERR(conn))
+	if (!IS_ERR(conn)) {
+		/* Store the pointer since we don't really have any
+		 * other owner of the object besides the params that
+		 * triggered it. This way we can abort the connection if
+		 * the parameters get removed and keep the reference
+		 * count consistent once the connection is established.
+		 */
+		params->conn = conn;
 		return;
+	}
 
 	switch (PTR_ERR(conn)) {
 	case -EBUSY:
-- 
1.9.3

