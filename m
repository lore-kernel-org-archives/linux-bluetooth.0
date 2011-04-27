Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Add confirm_hint parameter to user confirmation requests
Date: Wed, 27 Apr 2011 16:04:37 -0700
Message-Id: <1303945480-25756-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

When accepting a pairing request which fulfills the SSP auto-accept
criteria we need to push the request all the way to the user for
confirmation. This patch adds a new hint to the user_confirm_request
management event so user space can know when to show a numeric
comparison dialog and when to show a simple yes/no confirmation dialog.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_event.c        |   16 ++++++++++++++--
 net/bluetooth/mgmt.c             |    4 +++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 09740c3..490b43b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -783,7 +783,8 @@ int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr);
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value);
+int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value,
+							u8 confirm_hint);
 int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
 								u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6b6ff92..8ea6b08 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -254,6 +254,7 @@ struct mgmt_ev_pin_code_request {
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
 struct mgmt_ev_user_confirm_request {
 	bdaddr_t bdaddr;
+	__u8 confirm_hint;
 	__le32 value;
 } __packed;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 12a9bb9..003d731 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2461,7 +2461,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
 	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
-	int loc_mitm, rem_mitm;
+	int loc_mitm, rem_mitm, confirm_hint = 0;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
@@ -2493,6 +2493,16 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	/* If no side requires MITM protection; auto-accept */
 	if ((!loc_mitm || conn->remote_cap == 0x03) &&
 				(!rem_mitm || conn->io_capability == 0x03)) {
+
+		/* If we're not the initiators request authorization to
+		 * proceed from user space (mgmt_user_confirm with
+		 * confirm_hint set to 1). */
+		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+			BT_DBG("Confirming auto-accept as acceptor");
+			confirm_hint = 1;
+			goto confirm;
+		}
+
 		BT_DBG("Auto-accept of user confirmation with %ums delay",
 						hdev->auto_accept_delay);
 
@@ -2507,7 +2517,9 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey);
+confirm:
+	mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey,
+								confirm_hint);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c304688..5ae581a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1920,13 +1920,15 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	return err;
 }
 
-int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value)
+int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value,
+							u8 confirm_hint)
 {
 	struct mgmt_ev_user_confirm_request ev;
 
 	BT_DBG("hci%u", index);
 
 	bacpy(&ev.bdaddr, bdaddr);
+	ev.confirm_hint = confirm_hint;
 	put_unaligned_le32(value, &ev.value);
 
 	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, index, &ev, sizeof(ev),
-- 
1.7.4.4

