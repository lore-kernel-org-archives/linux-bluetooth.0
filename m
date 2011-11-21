Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Ignore HCI_Read_Local_Commands failures
Date: Mon, 21 Nov 2011 20:01:24 +0200
Message-Id: <1321898484-17952-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1321898484-17952-1-git-send-email-johan.hedberg@gmail.com>
References: <1321898484-17952-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some 1.2 controllers will fail the HCI_Read_Local_Commands HCI command
even though (according to the specification) they should support it.
Since this HCI command is part of the controller init sequence
controllers broken in this manner would be unusable. Since not having
the list of supported commands is not critical for these controllers it
is better to just ignore failures in this case (additionally, this is
also how older kernels used to behave).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af24b3d..e950865 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1400,6 +1400,18 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 }
 
+static void hci_cs_read_local_commands(struct hci_dev *hdev, u8 status)
+{
+	if (!status)
+		return;
+
+	/* Some 1.2 controllers report failure for HCI_Read_Local_Commands
+	 * even though they should support it. Since it's not a critical
+	 * issue not to have a proper result from them just ignore a
+	 * failure status (i.e. consider it a success) */
+	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0);
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2113,6 +2125,10 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_start_enc(hdev, ev->status);
 		break;
 
+	case HCI_OP_READ_LOCAL_COMMANDS:
+		hci_cs_read_local_commands(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		if (ev->status)
-- 
1.7.7.3

