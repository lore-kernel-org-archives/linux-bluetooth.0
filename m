Return-Path: <cyrus@holtmann.org>
From: vinicius.gomes@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix keeping the command timer running
Date: Fri,  8 Apr 2011 21:08:27 -0300
Message-Id: <4d9fa361.1836640a.6de8.ffffbffe@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

In the teardown path the reset command is sent to the controller,
this event causes the command timer to be reactivated.

Now we remove the timer after the reset command is sent.

Reported-by: Keith Packard <keithp@keithp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a80bc1c..7467eaa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -586,9 +586,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);
 
-	/* Stop timer, it might be running */
-	del_timer_sync(&hdev->cmd_timer);
-
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		hci_req_unlock(hdev);
 		return 0;
@@ -618,6 +615,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
+	/* Stop timer, it might be running */
+	del_timer_sync(&hdev->cmd_timer);
+
 	/* Kill cmd task */
 	tasklet_kill(&hdev->cmd_task);
 
-- 
1.7.4.3

