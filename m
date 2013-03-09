Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix endianness handling of cmd_status/complete opcodes
Date: Sat,  9 Mar 2013 09:53:50 +0200
Message-Id: <1362815630-6800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The opcode in cmd_complete and cmd_status events is 16 bits, so we
should only be comparing it after having converted it to the host
endianness. There's already an opcode variable in both functions which
is in host endiannes so the right fix is to just start using it instead
of ev->opcode.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e89707f..d11b87b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2299,10 +2299,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	if (ev->opcode != HCI_OP_NOP)
+	if (opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	hci_req_cmd_complete(hdev, ev->opcode, status);
+	hci_req_cmd_complete(hdev, opcode, status);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
@@ -2386,10 +2386,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	if (ev->opcode != HCI_OP_NOP)
+	if (opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	hci_req_cmd_status(hdev, ev->opcode, ev->status);
+	hci_req_cmd_status(hdev, opcode, ev->status);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-- 
1.7.10.4

