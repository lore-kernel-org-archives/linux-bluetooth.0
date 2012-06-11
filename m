Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/5] Bluetooth: Correct debug print specifier for u16 objects
Date: Mon, 11 Jun 2012 11:13:09 +0300
Message-Id: <1339402390-32320-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339402390-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339402390-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Some functions print u16 objects as "0xc03" others as "0x0c03". Patch
ensures that opcodes printed are the in the same format and consistent
with bluetooth code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e71485f..4f804ff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -61,7 +61,7 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 {
-	BT_DBG("%s command 0x%04x result 0x%2.2x", hdev->name, cmd, result);
+	BT_DBG("%s command 0x%4.4x result 0x%2.2x", hdev->name, cmd, result);
 
 	/* If this is the init phase check if the completed command matches
 	 * the last init command, and if not just return.
@@ -2095,7 +2095,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	struct hci_command_hdr *hdr;
 	struct sk_buff *skb;
 
-	BT_DBG("%s opcode 0x%x plen %d", hdev->name, opcode, plen);
+	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
 	skb = bt_skb_alloc(len, GFP_ATOMIC);
 	if (!skb) {
@@ -2262,7 +2262,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
 
-	BT_DBG("%s opcode 0x%x", hdev->name, opcode);
+	BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
@@ -2332,7 +2332,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s chan %p flags 0x%x", hdev->name, chan, flags);
+	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
 	skb->dev = (void *) hdev;
 
@@ -2832,7 +2832,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len,
+	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
 	       handle, flags);
 
 	hdev->stat.acl_rx++;
@@ -2874,7 +2874,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	handle = __le16_to_cpu(hdr->handle);
 
-	BT_DBG("%s len %d handle 0x%x", hdev->name, skb->len, handle);
+	BT_DBG("%s len %d handle 0x%4.4x", hdev->name, skb->len, handle);
 
 	hdev->stat.sco_rx++;
 
-- 
1.7.9.5

