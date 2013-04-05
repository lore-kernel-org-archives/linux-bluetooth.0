Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 04/18] Bluetooth: remove unneeded hci_conn_hold/put_device()
Date: Fri,  5 Apr 2013 14:57:36 +0200
Message-Id: <1365166670-3271-5-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

hci_conn_hold/put_device() is used to control when hci_conn->dev is no
longer needed and can be deleted from the system. Lets first look how they
are currently used throughout the code (excluding HIDP!).

All code that uses hci_conn_hold_device() looks like this:
    ...
    hci_conn_hold_device();
    hci_conn_add_sysfs();
    ...
On the other side, hci_conn_put_device() is exclusively used in
hci_conn_del().

So, considering that hci_conn_del() must not be called twice (which would
fail horribly), we know that hci_conn_put_device() is only called _once_
(which is in hci_conn_del()).
On the other hand, hci_conn_add_sysfs() must not be called twice, either
(it would call device_add twice, which breaks the device, see
drivers/base/core.c). So we know that hci_conn_hold_device() is also
called only once (it's only called directly before hci_conn_add_sysfs()).

So hold and put are known to be called only once. That means we can safely
remove them and directly call hci_conn_del_sysfs() in hci_conn_del().

But there is one issue left: HIDP also uses hci_conn_hold/put_device().
However, this case can be ignored and simply removed as it is totally
broken. The issue is, the only thing HIDP delays with
hci_conn_hold_device() is the removal of the hci_conn->dev from sysfs.
But, the hci_conn device has no mechanism to get notified when its own
parent (hci_dev) gets removed from sysfs. hci_dev_hold/put() does _not_
control when it is removed but only when the device object is created
and destroyed.
And hci_dev calls hci_conn_flush_*() when it removes itself from sysfs,
which itself causes hci_conn_del() to be called, but it does _not_ cause
hci_conn_del_sysfs() to be called, which is wrong.

Hence, we fix it to call hci_conn_del_sysfs() in hci_conn_del(). This
guarantees that a hci_conn object is removed from sysfs _before_ its
parent hci_dev is removed.

The changes to HIDP look scary, wrong and broken. However, if you look at
the HIDP session management, you will notice they're already broken in the
exact _same_ way (ever tried "unplugging" HIDP devices? Breaks _all_ the
time).
So this patch only makes HIDP look _scary_ and _obviously broken_. It does
not break HIDP itself, it already is!

See later patches in this series which fix HIDP to use proper
session-management.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/hci_core.h |  4 ----
 net/bluetooth/hci_conn.c         | 17 +----------------
 net/bluetooth/hci_event.c        |  4 ----
 net/bluetooth/hidp/core.c        | 20 +++-----------------
 4 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2fde836..cd5b126 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -338,7 +338,6 @@ struct hci_conn {
 	struct timer_list auto_accept_timer;
 
 	struct device	dev;
-	atomic_t	devref;
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
@@ -594,9 +593,6 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
-void hci_conn_hold_device(struct hci_conn *conn);
-void hci_conn_put_device(struct hci_conn *conn);
-
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 319e7a4..134ab9f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -398,8 +398,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 
-	atomic_set(&conn->devref, 0);
-
 	hci_conn_init_sysfs(conn);
 
 	return conn;
@@ -448,7 +446,7 @@ int hci_conn_del(struct hci_conn *conn)
 
 	skb_queue_purge(&conn->data_q);
 
-	hci_conn_put_device(conn);
+	hci_conn_del_sysfs(conn);
 
 	hci_dev_put(hdev);
 
@@ -835,19 +833,6 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
-void hci_conn_hold_device(struct hci_conn *conn)
-{
-	atomic_inc(&conn->devref);
-}
-EXPORT_SYMBOL(hci_conn_hold_device);
-
-void hci_conn_put_device(struct hci_conn *conn)
-{
-	if (atomic_dec_and_test(&conn->devref))
-		hci_conn_del_sysfs(conn);
-}
-EXPORT_SYMBOL(hci_conn_put_device);
-
 int hci_get_conn_list(void __user *arg)
 {
 	struct hci_conn *c;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 11df1c4..d089f5e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2000,7 +2000,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else
 			conn->state = BT_CONNECTED;
 
-		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
 
 		if (test_bit(HCI_AUTH, &hdev->flags))
@@ -3302,7 +3301,6 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		conn->handle = __le16_to_cpu(ev->handle);
 		conn->state  = BT_CONNECTED;
 
-		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
 		break;
 
@@ -3779,7 +3777,6 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(hcon);
 
-	hci_conn_hold_device(hcon);
 	hci_conn_add_sysfs(hcon);
 
 	amp_physical_cfm(bredr_hcon, hcon);
@@ -3913,7 +3910,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
-	hci_conn_hold_device(conn);
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index c547b55..f8144fe 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -73,18 +73,6 @@ static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 	return NULL;
 }
 
-static void __hidp_link_session(struct hidp_session *session)
-{
-	list_add(&session->list, &hidp_session_list);
-}
-
-static void __hidp_unlink_session(struct hidp_session *session)
-{
-	hci_conn_put_device(session->conn);
-
-	list_del(&session->list);
-}
-
 static void __hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
 {
 	memset(ci, 0, sizeof(*ci));
@@ -756,7 +744,7 @@ static int hidp_session(void *arg)
 
 	fput(session->ctrl_sock->file);
 
-	__hidp_unlink_session(session);
+	list_del(&session->list);
 
 	up_write(&hidp_session_sem);
 
@@ -779,8 +767,6 @@ static struct hci_conn *hidp_get_connection(struct hidp_session *session)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (conn)
-		hci_conn_hold_device(conn);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
@@ -1022,7 +1008,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	session->flags   = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
 	session->idle_to = req->idle_to;
 
-	__hidp_link_session(session);
+	list_add(&session->list, &hidp_session_list);
 
 	if (req->rd_size > 0) {
 		err = hidp_setup_hid(session, req);
@@ -1102,7 +1088,7 @@ unlink:
 	session->rd_data = NULL;
 
 purge:
-	__hidp_unlink_session(session);
+	list_del(&session->list);
 
 	skb_queue_purge(&session->ctrl_transmit);
 	skb_queue_purge(&session->intr_transmit);
-- 
1.8.2
