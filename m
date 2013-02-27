Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/16] Bluetooth: Refactor HCI command skb creation
Date: Wed, 27 Feb 2013 09:57:12 +0200
Message-Id: <1361951844-13719-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves out the skb creation from hci_send_cmd() into its own
prepare_cmd() function. This is essential so the same prepare_cmd()
function can be easily reused for skb creation for HCI transactions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ef051b7..8def4e6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2464,20 +2464,16 @@ int hci_transaction_run(struct hci_transaction *transaction)
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
@@ -2491,6 +2487,22 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
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

