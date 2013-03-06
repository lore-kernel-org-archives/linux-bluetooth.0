Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: HCI request error handling
Date: Wed,  6 Mar 2013 20:45:15 -0300
Message-Id: <1362613517-1761-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
References: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we are building a HCI request with more the one HCI command
and one of the hci_req_add calls fail, we should have some cleanup
routine so the HCI commands already queued on HCI request can be
deleted. Otherwise we will face some memory leaks issues.

This patch implements the HCI request error handling which is the
following: If a hci_req_add fails, we set a flag in struct hci_
request to indicate the failure. Once hci_req_run is called, we
verify the error flag. If it is set, we delete all HCI commands
already queued and return a error code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a9cbf2..2edac3f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1042,6 +1042,9 @@ int hci_unregister_cb(struct hci_cb *hcb);
 struct hci_request {
 	struct hci_dev		*hdev;
 	struct sk_buff_head	cmd_q;
+
+	/* This flag is set if something goes wrong during request creation */
+	bool			error;
 };
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a1bbf6d..402247a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2446,6 +2446,7 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
 	skb_queue_head_init(&req->cmd_q);
 	req->hdev = hdev;
+	req->error = false;
 }
 
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
@@ -2460,6 +2461,15 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 	if (skb_queue_empty(&req->cmd_q))
 		return -ENODATA;
 
+	/*
+	 * If error flag is set, remove all HCI commands queued on the HCI
+	 * request queue.
+	 */
+	if (req->error) {
+		skb_queue_purge(&req->cmd_q);
+		return -EIO;
+	}
+
 	skb = skb_peek_tail(&req->cmd_q);
 	bt_cb(skb)->req.complete = complete;
 
@@ -2533,6 +2543,7 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 	skb = hci_prepare_cmd(hdev, opcode, plen, param);
 	if (!skb) {
 		BT_ERR("%s no memory for command", hdev->name);
+		req->error = true;
 		return -ENOMEM;
 	}
 
-- 
1.8.1.2

