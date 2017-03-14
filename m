Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v4 BlueZ 1/4] Bluetooth: L2CAP: Refactor L2CAP_CONN_PARAM_UPDATE_REQ into a function
Date: Tue, 14 Mar 2017 18:30:55 +0000
Message-Id: <20170314183058.25555-2-eu@felipetonello.com>
In-Reply-To: <20170314183058.25555-1-eu@felipetonello.com>
References: <20170314183058.25555-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This signaling command is useful for any connection parameter change
procedure, thus it is important to allow access to it from outside this
translation unit.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 31 ++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c689c863..0073a01c61e9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -948,4 +948,7 @@ void l2cap_conn_put(struct l2cap_conn *conn);
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
 
+void l2cap_le_conn_update_req(struct l2cap_conn *conn, u8 min_interval,
+		u8 max_interval, u8 latency, u8 supv_timeout);
+
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fc7f321a3823..27a38b4543e1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1483,6 +1483,22 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_unlock(&conn->chan_lock);
 }
 
+/* This command shall only be send if the connection role is master */
+void l2cap_le_conn_update_req(struct l2cap_conn *conn, u8 min_interval,
+		u8 max_interval, u8 latency, u8 supv_timeout)
+{
+	struct l2cap_conn_param_update_req req;
+
+	req.min = cpu_to_le16(min_interval);
+	req.max = cpu_to_le16(max_interval);
+	req.latency = cpu_to_le16(latency);
+	req.to_multiplier = cpu_to_le16(supv_timeout);
+
+	l2cap_send_cmd(conn, l2cap_get_ident(conn),
+		       L2CAP_CONN_PARAM_UPDATE_REQ, sizeof(req), &req);
+}
+
+
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -1503,17 +1519,10 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	 */
 	if (hcon->role == HCI_ROLE_SLAVE &&
 	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
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
+	     hcon->le_conn_interval > hcon->le_conn_max_interval))
+		l2cap_le_conn_update_req(conn, hcon->le_conn_min_interval,
+			hcon->le_conn_max_interval, hcon->le_conn_latency,
+			hcon->le_supv_timeout);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
-- 
2.12.0

