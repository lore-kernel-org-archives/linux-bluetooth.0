Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Defer SCO setup if mode change is pending
Date: Mon, 19 Jul 2010 11:06:16 -0700
Message-Id: <1279562776-12901-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_conn.c         |   32 ++++++++++++++++++++++++---
 net/bluetooth/hci_event.c        |   43 ++++++++++++++++---------------------
 3 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 350b3e6..8b28962 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -256,6 +256,7 @@ enum {
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
+	HCI_CONN_SCO_SETUP_PEND,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
@@ -336,6 +337,7 @@ void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
+void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e9fef83..0b1e460 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -155,6 +155,27 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
 
+/* Device _must_ be locked */
+void hci_sco_setup(struct hci_conn *conn, __u8 status)
+{
+	struct hci_conn *sco = conn->link;
+
+	BT_DBG("%p", conn);
+
+	if (!sco)
+		return;
+
+	if (!status) {
+		if (lmp_esco_capable(conn->hdev))
+			hci_setup_sync(sco, conn->handle);
+		else
+			hci_add_sco(sco, conn->handle);
+	} else {
+		hci_proto_connect_cfm(sco, status);
+		hci_conn_del(sco);
+	}
+}
+
 static void hci_conn_timeout(unsigned long arg)
 {
 	struct hci_conn *conn = (void *) arg;
@@ -385,10 +406,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->power_save = 1;
 		hci_conn_enter_active_mode(acl);
 
-		if (lmp_esco_capable(hdev))
-			hci_setup_sync(sco, acl->handle);
-		else
-			hci_add_sco(sco, acl->handle);
+		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
+			/* defer SCO setup until mode change completed */
+			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
+			return sco;
+		}
+
+		hci_sco_setup(acl, 0x00);
 	}
 
 	return sco;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2069c3b..461413c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -775,9 +775,6 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (!status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_SNIFF_MODE);
 	if (!cp)
 		return;
@@ -785,8 +782,13 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
-		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+	if (conn) {
+		if (status)
+			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+			hci_sco_setup(conn, status);
+	}
 
 	hci_dev_unlock(hdev);
 }
@@ -798,9 +800,6 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (!status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_EXIT_SNIFF_MODE);
 	if (!cp)
 		return;
@@ -808,8 +807,13 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
-		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+	if (conn) {
+		if (status)
+			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+			hci_sco_setup(conn, status);
+	}
 
 	hci_dev_unlock(hdev);
 }
@@ -915,20 +919,8 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	} else
 		conn->state = BT_CLOSED;
 
-	if (conn->type == ACL_LINK) {
-		struct hci_conn *sco = conn->link;
-		if (sco) {
-			if (!ev->status) {
-				if (lmp_esco_capable(hdev))
-					hci_setup_sync(sco, conn->handle);
-				else
-					hci_add_sco(sco, conn->handle);
-			} else {
-				hci_proto_connect_cfm(sco, ev->status);
-				hci_conn_del(sco);
-			}
-		}
-	}
+	if (conn->type == ACL_LINK)
+		hci_sco_setup(conn, ev->status);
 
 	if (ev->status) {
 		hci_proto_connect_cfm(conn, ev->status);
@@ -1481,6 +1473,9 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 			else
 				conn->power_save = 0;
 		}
+
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+			hci_sco_setup(conn, ev->status);
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.1.1

