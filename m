Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Convert hci_cb_list to use RCU instead of rwlock
Date: Mon, 14 Jul 2014 16:52:30 +0300
Message-Id: <1405345950-7296-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI callback list (hci_cb_list) is most of the time used in a
read-only fashion. Converting it to use RCU instead of rwlock makes the
access to it more efficient.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 25 ++++++++++++-------------
 net/bluetooth/hci_core.c         | 10 +++-------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a26421ec7d99..3a35e9d219c3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -463,7 +463,6 @@ struct hci_conn_params {
 
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
-extern rwlock_t hci_cb_list_lock;
 
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
@@ -1085,12 +1084,12 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 
-	read_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
 	}
-	read_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
@@ -1106,24 +1105,24 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 
 	hci_proto_encrypt_cfm(conn, status, encrypt);
 
-	read_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
 	}
-	read_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
 
-	read_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
 	}
-	read_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
@@ -1131,12 +1130,12 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 {
 	struct hci_cb *cb;
 
-	read_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
 	}
-	read_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ae96cf9bef6d..a1f5ebc9197e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -48,7 +48,6 @@ LIST_HEAD(hci_dev_list);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
-DEFINE_RWLOCK(hci_cb_list_lock);
 
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
@@ -4359,9 +4358,7 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	write_lock(&hci_cb_list_lock);
-	list_add(&cb->list, &hci_cb_list);
-	write_unlock(&hci_cb_list_lock);
+	list_add_rcu(&cb->list, &hci_cb_list);
 
 	return 0;
 }
@@ -4371,9 +4368,8 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	write_lock(&hci_cb_list_lock);
-	list_del(&cb->list);
-	write_unlock(&hci_cb_list_lock);
+	list_del_rcu(&cb->list);
+	synchronize_rcu();
 
 	return 0;
 }
-- 
1.9.3

