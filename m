Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/11] Bluetooth: Introduce new hci_req_add function
Date: Tue,  5 Mar 2013 10:29:05 +0200
Message-Id: <1362472150-30965-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function is analogous to hci_send_cmd() but instead of directly
queuing the command to hdev->cmd_q it adds it to the local queue of the
asynchronous HCI request being build (inside struct hci_request).

This is the main function used for building asynchronous requests and
there should be one or more calls to it between calls to hci_req_init
and hci_req_run.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7191217..67fe661 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1048,6 +1048,7 @@ struct hci_request {
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
+int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 07e1365..0f2a0bf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2517,6 +2517,28 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+/* Queue a command to an asynchronous HCI request */
+int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct sk_buff *skb;
+
+	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
+
+	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	if (!skb) {
+		BT_ERR("%s no memory for command", hdev->name);
+		return -ENOMEM;
+	}
+
+	if (skb_queue_empty(&req->cmd_q))
+		bt_cb(skb)->req.start = true;
+
+	skb_queue_tail(&req->cmd_q, skb);
+
+	return 0;
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.10.4

