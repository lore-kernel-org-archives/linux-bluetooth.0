Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/7] Bluetooth: Move hci_get_cmd_complete() to hci_event.c
Date: Sun, 15 Mar 2015 11:07:34 +0200
Message-Id: <1426410455-18368-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
References: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make the hci_req_run_skb() API consistent with hci_cmd_sync_ev()
the callback should receive the cmd_complete parameters in the 'normal'
case and the full HCI event if a special event was expected. This patch
moves the hci_get_cmd_complete() function from hci_core.c to hci_event.c
where it's used to strip the skb from the needed headers before passing
it on to the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  | 52 ++++--------------------------------------
 net/bluetooth/hci_event.c | 57 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9f88b7c74a80..fef81321bb78 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -166,53 +166,6 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 	}
 }
 
-static struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
-					    u8 event, struct sk_buff *skb)
-{
-	struct hci_ev_cmd_complete *ev;
-	struct hci_event_hdr *hdr;
-
-	if (!skb)
-		return ERR_PTR(-ENODATA);
-
-	if (skb->len < sizeof(*hdr)) {
-		BT_ERR("Too short HCI event");
-		goto failed;
-	}
-
-	hdr = (void *) skb->data;
-	skb_pull(skb, HCI_EVENT_HDR_SIZE);
-
-	if (event) {
-		if (hdr->evt != event)
-			goto failed;
-		return skb;
-	}
-
-	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
-		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
-		goto failed;
-	}
-
-	if (skb->len < sizeof(*ev)) {
-		BT_ERR("Too short cmd_complete event");
-		goto failed;
-	}
-
-	ev = (void *) skb->data;
-	skb_pull(skb, sizeof(*ev));
-
-	if (opcode == __le16_to_cpu(ev->opcode))
-		return skb;
-
-	BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
-	       __le16_to_cpu(ev->opcode));
-
-failed:
-	kfree_skb(skb);
-	return ERR_PTR(-ENODATA);
-}
-
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout)
 {
@@ -271,7 +224,10 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
-	return hci_get_cmd_complete(hdev, opcode, event, skb);
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
+	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f57bb6236591..682609c45132 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5032,13 +5032,58 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	amp_read_loc_assoc_final_data(hdev, hcon);
 }
 
+static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
+				 u8 event, struct sk_buff *skb)
+{
+	struct hci_ev_cmd_complete *ev;
+	struct hci_event_hdr *hdr;
+
+	if (!skb)
+		return false;
+
+	if (skb->len < sizeof(*hdr)) {
+		BT_ERR("Too short HCI event");
+		return false;
+	}
+
+	hdr = (void *) skb->data;
+	skb_pull(skb, HCI_EVENT_HDR_SIZE);
+
+	if (event) {
+		if (hdr->evt != event)
+			return false;
+		return true;
+	}
+
+	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
+		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
+		return false;
+	}
+
+	if (skb->len < sizeof(*ev)) {
+		BT_ERR("Too short cmd_complete event");
+		return false;
+	}
+
+	ev = (void *) skb->data;
+	skb_pull(skb, sizeof(*ev));
+
+	if (opcode != __le16_to_cpu(ev->opcode)) {
+		BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
+		       __le16_to_cpu(ev->opcode));
+		return false;
+	}
+
+	return true;
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
 	hci_req_complete_t req_complete = NULL;
 	hci_req_complete_skb_t req_complete_skb = NULL;
 	struct sk_buff *orig_skb = NULL;
-	u8 status = 0, event = hdr->evt;
+	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req_event == event) {
@@ -5046,6 +5091,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
 		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
 				     &req_complete_skb);
+		req_evt = event;
 	}
 
 	/* If it looks like we might end up having to call
@@ -5239,10 +5285,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	if (req_complete)
+	if (req_complete) {
 		req_complete(hdev, status, opcode);
-	else if (req_complete_skb)
+	} else if (req_complete_skb) {
+		if (!hci_get_cmd_complete(hdev, opcode, req_evt, orig_skb)) {
+			kfree_skb(orig_skb);
+			orig_skb = NULL;
+		}
 		req_complete_skb(hdev, status, opcode, orig_skb);
+	}
 
 	kfree_skb(orig_skb);
 	kfree_skb(skb);
-- 
2.1.0

