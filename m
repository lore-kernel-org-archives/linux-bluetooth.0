Return-Path: <cyrus@holtmann.org>
From: Imran Haider <imran1008@gmail.com>
To: marcel@holtmann.org,
	padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Imran Haider <imran1008@gmail.com>
Subject: [PATCH] Bluetooth: Don't sleep after deleting command timer
Date: Fri, 22 Apr 2011 19:02:42 -0400
Message-Id: <1303513362-9357-1-git-send-email-imran1008@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fix adds on to commit b77dcf84. It seems that scheduling a timeout
of 250ms after deleting the command timer causes a kernel panic when
system is resuming from Suspend-to-RAM. I tried adding another timeout
before deleting the command timer but that didn't help so I believe that
some code in hci_dev_do_close must execute after the command timer is
deleted before control is returned to another thread.

The only bit the command timer handler hci_cmd_timer() touches is HCI_RESET.
It should be fine to delete the timer after testing the HCI_UP bit.
---
 net/bluetooth/hci_core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c83f618..398ec93 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -587,10 +587,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);
 
-	/* Stop timer, it might be running */
-	del_timer_sync(&hdev->cmd_timer);
-
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
+		/* Stop timer, it might be running */
+		del_timer_sync(&hdev->cmd_timer);
+
 		hci_req_unlock(hdev);
 		return 0;
 	}
@@ -619,6 +619,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
+	/* Stop timer, it might be running */
+	del_timer_sync(&hdev->cmd_timer);
+
 	/* Kill cmd task */
 	tasklet_kill(&hdev->cmd_task);
 
-- 
1.7.3.4
