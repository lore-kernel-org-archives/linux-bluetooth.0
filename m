Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Remove hci_req_cmd_status
Date: Wed, 27 Mar 2013 20:04:57 -0300
Message-Id: <1364425497-30944-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
References: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the hci_req_cmd_status function since it is not
used anymore. The HCI request framework now considers the HCI command
has complete once the Command Status or Command Complete Event is
received.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 358a698..0e7ee89 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1055,7 +1055,6 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
-void hci_req_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1239929..a199d63 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3322,32 +3322,6 @@ call_complete:
 		req_complete(hdev, status);
 }
 
-void hci_req_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status)
-{
-	hci_req_complete_t req_complete = NULL;
-
-	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
-
-	if (status) {
-		hci_req_cmd_complete(hdev, opcode, status);
-		return;
-	}
-
-	/* No need to handle success status if there are more commands */
-	if (!hci_req_is_complete(hdev))
-		return;
-
-	if (hdev->sent_cmd)
-		req_complete = bt_cb(hdev->sent_cmd)->req.complete;
-
-	/* If the request doesn't have a complete callback or there
-	 * are other commands/requests in the hdev queue we consider
-	 * this request as completed.
-	 */
-	if (!req_complete || !skb_queue_empty(&hdev->cmd_q))
-		hci_req_cmd_complete(hdev, opcode, status);
-}
-
 static void hci_rx_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
-- 
1.8.1.2

