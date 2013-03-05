Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/11] Bluetooth: Add initial skeleton for asynchronous HCI requests
Date: Tue,  5 Mar 2013 10:29:03 +0200
Message-Id: <1362472150-30965-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the initial definitions and functions for asynchronous
HCI requests. Asynchronous requests are essentially a group of HCI
commands together with an optional completion callback. The request is
tracked through the already existing command queue by having the
necessary context information as part of the control buffer of each skb.

The only information needed in the skb control buffer is a flag for
indicating that the skb is the start of a request as well as the
optional complete callback that should be used when the request is
complete (this will be found in the last skb of the request).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |   10 ++++++++++
 include/net/bluetooth/hci_core.h  |    8 ++++++++
 net/bluetooth/hci_core.c          |   30 ++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5f51bef..ed6e955 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -260,12 +260,22 @@ struct l2cap_ctrl {
 	__u8		retries;
 };
 
+struct hci_dev;
+
+typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
+
+struct hci_req_ctrl {
+	bool			start;
+	hci_req_complete_t	complete;
+};
+
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
 	__u16 expect;
 	__u8 force_active;
 	struct l2cap_ctrl control;
+	struct hci_req_ctrl req;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 787d3b9..7191217 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1041,6 +1041,14 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+struct hci_request {
+	struct hci_dev		*hdev;
+	struct sk_buff_head	cmd_q;
+};
+
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
+int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
+
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e5ee219..39be4e2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2439,6 +2439,36 @@ static int hci_send_frame(struct sk_buff *skb)
 	return hdev->send(skb);
 }
 
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
+{
+	skb_queue_head_init(&req->cmd_q);
+	req->hdev = hdev;
+}
+
+int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	BT_DBG("length %u", skb_queue_len(&req->cmd_q));
+
+	/* Do not allow empty requests */
+	if (skb_queue_empty(&req->cmd_q))
+		return -EINVAL;
+
+	skb = skb_peek_tail(&req->cmd_q);
+	bt_cb(skb)->req.complete = complete;
+
+	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
+	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
+	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
+
+	queue_work(hdev->workqueue, &hdev->cmd_work);
+
+	return 0;
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 {
-- 
1.7.10.4

