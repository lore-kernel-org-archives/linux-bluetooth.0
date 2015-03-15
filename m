Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/7] Bluetooth: Add clarifying comment to command status handling
Date: Sun, 15 Mar 2015 11:07:29 +0200
Message-Id: <1426410455-18368-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
References: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
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
index c7376cd42b1c..026ab77298c6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3104,6 +3104,12 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
+	/* Indicate request completion if the command failed. Also, if
+	 * we're not waiting for a special event and we get a success
+	 * command status we should try to flag the request as completed
+	 * (since for this kind of commands there will not be a command
+	 * complete event).
+	 */
 	if (ev->status ||
 	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req_event))
 		hci_req_cmd_complete(hdev, opcode, ev->status);
-- 
2.1.0

