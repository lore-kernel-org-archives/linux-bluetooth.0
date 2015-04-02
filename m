Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/7] Bluetooth: Add clarifying comment to command status handling
Date: Thu,  2 Apr 2015 13:41:07 +0300
Message-Id: <1427971273-14881-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1427971273-14881-1-git-send-email-johan.hedberg@gmail.com>
References: <1427971273-14881-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When dealing with HCI command status events, the reasoning for trying to
mark a request as complete if no specific event is being waited for and
status was success is not self-evident. This patch adds a clarifying
comment above the if-statement.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c0f992602f5..87e5bee36408 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3124,6 +3124,12 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
 		atomic_set(&hdev->cmd_cnt, 1);
 
+	/* Indicate request completion if the command failed. Also, if
+	 * we're not waiting for a special event and we get a success
+	 * command status we should try to flag the request as completed
+	 * (since for this kind of commands there will not be a command
+	 * complete event).
+	 */
 	if (ev->status ||
 	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
 		hci_req_cmd_complete(hdev, opcode, ev->status);
-- 
2.1.0

