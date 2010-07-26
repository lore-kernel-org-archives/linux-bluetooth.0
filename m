Return-Path: <cyrus@holtmann.org>
From: Ron Shaffer <rshaffer@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Ron Shaffer <rshaffer@codeaurora.org>
Subject: [PATCH v3] Bluetooth: Defer SCO setup if mode change is pending
Date: Mon, 26 Jul 2010 10:06:00 -0400
Message-Id: <1280153160-7166-1-git-send-email-rshaffer@codeaurora.org>
In-Reply-To: <1280083316.2621.24.camel@localhost.localdomain>
References: <1280083316.2621.24.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

Certain headsets such as the Motorola H350 will reject SCO and eSCO
connection requests while the ACL is transitioning from sniff mode
to active mode. Add synchronization so that SCO and eSCO connection
requests will wait until the ACL has fully transitioned to active mode.

< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
< HCI Command:  Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x00 interval 0
    Mode: Active
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x10 handle 14 bdaddr 00:1A:0E:50:28:A4 type SCO
    Error: Connection Accept Timeout Exceeded

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |   32 ++++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c        |   33 +++++++++++++++++----------------
 3 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e42f6ed..edf3dfe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -250,6 +250,7 @@ enum {
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
+	HCI_CONN_SCO_SETUP_PEND,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
@@ -330,6 +331,7 @@ void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
+void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b10e3cd..805a22c 100644
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
@@ -380,10 +401,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
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
index 6c57fc7..4fda049 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -785,9 +785,14 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
+	if (conn) {
 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
 
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND,
+				&conn->pend))
+			hci_sco_setup(conn, status);
+	}
+
 	hci_dev_unlock(hdev);
 }
 
@@ -808,9 +813,14 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
+	if (conn) {
 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
 
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND,
+				&conn->pend))
+			hci_sco_setup(conn, status);
+	}
+
 	hci_dev_unlock(hdev);
 }
 
@@ -915,20 +925,8 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
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
@@ -1479,6 +1477,9 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 			else
 				conn->power_save = 0;
 		}
+
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+			hci_sco_setup(conn, ev->status);
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.0.2
--
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
