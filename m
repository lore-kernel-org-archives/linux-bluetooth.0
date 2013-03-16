Return-Path: <cyrus@holtmann.org>
From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] net: bluetooth: Use PTR_RET function
Date: Sat, 16 Mar 2013 16:10:03 +0200
Message-Id: <1363443003-13839-1-git-send-email-gheorghiuandru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Used PTR_RET function instead of IS_ERR and PTR_ERR.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 net/bluetooth/hci_sysfs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 23b4e24..ff38561 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -590,10 +590,8 @@ int __init bt_sysfs_init(void)
 	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
 
 	bt_class = class_create(THIS_MODULE, "bluetooth");
-	if (IS_ERR(bt_class))
-		return PTR_ERR(bt_class);
 
-	return 0;
+	return PTR_RET(bt_class);
 }
 
 void bt_sysfs_cleanup(void)
-- 
1.7.9.5
