Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: debug: Add printing num of cmds queued
Date: Tue, 10 Jul 2012 15:27:47 +0300
Message-Id: <1341923271-14222-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ad508e..28bab9d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2823,7 +2823,8 @@ static void hci_cmd_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));
+	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
+	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
 
 	/* Send queued commands */
 	if (atomic_read(&hdev->cmd_cnt)) {
-- 
1.7.9.5

