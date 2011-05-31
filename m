Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 1/2] Bluetooth: Fix auth_complete_evt for legacy units
Date: Tue, 31 May 2011 15:49:25 +0200
Message-ID: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Legacy devices don't re-authenticate the link properly if a link key
already exists.  Thus, don't update sec_level for this case even if
hci_auth_complete_evt indicates success. Otherwise the sec_level will
not reflect a real security on the link.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |    2 ++
 net/bluetooth/hci_event.c        |   12 ++++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index af4b0ed..0ac820d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -322,6 +322,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
 /* ----- HCI Connections ----- */
 enum {
 	HCI_CONN_AUTH_PEND,
+	HCI_CONN_REAUTH_PEND,
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3163330..e675402 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -548,6 +548,8 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 							sizeof(cp), &cp);
+		if (conn->key_type != 0xff)
+			set_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
 	}
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c456f9c..82061db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1491,13 +1491,21 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
 		if (!ev->status) {
-			conn->link_mode |= HCI_LM_AUTH;
-			conn->sec_level = conn->pending_sec_level;
+			if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
+						test_bit(HCI_CONN_REAUTH_PEND,
+						&conn->pend)) {
+				BT_INFO("re-auth of legacy device is not"
+								"possible.");
+			} else {
+				conn->link_mode |= HCI_LM_AUTH;
+				conn->sec_level = conn->pending_sec_level;
+			}
 		} else {
 			mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
 		}
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
+		clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
 
 		if (conn->state == BT_CONFIG) {
 			if (!ev->status && hdev->ssp_mode > 0 &&
-- 
1.7.4.1

