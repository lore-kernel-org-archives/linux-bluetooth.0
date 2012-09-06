Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 11/19] Bluetooth: Choose connection based on capabilities
Date: Thu,  6 Sep 2012 15:19:49 +0300
Message-Id: <1346933997-14369-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Choose which L2CAP connection to establish by checking support
for HS and remote side supported features.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h  |    2 ++
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |   34 +++++++++++++++++++++++++++++-----
 net/bluetooth/l2cap_core.c    |   33 ++++++++++++++++++++++++++++-----
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 93967f1..6e88a80 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -23,6 +23,7 @@ struct amp_mgr {
 	struct list_head	list;
 	struct l2cap_conn	*l2cap_conn;
 	struct l2cap_chan	*a2mp_chan;
+	struct l2cap_chan	*bredr_chan;
 	struct kref		kref;
 	__u8			ident;
 	__u8			handle;
@@ -135,6 +136,7 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0330894..3e2d4e6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -768,6 +768,7 @@ int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_conn_set_timer(struct l2cap_conn *conn, struct delayed_work *work,
 			  long timeout);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 42bce4a..c550589 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -629,7 +629,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.ready = l2cap_chan_no_ready,
 };
 
-static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
+static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 {
 	struct l2cap_chan *chan;
 	int err;
@@ -664,7 +664,10 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
 	chan->conf_state = 0;
 
-	l2cap_chan_add(conn, chan);
+	if (locked)
+		__l2cap_chan_add(conn, chan);
+	else
+		l2cap_chan_add(conn, chan);
 
 	chan->remote_mps = chan->omtu;
 	chan->mps = chan->omtu;
@@ -703,7 +706,7 @@ int amp_mgr_put(struct amp_mgr *mgr)
 	return kref_put(&mgr->kref, &amp_mgr_destroy);
 }
 
-static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
+static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn, bool locked)
 {
 	struct amp_mgr *mgr;
 	struct l2cap_chan *chan;
@@ -716,7 +719,7 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 
 	mgr->l2cap_conn = conn;
 
-	chan = a2mp_chan_open(conn);
+	chan = a2mp_chan_open(conn, locked);
 	if (!chan) {
 		kfree(mgr);
 		return NULL;
@@ -745,7 +748,7 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 {
 	struct amp_mgr *mgr;
 
-	mgr = amp_mgr_create(conn);
+	mgr = amp_mgr_create(conn, false);
 	if (!mgr) {
 		BT_ERR("Could not create AMP manager");
 		return NULL;
@@ -833,3 +836,24 @@ void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
 	amp_mgr_put(mgr);
 	kfree(rsp);
 }
+
+void a2mp_discover_amp(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct amp_mgr *mgr = conn->hcon->amp_mgr;
+	struct a2mp_discov_req req;
+
+	BT_DBG("chan %p conn %p mgr %p", chan, conn, mgr);
+
+	if (!mgr) {
+		mgr = amp_mgr_create(conn, true);
+		if (!mgr)
+			return;
+	}
+
+	mgr->bredr_chan = chan;
+
+	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
+	req.ext_feat = 0;
+	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b47c325..b33ce3c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -517,7 +517,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 }
 
-static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
@@ -1008,6 +1008,18 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
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
@@ -1034,6 +1046,16 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
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
@@ -1048,8 +1070,9 @@ static void l2cap_do_start(struct l2cap_chan *chan)
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
@@ -1145,7 +1168,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_send_conn_req(chan);
+			l2cap_choose_conn(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -5497,7 +5520,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				l2cap_send_conn_req(chan);
+				l2cap_choose_conn(chan);
 			} else {
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
-- 
1.7.9.5

