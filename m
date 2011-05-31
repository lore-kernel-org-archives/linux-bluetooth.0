Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 2/2] Bluetooth: Refactor hci_auth_complete_evt function
Date: Tue, 31 May 2011 15:49:26 +0200
Message-ID: <1306849766-31540-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace if(conn) with if(!conn) checking to avoid too many nested statements

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/hci_event.c |   83 ++++++++++++++++++++++-----------------------
 1 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 82061db..0776c1d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1489,59 +1489,58 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-		if (!ev->status) {
-			if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
-						test_bit(HCI_CONN_REAUTH_PEND,
-						&conn->pend)) {
-				BT_INFO("re-auth of legacy device is not"
-								"possible.");
-			} else {
-				conn->link_mode |= HCI_LM_AUTH;
-				conn->sec_level = conn->pending_sec_level;
-			}
+	if (!conn)
+		goto unlock;
+
+	if (!ev->status) {
+		if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
+				test_bit(HCI_CONN_REAUTH_PEND,	&conn->pend)) {
+			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
-			mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
+			conn->link_mode |= HCI_LM_AUTH;
+			conn->sec_level = conn->pending_sec_level;
 		}
+	} else {
+		mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
+	}
 
-		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
-		clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
+	clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
+	clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
 
-		if (conn->state == BT_CONFIG) {
-			if (!ev->status && hdev->ssp_mode > 0 &&
-							conn->ssp_mode > 0) {
-				struct hci_cp_set_conn_encrypt cp;
-				cp.handle  = ev->handle;
-				cp.encrypt = 0x01;
-				hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
-							sizeof(cp), &cp);
-			} else {
-				conn->state = BT_CONNECTED;
-				hci_proto_connect_cfm(conn, ev->status);
-				hci_conn_put(conn);
-			}
+	if (conn->state == BT_CONFIG) {
+		if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
+			struct hci_cp_set_conn_encrypt cp;
+			cp.handle  = ev->handle;
+			cp.encrypt = 0x01;
+			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
+									&cp);
 		} else {
-			hci_auth_cfm(conn, ev->status);
-
-			hci_conn_hold(conn);
-			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+			conn->state = BT_CONNECTED;
+			hci_proto_connect_cfm(conn, ev->status);
 			hci_conn_put(conn);
 		}
+	} else {
+		hci_auth_cfm(conn, ev->status);
 
-		if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
-			if (!ev->status) {
-				struct hci_cp_set_conn_encrypt cp;
-				cp.handle  = ev->handle;
-				cp.encrypt = 0x01;
-				hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
-							sizeof(cp), &cp);
-			} else {
-				clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
-				hci_encrypt_cfm(conn, ev->status, 0x00);
-			}
+		hci_conn_hold(conn);
+		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+		hci_conn_put(conn);
+	}
+
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
+		if (!ev->status) {
+			struct hci_cp_set_conn_encrypt cp;
+			cp.handle  = ev->handle;
+			cp.encrypt = 0x01;
+			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
+									&cp);
+		} else {
+			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
+			hci_encrypt_cfm(conn, ev->status, 0x00);
 		}
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.4.1

