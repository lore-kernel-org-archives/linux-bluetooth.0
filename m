Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix HCI command send functions to use const specifier
Date: Fri, 19 Apr 2013 10:14:51 +0300
Message-Id: <1366355691-3173-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All HCI command send functions that take a pointer to the command
parameters do not need to modify the content in any way (they merely
copy the data to an skb). Therefore, the parameter type should be
declared const. This also allows passing already const parameters to
these APIs which previously would have generated a compiler warning.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   14 ++++++++------
 net/bluetooth/hci_core.c         |   16 +++++++++-------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 80d718a..35a57cd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1081,17 +1081,19 @@ struct hci_request {
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
-void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
-void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen, void *param,
-		    u8 event);
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
+		 const void *param);
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
+		    const void *param, u8 event);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       void *param, u32 timeout);
+			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
-				  void *param, u8 event, u32 timeout);
+				  const void *param, u8 event, u32 timeout);
 
-int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
+int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
+		 const void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ce82265..215db08 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -134,7 +134,7 @@ failed:
 }
 
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
-				  void *param, u8 event, u32 timeout)
+				  const void *param, u8 event, u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct hci_request req;
@@ -188,7 +188,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       void *param, u32 timeout)
+			       const void *param, u32 timeout)
 {
 	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
 }
@@ -2602,7 +2602,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 }
 
 static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
-				       u32 plen, void *param)
+				       u32 plen, const void *param)
 {
 	int len = HCI_COMMAND_HDR_SIZE + plen;
 	struct hci_command_hdr *hdr;
@@ -2628,7 +2628,8 @@ static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
 }
 
 /* Send HCI command */
-int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
+int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
+		 const void *param)
 {
 	struct sk_buff *skb;
 
@@ -2652,8 +2653,8 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 }
 
 /* Queue a command to an asynchronous HCI request */
-void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen, void *param,
-		    u8 event)
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
+		    const void *param, u8 event)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -2682,7 +2683,8 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen, void *param,
 	skb_queue_tail(&req->cmd_q, skb);
 }
 
-void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
+		 const void *param)
 {
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
-- 
1.7.10.4

