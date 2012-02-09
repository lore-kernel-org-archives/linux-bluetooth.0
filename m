Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Add address type to mgmt_ev_auth_failed
Date: Thu,  9 Feb 2012 17:23:48 +0200
Message-Id: <1328801030-24274-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Authentication Failed mgmt event to match the
latest API specification by adding an address type to it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 include/net/bluetooth/mgmt.h     |    2 +-
 net/bluetooth/hci_event.c        |    6 ++++--
 net/bluetooth/mgmt.c             |    6 ++++--
 net/bluetooth/smp.c              |    5 ++++-
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 14a655f..ccb24a4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -980,7 +980,8 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					u8 link_type, u8 addr_type, u8 status);
 int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					u8 link_type, u8 addr_type, u8 status);
-int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
+int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+						u8 addr_type, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 92f85c8..17bbf8b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -388,7 +388,7 @@ struct mgmt_ev_user_passkey_request {
 
 #define MGMT_EV_AUTH_FAILED		0x0011
 struct mgmt_ev_auth_failed {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3bf3f4d..b0784ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1901,7 +1901,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sec_level = conn->pending_sec_level;
 		}
 	} else {
-		mgmt_auth_failed(hdev, &conn->dst, ev->status);
+		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
+								ev->status);
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
@@ -3166,7 +3167,8 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	 * event gets always produced as initiator and is also mapped to
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
-		mgmt_auth_failed(hdev, &conn->dst, ev->status);
+		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
+								ev->status);
 
 	hci_conn_put(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 413a0b9..5459198 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2841,11 +2841,13 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					status, MGMT_OP_USER_PASSKEY_NEG_REPLY);
 }
 
-int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
+int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+						u8 addr_type, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 589766d..f6a6d8b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -257,12 +257,15 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 
 static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 {
+	struct hci_conn *hcon = conn->hcon;
+
 	if (send)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 								&reason);
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
-	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
+	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
+						hcon->dst_type, reason);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
 		cancel_delayed_work_sync(&conn->security_timer);
-- 
1.7.9

