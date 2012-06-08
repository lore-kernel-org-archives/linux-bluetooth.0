Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH] Bluetooth: Report correct error codes on disconnect
Date: Fri,  8 Jun 2012 00:55:13 -0300
Message-Id: <1339127713-19325-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When sending LE start encryption command to the target device that hasn't
any long-term key, its controller will send a LE change event with status
0x06 (PIN or Key missing), as it is asynchronous event just sent after
the LE command status, the LE disconnect complete event was overwriting
this error code with its error code, thus user space was getting the
unexpected error code.

This patch fixes the exposing of error codes sent from LE change events
to user space on disconnect ones by setting them early in disc_reason so
that hci_disconn_complete_evt() function can decide which error code to
use by checking disc_reason at the lower layer. If the disc_reason is 0,
then hci_disconn_complete_evt() needs to use the event status instead.

Signed-off-by: Paulo Alcantara <paulo.alcantara@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    6 ++++++
 net/bluetooth/hci_event.c        |   13 +++++++++++--
 net/bluetooth/l2cap_core.c       |   10 ++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 20fd573..5d98ae0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -358,6 +358,7 @@ extern rwlock_t hci_cb_list_lock;
 extern int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 extern int l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
 extern int l2cap_disconn_ind(struct hci_conn *hcon);
+extern void l2cap_set_disconn_reason(struct hci_conn *hcon, u8 reason);
 extern int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 extern int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
 extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
@@ -781,6 +782,11 @@ static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 	return l2cap_disconn_ind(conn);
 }
 
+static inline void hci_set_disconn_reason(struct hci_conn *hconn, __u8 reason)
+{
+	l2cap_set_disconn_reason(hconn, reason);
+}
+
 static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
 	switch (conn->type) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 47656be..2c7e4a7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1915,9 +1915,17 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (ev->status == 0) {
+		__u8 reason;
+
 		if (conn->type == ACL_LINK && conn->flush_key)
 			hci_remove_link_key(hdev, &conn->dst);
-		hci_proto_disconn_cfm(conn, ev->reason);
+
+		reason = hci_proto_disconn_ind(conn);
+		if (reason)
+			hci_proto_disconn_cfm(conn, reason);
+		else
+			hci_proto_disconn_cfm(conn, ev->reason);
+
 		hci_conn_del(conn);
 	}
 
@@ -2054,7 +2062,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 		if (ev->status && conn->state == BT_CONNECTED) {
-			hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
+			hci_set_disconn_reason(conn, ev->status);
+			hci_acl_disconn(conn, ev->status);
 			hci_conn_put(conn);
 			goto unlock;
 		}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..f2d16e0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5335,6 +5335,16 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 	return conn->disc_reason;
 }
 
+void l2cap_set_disconn_reason(struct hci_conn *hcon, u8 reason)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
+
+	BT_DBG("hcon %p reason %d", hcon, reason);
+
+	if (conn)
+		conn->disc_reason = reason;
+}
+
 int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
-- 
1.7.10.2

