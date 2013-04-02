Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 05/18] Bluetooth: introduce hci_conn ref-counting
Date: Tue,  2 Apr 2013 18:08:25 +0200
Message-Id: <1364918918-2336-6-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We currently do not allow using hci_conn from outside of HCI-core.
However, several other users could make great use of it. This includes
HIDP, rfcomm and all other sub-protocols that rely on an active
connection.

Hence, we now introduce hci_conn ref-counting. We currently never call
get_device(). put_device() is exclusively used in hci_conn_del_sysfs().
Hence, we currently never have a greater device-refcnt than 1.
Therefore, it is safe to remove the put_device() call from
hci_conn_del_sysfs() to hci_conn_del() (it's the only caller). In fact,
this even fixes a "use-after-free" bug as we access hci_conn after calling
hci_conn_del_sysfs() in hci_conn_del().

>From now on we can add references to hci_conn objects in other layers
(like l2cap_sock, HIDP, rfcomm, ...) and grab a reference via
hci_conn_get(). This does _not_ guarantee, that the connection is still
alive. However, this isn't what we want. We can simply lock the hci_conn
device and use "device_is_registered(hci_conn->dev)" to test that.
However, this is hardly necessary as outside users should never rely on
the HCI connection to be alive, anyway. Instead, they should solely rely
on the device-object to be available.
But if sub-devices want the hci_conn object as sysfs parent, they need to
be notified when the connection drops. This will be introduced in later
patches with hci_conn-users.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/hci_core.h | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |  3 +--
 net/bluetooth/hci_sysfs.c        |  1 -
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cd5b126..fa8fe72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -593,6 +593,37 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
+/*
+ * hci_conn_get() and hci_conn_put() are used to control the life-time of an
+ * "hci_conn" object. They do not guarantee that the hci_conn object is running,
+ * working or anything else. They just guarantee that the object is available
+ * and can be dereferenced. So you can use its locks, local variables and any
+ * other constant data.
+ * Before accessing runtime data, you _must_ lock the object and then check that
+ * it is still running. As soon as you release the locks, the connection might
+ * get dropped, though.
+ *
+ * On the other hand, hci_conn_hold() and hci_conn_drop() are used to control
+ * how long the underlying connection is held. So every channel that runs on the
+ * hci_conn object calls this to prevent the connection from disappearing. As
+ * long as you hold a device, you must also guarantee that you have a valid
+ * reference to the device via hci_conn_get() (or the initial reference from
+ * hci_conn_add()).
+ * The hold()/drop() ref-count is known to drop below 0 sometimes, which doesn't
+ * break because nobody cares for that. But this means, we cannot use
+ * _get()/_drop() in it, but require the caller to have a valid ref (FIXME).
+ */
+
+static inline void hci_conn_get(struct hci_conn *conn)
+{
+	get_device(&conn->dev);
+}
+
+static inline void hci_conn_put(struct hci_conn *conn)
+{
+	put_device(&conn->dev);
+}
+
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 134ab9f..75b75a8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -450,8 +450,7 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_dev_put(hdev);
 
-	if (conn->handle == 0)
-		kfree(conn);
+	hci_conn_put(conn);
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 55cceee..0384b76 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -145,7 +145,6 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 	}
 
 	device_del(&conn->dev);
-	put_device(&conn->dev);
 
 	hci_dev_put(hdev);
 }
-- 
1.8.2
