Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 09/12] Bluetooth: remove *_bh usage from hci_dev_list and hci_cb_list
Date: Thu, 22 Dec 2011 16:56:10 -0200
Message-Id: <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

They don't need to disable interruption anymore, we only run in interrupt
context now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |   16 ++++++++--------
 net/bluetooth/hci_conn.c         |    4 ++--
 net/bluetooth/hci_core.c         |   24 ++++++++++++------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 37d7cb8..5e2e984 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -801,13 +801,13 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
 
-	read_lock_bh(&hci_cb_list_lock);
+	read_lock(&hci_cb_list_lock);
 	list_for_each(p, &hci_cb_list) {
 		struct hci_cb *cb = list_entry(p, struct hci_cb, list);
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
 	}
-	read_unlock_bh(&hci_cb_list_lock);
+	read_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
@@ -823,26 +823,26 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 
 	hci_proto_encrypt_cfm(conn, status, encrypt);
 
-	read_lock_bh(&hci_cb_list_lock);
+	read_lock(&hci_cb_list_lock);
 	list_for_each(p, &hci_cb_list) {
 		struct hci_cb *cb = list_entry(p, struct hci_cb, list);
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
 	}
-	read_unlock_bh(&hci_cb_list_lock);
+	read_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct list_head *p;
 
-	read_lock_bh(&hci_cb_list_lock);
+	read_lock(&hci_cb_list_lock);
 	list_for_each(p, &hci_cb_list) {
 		struct hci_cb *cb = list_entry(p, struct hci_cb, list);
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
 	}
-	read_unlock_bh(&hci_cb_list_lock);
+	read_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
@@ -850,13 +850,13 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 {
 	struct list_head *p;
 
-	read_lock_bh(&hci_cb_list_lock);
+	read_lock(&hci_cb_list_lock);
 	list_for_each(p, &hci_cb_list) {
 		struct hci_cb *cb = list_entry(p, struct hci_cb, list);
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
 	}
-	read_unlock_bh(&hci_cb_list_lock);
+	read_unlock(&hci_cb_list_lock);
 }
 
 int hci_register_cb(struct hci_cb *hcb);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 401d8ea..3db4324 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -487,7 +487,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
-	read_lock_bh(&hci_dev_list_lock);
+	read_lock(&hci_dev_list_lock);
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) || test_bit(HCI_RAW, &d->flags))
@@ -512,7 +512,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	if (hdev)
 		hdev = hci_dev_hold(hdev);
 
-	read_unlock_bh(&hci_dev_list_lock);
+	read_unlock(&hci_dev_list_lock);
 	return hdev;
 }
 EXPORT_SYMBOL(hci_get_route);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 22c8331..4f0ff01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -844,7 +844,7 @@ int hci_get_dev_list(void __user *arg)
 
 	dr = dl->dev_req;
 
-	read_lock_bh(&hci_dev_list_lock);
+	read_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
 			cancel_delayed_work(&hdev->power_off);
@@ -858,7 +858,7 @@ int hci_get_dev_list(void __user *arg)
 		if (++n >= dev_num)
 			break;
 	}
-	read_unlock_bh(&hci_dev_list_lock);
+	read_unlock(&hci_dev_list_lock);
 
 	dl->dev_num = n;
 	size = sizeof(*dl) + n * sizeof(*dr);
@@ -1458,7 +1458,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	 */
 	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
 
-	write_lock_bh(&hci_dev_list_lock);
+	write_lock(&hci_dev_list_lock);
 
 	/* Find first available device id */
 	list_for_each(p, &hci_dev_list) {
@@ -1528,7 +1528,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
-	write_unlock_bh(&hci_dev_list_lock);
+	write_unlock(&hci_dev_list_lock);
 
 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
 							WQ_MEM_RECLAIM, 1);
@@ -1561,9 +1561,9 @@ int hci_register_dev(struct hci_dev *hdev)
 err_wqueue:
 	destroy_workqueue(hdev->workqueue);
 err:
-	write_lock_bh(&hci_dev_list_lock);
+	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
-	write_unlock_bh(&hci_dev_list_lock);
+	write_unlock(&hci_dev_list_lock);
 
 	return error;
 }
@@ -1576,9 +1576,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	write_lock_bh(&hci_dev_list_lock);
+	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
-	write_unlock_bh(&hci_dev_list_lock);
+	write_unlock(&hci_dev_list_lock);
 
 	hci_dev_do_close(hdev);
 
@@ -1830,9 +1830,9 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	write_lock_bh(&hci_cb_list_lock);
+	write_lock(&hci_cb_list_lock);
 	list_add(&cb->list, &hci_cb_list);
-	write_unlock_bh(&hci_cb_list_lock);
+	write_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
@@ -1842,9 +1842,9 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	write_lock_bh(&hci_cb_list_lock);
+	write_lock(&hci_cb_list_lock);
 	list_del(&cb->list);
-	write_unlock_bh(&hci_cb_list_lock);
+	write_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
-- 
1.7.6.4

