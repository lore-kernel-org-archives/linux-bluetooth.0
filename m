Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Export signature resolving key in debugfs
Date: Sat,  8 Mar 2014 23:32:16 -0800
Message-Id: <1394350336-10602-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Include the current connection signature resolving key (CSRK) as part
of the identity debugfs information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8bbfdea9cbec..1b2935c61b49 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -589,8 +589,8 @@ static int identity_show(struct seq_file *f, void *p)
 
 	hci_copy_identity_address(hdev, &addr, &addr_type);
 
-	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", &addr, addr_type,
-		   16, hdev->irk, &hdev->rpa);
+	seq_printf(f, "%pMR (type %u) %*phN %pMR %*phN\n", &addr, addr_type,
+		   16, hdev->irk, &hdev->rpa, 16, hdev->csrk);
 
 	hci_dev_unlock(hdev);
 
-- 
1.8.5.3

