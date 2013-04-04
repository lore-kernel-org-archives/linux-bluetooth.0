Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: Add support for custom event terminated commands
Date: Thu,  4 Apr 2013 13:23:43 +0300
Message-Id: <1365071024-6335-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1365071024-6335-1-git-send-email-johan.hedberg@gmail.com>
References: <1365071024-6335-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for having commands within HCI requests that do
not result in a command complete but some other event. This is at least
needed for some vendor specific commands to be issued in the
hdev->setup() procecure, but might also be useful for other commands.

The way that the support is implemented is by extending the skb control
buffer to have a field to indicate that the command is expected to
terminate with a special event. After sending the command each received
event can then be compared against this field through hdev->sent_cmd.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/hci_core.h  |    2 ++
 net/bluetooth/hci_core.c          |   10 +++++++++-
 net/bluetooth/hci_event.c         |   11 ++++++++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ed6e955..591fee7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -266,6 +266,7 @@ typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
 
 struct hci_req_ctrl {
 	bool			start;
+	u8			event;
 	hci_req_complete_t	complete;
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 38b653d..b2be51c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1054,6 +1054,8 @@ struct hci_request {
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen, void *param,
+		    u8 event);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f3e9768..a02c4b2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2625,7 +2625,8 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 EXPORT_SYMBOL(hci_send_cmd);
 
 /* Queue a command to an asynchronous HCI request */
-void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen, void *param,
+		    u8 event)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -2649,9 +2650,16 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 	if (skb_queue_empty(&req->cmd_q))
 		bt_cb(skb)->req.start = true;
 
+	bt_cb(skb)->req.event = event;
+
 	skb_queue_tail(&req->cmd_q, skb);
 }
 
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
+{
+	hci_req_add_ev(req, opcode, plen, param, 0);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ed0efb7..0a2b128 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2463,7 +2463,9 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	hci_req_cmd_complete(hdev, opcode, ev->status);
+	if (ev->status ||
+	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
+		hci_req_cmd_complete(hdev, opcode, ev->status);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
@@ -3713,6 +3715,13 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
+	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req.event == event) {
+		struct hci_command_hdr *hdr = (void *) hdev->sent_cmd->data;
+		u16 opcode = __le16_to_cpu(hdr->opcode);
+
+		hci_req_cmd_complete(hdev, opcode, 0);
+	}
+
 	switch (event) {
 	case HCI_EV_INQUIRY_COMPLETE:
 		hci_inquiry_complete_evt(hdev, skb);
-- 
1.7.10.4

