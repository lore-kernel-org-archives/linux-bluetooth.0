Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 05/20] Bluetooth: A2MP: AMP Manager basic functions
Date: Wed,  2 Nov 2011 16:02:33 +0200
Message-Id: <1320242568-372-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define AMP Manager and some basic functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   11 +++++++
 net/bluetooth/a2mp.c         |   60 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 7ead6a3..9827cec 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,6 +15,17 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+struct amp_mgr *get_amp_mgr_sk(struct sock *sk);
+struct amp_mgr *create_amp_mgr(struct l2cap_conn *conn);
+void remove_amp_mgr(struct amp_mgr *mgr);
+
+struct amp_mgr {
+	struct	list_head list;
+	struct	l2cap_conn *l2cap_conn;
+	struct	socket *a2mp_sock;
+	unsigned long	flags;
+};
+
 struct a2mp_cmd {
 	__u8	code;
 	__u8	ident;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 2fe0004..d505c77 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -13,6 +13,7 @@
 */
 
 #include <linux/workqueue.h>
+#include <linux/list.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -21,6 +22,9 @@
 
 static struct workqueue_struct *a2mp_workqueue;
 
+LIST_HEAD(amp_mgr_list);
+DEFINE_RWLOCK(amp_mgr_list_lock);
+
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 {
@@ -205,3 +209,59 @@ static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
 	}
 }
 
+/* AMP Manager functions */
+struct amp_mgr *get_amp_mgr_sk(struct sock *sk)
+{
+	struct amp_mgr *mgr;
+	struct amp_mgr *found = NULL;
+
+	read_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		if ((mgr->a2mp_sock) && (mgr->a2mp_sock->sk == sk)) {
+			found = mgr;
+			break;
+		}
+	}
+	read_unlock(&amp_mgr_list_lock);
+
+	return found;
+}
+
+void remove_amp_mgr(struct amp_mgr *mgr)
+{
+	BT_DBG("mgr %p", mgr);
+
+	write_lock(&amp_mgr_list_lock);
+	sock_release(mgr->a2mp_sock);
+	list_del(&mgr->list);
+	write_unlock(&amp_mgr_list_lock);
+
+	kfree(mgr);
+}
+
+struct amp_mgr *create_amp_mgr(struct l2cap_conn *conn)
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
+	write_lock(&amp_mgr_list_lock);
+	list_add(&(mgr->list), &amp_mgr_list);
+	write_unlock(&amp_mgr_list_lock);
+
+finished:
+	return mgr;
+}
-- 
1.7.4.1

