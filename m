Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support LE slave connection update procedure
Date: Mon, 23 Jun 2014 12:18:51 +0200
Message-Id: <1403518731-16989-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the current LE connection parameters of a slave connection do not
match up with the controller defined values, then trigger the connection
update procedure to allow adjusting them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cbf6b9d1c404..565afb78296a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1481,6 +1481,25 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, dst_type))
 		return;
 
+	/* For LE slave connections, make sure the connection interval
+	 * is in the range of the minium and maximum interval that has
+	 * been configured for this connection. If not, then trigger
+	 * the connection update procedure.
+	 */
+	if (!(hcon->link_mode & HCI_LM_MASTER) &&
+	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
+	     hcon->le_conn_interval > hcon->le_conn_max_interval)) {
+		struct l2cap_conn_param_update_req req;
+
+		req.min = cpu_to_le16(hcon->le_conn_min_interval);
+		req.max = cpu_to_le16(hcon->le_conn_max_interval);
+		req.latency = cpu_to_le16(hcon->le_conn_latency);
+		req.to_multiplier = cpu_to_le16(hcon->le_supv_timeout);
+
+		l2cap_send_cmd(conn, l2cap_get_ident(conn),
+			       L2CAP_CONN_PARAM_UPDATE_REQ, sizeof(req), &req);
+	}
+
 	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan);
-- 
1.9.3

