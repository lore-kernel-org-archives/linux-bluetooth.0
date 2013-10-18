Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Include address type in blacklist debugfs data
Date: Thu, 17 Oct 2013 17:24:20 -0700
Message-Id: <1382055860-12572-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address type is important for the blacklist entries. So include
it at well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 940da80..a4047d6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -65,7 +65,7 @@ static int blacklist_show(struct seq_file *f, void *p)
 
 	hci_dev_lock(hdev);
 	list_for_each_entry(b, &hdev->blacklist, list)
-		seq_printf(f, "%pMR\n", &b->bdaddr);
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	hci_dev_unlock(hdev);
 
 	return 0;
-- 
1.8.3.1

