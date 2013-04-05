Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 10/18] Bluetooth: l2cap: introduce l2cap_conn ref-counting
Date: Fri,  5 Apr 2013 14:57:42 +0200
Message-Id: <1365166670-3271-11-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want to use l2cap_conn outside of l2cap_core.c, we need refcounting
for these objects. Otherwise, we cannot synchronize l2cap locks with
outside locks and end up with deadlocks.

Hence, introduce ref-counting for l2cap_conn objects. This doesn't affect
l2cap internals at all, as they use a direct synchronization.
We also keep a reference to the parent hci_conn for locking purposes as
l2cap_conn depends on this. This doesn't affect the connection itself but
only the lifetime of the (dead) object.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/l2cap.h |  4 ++++
 net/bluetooth/l2cap_core.c    | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index db6694f..73ac062 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -584,6 +584,7 @@ struct l2cap_conn {
 
 	struct list_head	chan_l;
 	struct mutex		chan_lock;
+	struct kref		ref;
 };
 
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
@@ -814,4 +815,7 @@ void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
 void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
+void l2cap_conn_get(struct l2cap_conn *conn);
+void l2cap_conn_put(struct l2cap_conn *conn);
+
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 175dd32..58af8d6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1486,7 +1486,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	}
 
 	hcon->l2cap_data = NULL;
-	kfree(conn);
+	conn->hchan = NULL;
+	l2cap_conn_put(conn);
 }
 
 static void security_timeout(struct work_struct *work)
@@ -1520,8 +1521,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 		return NULL;
 	}
 
+	kref_init(&conn->ref);
 	hcon->l2cap_data = conn;
 	conn->hcon = hcon;
+	hci_conn_get(conn->hcon);
 	conn->hchan = hchan;
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
@@ -1563,6 +1566,26 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	return conn;
 }
 
+static void l2cap_conn_free(struct kref *ref)
+{
+	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
+
+	hci_conn_put(conn->hcon);
+	kfree(conn);
+}
+
+void l2cap_conn_get(struct l2cap_conn *conn)
+{
+	kref_get(&conn->ref);
+}
+EXPORT_SYMBOL(l2cap_conn_get);
+
+void l2cap_conn_put(struct l2cap_conn *conn)
+{
+	kref_put(&conn->ref, l2cap_conn_free);
+}
+EXPORT_SYMBOL(l2cap_conn_put);
+
 /* ---- Socket interface ---- */
 
 /* Find socket with psm and source / destination bdaddr.
-- 
1.8.2

