Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Add setting of the LE event mask
Date: Fri, 19 Oct 2012 20:15:09 +0300
Message-Id: <1350666911-6334-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds setting of the LE event mask to the HCI init procedure
for LE-capable controllers. Right now we only set the default mask which
is good enough for the events available in the 4.0 core specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f4f0b8b..78f1af5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -550,6 +550,13 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 		events[7] |= 0x20;	/* LE Meta-Event */
 
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
+
+	if (lmp_le_capable(hdev)) {
+		memset(events, 0, sizeof(events));
+		events[0] = 0x1f;
+		hci_send_cmd(hdev, HCI_OP_LE_SET_EVENT_MASK,
+			     sizeof(events), events);
+	}
 }
 
 static void bredr_init(struct hci_dev *hdev)
@@ -1066,6 +1073,15 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
 }
 
+static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	hci_req_complete(hdev, HCI_OP_LE_SET_EVENT_MASK, status);
+}
+
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
@@ -2489,6 +2505,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_buffer_size(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_EVENT_MASK:
+		hci_cc_le_set_event_mask(hdev, skb);
+		break;
+
 	case HCI_OP_USER_CONFIRM_REPLY:
 		hci_cc_user_confirm_reply(hdev, skb);
 		break;
-- 
1.7.10.4

