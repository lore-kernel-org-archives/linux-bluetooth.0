Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 5/9] Bluetooth: Add HCI User Passkey Req Evt handling
Date: Sat, 12 Nov 2011 22:01:15 -0800
Message-Id: <1321164079-2216-6-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
References: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some MITM scenarios require handling of the User Passkey Request event,
by querying the user, and passing the response back.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/hci_core.h |    4 ++
 net/bluetooth/hci_event.c        |   59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a67ff88..0b692ea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -933,6 +933,10 @@ int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status);
 int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
 						bdaddr_t *bdaddr, u8 status);
+int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status);
+int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
+						bdaddr_t *bdaddr, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0d55d00..3c49501 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -927,6 +927,37 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr,
+								rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
+								rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
@@ -2011,6 +2042,14 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_user_confirm_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_USER_PASSKEY_REPLY:
+		hci_cc_user_passkey_reply(hdev, skb);
+		break;
+
+	case HCI_OP_USER_PASSKEY_NEG_REPLY:
+		hci_cc_user_passkey_neg_reply(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_SCAN_ENABLE:
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
@@ -2770,6 +2809,22 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	/* Passkey Request is a degenerate case of User Confirm */
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_user_confirm_request(hdev, &ev->bdaddr, 0, 0);
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
@@ -3109,6 +3164,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_user_confirm_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_USER_PASSKEY_REQUEST:
+		hci_user_passkey_request_evt(hdev, skb);
+		break;
+
 	case HCI_EV_SIMPLE_PAIR_COMPLETE:
 		hci_simple_pair_complete_evt(hdev, skb);
 		break;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
