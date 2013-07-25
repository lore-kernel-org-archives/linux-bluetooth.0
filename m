Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Bluetooth: Fix removing Long Term Key
Date: Thu, 25 Jul 2013 15:14:17 -0300
Message-Id: <1374776057-2618-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes authentication failure on LE link re-connection when
BlueZ acts as slave (peripheral). LTK is removed from the internal list
after its first use causing PIN or Key missing reply when re-connecting
the link. The LE Long Term Key Request event indicates that the master
is attempting to encrypt or re-encrypt the link.

Pre-condition: BlueZ host paired and running as slave.
How to reproduce(master):
  1) Establish an ACL LE encrypted link
  2) Disconnect the link
  3) Try to re-establish the ACL LE encrypted link

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ae78738..ccb93dd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3558,7 +3558,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
-	if (ltk->type & HCI_SMP_STK) {
+	/* Use short term key only once */
+	if (ltk->type == HCI_SMP_STK_SLAVE) {
 		list_del(&ltk->list);
 		kfree(ltk);
 	}
-- 
1.7.11.7

