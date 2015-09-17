Return-Path: <cyrus@holtmann.org>
From: Seungyoun Ju <sy39.ju@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH 2/3] Bluetooth: Update LE connecion parameters depending on LE features
Date: Thu, 17 Sep 2015 15:57:19 +0900
Message-Id: <1442473040-14492-3-git-send-email-sy39.ju@samsung.com>
In-Reply-To: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
References: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A different LE connection parameter update procedure must be used
depending on local / remote device's LE features and role.

But current implementation selects the procedure based on the role only.

This patch selects a proper procedure based on LE features and local role,
and updates LE connection parameters.

Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
---
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 45 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c98afc0..8902a48 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -929,6 +929,8 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
+int l2cap_le_conn_update(struct l2cap_conn *conn, u16 min, u16 max,
+			 u16 latency, u16 to_multiplier);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee2..97ec748 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1472,6 +1472,37 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_unlock(&conn->chan_lock);
 }
 
+int l2cap_le_conn_update(struct l2cap_conn *conn, u16 min, u16 max,
+			 u16 latency, u16 to_multiplier)
+{
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	struct l2cap_conn_param_update_req req;
+	int err;
+
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (err < 0)
+		return err;
+
+	if (hcon->role == HCI_ROLE_MASTER ||
+	    (hdev->le_features[0] & HCI_LE_CONN_PARAM_REQ_PROC &&
+	     hcon->features[0][0] & HCI_LE_CONN_PARAM_REQ_PROC)) {
+		err = hci_le_conn_update(hcon, min, max, latency,
+				to_multiplier);
+	} else {
+		req.min = cpu_to_le16(min);
+		req.max = cpu_to_le16(max);
+		req.latency = cpu_to_le16(latency);
+		req.to_multiplier = cpu_to_le16(to_multiplier);
+
+		l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				L2CAP_CONN_PARAM_UPDATE_REQ,
+				sizeof(req), &req);
+	}
+
+	return err;
+}
+
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -1493,15 +1524,11 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (hcon->role == HCI_ROLE_SLAVE &&
 	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
 	     hcon->le_conn_interval > hcon->le_conn_max_interval)) {
-		struct l2cap_conn_param_update_req req;
-
-		req.min = cpu_to_le16(hcon->le_conn_min_interval);
-		req.max = cpu_to_le16(hcon->le_conn_max_interval);
-		req.latency = cpu_to_le16(hcon->le_conn_latency);
-		req.to_multiplier = cpu_to_le16(hcon->le_supv_timeout);
-
-		l2cap_send_cmd(conn, l2cap_get_ident(conn),
-			       L2CAP_CONN_PARAM_UPDATE_REQ, sizeof(req), &req);
+		l2cap_le_conn_update(conn,
+				hcon->le_conn_min_interval,
+				hcon->le_conn_max_interval,
+				hcon->le_conn_latency,
+				hcon->le_supv_timeout);
 	}
 }
 
-- 
2.1.0

