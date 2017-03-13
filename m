Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v3 BlueZ 2/3] Bluetooth: L2CAP: Add BT_LE_CONN_PARAM socket option
Date: Mon, 13 Mar 2017 17:54:11 +0000
Message-Id: <20170313175412.11365-3-eu@felipetonello.com>
In-Reply-To: <20170313175412.11365-1-eu@felipetonello.com>
References: <20170313175412.11365-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a need for certain LE profiles (MIDI for example) to change the
current connection's parameters. In order to do that, this patch
introduces a new BT_LE_CONN_PARAM socket option for SOL_BLUETOOTH
protocol which allow user-space l2cap sockets to update the current
connection.

It necessary to expose all the connection parameters to user-space
because user-space are exposed to those values anyway, via PPCP
characteristic or Slave Connection Interval AD, for instance. Also it is
useful for tools to set particular values for because of profile
requirements.

If ROLE is SLAVE, then it will also send a L2CAP_CONN_PARAM_UPDATE_REQ
signaling command to the MASTER, triggering proper 4.0 parameter update
procedure.

This option will also send a MGMT_EV_NEW_CONN_PARAM event with the
store_hint set so the user-space application can store the connection
parameters for persistence reasons.

Note: Connection Parameters Request Link Layer Control Procedure is not
supported by BlueZ yet.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 include/net/bluetooth/bluetooth.h |   8 +++
 net/bluetooth/l2cap_sock.c        | 101 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              |   1 +
 3 files changed, 110 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 01487192f628..ce5b3abd3b27 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,14 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_LE_CONN_PARAM	14
+struct bt_le_conn_param {
+	__u16 min_interval;
+	__u16 max_interval;
+	__u16 latency;
+	__u16 supervision_timeout;
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f307b145ea54..8c2e6f29869f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -515,6 +515,47 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_LE_CONN_PARAM: {
+		struct bt_le_conn_param conn_param;
+		struct hci_conn_params *params;
+		struct hci_conn *hcon;
+		struct hci_dev *hdev;
+
+		if (!chan->conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		hcon = chan->conn->hcon;
+		hdev = hcon->hdev;
+		hci_dev_lock(hdev);
+
+		params = hci_conn_params_lookup(hdev, &hcon->dst,
+			hcon->dst_type);
+
+		memset(&conn_param, 0, sizeof(conn_param));
+
+		if (params) {
+			conn_param.min_interval = params->conn_min_interval;
+			conn_param.max_interval = params->conn_max_interval;
+			conn_param.latency = params->conn_latency;
+			conn_param.supervision_timeout =
+				params->supervision_timeout;
+		} else {
+			conn_param.min_interval = hdev->le_conn_min_interval;
+			conn_param.max_interval = hdev->le_conn_max_interval;
+			conn_param.latency = hdev->le_conn_latency;
+			conn_param.supervision_timeout = hdev->le_supv_timeout;
+		}
+
+		hci_dev_unlock(hdev);
+
+		len = min_t(unsigned int, len, sizeof(conn_param));
+		if (copy_to_user(optval, (char *) &conn_param, len))
+			err = -EFAULT;
+
+		break;
+	}
 	case BT_SECURITY:
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
 		    chan->chan_type != L2CAP_CHAN_FIXED &&
@@ -762,6 +803,66 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_LE_CONN_PARAM: {
+		struct bt_le_conn_param conn_param;
+		struct hci_conn_params *hci_param;
+		struct hci_conn *hcon;
+		struct hci_dev *hdev;
+
+		len = min_t(unsigned int, sizeof(conn_param), optlen);
+		if (copy_from_user((char *) &conn_param, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!chan->conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		err = hci_check_conn_params(conn_param.min_interval,
+			conn_param.max_interval, conn_param.latency,
+			conn_param.supervision_timeout);
+		if (err < 0) {
+			BT_ERR("Ignoring invalid connection parameters");
+			break;
+		}
+
+		hcon = chan->conn->hcon;
+		hdev = hcon->hdev;
+
+		hci_dev_lock(hdev);
+
+		/* We add new param in case it doesn't exist.
+		 * hci_param will be updated in hci_le_conn_update(). */
+		hci_param = hci_conn_params_add(hdev, &hcon->dst,
+			hcon->dst_type);
+		if (!hci_param) {
+			err = -ENOMEM;
+			BT_ERR("Failed to add connection parameters");
+			hci_dev_unlock(hcon->hdev);
+			break;
+		}
+
+		hci_dev_unlock(hdev);
+
+		/* Send a L2CAP connection parameters update request, if
+		 * the host role is slave. */
+		l2cap_le_conn_req(chan->conn, conn_param.min_interval,
+			conn_param.max_interval, conn_param.latency,
+			conn_param.supervision_timeout);
+
+		/* this function also updates the hci_param value */
+		hci_le_conn_update(hcon, conn_param.min_interval,
+			conn_param.max_interval, conn_param.latency,
+			conn_param.supervision_timeout);
+
+		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, true,
+			conn_param.min_interval, conn_param.max_interval,
+			conn_param.latency, conn_param.supervision_timeout);
+		break;
+	}
+
 	case BT_SECURITY:
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
 		    chan->chan_type != L2CAP_CHAN_FIXED &&
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a03f8ae..0f44af559ae6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5540,6 +5540,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_param->conn_max_interval = max;
 		hci_param->conn_latency = latency;
 		hci_param->supervision_timeout = timeout;
+		hci_param->conn_config = BT_LE_CONN_CONFIG_CUSTOM_LATENCY;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.12.0

