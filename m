Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v2 BlueZ 1/2] Bluetooth: L2CAP: Refactor L2CAP_CONN_PARAM_UPDATE_REQ into a function
Date: Tue, 14 Feb 2017 20:28:28 +0000
Message-Id: <20170214202829.550-2-eu@felipetonello.com>
In-Reply-To: <20170214202829.550-1-eu@felipetonello.com>
References: <20170214202829.550-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This signaling command is useful for any connection parameter change
procedure, thus it is important to allow access to it from outside this
translation unit.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 36 +++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c689c863..ab9ad42d8ed0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -948,4 +948,7 @@ void l2cap_conn_put(struct l2cap_conn *conn);
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
 
+void l2cap_le_conn_req(struct l2cap_conn *conn, u8 min_interval,
+		u8 max_interval, u8 latency, u8 supv_timeout);
+
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ce0b5dd01953..152dee554202 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1483,6 +1483,24 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_unlock(&conn->chan_lock);
 }
 
+void l2cap_le_conn_req(struct l2cap_conn *conn, u8 min_interval,
+		u8 max_interval, u8 latency, u8 supv_timeout)
+{
+	struct l2cap_conn_param_update_req req;
+
+	if (conn->hcon->role != HCI_ROLE_SLAVE)
+		return;
+
+	req.min = cpu_to_le16(min_interval);
+	req.max = cpu_to_le16(max_interval);
+	req.latency = cpu_to_le16(latency);
+	req.to_multiplier = cpu_to_le16(supv_timeout);
+
+	l2cap_send_cmd(conn, l2cap_get_ident(conn),
+	               L2CAP_CONN_PARAM_UPDATE_REQ, sizeof(req), &req);
+}
+
+
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -1501,19 +1519,11 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	 * been configured for this connection. If not, then trigger
 	 * the connection update procedure.
 	 */
-	if (hcon->role == HCI_ROLE_SLAVE &&
-	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
-	     hcon->le_conn_interval > hcon->le_conn_max_interval)) {
-		struct l2cap_conn_param_update_req req;
-
-		req.min = cpu_to_le16(hcon->le_conn_min_interval);
-		req.max = cpu_to_le16(hcon->le_conn_max_interval);
-		req.latency = cpu_to_le16(hcon->le_conn_latency);
-		req.to_multiplier = cpu_to_le16(hcon->le_supv_timeout);
-
-		l2cap_send_cmd(conn, l2cap_get_ident(conn),
-			       L2CAP_CONN_PARAM_UPDATE_REQ, sizeof(req), &req);
-	}
+	if (hcon->le_conn_interval < hcon->le_conn_min_interval ||
+	    hcon->le_conn_interval > hcon->le_conn_max_interval)
+		l2cap_le_conn_req(conn, hcon->le_conn_min_interval,
+			hcon->le_conn_max_interval, hcon->le_conn_latency,
+			hcon->le_supv_timeout);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
-- 
2.11.1

