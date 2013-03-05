Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 05/11] Bluetooth: Refactor HCI command skb creation
Date: Tue,  5 Mar 2013 20:37:45 +0200
Message-Id: <1362508671-6460-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves out the skb creation from hci_send_cmd() into its own
prepare_cmd() function. This is essential so the same prepare_cmd()
function can be easily reused for skb creation for asynchronous HCI
requests.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dc8f0d8..0daea68 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2469,20 +2469,16 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 	return 0;
 }
 
-/* Send HCI command */
-int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
+static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
+				       u32 plen, void *param)
 {
 	int len = HCI_COMMAND_HDR_SIZE + plen;
 	struct hci_command_hdr *hdr;
 	struct sk_buff *skb;
 
-	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
-
 	skb = bt_skb_alloc(len, GFP_ATOMIC);
-	if (!skb) {
-		BT_ERR("%s no memory for command", hdev->name);
-		return -ENOMEM;
-	}
+	if (!skb)
+		return NULL;
 
 	hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
 	hdr->opcode = cpu_to_le16(opcode);
@@ -2496,6 +2492,22 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
 	skb->dev = (void *) hdev;
 
+	return skb;
+}
+
+/* Send HCI command */
+int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
+{
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
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hdev->init_last_cmd = opcode;
 
-- 
1.7.10.4

