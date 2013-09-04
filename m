Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Only schedule raw queue when user channel is active
Date: Tue,  3 Sep 2013 18:08:38 -0700
Message-Id: <1378256918-50836-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the user channel is set and an user application has full control
over the device, do not bother trying to schedule any queues except
the raw queue.

This is an optimization since with user channel, only the raw queue
is in use.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 541f4d5..1b86c78 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3292,15 +3292,13 @@ static void hci_tx_work(struct work_struct *work)
 	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
 	       hdev->sco_cnt, hdev->le_cnt);
 
-	/* Schedule queues and send stuff to HCI driver */
-
-	hci_sched_acl(hdev);
-
-	hci_sched_sco(hdev);
-
-	hci_sched_esco(hdev);
-
-	hci_sched_le(hdev);
+	if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		/* Schedule queues and send stuff to HCI driver */
+		hci_sched_acl(hdev);
+		hci_sched_sco(hdev);
+		hci_sched_esco(hdev);
+		hci_sched_le(hdev);
+	}
 
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
-- 
1.8.3.1

