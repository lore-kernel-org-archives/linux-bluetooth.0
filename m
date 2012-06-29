Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 15/19] Bluetooth: Choose connection based on capabilities
Date: Fri, 29 Jun 2012 17:46:48 +0300
Message-Id: <1340981212-21709-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Choose which L2CAP connection to establish by checking support
for HS and remote side supported features.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    1 +
 net/bluetooth/a2mp.c         |   22 ++++++++++++++++++++++
 net/bluetooth/l2cap_core.c   |   34 ++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 8ba236c..68866f4 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -129,5 +129,6 @@ int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+void l2cap_discover_amp(struct l2cap_conn *conn);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5ff8f1a..a4df006 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -766,3 +766,25 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 
 	return mgr->a2mp_chan;
 }
+
+void l2cap_discover_amp(struct l2cap_conn *conn)
+{
+	struct a2mp_discov_req req;
+	struct amp_mgr *mgr = conn->hcon->amp_mgr;
+
+	BT_DBG("%p", conn);
+
+	if (!mgr) {
+		mgr = amp_mgr_create(conn);
+		if (!mgr)
+			return;
+	}
+
+	amp_mgr_get(mgr);
+
+	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
+	req.ext_feat = 0;
+	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
+
+	amp_mgr_put(mgr);
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b01f9d1..a5256e7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -989,6 +989,18 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
+static bool __amp_capable(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+
+	if (enable_hs &&
+	    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED &&
+	    conn->fixed_chan_mask & L2CAP_FC_A2MP)
+		return true;
+	else
+		return false;
+}
+
 static void l2cap_send_conn_req(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1015,6 +1027,16 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	chan->ops->ready(chan);
 }
 
+static void l2cap_choose_conn(struct l2cap_chan *chan)
+{
+	if (__amp_capable(chan)) {
+		BT_DBG("chan %p AMP capable", chan);
+		l2cap_discover_amp(chan->conn);
+	} else {
+		l2cap_send_conn_req(chan);
+	}
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1029,8 +1051,9 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 			return;
 
 		if (l2cap_chan_check_security(chan) &&
-				__l2cap_no_conn_pending(chan))
-			l2cap_send_conn_req(chan);
+				__l2cap_no_conn_pending(chan)) {
+			l2cap_choose_conn(chan);
+		}
 	} else {
 		struct l2cap_info_req req;
 		req.type = __constant_cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -1126,7 +1149,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_send_conn_req(chan);
+			l2cap_choose_conn(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -5499,7 +5522,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				l2cap_send_conn_req(chan);
+				/* Unlock chan list since we add A2MP chan */
+				mutex_unlock(&conn->chan_lock);
+				l2cap_choose_conn(chan);
+				mutex_lock(&conn->chan_lock);
 			} else {
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
-- 
1.7.9.5

