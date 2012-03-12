Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix opcode access in hci_complete
Date: Mon, 12 Mar 2012 15:59:33 +0200
Message-Id: <1331560774-10748-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

opcode to be accessed is in le16 format so convert it
first to cpu byte order.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f3e1bb..149d749 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -84,6 +84,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 	 */
 	if (test_bit(HCI_INIT, &hdev->flags) && hdev->init_last_cmd != cmd) {
 		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
+		u16 opcode = __le16_to_cpu(sent->opcode);
 		struct sk_buff *skb;
 
 		/* Some CSR based controllers generate a spontaneous
@@ -93,7 +94,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 		 * command.
 		 */
 
-		if (cmd != HCI_OP_RESET || sent->opcode == HCI_OP_RESET)
+		if (cmd != HCI_OP_RESET || opcode == HCI_OP_RESET)
 			return;
 
 		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
-- 
1.7.9.1

