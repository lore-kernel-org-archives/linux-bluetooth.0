Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Denys Vlasenko <dvlasenk@redhat.com>
To: Johan Hedberg <johan.hedberg@intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Deinline large functions
Date: Mon, 11 Apr 2016 20:34:25 +0200
Message-Id: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
It is way off from being CPU limited, no need to squeeze
last few cycles by excessive inlining.

This patch delinlines the following functions:

hci_conn_hash_lookup_handle: 345 bytes, 39 calls
hci_conn_hash_lookup_ba: 372 bytes, 36 calls
hci_conn_hash_lookup_le: 382 bytes, 8 calls
hci_conn_hash_lookup_state: 356 bytes, 3 calls
hci_lookup_le_connect: 378 bytes, 7 calls
hci_conn_drop: 186 bytes, 30 calls
hci_connect_cfm: 121 bytes, 15 calls
hci_disconn_cfm: 121 bytes, 2 calls
hci_auth_cfm: 156 bytes, 2 calls
hci_encrypt_cfm: 156 bytes, 3 calls

Size reduction is about 40k:

    text     data      bss       dec     hex filename
95943139 20860256 35991552 152794947 91b7743 vmlinux_before
95903714 20860256 35991552 152755522 91add42 vmlinux

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Johan Hedberg <johan.hedberg@intel.com>
CC: linux-bluetooth@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
Changes since v1: added EXPORT_SYMBOL's

 include/net/bluetooth/hci_core.h | 219 +++------------------------------------
 net/bluetooth/hci_core.c         | 213 +++++++++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 203 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4f82ed..0cd798e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,108 +761,20 @@ static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 	return type;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
-								__u16 handle)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->handle == handle) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-	rcu_read_unlock();
-
-	return NULL;
-}
-
-static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
-							__u8 type, bdaddr_t *ba)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == type && !bacmp(&c->dst, ba)) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
-static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
-						       bdaddr_t *ba,
-						       __u8 ba_type)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
+struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
+						__u16 handle);
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != LE_LINK)
-		       continue;
-
-		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
-static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
-							__u8 type, __u16 state)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == type && c->state == state) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
-static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
+struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
+						__u8 type, bdaddr_t *ba);
 
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == LE_LINK && c->state == BT_CONNECT &&
-		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
+struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
+						bdaddr_t *ba,
+						__u8 ba_type);
 
-	rcu_read_unlock();
+struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
+						__u8 type, __u16 state);
 
-	return NULL;
-}
+struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev);
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
@@ -939,40 +851,7 @@ static inline void hci_conn_hold(struct hci_conn *conn)
 	cancel_delayed_work(&conn->disc_work);
 }
 
-static inline void hci_conn_drop(struct hci_conn *conn)
-{
-	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
-
-	if (atomic_dec_and_test(&conn->refcnt)) {
-		unsigned long timeo;
-
-		switch (conn->type) {
-		case ACL_LINK:
-		case LE_LINK:
-			cancel_delayed_work(&conn->idle_work);
-			if (conn->state == BT_CONNECTED) {
-				timeo = conn->disc_timeout;
-				if (!conn->out)
-					timeo *= 2;
-			} else {
-				timeo = 0;
-			}
-			break;
-
-		case AMP_LINK:
-			timeo = conn->disc_timeout;
-			break;
-
-		default:
-			timeo = 0;
-			break;
-		}
-
-		cancel_delayed_work(&conn->disc_work);
-		queue_delayed_work(conn->hdev->workqueue,
-				   &conn->disc_work, timeo);
-	}
-}
+void hci_conn_drop(struct hci_conn *conn);
 
 /* ----- HCI Devices ----- */
 static inline void hci_dev_put(struct hci_dev *d)
@@ -1186,78 +1065,12 @@ struct hci_cb {
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
-static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
-{
-	struct hci_cb *cb;
-
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->connect_cfm)
-			cb->connect_cfm(conn, status);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->connect_cfm_cb)
-		conn->connect_cfm_cb(conn, status);
-}
-
-static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
-{
-	struct hci_cb *cb;
-
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->disconn_cfm)
-			cb->disconn_cfm(conn, reason);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->disconn_cfm_cb)
-		conn->disconn_cfm_cb(conn, reason);
-}
-
-static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
-{
-	struct hci_cb *cb;
-	__u8 encrypt;
-
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-		return;
-
-	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
-
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
-
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
-								__u8 encrypt)
-{
-	struct hci_cb *cb;
-
-	if (conn->sec_level == BT_SECURITY_SDP)
-		conn->sec_level = BT_SECURITY_LOW;
+void hci_connect_cfm(struct hci_conn *conn, __u8 status);
+void hci_disconn_cfm(struct hci_conn *conn, __u8 reason);
 
-	if (conn->pending_sec_level > conn->sec_level)
-		conn->sec_level = conn->pending_sec_level;
-
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
+void hci_auth_cfm(struct hci_conn *conn, __u8 status);
+void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
+						__u8 encrypt);
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 883c821..a933ceb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -56,6 +56,219 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
+struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
+						__u16 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->handle == handle) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
+						__u8 type, bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+EXPORT_SYMBOL(hci_conn_hash_lookup_ba);
+
+struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
+						bdaddr_t *ba,
+						__u8 ba_type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != LE_LINK)
+		       continue;
+
+		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+EXPORT_SYMBOL(hci_conn_hash_lookup_le);
+
+struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
+						__u8 type, __u16 state)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->state == state) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == LE_LINK && c->state == BT_CONNECT &&
+		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+void hci_conn_drop(struct hci_conn *conn)
+{
+	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
+
+	if (atomic_dec_and_test(&conn->refcnt)) {
+		unsigned long timeo;
+
+		switch (conn->type) {
+		case ACL_LINK:
+		case LE_LINK:
+			cancel_delayed_work(&conn->idle_work);
+			if (conn->state == BT_CONNECTED) {
+				timeo = conn->disc_timeout;
+				if (!conn->out)
+					timeo *= 2;
+			} else {
+				timeo = 0;
+			}
+			break;
+
+		case AMP_LINK:
+			timeo = conn->disc_timeout;
+			break;
+
+		default:
+			timeo = 0;
+			break;
+		}
+
+		cancel_delayed_work(&conn->disc_work);
+		queue_delayed_work(conn->hdev->workqueue,
+				   &conn->disc_work, timeo);
+	}
+}
+
+void hci_connect_cfm(struct hci_conn *conn, __u8 status)
+{
+	struct hci_cb *cb;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->connect_cfm)
+			cb->connect_cfm(conn, status);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->connect_cfm_cb)
+		conn->connect_cfm_cb(conn, status);
+}
+
+void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
+{
+	struct hci_cb *cb;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->disconn_cfm)
+			cb->disconn_cfm(conn, reason);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->disconn_cfm_cb)
+		conn->disconn_cfm_cb(conn, reason);
+}
+
+void hci_auth_cfm(struct hci_conn *conn, __u8 status)
+{
+	struct hci_cb *cb;
+	__u8 encrypt;
+
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
+		return;
+
+	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
+}
+
+void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
+						__u8 encrypt)
+{
+	struct hci_cb *cb;
+
+	if (conn->sec_level == BT_SECURITY_SDP)
+		conn->sec_level = BT_SECURITY_LOW;
+
+	if (conn->pending_sec_level > conn->sec_level)
+		conn->sec_level = conn->pending_sec_level;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
+}
+
 /* ---- HCI debugfs entries ---- */
 
 static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
-- 
1.8.1.4
