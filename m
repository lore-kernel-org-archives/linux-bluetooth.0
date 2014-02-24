Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Export current local RPA with identity information
Date: Sun, 23 Feb 2014 20:39:23 -0800
Message-Id: <1393216763-14836-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The identity information in debugfs currently do not include the
current in use local RPA. Since the RPA is now stored in the
controller information, include it in the debugfs as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6928989ec906..14f7a3ecfef1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -596,7 +596,8 @@ static int identity_show(struct seq_file *f, void *p)
 		addr_type = ADDR_LE_DEV_PUBLIC;
 	}
 
-	seq_printf(f, "%pMR (type %u) %*phN\n", addr, addr_type, 16, hdev->irk);
+	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", addr, addr_type,
+		   16, hdev->irk, &hdev->rpa);
 
 	hci_dev_unlock(hdev);
 
-- 
1.8.5.3

