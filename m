Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] Bluetooth: Make hci_req_add returning void
Date: Thu,  7 Mar 2013 18:48:11 -0300
Message-Id: <1362692892-28716-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since no one checks the returning value of hci_req_add and HCI
request errors are now handled in hci_req_run, we can make hci_
req_add returning void.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 332ee50..d6c3256 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1051,7 +1051,7 @@ struct hci_request {
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
-int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 void hci_req_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 397adc6..1103d9f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2529,7 +2529,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 }
 
 /* Queue a command to an asynchronous HCI request */
-int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -2540,15 +2540,13 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 	if (!skb) {
 		BT_ERR("%s no memory for command", hdev->name);
 		req->err = -ENOMEM;
-		return -ENOMEM;
+		return;
 	}
 
 	if (skb_queue_empty(&req->cmd_q))
 		bt_cb(skb)->req.start = true;
 
 	skb_queue_tail(&req->cmd_q, skb);
-
-	return 0;
 }
 
 /* Get data from the previously sent command */
-- 
1.8.1.2

