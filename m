Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] Bluetooth: HCI request error handling
Date: Fri,  8 Mar 2013 11:20:16 -0300
Message-Id: <1362752418-8688-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
References: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we are building a HCI request with more the one HCI command
and one of the hci_req_add calls fail, we should have some cleanup
routine so the HCI commands already queued on HCI request can be
deleted. Otherwise, we will face some memory leaks issues.

This patch implements the HCI request error handling which is the
following: If a hci_req_add fails, we save the error code in hci_
request. Once hci_req_run is called, we verify the error field. If
it is different from zero, we delete all HCI commands already queued
and return the error code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_core.c         | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a9cbf2..332ee50 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1042,6 +1042,11 @@ int hci_unregister_cb(struct hci_cb *hcb);
 struct hci_request {
 	struct hci_dev		*hdev;
 	struct sk_buff_head	cmd_q;
+
+	/* If something goes wrong when building the HCI request, the error
+	 * value is stored in this field.
+	 */
+	int			err;
 };
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dc76dcf..fa72aff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2443,6 +2443,7 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
 	skb_queue_head_init(&req->cmd_q);
 	req->hdev = hdev;
+	req->err = 0;
 }
 
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
@@ -2453,6 +2454,14 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 
 	BT_DBG("length %u", skb_queue_len(&req->cmd_q));
 
+	/* If an error occured during request building, remove all HCI
+	 * commands queued on the HCI request queue.
+	 */
+	if (req->err) {
+		skb_queue_purge(&req->cmd_q);
+		return req->err;
+	}
+
 	/* Do not allow empty requests */
 	if (skb_queue_empty(&req->cmd_q))
 		return -ENODATA;
@@ -2529,7 +2538,9 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 
 	skb = hci_prepare_cmd(hdev, opcode, plen, param);
 	if (!skb) {
-		BT_ERR("%s no memory for command", hdev->name);
+		BT_ERR("%s no memory for command (opcode 0x%4.4x)",
+		       hdev->name, opcode);
+		req->err = -ENOMEM;
 		return -ENOMEM;
 	}
 
-- 
1.8.1.2

