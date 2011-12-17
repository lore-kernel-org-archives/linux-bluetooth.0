Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 21/22] Bluetooth: Use new alloc_workqueue()
Date: Sat, 17 Dec 2011 19:29:41 -0200
Message-Id: <1324157382-1815-22-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-21-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-21-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Update hdev workqueue API usage to use the new interface, this new
interface also allow us to mark this workqueue as WQ_HIGHPRI, so now rx
and tx work gets higher priority when running.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e4ff7b6..21816dd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1498,7 +1498,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	write_unlock_bh(&hci_dev_list_lock);
 
-	hdev->workqueue = create_singlethread_workqueue(hdev->name);
+	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI, 1);
 	if (!hdev->workqueue) {
 		error = -ENOMEM;
 		goto err;
-- 
1.7.6.4

