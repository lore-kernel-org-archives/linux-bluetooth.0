Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add proper cleanup path for bt_6lowpan_init()
Date: Wed, 18 Mar 2015 11:10:40 +0200
Message-Id: <1426669840-2933-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426669840-2933-1-git-send-email-johan.hedberg@gmail.com>
References: <1426669840-2933-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In case part of the bt_6lowpan_init() fails we should undo any
operations that succeeded before the failure. This patch add the
necessary cleanup path to the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 524218aeea6f..6e3c208820b8 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1457,9 +1457,20 @@ static int __init bt_6lowpan_init(void)
 
 	err = register_netdevice_notifier(&bt_6lowpan_dev_notifier);
 	if (err)
-		return err;
+		goto failed;
 
-	return hci_mgmt_chan_register(&bt_6lowpan_chan);
+	err = hci_mgmt_chan_register(&bt_6lowpan_chan);
+	if (err) {
+		unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	debugfs_remove(lowpan_enable_debugfs);
+	debugfs_remove(lowpan_control_debugfs);
+	return err;
 }
 
 static void __exit bt_6lowpan_exit(void)
-- 
2.1.0

