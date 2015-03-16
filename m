Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: The P-256 randomizer is 16 octets long and not 19 octets
Date: Mon, 16 Mar 2015 12:24:33 -0700
Message-Id: <1426533873-25880-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This seems to be a simple typo in the debugfs entry for the remote
out-of-band data entries.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index bc801e9db834..0818fabf346a 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -166,7 +166,7 @@ static int remote_oob_show(struct seq_file *f, void *ptr)
 		seq_printf(f, "%pMR (type %u) %u %*phN %*phN %*phN %*phN\n",
 			   &data->bdaddr, data->bdaddr_type, data->present,
 			   16, data->hash192, 16, data->rand192,
-			   16, data->hash256, 19, data->rand256);
+			   16, data->hash256, 16, data->rand256);
 	}
 	hci_dev_unlock(hdev);
 
-- 
2.1.0

