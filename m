Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/4] Bluetooth: Add opcode to error message
Date: Fri,  8 Jun 2012 11:12:44 +0300
Message-Id: <1339143166-6523-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Sometimes HCI command sending timeouts and gives error message without
specifying which command causes error. Patch makes sure that opcode
is printed to help debugging.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e5a9a09..8f35f2e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1369,11 +1369,18 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
 }
 
 /* HCI command timer function */
-static void hci_cmd_timer(unsigned long arg)
+static void hci_cmd_timeout(unsigned long arg)
 {
 	struct hci_dev *hdev = (void *) arg;
 
-	BT_ERR("%s command tx timeout", hdev->name);
+	if (hdev->sent_cmd) {
+		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
+		u16 opcode = __le16_to_cpu(sent->opcode);
+
+		BT_ERR("%s command 0x%04x tx timeout", hdev->name, opcode);
+	} else
+		BT_ERR("%s command tx timeout", hdev->name);
+
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
@@ -1673,7 +1680,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	init_waitqueue_head(&hdev->req_wait_q);
 
-	setup_timer(&hdev->cmd_timer, hci_cmd_timer, (unsigned long) hdev);
+	setup_timer(&hdev->cmd_timer, hci_cmd_timeout, (unsigned long) hdev);
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
-- 
1.7.9.5

