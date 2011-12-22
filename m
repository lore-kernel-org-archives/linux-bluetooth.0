Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 03/20] Bluetooth: A2MP: AMP Manager basic functions
Date: Thu, 22 Dec 2011 13:06:09 +0200
Message-Id: <1324551986-29431-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define AMP Manager and some basic functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   12 ++++++
 net/bluetooth/a2mp.c         |   79 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 97a0752..ee42c86 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -17,4 +17,16 @@
 
 void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb);
 
+struct amp_mgr {
+	struct list_head	list;
+	struct l2cap_conn	*l2cap_conn;
+	struct socket		*a2mp_sock;
+	struct kref		kref;
+	__u8			ident;
+	unsigned long		flags;
+};
+
+void amp_mgr_get(struct amp_mgr *mgr);
+int amp_mgr_put(struct amp_mgr *mgr);
+
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 87ff996..aa1fc95 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,11 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+static struct amp_mgr *get_amp_mgr_sk(struct sock *sk);
+
+LIST_HEAD(amp_mgr_list);
+DEFINE_MUTEX(amp_mgr_list_lock);
+
 static void a2mp_data_ready(struct sock *sk, int bytes)
 {
 	struct sk_buff *skb;
@@ -111,3 +116,77 @@ static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
 		return NULL;
 	}
 }
+
+/* AMP Manager functions */
+void amp_mgr_get(struct amp_mgr *mgr)
+{
+	kref_get(&mgr->kref);
+}
+
+static void amp_mgr_destroy(struct kref *kref)
+{
+	struct amp_mgr *mgr;
+	mgr = container_of(kref, struct amp_mgr, kref);
+
+	BT_DBG("Destroy amp_mgr %p", mgr);
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_del(&mgr->list);
+	mutex_unlock(&amp_mgr_list_lock);
+
+	sock_release(mgr->a2mp_sock);
+
+	kfree(mgr);
+}
+
+int amp_mgr_put(struct amp_mgr *mgr)
+{
+	return kref_put(&mgr->kref, &amp_mgr_destroy);
+}
+
+static struct amp_mgr *get_amp_mgr_sk(struct sock *sk)
+{
+	struct amp_mgr *mgr;
+	struct amp_mgr *found = NULL;
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		if ((mgr->a2mp_sock) && (mgr->a2mp_sock->sk == sk)) {
+			found = mgr;
+			amp_mgr_get(mgr);
+			break;
+		}
+	}
+	mutex_unlock(&amp_mgr_list_lock);
+
+	return found;
+}
+
+struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
+{
+	struct amp_mgr *mgr;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		goto finished;
+
+	BT_DBG("conn %p mgr %p", conn, mgr);
+
+	mgr->l2cap_conn = conn;
+
+	mgr->a2mp_sock = open_a2mp_sock(conn);
+	if (!mgr->a2mp_sock) {
+		kfree(mgr);
+		mgr = NULL;
+		goto finished;
+	}
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_add(&(mgr->list), &amp_mgr_list);
+	mutex_unlock(&amp_mgr_list_lock);
+
+	kref_init(&mgr->kref);
+
+finished:
+	return mgr;
+}
-- 
1.7.4.1

