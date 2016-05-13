Return-Path: <jslaby@suse.cz>
From: Jiri Slaby <jslaby@suse.cz>
To: marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: fix power_on vs close race
Date: Fri, 13 May 2016 10:38:49 +0200
Message-Id: <1463128729-2959-1-git-send-email-jslaby@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

With all the latest fixes applied, I am still able to reproduce this
(and other) warning(s):
WARNING: CPU: 1 PID: 19684 at ../kernel/workqueue.c:4092 destroy_workqueue+0x70a/0x770()
...
Call Trace:
 [<ffffffff819fee81>] ? dump_stack+0xb3/0x112
 [<ffffffff8117377e>] ? warn_slowpath_common+0xde/0x140
 [<ffffffff811ce68a>] ? destroy_workqueue+0x70a/0x770
 [<ffffffff811739ae>] ? warn_slowpath_null+0x2e/0x40
 [<ffffffff811ce68a>] ? destroy_workqueue+0x70a/0x770
 [<ffffffffa0c944c9>] ? hci_unregister_dev+0x2a9/0x720 [bluetooth]
 [<ffffffffa0b301db>] ? vhci_release+0x7b/0xf0 [hci_vhci]
 [<ffffffffa0b30160>] ? vhci_flush+0x50/0x50 [hci_vhci]
 [<ffffffff8117cd73>] ? do_exit+0x863/0x2b90

This is due to race present in the hci_unregister_dev path.
hdev->power_on work races with hci_dev_do_close. One tries to open,
the other tries to close, leading to warning like the above. (Another
example is a warning in kobject_get or kobject_put depending on who
wins the race.)

Fix this by switching those two racers to ensure hdev->power_on never
triggers while hci_dev_do_close is in progress.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2713fc86e85a..45a9fc68c677 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3139,10 +3139,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
-	hci_dev_do_close(hdev);
-
 	cancel_work_sync(&hdev->power_on);
 
+	hci_dev_do_close(hdev);
+
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
 	    !hci_dev_test_flag(hdev, HCI_SETUP) &&
 	    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
-- 
2.8.2
