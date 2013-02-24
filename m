Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 12/16] Bluetooth: add hci_conn_user sub-modules
Date: Sun, 24 Feb 2013 19:37:02 +0100
Message-Id: <1361731026-7428-13-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Several sub-modules like HIDP, rfcomm, ... need to track HCI connections.
The hci_conn->dev object is used as parent for sysfs devices so the
sub-modules need to be notified when the hci_conn object is removed from
sysfs.

This patch introduces hci_conn_user objects which contain a "probe" and
"remove" callback. You can register these on any hci_conn object and if it
is active, the "probe" callback will get called. Otherwise, an error is
returned.

The hci_conn object will call your "remove" callback directly before it is
removed from user-space. This allows you to remove your submodules
_before_ the hci_conn object is removed.

At any time you can asynchronously unregister your hci_conn_user object if
your submodule vanishes before the hci_conn object does.

There is no way around hci_conn_user. If we want wire-protocols in the
kernel, we always want the hci_conn object as parent in the sysfs tree. We
cannot use a channel here since we might need multiple channels for a
single protocol.
But the problem is, we _must_ get notified when an hci_conn object is
removed. We cannot use reference-counting for object-removal! This is not
how it works. If a hardware is removed, we should immediately remove the
object from sysfs. Any other behavior would be inconsistent with the rest
of the system. Also note that device_del() might sleep, but it doesn't
wait for user-space or block very long. It only _unlinks_ the object from
sysfs and the whole device-tree. Everything else is handled by ref-counts!
This is exactly what the other sub-modules must do: unlink their devices
when the "remove" hci_conn_user callback is called. They should not do any
cleanup or synchronous shutdowns.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/hci_core.h | 11 +++++++
 net/bluetooth/hci_conn.c         | 66 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa8fe72..3779568 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -296,6 +296,7 @@ struct hci_conn {
 	struct list_head list;
 
 	atomic_t	refcnt;
+	struct list_head users;
 
 	bdaddr_t	dst;
 	__u8		dst_type;
@@ -352,6 +353,12 @@ struct hci_conn {
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
 };
 
+struct hci_conn_user {
+	struct list_head list;
+	int (*probe) (struct hci_conn *conn, struct hci_conn_user *user);
+	void (*remove) (struct hci_conn *conn, struct hci_conn_user *user);
+};
+
 struct hci_chan {
 	struct list_head list;
 	__u16 handle;
@@ -593,6 +600,10 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
+int hci_conn_register_user(struct hci_conn *conn, struct hci_conn_user *user);
+void hci_conn_unregister_user(struct hci_conn *conn,
+			      struct hci_conn_user *user);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 75b75a8..5ba5e29 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -342,6 +342,70 @@ static void hci_conn_auto_accept(unsigned long arg)
 		     &conn->dst);
 }
 
+int hci_conn_register_user(struct hci_conn *conn, struct hci_conn_user *user)
+{
+	struct hci_dev *hdev = conn->hdev;
+	int ret;
+
+	hci_dev_lock(hdev);
+
+	if (user->list.next || user->list.prev) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (!device_is_registered(&conn->dev)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	ret = user->probe(conn, user);
+	if (ret)
+		goto out_unlock;
+
+	list_add(&user->list, &conn->users);
+	ret = 0;
+
+out_unlock:
+	hci_dev_unlock(hdev);
+	return ret;
+}
+EXPORT_SYMBOL(hci_conn_register_user);
+
+void hci_conn_unregister_user(struct hci_conn *conn,
+			      struct hci_conn_user *user)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	hci_dev_lock(hdev);
+
+	if (!user->list.next || !user->list.prev)
+		goto out_unlock;
+
+	list_del(&user->list);
+	user->list.next = NULL;
+	user->list.prev = NULL;
+	user->remove(conn, user);
+
+out_unlock:
+	hci_dev_unlock(hdev);
+}
+EXPORT_SYMBOL(hci_conn_unregister_user);
+
+static void hci_conn_unregister_all_users(struct hci_conn *conn)
+{
+	struct hci_conn_user *user;
+
+	while (!list_empty(&conn->users)) {
+		user = list_first_entry(&conn->users, struct hci_conn_user,
+					list);
+		list_del(&user->list);
+		user->list.next = NULL;
+		user->list.prev = NULL;
+		user->remove(conn, user);
+	}
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
@@ -384,6 +448,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	skb_queue_head_init(&conn->data_q);
 
 	INIT_LIST_HEAD(&conn->chan_list);
+	INIT_LIST_HEAD(&conn->users);
 
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
@@ -446,6 +511,7 @@ int hci_conn_del(struct hci_conn *conn)
 
 	skb_queue_purge(&conn->data_q);
 
+	hci_conn_unregister_all_users(conn);
 	hci_conn_del_sysfs(conn);
 
 	hci_dev_put(hdev);
-- 
1.8.1.4
