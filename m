Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v5 2/6] Bluetooth: Add HCI User Passkey Req Evt handling
Date: Wed, 23 Nov 2011 08:28:34 -0800
Message-Id: <1322065718-11570-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
References: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some MITM scenarios require handling of the User Passkey Request event,
by querying the user, and passing the response back.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/hci_event.c |   58 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..980da08 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -931,6 +931,37 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
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
@@ -2015,6 +2046,14 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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
@@ -2774,6 +2813,21 @@ unlock:
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
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_user_passkey_request(hdev, &ev->bdaddr);
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
@@ -3113,6 +3167,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
