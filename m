Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Fix HCI request framework
Date: Wed, 27 Mar 2013 20:04:55 -0300
Message-Id: <1364425497-30944-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
References: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some HCI commands don't send a Command Complete Event once the HCI
command has completed so they require some special handling from the
HCI request framework. These HCI commands, however, send a Command
Status Event to indicate that the command has been received, and
that the controller is currently performing the task for the command.

So, in order to properly handle those HCI commands, the HCI request
framework should consider the HCI command has completed once the
Command Status Event is received.

This way, we fix some issues regarding the Inquiry command support,
as well as add support for all those HCI commands which would require
some special handling from the HCI request framework.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1385807..8efb9c0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -53,8 +53,6 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
-	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-
 	hci_conn_check_pending(hdev);
 }
 
@@ -1600,8 +1598,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-
 	hci_conn_check_pending(hdev);
 
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
@@ -2462,7 +2458,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	hci_req_cmd_status(hdev, opcode, ev->status);
+	hci_req_cmd_complete(hdev, opcode, ev->status);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-- 
1.8.1.2

