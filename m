Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-2.6 v2] Bluetooth: Fix keeping the command timer running
Date: Mon, 11 Apr 2011 18:46:55 -0300
Message-Id: <1302558415-23289-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the teardown path the reset command is sent to the controller,
this event causes the command timer to be reactivated.

So the timer is removed in two situations, when the adapter isn't
marked as UP and when we know that some command has been sent.

Reported-by: Keith Packard <keithp@keithp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Changes:
 - The case when the adapter isn't up should be taken into account
  (thanks Thomas Gleixner);
 - the timer is only removed if any command was ever sent;

Could someone confirm that the same crash could potentially happen during
hci_dev_open() if some command sent by __hci_request() fails?


 net/bluetooth/hci_core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2216620..e7dced9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -587,10 +587,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);

-	/* Stop timer, it might be running */
-	del_timer_sync(&hdev->cmd_timer);
-
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
+		del_timer_sync(&hdev->cmd_timer);
 		hci_req_unlock(hdev);
 		return 0;
 	}
@@ -629,6 +627,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)

 	/* Drop last sent command */
 	if (hdev->sent_cmd) {
+		del_timer_sync(&hdev->cmd_timer);
 		kfree_skb(hdev->sent_cmd);
 		hdev->sent_cmd = NULL;
 	}
--
1.7.4.3

