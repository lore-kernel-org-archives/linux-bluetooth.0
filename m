Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 14/26] Bluetooth: A2MP: Create A2MP workqueue
Date: Fri, 17 Aug 2012 17:33:09 +0300
Message-Id: <1345214001-7053-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Workqueue might be used for A2MP tasks which cannot be run from
L2CAP of HCI code due to unsafe locking scenarios. For example in
l2cap_security_cfm and l2cap_conn_start we need to discover and
create amp manager from the code surrounded with &conn->chan_lock
and &chan->lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    2 ++
 net/bluetooth/a2mp.c         |   38 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c   |    6 ++++++
 3 files changed, 46 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 8ba236c..345fbc6 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -129,5 +129,7 @@ int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+int a2mp_init(void);
+void a2mp_exit(void);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6f719d3..26a225b 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -19,6 +19,8 @@
 #include <net/bluetooth/amp.h>
 #include <net/bluetooth/pal.h>
 
+static struct workqueue_struct *amp_workqueue;
+
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 {
@@ -767,3 +769,39 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 
 	return mgr->a2mp_chan;
 }
+
+void l2cap_discover_amp(struct l2cap_chan *chan)
+{
+	struct a2mp_discov_req req;
+	struct l2cap_conn *conn = chan->conn;
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
+	mgr->bredr_chan = chan;
+
+	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
+	req.ext_feat = 0;
+	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
+}
+
+int a2mp_init(void)
+{
+	amp_workqueue = create_singlethread_workqueue("a2mp");
+	if (!amp_workqueue)
+		return -EPERM;
+
+	return 0;
+}
+
+void a2mp_exit(void)
+{
+	flush_workqueue(amp_workqueue);
+	destroy_workqueue(amp_workqueue);
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4dbbb79..d4e99d6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5730,11 +5730,17 @@ int __init l2cap_init(void)
 			BT_ERR("Failed to create L2CAP debug file");
 	}
 
+	if (enable_hs)
+		return a2mp_init();
+
 	return 0;
 }
 
 void l2cap_exit(void)
 {
+	if (enable_hs)
+		a2mp_exit();
+
 	debugfs_remove(l2cap_debugfs);
 	l2cap_cleanup_sockets();
 }
-- 
1.7.9.5

