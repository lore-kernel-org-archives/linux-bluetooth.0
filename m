Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide high speed configuration option
Date: Sun, 29 Sep 2013 03:53:25 -0700
Message-Id: <1380452005-7211-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hiding the Bluetooth high speed support behind a module parameter is
not really useful. This can be enabled and disabled at runtime via
the management interface. This also has the advantage that his can
now be changed per controller and not just global.

This patch removes the module parameter and exposes the high speed
setting of the management interface to all controllers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/hci_core.c      |  6 ------
 net/bluetooth/l2cap_core.c    | 35 +++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    | 10 ----------
 net/bluetooth/mgmt.c          | 12 +-----------
 5 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1a966af..f141b5f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -564,6 +564,7 @@ struct l2cap_conn {
 
 	__u32			feat_mask;
 	__u8			fixed_chan_mask;
+	bool			hs_enabled;
 
 	__u8			info_state;
 	__u8			info_ident;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4549b5c..450a6c8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1222,12 +1222,6 @@ int hci_dev_open(__u16 dev)
 		ret = hdev->setup(hdev);
 
 	if (!ret) {
-		/* Treat all non BR/EDR controllers as raw devices if
-		 * enable_hs is not set.
-		 */
-		if (hdev->dev_type != HCI_BREDR && !enable_hs)
-			set_bit(HCI_RAW, &hdev->flags);
-
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 			set_bit(HCI_RAW, &hdev->flags);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d1f1e78..6d42498 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1016,13 +1016,12 @@ static bool __amp_capable(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 
-	if (enable_hs &&
-	    hci_amp_capable() &&
+	if (conn->hs_enabled && hci_amp_capable() &&
 	    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED &&
 	    conn->fixed_chan_mask & L2CAP_FC_A2MP)
 		return true;
-	else
-		return false;
+
+	return false;
 }
 
 static bool l2cap_check_efs(struct l2cap_chan *chan)
@@ -1638,6 +1637,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	conn->feat_mask = 0;
 
+	if (hcon->type == ACL_LINK)
+		conn->hs_enabled = test_bit(HCI_HS_ENABLED,
+					    &hcon->hdev->dev_flags);
+
 	spin_lock_init(&conn->lock);
 	mutex_init(&conn->chan_lock);
 
@@ -3084,14 +3087,14 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
-static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
+static inline bool __l2cap_ews_supported(struct l2cap_conn *conn)
 {
-	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
+	return conn->hs_enabled && conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
 }
 
-static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
+static inline bool __l2cap_efs_supported(struct l2cap_conn *conn)
 {
-	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
+	return conn->hs_enabled && conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
 }
 
 static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
@@ -3135,7 +3138,7 @@ static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
 static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 {
 	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
-	    __l2cap_ews_supported(chan)) {
+	    __l2cap_ews_supported(chan->conn)) {
 		/* use extended control field */
 		set_bit(FLAG_EXT_CTRL, &chan->flags);
 		chan->tx_win_max = L2CAP_DEFAULT_EXT_WINDOW;
@@ -3165,7 +3168,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
 			break;
 
-		if (__l2cap_efs_supported(chan))
+		if (__l2cap_efs_supported(chan->conn))
 			set_bit(FLAG_EFS_ENABLE, &chan->flags);
 
 		/* fall through */
@@ -3317,7 +3320,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 			break;
 
 		case L2CAP_CONF_EWS:
-			if (!enable_hs)
+			if (!chan->conn->hs_enabled)
 				return -ECONNREFUSED;
 
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
@@ -3349,7 +3352,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 		}
 
 		if (remote_efs) {
-			if (__l2cap_efs_supported(chan))
+			if (__l2cap_efs_supported(chan->conn))
 				set_bit(FLAG_EFS_ENABLE, &chan->flags);
 			else
 				return -ECONNREFUSED;
@@ -4303,7 +4306,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn,
 		if (!disable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 				| L2CAP_FEAT_FCS;
-		if (enable_hs)
+		if (conn->hs_enabled)
 			feat_mask |= L2CAP_FEAT_EXT_FLOW
 				| L2CAP_FEAT_EXT_WINDOW;
 
@@ -4314,7 +4317,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn,
 		u8 buf[12];
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
 
-		if (enable_hs)
+		if (conn->hs_enabled)
 			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
 		else
 			l2cap_fixed_chan[0] &= ~L2CAP_FC_A2MP;
@@ -4411,7 +4414,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 	if (cmd_len != sizeof(*req))
 		return -EPROTO;
 
-	if (!enable_hs)
+	if (!conn->hs_enabled)
 		return -EINVAL;
 
 	psm = le16_to_cpu(req->psm);
@@ -4838,7 +4841,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x, dest_amp_id %d", icid, req->dest_amp_id);
 
-	if (!enable_hs)
+	if (!conn->hs_enabled)
 		return -EINVAL;
 
 	chan = l2cap_get_chan_by_dcid(conn, icid);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c85537c..9119898 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -445,11 +445,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (!enable_hs) {
-			err = -ENOPROTOOPT;
-			break;
-		}
-
 		if (put_user(chan->chan_policy, (u32 __user *) optval))
 			err = -EFAULT;
 		break;
@@ -720,11 +715,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (!enable_hs) {
-			err = -ENOPROTOOPT;
-			break;
-		}
-
 		if (get_user(opt, (u32 __user *) optval)) {
 			err = -EFAULT;
 			break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1b5b10f..035744d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,8 +32,6 @@
 #include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/smp.h>
 
-bool enable_hs;
-
 #define MGMT_VERSION	1
 #define MGMT_REVISION	3
 
@@ -382,8 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_LINK_SECURITY;
 	}
 
-	if (enable_hs)
-		settings |= MGMT_SETTING_HS;
+	settings |= MGMT_SETTING_HS;
 
 	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
@@ -1344,10 +1341,6 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!enable_hs)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				  MGMT_STATUS_NOT_SUPPORTED);
-
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				  MGMT_STATUS_INVALID_PARAMS);
@@ -4396,6 +4389,3 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
 			  cmd ? cmd->sk : NULL);
 }
-
-module_param(enable_hs, bool, 0644);
-MODULE_PARM_DESC(enable_hs, "Enable High Speed support");
-- 
1.8.3.1

