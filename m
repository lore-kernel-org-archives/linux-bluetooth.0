Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 15/26] Bluetooth: Choose connection based on capabilities
Date: Fri, 17 Aug 2012 17:33:10 +0300
Message-Id: <1345214001-7053-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Choose which L2CAP connection to establish by checking support
for HS and remote side supported features.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    2 ++
 net/bluetooth/a2mp.c         |   31 ++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_core.c   |   31 +++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 345fbc6..f3f0d7e 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -22,6 +22,7 @@
 struct amp_mgr {
 	struct l2cap_conn	*l2cap_conn;
 	struct l2cap_chan	*a2mp_chan;
+	struct l2cap_chan	*bredr_chan;
 	struct kref		kref;
 	__u8			ident;
 	__u8			handle;
@@ -129,6 +130,7 @@ int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+void a2mp_discover_amp(struct l2cap_chan *chan);
 int a2mp_init(void);
 void a2mp_exit(void);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 26a225b..7113c76 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -770,18 +770,25 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 	return mgr->a2mp_chan;
 }
 
-void l2cap_discover_amp(struct l2cap_chan *chan)
+struct amp_work {
+	struct work_struct work;
+	struct l2cap_chan *chan;
+};
+
+static void a2mp_discover_amp_worker(struct work_struct *w)
 {
-	struct a2mp_discov_req req;
+	struct amp_work *work = (struct amp_work *) w;
+	struct l2cap_chan *chan = work->chan;
 	struct l2cap_conn *conn = chan->conn;
 	struct amp_mgr *mgr = conn->hcon->amp_mgr;
+	struct a2mp_discov_req req;
 
 	BT_DBG("%p", conn);
 
 	if (!mgr) {
 		mgr = amp_mgr_create(conn);
 		if (!mgr)
-			return;
+			goto clean;
 	}
 
 	mgr->bredr_chan = chan;
@@ -789,6 +796,24 @@ void l2cap_discover_amp(struct l2cap_chan *chan)
 	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
 	req.ext_feat = 0;
 	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
+
+clean:
+	kfree(w);
+}
+
+void a2mp_discover_amp(struct l2cap_chan *chan)
+{
+	struct amp_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return;
+
+	INIT_WORK(&work->work, a2mp_discover_amp_worker);
+	work->chan = chan;
+
+	if (!queue_work(amp_workqueue, &work->work))
+		kfree(work);
 }
 
 int a2mp_init(void)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d4e99d6..a4a512e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1005,6 +1005,18 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
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
@@ -1031,6 +1043,16 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	chan->ops->ready(chan);
 }
 
+static void l2cap_choose_conn(struct l2cap_chan *chan)
+{
+	if (__amp_capable(chan)) {
+		BT_DBG("chan %p AMP capable: discover AMPs", chan);
+		a2mp_discover_amp(chan);
+	} else {
+		l2cap_send_conn_req(chan);
+	}
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1045,8 +1067,9 @@ static void l2cap_do_start(struct l2cap_chan *chan)
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
@@ -1142,7 +1165,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_send_conn_req(chan);
+			l2cap_choose_conn(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -5526,7 +5549,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				l2cap_send_conn_req(chan);
+				l2cap_choose_conn(chan);
 			} else {
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
-- 
1.7.9.5

