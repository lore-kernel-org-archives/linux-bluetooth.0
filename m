Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/4] Bluetooth: Add debug print specifier
Date: Fri,  8 Jun 2012 11:12:45 +0300
Message-Id: <1339143166-6523-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Some functions print opcode as "0xc03" others as "0x0c03". Patch
ensures that opcodes printed are the in the same format.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f35f2e..c7be1bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2097,7 +2097,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	struct hci_command_hdr *hdr;
 	struct sk_buff *skb;
 
-	BT_DBG("%s opcode 0x%x plen %d", hdev->name, opcode, plen);
+	BT_DBG("%s opcode 0x%04x plen %d", hdev->name, opcode, plen);
 
 	skb = bt_skb_alloc(len, GFP_ATOMIC);
 	if (!skb) {
@@ -2264,7 +2264,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
 
-	BT_DBG("%s opcode 0x%x", hdev->name, opcode);
+	BT_DBG("%s opcode 0x%04x", hdev->name, opcode);
 
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
-- 
1.7.9.5

