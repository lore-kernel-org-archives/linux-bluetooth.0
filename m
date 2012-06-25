Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] bluetooth: opcode field of sent commands is little endian.
Date: Mon, 25 Jun 2012 08:38:38 +0200
Message-Id: <1340606319-32187-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes built-in Bluetooth not working on Apple PowerBooks, regression from
commit 75fb0e324daa48ec458fb5c2960eb07b80cfad9d ('Bluetooth: Fix init sequence
for some CSR based controllers').

Cc: stable@vger.kernel.org [v3.4]
Signed-off-by: Michel Dänzer <michel@daenzer.net>
---
 net/bluetooth/hci_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6dc44c..e039e3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -92,7 +92,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 		 * command.
 		 */
 
-		if (cmd != HCI_OP_RESET || sent->opcode == HCI_OP_RESET)
+		if (cmd != HCI_OP_RESET || sent->opcode == cpu_to_le16(HCI_OP_RESET))
 			return;
 
 		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
-- 
1.7.10.4
