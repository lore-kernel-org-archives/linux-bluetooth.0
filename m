Return-Path: <cyrus@holtmann.org>
From: Seungyoun Ju <sy39.ju@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH 3/3] Bluetooth: Implement L2CAP socket option for connection params
Date: Thu, 17 Sep 2015 15:57:20 +0900
Message-Id: <1442473040-14492-4-git-send-email-sy39.ju@samsung.com>
In-Reply-To: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
References: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a BT_CONNECTION_PARAMS l2cap sockopt to
update and get LE connection parameters.

Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
---
 net/bluetooth/l2cap_sock.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 73a4ce8..fc98e33 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -498,6 +498,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	struct bt_power pwr;
+	struct bt_connection_params le_params;
+	struct l2cap_conn *conn;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -603,6 +605,30 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CONNECTION_PARAMS:
+		if (!bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (!chan->conn || !chan->conn->hcon) {
+			err = -EINVAL;
+			break;
+		}
+		conn = chan->conn;
+
+		le_params.min_interval = conn->hcon->le_conn_min_interval;
+		le_params.max_interval = conn->hcon->le_conn_max_interval;
+		le_params.latency = conn->hcon->le_conn_latency;
+		le_params.supv_timeout = conn->hcon->le_supv_timeout;
+
+		len = min_t(unsigned int, len, sizeof(le_params));
+		if (copy_to_user(optval, (char *) &le_params, len))
+			err = -EFAULT;
 		break;
 
 	default:
@@ -749,6 +775,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	struct bt_power pwr;
+	struct bt_connection_params le_params;
 	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
@@ -939,6 +966,36 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CONNECTION_PARAMS:
+		if (!bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (!chan->conn || !chan->conn->hcon) {
+			err = -EINVAL;
+			break;
+		}
+		conn = chan->conn;
+
+		le_params.min_interval = conn->hcon->le_conn_min_interval;
+		le_params.max_interval = conn->hcon->le_conn_max_interval;
+		le_params.latency = conn->hcon->le_conn_latency;
+		le_params.supv_timeout = conn->hcon->le_supv_timeout;
+
+		len = min_t(unsigned int, sizeof(le_params), optlen);
+		if (copy_from_user((char *) &le_params, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		err = l2cap_le_conn_update(conn,
+				le_params.min_interval, le_params.max_interval,
+				le_params.latency, le_params.supv_timeout);
 		break;
 
 	default:
-- 
2.1.0

