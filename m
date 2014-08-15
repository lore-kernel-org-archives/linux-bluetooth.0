Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Improve *_get() functions to return the object type
Date: Fri, 15 Aug 2014 18:23:05 +0300
Message-Id: <1408116185-18497-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's natural to have *_get() functions that increment the reference
count of an object to return the object type itself. This way it's
simple to make a copy of the object pointer and increase the reference
count in a single step. This patch updates two such get() functions,
namely hci_conn_get() and l2cap_conn_get(), and updates the users to
take advantage of the new API.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 include/net/bluetooth/l2cap.h    |  2 +-
 net/bluetooth/hidp/core.c        | 10 ++++------
 net/bluetooth/l2cap_core.c       |  6 +++---
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b0ded1333865..aa75eee8ad7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -756,9 +756,10 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status);
  * _get()/_drop() in it, but require the caller to have a valid ref (FIXME).
  */
 
-static inline void hci_conn_get(struct hci_conn *conn)
+static inline struct hci_conn *hci_conn_get(struct hci_conn *conn)
 {
 	get_device(&conn->dev);
+	return conn;
 }
 
 static inline void hci_conn_put(struct hci_conn *conn)
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1558eccb19db..8f1652ed3326 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -948,7 +948,7 @@ void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
 void l2cap_conn_shutdown(struct l2cap_conn *conn, int err);
-void l2cap_conn_get(struct l2cap_conn *conn);
+struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
 void l2cap_conn_put(struct l2cap_conn *conn);
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 6c7ecf116e74..1b7d605706aa 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -915,7 +915,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
 
 	/* connection management */
 	bacpy(&session->bdaddr, bdaddr);
-	session->conn = conn;
+	session->conn = l2cap_conn_get(conn);
 	session->user.probe = hidp_session_probe;
 	session->user.remove = hidp_session_remove;
 	session->ctrl_sock = ctrl_sock;
@@ -941,13 +941,13 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
 	if (ret)
 		goto err_free;
 
-	l2cap_conn_get(session->conn);
 	get_file(session->intr_sock->file);
 	get_file(session->ctrl_sock->file);
 	*out = session;
 	return 0;
 
 err_free:
+	l2cap_conn_put(session->conn);
 	kfree(session);
 	return ret;
 }
@@ -1327,10 +1327,8 @@ int hidp_connection_add(struct hidp_connadd_req *req,
 
 	conn = NULL;
 	l2cap_chan_lock(chan);
-	if (chan->conn) {
-		l2cap_conn_get(chan->conn);
-		conn = chan->conn;
-	}
+	if (chan->conn)
+		conn = l2cap_conn_get(chan->conn);
 	l2cap_chan_unlock(chan);
 
 	if (!conn)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a6559225bb50..cb36169ef300 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1695,9 +1695,10 @@ static void l2cap_conn_free(struct kref *ref)
 	kfree(conn);
 }
 
-void l2cap_conn_get(struct l2cap_conn *conn)
+struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn)
 {
 	kref_get(&conn->ref);
+	return conn;
 }
 EXPORT_SYMBOL(l2cap_conn_get);
 
@@ -6908,8 +6909,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	kref_init(&conn->ref);
 	hcon->l2cap_data = conn;
-	conn->hcon = hcon;
-	hci_conn_get(conn->hcon);
+	conn->hcon = hci_conn_get(hcon);
 	conn->hchan = hchan;
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
-- 
1.9.3

