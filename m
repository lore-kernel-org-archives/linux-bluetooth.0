Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: L2CAP: Derive MPS from connection MTU
Date: Mon,  3 Sep 2018 20:12:15 +0300
Message-Id: <20180903171217.4408-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures the MPS can fit in a single HCI fragment so each
segment don't have to be reassembled at HCI level, in addition to
that also remove the debugfs entry to configure the MPS.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 -
 net/bluetooth/l2cap_core.c    | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0697fd413087..17296675a0b1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -456,7 +456,6 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
 #define L2CAP_LE_MAX_CREDITS		10
-#define L2CAP_LE_DEFAULT_MPS		230
 
 struct l2cap_le_conn_req {
 	__le16     psm;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d17a4736e47c..8a60db6261f7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -52,7 +52,6 @@ static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
 
 static u16 le_max_credits = L2CAP_LE_MAX_CREDITS;
-static u16 le_default_mps = L2CAP_LE_DEFAULT_MPS;
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				       u8 code, u8 ident, u16 dlen, void *data);
@@ -520,7 +519,8 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->sdu_len = 0;
 	chan->tx_credits = 0;
 	chan->rx_credits = le_max_credits;
-	chan->mps = min_t(u16, chan->imtu, le_default_mps);
+	/* Derive MPS from connection MTU to stop HCI fragmentation */
+	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -1282,6 +1282,8 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
 		return;
 
+	l2cap_le_flowctl_init(chan);
+
 	req.psm     = chan->psm;
 	req.scid    = cpu_to_le16(chan->scid);
 	req.mtu     = cpu_to_le16(chan->imtu);
@@ -5493,8 +5495,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	l2cap_le_flowctl_init(chan);
-
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5506,6 +5506,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->tx_credits = __le16_to_cpu(req->credits);
 
 	__l2cap_chan_add(conn, chan);
+
+	l2cap_le_flowctl_init(chan);
+
 	dcid = chan->scid;
 	credits = chan->rx_credits;
 
@@ -7102,7 +7105,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_LE_FLOWCTL:
-		l2cap_le_flowctl_init(chan);
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -7647,8 +7649,6 @@ int __init l2cap_init(void)
 
 	debugfs_create_u16("l2cap_le_max_credits", 0644, bt_debugfs,
 			   &le_max_credits);
-	debugfs_create_u16("l2cap_le_default_mps", 0644, bt_debugfs,
-			   &le_default_mps);
 
 	return 0;
 }
-- 
2.17.1
