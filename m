Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Track both local and remote L2CAP fixed channel mask
Date: Tue,  2 Dec 2014 10:00:40 +0200
Message-Id: <1417507240-26820-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To pave the way for future fixed channels to be added easily we should
track both the local and remote mask on a per-L2CAP connection (struct
l2cap_conn) basis. So far the code has used a global variable in a racy
way which anyway needs fixing.

This patch renames the existing conn->fixed_chan_mask that tracked
the remote mask to conn->remote_fixed_chan and adds a new variable
conn->local_fixed_chan to track the local mask. Since the HS support
info is now available in the local mask we can remove the
conn->hs_enabled variable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  4 ++--
 net/bluetooth/l2cap_core.c    | 37 ++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 061e648052c8..d71dc3579354 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -619,8 +619,8 @@ struct l2cap_conn {
 	unsigned int		mtu;
 
 	__u32			feat_mask;
-	__u8			fixed_chan_mask;
-	bool			hs_enabled;
+	__u8			remote_fixed_chan;
+	__u8			local_fixed_chan;
 
 	__u8			info_state;
 	__u8			info_ident;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c2d1489c228c..5262920a6052 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -46,7 +46,6 @@
 bool disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
-static u8 l2cap_fixed_chan[8] = { L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS, };
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
@@ -1120,10 +1119,10 @@ static bool __amp_capable(struct l2cap_chan *chan)
 	struct hci_dev *hdev;
 	bool amp_available = false;
 
-	if (!conn->hs_enabled)
+	if (!(conn->local_fixed_chan & L2CAP_FC_A2MP))
 		return false;
 
-	if (!(conn->fixed_chan_mask & L2CAP_FC_A2MP))
+	if (!(conn->remote_fixed_chan & L2CAP_FC_A2MP))
 		return false;
 
 	read_lock(&hci_dev_list_lock);
@@ -3096,12 +3095,14 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 
 static inline bool __l2cap_ews_supported(struct l2cap_conn *conn)
 {
-	return conn->hs_enabled && conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
+	return ((conn->local_fixed_chan & L2CAP_FC_A2MP) &&
+		(conn->feat_mask & L2CAP_FEAT_EXT_WINDOW));
 }
 
 static inline bool __l2cap_efs_supported(struct l2cap_conn *conn)
 {
-	return conn->hs_enabled && conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
+	return ((conn->local_fixed_chan & L2CAP_FC_A2MP) &&
+		(conn->feat_mask & L2CAP_FEAT_EXT_FLOW));
 }
 
 static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
@@ -3330,7 +3331,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 			break;
 
 		case L2CAP_CONF_EWS:
-			if (!chan->conn->hs_enabled)
+			if (!(chan->conn->local_fixed_chan & L2CAP_FC_A2MP))
 				return -ECONNREFUSED;
 
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
@@ -4334,7 +4335,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn,
 		if (!disable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 				| L2CAP_FEAT_FCS;
-		if (conn->hs_enabled)
+		if (conn->local_fixed_chan & L2CAP_FC_A2MP)
 			feat_mask |= L2CAP_FEAT_EXT_FLOW
 				| L2CAP_FEAT_EXT_WINDOW;
 
@@ -4345,14 +4346,10 @@ static inline int l2cap_information_req(struct l2cap_conn *conn,
 		u8 buf[12];
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
 
-		if (conn->hs_enabled)
-			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
-		else
-			l2cap_fixed_chan[0] &= ~L2CAP_FC_A2MP;
-
 		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
-		memcpy(rsp->data, l2cap_fixed_chan, sizeof(l2cap_fixed_chan));
+		rsp->data[0] = conn->local_fixed_chan;
+		memset(&rsp->data[1], 0, 7);
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_RSP, sizeof(buf),
 			       buf);
 	} else {
@@ -4418,7 +4415,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_IT_FIXED_CHAN:
-		conn->fixed_chan_mask = rsp->data[0];
+		conn->remote_fixed_chan = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 
@@ -4442,7 +4439,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 	if (cmd_len != sizeof(*req))
 		return -EPROTO;
 
-	if (!conn->hs_enabled)
+	if (!(conn->local_fixed_chan & L2CAP_FC_A2MP))
 		return -EINVAL;
 
 	psm = le16_to_cpu(req->psm);
@@ -4872,7 +4869,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x, dest_amp_id %d", icid, req->dest_amp_id);
 
-	if (!conn->hs_enabled)
+	if (!(conn->local_fixed_chan & L2CAP_FC_A2MP))
 		return -EINVAL;
 
 	chan = l2cap_get_chan_by_dcid(conn, icid);
@@ -6964,9 +6961,11 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	conn->feat_mask = 0;
 
-	if (hcon->type == ACL_LINK)
-		conn->hs_enabled = test_bit(HCI_HS_ENABLED,
-					    &hcon->hdev->dev_flags);
+	conn->local_fixed_chan = L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS;
+
+	if (hcon->type == ACL_LINK &&
+	    test_bit(HCI_HS_ENABLED, &hcon->hdev->dev_flags))
+		conn->local_fixed_chan |= L2CAP_FC_A2MP;
 
 	mutex_init(&conn->ident_lock);
 	mutex_init(&conn->chan_lock);
-- 
2.1.0

