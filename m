Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] Bluetooth: HCI request error handling
Date: Thu,  7 Mar 2013 18:48:10 -0300
Message-Id: <1362692892-28716-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
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
---
 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_core.c         | 10 ++++++++++
 2 files changed, 15 insertions(+)

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
index dc76dcf..397adc6 100644
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
@@ -2530,6 +2539,7 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 	skb = hci_prepare_cmd(hdev, opcode, plen, param);
 	if (!skb) {
 		BT_ERR("%s no memory for command", hdev->name);
+		req->err = -ENOMEM;
 		return -ENOMEM;
 	}
 
-- 
1.8.1.2

