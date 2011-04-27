Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Add automated SSP user confirmation responses
Date: Wed, 27 Apr 2011 16:04:34 -0700
Message-Id: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds automated negative and positive (auto-accept) responses
for Secure Simple Pairing user confirmation requests. The responses are
only sent if the HCI_MGMT flag is set in order not to confuse older user
space versions (without management interface support).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3c90736..038d70d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2447,14 +2447,47 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
 	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
+	int loc_mitm, rem_mitm;
+	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey);
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		goto unlock;
 
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (!conn)
+		goto unlock;
+
+	loc_mitm = (conn->auth_type & 0x01);
+	rem_mitm = (conn->remote_auth & 0x01);
+
+	/* If we require MITM but the remote device can't provide that
+	 * (it has NoInputNoOutput) then reject the confirmation
+	 * request. The only exception is when we're dedicated bonding
+	 * initiators (connect_cfm_cb set) since then we always have the MITM
+	 * bit set. */
+	if (!conn->connect_cfm_cb && loc_mitm && conn->remote_cap == 0x03) {
+		BT_DBG("Rejecting request: remote device can't provide MITM");
+		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
+					sizeof(ev->bdaddr), &ev->bdaddr);
+		goto unlock;
+	}
+
+	/* If no side requires MITM protection; auto-accept */
+	if ((!loc_mitm || conn->remote_cap == 0x03) &&
+				(!rem_mitm || conn->io_capability == 0x03)) {
+		BT_DBG("Auto-accept of user confirmation");
+		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY,
+						sizeof(ev->bdaddr), &ev->bdaddr);
+		goto unlock;
+	}
+
+	mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.4.4

