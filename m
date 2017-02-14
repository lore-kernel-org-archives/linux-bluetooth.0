Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v2 BlueZ 2/2] Bluetooth: L2CAP: Add BT_LE_CONN_CONFIG socket option
Date: Tue, 14 Feb 2017 20:28:29 +0000
Message-Id: <20170214202829.550-3-eu@felipetonello.com>
In-Reply-To: <20170214202829.550-1-eu@felipetonello.com>
References: <20170214202829.550-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a need for certain LE profiles (MIDI for example)to change the
current connection's parameters. In order to do that, this patch
introduces a new BT_LE_CONN_CONFIG socket option for SOL_BLUETOOTH
protocol which allow user-space l2cap sockets to update the current
connection.

The current options exported to user-space are default, low and high
latency. Internally, when a custom latency is used when the connection
parameters are set by MGMT_OP_LOAD_CONN_PARAM.

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
 include/net/bluetooth/bluetooth.h |   9 ++++
 include/net/bluetooth/hci_core.h  |   1 +
 net/bluetooth/hci_core.c          |   1 +
 net/bluetooth/l2cap_sock.c        | 109 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              |   1 +
 5 files changed, 121 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 01487192f628..ff63b85859ff 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,15 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_LE_CONN_CONFIG	14
+enum bt_le_conn_config {
+	BT_LE_CONN_CONFIG_DEFAULT_LATENCY = 0,
+	BT_LE_CONN_CONFIG_LOW_LATENCY,
+	BT_LE_CONN_CONFIG_HIGH_LATENCY,
+	/* Kernel-only configuration */
+	BT_LE_CONN_CONFIG_CUSTOM_LATENCY = 100,
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 554671c81f4a..c4ed995ebace 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -522,6 +522,7 @@ struct hci_conn_params {
 	u16 conn_max_interval;
 	u16 conn_latency;
 	u16 supervision_timeout;
+	enum bt_le_conn_config conn_config;
 
 	enum {
 		HCI_AUTO_CONN_DISABLED,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ac89e9ace71..832d7a2cbec3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2824,6 +2824,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	params->conn_latency = hdev->le_conn_latency;
 	params->supervision_timeout = hdev->le_supv_timeout;
 	params->auto_connect = HCI_AUTO_CONN_DISABLED;
+	params->conn_config = BT_LE_CONN_CONFIG_DEFAULT_LATENCY;
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a8ba752732c9..1bad51a4e28b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -514,6 +514,35 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_LE_CONN_CONFIG: {
+		enum bt_le_conn_config conn_config;
+		struct hci_conn_params *params;
+		struct hci_conn *hcon;
+
+		if (!chan->conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		hcon = chan->conn->hcon;
+		hci_dev_lock(hcon->hdev);
+
+		params = hci_conn_params_lookup(hcon->hdev,
+			&hcon->dst, hcon->dst_type);
+
+		if (params)
+			conn_config = params->conn_config;
+		else
+			conn_config = BT_LE_CONN_CONFIG_DEFAULT_LATENCY;
+
+		hci_dev_unlock(hcon->hdev);
+
+		len = min_t(unsigned int, len, sizeof(conn_config));
+		if (copy_to_user(optval, (char *) &conn_config, len))
+			err = -EFAULT;
+
+		break;
+	}
 	case BT_SECURITY:
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
 		    chan->chan_type != L2CAP_CHAN_FIXED &&
@@ -761,6 +790,86 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_LE_CONN_CONFIG: {
+		enum bt_le_conn_config conn_config;
+		struct hci_conn_params *hci_param;
+		struct hci_conn *hcon;
+		u16 min_interval = 0, max_interval = 0, latency = 0;
+
+		len = min_t(unsigned int, sizeof(conn_config), optlen);
+		if (copy_from_user((char *) &conn_config, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!chan->conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		/* CUSTOM must be set only by the kernel */
+		if (conn_config >= BT_LE_CONN_CONFIG_CUSTOM_LATENCY) {
+			err = -EINVAL;
+			BT_ERR("Ignoring invalid connection configuration");
+			break;
+		}
+
+		hcon = chan->conn->hcon;
+
+		hci_dev_lock(hcon->hdev);
+
+		hci_conn_params_clear_disabled(hcon->hdev);
+
+		/* We add new param in case it doesn't exist.
+		 * hci_param will be updated in hci_le_conn_update(). */
+		hci_param = hci_conn_params_add(hcon->hdev,
+			&hcon->dst, hcon->dst_type);
+		if (!hci_param) {
+			err = -ENOMEM;
+			BT_ERR("Failed to add connection parameters");
+			hci_dev_unlock(hcon->hdev);
+			break;
+		}
+
+		hci_param->conn_config = conn_config;
+
+		switch (conn_config) {
+		case BT_LE_CONN_CONFIG_LOW_LATENCY:
+			min_interval = 0x0006;
+			max_interval = 0x000c;
+			latency = 0x0000;
+			break;
+		case BT_LE_CONN_CONFIG_HIGH_LATENCY:
+			min_interval = 0x0038;
+			max_interval = 0x0c80;
+			latency = 0x01f3;
+			break;
+		case BT_LE_CONN_CONFIG_DEFAULT_LATENCY:
+		default:
+			/* make sure we don't have non-supported configs */
+			hci_param->conn_config =
+				BT_LE_CONN_CONFIG_DEFAULT_LATENCY;
+			min_interval = hcon->hdev->le_conn_min_interval;
+			max_interval = hcon->hdev->le_conn_max_interval;
+			latency = hcon->hdev->le_conn_latency;
+			break;
+		}
+
+		hci_dev_unlock(hcon->hdev);
+
+		l2cap_le_conn_req(chan->conn, min_interval, max_interval,
+				latency, hci_param->supervision_timeout);
+
+		/* this function also updates the hci_param value */
+		hci_le_conn_update(hcon, min_interval, max_interval, latency,
+			hci_param->supervision_timeout);
+
+		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type, true,
+			min_interval, max_interval, latency,
+			hci_param->supervision_timeout);
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
2.11.1

