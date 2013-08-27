Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Report error for HCI reset ioctl when device is down
Date: Mon, 26 Aug 2013 20:57:58 -0700
Message-Id: <1377575878-2629-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even if this is legacy API, there is no reason to not report a proper
error when trying to reset a HCI device that is down.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d9b87d..c529e85 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1341,8 +1341,10 @@ int hci_dev_reset(__u16 dev)
 
 	hci_req_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags))
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		ret = -ENETDOWN;
 		goto done;
+	}
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
-- 
1.8.3.1

