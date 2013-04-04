Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: Add __hci_cmd_sync_ev function
Date: Thu,  4 Apr 2013 13:23:44 +0300
Message-Id: <1365071024-6335-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1365071024-6335-1-git-send-email-johan.hedberg@gmail.com>
References: <1365071024-6335-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a __hci_cmd_sync_ev function, analogous to
__hci_cmd_sync except that it also takes an event parameter to indicate
that the command completes with a special event instead of command
complete. Internally this new function takes advantage of the
hci_req_add_ev function introduced in the previous patch.

The primary expected user of this new function are the setup routines of
HCI drivers which may want to send custom commands and return only when
they have completed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2be51c..d4e13bf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1060,6 +1060,8 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       void *param, u32 timeout);
+struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
+				  void *param, u8 event, u32 timeout);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a02c4b2..719510a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -79,7 +79,7 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 	}
 }
 
-struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode)
+struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 event)
 {
 	struct hci_ev_cmd_complete *ev;
 	struct hci_event_hdr *hdr;
@@ -98,6 +98,12 @@ struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode)
 	hdr = (void *) skb->data;
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
+	if (event) {
+		if (hdr->evt != event)
+			goto failed;
+		return skb;
+	}
+
 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
 		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
 		goto failed;
@@ -122,8 +128,8 @@ failed:
 	return ERR_PTR(-ENODATA);
 }
 
-struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       void *param, u32 timeout)
+struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
+				  void *param, u8 event, u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct hci_request req;
@@ -133,7 +139,7 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hci_req_init(&req, hdev);
 
-	hci_req_add(&req, opcode, plen, param);
+	hci_req_add_ev(&req, opcode, plen, param, event);
 
 	hdev->req_status = HCI_REQ_PEND;
 
@@ -172,7 +178,14 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	return hci_get_cmd_complete(hdev, opcode);
+	return hci_get_cmd_complete(hdev, opcode, event);
+}
+EXPORT_SYMBOL(__hci_cmd_sync_ev);
+
+struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
+			       void *param, u32 timeout)
+{
+	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
 }
 EXPORT_SYMBOL(__hci_cmd_sync);
 
-- 
1.7.10.4

